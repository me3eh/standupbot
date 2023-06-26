module Jsons
    class EveningForm
        def initialize; end

        def call(user_id:, team_id:)
            blocks=[]
            blocks<<Header::call(text: "Wieczorny Standup!")
            blocks<<Input::call(label_text: "1. Co udało ci sie dzisiaj skończyć?", value_id: "first_input")
            blocks<<Input::call(label_text: "2. Które zadań nie zostały zakończone i na jakim etapie dzisiaj je pozostawiasz ? " +
                "(pamiętałeś żeby wypchnąć je do repo?)", value_id: "second_input")
            blocks<<Input::call(label_text: "3. Pojawiły się jakieś blockery?", value_id: "third_input")
            blocks<<Input::call(label_text: "4. Czego nowego się dziś nauczyłeś / dowiedziałeś ? A jeśli niczego / "+
                "to czego w danym temacie chciałbyś się dowiedzieć ? Daj nam sobie pomóc", value_id: "fourth_input")
            blocks<<Input::call(label_text: "Tutaj wrzuć swoje tickety/pry oraz czas ich wykonania - spokojnie, opcjonalne", value_id: "prs")
            blocks<<ActionBlock::call(action_button1: "evening_saving")
            {blocks:blocks}
        end
    end
end
