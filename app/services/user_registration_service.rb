class UserRegistrationService
  def initialize(user, profile_image)
    @user = user
    @profile_image = profile_image
  end

  def call
    return @user unless @profile_image.present?

    result = Cloudinary::Uploader.upload(@profile_image.path)

    @user.update(profile_image: result["secure_url"])

    @user
  end
end