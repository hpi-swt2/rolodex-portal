require 'rails_helper'

RSpec.describe 'Navbar', driver: :selenium_headless, type: :feature, js: true do
  let(:user) { FactoryBot.create :user }

  describe 'profile dropdown' do
    before do
      sign_in user
      visit root_path
    end

    it 'is not expanded by default' do
      profile_dropdown = page.find('#navbarProfileDropdown + div', visible: :all)
      expect(profile_dropdown['class']).not_to include('show')
    end

    it 'expands after being clicked on' do
      toggle_profile_dropdown
      profile_dropdown = page.find('#navbarProfileDropdown + div')
      expect(profile_dropdown['class']).to include('show')
    end

    it 'contains a link to the users profile page' do
      toggle_profile_dropdown
      within '#navbarProfileDropdown + div' do
        expect(page).to have_link(href: user_path(user))
      end
    end

    it 'contains a link to contacts page' do
      toggle_profile_dropdown
      within '#navbarProfileDropdown + div' do
        expect(page).to have_link(href: user_contacts_path(user))
      end
    end

    it 'contains a link to the account settings page' do
      toggle_profile_dropdown
      within '#navbarProfileDropdown + div' do
        expect(page).to have_link(href: edit_user_registration_path(user))
      end
    end

    it 'contains a link to the users edit profile page' do
      toggle_profile_dropdown
      within '#navbarProfileDropdown + div' do
        expect(page).to have_link(href: edit_user_path(user))
      end
    end

    def toggle_profile_dropdown
      page.execute_script('document.getElementById("navbarProfileDropdown").click()')
    end
  end

  describe 'public page' do
    before do
      visit root_path
    end

    it 'does not contain a link to the notes page' do
      expect(page).not_to have_link(href: notes_path)
    end

    it 'does not contain a link to the users page' do
      expect(page).not_to have_link(href: users_path)
    end

    it 'does not contain a link to the contacts page' do
      expect(page).not_to have_link('My contacts')
    end
  end
end
