require 'rails_helper'

RSpec.describe "home/dashboard", type: :view do
  context "when user is signed in" do
    before(:each) do
      @users = assign(:users, FactoryBot.create_list(:user, 3))
      sign_in @users.first

      render
    end

    describe "users list" do
      it "shows the heading" do
        expect(rendered).to have_text(I18n.t('dashboard.user_list'))
      end
    end

    describe "global chat" do
      it "shows the heading" do
        expect(rendered).to have_text(I18n.t('dashboard.global_chat'))
      end
    end

    describe "last activities" do
      it "shows the heading" do
        expect(rendered).to have_text(I18n.t('dashboard.last_activities'))
      end
    end

    describe 'current proposals' do
      it "shows the heading" do
        expect(rendered).to have_text(I18n.t('dashboard.current_proposals'))
      end
    end
  end
end