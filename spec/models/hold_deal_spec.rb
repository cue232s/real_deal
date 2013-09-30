require 'spec_helper'


describe HoldDeal do
  before(:each) do
    Property.any_instance.stub(:get_property){ Rubillow::Models::DeepSearchResult.new(get_xml('get_deep_search_results.xml')) }
  end
  let(:home) {FactoryGirl.create(:property)}
  subject(:deal) { home.hold_deals.create  }

  its(:property_address) {should == home.address}

  it "should calculate its total investment" do
    tot_inv = deal.asking_price - (deal.asking_price.to_f * deal.asking_price_discount.to_f)
    tot_inv += deal.rehab_cost.to_f
    deal.total_investment.should eq tot_inv
  end


  it "should have a rehab_cost" do
    subject.rehab_cost.should eq subject.property.property.finished_square_feet.to_i * subject.rehab_cost_per_sq_ft
  end

  it "should calculate an after repair value" do
    sqft_list = []
    comp_list = [{sqft: 2600 , price: 584400}, {sqft: 1237, price: 301500}, {sqft: 2000 , price: 735300}]#list of 3 comparable properties
    comp_list.each do |comp|
      sqft_list << (comp[:price].to_f / comp[:sqft].to_f)
      #note the .to_f
      # p "+" + comp[:price].to_s
      # p "++" + comp[:sqft].to_s
    end
    arv = sqft_list.inject{ |sum, el| sum + el }.to_f / sqft_list.size #the avg comparable cost per sqft
    est_erv = arv * home.property.finished_square_feet.to_f
    Rubillow::PropertyDetails.stub(:deep_comps) {Rubillow::Models::DeepComps.new(get_xml('get_deep_comps.xml'))}
    deal.calculate_arv.to_f.should eq est_erv
  end

  its(:asking_price) { should eq home.property.price.to_i }
  its(:asking_price_discount) { should eq 0.30 }
  its(:acquisition_price) {should eq (deal.asking_price - (deal.asking_price * deal.asking_price_discount)).to_f }
  its(:total_investment) { should eq deal.acquisition_price + deal.rehab_cost }
  its(:rehab_cost_per_sq_ft) { should eq 30 }
  its(:rehab_cost) { should eq deal.rehab_cost_per_sq_ft.to_f * deal.property_sq_ft.to_f}
end
