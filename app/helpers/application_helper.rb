module ApplicationHelper
  def has_profile?
    current_member.profile != nil && !current_member.profile.new_record?
  end
end
