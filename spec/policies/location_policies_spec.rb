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
        profile.is_host = true
        profile.member_id = member.id
        profile.save
        expect(subject).to permit(member, location)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it "denies access to member for whom the profile does not belong" do
        expect(subject).not_to permit(member, profile)
      end
    end
  end

  context "for member editing own location" do
    let(:member) { FactoryGirl.create(:member) }
    let(:profile) { FactoryGirl.create(:profile, member_id: member.id) }
    let(:location) { FactoryGirl.create(:location) }

    permissions :edit?, :update?, :destroy? do
      it "grants access if location belongs to member" do
        profile.is_host = true
        profile.member_id = member.id
        profile.save
        expect(subject).to permit(member, Location.create!(member_id: member.id, title: "lovely duplex", beds: 2, guests: 3, price: 34))
      end
    end
  end
end
