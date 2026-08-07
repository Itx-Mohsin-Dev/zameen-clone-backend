class Users::SessionsController < Devise::SessionsController

  def respond_with(resource, _opts = {})
    render json: {
      message: "Login Successfully",
      token: request.env["warden-jwt_auth.token"],
      user: UserSerializer.new(resource)
    }, status: :ok
  end

  def respond_to_on_destroy(_resource = nil)
    if current_user
      render json: { message: "Logout Successfully" }, status: :ok
    else
      render json: { error: "No authenticated user" }, status: :unauthorized
    end
  end
end
