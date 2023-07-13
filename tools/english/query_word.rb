require 'uri'
require 'net/http'
require 'json'


def query(word)
  url = URI("https://wordsapiv1.p.rapidapi.com/words/#{word}")
  
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  
  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Key"] = ENV['RAPID_API_KEY']
  request["X-RapidAPI-Host"] = 'wordsapiv1.p.rapidapi.com'
  
  response = http.request(request)

  resp = JSON.parse(response.read_body)

  result = "<p>"
  result += "<strong>#{word}</strong>"

  if resp['frequency']
    result += " #{resp['frequency']}"
  end

  if resp['pronunciation']
    pronunciation = ""
    resp['pronunciation'].each {
      |k, v|
      if pronunciation != ""
        pronunciation += " "
      end
      pronunciation += "<span style=\"color: grey;\">(#{k})</span>/#{v}/"
    }
    result += " [#{pronunciation}]"
  end
  result += "</p>"

  return result
end

if __FILE__ == $0
  if $*.empty?
    puts "Need word."
  else
    puts "#{query $*[0]}"
   end
end

