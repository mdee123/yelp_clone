require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do


    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end

  end

  context 'creating restaurants' do

    before do
      sign_up('email@email.com')
    end

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restaurants' do

    let!(:kfc){Restaurant.create(name: 'KFC')}

    scenario 'lets a user view a restraurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before do
      sign_up('email@email.com')
      create_restaurant('KFC')
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    before do
      sign_up('email@email.com')
      create_restaurant('KFC')
    end

    scenario 'removes a restaurant when a user clicks on a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

  end

  context 'user is not logged in' do

    scenario 'user cannot create a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    scenario 'user cannot edit a restraurant they haven\'t created' do
      sign_up('email@email.com')
      create_restaurant('KFC')
      sign_out
      sign_up('test@email.com')
      expect(page).not_to have_content 'Edit'
    end

    scenario 'user cannot delete a restraurant they haven\'t created' do
      sign_up('email@email.com')
      create_restaurant('KFC')
      sign_out
      sign_up('test@email.com')
      expect(page).not_to have_content 'Delete'
    end
  end

  context 'uploading images' do
    scenario 'a user can upload an image' do
      sign_up('email@email.com')
      click_link 'Add a restaurant'
      fill_in 'Name', with: "Burger"
      attach_file("Image", Rails.root + "spec/fixtures/burger.jpeg")
      click_button 'Create Restaurant'
      expect(page.find('#restaurant_image')['src']).to have_content 'burger.jpeg'
    end
  end
end
