require 'pg'

class Patient
  attr_reader :name, :birthdate, :doctor_id

  def initialize(name, birthdate, doctor_id)
    @name = name
    @birthdate = birthdate
    @doctor_id = doctor_id
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |patient_instance|
      name = patient_instance['name']
      birthdate = patient_instance['birthdate']
      doctor_id = patient_instance['doctor_id'].to_i
      patients << Patient.new(name, birthdate, doctor_id)
    end
    patients
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthdate, doctor_id) VALUES ('#{name}', '#{birthdate}', '#{doctor_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_patient)
    self.name == another_patient.name && self.birthdate == another_patient.birthdate
  end
end
