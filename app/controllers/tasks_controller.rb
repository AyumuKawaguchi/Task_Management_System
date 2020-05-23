class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = Task.all #これだと全てのユーザーが全部観れてしまう。全一覧表示なら良いけどさ。特定ユーザーのみに見せたいときは適切じゃない。
    @tasks = current_user.tasks.order(created_at: :desc)
    @tasks = current_user.tasks.recent
    # @tasks = Task.where(user_id: current_user.id).order(created_at: :desc)
    # 上2つは同じ意味だよ。
  end

  def show
    # @task = Task.find(params[:id]) #これだとたまたま適当にURLを/tasks/32のように打ってしまったら、特定ユーザー出なくてもアクセスできてしまう。
    # @task = current_user.tasks.find(params[:id]) before_actionでリファクタリングしているけど、一応わかりやすくするのに残しとく
  end

  def new
    @task = Task.new
  end

  def create
    # @task= Task.new(task_params.merge(user_id: current_user.id))  #@taskにしているのはユーザビリティへの配慮とビューでエラー出た際に表示できるため。
    @task= current_user.tasks.new(task_params)  
    # 上記二つは同じ意味だが、それぞれ書いておくと、結局やりたいことはtaskテーブルとuserテーブルが紐づいているよということが前提で
    # 上はmerge(user_id: current_user.id)で新しく作るタスクのインスタンスがどのユーザー作ったのかをを示している。
    # 日本語訳なら「新しくタスクを作るよ。あっそれとどのユーザーが作ったか結びつけるわ」みたいなアプローチ
    # user_idはDB上のカラム名で、current_user.idはrails上で使用している値みたいなイメージ
    # 下は「カレントユーザーに結びついたタスクを作るよ」って簡単に書いている感じ

    if @task.save
    redirect_to root_path, notice: "タスク「#{@task.name}を登録しました。」"
    # flash[:notice] = "タスク「#{task.name}を登録しました。」"
    # redirect_to root_path これと同じになるからビューでflash.noticeが使えている。
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to root_path, notice: "タスク「#{task.name}」を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: "タスク「#{task.name}」を削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end
