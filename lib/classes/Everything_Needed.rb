class Everything_Needed
  def initialize
    @list_of_slack_clients = {}
    @info_about_user = {}
    @users_in_channel = {}
    Team.all.each do |team|
      slack_client = Slack::Web::Client.new( token: team.token )
      @list_of_slack_clients = @list_of_slack_clients.merge(
        {
          team.team_id => slack_client
        }
      )
    end
  end

  def get_slack_client(team_id:)
    @list_of_slack_clients[team_id]
  end

  def get_info_about_user(team_id:, user_id:)
    statement = @info_about_user[team_id]&.has_key?(user_id)
    if !statement
      profile_info = @list_of_slack_clients[team_id].users_info(
        user: user_id)[:user][:profile]
      @info_about_user =
        {
          user_id => {
            "real_name" => profile_info[:real_name],
            "pic" => profile_info[:image_192]
          }
        }
    end
    [ @info_about_user[team_id][user_id][:real_name],
      @info_about_user[team_id][user_id][:pic] ]
  end

  def get_list_members_in_channel(team_id:, channel_id:)
    statement = @users_in_channel&.has_key?(channel_id)
    if !statement
      slack_client = @list_of_slack_clients[team_id]
      # slack_client.conversations_members(
      #   channel: channel_id)[:members].each do |u|
      #   slack_client.users_info(user: u)[]
      # end
      @users_in_channel = {
        channel_id => @list_of_slack_clients[team_id].conversations_members(
          channel: channel_id)[:members]
      }
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

  def add_member_to_list_members_in_channel(team_id:, channel_id:, user_id:)
    statement = @users_in_channel&.has_key?(channel_id)
    if !statement
      slack_client = @list_of_slack_clients[team_id]
      user_list = []
      slack_client.conversations_members(
        channel: channel_id)[:members].each do |u|
          user_list.append(u) unless slack_client.users_info(
            user: u)[:user][:is_bot]
      end
      @users_in_channel = @users_in_channel.merge({
        channel_id => user_list
      })
    else
      @users_in_channel[channel_id] =
        @users_in_channel[channel_id].append(user_id)
    end
    @users_in_channel[channel_id]
  end

  def delete_member_from_list_members_in_channel(channel_id:, user_id:)
    puts user_id
    statement = @users_in_channel&.has_key?(channel_id)
    if !statement.nil?
      @users_in_channel[channel_id]&.delete(user_id)
    end
  end
end