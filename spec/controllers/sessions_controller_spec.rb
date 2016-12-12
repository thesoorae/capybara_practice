require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "renders the new sessions page" do
      get :new, user:{}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of username and password" do
        post :create, user: {username: "Bleeb"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
    context "with valid params" do
      it "redirects to the goals index page" do
        user1 = create(:user)
        post :create, user: {username: user1.username, password: user1.password}
        expect(response).to redirect_to(goals_url)
      end
    end
  end

  describe "DELETE #destroy" do
    it "signs out the user" do
      user1 = create(:user)
      post :create, user: {username: user1.username, password: user1.password}
      old_session_token = user1.session_token
      delete :destroy
      user2 = User.find(user1.id)
      expect(user2.session_token).to_not eq(old_session_token)
    end


    it "redirects to new session url" do
      user1 = create(:user)
      post :create, user: {username: user1.username, password: user1.password}
      delete :destroy
      expect(response).to redirect_to(new_session_url)
    end
  end
end
