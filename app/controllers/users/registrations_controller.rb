class Users::RegistrationsController < Devise::RegistrationsController
  before_action :allow_extra_fields, only: [ :create ]
  # def create
  # super #runs the parent's method (Devise::RegistrationsController#create)
  # we can't write custom render logic after super, because super already renders a response
  # and we will face DoubleRenderError Exception, so we are using respond_with hook to render once
  # end

  def sign_up(resource_name, resource)
    # "Don't automatically sign the user in after registration."
    # This prevents Devise from trying to write to the session.
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: "User Created Successfully", user: UserSerializer.new(resource) }, status: :created
    else
      render_validation_error(resource)
    end
  end

  def allow_extra_fields
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [ :name, :phone, :role ]
    )
  end
end
