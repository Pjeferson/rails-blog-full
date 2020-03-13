require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user1) { User.create(name: 'My Name', email: 'email@email.com', password: 'mypassword', password_confirmation: 'mypassword')}
  let(:user2) { User.create(name: 'My Name2', email: 'email2@email.com', password: 'mypassword', password_confirmation: 'mypassword')}


   # Associations
   it { should belong_to(:follower) }
   it { should belong_to(:following) }
  
   # Validation
   it 'should be valid with valide attributes' do
     follow = Follow.new(follower: user1, following: user2)
     expect(follow).to be_valid  
   end

   it 'should not be valid without users' do
    follow = Follow.new(follower: user1)
    expect(follow).to_not be_valid  
  end
end
