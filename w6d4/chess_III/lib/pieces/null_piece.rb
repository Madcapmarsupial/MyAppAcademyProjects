require 'singleton'

class Nullpiece < Piece
    include Singleton
    def initialize
        #@color = ""
        
        #super
    end

    

   def symbol
       return :" "
   end

    def color
        "empty color"
    end


end