# fedwire-participants-data

Provides data from the The Federal Reserve Banks' Fedwire® Funds Service participants in JSON format, mapping routing number to associated bank name and branch info.

For more details, see [Federal Reserve Bank Services: Download E-Payments Routing Directories](https://www.frbservices.org/EPaymentsDirectory/download.html)

## Data sample

JSON: **[fedwire-participants.json](https://raw.githubusercontent.com/wealthsimple/fedwire-participants-data/master/fedwire-participants.json)**

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

YAML: **[fedwire-participants.yml](https://raw.githubusercontent.com/wealthsimple/fedwire-participants-data/master/fedwire-participants.yml)**

```yaml
---
'325182836':
  :telegraphic_name: LOWER VALLEY CU WA
  :customer_name: LOWER VALLEY CREDIT UNION
  :state: WA
  :city: SUNNYSIDE
  :funds_transfer_eligible: true
  :settlement_only: false
  :securities_transfer_eligible: true
  :revision_date: '20120702'
'325182946':
  :telegraphic_name: UMPQUA BANK WA
  :customer_name: UMPQUA BANK
  :state: OR
  :city: HILLSBORO
  :funds_transfer_eligible: true
  :settlement_only: false
  :securities_transfer_eligible: false
  :revision_date:
...
```
