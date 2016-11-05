require 'rails_helper'

RSpec.describe ReservationReminderJob, type: :job do

  describe "ReservationReminderJob" do

    let(:host) { FactoryGirl.create(:member, email: "info@anthonycandaele.com") }
    let(:location) { FactoryGirl.create(:location_with_available_dates, member_id: host.id) }
    let(:member) { FactoryGirl.create(:member) }
    let!(:host_profile) { FactoryGirl.create(:profile, member_id: host.id) }

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
      ReservationReminderJob.perform_now(@reservation)
      expect(ActionMailer::Base.deliveries.count).to eq(2)
    end

    it "does not sent reminder emails for cancelled reservation" do
      @reservation.update(id_for_refund: "re_123123123")
      ReservationReminderJob.perform_now(@reservation)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end

    it "sets the job at the correct time" do
      expect {
        ReservationReminderJob.set(wait_until:
        Date.tomorrow.noon).perform_later(@reservation)
      }.to have_enqueued_job.at(Date.tomorrow.noon)
    end
 end
end
