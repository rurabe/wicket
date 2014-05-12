require 'spec_helper'

module Wicket
  describe Utilities do
    describe "#radians_tolerance" do
      it "raises for 0" do
        expect{Utilities.radians_tolerance(:min_angle => 0)}.to raise_error
        
      end
      context "radians" do
        it "does not convert when implicitly radians" do
          t = Utilities.radians_tolerance(:min_angle => 3)
          expect(t).to eq(3)
        end

        it "does not convert if explicitly set as radians" do
          t = Utilities.radians_tolerance(:min_angle => 3.1, :min_angle_unit => :radians)
          expect(t).to eq(3.1)
        end

        it "does not convert a radian explcitly set but out of range" do
          t = Utilities.radians_tolerance(:min_angle => 0.9, :min_angle_unit => :radians)
          expect(t).to eq(0.9)
        end

        it "raises if over pi" do
          expect{Utilities.radians_tolerance(:min_angle => 4, :min_angle_unit => :radians)}.to raise_error
        end
      end

      context "degrees" do
        it "converts degrees explicitly" do
          t = Utilities.radians_tolerance(:min_angle => 170, :min_angle_unit => :degrees)
          expect(t).to be_within(0.00000001).of(2.96705973)
        end

        it "converts degrees implicitly" do
          t = Utilities.radians_tolerance(:min_angle => 175)
          expect(t).to be_within(0.00000001).of(3.05432619)
        end

        it "converts degrees out of range when explicit" do
          t = Utilities.radians_tolerance(:min_angle => 95, :min_angle_unit => :degrees)
          expect(t).to be_within(0.00000001).of(1.65806279)
        end

        it "raises if over 180" do
          expect{Utilities.radians_tolerance(:min_angle => 190, :min_angle_unit => :degrees)}.to raise_error
        end
      end

      context "percentage" do
        it "converts percentages explicitly" do
          t = Utilities.radians_tolerance(:min_angle => 95, :min_angle_unit => :percentage)
          expect(t).to be_within(0.00000001).of(2.98451302)
        end

        it "converts percentages implicitly" do
          t = Utilities.radians_tolerance(:min_angle => 90)
          expect(t).to be_within(0.00000001).of(2.82743339)
        end

        it "converts percentages out of range when explicit" do
          t = Utilities.radians_tolerance(:min_angle => 2, :min_angle_unit => :percentage)
          expect(t).to be_within(0.00000001).of(0.06283185)
        end

        it "raises if over 100" do
          expect{Utilities.radians_tolerance(:min_angle => 115, :min_angle_unit => :percentage)}.to raise_error
        end
      end


      context "decimal percentage" do
        it "converts decimal percentages explicitly" do
          t = Utilities.radians_tolerance(:min_angle => 0.95, :min_angle_unit => :decimal_percentage)
          expect(t).to be_within(0.00000001).of(2.98451302)
        end

        it "converts decimal percentages implicitly" do
          t = Utilities.radians_tolerance(:min_angle => 0.90)
          expect(t).to be_within(0.00000001).of(2.82743339)
        end

        it "raises if over 1" do
          expect{Utilities.radians_tolerance(:min_angle => 1.15, :min_angle_unit => :decimal_percentage)}.to raise_error
        end
      end
    end
  end
end