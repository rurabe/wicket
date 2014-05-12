require 'spec_helper'

module Wicket
  describe Coordinate do
    let(:coord){ Coordinate.new(3,4) }
    let(:remote){ Coordinate.new(0,0) }

    it "calculates distance" do
      expect(coord.distance_to(remote)).to eq(5)
    end

    it "absolutizes" do
      ab = coord.absolutize(2,-4)
      expect(ab.x).to eq(5)
      expect(ab.y).to eq(0)
    end

    it "relativizes" do
      expect(coord.relativize(remote)).to eq([-3,-4])
    end

    it "reflects" do
      reflection = coord.reflect(remote)
      expect(reflection.x).to eq(6)
      expect(reflection.y).to eq(8)       
    end
  end
end