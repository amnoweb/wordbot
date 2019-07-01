# This code will create a character using random
# words to fill in qualities such as name,
# favorite color, favorite animal, favorite food,
# etc.

require "net/http"
require "json"

def main
    puts
    puts
    puts "Welcome to my Wordbot challenge! Are you ready to create a randomized character?\n"
    puts "You give us the name and we'll give you the deets!\n"
    puts "Type a character name here: "
    charName= gets
    puts
    puts "Alright, let's learn a little more about #{charName}\n"
    build_char
end


def build_char
    puts "Favorite animal: "
    animal = get_json('/wordbot?count=1&set=animals')
    puts animal["words"]
    
    puts "Favorite fruit: "
    fruit = get_json('/wordbot?count=1&set=fruits')
    puts fruit["words"]
    
    puts "Character type: "
    trait = get_json('/wordbot?count=1&set=moods')
    puts trait["words"]
    
    puts "Career: "
    occupation = get_json('/wordbot?count=1&set=occupations')
    puts occupation["words"]
    
    puts "Last thing the character did: "
    action = get_json('/wordbot?count=1&set=verbs_past')
    puts action["words"]
    
    randomize_again

end
    
def randomize_again
  loop do
    puts "\nCreate another character Y/N\n"
    continuePlaying = gets.delete("\n")
    if continuePlaying.downcase=="y"
      build_char
      break
    else
      puts "Have fun with the new character(s)!"
      exit
    end
  end

end

# get data from the api and parse it into a ruby hash
def get_json(path)
  response = Net::HTTP.get_response(build_uri(path))
  result = JSON.parse(response.body)
  #puts "🤖 GET #{path}"
  #puts "HTTP #{response.code}"
  #puts JSON.pretty_generate(result)
  result
end

def build_uri(path)
  URI.parse("https://api.noopschallenge.com" + path)
end

main()