require 'spec_helper'


describe Property do
  before(:each) do
    Property.any_instance.stub(:get_property){Rubillow::Models::DeepSearchResult.new(get_xml('get_deep_search_results.xml'))}
    Property.any_instance.stub(:get_updated_property_details){ Rubillow::Models::UpdatedPropertyDetails.new(get_xml('get_updated_property_details.xml'))}
  end

  it "should throw an ArgumentError when initialized without an address" do
    expect{Property.new zipcode: "63112"}.to raise_error { |error| error.should be_a(ArgumentError)}
  end

  it "should throw an ArgumentError when nitialized without a zipcode" do
    expect{Property.new address: "1234 Main St." }.to raise_error { |error| error.should be_a(ArgumentError)}
  end
  context "With good address" do

    subject(:single_family_home) { FactoryGirl.create(:property) }

    its(:address) { should == "2114 Bigelow Ave N"}
    its(:zipcode) {should eq "98109"}
    its(:state)   {should eq "WA"}
    its(:state)   {should_not be nil }
    its(:property) {should be_a Rubillow::Models::DeepSearchResult }
    its(:updated_property_details) { should be_a Rubillow::Models::UpdatedPropertyDetails }
    its("updated_property_details.code") { should eq 0 }
    its("property.price") { should eq "1032000"}
    its("property.use_code") { should eq "SingleFamily"}
    its("property.last_sold_date") { should eq "Wed, 26 Nov 2008"}
    its("property.last_sold_price") { should eq "1025000"}


    context "When UPD is updated with a price" do
      its("updated_property_details.message") { should eq "Request successfully processed" }
      its("updated_property_details.price.code") { should eq 0 }
      its("updated_property_details.price.price") { should eq "1290000" }
    end

    context "When UPD does not have a price nor a zestimate" do
      before(:each) do
        Property.any_instance.stub(:get_updated_property_details){ Rubillow::Models::UpdatedPropertyDetails.new(get_xml('get_updated_property_details_without_price.xml'))}
      end
      its("updated_property_details.price.message") { should eq "No price available on this" }
      its("updated_property_details.price.code") { should eq -1 }
      its("updated_property_details.price.price") { should eq nil }

    end
  end
end
