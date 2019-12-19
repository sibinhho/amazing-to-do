class V1::TasksController < ApplicationController
    def index
        @tasks = Task.all
        render json: @tasks, status: :ok
    end

    def create
        @task = Task.new(task_params)
        @task.save
        render json: @task, status: :created
    end

    def show
        @task = Task.find(params[:id])
        if @task
            render json: @task, status: :ok
        else
            render status: :unprocessable_entity
        end
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
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

    def task_params
        params.require(:task).permit(:category, :deadline, :done, :name)
    end
end
