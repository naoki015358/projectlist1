class UsersController < ApplicationController
  before_action :ensure_current_user, {only: [:index, :show, :completes, :incompletes, :works, :abnormals]}
  before_action :require_user_logged_in, only: [:index, :show, :completes, :incompletes, :works, :abnormals]
  
 
  def index
      @users = User
  end

  def show
     @user = User.find(params[:id])
     @projects = current_user.projects
  end
      

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def completes
     @user = User.find(params[:id])
     @projects = @user.projects.page(params[:page])
     @projects = @projects.where(status: '完了')
     
  end
  
  def incompletes
     @user = User.find(params[:id])
     @projects = @user.projects.page(params[:page])
     @projects = @projects.where(status: '未完了')
     
  end
  
  def works
     @user = User.find(params[:id])
     @projects = @user.projects.page(params[:page])
     @projects = @projects.where(status: '作業中')
     
  end
  
  def abnormals
     @user = User.find(params[:id])
     @projects = @user.projects.page(params[:page])
     @projects = @projects.where(status: '品質異常')
     
  end
  


  
  private
  
def ensure_current_user
  @current_user = User.find_by(id: session[:user_id])
  if @current_user.id != params[:id].to_i
    flash[:notice]="権限がありません"
    redirect_to("/login")
  end
end
  
   
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
