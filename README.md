<h1 style="justify-content: center; display:grid; color:red;">Wstaniobot</h1>

<div align="center">
	<br>	
		<img src="styles.svg" width="800" height="400" alt="">
	<br>
</div>

## Komendy:
- ### morning_standup 
- ### evening_standup 
- ### ping_people_stationary
- ###
## Rzeczy, które mogą się przydać:


<h4>Podpięcie bazy danych do irb</h4>

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