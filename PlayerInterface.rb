

class PlayerInterface # is at the top of hierarchy of Players
  #Makes Sure players implement all of the required methods
  #else it will raise an error
  # it will also restrict this Class's instance to be made
  def initialize #initialize method
    raise NotImplementedError.
    new("#{self.class.name} is an abstract class.")
  end

  def setup #setup method for setting player
    raise NotImplementedError.
    new("#{self.class.name}setup is an abstract method")
  end

  def setCard  #makes sure player gets a card
    raise NotImplementedError.
    new("#{self.class.name} setCard is an abstract method")
  end

  def canAnswer  # if a player can answer the guess
    raise NotImplementedError.
    new("#{self.class.name} canAnswer is an abstract method")
  end

  def getGuess # makes a guess based on choices
    raise NotImplementedError.
    new("#{self.class.name}getGuess is an abstract method")
  end

  def receiveInfo #gets info and makes deductions based on information
    raise NotImplementedError.
    new("#{self.class.name}receive info is an abstract method")
  end

end

