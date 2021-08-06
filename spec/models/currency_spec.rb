require 'rails_helper'

RSpec.describe Currency, type: :model do
  
  context 'validation' do
    describe 'params_presented' do
      subject { described_class.new }
      before do
        subject.valid?
      end

      it "should pass if params empty" do
        expect(subject.errors.full_messages).to include("Rate can't be blank") and include("Name can't be blank")
      end

      context 'when name presented' do
        subject { described_class.new(name: 'DSU') }

        it "should fail if rate empty" do
          expect(subject.errors.full_messages).to include("Rate can't be blank")
        end
      end

      context 'when rate presented' do
        subject { described_class.new(rate: 0) }

        it "should fail if name empty" do
          expect(subject.errors.full_messages).to include("Name can't be blank")
        end
      end
    end  

    describe 'uniquess params' do
      subject { described_class.new(name: "DSU", rate: 0) }
      before do
        subject.save
      end

      after do
        subject.destroy
      end

      it "pass if name isn't unique" do
        expect(Currency.new(name: subject.name, rate: 0)).not_to be_valid
      end
    end  
  end
end
