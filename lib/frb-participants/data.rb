module FrbParticipants
  class Data
    # Data files are large, so preloading during an initializer can save time.
    def self.preload!
      [FrbParticipants::InstitutionName, FrbParticipants::FedachParticipant, FrbParticipants::FedwireParticipant].map(&:data)
      true
    end

    def self.load(file_name)
      YAML.load_file("./data/#{file_name}")
    end
  end
end
