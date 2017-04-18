module FrbParticipants
  class FedwireParticipant < Participant
    def self.data
      @@data ||= FrbParticipants::Data.load("fedwire-participants.yml")
    end
  end
end
