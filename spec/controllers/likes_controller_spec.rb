require "rails_helper"

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:status) { create(:status) }

  describe "POST #likes" do
    context "when user is logged in" do
      before do
        sign_in user
        post :create, status_id: status.id
      end

      it "likes the specified status" do
        expect(user.likes? status).to be_truthy
      end
    end

    context "when user is not logged in" do
      before do
        post :create, status_id: status.id
      end

      it "redirects to sign-in page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #like" do
    context "when user is logged in" do
      before do
        sign_in user
        user.like! status
        delete :destroy, status_id: status.id
      end

      it "unlikes the specified status" do
        expect(user.likes? status).to be_falsy
      end
    end

    context "when user is not logged in" do
      before do
        delete :destroy, status_id: status.id
      end

      it "redirects to sign-in page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
