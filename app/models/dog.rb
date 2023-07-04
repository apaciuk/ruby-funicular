require_relative './base.rb'

class Dog < Base
    attr_accessor :name, :breed, :id
    def initialize(name: nil, breed: nil, id: nil)
        @name = name
        @breed = breed
        @id = id
    end 
end