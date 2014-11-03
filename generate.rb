require 'erubis'
require 'active_support/all'

$fnames = [
  'John',
  'Jane',
  'April',
  'Yifan',
  'Kelly',
  'Edda',
  'Nichole',
  'Becky',
  'Katie',
  'Matt',
  'Lindsey',
  'Rebecca',
  'Kelsey',
  'Robert',
  'Emily',
  'Jennifer',
  'Erin',
  'Xiaoying',
  'Sam',
  'Erin'
]

$lnames = [
  'Smith',
  'Jones',
  'Arnaldsdottir',
  'Baldwin',
  'Barnes',
  'Cook',
  'Fox',
  'Grebe',
  'Haberstroh',
  'Hillgartner',
  'Lin',
  'McCarthy',
  'Powers',
  'Rodriguez',
  'Sovell',
  'Taylor',
  'Thomas',
  'Thurlow',
  'Watson',
  'Wei',
  'Zhu'
]

$nickname_suffixes = [
  "y",
  "ie",
  "ums"
]

$teams = 6
$families = 8
$starting_id = 6
$birth_year = (2000..2005).to_a

def generate_name
  $name_cache ||= {}
  $last_name_cache ||={}
  fname =  $fnames.sample
  lname =  $lnames.sample
  nname = fname + $nickname_suffixes.sample
  if $last_name_cache.has_key? lname
    family_id = $last_name_cache[lname]
  else
    family_id = rand($families)+1
  end
  result = {
    player_fname: fname,
    player_lname: lname,
    player_nickname: nname,
    family_id: family_id
  }
  key = fname+lname
  if $name_cache.has_key?(key)
    result = generate_name
  else
    $name_cache[key] = 1
  end
  return result
end

def generate_birth_date
  date = [
    $birth_year.sample,
    (1..12).to_a.sample,
    (1..28).to_a.sample
  ]
  Date.new(*date).to_formatted_s :db
end

def generate_player(player_id)
  generate_name.merge(
    {
      player_id: player_id,
      player_birthday: generate_birth_date,
      team_id: rand($teams)+1
    }
  )
end

def players(id_range)
  players = []
  id_range.each do |i|
    players << generate_player(i)
  end
  players 
end

def render_players(file_name, range)
  File.open(file_name, 'w') do |file|
    file.write(players(range))
  end
end

def render_full_sql(range)
  data = {players: players(range)}
  template = Erubis::Eruby.new(File.read("merge_template.sql")).result(data)
  File.open('generated/team_merge.sql', 'w') do |file|
    file.write(template)
  end
end
