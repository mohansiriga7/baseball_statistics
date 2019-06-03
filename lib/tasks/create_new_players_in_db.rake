require 'open-uri'

namespace :create_new_players_in_db do

  desc 'Fetches new players informations from XML and creates in database'
  task :execute => :environment do
    record_type = ENV['RECORD_TYPE']

    #creating players
    create_rows(record_type)
  end

  def create_rows(row_type)
    doc = Nokogiri::XML(open("http://www.cafeconleche.org/examples/baseball/1998statistics.xml"))

    doc.xpath("//#{row_type.upcase}").each_with_index{|parent_elem, parent_count|
      puts "Parent #{parent_count + 1}"
      column_values = Hash.new
      record = get_model_name(row_type).new

      parent_elem.elements.each{|child_elem|
        # Check if the table has the given column or not. We are updating the records with columns which only XML has given.
        if record.respond_to?("#{child_elem.name.downcase}=")
          column_values[child_elem.name.downcase.to_sym] = child_elem.text
        end
      }
      record = get_model_name(row_type).new(column_values)
      record.average = (record.hits / record.at_bats) * 100 unless record.at_bats == 0 || record.at_bats.nil? || record.hits.nil?
      record.stolen_base = record.steals + record.caught_stealing unless record.steals.nil? || record.caught_stealing.nil?

      # Since we don't have total bases and bases on balls information in our xml file, so its unable to On-base plus Slugging(OPs)
      #record.on_base_plus_slugging = calculate_ops(record)
      record.save
    }
  end

  def get_model_name(klass)
    klass.camelize.constantize
  end

  def calculate_ops(record)
    calculate_obp(record) + calculate_slugging(record)
  end

  def calculate_obp(record)
    #Formule to calculate OBP is : (H + BB + HBP) / (AB + BB +SF + HBP)
    # H = hits
    # BB = bases on balls
    # HBP = times hit by pitch
    # AB = at bats
    # SF = sacrifice flies
    # TB = total bases
    # Since we don't have total bases and bases on balls information in our xml file, so its unable to calculate slugging
  end

  def calculate_slugging(record)
    #Formule to calculate SLG is: TB / AB
    # Since we don't have total bases information in our xml file, so its unable to calculate slugging
  end

end


