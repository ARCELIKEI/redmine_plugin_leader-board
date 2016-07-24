class TeamDetailsController < ApplicationController

  helper :journals
  helper :projects
  include ProjectsHelper
  helper :custom_fields
  include CustomFieldsHelper
  helper :issue_relations
  include IssueRelationsHelper
  helper :watchers
  include WatchersHelper
  helper :attachments
  include AttachmentsHelper
  helper :queries
  include QueriesHelper
  helper :repositories
  include RepositoriesHelper
  helper :sort
  include SortHelper
  include TeamDetailsHelper
  helper :team_details
  helper :timelog
  include Redmine::Export::PDF

  before_filter :find_team_manager


  
  def index
    members = @team_manager.team_members.collect{|t| t.user_id}
    retrieve_query_for_team_managers(members)
    sort_update(@query.sortable_columns)
    @query.sort_criteria = sort_criteria.to_a

    if @query.valid?
      case params[:format]
      when 'csv', 'pdf'
        @limit = Setting.issues_export_limit.to_i
        if params[:columns] == 'all'
          @query.column_names = @query.available_inline_columns.map(&:name)
        end
      when 'atom'
        @limit = Setting.feeds_limit.to_i
      when 'xml', 'json'
        @offset, @limit = api_offset_and_limit
        @query.column_names = %w(author)
      else
        @limit = per_page_option
      end
      @issue_count = @query.issue_count
      @issue_pages = Paginator.new @issue_count, @limit, params['page']
      @offset ||= @issue_pages.offset
      @issues = @query.issues(:include => [:assigned_to, :tracker, :priority, :category, :fixed_version],
                              :order => sort_clause,
                              :offset => @offset,
                              :limit => @limit)
      @issue_count_by_group = @query.issue_count_by_group
    else
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end


  private

  def find_team_manager
    @team_manager = TeamManager.find_by_user_id(User.current.id)  
  end

end