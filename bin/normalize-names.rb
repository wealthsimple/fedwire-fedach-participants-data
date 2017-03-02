require "active_support/all"
require "pp"
require "json"
require "neatjson"
require "yaml"
require "rest-client"

participants = YAML.load_file("./fedwire-participants.yml")
names = participants.map do |_, data|
  data[:customer_name]
end.uniq.sort

# Institutions keyed by fedwire name.
institutions = {}

names.each_with_index do |name, i|
  puts "#{i+1}/#{names.size}: #{name}"

  response = RestClient.get("https://tartan.plaid.com/institutions/all/search?p=connect&q=#{CGI::escape(name)}")
  response = JSON.parse(response)

  # Only if there is one result, consider that to be an exact match.
  next  unless response.size == 1
  institution = response.first
  institutions[name] = {
    name: institution["name"],
    plaid_id: institution["id"],
  }

  # Something reasonable to ensure we aren't overloading Plaid
  sleep 0.5
end

File.write("./institution-names.json", JSON.neat_generate(institutions, wrap: 200, after_comma: 1))
File.write("./institution-names.yml", institutions.to_yaml)
