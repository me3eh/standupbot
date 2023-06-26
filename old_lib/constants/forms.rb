module Constants
  module Forms
    extend self
    # if stationary is selected, then is_stationary == 1
    # else if remotely is selected, then is_stationary == 2
    # else is_stationary == 0
    # more info in event morning
    STATIONARY = 1
    REMOTELY = 2
    SOMEWHERE_FAR_AWAY = 0
    OPEN_FOR_PP = true
    NOT_REALLY_KEEN_FOR_PP = false
    EMOJI_FOR_MORNING = ':clown_face:'
    EMOJI_FOR_EVENING = ':see_no_evil:'
    COLOR_FOR_MORNING_STANDUP = '#bfff00'
    COLOR_FOR_EVENING_STANDUP = '#1B4D3E'

    def text_for_submit(input:)
      input.present? ? 'Edytuj poprzedni' : 'Potwierdź'
    end
  end
end
