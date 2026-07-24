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

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.seller?
        scope.where(user: user)
      else
        scope.where(status: "approved")
      end
    end
  end
end
