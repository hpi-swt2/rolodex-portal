require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build :user }

  it 'is creatable using a factory' do
    expect(user).to be_valid
  end

  it "is invalid with a status other than 'available' or 'working'" do
    user.current_status = 'unavailable'
    expect(user).not_to be_valid
  end

  it 'is not valid with an email without @' do
    user.email = 'testATexample.de'
    expect(user).not_to be_valid
  end

  it 'is not valid without an email' do
    user.email = ''
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user.password = ''
    user.password_confirmation = ''
    expect(user).not_to be_valid
  end

  it 'is not valid without a username' do
    user.username = ''
    expect(user).not_to be_valid
  end

  it 'creates user name from email' do
    user = FactoryBot.create(:user_without_username, email: 'test-user@example.org')
    expect(user.username).to eq('test-user')
  end

  it 'creates user with default status available' do
    user = described_class.new({ email: 'test-user@example.org' })
    expect(user.current_status).to eq('available')
  end

  it 'has an empty contacts list' do
    expect(user.contacts).to be_empty
  end

  it 'has a contact after adding one' do
    contact = FactoryBot.build(:user)
    user.contacts << contact
    expect(user.contacts).to include(contact)
  end

  describe 'contact requests' do
    let(:contact) { FactoryBot.create :user }
    let(:request) { FactoryBot.create :user }

    it 'adds user to contact request list of other user' do
      contact.contact_requests << user
      expect(contact.contact_requests).to include(user)
      expect(contact.contacts).not_to include(user)
    end

    it 'adds and deletes contact request' do
      contact.contact_requests << user
      expect(contact.contact_requests).to include(user)
      contact.contact_requests.delete(user)
      expect(contact.contact_requests).not_to include(user)
    end

    it 'has different contact and request lists' do
      user.contacts << contact
      user.contact_requests << request
      expect(user.contact_requests).to include(request)
      expect(user.contact_requests).not_to include(contact)
    end
  end

  it "determines other users which the user has send a contact request to" do
    requested = FactoryBot.create(:user)
    expect(@user.sent_contact_request?(requested)).to be false
    requested.contact_requests << @user
    expect(@user.sent_contact_request?(requested)).to be true
  end

  it "determines other users which are in my contacts" do
    contact = FactoryBot.create(:user)
    expect(@user.sent_contact_request?(contact)).to be false
    @user.contacts << contact
    expect(@user.sent_contact_request?(contact)).to be true
  end
end
