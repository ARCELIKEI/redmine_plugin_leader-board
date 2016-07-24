class TeamMember < ActiveRecord::Base
  unloadable

  belongs_to :team_manager
  belongs_to :user


  def name
    if self.user != nil
      self.user.name || ""
    else
      ""
    end
  end


end
