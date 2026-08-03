class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard

    render json: {
      total_users: User.count,
      total_properties: Property.count,
      total_inquiries: Inquiry.count,
      pending_properties: Property.pending.count
    }
  end
end
