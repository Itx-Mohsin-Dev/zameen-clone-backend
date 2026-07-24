class FavoritePolicy < ApplicationPolicy
  def create?
    user.buyer?
  end

  def destroy?
    record.user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.buyer?
        scope.where(user: user)
      else
        scope.none
      end
    end
  end
end
