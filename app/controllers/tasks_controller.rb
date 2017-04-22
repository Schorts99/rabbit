class TasksController < ApplicationController
  before_action :find_task, except: [:new, :create, :index]

  def index
    if params[:category].blank?
      @tasks = Task.all.order('created_at DESC')
    else
      @category_id = Category.find_by(name: params[:category]).id
      @tasks = Task.where(category_id: @category_id).order('created_at DESC')
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task
    else
      render 'new', notice: "Hubo un error al guardar la tarea, intentalo de nuevo"
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task
    else
      render 'edit', notice: "Hubo un error al actualizar la tarea, intentalo de nuevo"
    end
  end

  def destroy
    if @task.destroy
      redirect_to root_path
    else
      redirect_to @task, notice: "Hubo un error al eliminar la tarea, intentalo de nuevo"
    end
  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :company, :url, :category_id)
    end

    def find_task
      @task = Task.find(params[:id])
    end
end
