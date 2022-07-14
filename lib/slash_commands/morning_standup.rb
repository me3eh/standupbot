SlackRubyBotServer::Events.configure do |config|
  config.on :command, '/morning_standup' do |command|

    user_id = command[:user_id]
    team_id = command[:team_id]

    standup = Standup_Check.find_by(
      user_id: user_id,
      date_of_stand: Date.today,
      team: team_id
    )

    # if standup.present? && standup.morning_stand

    # else
    json_blocks = Forms::MorningStandupForm.call(standup)
    # end
    #   if command[:text] == '-e'
    #     json_blocks.unshift(edit_options_alternative_options)
    #   else
    #     json_blocks.unshift(edit_options)
    #   end
    #   # change if adding new blocks
    #   standup_form_inputs = [
    #     standup.morning_first,
    #     standup.morning_second,
    #     standup.morning_third,
    #     standup.morning_fourth
    #   ]
    #   fulfilling_inputs_with_previous_answers(json_blocks: json_blocks,
    #                                           form_inputs: standup_form_inputs)
    #
    #   checking_option_for_working_place(json_blocks: json_blocks,
    #                                     standup: standup)
    #
    #   checking_option_for_pp(json_blocks: json_blocks, standup: standup)
    #
    # end
    pp json_blocks
    {
      "blocks": json_blocks
    }
  end
end

