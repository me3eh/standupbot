
module Constants
  module Forms
    extend self
    # if stationary is selected, then is_stationary == 1
    # else if remomtely is selected, then is_stationary == 2
    # else is_stationary == 0
    # more info in event morning
    STATIONARY = 1
    REMOTELY = 2
    SOMEWHERE_FAR_AWAY = 0
    OPEN_FOR_PP = true
    NOT_REALLY_KEEN_FOR_PP = false
    EMOJI_FOR_MORNING = ":clown_face:"
  end
end