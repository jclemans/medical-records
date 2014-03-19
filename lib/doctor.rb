require 'pg'
require 'pry'

class Doctor
  attr_reader :name, :id, :specialty_id, :description

  def initialize(name, specialty_id=nil)
    @name = name
    @specialty_id  = specialty_id
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |doctor_instance|
      name = doctor_instance['name']
      specialty_id = doctor_instance['specialty_id'].to_i
      doctors << Doctor.new(name, specialty_id)
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', '#{@specialty_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name && self.specialty_id == another_doctor.specialty_id
  end

  def get_specialty(specialty_id)
    results = DB.exec("SELECT * FROM specialties WHERE id = #{specialty_id};") #need to get description out of this
    @description = results.first['description']
  end
end
