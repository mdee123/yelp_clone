def sign_up(email)
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: 'testpassword'
  fill_in 'Password confirmation', with: 'testpassword'
  click_button 'Sign up'
end

def sign_out
  visit '/'
  click_link 'Sign out'
end

def create_restaurant(name)
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end

def create_review(name, thoughts, rating)
  click_link "Review #{name}"
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
