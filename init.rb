Redmine::Plugin.register :leader_board do
  name 'Leader Board plugin'
  author 'Arcelik AR-GE'
  description 'This plugin provides adding team hierarchy. Team leaders can see their members activities from Managerial section.'
  version '0.0.1'
  url 'https://github.com/ARCELIKEI/redmine_plugin_leader-board'

   menu :admin_menu, :team_managers, {:controller => 'team_managers', :action => 'index'},
  		:caption => :team_managers_admin

   menu :account_menu, :my_link, {:controller => 'team_details', :action => 'index'},
       :caption => :managerial, :if => Proc.new { (TeamManager.find_by_user_id(User.current.id)) && (User.current.logged?) }

end
