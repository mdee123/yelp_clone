def sign_up(email)
  visit '/restaurants'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: 'testpassword'
  fill_in 'Password confirmation', with: 'testpassword'
  click_button 'Sign up'
end

def create_restaurant(name)
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end

def sign_out
  visit '/restaurants'
  click_link 'Sign out'
end

def create_review(restaurant)
  visit "/restaurants"
  click_link "Review #{restaurant}"
  fill_in 'Thoughts', with: 'so so'
  select '3', from: 'Rating'
  click_button 'Leave Review'
end
