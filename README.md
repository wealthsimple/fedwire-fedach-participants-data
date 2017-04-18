# frb-participants

Provides data from the The Federal Reserve Banks' Fedwire & FedACH participants in JSON format, mapping routing number to associated bank name and branch info.

For more details, see [Federal Reserve Bank Services: Download E-Payments Routing Directories](https://www.frbservices.org/EPaymentsDirectory/download.html)

## Rubygem:

```ruby
gem 'frb-participants', git: 'https://github.com/wealthsimple/frb-participants'
```

You can do basic queries of data:

```ruby
FrbParticipants::FedwireParticipant.find_by_routing_number("325182946")
=> #<OpenStruct
      telegraphic_name="UMPQUA BANK WA",
      customer_name="UMPQUA BANK",
      state="OR",
      city="HILLSBORO",
      funds_transfer_eligible=true,
      settlement_only=false,
      securities_transfer_eligible=false,
      revision_date="20160526">
```

Important! If you are using this on a production service, it is recommended that you preload the data in an initializer:

```ruby
require 'frb-participants'
FrbParticipants::Data.preload!
```

## Normalized data:

 **[fedwire-participants.json](https://github.com/wealthsimple/frb-participants/blob/master/data/fedwire-participants.json)**

```json
{
  "325182836":{
    "telegraphic_name":"LOWER VALLEY CU WA",
    "customer_name":"LOWER VALLEY CREDIT UNION",
    "state":"WA",
    "city":"SUNNYSIDE",
    "funds_transfer_eligible":true,
    "settlement_only":false,
    "securities_transfer_eligible":true,
    "revision_date":"20120702"
  },
  "325182946":{
    "telegraphic_name":"UMPQUA BANK WA",
    "customer_name":"UMPQUA BANK",
    "state":"OR",
    "city":"HILLSBORO",
    "funds_transfer_eligible":true,
    "settlement_only":false,
    "securities_transfer_eligible":false,
    "revision_date":null
  },
  ...
}
```

 **[fedach-participants.json](https://github.com/wealthsimple/frb-participants/blob/master/data/fedach-participants.json)**

```json
{
  "011000015":{
    "office_type":"main",
    "servicing_frb_number":"011000015",
    "record_type_code":"0",
    "revision_date":"122415",
    "new_routing_number":null,
    "customer_name":"FEDERAL RESERVE BANK",
    "address":"1000 PEACHTREE ST N.E.",
    "city":"ATLANTA",
    "state":"GA",
    "zip":"30309",
    "zip_extension":"4470",
    "telephone":"8773722457"
  },
  ...
}
```
