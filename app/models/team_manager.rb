class TeamManager < ActiveRecord::Base
  unloadable

  belongs_to :user
  has_many :team_members, :dependent =>  :destroy
  validates_uniqueness_of :user_id

  def name
  	self.user.name || ""
  end

end
