# Algorithms

Over the past few weeks, we have become familiar with a couple of
computer languages, and how they can be used to perform simple tasks
from the command line. This is, of course, useful, but where
computational approaches allow us to most efficiently perform tasks is
when we write more complex programs that complete multiple tasks
automatically. Over the next two weeks we will cover some of the tools
available in Python to doso, as well as strategies and best practices to
write code that is efficient, correct, and easy to understand and
replicate in the future.

## What is an algorithm?

The set of specific instructions given to a computer in order to solve a
particular problem is called an *algorithm*. If followed from start to
finish, the computer should produce the desired result. A key step in
solving complex problems using computers is, therefore, defining an
algorithm. Cookbook recipes are a kind of algorithm. Starting with a
particular set of ingredients, we perform tasks using them, and
eventually we end up with the desired gastronomic outcome. Similar to
creating a recipe, a productive way to define computational algorithms
is breaking the problem up into small steps that start with our inputs
and end with the desired outputs(e.g reading an input, storing it as an
object, processing it in multiple ways, outputting the results).

## Planning and pseudocode

Before starting to write a program, it is ideal to at least have a
general idea of what our algorithm is going to be. In other words, it
helps to define the steps that our program needs to take in as much
detail as is practical before delving into the code. This way, we can
more easily keep track of the main objective while dealing with the
particularities of coding up our algorithm.

Once we've figured out the borad algorithm we want to follow, a useful
way to plan the details is using *pseudocode*. That is, using informal
code-like language and programming conventions to write out each step of
a program, before dealing with the specific syntax of the programming
language we're using. For instance, if we wanted to convert a sequence
of codons amino acids, we could write the following pseudocode:

``` bash
    import codon table
    seq=codon sequence
    codons = split seq into triplets
    for each codon
        replace for corresponding amino acid
```

**Exercise:**

1.  Using pseudocode write an algorithm you could follow to get out of
    bed and start your day on Wednesdays.

2.  Generalize your algorithm so it works for every day of the week.

# The flow of a program

The simples computer programs consist of a list of tasks, known as
statements, each specified in a new line, that are performed one after
the other, every time in the same order. **Note:** in some languages
statements are delimited by other characters, such as '\";\" in C.
However, we can use more complex computational tools, such as
*conditional* statements, where the program can decide next steps given
the result of a previous operation, and *loops*, that allow us to repeat
slightly different versions of the same task a large number of times,
while only specifying the task once in the code.

## Conditionals

Conditional statements are commands that tell a a program to execute
particular statements if a condition is made, and a different set of
statements if it is not. For example, we can ask Python to tell us if a
number is divisible by 2:

``` python
    x = 4

    if x % 2 == 0
        print("Divisible by 2")
```

Run this on a Jupyter Notebook. You should see the output
\"`Divisible by 2`\".

