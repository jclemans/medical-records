require 'spec_helper'
require 'specialty'

describe Specialty do
  describe 'initialize' do
    it 'is initialized with a description and doctor ID' do
      specialty = Specialty.new('Pathology', 1)
      specialty.should be_an_instance_of Specialty
    end
    it 'gives the description of each instance of Specialty' do
      specialty = Specialty.new('Pathology', 1)
      specialty.description.should eq 'Pathology'
      specialty.doctor_id.should eq 1
    end
    it 'starts off with nothing stored' do
      Specialty.all.should eq []
    end
  end

  describe 'save' do
    it 'saves each instance of specialty to the database' do
      specialty = Specialty.new('Pathology', 1)
      specialty.save
      Specialty.all.should eq [specialty]
    end
  end
  describe '==(another_specialty)' do
    it "is the same specialty if they have the same description" do
      specialty_1 = Specialty.new("Pathology", 1)
      specialty_1.save
      specialty_2 = Specialty.new("Pathology", 2)
      specialty_2.save
      specialty_1.should eq specialty_2
    end
  end
end
