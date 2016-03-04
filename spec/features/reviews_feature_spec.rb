require 'rails_helper'

feature 'reviewing' do
    before do
      sign_up('email@email.com')
      create_restaurant('KFC')
    end

  scenario 'allows users to leave a review using a form' do
    create_review('KFC', 'so so', '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end

  feature 'deleting a review' do

    scenario 'a user can only delete a review that they have written' do
      create_review('KFC', 'so so', '3')
      click_link 'KFC'
      click_link 'Delete Review'
      expect(page).to have_content 'Review deleted successfully'
    end

    scenario 'a user can\'t delete another user\'s review' do
      create_review('KFC', 'so so', '3')
      sign_out
      sign_up('test@email.com')
      click_link 'KFC'
      click_link 'Delete Review'
      expect(page).to have_content 'You cannot delete another user\'s review'
    end
  end

  scenario 'displays an average rating for all reviews' do
    create_review('KFC', 'so so', '3')
    sign_out
    sign_up('test@email.com')
    create_review('KFC', 'great', '5')
    expect(page).to have_content("Average rating: ★★★★☆")
  end

  feature 'displays time posted' do
    scenario 'a review posted 5 hours ago shows it is posted 5 hours ago' do
      time_now = Time.now
      allow(Time).to receive(:now).and_return(time_now - 5.hours)
      create_review('KFC', 'so so', '3')
      allow(Time).to receive(:now).and_return(time_now)
      visit '/restaurants'
      expect(page).to have_content('posted about 5 hours ago')
    end
  end
end
