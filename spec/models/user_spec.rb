require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid with valide attributes' do
    user = User.new(name: 'My Name', email: 'email@email.com', password: 'mypassword', password_confirmation: 'mypassword')
    expect(user).to be_valid  
  end

  it 'should not be valid without name' do
    user = User.new(name: '', email: 'email@email.com', password: 'mypassword', password_confirmation: 'mypassword')
    expect(user).not_to be_valid  
  end

  it 'should not be valid with a name length bigger than 50 chars' do
    user = User.new(name: 'a' * 51, email: 'email@email.com', password: 'mypassword', password_confirmation: 'mypassword')
    expect(user).not_to be_valid  
  end

  it 'should not be valid without email' do
    user = User.new(name: 'My Name', email: ' ', password: 'mypassword', password_confirmation: 'mypassword')
    expect(user).not_to be_valid  
  end

  it 'should not be valid with a email length bigger than 255 chars' do
    user = User.new(name: 'My Name', email: 'a'*246+'@email.com', password: 'mypassword', password_confirmation: 'mypassword')
    expect(user).not_to be_valid  
  end

  it 'should not be valid without password' do
    user = User.new(name: '', email: 'email@email.com', password: '', password_confirmation: '')
    expect(user).not_to be_valid  
  end

  it 'should not be valid without password confirmation' do
    user = User.new(name: 'My Name', email: ' ', password: 'mypassword', password_confirmation: '')
    expect(user).not_to be_valid  
  end
end
