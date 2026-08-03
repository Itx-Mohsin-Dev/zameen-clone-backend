class PropertyPolicy < ApplicationPolicy
  def create?
    user.seller? || user.admin?
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end

  def show?
    record.approved? || record.user == user || user&.admin?
  end

  def approve?
    user.admin?
  end

  def reject?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.where(status: "approved") unless user
      if user.admin?
        scope.all
      elsif user.seller?
        scope.where(status: "approved")
      else
        scope.where(status: "approved")
      end
    end
  end
end
