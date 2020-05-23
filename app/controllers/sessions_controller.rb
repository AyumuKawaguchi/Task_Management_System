class SessionsController < ApplicationController

  skip_before_action :login_require


  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      render :new
    end
    # &.はぼっち演算子と呼ばれオブジェクトがnilだった場合にnilに対応していないメソッド(NilClassに定義されていないメソッド)を呼び出すので、エラーが出る状況だったのを、オブジェクトがnilだった場合に戻り値にnilを返すメソッドに一時的に変えてしまうことでエラーを回避するという感じ。この場合はuserがオブジェクト、authenticateがメソッドで、通常はauthenticateはオブジェクトがnilだった場合エラーを吐き出すけどぼっち演算子を使うことで、userがnilだったとしてもエラーを吐かないようにしている。
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private
  
  def session_params
    params.require(:session).permit(:email, :password)
  end


end
