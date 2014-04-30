require 'spec_helper'

module Wicket
  describe SVGPath do
    let(:path){ SVGPath.new("M10 10 20 20") }

    it "knows its text" do
      expect(path.text).to eq("M10 10 20 20")
    end

    context "absolute h shortcuts" do
      let(:path){ SVGPath.new("M10 10H20l10 10H10z") }
      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((10.0 -10.0,20.0 -10.0,30.0 -20.0,10.0 -20.0,10.0 -10.0))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((10.0 -10.0,20.0 -10.0,30.0 -20.0,10.0 -20.0,10.0 -10.0)))")
      end
    end

    context "relative h shortcuts" do
      let(:path){ SVGPath.new("M10 10h20h10l10 10h-10z") }
      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0)))")
      end
    end

    context "absolute h shortcuts" do
      let(:path){ SVGPath.new("M10 10l20 20V50V80z") }
      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((10.0 -10.0,30.0 -30.0,30.0 -50.0,30.0 -80.0,10.0 -10.0))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((10.0 -10.0,30.0 -30.0,30.0 -50.0,30.0 -80.0,10.0 -10.0)))")
      end
    end

    context "relative h shortcuts" do
      let(:path){ SVGPath.new("M10 10h20h10l10 10h-10z") }
      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0)))")
      end
    end

    context "single subpath, manually closed, no explicit commands" do
      let(:path){ SVGPath.new("M197.5977 356.0957 227.0786 325.3271 229.667 328.4067 200.8188 358.5156 197.5977 356.0957") }

      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((197.5977 -356.0957,227.0786 -325.3271,229.667 -328.4067,200.8188 -358.5156,197.5977 -356.0957))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((197.5977 -356.0957,227.0786 -325.3271,229.667 -328.4067,200.8188 -358.5156,197.5977 -356.0957)))")
      end
    end

    context "single subpath, z closed, no explicit commands" do
      let(:path){ SVGPath.new("M227.1177 371.5405 247.7852 349.9634 250.373 353.0425 230.2959 374.0044 z") }

      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((227.1177 -371.5405,247.7852 -349.9634,250.373 -353.0425,230.2959 -374.0044,227.1177 -371.5405))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((227.1177 -371.5405,247.7852 -349.9634,250.373 -353.0425,230.2959 -374.0044,227.1177 -371.5405)))")
      end
    end


    context "single subpath, z closed, no explicit commands" do
      let(:path){ SVGPath.new("M227.1177 371.5405 247.7852 349.9634 250.373 353.0425 230.2959 374.0044 z") }

      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((227.1177 -371.5405,247.7852 -349.9634,250.373 -353.0425,230.2959 -374.0044,227.1177 -371.5405))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((227.1177 -371.5405,247.7852 -349.9634,250.373 -353.0425,230.2959 -374.0044,227.1177 -371.5405)))")
      end
    end

    context "single subpath, z closed, relative and absolute commands" do
      let(:path){ SVGPath.new("M722.3984,688.502L710,693.5693l-1.8115-3.5811l12.3096-5.0313L732.3984,688.502z") }

      it "parses to polygon" do
        expect(path.to_polygon).to eq("POLYGON((722.3984 -688.502,710.0 -693.5693,708.1885 -689.9882,720.4981 -684.9569,732.3984 -688.502,722.3984 -688.502))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((722.3984 -688.502,710.0 -693.5693,708.1885 -689.9882,720.4981 -684.9569,732.3984 -688.502,722.3984 -688.502)))")
      end
    end

    context "two subpaths, z closed, no explicit commands" do
      let(:path){ SVGPath.new("M227.1177 371.5405 247.7852 349.9634 250.373 353.0425 230.2959 374.0044 z M197.5977 356.0957 227.0786 325.3271 229.667 328.4067 200.8188 358.5156 197.5977 356.0957") }

      it "parses the first subpath to polygon" do
        expect(path.to_polygon).to eq("POLYGON((227.1177 -371.5405,247.7852 -349.9634,250.373 -353.0425,230.2959 -374.0044,227.1177 -371.5405))")
      end

      it "parses both to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((227.1177 -371.5405,247.7852 -349.9634,250.373 -353.0425,230.2959 -374.0044,227.1177 -371.5405)),((197.5977 -356.0957,227.0786 -325.3271,229.667 -328.4067,200.8188 -358.5156,197.5977 -356.0957)))")
      end
    end
  end
end