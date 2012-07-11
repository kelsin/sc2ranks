require 'sc2ranks/team'
require 'sc2ranks/match'
require 'sc2ranks/portrait'

class Sc2ranks
  class Character < Struct.new(:name, :bnet_url, :bnet_id, :id, :region, :updated_at, :achievement_points, :character_code, :portrait, :teams, :matches)
    def initialize(url, data)
      self.bnet_url = url
      
      new_members = Sc2ranks.members_to_string(members)

      (new_members - ['bnet_url']).each do |member|
        case member
        when 'portrait'
          self.portrait = Portrait.new(data[member])
        when 'teams'
          self.teams = []

          data['teams'].each do |team|
            self.teams << Team.new(team)
          end
        when 'matches'
          self.matches = Match.all(bnet_url)

          data['matches'].each do |match|
            self.matches << Match.new(match)
          end
        else
          self[member] = data[member]
        end
      end
    end

    # Look up a team via bracket number and is_random setting. If you are trying
    # to find the user's 1v1 team or a random team this will return the Team
    # object or nil. If you are looking for 2's, 3's or 4's this will return an
    # array of teams (or an empty array if their are none).
    def team(bracket, is_random = false)
      if bracket == 1 or is_random
        self.teams.detect do |team|
          team.bracket == bracket and team.is_random == is_random
        end
      else
        self.teams.select do |team|
          team.bracket == bracket and team.is_random == is_random
        end
      end
    end
  end
end
