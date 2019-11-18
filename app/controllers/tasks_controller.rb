class TasksController < ApplicationController
    before_action :require_user_logged_in 
    before_action :correct_user, only:[:edit,:destroy]
    before_action :set_task, only:[:edit,:update,:destroy]
    
    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(7)
    end
    def show
        if correct_user
            set_task
        else
            redirect_to login_url
        end
    end
    def new
        @task = Task.new
    end
    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'タスクが追加されました!'
            redirect_to root_url
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = 'タスクが追加されませんでした(T_T)'
            render :new
        end
    end
    def edit

    end
    def update
        
        if @task.update(task_params)
            flash[:success] = 'タスクは正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクは更新されませんでした'
            render :edit
        end
    end
    def destroy
        @task.destroy
        flash[:success] = 'タスクは削除されました。'
        redirect_to root_url
    end
    
    private
    
    #Strong Parameter
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
    
end
