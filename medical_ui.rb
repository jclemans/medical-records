require 'pg'
require './lib/doctor'
require './lib/patient'
require './lib/specialty'

DB = PG.connect({:dbname => 'medical_records'})

def main_menu

  puts "Welcome to the Doctor Assistant 2k\n"
  puts "Enter 'P' to add a new patient, or 'D' to add a new doctor"
  puts "Enter 'L' to list all patients, 'S' to show all doctors, or 'B' to browse by specialty."
  puts "Enter 'X' to eXit."
  choice = gets.chomp.upcase
  case choice
  when 'P'
    add_patient
  when 'D'
    add_doctor
  when 'L'
    list_patients
  when 'S'
    show_doctors
  when 'B'
    browse_specialty
  when 'X'
    exit
  else
    puts 'Invalid entry, try again.'
    main_menu
  end
end

def add_patient
  puts "Enter patient name (First Last):"
  name = gets.chomp
  puts "Enter patient birthdate (YYYY-MM-DD):"
  birthdate = gets.chomp
  puts "Enter your doctor ID number. Please contact the IT department if you forgot it."
  doctor_id = gets.chomp.to_i

  new_patient = Patient.new(name, birthdate, doctor_id)
  new_patient.save
  puts "Patient #{name} has been added with ID # #{@p_id}."
  main_menu
end

def add_doctor
  puts "Enter your name (First Last):"
  dr_name = gets.chomp
  dr_name = "Dr. " + dr_name
  puts "Enter your specialty:"
  specialty = gets.chomp
  new_doctor = Doctor.new(dr_name, specialty)
  new_doctor.save
  puts "Thank you, #{dr_name}. You have been added to the system with ID # #{@id}."
  main_menu
end

def list_patients
  list_of_patients = []
  Patient.all.each_with_index do |patient, index|
    p_name = patient.name
    p_bday = patient.birthdate
    list_of_patients << "#{index + 1}. #{p_name}, #{p_bday}"
  end
  puts list_of_patients
  puts "\n\n"
  main_menu
end

def show_doctors
  list_of_doctors = []
  Doctor.all.each_with_index do |doctor, index|
    d_name = doctor.name
    d_specialty = doctor.specialty
    list_of_doctors << "#{index + 1}. #{d_name}, #{d_specialty}"
  end
  puts "\n"
  puts list_of_doctors
  puts "\n\n"
  main_menu
end

def browse_specialty
  list_of_specialties =[]
  Specialty.all.each_with_index do |specialty, index|
    description = specialty.description
    list_of_specialties << "#{index + 1}. #{description}"
  end
  puts list_of_specialties
  puts "Please select the number of the specialty to see a list of doctors in that specialty:"
  choice = gets.chomp.to_i
  doctor_list = Doctor.all.select do |doctor|
    doctor.specialty_id = choice
  end
  doctor_list
  main_menu
end

main_menu
