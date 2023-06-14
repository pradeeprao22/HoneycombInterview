require 'httparty'

def get_favorite_language(username)
  url = "https://api.github.com/users/#{username}/repos"
  response = HTTParty.get(url)
  
  if response.code == 200
    repos = JSON.parse(response.body)
    languages = {}
    
    repos.each do |repo|
      language = repo['language']
      if language
        if languages[language]
          languages[language] += 1
        else
          languages[language] = 1
        end
      end
    end
    
    if languages.empty?
      "No favorite language found."
    else
      favorite_language = languages.max_by { |_k, v| v }[0]
      "Favorite language: #{favorite_language}"
    end
  else
    "Failed to fetch repositories for user: #{username}"
  end
end

print "Enter a GitHub username: "
username = gets.chomp

favorite_language = get_favorite_language(username)
puts favorite_language

