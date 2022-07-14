module Morning_Standup_Commands
  # def get_json_morning
  #   [
  #     Jsons::Header.call(text: "Poranny Standup"),
  #     {
  #       "type": "input",
  #       "element": {
  #         "type": "plain_text_input",
  #         "multiline": true,
  #         "action_id": "input",
  #       },
  #       "label": {
  #         "type": "plain_text",
  #         "text": "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?",
  #         "emoji": true
  #       },
  #     },
  #     {
  #       "type": "divider"
  #     },
  #     {
  #       "type": "divider"
  #     },
  #     {
  #       "type": "input",
  #       "element": {
  #         "type": "plain_text_input",
  #         "multiline": true,
  #         "action_id": "input"
  #       },
  #       "label": {
  #         "type": "plain_text",
  #         "text": "2. Jakie widzisz zagrożenia i blockery w powyższej liście?",
  #         "emoji": true
  #       }
  #     },
  #     {
  #       "type": "divider"
  #     },
  #     {
  #       "type": "divider"
  #     },
  #     {
  #       "type": "input",
  #       "element": {
  #         "type": "plain_text_input",
  #         "multiline": true,
  #         "action_id": "input"
  #       },
  #       "label": {
  #         "type": "plain_text",
  #         "text": "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?",
  #         "emoji": true
  #       }
  #     },
  #     {
  #       "type": "divider"
  #     },
  #     {
  #       "type": "divider"
  #     },
  #     {
  #       "type": "input",
  #       "element": {
  #         "type": "plain_text_input",
  #         "multiline": true,
  #         "action_id": "input"
  #       },
  #       "label": {
  #         "type": "plain_text",
  #         "text": "4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu / konsultacji / podzielenia się wiedzą doświadczeniami ?",
  #         "emoji": true
  #       }
  #     },
  #     {
  #       "type": "actions",
  #       "elements": [
  #         {
  #           "type": "checkboxes",
  #           "options": [
  #             {
  #               "text": {
  #                 "type": "mrkdwn",
  #                 "text": "*Open for PP*"
  #               },
  #               "description": {
  #                 "type": "mrkdwn",
  #                 "text": "*Zaznaczenie na własną odpowiedzialność*"
  #               },
  #               "value": "value-2"
  #             }
  #           ],
  #           "action_id": "actionblank"
  #         }
  #       ]
  #     },
  #     {
  #       "type": "actions",
  #       "elements": [
  #         {
  #           "type": "radio_buttons",
  #           "options": [
  #             {
  #               "text": {
  #                 "type": "plain_text",
  #                 "text": "Stacjonarnie",
  #                 "emoji": true
  #               },
  #               "value": "stationary"
  #             },
  #             {
  #               "text": {
  #                 "type": "plain_text",
  #                 "text": "Zdalnie",
  #                 "emoji": true
  #               },
  #               "value": "remotely"
  #             }
  #           ],
  #           "action_id": "choice"
  #         }
  #       ]
  #     },
  #     {
  #       "type": "actions",
  #       "elements": [
  #         {
  #           "type": "button",
  #           "text": {
  #             "type": "plain_text",
  #             "text": "Potwierdź",
  #             "emoji": true
  #           },
  #           "value": "click_me_123",
  #           "action_id": "actionId-0"
  #         }
  #       ]
  #     }
  #   ]
  # end
  def get_initial_check_box__morning
    {
      "initial_options" =>
        [
          {
            "text": {
              "type": "mrkdwn",
              "text": "*Open for PP*"
            },
            "description": {
              "type": "mrkdwn",
              "text": "*Zaznaczenie na własną odpowiedzialność*"
            },
            "value": "value-2"
          }
        ],
    }
  end

  # def fulfilling_inputs_with_previous_answers(json_blocks:, form_inputs:)
  #   0.upto(3) do |form_number|
  #     json_blocks[form_number * 3 + 2][:element] =
  #       json_blocks[form_number * 3 + 2][:element].merge(
  #         { "initial_value": form_inputs[form_number] }
  #       )
  #   end
  # end

  # def checking_option_for_working_place(json_blocks:, standup:)
  #   json_blocks[13][:elements][0] =
  #     json_blocks[13][:elements][0].merge(
  #       get_initial_radio_button(
  #         is_stationary: standup.is_stationary)
  #     ) unless not_checked_option_for_working_place(standup)
  # end

  def not_checked_option_for_working_place(standup)
    standup.is_stationary.equal?(0)
  end

  def get_initial_radio_button(is_stationary:)
    text, value = get_place_of_working(is_stationary: is_stationary)
    {
      "initial_option" => {
        "text": {
          "type": "plain_text",
          "text": text,
          "emoji": true
        },
        "value": value
      }
    }
  end
  def get_place_of_working(is_stationary:)
    # if stationary is selected, then is_stationary == 1
    # else if remomtely is selected, then is_stationary == 2
    # else is_stationary == 0
    # more info in event morning
    is_stationary.equal?(1) ?
      %w[Stacjonarnie stationary] :
      %w[Zdalnie remotely]
  end
  def checking_option_for_pp(json_blocks:, standup:)
    json_blocks[12][:elements][0] =
      json_blocks[12][:elements][0].merge(get_initial_check_box__morning) if option_open_for_pp_checked(standup)
  end
  def option_open_for_pp_checked(standup)
    standup.open_for_pp
  end

  # def gathering_responds_from_form_morning(responds:,arguments_from_form:, creating_standup:)
  #   arguments_from_form.each.with_index do |u, index|
  #     if !creating_standup && first_argument(index)
  #       responds.append( u[1][:edit_option][:selected_option][:value])
  #     elsif !last_argument?(index, arguments_from_form) && !next_to_last_argument?(index, arguments_from_form)
  #       responds.append u[1][:input].nil? ?
  #                       ":speak_no_evil:" :
  #                         u[1][:input][:value].nil? ?
  #                           ":speak_no_evil:" :
  #                           u[1][:input][:value]
  #     elsif next_to_last_argument?(index, arguments_from_form)
  #       responds.append(u[1][:actionblank][:selected_options].empty? ?
  #                         false : true)
  #     elsif last_argument?(index, arguments_from_form)
  #       responds.append(u[1][:choice][:selected_option].nil? ?
  #                         "Idk, gdzieś w przestrzeni kosmicznej" :
  #                         u[1][:choice][:selected_option][:text][:text])
  #    end
  #   end
  # end
  #
  # def last_argument?(index, arguments_from_form)
  #   index.eql?(arguments_from_form.size-1)
  # end
  # def next_to_last_argument?(index, arguments_from_form)
  #   index.eql?(arguments_from_form.size-2)
  # end

  def stationary_or_remotely(choice)
    choice.eql?("Stacjonarnie") ? 1 : 2
  end
  # def post_public_morning(slack_client:,
  #                         command_channel:,
  #                         name_of_user:,
  #                         word:,
  #                         pic:,
  #                         value_1_if_editing_existing_standup:)
  #   open_for_pp = word[4 + value_1_if_editing_existing_standup] ? "\t*#Open for PP*" : " "
  #   place = "\n\n\n*##{word[5 + value_1_if_editing_existing_standup]}*"
    # slack_client.chat_postMessage(
    #   channel: command_channel,
    #   "blocks": [
    #     {
    #       "type": "header",
    #       "text": {
    #         "type": "plain_text",
    #         "text": "Standup poranny: "+
    #           "#{name_of_user}",
    #         "emoji": true
    #       }
    #     },
    #   ],
    #   "attachments": [
    #     fields:[
    #       {
    #         "title": "1. Zadania na dziś",
    #         "value": word[0 + value_1_if_editing_existing_standup],
    #         "short": false
    #       },
    #       {
    #         "title": "2. Blockery",
    #         "value": word[1 + value_1_if_editing_existing_standup],
    #         "short": false
    #       },
    #       {
    #         "title": "3. Pomoc?",
    #         "value": word[2 + value_1_if_editing_existing_standup],
    #         "short": false
    #       },
    #       {
    #         "title": "4. Kompan do pomocy?",
    #         "value": word[3 + value_1_if_editing_existing_standup],
    #         "short": false
    #       },
    #     ],
    #     footer: " #{place} #{open_for_pp}",
    #     color: "#bfff00",
    #     thumb_url: "#{pic}",
    #   ],
    #   as_user: true,
    #   )
  # end
  def edit_public_morning(slack_client:,
                          command_channel:,
                          ts:,
                          word:,
                          pic:,
                          name_of_user:,
                          value_1_if_editing_existing_standup:)
    open_for_pp = word[4 + value_1_if_editing_existing_standup] ? "\t*#Open for PP*" : " "
    place = "\n\n\n*##{word[5 + value_1_if_editing_existing_standup]}*"
    slack_client.chat_update(
      channel: command_channel,
      ts: ts,
      "blocks": [
        {
          "type": "header",
          "text": {
            "type": "plain_text",
            "text": "Standup poranny: "+
              "#{name_of_user}",
            "emoji": true
          }
        },
      ],
      "attachments": [
        fields:[
          {
            "title": "1. Zadania na dziś",
            "value": word[0 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "2. Blockery",
            "value": word[1 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "3. Pomoc?",
            "value": word[2 + value_1_if_editing_existing_standup],
            "short": false
          },
          {
            "title": "4. Kompan do pomocy?",
            "value": word[3 + value_1_if_editing_existing_standup],
            "short": false
          },
        ],
        footer: " #{place} #{open_for_pp}",
        color: "#bfff00",
        thumb_url: "#{pic}",
      ],
      as_user: true,
      )

  end
end
