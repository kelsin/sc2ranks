class Sc2ranks
  class Match < Struct.new(:map, :type, :outcome, :date)
    def initialize(data)
      Sc2ranks.members_to_string(members).each do |member|
        self[member] = data[member]
      end
    end

    def win?
      outcome == :win
    end
    
    def self.all(bnet_url)
      uri = URI.parse(bnet_url + 'matches')
      response = Net::HTTP.get_response(uri)
      puts uri
    end
  end
end
