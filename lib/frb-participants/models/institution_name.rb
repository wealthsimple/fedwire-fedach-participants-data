module FrbParticipants
  class InstitutionName
    def self.find_by_frb_name(frb_name)
      normalized_name = data[frb_name]
      OpenStruct.new(frb_name: frb_name, normalized_name: normalized_name) if normalized_name
    end

    def self.data
      @@institution_name_data ||= plaid_data.merge(manual_data)
    end

    def self.plaid_data
      @@plaid_data ||= FrbParticipants::Data.load("plaid-institution-names.yml")
    end

    def self.manual_data
      @@manual_data ||= FrbParticipants::Data.load("manually-normalized-institution-names.yml")
    end
  end
end
