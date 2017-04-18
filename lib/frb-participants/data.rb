module FrbParticipants
  class Data
    # Data files are large, so preloading during an initializer can save time.
    def self.preload!
      [FrbParticipants::InstitutionName, FrbParticipants::FedachParticipant, FrbParticipants::FedwireParticipant].map(&:data)
      true
    end

    def self.load(file_name)
      path = File.join(File.dirname(File.expand_path(__FILE__)), "../../data/#{file_name}")
      YAML.load_file(path)
    end
  end
end
