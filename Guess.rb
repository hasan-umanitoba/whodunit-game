

class Guess

  #consists of three cards and a boolean variable
  #the names of fields should be person place and weapon

  attr_accessor :person , :place , :weapon, :accusation
  #using ruby symbols to define the type of card
  def initialize(person,place,weapon,accusation)
    #The names of the fields should be "person", "place" and "weapon".
    @person = person
    @place = place
    @weapon = weapon
    @accusation = accusation
    #  initializers that accept the required information.
  end

  def isAccusation() #used in TestPlayer :
    #if its an accusation it is true

    booleanVal = false

    if @accusation == true
      booleanVal = true

    end

    booleanVal
  end

  def to_s () # toString method for guess // either its a Suggestion or an Accusation

    string =nil
    if @accusation== false
      string = ("Suggestion: #{@person.value} in #{@place.value} with the #{@weapon.value}.")
    else
      string= ("Accusation: #{@person.value} in #{@place.value} with the #{@weapon.value}.")

    end

    string
  end

end