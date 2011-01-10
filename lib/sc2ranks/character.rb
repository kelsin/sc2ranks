class Sc2ranks
  class Character
    attr_reader :region
    attr_reader :name
    attr_reader :bnet_id
    attr_reader :id
    attr_reader :updated_at
    attr_reader :achievement_points
    attr_reader :character_code
    attr_reader :portrait
    attr_reader :teams

    def initialize(http)
      @region = http['region']
      @name = http['name']
      @bnet_id = http['bnet_id']
      @id = http['id']
      @updated_at = http['updated_at']
      @achievement_points = http['achievement_points']
      @character_code = http['character_code']

      @portrait = Portrait.new(http['portrait'])

      @teams = []
      http['teams'].each do |data|
        @teams << Team.new(data)
      end
    end

    def team(bracket, is_random = false)
      if bracket == 1
        @teams.detect do |team|
          team.bracket == 1
        end
      else
        @teams.select do |team|
          team.bracket == bracket and team.is_random == is_random
        end
      end
    end

    class Team
      attr_reader :bracket
      attr_reader :is_random
      attr_reader :fav_race
      attr_reader :updated_at
      attr_reader :league
      attr_reader :division
      attr_reader :division_rank
      attr_reader :world_rank
      attr_reader :region_rank
      attr_reader :wins
      attr_reader :losses
      attr_reader :points
      attr_reader :ratio

      def initialize(http)
        @bracket = http['bracket']
        @is_random = http['is_random']
        @fav_race = http['fav_race']
        @updated_at = http['updated_at']
        @league = http['league']
        @division = http['division']
        @division_rank = http['division_rank']
        @world_rank = http['world_rank']
        @region_rank = http['region_rank']
        @wins = http['wins']
        @losses = http['losses']
        @points = http['points']
        @ratio = http['ratio']
      end

      def is_random?
        @is_random
      end
    end

    class Portrait
      attr_reader :icon_id
      attr_reader :column
      attr_reader :row

      def initialize(http)
        @icon_id = http['icon_id']
        @column = http['column']
        @row = http['row']
      end
    end
  end
end
