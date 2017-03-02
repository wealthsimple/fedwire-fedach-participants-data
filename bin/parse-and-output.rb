require "active_support/all"
require "slither"
require "pp"
require "json"
require "neatjson"
require "yaml"

# Format is defined at:
# https://www.frbservices.org/EPaymentsDirectory/fedwireFormat.html
Slither.define :fedwire_participants, by_bytes: false do |definition|
  definition.body do |body|
    body.trap { true }
    body.column :routing_number, 9, type: :string
    body.column :telegraphic_name, 18, type: :string
    body.column :customer_name, 36, type: :string
    body.column :state, 2, type: :string
    body.column :city, 25, type: :string
    body.column :funds_transfer_eligible, 1, type: :string
    body.column :settlement_only, 1, type: :string
    body.column :securities_transfer_eligible, 1, type: :string
    body.column :revision_date, 8, type: :string
  end
end

parsed = Slither.parse("./vendor/test.txt", :fedwire_participants)[:body]

# Convert boolean fields from string => boolean
parsed.map do |line|
  line[:funds_transfer_eligible] = line[:funds_transfer_eligible] == "Y"
  line[:settlement_only] = line[:settlement_only] == "S"
  line[:securities_transfer_eligible] = line[:securities_transfer_eligible] == "Y"
  line
end

# Participants keyed by routing number.
participants = {}
parsed.each do |line|
  participants[line[:routing_number]] = line.except(:routing_number)
end

File.write("./fedwire-participants.json", JSON.neat_generate(participants, wrap: 200, after_comma: 1))
File.write("./fedwire-participants.yml", participants.to_yaml)
