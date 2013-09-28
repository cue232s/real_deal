require 'spec_helper'


describe Property do
  before(:each) do
    Property.any_instance.stub(:get_property){Rubillow::Models::DeepSearchResult.new(get_xml('get_deep_search_results.xml'))}
  end

  subject(:single_family_home) { FactoryGirl.create(:property) }

  it "should throw an ArgumentError when not initialized with address" do
    expect{Property.new zipcode: "63112"}.to raise_error { |error| error.should be_a(ArgumentError)}
  end

  it "should throw an ArgumentError when not initialized with zipcode" do
    expect{Property.new address: "1234 Main St." }.to raise_error { |error| error.should be_a(ArgumentError)}
  end

  it "should have a Zillow deep search_result instance" do
    property = FactoryGirl.create(:property)
    property.property.should be_a Rubillow::Models::DeepSearchResult
    p single_family_home

  end

  its(:state) {should == "WA"}
  its(:state)
end
