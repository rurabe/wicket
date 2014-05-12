require 'spec_helper'
require 'yaml'

module Wicket
  describe SVGPath do

    # examples from test_cases.yml
    YAML.load(File.open("spec/test_cases.yml","r")).each do |title,data|
      wkts = data["wkt"].map{|w| "((#{w}))" }
      context(title) do
        let(:path){ SVGPath.new(data["path"]) }
        it "parses to polygon" do
          expect(path.to_polygon(:curve_tolerance => 3)).to eq("POLYGON#{wkts.first}")
        end

        it "parses to a multipolygon" do
          expect(path.to_multipolygon(:curve_tolerance => 3)).to eq("MULTIPOLYGON(#{wkts.join(",")})")
        end
      end
    end

    it "knows its text" do
      path = SVGPath.new("M10 10 20 20")
      expect(path.text).to eq("M10 10 20 20")
    end

    context "curved paths" do
      let(:path){ SVGPath.new("M0 0,C0 200,200 200,200 0z") }
      let(:wkt){ path.to_polygon(:curve_tolerance => 160) }

      it "contains the vertices" do
        ["0.0 -0.0","200.0 -0.0"].each do |vertex|
          expect(path.to_multipolygon).to include(vertex)
        end
      end

      it "allows you to make a lower resolution curve" do
        expect(path.to_polygon(:curve_tolerance => 150).length).to be < wkt.length
      end

      it "allows you to make a higher resolution curve" do
        expect(path.to_polygon(:curve_tolerance => 175).length).to be > wkt.length
      end
    end
  end
end