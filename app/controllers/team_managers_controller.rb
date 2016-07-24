class TeamManagersController < ApplicationController
	unloadable
	before_filter :require_login_admin



	# displays all team managers in the system
	def index
		@team_managers = TeamManager.all
	end

	# new team manager
	def new
		@users = ((User.all) - User.where(id: TeamManager.all.map { |m| m.user_id })).collect{|u| { :id => u.id, :value => u.name} }.to_json
		@team_manager = TeamManager.new
		@users = User.all
		@options = Array.new

		@users.each do |user|
      @options.push([user.firstname+ " " + user.lastname, user.id])
    end

	end

	# create & set its fields
	def create
		puts "==================="
		puts params[:team_manager][:user]
		puts "==================="
		user = User.find_by_id(params[:team_manager][:user])
		if params[:team_manager][:user].nil? || user.nil?
			flash[:error] = "Team Manager cannot be found."
			redirect_to :action => :index
			return
		end
		@team_manager = TeamManager.new
		@team_manager.title = params[:team_manager][:title]
		@team_manager.user_id = user.id
		if @team_manager.save
			flash[:notice] = "Team Manager Created!"
		else
			flash[:error] = "Team Manager cannot be created : #{@team_manager.errors.messages}."
		end
		redirect_to :action => :index
	end

	# deletes an existing team manager
	# and all his members from team members list
	def remove
		TeamManager.find(params[:id]).destroy
		flash[:notice] = "Team manager has been removed with its team members!"
		redirect_to :action => :index
	end

	private
	def require_login_admin
		unless (User.current.logged?) && (User.current.admin)
			render_404
			return
		end
	end



end
