require 'rails_helper'

describe Review, type: :model do
  it {should belong_to(:restaurant)}
  it {should belong_to(:user)}

  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
