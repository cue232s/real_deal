module Rubillow
  module Models

   class UpdatedPropertyDetails < Base
      def parse
              super
              
              return if !success?
              
              extract_zpid(@parser)
              extract_links(@parser)
              extract_address(@parser)
              extract_images(@parser)
              
              @page_views = {
                :current_month => @parser.xpath('//pageViewCount/currentMonth').first.text,
                :total => @parser.xpath('//pageViewCount/total').first.text
              }
              puts @parser.xpath
              # @price = @parser.xpath('//price').first.text
              # @neighborhood = @parser.xpath('//neighborhood').first.text
              # @school_district = @parser.xpath('//schoolDistrict').first.text
              # @elementary_school = @parser.xpath('//elementarySchool').first.text
              # @middle_school = @parser.xpath('//middleSchool').first.text
              # @home_description = @parser.xpath('//homeDescription').first.text
              
              # @posting = {}
              @parser.xpath('//posting').children.each do |elm|
                @posting[underscore(elm.name).to_sym] = elm.text
              end
              
              @edited_facts = {}
              @parser.xpath('//editedFacts').children.each do |elm|
                @edited_facts[underscore(elm.name).to_sym] = elm.text
              end
            end
         end

       end

end