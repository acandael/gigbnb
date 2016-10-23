module ApplicationHelper
  def has_profile?
    current_member.profile != nil && !current_member.profile.new_record?
  end

  def is_host?
    member_signed_in? && current_member.profile && current_member.profile.is_host
  end

  def has_locations?
    current_member.locations.any?
  end

  def authorized_stripe?(member)
    member.stripe_user_id != nil
  end
end
