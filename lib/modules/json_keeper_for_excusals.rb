module Keeper_excusals
  def Keeper_excusals.attachment_for_main_screen
    [
      {
        "fallback": "Something wrong happened. GIVE BACK WORKING BOT",
        "callback_id": "choice_for_excusal",
        "color": "#3AA3E3",
        "attachment_type": "default",
        "actions": [
          {
            "name": "game",
            "text": ":heavy_plus_sign: Dodaj zwolnienie",
            "type": "button",
            "style": "primary",
            "value": "add",
          },
          {
            "name": "game",
            "text": ":heavy_minus_sign: Usun zwolnienie",
            "type": "button",
            "style": "danger",
            "value": "delete",
          },
          {
            "name": "game",
            "text": "Wylistuj zwolnienia",
            "type": "button",
            "value": "list",
          },
        ]
      }
    ]
  end
end
