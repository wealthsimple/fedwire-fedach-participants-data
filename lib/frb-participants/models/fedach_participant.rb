module FrbParticipants
  class FedachParticipant < Participant
    def self.data
      @@data ||= FrbParticipants::Data.load("fedach-participants.yml")
    end
  end
end
