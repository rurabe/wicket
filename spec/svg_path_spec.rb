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

    context "the kitchen sink of linear paths" do
      let(:path){ SVGPath.new("M293.9214,533.9287l-6.3857-18.1475l3.9316-0.8857l6.0811,17.29L293.9214,533.9287z M287.5356,515.7813V496.5h3.9316v18.3955 L287.5356,515.7813z") }
      it "parses the first subpath to polygon" do
        expect(path.to_polygon).to eq("POLYGON((293.9214 -533.9287,287.5357 -515.7812,291.4673 -514.8955,297.5484 -532.1855,293.9214 -533.9287,293.9214 -533.9287))")
      end

      it "parses both to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((293.9214 -533.9287,287.5357 -515.7812,291.4673 -514.8955,297.5484 -532.1855,293.9214 -533.9287,293.9214 -533.9287)),((287.5356 -515.7813,287.5356 -496.5,291.4672 -496.5,291.4672 -514.8955,287.5356 -515.7813,287.5356 -515.7813)))")
      end
    end

    context "absolute c curves" do
      let(:path){ SVGPath.new("M0 0,C0 200,200 200,200 0z") }
      let(:wkt){ "0.0 -0.0,0.57373046875 -18.1640625,2.24609375 -35.15625,8.59375 -65.625,13.12255859375 -79.1015625,18.45703125 -91.40625,31.25 -112.5,38.56201171875 -121.2890625,46.38671875 -128.90625,54.65087890625 -135.3515625,63.28125 -140.625,72.20458984375 -144.7265625,81.34765625 -147.65625,90.63720703125 -149.4140625,100.0 -150.0,109.36279296875 -149.4140625,118.65234375 -147.65625,127.79541015625 -144.7265625,136.71875 -140.625,145.34912109375 -135.3515625,153.61328125 -128.90625,161.43798828125 -121.2890625,168.75 -112.5,175.47607421875 -102.5390625,181.54296875 -91.40625,191.40625 -65.625,195.05615234375 -50.9765625,197.75390625 -35.15625,200.0 -0.0,0.0 -0.0" }

      it "parses the first subpath to polygon" do
        expect(path.to_polygon).to eq("POLYGON((#{wkt}))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((#{wkt})))")
      end

      it "allows you to make a lower resolution curve" do
        expect(path.to_polygon(:curve_tolerance => 150).length).to be < wkt.length
      end

      it "allows you to make a higher resolution curve" do
        expect(path.to_polygon(:curve_tolerance => 175).length).to be > wkt.length
      end
    end

    context "relative c curves" do
      let(:path){ SVGPath.new("M100 100,c0 200,200 200,200 0z") }
      let(:wkt){ "100.0 -100.0,100.57373046875 -118.1640625,102.24609375 -135.15625,108.59375 -165.625,113.12255859375 -179.1015625,118.45703125 -191.40625,131.25 -212.5,138.56201171875 -221.2890625,146.38671875 -228.90625,154.65087890625 -235.3515625,163.28125 -240.625,172.20458984375 -244.7265625,181.34765625 -247.65625,190.63720703125 -249.4140625,200.0 -250.0,209.36279296875 -249.4140625,218.65234375 -247.65625,227.79541015625 -244.7265625,236.71875 -240.625,245.34912109375 -235.3515625,253.61328125 -228.90625,261.43798828125 -221.2890625,268.75 -212.5,275.47607421875 -202.5390625,281.54296875 -191.40625,291.40625 -165.625,295.05615234375 -150.9765625,297.75390625 -135.15625,300.0 -100.0,100.0 -100.0" }

      it "parses the first subpath to polygon" do
        expect(path.to_polygon).to eq("POLYGON((#{wkt}))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((#{wkt})))")
      end

      it "allows you to make a lower resolution curve" do
        path = SVGPath.new("M0 0,c0 200,200 200,200 0z")
        expect(path.to_polygon(:curve_tolerance => 150).length).to be < wkt.length
      end

      it "allows you to make a higher resolution curve" do
        path = SVGPath.new("M0 0,c0 200,200 200,200 0z")
        expect(path.to_polygon(:curve_tolerance => 175).length).to be > wkt.length
      end
    end

    context "relative c curves" do
      let(:path){ SVGPath.new("M100 100,c0 200,200 200,200 0z") }
      let(:wkt){ "100.0 -100.0,100.57373046875 -118.1640625,102.24609375 -135.15625,108.59375 -165.625,113.12255859375 -179.1015625,118.45703125 -191.40625,131.25 -212.5,138.56201171875 -221.2890625,146.38671875 -228.90625,154.65087890625 -235.3515625,163.28125 -240.625,172.20458984375 -244.7265625,181.34765625 -247.65625,190.63720703125 -249.4140625,200.0 -250.0,209.36279296875 -249.4140625,218.65234375 -247.65625,227.79541015625 -244.7265625,236.71875 -240.625,245.34912109375 -235.3515625,253.61328125 -228.90625,261.43798828125 -221.2890625,268.75 -212.5,275.47607421875 -202.5390625,281.54296875 -191.40625,291.40625 -165.625,295.05615234375 -150.9765625,297.75390625 -135.15625,300.0 -100.0,100.0 -100.0" }

      it "parses the first subpath to polygon" do
        expect(path.to_polygon).to eq("POLYGON((#{wkt}))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((#{wkt})))")
      end

      it "allows you to make a lower resolution curve" do
        path = SVGPath.new("M0 0,c0 200,200 200,200 0z")
        expect(path.to_polygon(:curve_tolerance => 150).length).to be < wkt.length
      end

      it "allows you to make a higher resolution curve" do
        path = SVGPath.new("M0 0,c0 200,200 200,200 0z")
        expect(path.to_polygon(:curve_tolerance => 175).length).to be > wkt.length
      end
    end

    context "a complex curve" do
      let(:path){ SVGPath.new("M889.9277,494.0005c0,12.1528-0.8057,23.9614-2.3066,35.4341h10.1104 c1.4434-11.4824,2.1963-23.2969,2.1963-35.4341s-0.7529-23.9526-2.1963-35.4351h-10.1104 C889.1221,470.0381,889.9277,481.8467,889.9277,494.0005z") }
      let(:wkt) { "889.9277 -494.0005,889.3372375 -511.9725875,887.6211 -529.4346,897.7315 -529.4346,899.370925 -511.9631,899.9278 -494.0005,899.370925 -480.5888875,897.7315 -458.5654,887.6211 -458.5654,889.337275 -476.0275375,889.9277 -494.0005,889.9277 -494.0005" }

      it "contains the same vertices" do
        ["889.9277 -494.0005","887.6211 -529.4346","897.7315 -529.4346","899.9278 -494.0005","897.7315 -458.5654","887.6211 -458.5654","889.9277 -494.0005"].each do |vertex|
          expect(path.to_multipolygon).to include(vertex)
        end
      end

      it "parses to a polygon" do
        expect(path.to_polygon).to eq("POLYGON((#{wkt}))")
      end

      it "parses to a multipolygon" do
        expect(path.to_multipolygon).to eq("MULTIPOLYGON(((#{wkt})))")
      end
    end
  end
end