class Sc2ranks
  class Team < Struct.new(:bracket,:is_random,:fav_race,:updated_at,:league,:division,:division_rank,:world_rank,:region_rank,:wins,:losses,:points,:ratio)
    def initialize(data)
      Sc2ranks.members_to_string(members).each do |member|
        self[member] = data[member]
      end
    end

    alias :is_random? :is_random
  end
end
