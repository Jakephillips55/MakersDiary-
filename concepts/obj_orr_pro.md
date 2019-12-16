#this is a copy of the following blog post
# https://medium.com/launch-school/the-basics-of-oop-ruby-26eaa97d2e98 

Ruby is an object-oriented programming language (OOP) that uses classes as blueprints for objects. Objects are the basic building-blocks of Ruby code (everything in Ruby is an object), and have two main properties: states and behaviours. Ruby classes are the blueprints that establish what attributes (also known as states) and behaviours (known in Ruby as methods) that an object should have.
Let’s back up and clarify what exactly OOP is:
OOP is a type of computer programming language that arose as a solution and response to bigger and more complex code. Although a complete history is beyond the scope of this article, the main takeaway is that OOP principles have been around since the 1950’s-1960’s, but really began to dominate the programming world in the 1990’s and continues to do so today (Wikipedia). Abstraction, polymorphism, inheritance and encapsulation form four of the main pillars of OOP. The acronym “A PIE” is a helpful mnemonic to remember them. Let’s explore how they apply to Ruby:
Abstraction
Ruby exhibits Abstraction by allowing us to form mental models of problems using familiar ‘real-world’ concepts, which allows us to abstract the problem to a more familiar domain. It puts the emphasis of the programming language on human needs over machine needs. We concern ourselves with a higher-level sense of the problem without worrying about implementation details like binary code or whether the code will run on a specific operating system. This allows us to restrict our focus to objects with properties (states) and behaviours (methods).
Encapsulation
Speaking about restricting our focus, Ruby does something similar in the form of encapsulation. Just like how we don’t need to worry about the meaning of life while we’re engaged in our work as programmers, Ruby restricts its focus to only what is relevant to the task at hand. It’s perfectly valid to think about the meaning of life, but it’s probably not relevant most of the time that you’re programming. Encapsulation is the deliberate erection of boundaries in code that prevents erroneous accessing and modifying of states and behaviours that don’t make sense for what our intention is. If for example, we create a CityPark class to form a blueprint of properties and behaviours that we expect out of a CityPark object, we expect that there may be a relation in terms of behaviours with a Forest class, but we don’t want their particular attributes to overlap.
We would expect both a Park object and a Forest object to contain tree attributes, but the specifics should be unique to the particular object. In other words, that information should be encapsulated within that specific instance of the class. If we try to retrieve the information regarding the number of trees in a specific park, we don’t want to return the value of the number of trees in some forest. The state of each object is said to be unique, because it’s bound to a specific object. We can therefore create multiple CityPark objects and expect to have the ability to retrieve information about each specific park individually.


#city_park.rb

class CityPark
  attr_reader :name, :num_trees

  def initialize(name, num_trees)
    @name = name
    @num_trees = num_trees
  end
end

class Forest
  attr_reader :name, :num_trees

  def initialize(name, num_trees)
    @name = name
    @num_trees = num_trees
  end
end

high_park = CityPark.new("High Park", 5000)
durham_forest = Forest.new("Durham Forest", 125000)
dufferin_park = CityPark.new("Dufferin Park", 2000)

high_park.name # => "High Park"
high_park.num_trees # => 5000
durham_forest.name # => "Durham Forest"
durham_forest.num_trees # => 125000
dufferin_park.num_trees # => 2000

