class Everything_Needed
  def initialize
    @list_slack_clients = {}
    @info_about_user = {}
    @users_in_channel = {}
    @collection_of_nonbot_users = {}
    # @list_users = []
    Team.all.each do |team|
      slack_client = Slack::Web::Client.new( token: team.token )
      @list_slack_clients = @list_slack_clients.merge(
        {
          team.team_id => slack_client
        }
      )
    end
  end

  def get_slack_client(team_id:)
    @list_slack_clients[team_id]
  end

  def get_info_about_user(team_id:, user_id:)
    statement = @info_about_user[team_id]&.has_key?(user_id)
    if !statement
      profile_info = @list_slack_clients[team_id].users_info(
        user: user_id)[:user][:profile]
      @info_about_user = @info_about_user.merge(
        {
          user_id =>
            {
            "real_name" => profile_info[:real_name],
            "pic" => profile_info[:image_192]
            }
        }
      )
    end
    [ @info_about_user[team_id][user_id][:real_name],
      @info_about_user[team_id][user_id][:pic] ]
  end

  def get_list_members_in_channel(team_id:, channel_id:)
    statement = @users_in_channel&.has_key?(channel_id)
    if !statement
      array_with_users = []
      slack_client = @list_slack_clients[team_id]
      slack_client.conversations_members(
        channel: channel_id
      )[:members].each do |u|
        array_with_users.append(u) unless is_bot(user_id: u, team_id: team_id)
      end

      @users_in_channel = @users_in_channel.merge(
        {
          channel_id => array_with_users
        }
      )
    end
    @users_in_channel[channel_id]
  end

  def change_info_about_user(user_id:, real_name:, pic:, team_id:)
    statement = @info_about_user[team_id]&.has_key?(user_id)
    if !statement
        @info_about_user = @info_about_user.merge({
          team_id => {
            user_id => {
              "real_name" => real_name,
              "pic" => pic
            }
          }
        })
    else
      @info_about_user[team_id][user_id][:real_name] = real_name
      @info_about_user[team_id][user_id][:pic] = pic
    end
    @info_about_user[team_id][user_id]
  end

  def update_list_members_in_channel(team_id:, channel_id:)
    statement = @users_in_channel&.has_key?(channel_id)
    array_with_users = []
    slack_client = @list_slack_clients[team_id]
    slack_client.conversations_members(
      channel: channel_id
    )[:members].each do |u|
      array_with_users.append(u) unless is_bot(user_id: u, team_id: team_id)
    end
    if !statement
      @users_in_channel = @users_in_channel.merge
      (
        {
          channel_id => array_with_users
        }
      )
    else
      @users_in_channel[channel_id] = array_with_users
    end
    @users_in_channel[channel_id]
  end

  def is_bot(user_id:, team_id:)
    statement = @collection_of_nonbot_users&.has_key?(user_id)
    if !statement
      slack_client = get_slack_client(team_id: team_id)
      @collection_of_nonbot_users =
        @collection_of_nonbot_users.merge(
          {
            user_id => slack_client.users_info(user:user_id)[:user][:is_bot]
          }
        )
    end
    @collection_of_nonbot_users[user_id]
  end
end