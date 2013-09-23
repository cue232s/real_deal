require 'spec_helper'


describe HoldDeal do
  before(:each) do
    Property.any_instance.stub(:get_property){Rubillow::Models::DeepSearchResult.new(get_xml('get_deep_search_results.xml'))}
    @property = FactoryGirl.create(:property)
    @deal = @property.hold_deals.create 
  end

  it "should have a property address" do 
    @deal.property_address.should eq @property.address
  end

  it "should calculate its total investment" do
    @deal.total_investment.should eq (@deal.property.property.finished_square_feet.to_i * 30 + @deal.asking_price).to_i
  end

  it "should have a rehab_cost" do
    @deal.rehab_cost.should eq @deal.property.property.finished_square_feet.to_i * @deal.rehab_cost_per_sq_ft
  end

  it "should calculate an after repair value" do
    Rubillow::PropertyDetails.stub(:deep_comps) {Rubillow::Models::DeepComps.new(get_xml('get_deep_comps.xml'))}
    p @deal.calculate_arv.to_i
  end

  its(:asking_price) {should eq 1}
  # it "should have a Zillow deep search_result instance" do
  #   property = FactoryGirl.create(:property)
  #   property.property.should be_a Rubillow::Models::DeepSearchResult
  # end


end