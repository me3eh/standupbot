require 'date'
instance = SlackRubyBotServer::Service.instance
zone = 2
instance.every :minute do
  today_date_and_time = DateTime.now
  if  today_date_and_time.strftime('%A').eql?('Friday') &&
    today_date_and_time.hour.eql?(14-zone) &&
    today_date_and_time.minute > 58
      slack_client = $everything_needed.get_slack_client(team_id: 'T0A5H5F5M')
    # TODO change for team_id: T0A5H5F5M channel_id:CUMV4JP27
    # for test environment T01PQKG5X19/'C01PWJCSCKW'
      if today_date_and_time.month == 12 && today_date_and_time.day > 20
        slack_client.chat_postMessage(
          channel: 'CUMV4JP27',
          text: "Sorki, ze nie wczesniej. Dobrego sylwestra :ultra_fast_parot:"
        )
      else
        slack_client.chat_postMessage(
          channel: 'CUMV4JP27',
          text: "Angielski :slow_parrot:"
        )
      end
  end
  if today_date_and_time.strftime('%A').eql?('Thursday') &&
    today_date_and_time.hour.eql?(11-zone) &&
    today_date_and_time.minute == 30
      slack_client = $everything_needed.get_slack_client(team_id: 'T0A5H5F5M')
    # TODO change for team_id: T0A5H5F5M channel_id:CUMV4JP27
    # for test environment T01PQKG5X19/'C01PWJCSCKW'

      if today_date_and_time.month == 12 && today_date_and_time.day > 20
        slack_client.chat_postMessage(
          channel: 'CUMV4JP27',
          text: "Wszystkiego dobrego :D"
        )
      else
        slack_client.chat_postMessage(
          channel: 'CUMV4JP27',
          text: "Przypominajka o jutrzejszym angielskim, by żarek nie musiał. Reakcja, jak idziesz"
        )
      end
  end
end
