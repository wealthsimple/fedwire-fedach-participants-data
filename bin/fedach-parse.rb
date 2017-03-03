require "active_support/all"
require "slither"
require "pp"
require "json"
require "neatjson"
require "yaml"

# Format is defined at:
# https://www.frbservices.org/EPaymentsDirectory/achFormat.html
Slither.define :fedach_participants, by_bytes: false do |definition|
  definition.body do |body|
    body.trap { true }
    # The institution's routing number
    body.column :routing_number, 9, type: :string
    # Main office or branch O=main B=branch
    body.column :office_type, 1, type: :string
    # Servicing Fed's main office routing number
    body.column :servicing_frb_number, 9, type: :string
    # The code indicating the ABA number to be used to route or send ACH items to the RFI
    # 0 = Institution is a Federal Reserve Bank
    # 1 = Send items to customer routing number
    # 2 = Send items to customer using new routing number field
    body.column :record_type_code, 1, type: :string
    # Date of last change to CRF information (MMDDYY)
    body.column :revision_date, 6, type: :string
    # Institution's new routing number resulting from a merger or renumber
    body.column :new_routing_number, 9, type: :string
    # Commonly used abbreviated name
    body.column :customer_name, 36, type: :string
    # Delivery address
    body.column :address, 36, type: :string
    # City name in the delivery address
    body.column :city, 20, type: :string
    # State code of the state in the delivery address
    body.column :state, 2, type: :string
    # Zipcode in the delivery address
    body.column :zip, 5, type: :string
    # Zipcode extension in the delivery address
    body.column :zip_extension, 4, type: :string
    # CRF contact telephone number
    body.column :telephone, 10, type: :string
    # Code is based on the customers receiver code
    # 1=Receives Gov/Comm
    # body.column :institution_status, 1, type: :string
    # 1=Current view
    # body.column :data_view, 1, type: :string
  end
end

parsed = Slither.parse("./vendor/FedACHdir.txt", :fedach_participants)[:body]

# Normalize fields where possible
parsed.map do |line|
  line[:new_routing_number] = nil if line[:new_routing_number] == "000000000"
  line[:zip_extension] = nil if line[:zip_extension] == "0000"
  line[:office_type] = {"O" => "main", "B" => "branch"}[line[:office_type]]
  line
end

# Participants keyed by routing number.
participants = {}
parsed.each do |line|
  participants[line[:routing_number]] = line.except(:routing_number)
end

File.write("./fedach-participants.json", JSON.neat_generate(participants, wrap: 200, after_comma: 1))
File.write("./fedach-participants.yml", participants.to_yaml)
