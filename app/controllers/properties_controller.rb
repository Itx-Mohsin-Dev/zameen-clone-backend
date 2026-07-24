class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_property, only: [ :show, :update, :destroy ]

  def index
    # converting "rent" into 1 to apply search for enums
    if params.dig(:q, :purpose_eq).present?
      purpose = Property.purposes[params[:q][:purpose_eq]]
      return render_response([]) if purpose.nil?

      params[:q][:purpose_eq] = purpose
    end


    if params.dig(:q, :property_type_eq).present?
      property_type = Property.property_types[params[:q][:property_type_eq]]
      return render_response([]) if property_type.nil?

      params[:q][:property_type_eq] = property_type
    end

    # @properties = Property.all
    @q = policy_scope(Property).ransack(params[:q])
    @properties = @q.result

    render_response(@properties)
  end

  def create
    # @property = Property.new(property_params)
    @property = current_user.properties.build(property_params)

    authorize @property

    if @property.save
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
      render_response(@property)
    else
      render_validation_error(@property)
    end
  end

  def destroy
    authorize @property

    if @property.destroy()
      head :no_content
    end
  end



  private

  def property_params
    params.require(:property).permit(:title, :description, :location, :city, :price, :area, :property_type, :bathrooms, :bedrooms, :purpose, :status)
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
