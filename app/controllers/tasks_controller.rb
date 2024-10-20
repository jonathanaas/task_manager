class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      # Chamar microserviço de scraping aqui
      notify_service(@task)
      redirect_to tasks_path, notice: 'Tarefa criada com sucesso.'
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      notify_service(@task)
      redirect_to tasks_path, notice: 'Tarefa atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'Tarefa excluída com sucesso.'
  end

  private

  def task_params
    params.require(:task).permit(:url, :status)
  end

  def notify_service(task)
    # Lógica para enviar notificação ao microserviço de notificações
    NotificationService.new(task).notify
  end
end
