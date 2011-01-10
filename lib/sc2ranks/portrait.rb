class Sc2ranks
  class Portrait < Struct.new(:icon_id,:column,:row)
    def initialize(data)
      members.each do |member|
        self[member] = data[member]
      end
    end
  end
end
