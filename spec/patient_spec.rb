require 'patient'
require 'spec_helper'

describe Patient do
  describe 'initialize' do
    it 'is initialized with a name, birthdate, and associated doctor id' do
      test_patient = Patient.new('Rust Cole', '1975-05-23', 1)
      test_patient.should be_an_instance_of Patient
    end
    it 'gives you the name, birthdate, and associated doctor id of each instance' do
      test_patient = Patient.new('Rust Cole', '1975-05-23', 1)
      test_patient.name.should eq 'Rust Cole'
      test_patient.birthdate.should eq '1975-05-23'
      test_patient.doctor_id.should eq 1
    end
    it 'starts off with no patients' do
      Patient.all.should eq []
    end
  end
  describe 'save' do
    it 'lets you save an instance of Patient to the database' do
      test_patient = Patient.new('Rust Cole', '1975-05-23', 1)
      test_patient.save
      Patient.all.should eq [test_patient]
    end
    it 'sets its ID when you save it' do
      test_patient = Patient.new('Rust Cole', '1975-05-23', 1)
      test_patient.save
      test_patient.p_id.should be_an_instance_of Fixnum
    end
  end
  describe '==(another_patient)' do
    it 'is the same patient if they have the same name, b-day' do
      patient_1 = Patient.new('Rust Cole', '1975-05-23', 1)
      patient_2 = Patient.new('Rust Cole', '1975-05-23', 1)
      patient_1.should eq patient_2
    end
  end

end


