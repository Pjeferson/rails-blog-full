require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let!(:user) {User.create(name: 'Meu nome', email: 'meuemail@email.com', password: 'Minha senha', password_confirmation: 'Minha senha')}
    
  before(:each) do
    visit '/signin'
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'Minha senha'
    end
    click_button 'Entrar'
  end

  context "create new post" do
    before(:each) do
      visit new_post_path
    end

    scenario "post should be created" do
      within('form') do
        fill_in 'Título', with: 'Novo Post'
        fill_in 'Conteúdo', with: 'Meu novo post é sobre meu novo post'
      end
      click_button 'Criar postagem'
      expect(page).to have_content('Postagem criada com sucesso!')  
    end

    scenario "invalid post should not be created" do
      within('form') do
        fill_in 'Título', with: 'a'*51
        fill_in 'Conteúdo', with: 'Meu novo post é sobre meu novo post'
      end
      click_button 'Criar postagem'
      expect(page).to have_content('Não foi possível realizar a postagem. Verifique os dados da mesma.')
    end
  end

  context "view posts" do
    let!(:other_user) {User.create(name: 'Meu nome', email: 'meuemail@email.com', password: 'Minha senha', password_confirmation: 'Minha senha')}
    let!(:posts) { 
      Post.create([
        {user: other_user, title: 'post um', body: 'corpo um'},
        {user: other_user, title: 'post dois', body: 'corpo dois'},
        {user: other_user, title: 'post tres', body: 'corpo tres'}
      ]) 
    }
   
    scenario "posts created by followed users should be visualizated" do
      Follow.create({follower: user, following: other_user})
      visit posts_path
      posts.each do |post|
        expect(page).to have_content(post.title)  
        expect(page).to have_content(post.body)  
      end
    end

    scenario "posts created by not followed users should not be visualizated" do
      visit posts_path
      posts.each do |post|
        expect(page).not_to have_content(post.title)  
        expect(page).not_to have_content(post.body)  
      end
    end

    scenario "created posts should be detailed with owner infos" do
      posts.each do |post|
        visit post_path(post)
        expect(page).to have_content(post.user.name) 
        expect(page).to have_content(post.title)  
        expect(page).to have_content(post.body)  
      end
    end

  end
end
