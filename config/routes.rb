


get 'leader_board/index', :to => 'team_managers#index', :as => 'leader_board'

get 'leader_board/team_details', :to => 'team_details#index', :as => 'team_details'

get 'team_managers/new', :to => 'team_managers#new', :as => 'new_team_manager'
post 'team_managers/create', :to => 'team_managers#create', :as => 'create_team_manager'
get 'team_managers/remove', :to => 'team_managers#remove', :as => 'remove_team_manager'

get 'team_members/:team_manager_id/members',  :to => 'team_members#index', :as => 'team_members'
get 'team_members/:team_manager_id/new', :to => 'team_members#new', :as => 'new_team_member'
post 'team_members/:team_manager_id/create', :to => 'team_members#create', :as => 'create_team_member'
get 'team_members/:team_manager_id/remove', :to => 'team_members#remove', :as => 'remove_team_member'

