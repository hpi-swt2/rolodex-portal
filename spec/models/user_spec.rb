require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user)
  end

  it "is creatable using a factory" do
    expect(@user).to be_valid
  end

  it "is invalid with a status other than 'available' or 'working'" do
    @user.current_status = "unavailable"
    expect(@user).not_to be_valid
  end

  it "is not valid with an email without @" do
    @user.email = "testATexample.de"
    expect(@user).not_to be_valid
  end

  it "is not valid without an email" do
    @user.email = ""
    expect(@user).to_not be_valid
  end

  it "is not valid without a password" do
    @user.password = ""
    @user.password_confirmation = ""
    expect(@user).not_to be_valid
  end

  it "is not valid without a username" do
    @user.username = ""
    expect(@user).not_to be_valid
  end

  it "creates user name from email" do
    user = FactoryBot.create(:user_without_username, email: "test-user@example.org")
    expect(user.username).to eq("test-user")
  end

  it "creates user with default status available" do
    user = described_class.new({ email: "test-user@example.org" })
    expect(user.current_status).to eq("available")
  end
end
