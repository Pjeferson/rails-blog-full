require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context "create new user" do
    before(:each) do
      visit '/signup'
      within('form') do
        fill_in 'Nome', with: 'Meu nome'
        fill_in 'Email', with: 'meuemail@email.com'
      end
    end

    scenario "user should be created" do
      within('form') do
        fill_in 'Senha', with: 'Minha senha'
        fill_in 'Confirmação de senha', with: 'Minha senha'
      end
      click_button 'Criar conta'
      expect(page).to have_content('Cadastro realizado com sucesso!')  
    end

    scenario "invalid user should not be created" do
      click_button 'Criar conta'
      expect(page).to have_content('Não foi possível realizar o cadastro. Verifique seus dados.')  
    end
  end

  context "edit user" do
    let!(:user) {User.create(name: 'Meu nome', email: 'meuemail@email.com', password: 'Minha senha', password_confirmation: 'Minha senha')}
    
    before(:each) do
      visit '/signin'
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: 'Minha senha'
      end
      click_button 'Entrar'
      visit edit_user_path(user)
    end

    scenario "user should be edited" do
      within('form') do
        fill_in 'Senha', with: 'Minha nova senha'
        fill_in 'Confirmação de senha', with: 'Minha nova senha'
      end
      click_button 'Atualizar conta'
      expect(page).to have_content('Cadastro atualizado com sucesso!')  
    end

    scenario "invalid user should not be edited" do
      within('form') do
        fill_in 'Email', with: ''
      end
      click_button 'Atualizar conta'
      expect(page).to have_content('Não foi possível atualizar o cadastro. Verifique seus dados.')  
    end
  end

  context "view users" do
    let!(:user1) {User.create(name: 'Meu nome 1', email: 'meuemail1@email.com', password: 'Minha senha', password_confirmation: 'Minha senha')}
    let!(:user2) {User.create(name: 'Meu nome 2', email: 'meuemail2@email.com', password: 'Minha senha', password_confirmation: 'Minha senha')}
    
    before(:each) do
      visit '/signin'
      within('form') do
        fill_in 'Email', with: user1.email
        fill_in 'Senha', with: 'Minha senha'
      end
      click_button 'Entrar'
    end

    scenario "user should see own profile" do
      visit user_path(user1)
      expect(page).to have_content(user1.name)
      expect(page).to have_selector(:button, 'Editar')
      expect(page).not_to have_selector(:button, 'Seguir')  
    end

    scenario "user should see anothers profiles" do
      visit user_path(user2)
      expect(page).to have_content(user2.name)
      expect(page).not_to have_selector(:button, 'Editar')
      expect(page).to have_selector(:button, 'Seguir')  
    end

    scenario "user should see not followed profiles on 'Seguir Pssoas'" do
      click_link 'Seguir pessoas'
      expect(page).to have_content(user2.name) 
    end

    scenario "user should not see followed profiles on 'Seguir Pssoas'" do
      Follow.create(follower: user1, following: user2)
      click_link 'Seguir pessoas'
      expect(page).not_to have_content(user2.name)  
    end
    
  end
end
