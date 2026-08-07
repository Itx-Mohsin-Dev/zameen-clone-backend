class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_property, only: [ :show, :update, :destroy, :approve, :reject ]

  def index
    result = PropertySearchService.new(params, current_user).call
    render json: {
      properties: ActiveModelSerializers::SerializableResource.new(
        result[:properties],
        each_serializer: PropertySerializer
      ),
      meta: result[:meta]
    }
  end

  def my_listings
    properties = current_user.properties.order(created_at: :desc)

    render json: properties,
           each_serializer: PropertySerializer
  end

  def create
    if params[:images].blank?
      render json: { error: "At least one property image is required" }, status: :unprocessable_entity
      return
    end

    @property = current_user.properties.build(property_params)

    authorize @property

    @property = PropertyCreationService.new(@property, params[:images]).call

    if @property.persisted?
      render json: @property, status: :created
    else
      render_validation_error(@property)
    end
  end

  def show
    authorize @property

    render_response(@property)
  end

  def update
    authorize @property

    if @property.update(property_params)
      if params[:images].present?
        @property.property_images.destroy_all

        params[:images].each do |image|
          result = Cloudinary::Uploader.upload(image.path)
          
          @property.property_images.create!(
            image_url: result["secure_url"]
          )
        end
      end

      render_response(@property)
    else
      render_validation_error(@property)
    end
  end

  def destroy
    authorize @property

    if @property.destroy
      head :no_content
    end
  end

  def bulk_destroy
    properties = current_user.properties.where(id: params[:ids])
    properties.destroy_all
    head :no_content
  end

  def pending
    properties = policy_scope(Property).where(status: :pending)
    render_response(properties)
  end

  def approve
    authorize @property

    if @property.update(status: :approved)
      render_response(@property)
    else
      render_validation_error(@property)
    end
  end

  def reject
    authorize @property

    if @property.update(status: :rejected)
      render_response(@property)
    else
      render_validation_error(@property)
    end
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :location, :city, :price, :area, :property_type, :bathrooms, :bedrooms, :purpose, :marla_type, :latitude, :longitude)
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
