require 'rails_helper'

RSpec.describe User, type: :model do
  it "should create an user object" do
    user = User.new
    expect(user)
  end

  it "should not save user without attributes" do
    user = User.new
    expect(user.save).to eq(false)
  end

  it "should save an user object with attributes" do
    user = build(:user)
    expect(user.save)
  end
end
