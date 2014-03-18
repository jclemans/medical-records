require 'doctor'
require 'spec_helper'

describe Doctor do
  describe 'initialize' do
    it 'is initialized with a name and specialty' do
      test_doctor = Doctor.new('Dr. Leo Spaceman', 'Internal Medicine')
      test_doctor.should be_an_instance_of Doctor
    end
    it 'initializes a new instance of a doctor with a name and specialty' do
      test_doctor = Doctor.new('Dr. Leo Spaceman', 'Internal Medicine')
      test_doctor.name.should eq 'Dr. Leo Spaceman'
      test_doctor.specialty.should eq 'Internal Medicine'
    end
    it 'starts off with no doctors' do
      Doctor.all.should eq []
    end
  end
  describe 'save' do
    it 'lets you save doctors to the database' do
      test_doctor = Doctor.new('Dr. Leo Spaceman', 'Internal Medicine')
      test_doctor.save
      Doctor.all.should eq [test_doctor]
    end
    it 'sets its ID when you save it' do
      test_doctor = Doctor.new('Dr. Leo Spaceman', 'Internal Medicine')
      test_doctor.save
      test_doctor.id.should be_an_instance_of Fixnum
    end
  end
  describe '==(another_doctor)' do
    it 'is the same doctor if they have the same name and specialty' do
      doctor_1 = Doctor.new('Dr. Leo Spaceman', 'Internal Medicine')
      doctor_2 = Doctor.new('Dr. Leo Spaceman', 'Internal Medicine')
      doctor_1.should eq doctor_2
    end
  end
end
