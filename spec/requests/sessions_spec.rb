require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    subject{ get login_path }

    context "when user is not logged in" do
      it "has 200 status and render_template new" do
        subject

        expect(response).to have_http_status 200
        expect(response).to render_template :new
      end
    end

    context "when user was logged in" do
      let(:user) { create :user }

      it "has 302 status and redirect to photos_path" do
        login user
        subject

        expect(response).to have_http_status 302
        expect(response).to redirect_to photos_path
      end
    end
  end

  describe "POST /login" do
    let!(:user)  { create :user }

    context "when user is not logged in" do
      subject{ post login_path, params: { account: login_account, password: login_password } }

      context "when user_account and user_password are acceptable" do
        let(:login_account)  { user.account }
        let(:login_password) { user.password }
        
        it "has 302 status and redirect to photos_path" do
          subject

          expect(response).to have_http_status 302
          expect(response).to redirect_to photos_path
        end
      end

      context "when user_account and user_password are acceptable" do
        let(:login_account)  { "1234" }
        let(:login_password) { "4567" }
        
        it "renders :new with flash[:alert] messages" do
          subject

          expect(response).to render_template :new
        end

        it "shows error messages" do
          subject

          expect(response.body).to include "ユーザーIDとパスワードが一致するユーザーが存在しない"
        end
      end

      context "when user_account and user_password are blank" do
        let(:login_account) {""}
        let(:login_password) {""}
        
        it "renders :new with flash[:alert] messages" do
          subject

          expect(response).to render_template :new
        end

        it "shows error messages" do
          subject

          expect(response.body).to include "ユーザーIDを入力してください"
          expect(response.body).to include "パスワードを入力してください"
        end
      end
    end

    context "when user was logged in" do
      it "has 302 status and redirect to photos_path" do
        login user
        subject

        expect(response).to have_http_status 302
        expect(response).to redirect_to photos_path
      end
    end
  end

  describe "GET /logout" do
    subject { get logout_path }

    context "when user is not logged in" do
      it "has 302 status and redirect to photos_path" do
        subject

        expect(response).to have_http_status 302
        expect(response).to redirect_to login_path
      end
    end

    context "when user was logged in" do
      let!(:user)  { create :user }

      it "has 302 status and redirect to photos_path" do
        login user
        subject
        
        expect(response).to have_http_status 302
        expect(response).to redirect_to login_path
      end
    end
  end    
end
