module Application
  class << self
    def initialize!
      load_entities
      load_lib
      load_models
      load_helpers
      load_restfuls_v1
      load_routes
      load_validations
      load_comm
      load_patch
      load_api
    end

    private


    def load_entities
      Dir[File.expand_path('../entities/*.rb', __FILE__)].each {|entity| require entity }
    end
    
    def load_models
      Dir[File.expand_path('../../models/*.rb', __FILE__)].each {|model| require model }
    end

    def load_helpers
      Dir[File.expand_path('../helpers/*.rb', __FILE__)].each {|helper| require helper }
    end

    def load_routes
      Dir[File.expand_path('../restfuls/*.rb', __FILE__)].each {|route| require route }
    end

    def load_restfuls_v1
      Dir[File.expand_path('../restfuls/v1/*.rb', __FILE__)].each {|api| require api }
    end


    def load_lib
      Dir[File.expand_path('../../../lib/base_user/*.rb', __FILE__)].each {|lib| require lib }
    end

    def load_validations
      Dir[File.expand_path('../validations/*.rb', __FILE__)].each {|val| require val }
    end

    def load_comm
      require File.expand_path('../comm', __FILE__)
    end

    def load_patch
      require File.expand_path('../patch', __FILE__)
    end

    def load_api
      require File.expand_path('../api', __FILE__)
    end
  end
end

# Initialize Application
Application.initialize!
