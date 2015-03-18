require "rails_helper"

RSpec.describe User, type: :model do
  describe ".active" do
    let(:period) { 10.days.ago..Time.now }

    let(:active_users) do
      travel_to(5.days.ago) { create_list(:user_with_statuses, 5) }
    end

    let(:inactive_users) do
      travel_to(20.days.ago) { create_list(:user_with_statuses, 5) }
    end

    it "returns users with status updates during a given period" do
      expect(User.active(period)).to match_array(active_users)
    end
  end

  describe ".inactive" do
    let(:period) { 10.days.ago..Time.now }

    let(:active_users) do
      travel_to(5.days.ago) { create_list(:user_with_statuses, 5) }
    end

    let(:inactive_users) do
      travel_to(20.days.ago) { create_list(:user_with_statuses, 5) }
    end

    it "returns users without status updates during a given period" do
      expect(User.inactive(period)).to match_array(inactive_users)
    end
  end

  describe "#like!" do
    let(:status) { create(:status) }

    context "when given a status that is not liked" do
      let(:user) { create(:user) }

      it "adds that status to favorites" do
        user.like! status
        expect(user.favorites).to include(status)
      end
    end

    context "when given an already liked status" do
      let(:user) { create(:user_with_favorite, status: status) }

      it "does not change favorites" do
        expect { user.like! status }.not_to change(user, :favorites)
      end
    end
  end

  describe "#unlike!" do
    let(:status) { create(:status) }

    context "when given a status that is not liked" do
      let(:user) { create(:user) }

      it "does not change favorites" do
        expect { user.unlike! status }.not_to change(user, :favorites)
      end
    end

    context "when given an already liked status" do
      let(:user) { create(:user_with_favorite, status: status) }

      it "removes that status from favorites" do
        user.unlike! status
        expect(user.favorites).not_to include(status)
      end
    end
  end

  describe "#likes?" do
    let(:status) { create(:status) }

    context "when given a status that is not liked" do
      let(:user) { create(:user) }

      it "returns false" do
        expect(user.likes? status).to be_falsy
      end
    end

    context "when given an already liked status" do
      let(:user) { create(:user_with_favorite, status: status) }

      it "returns true" do
        expect(user.likes? status).to be_truthy
      end
    end
  end
end
