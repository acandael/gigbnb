module ApplicationHelper
  def has_profile?
    current_member.profile != nil && current_member.profile.id != nil
  end
end
