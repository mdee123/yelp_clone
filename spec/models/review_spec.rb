require 'rails_helper'

describe Review, type: :model do
  it {is_expected.to belong_to :restaurant}
  # it { expect(restaurant).to have_many(:reviews).dependent(:destroy) }
end
