require 'rails_helper'

RSpec.feature "Follows", type: :feature do
  context "create a follow relationship" do
    let!(:user1) {User.create(name: 'Meu nome 1', email: 'meuemail1@email.com', password: 'Minha senha', password_confirmation: 'Minha senha')}
    let!(:user2) {User.create(name: 'Meu nome 2', email: 'meuemail2@email.com', password: 'Minha senha', password_confirmation: 'Minha senha')}
    
    before(:each) do
      visit '/signin'
      within('form') do
        fill_in 'Email', with: user1.email
        fill_in 'Senha', with: 'Minha senha'
      end
      click_button 'Entrar'
      click_link 'Seguir pessoas'
      click_link user2.name
      click_link 'Seguir'
    end

    scenario "user should follow another user" do
      expect(page).to have_selector(:button, 'Deixar de seguir') 
    end

    scenario "user should unfollow a user" do
      click_link 'Deixar de seguir'
      expect(page).to have_selector(:button, 'Seguir') 
    end
  end
end
