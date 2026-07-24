class InquiryPolicy < ApplicationPolicy
  def create?
    user.buyer?
  end

  def show?
    record.user == user || user.admin? || record.property.user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.seller?
        scope.joins(:property).where(properties: { user_id: user.id })
      elsif user.buyer?
        scope.where(user: user)
      end
    end
  end
end
