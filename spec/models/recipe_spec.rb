require 'rails_helper'

RSpec.describe Recipe, type: :model do
  user = User.create(name: 'test', email: 'test@gmail.com', password: 'qwerty')
  subject { Recipe.create(user_id: user.id, name: 'test', preparation_time: 0, cooking_time: 0, description: 'yum') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'preparation_time should be present' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'cooking_time should be present' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'description should be present' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'preparation_time must be greater than 0' do
    subject.preparation_time = -5
    expect(subject).to_not be_valid
  end

  it 'cooking_time must be greater than 0' do
    subject.cooking_time = -5
    expect(subject).to_not be_valid
  end
end
