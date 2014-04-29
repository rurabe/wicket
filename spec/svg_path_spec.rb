require 'spec_helper'

module Wicket
  describe SVGPath do

    context "single subpath, manually closed, no explicit commands" do
      let(:path){ SVGPath.new("M197.5977 356.0957 227.0786 325.3271 229.667 328.4067 200.8188 358.5156 197.5977 356.0957") }

      it "knows its text" do
        expect(path.text).to eq("M197.5977 356.0957 227.0786 325.3271 229.667 328.4067 200.8188 358.5156 197.5977 356.0957")
      end

      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((197.5977 -356.0957,227.0786 -325.3271,229.667 -328.4067,200.8188 -358.5156,197.5977 -356.0957))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((197.5977 -356.0957,227.0786 -325.3271,229.667 -328.4067,200.8188 -358.5156,197.5977 -356.0957)))")
      end
    end
  end
end