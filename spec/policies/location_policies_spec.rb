require 'rails_helper'

describe LocationPolicy do
  subject { described_class }

  context "for a visitor" do
    let(:member) { nil }
    let(:location) { FactoryGirl.create(:location) }

    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it "does not grant access for non logged in visitors" do
        expect(subject).not_to permit(member, location)
      end
    end
  end

  context "for member viewing other members' locations or creating a location" do
    let(:member) { FactoryGirl.create(:member) }
    let(:profile) { FactoryGirl.create(:profile, member_id: member.id) }
    let(:location) { FactoryGirl.create(:location) }

    permissions :index?, :show?, :new?, :create? do
      it "grants access to member" do
        profile.member_id = member.id
        profile.save
        expect(subject).to permit(member, location)
      end
    end
  end
end
