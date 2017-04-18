module FrbParticipants
  class Participant
    def self.find_by_routing_number(routing_number)
      participant_attributes = data[routing_number]
      if participant_attributes
        type = participant_attributes.has_key?(:settlement_only) ? :wire : :ach
        normalized_name = FrbParticipants::InstitutionName.find_by_frb_name(participant_attributes[:customer_name])&.normalized_name
        OpenStruct.new(participant_attributes.merge(
          type: type,
          normalized_name: normalized_name,
        ))
      end
    end

    def self.data
      @@participant_data ||= fedwire_data.merge(fedach_data)
    end

    def self.fedwire_data
      @@fedwire_data ||= FrbParticipants::Data.load("fedwire-participants.yml")
    end

    def self.fedach_data
      @@fedach_data ||= FrbParticipants::Data.load("fedach-participants.yml")
    end
  end
end
