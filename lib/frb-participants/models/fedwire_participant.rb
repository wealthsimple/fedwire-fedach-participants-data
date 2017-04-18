module FrbParticipants
  class FedwireParticipant < Participant
    def self.data
      @@data ||= YAML.load_file("./data/fedwire-participants.yml")
    end
  end
end
