require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do

  view 'home'

end

get "/weather" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "aba8556037cf2658bde28a165e86639d" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash
  
  @location = @forecast["timezone"]
  @current_weather_degrees = @forecast["current"]["temp"]
  @current_weather_description = @forecast["current"]["weather"][0]["description"]

  @text_current_weather = "it is currently #{@current_weather_degrees} degrees and #{@current_weather_description}."


    # for day in @forecast["daily"]
    #     "We'll have a high of #{day["temp"]["max"]} and #{day["weather"][0]["description"]}"
    # end

    # <% for day in @forecast["daily"] %>
    # <%= "We'll have a high of #{day["temp"]["max"]} and #{day["weather"][0]["description"]}" %>
    # <% end %>

    # <% day_number = 1 %>
    # <% for day in @forecast["daily"] %>
    # <p> <h6> <%= "On day #{day_number}, we'll have a high of #{day["temp"]["max"]} and #{day["weather"][0]["description"]}." %> </h6> </p>
    # <% day_number = day_number + 1 %>
    # <% end %>

  ### Get the news

  view 'weather'

end

get "/news" do

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=41aa5b540b6046d08135872b55955bf2"
@news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

  view 'news'

end
