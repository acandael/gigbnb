module ApplicationHelper
  def has_profile?
    current_member.profile != nil && !current_member.profile.new_record?
  end

  def is_host?(profile)
    profile.is_host != nil && profile.is_host
  end
end