Before continuing, take note of two things: First, we have typed a colon
(\":\") at the end of the `if` statement. This tells Python to expect
additional code related to the `if` statement in the next line. You will
find this at the end of most commands that require additional code to
run \"within\" them, including loops, conditionals, and the creation of
new functions (more on that next week!). Second, we added blank spacing
(i.e. *indentation*) before the
`print("Divisible by 2")`
statement. This tells Python which lines of code should be executed
within the `if` statement. Again, this type of syntax will appear in all
commands that run code within them.

Continuing on, lets define `x = 3`. What happens when you run the above
command? Since the `print` statement is only executed when the `x` is
divisible by 2, nothing will be output. We can use an
`else` statement to tell the
program what to do if the condition set in the `if` statement isn't
true.

``` python
    x = 4

    if x % 2 == 0
        print("Divisible by 2")
    else:
        print("Not divisible by 2")
```

If we want to check multiple conditions can use
`elif` statements (short for \"else
if\"). As its name suggests, this command evaluates if a condition is
met. If it is not, it continues to the next `elif` or `else` statement.
If it is, the relevant code block is executed, and subsequent
`elif`/`else` statements are ignored. We can add an `else` statement at
the end to cover the case where none of the conditions are true.

``` python
    x = 17

    if x % 2 == 0:
        print("Divisible by 2")
    elif x % 3 == 0:
        print("Divisible by 3")
    elif x % 5 == 0:
        print("Divisible by 5")
    elif x % 7 == 0:
        print("Divisible by 7")
    else:
        print("Not divisible by 2, 3, 5, or 7")
```

Now try setting `x = 15`. What is the output of the program? This
exemplifies how the order in which `elif` statements are written,
determines their order of priority as they are evaluated.

**Exercise:** Run the following code

``` python
    x = 14

    if x % 2 == 0:
        print("Divisible by 2")
    if x % 3 == 0:
        print("Divisible by 3")
    if x % 5 == 0:
        print("Divisible by 5")
    if x % 7 == 0:
        print("Divisible by 7")
    else:
        print("Not divisible by 2, 3, 5, or 7")
```

1.  What output do you get? Why do you get this output?

2.  Set `x = 12`. What output do you get now? Why?

## Loops

Loops are one of the key commands we can use to make our programs more
efficient. They allow us to run the same block of code many times on
different inputs and/or with small variations. Python can execute two
types of loops `for` loops, which iterate over a defined set of
elements, and `while` loops, which run code as long as a specific
condition is met. They are each useful in different situations.

### `for` loops

`for` loops iterate through all elements in a sequence, which can be a
string, a list, a tuple, or the keys or values of a dictionary, among
others. They are run as follows

``` python
    # Print all elements of a list
    for i in [1, 4, "hello", False]:
        print(i)

    # Print all characters in a string
    for char in "ATCCTCGTA":
        print(char)
```

Loops are of course most useful when we need to iterate over many
elements. Defining a long list of elements to iterate over by hand can
be impractical. Sometimes this list already exists (e.g. all rows in a
table, all text files in a directory). For when it doesn't Python has
several useful functions to create commonly-used lists. For instance
`range()` returns consecutive
numbers at specific intervals, which can be converted to lists. The
general syntax is
`range(from, to, step)`. Since
Python starts counting at 0, the last value (`"to"`) is not included in
the output. If `"from"` and `"step"` aren't specified, they default to 0
and 1, respectively.

``` python
    # Numbers from 1 to 10 (non inclussive) in steps of 1
    >>> list(range(0, 10, 1))
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
    # Numbers from 2 to 10 in steps of 2
    >>> list(range(2, 11, 2))
        [2, 4, 6, 8, 10]

    # Numbers from 0 to 8 in steps of 1
    >>> list(range(9))
        [0, 1, 2, 3, 4, 5, 6, 7, 8]

    # Numbers from 4 to 8 in steps of 1
    >>> list(range(4, 9))
        [4, 5, 6, 7, 8]
```

`range` can be used in `for` loops as follows

``` python
    # Print the cube of all values between 0-9
    for i in range(10):
        print(i, i ** 3, sep="\t")
```

Note how we used `print` two values, the raw `i`, and $\texttt{i}^3$,
separated by a `TAB` character, specified as \"`\``t`\".

### `while` loops

`while` loops will run as long as a condition is met. For example, the
code below sets `i = 0`, and prints `i` as long as it is less than 5.

``` python
    i = 0
    while i < 5:
      print(i)
```

As you may have noticed, the code above will run forever, since `i` will
never be greater than 5. To stop this `infinite` loop go to
$\texttt{Kernel} \rightarrow \texttt{Interrupt}$ on Jupyter, or press
`ctrl+c` on the terminal. To avoid `while` loops running for ever, we
must update the initial conditions in a way that eventually stops
fulfilling the loop's conditional, and breaks the loop. In our simple
case above, we can increase `i` by 1 every cycle.

``` python
    i = 0
    while i < 5:
      print(i)
      i = i + 1
     print("done")
```

When `i = 5`, the condition `i < 5` is no longer met, and the loop
stops. `while` loops are meant to be used in cases where we want the
code to run until a specific event happens. For example, we can use them
to find the solution of a particular problem by running until the
solution is found. For instance

``` python
    # Find the first integer >= 1200 divisible by 19 

    # Set variables
    srch = True
    x = 1200

    # Loop x through integers starting at 1200. 
    # If x divisible by 19 print x and stop searching
    while srch == True:
        if x % 19 == 0:
            print(x, "is divisible by 19")
            srch = False
        x=x+1
```

Note that if the condition for a loop to run is that a boolean variable
is, we don't need to specify this. The loop above could also be written
as

``` python
    # Find the first integer >= 1200 divisible by 19 

    # Set variables
    srch = True
    x = 1200

    # Loop x through integers starting at 1200. 
    # If x divisible by 19 print x and stop searching
    while srch:
        if x % 19 == 0:
            print(x, "is divisible by 19")
            srch = False
        x=x+1
```

### Loop Control

We can further control the flow of a loop using the commands `break` and
`continue`. As its names suggests, `break` terminates a loop when
executed and continues to lines of code after the loop. `cotinue`
terminates the current iteration of the loop, and proceeds with the next
iteration. For instance, we could rewrite the loop above as

``` python
    # Find the first integer >= 1200 divisible by 19 

    # Set variables
    x = 1200

    # Loop through integers starting at 1200, until 1900. 
    # If one is divisible by 19 print this and break loop
    while x < 1900:
        if x % 19 == 0:
            print(x, "is divisible by 19")
            break
        x=x+1
```

Note how we use `break` to stop searching, instead of setting the loop
condition to `False`.

Similarly, we can use `continue` to find the first 100 even numbers

``` python
    # List the first 100 even numbers
    x = 0 # Starting number
    found = 0 # Keeps track of number of elements found

    #Iterate over integers starting with x = 0
    # If even, print x and increase found by 1
    # If odd go to next integer. 
    while found < 100:
        x = x + 1
        if x % 2 == 1:
            continue
        print(x)
        found = found + 1
```

### Looping over data structures

We can take advantage of the architecture of Python's data structures to
access their contents using loops. For example, we can loop through both
the elements and indices of a list or string using the
`enumerate()` function, which
creates a list of tuples containing index-value pairs.

``` python
    # Create list from DNA sequence. One base per index.
    seq="GATGCTAGTGCTAGCTA"

    # Index - element pairs can be visualized with list()

    list(enumerate(seq))

    #Iterate over index - element pairs
    for k, x in enumerate(seq):
        print(k, x)
```

Note how we specified two variables to iterate over (`k` and `z`). This
works specifically because we are iterating over a series of tupples of
length 2.

`enumerate` can be applied to lists in exactly the same way as above. If
dealing with dictionaries, we can use the `.items()` method in a similar
way to access the key-value pairs.

``` python
    z = {0: "a", 1: "b", 2: "c"}

    for (key, val) in z.items():
        print(key, "->", val)
```

Finally, an incredibly useful tool in Python when dealing with lists is
*list comprehension*. Briefly, this is a way to write loops that apply
the same function to all elements of a list in a very compact way. For
instance, we can get the square of every element of a numeric list in
just one line of code:

``` python
    # Create list
    a = [1, 2, 5, 14, 42, 132]

    # Apply 'x ** 2' to all elements in the list
    b = [x ** 2 for x in a]
```

**Exercises:** Below are a series of loops that print the word \"hello\"
a number of times. Based on the code of each one, try to determine how
many times \"hello\" will be printed each time *before* running the
code.

1.  ``` python
        for i in range(3, 17):
            print("hello")
    ```

2.  ``` python
        for j in range(12):
            if j % 3 == 0:
            print("hello")
    ```

3.  ``` python
        for j in range(15):
            if j % 5 == 3:
                print("hello")
            elif j % 4 == 3:
                print("hello")
    ```

4.  ``` python
        z = 0
        while z != 15:
            print("hello")
            z = z + 3
    ```

5.  ``` python
        for i in range(10):
            if i > 5:
                break
            print("hello")
    ```

6.  ``` python
        z = 0
        while z < 25:
            z = z + 1
            if z % 2 == 1:
                continue
            print("hello")
    ```

# Working with files

## Basic text files

A very common task in scientific computation is reading input from files
and writing output into new files. Python interacts with files by first
opening a *connection* to a file, which is called a *file handle*. We
can then use this connection to read from or write to the file. To
create a conntection we use the `open` command.

``` python
    f = open("some_seqs.txt", "r")
```

Here `some_seqs.txt` is the path to the file we want to open (remember
to specify it relative to where you launched Jupyter), and \"`r`\"
stands for \"reading\". You can specify \"w\" to write and \"a\" to
append to a file (more on that below).`f` is now an object that contains
the connection to our file.

Similar to other objects, there are several methods that can be used for
a file handle. For example

``` python
    # Get file name
    f.name

    # Nature of the file handle (read, write, append).
    f.mode
```

We can also use methods to read from the file. For example, we can print
all of its contents.

``` python
    # Print all file contents
    print(f.read())
```

Once you're done reading (or writing), you need to close the connection
to the file

``` python
    # Print all file contents
    f.close()
```

It is easy to forget closing a file, which can lead to unwaned behavior,
such as overwriting files, or other programs being unable to open our
file. To avoid this, it is advisable to use the `with` command to open
files.

``` python
    with open("./some_seqs_test.txt", "r") as f:
        print(f.readline())
```

`with` opens the file, performs whatever operations we specify within
it, and the closes the file. Note that in the command above we used the
`readline()` method, which reads lines sequentially. That is, every time
you call it it reads the next line in the file. We can use a similar
approach to loop through lines of a file and perform some operation.

``` python
    # Print each line in the file
    with open("./some_seqs_test.txt", "r") as f:
        for ln in f:
            print(ln)
```

You may have noticed that now the output has a space between each line.
This is because `print` adds a new line at the end of what is being
printed. Since the file also has a new line then a blank space is
created. We can use the `.rstrip()` method to remove the new line
characters.

``` python
    # Print each line in the file
    with open("./some_seqs_test.txt", "r") as f:
        for ln in f:
            print(ln.rstrip())
```

This toy example illustrates how we can iterate through all lines in a
file and perform operations on them one by one. However, some times we
want to save a file as a data structure to perform further operations on
it. We can use a similar approach as above to read a file into a
dictionary.

``` python
    # Create empty dictionary to be populated 
    genes = {}

    #Open file
    with open("./some_seqs_test.txt","r") as f:
      for line in f:
        line = line.rstrip()  # Remove newlines
        gene_id,seq = line.split() # split line, save as gen_id and split
        genes[gene_id] = seq  # Add seq to genes dictionary with key [gene_id]
        
    # printo dictionary to insepct
    print(genes)
```

we can also use `open()` to create new files that we can write into.
Just like above, there are multiple methods to write into files.

``` python
    with open("myfile.txt", "w") as f:
        f.write("Some stuff\n")  # Write some stuff, add \n to go to a new line
        f.writelines(["ln 2\n", "ln 3\n", "ln 4\n"]) # Write several lines at once
```

You should now have a file in your current directory called
`myfile.txt`. Instepct its contents

``` bash
    $ cat myfile.txt
      Some stuff
      ln 2
      ln 3
      ln 4
```

Lets now try something a bit more complex. Lets read from a file perform
an operation with each line, and write the outputs to a new file. Using
our file that has gene names and sequences each in one line, lets
calculate the GC content and output it to a new file.

``` python
    with open("some_seqs_test.txt","r") as infile, open("gc_content.txt", "w") as outfile:
      for line in infile:
        line = line.rstrip()  # Remove newlines
        gene_id,seq = line.split() # split line, save as gen_id and split
        gc = (seq.count("G") + seq.count("C")) / len(seq)
        outfile.write(gene_id+"\t"+str(gc)+"\n")
        
```

# Final Problems

Answer the following questions in Markdown format within a folder in
your GitHub repository (e.g. `Practicals/W5/`. Add any scripts and other
files you create to the folder as well.

## Baking a cake

Following a recipe is one way we use algorithms in our daily lives.
Baking a cake usually involves mixing flour, eggs, milk, butter, and
sugar into a batter, putting the batter in an oven pan, and baking for
20-30 min at 400 °F. To know when the cake is done, one can stab it with
a knife. If the knife comes out clean, the cake is done, but if some
batter sticks to the knife the cake needs some more time. Use pseudo
code to write a detailed algorithm for baking a cake based on the above
description.

## Fizz buzz

[*Fizz, buzz*](https://en.wikipedia.org/wiki/Fizz_buzz) is a game used
to teach children about division. Players take turns counting upwards
from one, replacing any numbers divisible by 3 with the word *fizz*, and
any numbers divisible by 5 with *buzz*. Numbers divisible by both are
replaced with *fissbuzz*. In this exercise you will recreate this game
using Python.

1.  Write an algorithm to play *fizz buzz* using pseudocode. Be as
    detailed as possible.

2.  Write a Python program that outputs a game of *fizz buzz* from 1 to
    100 (including 100).

## GC content from fasta

The file
`IntroBiolComp-2026/Python/DataFiles/Turkey_transcripts_15.fasta`
contains 15 coding sequences from the domestic turkey genome in `fasta`
format. write a Python program that calculates the GC content of each
sequence and outputs it to a new file containing sequence names and GC
contents separated by tabs. For instance:

``` bash
    NM_001282121.1  0.452
    NM_001291881.2  0.479
    ... etc ...
```
