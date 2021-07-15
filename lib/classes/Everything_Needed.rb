class Everything_Needed
  def initialize
    @list_slack_clients = {}
    @info_about_user = {}
    @users_in_channel = {}
    @real_user = {}
    Team.all.each do |team|
      slack_client = Slack::Web::Client.new( token: team.token )
      @list_slack_clients = @list_slack_clients.merge(
        {
          team.team_id => slack_client
        }
      )
    end
    @list_slack_clients.each do |key, slack_client|
      slack_client.users_list[:members].each do |users|
        next if (users[:is_bot] || users[:id].eql?("USLACKBOT"))
        @real_user = @real_user.merge({users[:id] => false})
        if @info_about_user[key].nil?
          @info_about_user = @info_about_user.merge(
            {
              key => {
                users[:id] => {
                  "real_name" => users[:profile][:real_name],
                  "pic" => users[:profile][:image_192]
                }
              }
            }
          )
        else
          @info_about_user[key] = @info_about_user[key].merge(
            {
              users[:id] => {
                "real_name" => users[:profile][:real_name],
                "pic" => users[:profile][:image_192]
              }
            }
          )
        end
      end
    end
  end
  def get_slack_client(team_id:)
    if @list_slack_clients[team_id].nil?
      team = Team.find_by(team_id: team_id) ||
        raise("Cannot find team with ID #{team_id}.")
      slack_client = Slack::Web::Client.new( token: team.token )
      @list_slack_clients = @list_slack_clients.merge(
        {
          team_id => slack_client
        }
      )
    end
    @list_slack_clients[team_id]
  end

  def get_info_about_user(team_id:, user_id:)
    if @info_about_user[team_id].nil?
      slack_client = $everything_needed.get_slack_client(team_id: team_id)
      user = slack_client.users_info(user: user_id)[:user]
      @info_about_user = @info_about_user.merge(
        {
          team_id =>{
            user_id =>{
              "real_name" => user[:profile][:real_name],
              "pic" => user[:profile][:image_192],
            }
          }
        }
      )
    elsif @info_about_user[team_id][user_id].nil?
      slack_client = $everything_needed.get_slack_client(team_id: team_id)
      user = slack_client.users_info(user: user_id)[:user]
      @info_about_user[team_id] = @info_about_user[team_id].merge(
        {
          user_id =>{
            "real_name" => user[:profile][:real_name],
            "pic" => user[:profile][:image_192],
          }
        }
      )
    end
    [ @info_about_user[team_id][user_id]["real_name"],
      @info_about_user[team_id][user_id]["pic"] ]
  end

  def get_list_members_in_channel(team_id:, channel_id:)
    if @users_in_channel[channel_id].nil?
      array_with_users = []
      slack_client = @list_slack_clients[team_id]
      slack_client.conversations_members(channel: channel_id
      )[:members].each do |u|
        array_with_users.append(u) unless is_bot(user_id: u,
                                                 team_id: team_id)
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
    if @info_about_user[team_id].nil?
      @info_about_user = @info_about_user.merge(
            {
            team_id => {
              user_id => {
                "real_name" => real_name,
                "pic" => pic,
              }
            }
          })
    elsif @info_about_user[team_id][user_id].nil?
      @info_about_user[team_id] = @info_about_user[team_id].merge(
        {
          user_id => {
            "real_name" => real_name,
            "pic" => pic,
          }
        })
    else
      profile = @info_about_user[team_id][user_id]
      profile["real_name"] = real_name
      profile["pic"] = pic
    end
  end

  def update_list_members_in_channel(team_id:, channel_id:)
    statement = @users_in_channel&.has_key?(channel_id)
    array_with_users = []
    slack_client = @list_slack_clients[team_id]
    slack_client.conversations_members(
      channel: channel_id
    )[:members].each do |u|
      array_with_users.append(u) unless is_bot(user_id: u,
                                               team_id: team_id)
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
    if @real_user[user_id].nil?
      @real_user = @real_user.merge(
        {
          user_id => false
        }
      ) unless $everything_needed.get_slack_client(team_id: team_id).users_info(user: user_id)[:user][:is_bot]
    end
    @real_user[user_id].nil? ? true : false
  end
end