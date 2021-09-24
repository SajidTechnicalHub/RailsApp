class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def index?
    true
  end
 
  def create?
    user.present?
  end
 
  def update?
    return true if (user.present? && user == product.user) || (user.present? && user.status == 'moderator')
  end
 
  def destroy?
    return true if (user.present? && user == product.user) || (user.present? && user.status == 'moderator')
  end
 
  private
 
    def product
      record
    end
end
