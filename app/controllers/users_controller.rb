class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    render_response(current_user)
  end
end
