require 'pg'

class Specialty
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def self.all
    results = DB.exec("SELECT * FROM specialties;")
    @specialties = []
    results.each do |specialty|
      description = specialty['description']
      @specialties << Specialty.new(description)
    end
    @specialties
  end

  def save
    results = DB.exec("INSERT INTO specialties (description) VALUES ('#{@description}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_specialty)
    self.description == another_specialty.description
  end

end
