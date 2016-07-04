class LocationPolicy < ApplicationPolicy
  def index?
    @member
  end

  def show?
    @member
  end

  def new?
    @member && @member.profile.is_host
  end

  def create?
    @member && @member.profile.is_host
  end

  def update?
    @member && @member.profile.is_host
  end

  def edit?
    @member && @member.profile.is_host
  end

  def destroy?
    @member && @member.profile.is_host
  end
end
