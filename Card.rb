

class Card
  #1. Card: a card is one of the cards of the game. It has two fields: a type and a value.
  #contains a type and a value
  attr_accessor :value, :type
  #getter methods for value and type
  def initialize(type,value)
    @type, @value = type, value

  end
  #initializes type and value

  def to_s () #to_s method to test

    puts(value)
  end

end