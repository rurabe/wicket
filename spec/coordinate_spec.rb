require 'spec_helper'

module Wicket
  describe Coordinate do
    let(:coord){ Coordinate.new(0,0) }

    it "calculates distance" do
      remote = Coordinate.new(3,4)
      expect(coord.distance_to(remote)).to eq(5)
    end
  end
end