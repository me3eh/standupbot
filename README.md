<h1>Wstaniobot do slacka - WIP</h1>

![](https://media.tenor.com/images/4f5ec4401107eebf42f42093ffb1472f/tenor.gif)

Rzeczy, które mogą się przydać:

<h3>Podpięcie bazy danych do irb</h3>

(w moim wypadku tylko dwie klasy-
pewnie da sie lepiej, ale znalazłem tylko takie rozwiązanie dla ruby'ego z rake'iem)
```ruby
`require 'active_record'
class Standup_Check < ActiveRecord::Base; end
class Team < ActiveRecord::Base; end
db_config = YAML.load_file('config/postgresql.yml')
Standup_Check.establish_connection(db_config['development'])
Team.establish_connection(db_config['development'])
Team.connection
Standup_Check.connection`
```
Usuniecie referencji 
```ruby
class DeleteReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :standup_checks, :team_id
  end
end

```