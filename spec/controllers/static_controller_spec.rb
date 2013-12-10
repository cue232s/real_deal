require 'spec_helper'

describe StaticController do

  describe "GET 'dealView'" do
    it "returns http success" do
      get 'dealView'
      response.should be_success
    end
  end

end
