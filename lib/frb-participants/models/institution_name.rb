module FrbParticipants
  class InstitutionName
    def self.find_by_frb_name(frb_name)
      normalized_name = data[frb_name]
      OpenStruct.new(frb_name: frb_name, normalized_name: normalized_name) if normalized_name
    end

    def self.data
      @@data ||= YAML.load_file("./data/institution-names.yml")
    end
  end
end
