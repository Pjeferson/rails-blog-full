require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context "create new user" do
    scenario "user should be created" do
      visit '/signup'
      within('form') do
        fill_in 'Nome', with: 'Meu nome'
        fill_in 'Email', with: 'meuemail@email.com'
        fill_in 'Senha', with: 'Minha senha'
        fill_in 'Confirmação de senha', with: 'Minha senha'
      end
      click_button 'Criar conta'
      expect(page).to have_content('Cadastro realizado com sucesso!')  
    end

    scenario "invalid user should not be created" do
      visit '/signup'
      within('form') do
        fill_in 'Nome', with: 'Meu nome'
        fill_in 'Email', with: 'meuemail@email.com'
      end
      click_button 'Criar conta'
      expect(page).to have_content('Não foi possível realizar o cadastro. Verifique seus dados.')  
    end
  end
end
