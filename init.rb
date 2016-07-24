Redmine::Plugin.register :leader_board do
  name 'Leader Board plugin'
  author 'Arcelik AR-GE'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

   menu :admin_menu, :team_managers, {:controller => 'team_managers', :action => 'index'},
  		:caption => :team_managers_admin

   menu :account_menu, :my_link, {:controller => 'team_details', :action => 'index'},   ### make init HERE!!!
       :caption => :managerial, :if => Proc.new { (TeamManager.find_by_user_id(User.current.id)) && (User.current.logged?) }

end
