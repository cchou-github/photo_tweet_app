require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "Photos", type: :request do
  describe "GET /photo/new" do
    subject{ get new_photo_path }

    context "when user is not logged in" do
      before { subject }
      include_examples "has 302 status and redirect to login_path"
    end

    context "when user was logged in" do
      let(:user) { create :user }

      before do
        login user
        subject
      end

      it "has 200 status and render_template to new" do
        expect(response).to have_http_status 200
        expect(response).to render_template :new
      end
    end
  end

  describe "GET /photos" do
    let(:user) { create :user }
    let(:other_user) { create :user }
    let!(:current_user_photos) { create_list :photo, 2, user: user }
    let!(:other_users_photo) { create :photo, user: other_user }
    before do
      current_user_photos
    end

    subject { get photos_path }

    context "when user is not logged in" do
      before { subject }
      include_examples "has 302 status and redirect to login_path"
    end

    context "when user was logged in" do
      context "when tweet app is not linked" do
        before do
          login user
          subject
        end

        it "has 200 status and render_template to index" do
          expect(response).to have_http_status 200
          expect(response).to render_template :index
        end

        it "render the page with expecting information" do
          expect(response.body).to include I18n.t("photos.index.link_with_tweet") #MyTweetAppと連携
          expect(response.body).not_to include I18n.t("photos.index.tweet") #ツイートする
          expect(response.body).to include current_user_photos.first.title
          expect(response.body).to include current_user_photos.second.title
          expect(response.body).not_to include other_users_photo.title
        end
      end

      context "when tweet app is linked" do
        let!(:rspec_session) {{ tweet_access_token: "test_token" }} # sessionを指定する https://qiita.com/tmak_tsukamoto/items/c42101aeec119a2816ac

        before do
          login user
          subject
        end

        it "has 200 status and render_template to index" do
          expect(response).to have_http_status 200
          expect(response).to render_template :index
        end

        it "render the page with expecting information" do
          expect(response.body).to include I18n.t("photos.index.tweet_linked") #MyTweetAppと連携中
          expect(response.body).to include I18n.t("photos.index.tweet") #ツイートする
          expect(response.body).to include current_user_photos.first.title
          expect(response.body).to include current_user_photos.second.title
          expect(response.body).not_to include other_users_photo.title
        end
      end
    end
  end

  describe 'POST /photos yao' do
    subject { post photos_path, params: params }

    let(:title) { "photo_title" }
    let(:image_file) { Rack::Test::UploadedFile.new('spec/fixtures/test_image.jpg', 'image/jpeg') }

    let(:params) do
      { photo: { title: title, image_file: image_file }}
    end
    
    
    context "when user is not logged in" do
      before { subject }

      include_examples "has 302 status and redirect to login_path"
    end

    context "when user is logged in"do
      let(:user) { create :user }

      before { login user }

      context "when the params are acceptable" do
        it "creates a photo record" do
          expect{ subject }.to change{ Photo.all.count }.from(0).to(1)
        end

        it "has 302 and redirects to photos_path" do
          subject
          expect(response).to have_http_status 302
          expect(response).to redirect_to photos_path
        end
      end

      context "when params is empty" do
        let(:title) { "" }
        let(:image_file) { nil }

        it "creates a photo record" do
          expect{ subject }.not_to change{ Photo.all.count }.from(0)
        end

        it "renders new_photo_path" do
          subject
          expect(response).to have_http_status 200
          expect(response).to render_template :new
        end

        it "renders error messages" do
          subject
          expect(response.body).to include "タイトルを入力してください"
          expect(response.body).to include "画像ファイルを入力してください"
        end
      end

      context "when title is too long" do
        let(:title) { "あ" * 31 }

        it "creates a photo record" do
          expect{ subject }.not_to change{ Photo.all.count }.from(0)
        end

        it "renders new_photo_path" do
          subject
          expect(response).to have_http_status 200
          expect(response).to render_template :new
        end

        it "renders error messages" do
          subject
          expect(response.body).to include "タイトルを30文字以内にしてください"
        end
      end
    end
  end
end
