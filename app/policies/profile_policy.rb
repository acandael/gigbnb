class ProfilePolicy < ApplicationPolicy

 def index?
   @member
 end

 def show?
   @member
 end

 def new?
   @member
 end

 def create?
   @member
 end

 def update?
   @member && @member.profile == @record
 end

 def edit?
   @member && @member.profile == @record
 end

 def destroy?
   @member && @member.profile == @record
 end
end
