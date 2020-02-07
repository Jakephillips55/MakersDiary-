

*String ruby tricks*
"hello James!".upcase      #=> "HELLO JAMES!"
"hello James!".capitalize  #=> "Hello james!"
"hello James!".titleize    #=> "Hello James!"

"MyString".methods.sort
And for a list of the methods available for strings in particular:

"MyString".own_methods.sort

['Cat', 'Dog', 'Bird'].include? 'Dog'
= true
'Unicorn'.in?(['Cat', 'Dog', 'Bird']) # => false
#in and include? - in? is a method in rails but not in ruby

*nums*

To simulate a roll of a six-sided die, you'd use: 1 + rand(6). A roll in craps could be simulated with 2 + rand(6) + rand(6).

If you just need a random float, just call rand with no arguments.

*instance variables*
class Person
  attr_accessor :name

  def greeting
    "Hello #{@name}"
  end
end

person = Person.new
person.name = "Dennis"
person.greeting # => "Hello Dennis"


*Class tricks*

DIFF between class and modules 

https://stackoverflow.com/questions/151505/difference-between-a-class-and-a-module

#class << self

a = 'foo'
class << a
  def inspect
    '"bar"'
  end
end
a.inspect   # => "bar"

a = 'foo'   # new object, new singleton class
a.inspect   # => "foo"

The class << foo syntax opens up foo's singleton class (eigenclass). This allows you to specialise the behaviour of methods called on that specific object.

class String
  class << self
    def value_of obj
      obj.to_s
    end
  end
end

String.value_of 42   # => "42"

class << self opens up self's singleton class, so that methods can be redefined for the current self object (which inside a class or module body is the class or module itself).

--> shorter way of writing this is
class String
  def self.value_of obj
    obj.to_s
  end
end
---> even shorter
def String.value_of obj
  obj.to_s
end


###Class variables
class Person
  *@@count is a class variable shared by Person and every subclass.
   When you instantiate a Person or any kind of Person, such as a Worker,
   the count increases.*
  @@count = 0

  def initialize
    self.class.count += 1
  end

  def self.count
    @@count
  end
  def self.count=(value)
    @@count = value
  end
end

class Worker < Person
  *@count is a CLASS INSTANCE VARIABLE exclusive to Worker.
   Only when you instantiate a Worker, the count increases.*
  @count = 0
end

8.times { Person.new }
4.times { Worker.new }

p Person.count # => 12
p Worker.count # => 12



*undefined*
kind_of? and is_a? are synonymous.

instance_of? is different from the other two in that it only returns true if the object is an instance of that exact class, not a subclass.

Example:

"hello".is_a? Object and "hello".kind_of? Object return true because "hello" is a String and String is a subclass of Object.
However "hello".instance_of? Object returns false.

CREATE - POST /restaurants
READ - GET /restaurants/123
UPDATE - PATCH /restaurants/123
DELETE - DELETE /restaurants/123
CRUD

---------------
In a one-to-many relationship, each row in the related to table can be related to many rows in the relating table. This allows frequently used information to be saved only once in a table and referenced many times in all other tables. In a one-to-many relationship between Table A and Table B, each row in Table A is linked to 0, 1 or many rows in Table B. The number of rows in Table A is almost always less than the number of rows in Table B.
so
id - name            content id - content  -------- id
1 - bob                       2 - builders          1
2 - tom                       4 - jerry             1
3 - placeholder name          3 - placeholder idea  3
4 - brave                     1 - heart             4

each name above is linked to an id that id is referenced in the next table - so bob has id 1, 1 is referenced by builders and jerry. bob is multilinked to builders and jerry
whereas the other names only have one link                 

---------------
---------------

*ERRORS*
#big cool ERRORS and whats maybe causing them

PostgreSQL ERROR: INSERT has more target columns than expressions, when it doesn't
- this was a syntax error I had missed '' in correct locations so;
i had done this - ('a, b') instead of ('a', 'b') /

triple read your syntax test and code - alot of errors are typos.


javascript 

Greeting.prototype.hello = function(person) {
  return 'Hello, ' + person + '!';
}
VM1320:1 Uncaught ReferenceError: Greeting is not defined
    at <anonymous>:1:1
(anonymous) @ VM1320:1
function Greeting() {
}
undefined
Greeting.prototype.hello = function(person) {
  return 'Hello, ' + person + '!';
}
ƒ (person) {
  return 'Hello, ' + person + '!';
}
var greeting = new Greeting(); 
undefined
greeting.hello('Jake');
"Hello, Jake!"
