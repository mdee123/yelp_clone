require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end

  feature 'deleting a review' do

    before do
      sign_up(email@email.com)
      create_restaurant('KFC')
    end

    scenario 'a user can only delete a review that they have writtten' do


    end


  end


end
