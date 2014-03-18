require 'pg'
require 'pry'

class Doctor
  attr_reader :name, :specialty, :id

  def initialize(name, specialty)
    @name = name
    @specialty = specialty
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |doctor_instance|
      name = doctor_instance['name']
      specialty = doctor_instance['specialty']
      doctors << Doctor.new(name, specialty)
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialty == another_doctor.specialty
  end
end
