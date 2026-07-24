class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_property, only: [ :show, :update, :destroy ]

  def index
    # @properties = Property.all
    @properties = policy_scope(Property)
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
