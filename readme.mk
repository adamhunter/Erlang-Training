## Data Types
* atoms
  * true, hello, 'WORLD'
* binary
  * <<"Hello World">>
  * Useful for unicode characters
* lists
  * [1,2,3]
  * "Hello, World" (a string of characters [which are just integers])
* tuples
  * {greeting, <<"Hello there!">>}
* integers
  * 12345
  * max value of ram

## Pattern Matching
* Single assignment variables start with an uppercase character
* The `=` operator
  * A = 10.
  * {RecordType, Car} = {car, "Challenger"}.
  * Message = "Hello, world!".
  
## Lists
  * map (just like ruby map)
  * filter (just like ruby select)
  * List comprehension (map)
    * A = [1,2,3,4,5].
    * [X * 2 || X <- A].
    * [2,4,6,8,10]
  * List comprehension (filter)
    * A = [1,2,3,4,5].
    * [X || X <- A, X rem 2 == 0]
  * Build in reverse for constant time list insertion the use lists:reverse(List).
    
## Functions
  * Arity (number of parameters a function takes)

## Recursions
  * call function in tail position to reuse call frame (bindings)
  * last call in function is "tail"
  
## Processes
  * Module and Process are useful for code decomposition
  * Akin to a Class

## Misc
  * erlc (to compile .erl to .beam)
  * erl -pa (for load path)
  * m(module_name) gives info about module
  * c("/path/to/file.erl") or c(demo)
  * _Variable (ignore variable)
  
## Line terminators
  * Comma separates sequentially executing statements (,)
    * X = 2, X1 = X+2, X2 = X1 + 2.
  
  * Semicolon separates related but distinct things (;)
    * see even_or_odd
  * Period terminates a block of things or a single thing (.)