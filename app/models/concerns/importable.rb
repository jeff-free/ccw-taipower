module Importable 
  extend ActiveSupport::Concern

  included do
    attr_accessor :file
  end

  class_methods do
    def import
      true
    end
  end
end
