class TasksController < ApplicationController
    before_action :set_task, only: [:show,:edit]
    
    def index
        @tasks = Task.all
    end
    def show
        
    end
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = 'タスクが追加されました(T_T)'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクがなくなりました\(^o^)/'
            redirect_to :new
        end
    end
    def edit
        
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    #Strong Parameter
    def task_params
        params.require(:task).permit(:task, :status)
    end
    
end
