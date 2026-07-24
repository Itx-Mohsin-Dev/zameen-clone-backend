class InquiriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inquiry, only: [ :show ]

  def index
    # @inquiries = Inquiry.all
    @inquiries = policy_scope(Inquiry)

    render_response(@inquiries)
  end

  def create
    # @inquiry = Inquiry.new(inquiry_params)
    @inquiry = current_user.inquiries.build(inquiry_params)

    authorize @inquiry

    if @inquiry.save
      render json: @inquiry, status: :created
    else
      render_validation_error(@inquiry)
    end
  end

  def show
    authorize @inquiry

    render_response(@inquiry)
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:property_id, :name, :email, :message)
  end

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end
end
