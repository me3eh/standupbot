module Keeper_post_standup
  MORNING_NOTIFICATION = "1. Jakie zadania na dziś planujesz oraz jak oceniasz czas ich wykonania?\n\n" +
                         "2. Jakie widzisz zagrożenia i blockery w powyższej liście?\n\n" +
                         "3. Czy w któryms z powyższych tematów chciałbyś otrzymać pomoc?\n\n" +
                         '4. Czy w którymś z planowanych zadań przyjąłbyś kompana do Pair programmingu' +
                         " konsultacji / podzielenia się wiedzą doświadczeniami ?\n"
  EVENING_NOTIFICATION = "1. Co udało ci sie dzisiaj skończyć?\n\n" +
                         '2. Które zadań nie zostały zakończone i na jakim etapie dzisiaj ' +
                         "je pozostawiasz ? (pamiętałeś żeby wypchnąć je do repo?)\n\n" +
                         "3. Pojawiły się jakieś blockery?\n\n" +
                         '4. Czego nowego się dziś nauczyłeś / dowiedziałeś ? A jeśli niczego ' +
                         "to czego w danym temacie chciałbyś się dowiedzieć ? Daj nam sobie pomóc\n"

  def self.stationary_or_remotely(choice)
    choice.eql?('Stacjonarnie') ? 1 : 2
  end
end
