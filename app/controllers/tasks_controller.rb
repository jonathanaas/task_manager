class TasksController < ApplicationController
    def index
      @tasks = @current_user.tasks
      render json: @tasks
    end
  
    def create
      @task = @current_user.tasks.new(task_params)
      if @task.save
        render json: @task, status: :created
        # Aqui você chamaria o microserviço de notificações
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      @task = @current_user.tasks.find(params[:id])
      if @task.update(task_params)
        render json: @task
        # Aqui você chamaria o microserviço de notificações
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @task = @current_user.tasks.find(params[:id])
      @task.destroy
      head :no_content
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title, :status, :url)
    end
  
end
  