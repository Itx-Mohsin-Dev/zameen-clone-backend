class PropertyCreationService
  def initialize(property, images)
    @property = property
    @images = images
  end

  def call
    property_creation
    @property
  end

  private

  def property_creation
    @property.status = :pending
    if @property.save
      upload_images
    end
  end

  def upload_images
    return unless @images.present?

    Array(@images).each do |image|
      result = Cloudinary::Uploader.upload(image.path)

      @property.property_images.create!(
        image_url: result["secure_url"]
      )
    end
  end
end
