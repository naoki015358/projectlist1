class UsersController < ApplicationController
  
  def index
      @users = User
  end

  def show
     @user = User.find(params[:id])
     @projects = @user.projects
     
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
     @projects = @projects.where(status: '未着手')
     
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

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
