class ProjectsController < ApplicationController
     before_action :require_user_logged_in
     before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
    
    def index
        @projects = current_user.projects
    end
    
    def show
        
        
    end
    
    def new
        @project = Project.new
    end
    
    def create
        @project = current_user.projects.build(project_params)

        if @project.save
          flash[:success] = '製品が正常に登録されました'
          redirect_to @project
        else
          flash.now[:danger] = '製品が登録されませんでした'
          render :new
        end
    end

    def edit
        
    end
      
    def update
        
    
        if @project.update(project_params)
          flash[:success] = '製品は正常に更新されました'
          redirect_to @project
        else
          flash.now[:danger] = '製品は更新されませんでした'
          render :edit
        end
    end
        
    def destroy
        
        @project.destroy
    
        flash[:success] = '製品は正常に削除されました'
        redirect_to projects_url
    end
    
  
      
    private
    
   def correct_user
      @project = current_user.projects.find_by(id: params[:id])
     unless @project
      redirect_to root_url
     end
   end
  
    
    def project_params
        params.require(:project).permit(:product, :status)
    end
end