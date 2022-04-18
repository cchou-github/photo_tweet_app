require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "TweetApi request", type: :request do
  describe "GET photo/:photo_id/tweet" do
    subject { get photo_tweet_path(photo.id) }

    let(:user)  { create :user }
    let(:photo) { create :photo, user: user }

    context "when user is not logged in" do
      before { subject }
      include_examples "has 302 status and redirect to login_path"
    end

    context "when user is logged in" do
      before { login user }

      context "when there is no token in session" do
        it "has 302 status and redirect to photos_path with flash alert" do
          subject
  
          expect(response).to have_http_status 302
          expect(response).to redirect_to photos_path
          expect(flash[:alert]).to eq I18n.t("tweet_api.tweet.errors.tweet_failed") #ツイート失敗しました
        end
      end

      context "when there is token in session" do
        let(:access_token) { "test_token" }
        let!(:rspec_session) {{ tweet_access_token: access_token }}

        context "when the tweet is success" do
          before do
            allow_any_instance_of(Api::Tweet::Client).to receive(:post_tweet!).and_return(nil)
          end

          it "has 302 status and redirect to photos_path with flash notice" do
            subject
    
            expect(response).to have_http_status 302
            expect(response).to redirect_to photos_path
            expect(flash[:notice]).to eq I18n.t("tweet_api.tweet.tweet_success") #ツイート成功しました
          end
        end

        context "when error was raised" do
          before do
            allow_any_instance_of(Api::Tweet::Client).to receive(:post_tweet!).and_raise(Api::Tweet::Errors::TweetApiError)
          end
  
          it "has 302 status and redirect to photos_path with flash alert" do
            subject
    
            expect(response).to have_http_status 302
            expect(response).to redirect_to photos_path
            expect(flash[:alert]).to eq I18n.t("tweet_api.tweet.errors.tweet_failed") #ツイート失敗しました
          end
        end
      end
    end
  end
end