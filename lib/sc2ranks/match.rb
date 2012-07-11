class Sc2ranks
  class Match < Struct.new(:map, :type, :outcome, :date)
    def initialize(data)
      Sc2ranks.members_to_string(members).each do |member|
        self[member] = data[member.to_sym]
      end
    end

    def win?
      outcome == :win
    end
    
    def self.all(bnet_url)
      uri = URI.parse(bnet_url + 'matches')
      response = Net::HTTP.get_response(uri)
      doc = Nokogiri::HTML(response.body)
      rows = doc.css('.match-row')
      rows.collect do |row|
        match = {}
        [
          [:map, 'td[2]/text()'],
          [:type, 'td[3]/text()'],
          [:outcome, 'td[4]/span/text()', [:downcase, :to_sym]],
          [:date, 'td[5]/text()', :to_date]
        ].each do |name, xpath, methods|
          match[name] = row.at_xpath(xpath).to_s.strip
          unless methods.nil?
            Array(methods).each do |method|
              match[name] = match[name].send(method)
            end
          end
        end
        self.new(match) # return the match
      end
    end
  end
end
