
FactoryBot.define do
  factory :standup, class: Standup_Check do
    user_id {"U01Q32HRB2M" }

    trait :morning_standup do
      morning_stand { true }
      date_of_stand { Date.today }
      team { "T02XZKGVX19" }
      ts_of_message_morning {"1657204020.162319"}
      channel_of_message_morning {"C01PJSCSCKW"}
      morning_first { Faker::Games::Zelda.character }
      morning_second { Faker::Games::Zelda.character}
      morning_third { Faker::Games::Zelda.character }
      morning_fourth { Faker::Games::Zelda.character }
      open_for_pp { true }
      is_stationary { 1 }
    end

    trait :evening_standup do
      evening_stand { true }
      team { "T02XZKGVX19" }
      ts_of_message_evening { "1657204020.162224" }
      channel_of_message_evening { "C01PJSCSCKW" }
      date_of_stand { Date.new }
      ts_of_message_evening {nil}
      evening_first { Faker::Games::Zelda.character }
      evening_second { Faker::Games::Zelda.character }
      evening_third { Faker::Games::Zelda.character }
      evening_fourth { Faker::Games::Zelda.character }
      PRs_and_estimation { Faker::Games::Zelda.character }
    end
  end
end