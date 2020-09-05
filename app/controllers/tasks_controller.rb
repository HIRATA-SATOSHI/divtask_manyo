class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    # @tasks = Task.all.order(created_at: :desc)
    if params[:sort_expired]
      @tasks = Task.all
      @tasks = @tasks.order(deadline: :desc)
    else
      @tasks = Task.all
      @tasks = @tasks.order(created_at: :desc)
    end  

    if params[:sort_priority_high]
      @tasks = Task.all
      @tasks = @tasks.order(priority: :asc)
    end
  
    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        #両方name and statusが成り立つ検索結果を返す
        @tasks = @tasks.where('name LIKE ?', "%#{params[:task][:name]}%")
        @tasks =@tasks.where(status: params[:task][:status])
        
        #渡されたパラメータがtask nameのみだったとき
      elsif params[:task][:name].present?
        @tasks = @tasks.where('name LIKE ?', "%#{params[:task][:name]}%")
      
       #渡されたパラメータがステータスのみだったとき
      elsif params[:task][:status].present?
        @tasks =@tasks.where(status: params[:task][:status])
      end
    end

    @tasks = @tasks.page(params[:page]).per(5)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end
  

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'タスクを登録しました！' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'タスクを更新しました！' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'タスクを削除しました！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority)
  end    

  def set_task
    @task = Task.find(params[:id])
  end
end
