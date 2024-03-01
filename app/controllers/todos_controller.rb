class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
    before_action :authenticate_request

  def index
    todos = Todo.all
    render json: TodoBlueprint.render(todos, view: :normal), status: :ok
  end

  def my_todos
    todos = @current_user.todos
    render json: TodoBlueprint.render(todos, view: :normal, status: :ok)
  end

  def show
    render json: TodoBlueprint.render(@todo, view: :normal), status: :ok
  end

  def create
    todo = @current_user.todos.create(todo_params)

    if todo.save
      render json: TodoBlueprint.render(todo, view: :normal), status: :created
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def update

    if @todo.update(todo_params)
      render json: TodoBlueprint.render(@todo, view: :normal), status: :ok
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @todo.destroy
      render json: nil, status: :ok
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end
  
  def todo_params
    params.permit(:body, :is_completed)
  end
end