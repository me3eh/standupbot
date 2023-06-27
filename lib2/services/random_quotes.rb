# frozen_string_literal: true

module Services
  module RandomQuotes
    extend self

    def call(username:)
      ["No i Pan #{username}, oczywiście",
       "Przed wyruszeniem na PP, musisz zebrać drużynę",
       "Nie możesz tu spać, znajdź oberżę lub odpocznij na zewnątrz",
       "Reasumując wszystkie aspekty kwintesencji tematu, dochodzę do fundamentalnej konkluzji - warto programować",
       "Wczorajszy standup nic by nie dał, nie dałoby nic",
       "Wyuczę cię w jeden księżyc",
       "Pie***lę standup, dawaj mi PP",
       "PP? Pie***lę, tak chłop ze chłopem?",
       "To zdawałem raport ja, Jarząbek",
       "Czy naładowane bateryjki przed pracą? No tak średnio bym powiedział. Czyli za krótko było wolne? " +
         "Może za długo właśnie",

       # "Co tak pachnie? Standup. A czego dodałeś? "
        # "Nie ma takiego czegoś jak 'nie da się', jest tylko 'nie chce mi się'",

      ].sample
    end
  end
end
