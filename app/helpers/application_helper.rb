module ApplicationHelper
  def has_profile?
    current_member.profile != nil && !current_member.profile.new_record?
  end

  def is_host?(profile)
    profile.is_host != nil && profile.is_host
  end

  def has_locations?
    current_member.locations.any?
  end

  def authorized_stripe?(member)
    member.stripe_user_id != nil
  end
end
