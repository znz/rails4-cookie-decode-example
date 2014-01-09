require 'spec_helper'

describe HelloController do

  describe "GET 'world'" do
    it "returns http success" do
      get 'world'
      response.should be_success
    end
  end

end