Notice how on line 25 we chain the name method to the high_park local variable which is where the specific instance of the CityPark class is stored. This works because the name method is actually an instance method of the CityPark class (CityPark#name). The name method is a ‘getter’ method which retrieves the data stored in an instance variable. Instance variables are where we store the specific unique attributes (or states) for instances of the class.
Public, Private, Protected
Encapsulation is at work in many other ways in Ruby, and classifying methods as either public, private, orprotected is another example. public methods are the interface that we use to interact with the class, and so can be invoked outside of the class (as we do on lines 25–29). private methods have a much more restricted scope, and are only invokable from within a class, and without an explicit receiver. Private methods are for implementation details that don’t need to be accessed outside of the class, or to deliberately hide information. Think about how you might want to restrict access to sensitive information like a bank account balance, while allowing another method within the class to check if that balance has enough money to withdraw. protected methods are a sort of compromise and behave like public methods when accessed inside a class definition, but behave like private methods when accessed outside.
Polymorphism
Also notice how we used what looks like the same name method on objects of two different classes — and Ruby didn’t get confused!? This is a demonstration of polymorphism, which is being able to have a single interface perform different functionality depending on the context in which it’s invoked. Because of Ruby’s method lookup path, (and encapsulation) the Ruby interpreter first looks for the method that’s being invoked in the class of the calling object (here on line 25 it would be the CityPark class). Because a name method is found within the CityPark class, it stops looking and invokes this method. Note that in our example the two name methods are fully independent: CityPark#name and Forest#name. If we wished, we could modify one of those methods for different functionality without affecting the other.
This flexibility allows us to re-write methods of the same name within custom classes to make their implementation details specific to the needs we want, while exposing a familiar public interface with which we interact with.
But hold up. So far in our example both the CityPark and Forest class share the exactly the same behaviours and attributes (objects of each class have name and num_trees attributes, and an instance method to retrieve that information). Doesn’t it seem inefficient to have written repetitive code? Anyone say DRY? As in: “Don’t Repeat Yourself”, not: “that insult was harsh and accurate”.
Inheritance
Remember that other pillar of OOP? Inheritance is the ability of related classes to share behaviours through a hierarchical structure of single inheritance. Subclasses inherit the methods from their parent classes (which includes the methods that it inherits through its parent class and so on so forth up the chain). It’s called single inheritance because a given class can only ever directly subclass from one parent class. In our example, we can re-imagine our class relationships by creating a superclass that we’ll call GreenSpace. By subclassing the CityPark and Forest classes from this shared ancestor GreenSpace, both of those subclasses will inherit the behaviours and attribute domains of the GreenSpace class (the < symbol on lines 12 and 14 denote a subclass relationship). So many characters saved, what relief! Seriously though, efficiency is wonderful.

greenspace.rb

class GreenSpace
 attr_reader :name, :num_trees

 def initialize(name, num_trees)
   @name = name
   @num_trees = num_trees
 end
end

class CityPark < GreenSpace; end

class Forest < GreenSpace; end

high_park = CityPark.new("High Park", 5000)
durham_forest = Forest.new("Durham Forest", 125000)
dufferin_park = CityPark.new("Dufferin Park", 2000)

high_park.name # => "High Park"
high_park.num_trees # => 5000
durham_forest.name # => "Durham Forest"
durham_forest.num_trees # => 125000
dufferin_park.num_trees # => 2000

Now, when we create a new CityPark object on line 16, there is no initialize constructor method within the CityPark class, so the Ruby interpreter will go through the method lookup path in search of an initialize method (as a constructor method, the initialize method is called automatically upon instantiation of a new object of the class). The exact method lookup path for a particular calling object can be found by invoking the ancestors class method on the class of the calling object (it will return an array, which is the names of the classes and modules that will be searched (in order) for the method being invoked). Ruby will stop looking and invoke the first method that it finds by the name provided.
Class methods are methods that are invoked on class itself, rather than on an object of the class. They do not have scope to the individual attributes of objects of the class, they’re focused on functionality that is more general to the class (such as finding out the method lookup path for any object within the class, which doesn’t concern itself with any specific instance).
Modules
Did you notice earlier that I mentioned modules, without explaining what those are? Modules are Ruby’s solution to multiple inheritance. Modules can be containers of methods that are out of place elsewhere in your code (applicable in some places but not others), or it can contain multiple whole classes to group classes that are similar but not hierarchically related. Any number of modules can be mixed into a class (remember that a class can only directly inherit from one other class) by using the include reserved word followed by the module name. This is called a mixin. Note that objects cannot be instantiated from modules; that is restricted to classes.
To demonstrate when to use a module vs. inheritance it can be useful to think about the relationship. If it’s an “is-a” relationship such as “A City Park is a Green Space”, then it’s likely more sensible to inherit behaviours through hierarchy from a GreenSpace parent class. If it’s more of a “can-do” relationship such as “You can go swimming in a CityPark”, then that behaviour might better suit being mixed in through a module*. The convention with module naming is to append the “-able” suffix to the module name, such as with Swimmable.
If we add some more classes to our example, a RecreationCentre class that subclasses from CityPark, and a Lake class that subclasses from Forest, we see how modules are useful. Despite all of the classes sharing the methods from the GreenSpace class higher up in the hierarchy, we don’t want to put the swim method there because that would include the behaviour in places it doesn’t belong such as our CityPark class. Instead of creating a mess by including the swim behaviour in a shared parent class (or being gross and repeating ourselves), we include the Swimmable module to add the swim method functionality only where it’s needed: within the Lake and RecreationCentre classes.

# recreation_centre.rb

module Swimmable
  def swim
    "Can swim here!"
  end
end

class GreenSpace
  attr_reader :name, :num_trees

  def initialize(name, num_trees)
    @name = name
    @num_trees = num_trees
  end
end

class CityPark < GreenSpace; end

class RecreationCentre < CityPark
  attr_reader :philanthropist
  include Swimmable

  def initialize(name, num_trees, philanthropist)
    super(name, num_trees)
    @philanthropist = philanthropist
  end
end

class Forest < GreenSpace; end

class Lake < Forest
  include Swimmable
end

dufferin_park = CityPark.new("Dufferin Park", 2000)
wallace_emerson = RecreationCentre.new("Wallace Emerson", 2, "Joe Beef")

dufferin_park.num_trees # => 2000
wallace_emerson.num_trees # => 2
wallace_emerson.swim # => "Can swim here!""
dufferin_park.swim # NoMethodError => undefined method 'swim' for CityPark...
wallace_emerson.philanthropist # => "Joe Beef"


Setter and Getter Methods
Let’s investigate our new code further. Notice the attr_reader on line 10. This is the line of code that creates that getter method that we mentioned earlier. It’s part of the attr family, which creates attribute setter and getter methods for the arguments passed in as symbols (here :name, and :num_trees). attr_reader is the short-form way to create a reader method, attr_writer will create a writer method, and attr_accessor will create both. It’s convention to pass the instance variable as a symbol rather than to use some other more descriptive name like get_name or show_num_trees. This makes the invocation of the method clean and straightforward. It’s also possible to define setter and getter methods using the def reserved word like with traditional instance methods if you want to add functionality (like formatting a name in a setter method).
Super
Did you notice the word super on line 25? The reserved word super passes any arguments supplied up the method lookup path to the first method of the same name that Ruby finds, which it then invokes. In our example, super on line 25 passes the name and num_trees arguments up to the initialize method in the GreenSpace class. Ruby then continues to execute the originally invoked initialize method on line 24 and assigns the philanthropist argument to the @philanthropist instance variable, where it is stored as a unique state of the instance of the RecreationCentre class (see the return value of line 43). Super can also be invoked without arguments to pass all supplied arguments up the lookup path.
Self
Why don’t we talk about some more Ruby OOP basics, such as the reserved keyword self. Self is interesting, because its meaning is dependant on context. Self refers to the calling object, which for us can mean a specific instance of the class, or the class itself, depending on where it’s used.

# recreation_centre_expanded.rb

module Swimmable
  def swim
    "Can swim here!"
  end
end

class GreenSpace
  attr_accessor :name, :num_trees

  def initialize(name, num_trees)
    @name = name
    @num_trees = num_trees
  end
end

class CityPark < GreenSpace; end

class RecreationCentre < CityPark
  attr_reader :philanthropist

  include Swimmable

  @@num_rec_centres = 0

  def initialize(name, num_trees, philanthropist)
    super(name, num_trees)
    @philanthropist = philanthropist
    @@num_rec_centres += 1
  end

  def whats_this
    self
  end

  def self.num_rec_centres
    @@num_rec_centres
  end
end

class Forest < GreenSpace; end

class Lake < Forest
  include Swimmable
end

dufferin_park = CityPark.new("Dufferin Park", 2000)
wallace_emerson = RecreationCentre.new("Wallace Emerson", 2, "Joe Beef")
scadding_court = RecreationCentre.new("DunBat", 25, "Jim Balsillie")


RecreationCentre.num_rec_centres # => 2
scadding_court.name # => "DunBat"
scadding_court.name = "Scadding Court"
scadding_court.name # => "Scadding Court"
scadding_court.whats_this # => #<RecreationCentre:0x00007fc73b9a0060 @name="Scadding Court", @num_trees=25, @philanthropist="Jim Balsillie">

In our latest example, on line 37 inside the RecreationCentre class we define a class method. Remember those? We know we’re defining a class method because the context is inside a class, but outside of an instance method definition. The self here refers to the class itself, which makes it clear why we use it to define a class method.
On lines 33–35 we defined a new instance method called whats_this which only invokes self. Because the context here is within an instance method, self now refers to the specific instance of the class that the method is invoked on, which we do on line 57. Does any of that return value look familiar to you?
Inside some encoding is RecreationCentre which a class we’ve defined, then an octal number followed by @name=”Scadding Court”, which is an attribute we’ve assigned, followed by @num_trees=25, and then @philanthropist=”Jim Balsillie”. Interesting! This is all the information about the object we invoked the CityPark#whats_this instance method on. This is our calling object.
Did you notice another change in the code on line 10? The attr_reader has been changed to an attr_accessor, which now creates not just the getter, but both the setter and getter methods. We demonstrate this change in functionality on lines 54–56. Because these setter and getter methods are public (by default), we can invoke them outside of the class definition.
Final Thoughts
I want to point out that class relationships aren’t always obvious when designing a program, and designing good relationships between classes is a skill that takes a lot of practice. There’s a whole field dedicated to OOP design patterns, so don’t expect to master them overnight. There are tools like Class Responsibility Cards (CRC) that can help during the design phase, and also it’s often helpful to do exploratory code spikes to test out relationship ideas before proceeding with the code. In the example we’ve used here, it doesn’t make a lot of sense to have a RecreationCentre class subclass from a CityPark class.
When you think about it, how much do recreation centres and parks have in common? Recreation centres should be their own standalone class whose objects act as collaborator objects to the CityPark class. City parks can have recreation centres, but those centres aren’t actually green spaces so much as things that are located in green spaces.
There’s a lot more to OOP Ruby than what I’ve shown, but I hope this at least helps clarify some concepts for you, and if not, then leave a comment and we’ll get you sorted out.
If you think you know a concept, try explaining it to a wall. It’s called the ‘Rubber duck’ technique and is especially useful for self-directed learning. Reaching out to another student is even better.
