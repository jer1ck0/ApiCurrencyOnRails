require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'validation' do
    describe 'params_presented' do
      subject { described_class.new }
      before do
        subject.valid?
      end

      it "should pass if params(email, username, password) empty" do
        expect(subject.errors.full_messages).to include("Email can't be blank") and include("Username can't be blank") and include("Password can't be blank")
      end

      context 'when username & password presented' do
        subject { described_class.new(username: 'DSU', password: "qwerty") }

        it "should fail if password empty" do
          expect(subject.errors.full_messages).to include("Email can't be blank")
        end
      end

      context 'when username & email presented' do
        subject { described_class.new(username: 'DSU', email: "qwe@rty.ru") }

        it "should fail if password empty" do
          expect(subject.errors.full_messages).to include("Password can't be blank")
        end
      end

      context 'when email & password presented' do
        subject { described_class.new(email: "qwe@rty.ru", password: "qwerty") }

        it "should fail if username empty" do
          expect(subject.errors.full_messages).to include("Username can't be blank")
        end
      end
    end  

    describe 'uniquess params' do
      subject { described_class.new(username: "DSU", email: "qwe@rty.ru", password: "qwerty") }
      before do
        subject.save        
        @subject1 = subject.dup
        @subject1.valid?
      end

      after do
        subject.destroy
      end

      it "pass if username & email isn't unique" do
        expect(@subject1.errors.full_messages).to include("Username has already been taken") and include("Email has already been taken")
      end
    end
  end
end
