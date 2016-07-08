require 'rails_helper'

describe ProfilePolicy do
  subject { described_class }

  context "for a visitor" do
    let(:member) { nil }
    let(:profile) { FactoryGirl.create(:profile) }

    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it "does not grant access for non logged in visitors" do
        expect(subject).not_to permit(member, profile )
      end
    end
  end

  context "for member viewing other members’ profiles or creating a profile" do
    let(:profile) { FactoryGirl.create(:profile) }
    let(:member) { FactoryGirl.create(:member) }

    permissions :index?, :show?, :new?, :create? do
      it "grants access to member" do
        expect(subject).to permit(member, profile)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it "denies access to member for whom the profile does not belong" do
        expect(subject).not_to permit(member, profile )
      end
    end
  end

  context "for member editing own profile" do
    let(:member) { FactoryGirl.create(:member) }

    permissions :edit?, :update?, :destroy? do
      it "grants access if profile belongs to member" do
        expect(subject).to permit(member, Profile.create!(member_id: member.id, first_name: "Joe", last_name: "Doe", postal_code: 9000, cc_number: 12345))
      end
    end
  end
end
