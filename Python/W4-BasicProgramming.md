# Programming in Python: The Basics

## What is programming? Why learn it?

Put simply, programming is giving a computer a series of instructions
for it to execute in a particular order. The nature of these
instructions can, of course, range from simple tasks like replacing
characters in a text file to a "full-fledged\" piece of software that
takes many user inputs and deals with them in specific ways, such as
word processors or illustration programs, to incredibly complex tasks
like tracking air traffic at a busy airport (and beyond!). With this
said, the essence of it is always the same: coming up with a logical set
of steps to solve a problem (an *algorithm*, and communicating it to a
computer in a correct way.

In science, programming is key. We are, by definition, looking to know
what is not known, so there will very often not be software that does
exactly what we need. Being able to write such software not only makes
it possible to do the science, but also allows us to write software that
makes our results easier to understand and reproduce for us and others.
As Allesina & Wilmes put it "If you organize your data and code
properly, and you automate the whole pipeline, anybody (anywhere) will
be able to reproduce your findings exactly.\"

## Why Python?

There are many programming languages, which have often been developed to
address specific problems. We have already learned `Unix`, and you may
have heard about others, such as `R`, `Python`, and `C++`. Some will be
faster or more efficient for dealing with specific data types or tasks
(e.g. visualization), while others may be easier to write and understand
at the expense of speed and flexibility. Learning a few programming
languages is good practice, since it makes us much more versatile
programmers. Although there is usually *a* way to do most things in
every single language, some tasks are much easier to complete in some
languages than in others. Furthermore, being at least familiar with
multiple languages allows you to understand and expand/reuse/repurpose
other peoples' code better. Finally, hundreds of new functions and
*packages* are constantly being developed across fields of science.
Sometimes the resources you need have been developed in one language and
not others, so knowing a couple of languages can be very helpful.

In this class we cover three popular languages in the biological
sciences: Unix, Python, and R. Unix and similar operating systems are
where most of scientific software is developed. Python is often seen as
a "general purpose\" language, which can be used for tasks ranging from
web scraping to data manipulation and analysis. R, on the other hand, is
more specialized for statistics and data visualization. This being said,
both languages have very active development communities in biology and
adjacent fields, so they have both grown to cover an enormous variety of
tasks.

## Getting started in Python

### Getting help

As with every other section of this course, learning Python in detail
would require multiple semesters of hard work. Our goal is to get well
enough acquainted with topics so you can continue learning them in the
future. With this in mind, a key place to find help when it comes to
Python is the official Python documentation, at
[docs.python.org](https://docs.python.org/). If you need help for a
specific command, you can use the
`help("my_command")` command to
access a help page similar to a `man` page in Unix.

### Running Python

Python can be run in two main ways, similar to bash scripts. If you type
`python` into the terminal a Python *interpreter* will launch, where you
can enter code line by line, similar to a shell.

``` bash
    # Launch Python interpreter
    $ python
    Python 3.12.2 (main, Feb 16 2024, 20:50:58) [GCC 12.3.0] on linux
    Type "help", "copyright", "credits" or "license" for more information.

    >>> print("Hello world")
        Hello world
```

**Note:** The Python prompt is different from your command line prompt,
so I will signal which is being used on code boxes (Python: `>>>`, bash:
`$`).

Alternatively, you can write your code on a text document, and run it
from the terminal. As with bash, it is good practice to begin your
script with a *shebang* that tells the computer where to find the
software to interpret our script (Python in this case). For instance, if
we create a file named `hello.py` with the following content

``` bash
    #!/usr/bin/env python3

    print("Hello world")
```

We can run it from the terminal

``` bash
    $ python hello.py
    Hello world
```

Which one you use will depend on what we are doing. For example, if you
are exploring a dataset and want to decide what you do next based on the
previous line of code, then running things line-by-line may make snese.
If you have a well-defined set of tasks that you want to run in order,
and that may perhaps take a long time, then a script would make the most
sense. Frequently, scripts are created by testing each line of code on
some "toy example,\" and then deployed as a script to complete our
actual task. Since we're learning, we will run a lot of line-by-line
commands, but most of the homework problems will involve writing scripts
that can run in one go from the terminal.

**Exercise:** The following code lets you know things about a set of
numbers.

``` bash
    message = '' # make an empty variable
    for x in [1, 2, 3, 4, 5]:
        if x > 4:
            print(x)
            message = 'x is big'
        else: 
            print(x)
            message = 'x is small'
        print(message)
    print('All Done!')
```

1.  Write this code in a file and run it as a script from the terminal.

2.  Can you tell what is this code doing?

### Python versions

Most pieces of software are built and changed over time, so they have
multiple versions. Between Python version 2 and 3, enough changes were
made where these two versions are not *back-compatible*. We will be
using Python 3 in this class. However, because a lot of software was
developed in Python 2 over the years some computers still have it.
Please make sure that you are running version 3 by typing
`python –version` on the terminal.
If you get version `3.x.x` (where
`x` can be any number) you have an appropriate version. Otherwise please
follow the installation instructions posted on the course GitHub in the
`Python` directory.

### Jupyter notebooks

A great way to run Python in interactive mode (i.e. line by line) are
`Jupyter` notebooks, which run Python on your web browser, and allow you
to document and annotate your code using Markdown. To open a Jupyter
notebook simply open a terminal (or Anaconda prompt on Windows) and type
`jupyter notebook`. Windows users
can also launch a notebook by clicking on the application found in
`Start `$\rightarrow$` Anaconda3 `$\rightarrow$` Jupyter Notebook`.

Once the application launches, a web browser window should open, showing
your current directory. Navigate to the place where you want to save
your files (next time you can navigate there beforehand from the
terminal), click the "New\" button on the upper right corner, and select
"Python 3\" to open a new notebook. Notebooks are composed of cells,
which can contain code, markdown, or raw text. You can input code (or
markdown) directly into the box, and hit `Shift+Enter` to run or render
it. Doing so will also create a new cell. There are buttons on the right
hand side of the active cell that allow you to create new cells or move,
duplicate, and delete existing ones.

**Exercise:** Open a Jupyter notebook and run code that prints "Hello
world\" to the screen.

### Basic operations

To get familiar with Jupyter notebooks and python syntax lets try a few
simple operations For example, we can do all basic math operations (e.g.
addition, substraction, etc\...)

``` bash
    >>> 1 + 4 - 3 # addition and substraction
        2
    >>> 2 * 4 # multiplication
        8
    >>> 3/2 # division
        1.5
    >>> 3//2 # integer division
        1
    >>> 3 % 2 # Modulo (remainder of integer division)
        0.5
    >>> 4 ** 3 # exponentiation
        16
```

Python respects "order of operations\" conventions. For example

``` bash
    >>> 2 + 3 * 2 # multiply first
        8
    >>> 2 + (3 * 2) # multiply first
        8
    >>> (2 + 3) * 2 # add first
        10
```

We can also use logical operators, which return *Boolean* values (i.e.
true or false)

``` bash
    >>> 4 > 1
        True
    >>> 2 + 2 == 5 # "is equal to" opeartor
        False
    >>> 3 != 2 # "is not equal to" operator
        True
```

Note how we use a *double* equals sign (==) to test for equality. This
is because a single equals sign (=) is used to assign variables, as we
will see in the next section.

### Variables

A key part of programming is assigning and manipulating variables. On
Python, this is acheived using the equals (=) sign.

``` bash
    >>> x = 5 #assign 5 to variable x
    >>> x # output the value of x
        5
```

If we want to list the variables currently defined in out environment we
can use

``` bash
    >>> who
        x 
```

Once we have defined variables, we can use them to perform operations.

``` bash
    >>> x * 4
        20
    >>> y = 8
    >>> x * y
        40
```

## Data Types and Structures

Each variable contains data of a certain type, which determines the
types of operations that can be done using that variable. For example, a
variable can be a number, a string of characters (e.g. a sentence), or a
boolean variable. There are more complex data *structures*, that include
multiple values, for example as a list. Understanding how each data
type/structure works and what it can be used for is key to write
efficient programs. We can know the type of a variable using the command
`type([my_var])`

### Singular data types

We have already encountered the simplest data types: those which
represent single pieces of data stored in their own variable, such as
one number of one string of characters.

#### Numbers

Single numbers can be stored as two closely related data types: integers
and floating point numbers. The difference between them is that integers
are whole numbers, while floating point numbers can have decimal places.

``` bash
    >>> count = 4 # integer
    >>> type(count)
        int
    >>> heigh = 1.843 # floating point
    >>> type(height)
        float
    >>> weight = 67.0 # floating point
    >>> type(weight)
        float
```

There are many built-in functions in Python that can be applied to
numerical variables. For example

``` bash
    >>> abs(-3.14) # absolute value
    3.14
    >>> pow(3, 6) # 3^6
    729
    >>> round(3.1415926535, 3) # round to 3 digits
    3.142
```

If you ever want to perform an operation on an integer but don't know
the command name for it, the Python documentation and/or web searching
should produce good answers. If the function does not exist, you can
always create your own, as we will learn next week.

#### Booleans

Boolean variables can take two values: True or False. These variables
behave similarly to integers, in that the value "True\" takes a value of
1 and "False\" of 0.

``` bash
    >>> Open = True # note the capital T
    >>> type(Open)
        bool
    >>> dry = False 
    >>> type(dry)
        bool
    >>> Open + Open # Operation with boolean variable
        2
```

#### Strings

Strings are groups of characters grouped in some order (such as words).
Biological data can often be nicely represented as strings, for instance
nucleotide or amino acid sequences, taxonomic names, or patient charts.
Python is very good for string manipulation, so we will cover this data
type in some more detail.

To assign a string we need to surround it with quotation marks.

``` bash
    >>> seq = "GACTTAGACTYA"
    >>> type(seq)
        str
```

We can perform all sorts of operations with our string. For example:

``` bash
    >>> print(seq) # print the string
        GACTTAGACTYA
    >>> print("The sequence is", seq) # print two strings together
        The sequence is GACTTAGACTYA
    >>> len(seq) # length of the string
        9
```

In Python, all variables contain useful methods applicable to that
specific variable in addition ot the data. These can be seen as
"object-specific functions\", and are invoked using the dot (".\")
character. For example, if we wanted to count the number of `G`
nucleotides in our sequence we could use

``` bash
    >>> seq.count("G")
        2   # G is present 4 times.
```

You can access all the available methods for an object by typing its
name and then `Tab` (or double-tab if working directly from the
terminal). Tab will also autocomplete. If you need more information
about how a method applies to a specific variable you can use
`help(var.method)` to print a help
message (e.g. `help(seq.count)`).

Additional methods for strings are, for instance

``` bash
    >>> seq.replace("T", "U") # Replace T for U
        'GACUUAGACUYA'
    >>> seq.find("C") # position of first "C"
        2
    >>> sp_name = " Mus musculus "
    >>> sp_name.split() # split string (using spaces by default)
        [' Mus', 'musculus ']
    >>> sp_name.split("u") # specify split character
        [' M', 's m', 'sc', 'l', 's ']
    >>>> newstring.strip() # remove leading/trailing white space
        'Mus musculus'
```

We can also perform opearations involving multiple strings.

``` bash
    # Concatenate (i.e. join) three strings
    >>> promoter = "TATAAA"
    >>> upstream = "TAGCTA"
    >>> downstream = "ATCATAAT"
    >>> dna = upstream + promoter + downstream
    >>> dna
    'TATAAATAGCTAATCATAAT'

    # Concatenate three strings separated by a character
    >>> upstream + "-" + promoter + "-" + downstream
        'TAGCTA-TATAAA-ATCATAAT'
    TATAAATAGCTAATCATAAT
```

Something to bear in mind here is not to confuse functions, which are
applied to an object using parentheses (e.g. `len(x)`) with
object-specific methods that are invoked using ".\" (e.g.
`seq.split()`).

**Exercises:**

1.  Initialize the string
    `s = "WHEN on board H.M.S. Beagle, as natura- list"`.

2.  Apply a string method to count the number of occurrences of the
    character "b\".

3.  Write a command that counts both lowercase and uppercase "b\".

4.  Replace "WHEN\" with "When\".

### Data structures

It is very frequently the case that we need to organize datasets more
complex than a single number or string of characters. Python allows us
to store such data in variables called *data structures*, which can be
easily accessed and manipulated. We will cover some of the most commonly
used data structures in biology.

#### Lists

Lists store *ordered* collections of data that are *indexed*. This means
that each element of a list is assigned a unique identifier (an index),
based on its position on the list. To define a list, we can enclose its
values in square brackets, and separate them with commas.

``` bash
    >>> my_list = ["TATAAA", 4, 0.3333, True]
```

Note how we can combine elements of different types in lists. We can
access different element of the list by specifying their index (or
indices) between square brackets. Something important to note is that,
like many other computer languages, Python is *zero-indexed*. This means
it starts indexing at 0, so the first element on the list is element
number 0.

``` bash
    >>> my_list[2]
        0.3333
    >>> my_list[0]
        'TATAAA'
```

We can also access a range of consecutive elements of a list using the
colon (":\") operator. Ranges are specified as `[from:to]`, with the
last value not included. For example, if we wanted elements 2 to 4 we
would specify `[2:5]`.

``` bash
    >>> my_list[0:2] # elements 0 and 1
        ['TATAAA', 4]
    >>> my_list[2:] # elements from 2 to the end
        [0.3333, True]
    >>> my_list[:2] # elements from the start to 2 (excludin 2)
        ['TATAAA', 4]
```

If we want to index from the end of the list, we can use negative index
positions. Because 0 is already taken to mark the first position,
negative indexing starts with the last position being -1.

``` bash
    >>> my_list[-1] # last element
        True
    >>> my_list[-2:] # last two elements
        [0.3333, True]
```

In addition to just accessing elements of a list, we can use indexes to
update list values.

``` bash
    >>> my_list
        ['TATAAA', 4., 0.3333, True]  
    >>> my_list[3] = False  # update item 3 to False.
    >>> my_list
        ['TATAAA', 4, 0.3333, False]
```

Or delete specific values.

``` bash
    >>> my_list
        ['TATAAA', 4., 0.3333, True]
    >>> del(my_list[2:4]
    >>> my_list
        ['TATAAA', 4]
```

Note that `del()` performs its operation on an object *in place*. This
means that the object is edited permanently. If we wanted to obtain a
new list with some elements removed we could create a copy of our list
using the `.copy()` and then edit it in place.

``` bash
    >>> short_list = my_list # create new list
    >>> del(short_list[2:4])
    >>> my_list
        ['TATAAA', 4, 0.3333, True]
    >>> short_list
        ['TATAAA', 4]
```

Finally, lists can also be created using the
`list()` function, which takes a
single element that is *iterable* (i.e. that has some sort of structure
that can be subset into single pieces), and converts it to a list. THis
is a useful approach to, for example, convert a string into a list.

``` bash
    >>> gene = "ATGACCCCGTTTTCTGCTCTACAATCAGGCATCAATATCACA"
    >>> type(gene)
        str
    >>> gene_ls = list(gene)
    >>> gene[14] # Return the 14th base in the sequence
        'T'
```

There are several useful built-in methods that can be applied to lists.
Some are demonstrated below:

``` bash
    # Append an element to the end of a list
    >>> my_list.append("yellow")
    >>> my_list
        ['TATAAA', 4, 0.3333, False, 'yellow']
        
    # Count occurrences of a particular element of the list
    >>> gene = list("ATGACCCCGTTTTCTGCTCTACAATCAGGCATCAATA")
    >>> gene.count("C")
        11
        
    # Return the index corresponding to the first occurrence of an element
    >>> states = ["open", "open", "open", "closed", "closed", "closed"]
    >>> states.index("closed")
        3
        
    # Sort the elements of a list *in place*
    >>> lengths = [1.37, 0.99, 0.91, 1.27, 1.06, 2.01, 1.99, 1.41]
    >>> lengths.sort()
    >>> lengths
        [0.91, 0.99, 1.06, 1.27, 1.37, 1.41, 1.99, 2.01]

    # Reverse the elements of a list *in place*
    >>> lengths.reverse()
    >>> lengths
        [2.01, 1.99, 1.41, 1.37, 1.27, 1.06, 0.99, 0.91]
```

#### Tuples

As we have just seen, lists can be edited extensively. These functions
are very useful, but can also lead to problems if data is edited
accidentally, especially if we don't immediately notice. With this in
mind, it is useful to give certain objects write-protection to avoid
changing data that should not change, such as a set of patient
identifiers, the coordinates of a field site, or any other raw data that
were collected. Python allows us to create *immutable* objects, which
can't be changed once they are created. The immutable analog of a list
is called a *Tupple*, and is created using parentheses instead of square
brackets, or using the `tuple()`
function.

``` bash
    >>> patients = ("Id445","Id445","Id32","Id1482","Id174","Id972",)
    >>> type(patients)
        tuple
    >>> patients[4]  # Access element 4
        'Id174'
    >>> patients[4] = "Id173" # Try to update element 4
        -------------------------------------------------
        TypeError       Traceback (most recent call last)
        Cell In[75], line 1
        ----> 1 patients[4] = "Id173"

        TypeError: 'tuple' object does not support item assignment
```

Two methods are available for tuples:

``` bash
    # Count occurrences of a particular element 
    >>> patients.count("Id445")
        2
        
    # Return the index for the first occurrence of an element
    >>> patients.index("Id174")
        4
```

#### Dictionaries

Dictionaries are similar to lists, but instead of being indexed in
order, the are *unordered*, and indexed by names, called *keys*. This is
a useful structure for data that don't have an inherent order, and where
we benefit from naming each element in the data. This could be for
example pairing species names with some phenotype, gene names with their
sequence, etc\... Dictionaries are defined using durly brackets, pairing
keys and values with a colon, and separating key:value pairs with
commas.Similar to lists, dictionaries can be made up of different object
types.

``` bash
    # Create dictionary with multiple data types
    >>> my_dictionary = {"a": "test", "b": 3.14, "c": [1, 2, 3], "d":True}
    >>> my_dictionary
        {'a': 'test', 'b': 3.14, 'c': [1, 2, 3], 'd': True}

    # Dictionary containing the number of cases for some disease in the Montgomery County
    >>> cases = { "Riner":8,
              "Christiansburg":22,
              "Merrimac":7,
              "Blacksburg":39,
              "Elliston":12,
              "Shawsville":44,
              "Ironto":19,
              "Prices Fork":1}
    >>> type(cases)
        dict

    # Call a specific key from the dictionary
    >>>> cases["Ironto"]
        19
        
    # Add a new value
    >>> cases["Pilot"] = 2
    >>> cases
       {'Riner': 8,
     'Christiansburg': 22,
     'Merrimac': 7,
     'Blacksburg': 39,
     'Elliston': 12,
     'Shawsville': 44,
     'Ironto': 19,
     'Prices Fork': 1,
     'Pilot': 2}

    ## Update a value
    >>> cases["Merrimac"] = 14
    >>> cases
       {'Riner': 8,
     'Christiansburg': 22,
     'Merrimac': 14,
     'Blacksburg': 39,
     'Elliston': 12,
     'Shawsville': 44,
     'Ironto': 19,
     'Prices Fork': 1,
     'Pilot': 2}
```

Dictionaries can only have a single value per key, so if you input the
same key multiple times, the last one that was input will be saved. As
with other data types/structures, there are several methods we can use
with dictionaries.

``` bash
    # Get the value for a specific key and print out a preser value if not present
    >>> cases.get("Blacksburg", "NA")
        39
    >>> cases.get("Princeton", "NA")
        'NA'
        
    # Output all keys as a list
    >>> cases.keys()
        dict_keys(['Riner', 'Christiansburg', 'Merrimac', 'Blacksburg', 'Elliston', 'Shawsville', 'Ironto', 'Prices Fork', 'Pilot'])
        
    # Output all values as a list
    >>> cases.values()
        dict_values([8, 22, 7, 39, 12, 44, 19, 1, 2])

    # Update one directory with the values of another:
    # The focal directory gets edited in place.
    # Values are added or updated but not deleted
    >>> D1 = {"a": 1, "b": 2, "c": 3}
    >>> D2 = {"a": 2, "d": 4, "e": 5}
    >>> D1.update(D2)
    >>> D1
        {'d': 4, 'e': 5, 'b': 2, 'a': 2, 'c': 3}
```

**Exercises:**

1.  Define a list `a = [1, 1, 2, 3, 5, 8]`.

2.  Extract `[5, 8]` in two different ways.

3.  Add the element `13` at the end of the list.

4.  Reverse the list.

5.  Define a dictionary `m = {"a": ".-", "b": "-...-", "c": ’-.-.’}`.

6.  Add the element `"d": "-.."`.

## More built-in functions

Now that we have covered more complex data types, lets look at some more
common built-in functions that can be used to do operations on them.

We can do basic numerical operations on lists of numbers.

``` bash
    # Create a list
    >>> a = [5, 6, 7, 7, 7, 8, 9, 9]
    # Maxumim value 
    >>> max(a)
        9
    # Minimum value
    >>> min(a)
        5
    # Sum of list
    >>> sum(a)
        58
    # Arithmetic mean of list
    >>> sum(a)/len(a)
```

We can apply some of the same operations to lists of strings

``` bash
    # Create b list
    >>> b = ["Computational", "Biology","BIOL 2214"]
    # Maxumim value in lexicographical order 
    >>> max(b)
        'Computational'
        
    # Minimum value
    >>> min(b)
        'BIOL 2214'

    # Similar with individual strings
    c = "BIOL 2214 Computational Biology"
    >>> max(c)
        'y'
```

We can use the `join()` method to join the values of a list of strings
into a single string

``` bash
    >>> seq = ["A","C","T","G"]

    # Join strings with dash as a delimiter 
    >>> "-".join(seq)
        'A-C-T-G'
        
    # Join them with no delimiter
    >>> "".join(seq)
        'ACTG'
```

We can also ask if a specific value is in a string using `in`.

``` bash
    >>> class = "BIOL 2214 Computational Biology" 
    >>> "B" in class
        True
    >>> 34 not in [1,2,3,4,5]
        5
        
    # Test if a key is in a dictionary
    >>> dict = {"a":1, "b":4, "c":3}
    >>> "f" in dict
        False
     
    # Test if value is in a dictionary
    >>> 4 in dict.values()
        True
```

## Final Problems

Answer the following questions in Markdown format within a folder in
your GitHub repository (e.g. `Practicals/W4/`. Add any scripts and other
files you create to the folder as well.

### About you

Create a script in a text editor and name it `about_me.py`. Remember to
use a shebang in the first line (`#!/usr/bin/env python3`).

-   Define variables that contain your name, favorite color, favorite
    activity, and favorite animal. Feel free to pick any data
    types/structures that you think would work.

-   Add code to print out your name and favorite color, activity, and
    animal **using the variables you declared above**. Remember
    `print()` can print out multiple strings, separated by commas. The
    output should be:

    ``` bash
        My name: Roberto
         My favorite color: Blue
         My favorite activity: Coding
         My favorite animal: Poison frogs
    ```

-   Save your file and run it from the terminal to produce the output
    above.

-   In your answer include the contents of your script, a general
    explanation of what your script does, and comments to explain each
    step.

### Codon to amino acid

The file `IntroBiolComp-2026/Python/DataFiles/CodonTable.tsv` contains a
table with the standard genetic code, which translates from DNA codon to
amino acid. In this problem you will write a script to translate a
sequence of codons to amino acids. You can write this script as a
standalone text file, or on a Jupyter notebook. Remember to add as many
explanations as you think are necessary for me to understand.

-   Create a dictionary with the `Codon` column as keys and `Symbol`
    column as values.

-   Create a string with the following sequence as input (including
    spaces)
    `"CTA GGA GTG ATT TCG"`.

-   Add code to split the string above into three-letter strings (i.e.
    codons).

-   Add code that uses your dictionary to match each codon to its
    corresponding amino acid, and saves the amino acid sequence as a
    list.

-   Print the amino acid sequence to the screen.
