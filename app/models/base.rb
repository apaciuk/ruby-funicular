require 'pstore'

class Base
  DB_FILE = File.expand_path("../../../db.pstore", __FILE__)

    module ClassMethods 
         # Find a record by ID
        def find(id) 
             db.transaction(true) do # read-only transaction
                db[derive_db_id(self.name, id)] 
             end
        end 

        # Returns all records for this model
        def all 
            db.transaction(true) do 
               ids = extract_model_ids(db) 
               ids.map { |key| db[key] } 
            end
        end 

        # Store an instance in the DB 
        def save(object) 
            db_id = derive_db_id(object.class.name, object.id) 
            db.transaction do 
                db[db_id] = object 
            end
        end 

        # Scoped by class, to auto-increment the IDs 
        def next_available_id 
            last_id = all_ids.map do |key| 
            key.sub("#{self.name}_", "").to_i
            end.max.to_i

            last_id + 1
        end 

        private 
        
        # Accessor for the PStore database
        def db
            @db ||= PStore.new(DB_FILE)
        end

        # Scoped by class, so that different model classes can have the same numerical IDs 
        def derive_db_id(model_name, obj_id) 
            "#{model_name}_#{obj_id}" 
        end 

        # Extracts the IDs for all records of a given model
        def all_ids
            db.transaction(true) do |db|
                extract_model_ids(db)
            end
        end 

        # Get all the PStore root keys (the DB IDs) scoped for the current class 

        def extract_model_ids(store) 
            store.roots.select do |key| 
                key.start_with?("#{self.name}_") 
            end
        end 

    end 
    extend ClassMethods

    def save 
       ensure_presence_of_id 
       self.class.save(self) 
    end 

    private

    def ensure_presence_of_id
        self.id ||= self.class.next_available_id
    end

end