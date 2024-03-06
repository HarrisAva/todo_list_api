require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:expected_todo_structure) do
    {
      'id' => Integer,
      'body' => String,
      'is_completed' => [TrueClass, FalseClass]
    }
  end

  describe 'GET /index' do
    before do
      create_list(:todo, 10)
      get '/todos'
      @body = JSON.parse(response.body)
    end

    it 'returns todos' do
      @body.each do |todo|
        expect(todo.keys).to contain_exactly(*expected_todo_structure.keys)
      end
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'does not return empty if todos exist' do
      expect(@body).not_to be_empty
    end

    it 'returns 10 todos' do
      expect(@body.size).to eq(10)
    end
  end

  describe 'GET /show' do
    let(:todo_id) { create(:todo).id }

    before do
      get "/todos/#{todo_id}"
      @body = JSON.parse(response.body)
    end

    it 'checks for the correct structure ' do
      expect(@body.keys).to contain_exactly(*expected_todo_structure.keys)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before do
      post '/todos', params: attributes_for(:todo)
      @body = JSON.parse(response.body)
    end

    it 'checks for the correct structure ' do
      expect(@body.keys).to contain_exactly(*expected_todo_structure.keys)
    end

    it 'count of todos should increase by 1' do
      expect(Todo.count).to eq(1)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    let(:todo_id) { create(:todo).id }

    before do
      put "/todos/#{todo_id}", params: { body: 'updated body' }
      @body = JSON.parse(response.body)
    end

    it 'checks for the correct structure ' do
      expect(@body.keys).to contain_exactly(*expected_todo_structure.keys)
    end

    it 'checks if the body is updated' do
      expect(Todo.find(todo_id).body).to eq('updated body')
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'delete /destroy' do
    let(:todo_id) { create(:todo).id }

    before do
      delete "/todos/#{todo_id}"
    end

    it 'decrements the count of todos by 1' do
      expect(Todo.count).to eq(0)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
