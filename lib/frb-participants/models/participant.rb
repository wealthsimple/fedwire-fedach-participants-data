module FrbParticipants
  class Participant
    def self.find_by_routing_number(routing_number)
      participant_attributes = data[routing_number]
      OpenStruct.new(participant_attributes)  if participant_attributes
    end
  end
end
