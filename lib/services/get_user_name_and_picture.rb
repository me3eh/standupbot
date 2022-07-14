
module GetUserNameAndPicture
  extend self
  def call(team_id:, user_id: )
    user = GetSlackClient.call(team_id: team_id).users_info(user: user_id)[:user]
    [ user["real_name"], user["pic"] ]
  end
end