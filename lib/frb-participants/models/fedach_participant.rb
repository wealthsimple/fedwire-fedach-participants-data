module FrbParticipants
  class FedachParticipant < Participant
    def self.data
      @@data ||= YAML.load_file("./data/fedach-participants.yml")
    end
  end
end
