require "nokogiri"
require "open-uri"

namespace :update_db do
    desc "Update values from central bank data"
    task :sync_with_cb => :environment do
      url = 'http://www.cbr.ru/scripts/XML_daily.asp'
      doc = Nokogiri::XML(open(url))
      valutes = doc.xpath("ValCurs").children
      valutes.each do |elem|
        cur_name = elem.search("CharCode").text
        cur_rate = elem.search("Value").text.to_f/elem.search("Nominal").text.to_i
        cur_curency = Currency.find_by_name(cur_name)
        if cur_curency.nil?
          cur_curency = Currency.new(name: cur_name, rate: cur_rate)
          cur_curency.save
        else
          cur_curency.rate = cur_rate
          cur_curency.save
        end
      end
    end
  end