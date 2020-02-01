class V1::TasksController < ApplicationController
    def search
        if params[:name].present? && !params[:category].present?
            tasks_by_name = Task.search_by_name([params[:name], @current_user.id.to_i]).includes(:tags)

            render json: tasks_by_name, status: :ok
        elsif params[:name].present?
            tasks_by_name = Task.search_by_name([params[:name], @current_user.id.to_i]).includes(:tags)
            query_tags = params[:category].split(" ")

            result = []
            tasks_by_name.each do |t|
                if query_tags.all? { |e| t.tags.find {|tag| tag.name == e} }
                    result << t
                end
            end

            render json: result, status: :ok
        elsif params[:category].present?             
            query_tags = params[:category].split(" ")

            tasks_by_tag = Task.joins(:tags).where('tags.name': query_tags)
                .group('tasks.id').having("count(tags) =" + query_tags.size.to_s)
            result = []
            tasks_by_tag.each do |t|
                if t.user_id ==  @current_user.id.to_i
                    result << t
                end
            end
            render json: result, status: :ok
        else 
            render status: :unprocessable_entity
        end

    end

    def create
        @task = Task.new(task_params)
        @task.save
        set_tags
        render json: @task, status: :created
    end

    def show
        @task = Task.find(params[:id])
        if @task && correct_user
            render json: @task, status: :ok
        else
            render status: :unprocessable_entity
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

    def set_tags
        if task_params[:category].present?
            @task.tags.destroy_all
            task_params[:category].split(" ").each do |t|
                tag = Tag.find_by(name: t) || Tag.new(name: t)
                @task.tags << tag
            end
        end
    end

    def task_params
        params.require(:task).permit(:category, :deadline, :done, :name, :user_id)
    end
end
