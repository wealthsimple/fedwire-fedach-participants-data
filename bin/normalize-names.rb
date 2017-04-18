require "active_support/all"
require "pp"
require "json"
require "neatjson"
require "yaml"
require "rest-client"

participants = YAML.load_file("./data/fedwire-participants.yml")
names = participants.map do |_, data|
  data[:customer_name]
end.uniq.sort

# Institutions keyed by fedwire name.
institutions = {}

# Remove excess. Examples:
# KANSAS STATE BANK => The Kansas State Bank (Scranton) => Kansas State Bank
# ALLIANCE BANK CENTRAL TEXAS => Alliance Bank - Central Texas => Alliance Bank Central Texas
def normalize_name(fedwire_name, plaid_name)
  return plaid_name if plaid_name.size == fedwire_name.size

  start_index = plaid_name.upcase.index(fedwire_name)
  if !start_index
    plaid_name.gsub!(" - ", " ")
    start_index = plaid_name.upcase.index(fedwire_name)
    return plaid_name if !start_index
  end
  plaid_name.slice(start_index, fedwire_name.size)
end

names.each_with_index do |name, i|
  puts "#{i+1}/#{names.size}: #{name}"

  response = RestClient.get("https://tartan.plaid.com/institutions/all/search?p=connect&q=#{CGI::escape(name)}")
  response = JSON.parse(response)

  # Only if there is one result, consider that to be an exact match.
  next  unless response.size == 1

  institutions[name] = normalize_name(name, institution[:name])

  # Something reasonable to ensure we aren't overloading Plaid
  sleep 0.5
end

File.write("./data/plaid-institution-names.json", JSON.neat_generate(institutions, wrap: 200, after_comma: 1))
File.write("./data/plaid-institution-names.yml", institutions.to_yaml)
