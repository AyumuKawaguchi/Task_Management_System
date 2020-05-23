class ApplicationController < ActionController::Base

  helper_method :current_user
  before_action :login_require

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # if @current_user.nil?
    #   @current_user =  User.find_by(id: session[:user_id])
    # else
    #   @current_user =  @current_user
    # end
    # 三項演算子を利用すると・・・
    # @current_user = @current_user.nil? ? User.find_by(id: session[:user_id]) : @current_user
    # 演算子｜｜を利用すると・・・
    # @current_user = @current_user || User.find_by(id: session[:user_id])

    # もしsessionにuser_idが格納されているなら、そのままcurrent_userとして扱い、current_userがnilならUserテーブルからsessionのidを探して一致したuserをcurrent_userにするんだぞって感じ
  end

  def login_require
    redirect_to login_url unless current_user
  end

end
