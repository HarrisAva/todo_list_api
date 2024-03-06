require 'rails_helper'

RSpec.describe Todo, type: :model do
  context 'valid attributes' do
    it 'is valid with valid attributes' do
      todo = build(:todo)
      expect(todo).to be_valid
    end
  end

  context 'invalid attributes' do
    it 'is invalid without a body' do
      todo = build(:todo, body: nil)
      todo.valid?
      expect(todo.errors[:body]).to include("can't be blank")
    end

    it 'is invalid when body is too long' do
      todo = build(:todo, body: 'a' * 256)
      todo.valid?
      expect(todo.errors[:body]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid without a is_completed' do
      todo = build(:todo, is_completed: nil)
      todo.valid?
      expect(todo.errors[:is_completed]).to include('is not included in the list')
    end
  end
end
