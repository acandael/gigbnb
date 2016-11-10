require 'rails_helper'

RSpec.describe ReservationCancellationJob, type: :job do
    let(:host) { FactoryGirl.create(:member, email: "info@anthonycandaele.com") }
    let(:location) { FactoryGirl.create(:location_with_available_dates, member_id: host.id) }
    let(:member) { FactoryGirl.create(:member) }
    let!(:host_profile) { FactoryGirl.create(:profile, member_id: host.id) }
    let!(:guest_profile) { FactoryGirl.create(:profile, member_id: member.id) }

    before do
      ActionMailer::Base.deliveries.clear
      @reservation = Reservation.create(
      location_id: location.id,
      member_id: member.id,
      start_date: Date.tomorrow,
      end_date: Date.current + 2.days)
    end 

    after do
      ActionMailer::Base.deliveries.clear
    end

    it "sends reminder emails to guest and host" do
      ReservationCancellationJob.perform_now(@reservation)
      expect(ActionMailer::Base.deliveries.count).to eq(2)
    end
end
