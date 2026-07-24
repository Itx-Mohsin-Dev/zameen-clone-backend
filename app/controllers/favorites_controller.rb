class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorite, only: [ :destroy ]

  def index
    # @favorites = Favorite.all
    @favorites = policy_scope(Favorite)

    render_response(@favorites.map(&:property))
  end

  def create
    # @favorite = Favorite.new(favorite_params)
    @favorite = current_user.favorites.build(favorite_params)

    authorize @favorite

    if @favorite.save
      render json: @favorite, status: :created
    else
      render_validation_error(@favorite)
    end
  end

  def destroy
    authorize @favorite

    if @favorite.destroy()
      head :no_content
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:property_id)
  end

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end
end
