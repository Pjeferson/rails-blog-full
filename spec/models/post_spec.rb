require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:user) { User.create(name: 'My Name', email: 'email@email.com', password: 'mypassword', password_confirmation: 'mypassword')}
  
  # Associations
  it { should belong_to(:user) }
  
  # Validation
  it 'should be valid with valide attributes' do
    post = Post.new(user: user, title: 'Post Title', body: 'body text')
    expect(post).to be_valid  
  end

  it 'should be valid without body' do
    post = Post.new(user: user, title: 'Post Title', body: '')
    expect(post).to be_valid  
  end

  it 'should not be valid without title' do
    post = Post.new(user: user, title: '', body: 'body text')
    expect(post).not_to be_valid  
  end

  it 'should not be valid with a title bigger than 50 chars' do
    post = Post.new(user: user, title: 'a' * 51, body: 'body text')
    expect(post).not_to be_valid  
  end

  it 'should not be valid with a body bigger than 240 chars' do
    post = Post.new(user: user, title: 'a' * 241, body: 'body text')
    expect(post).not_to be_valid  
  end
end
