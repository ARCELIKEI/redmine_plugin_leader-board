class TeamMembersController < ApplicationController
  	unloadable


  	before_filter :find_team_manager
  	before_filter :require_login_admin



  	def new
      @users = (User.all - User.where(id: @team_manager.user_id)).collect{|u| { :id => u.id, :value => u.name} }.to_json
  		@team_member = @team_manager.team_members.new
  	end


  	def create
  		@team_member = TeamMember.new
      @team_member.team_manager_id = params[:team_manager_id]
  		@team_member.user_id = params[:team_member][:user_id]
  		if @team_member.save
  			redirect_to leader_board_path
  		end
  	end


  	def index
  		@team_members = @team_manager.team_members
  	end


    def remove
      TeamMember.find(params[:id]).destroy
      redirect_to :action => :index
    end


	private

	def require_login_admin
		unless (User.current.logged?) && (User.current.admin)
			render_404
			return
		end
	end

	def find_team_manager
		@team_manager = TeamManager.find(params[:team_manager_id])
	end

end
