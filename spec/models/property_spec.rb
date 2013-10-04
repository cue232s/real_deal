require 'spec_helper'


describe Property do
  context "With good address" do
    before(:each) do
      Property.any_instance.stub(:get_property){Rubillow::Models::DeepSearchResult.new(get_xml('get_deep_search_results.xml'))}
      Property.any_instance.stub(:get_updated_property_details){ Rubillow::Models::UpdatedPropertyDetails.new(get_xml('get_updated_property_details.xml'))}
    end

    subject(:single_family_home) { FactoryGirl.create(:property) }

    its(:address) { should == "2114 Bigelow Ave N"}
    its(:zipcode) {should == "98109"}
    its(:state)   {should == "WA"}
    its(:state)   {should_not be nil }
    its("updated_property_details") { should be_a Rubillow::Models::UpdatedPropertyDetails }
    its("updated_property_details.code") { should eq 0 }

    it "should throw an ArgumentError when not initialized with address" do
      expect{Property.new zipcode: "63112"}.to raise_error { |error| error.should be_a(ArgumentError)}
    end

    it "should throw an ArgumentError when not initialized with zipcode" do
      expect{Property.new address: "1234 Main St." }.to raise_error { |error| error.should be_a(ArgumentError)}
    end

    it "should have a Zillow deep search_result instance" do
      property = FactoryGirl.create(:property)
      property.property.should be_a Rubillow::Models::DeepSearchResult
    end

    context "When UPD is updated with a price" do
      its("updated_property_details.message") { should eq "Request successfully processed" }
      it "should have a price[:code] of 0" do
        subject.updated_property_details.price[:code].should eq 0
      end

    end
  end
end
