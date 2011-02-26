class Sc2ranks
  class Portrait < Struct.new(:icon_id,:column,:row)
    def initialize(data)
      Sc2ranks.members_to_string(members).each do |member|
        self[member] = data[member]
      end
    end
  end
end
