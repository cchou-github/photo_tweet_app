require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "Oauth2Tweets request", type: :request do
  describe "GET /oauth/callback" do
    
    subject { get oauth_callback_path, params: { code: code }}

    let(:user)  { create :user }
    let(:photo) { create :photo, user: :user }
    let(:code) { "test_code" }

    context "when user is not logged in" do
      before { subject }
      include_examples "has 302 status and redirect to login_path"
    end

    context "when user is logged in" do
      before { login user }

      context "when there is no code" do
        let(:code) { nil }

        it "has 302 status and redirect to photos_path with flash alert" do
          subject
  
          expect(response).to have_http_status 302
          expect(response).to redirect_to photos_path
          expect(flash[:alert]).to eq I18n.t("oauth2_tweets.callback.errors.link_failed") #連携に失敗しました
        end
      end

      context "when token is successfully retrieved" do
        let(:access_token) { "test_token" }

        before do
          allow_any_instance_of(Oauth2::Tweet::Client).to receive(:request_access_token!).and_return(access_token)
        end

        it "has 302 status and redirect to photos_path without flash alert" do
          subject
  
          expect(response).to have_http_status 302
          expect(response).to redirect_to photos_path
          expect(flash[:alert]).not_to eq I18n.t("oauth2_tweets.callback.errors.link_failed") #連携に失敗しました
        end
      end

      context "when error was raised" do
        let(:access_token) { "test_token" }

        before do
          allow_any_instance_of(Oauth2::Tweet::Client).to receive(:request_access_token!).and_raise(Oauth2::Tweet::Client::RequestAccesstokenError)
        end

        it "has 302 status and redirect to photos_path with flash alert" do
          subject
  
          expect(response).to have_http_status 302
          expect(response).to redirect_to photos_path
          expect(flash[:alert]).to eq I18n.t("oauth2_tweets.callback.errors.link_failed") #連携に失敗しました
        end
      end
    end
  end
end