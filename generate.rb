require 'erubis'
require 'active_support/all'

## Data

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

# Hard-coded team ids
$teams = (1..6).to_a
# Hard-coded family ids
$families = (1..8).to_a
# Players are 9 - 16 years old
$birth_year = (2000..2005).to_a

## Methods (read from bottom of file up)

# Return the family id based on the last name
# or initialize a new (randomly picked) family id
def derive_family(lname)
  # Initialize a cache, default value is a new random family id
  $last_name_cache ||= Hash.new do |hash, key|
    hash[key] = $families.sample
  end
  return $last_name_cache[lname]
end

# By convention, methods that end with a ? return a
# true or false value.
def unique_name?(full_name)
  # Initialize a cache that will return false if a name is not
  # recognized, but will remember the name for next time
  $name_cache ||= Hash.new do |hash, key|
    hash[key] = "recognized"
    false
  end
  $name_cache[full_name]
end

# Construct a hash with appropriate 'player' values.
def generate_name
  fname =  $fnames.sample
  lname =  $lnames.sample
  # If the generated name is not unique, call this
  # function again (and so on until it succeeds)
  unless unique_name?(fname + lname)
    generate_name
  end
  return {
      player_fname: fname,
      player_lname: lname,
      player_nickname: fname + $nickname_suffixes.sample,
      family_id: derive_family(lname)
    }
end

# Create a appropriately formatted date
def generate_birth_date
  # year, month, day: randomly generated
  date = [
    $birth_year.sample,
    (1..12).to_a.sample,
    (1..28).to_a.sample
  ]
  # This would be much harder without the powers
  # imported from the active_support library.
  # Automatically turns a date into SQL date string.
  Date.new(*date).to_formatted_s :db
end

# Construct player hash from name generator, the passed in
# player id, a generated birthday, and a randomly selected
# team id.
def generate_player(player_id)
  generate_name.merge(
    {
      player_id: player_id,
      player_birthday: generate_birth_date,
      team_id: $teams.sample
    }
  )
end

# Generate a set of player data from the range
def make_players(id_range)
  players = []
  id_range.each do |player_id|
    players << generate_player(player_id)
  end
  players
end

# Get hash from make_players function, render sql template
# using the hash
def render_sql_template(range)
  data = {players: make_players(range)}
  template = Erubis::Eruby.new(File.read("merge_template.sql")).result(data)
  File.open('generated/team_merge.sql', 'w') do |file|
    file.write(template)
  end
  return data
end

# Simple wrapper function, just outputs some status stuff
# to the command line. Range is passed through.
def run(range)
  puts 'starting render...'
  data = render_sql_template(range)
  puts 'added ' + data[:players].size.to_s + ' players'
  puts 'ending render'
end

# This allows the file to be used as a script not just a library
# This turns it into a 'program' that can be called on the command
# line. ARGV is a way for the program to accept arguments from the
# command line (the starting player id and last player id). If
# not set, the defaults are 6 and 50 respectively.
if __FILE__ == $0
  start, stop = (ARGV[0] || 6), (ARGV[1] || 50)
  puts "run: #{start}..#{stop}"
  run start..stop
end
