class V1::TasksController < ApplicationController
    def create
        @task = Task.new(task_params)
        @task.save
        render json: @task, status: :created
    end

    def show
        @task = Task.find(params[:id])
        if @task && correct_user
            render json: @task, status: :ok
        else
            render status: :unauthorized
        end
    end

    def update
        @task = Task.find(params[:id])
        if correct_user && @task.update(task_params)
            render json: @task, status: :ok
        else
            render status: :unprocessable_entity
        end
    end

    def destroy
        @task = Task.find(params[:id])
        if @task.destroy
            render status: :ok
        else
            render status: :unprocessable_entity
        end
    end

    private

    def correct_user
        @task.user_id.to_i == @current_user.id.to_i
    end

    def task_params
        params.require(:task).permit(:category, :deadline, :done, :name, :user_id)
    end
end
