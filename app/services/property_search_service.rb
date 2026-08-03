class PropertySearchService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    return empty_result unless convert_enum_params
    paginate(search_properties)
  end

  private

  # converting "rent" into 1 to apply search for enums
  def convert_enum_params
    if @params.dig(:q, :purpose_eq).present?
      purpose = Property.purposes[@params[:q][:purpose_eq]]
      return false if purpose.nil?

      @params[:q][:purpose_eq] = purpose
    end

    if @params.dig(:q, :property_type_eq).present?
      property_type = Property.property_types[@params[:q][:property_type_eq]]
      return false if property_type.nil?

      @params[:q][:property_type_eq] = property_type
    end

    true
  end

  def search_properties
    q = Pundit.policy_scope!(@user, Property).order(created_at: :desc).ransack(@params[:q])
    q.result
  end

  def paginate(properties)
    # Adding Pagination
    total_records = properties.count
    per_page = 10
    page = @params[:page].to_i
    page = 1 if page <= 0
    offset = (page - 1) * per_page
    paginated_properties = properties.limit(per_page).offset(offset)
    total_pages = (total_records.to_f / per_page).ceil
    {
      properties: paginated_properties,
      meta: {
        current_page: page,
        per_page: per_page,
        total_records: total_records,
        total_pages: total_pages
      }
    }
  end

  def empty_result
    {
      properties: [],
      meta: {
        current_page: 1,
        per_page: 10,
        total_records: 0,
        total_pages: 0
      }
    }
  end
end
