class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:destroy]

  def index
    @users = policy_scope(User)
    render_response(@users)
  end

  def destroy
    authorize @user
    
    if @user.destroy
      head :no_content
    end
  end

  def profile
    render_response(current_user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
