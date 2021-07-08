#
# class Users
#   def call(users_and_bots_in_channel, slack_client)
#     @users, @users_name ||= initialization_of_hashmap_and_array(users_and_bots_in_channel, slack_client)
#     return @users, @users_name
#   end
# end
#
# private
#
# def initialization_of_hashmap_and_array(users_and_bots_in_channel, slack_client)
#   users_and_bots_in_channel.each_with_index do |u, index|
#     users_in_channel = []
#     hashmap = {}
#     info_about_user = slack_client.users_info(user: u)[:user]
#     hashmap = hashmap.merge({u.to_s => info_about_user[index][:profile][:real_name].to_s})
#     unless info_about_user[index][:is_bot]
#       users_in_channel.append(u)
#     end
#     return users_in_channel, hashmap
#   end
# end