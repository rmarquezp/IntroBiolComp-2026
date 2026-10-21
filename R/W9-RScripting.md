# R II: Scripting

## Scripts for Statistics

One of the most advantageous aspects of directly writing the code for
our statistical analyses is that we can perform all the steps in volved
in complex analyses automatically, making them more efficient and less
error-prone. Now that we've explored the basic functionalities of R as a
language, we will look at the mechanics of writing scripts in this
language. Much of the concepts that we will deal with have been covered
previously in Python and Unix, so we will focus on the specifics of the
R language.

### Reminder: Writing Good Code

Before we jump into R, however, it is good to remember the principles of
writing good code, which are universal to all languages.

#### Documenting

Documenting what your code is doing is central to its correctness,
trannsparency, and reusability. In R, comments are written using the
`#` character, which tells the
interpreter to ignore all text following that character. Usually larger
comments are used on single lines, while small, specific ones can be
included in the same line as your code, as long as they don't impede
code readability.

``` R
    # The sqrt() function calculates the square root of a number.
    > sqrt(2) # squared root of 2.
```

#### Spacing and Indentation

Just like natural languages, code is easier to read when it is easier to
process visually. Book publishers think carefully about the font type
and size, the line spacing, and all sort of other attributes of their
books to make them more appealing to readers. We should do the same with
our own code.

Using a single line per operation, and splitting longer lines is a good
way to do this. For instance, the code below creates a $3x4$ matrix and
transposes it, all in a single line.

``` R
    mat <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), nrow=3, ncol=4, byrow=T); matInv <- t(mat)
```

A more readable version of the same code would be as follows.

``` R
    mat <- matrix(c(1, 2, 3, 4,
                    5, 6, 7, 8,
                    9, 10, 11, 12), nrow=3, ncol=4, byrow=T)
    matTr <- t(mat)
```

Similarly, it is good to separate related blocks of code with blank
lines

``` R
    # Create matrices
    mat <- matrix(c(1, 2, 3, 4,
                    5, 6, 7, 8,
                    9, 10, 11, 12), nrow=3, ncol=4, byrow=T)
    matTr <- t(mat)

    # Do operations with them
    mult <- mat %*% matTr
```

Finally, indentation is a powerful tool to visualize how blocks of code
are related. Python *requires* the user to follow specific indentation
conventions to specify the structure of their code. In most other
computer languages, including R, structure is specified using
characters, such as curly brackets
(`{}`) or keywords, such as
`do` and
`done`. With this in mind, it is
important to follow some conventions to make code more readable to
ourselves and others. Generally, blocks of code nested under a
function/statement should be indented beyond that function/statement. In
addition, brackets/key words should be placed in ways that facilitate
reading. There are many indentation
[styles](https://en.wikipedia.org/wiki/Indentation_style), and (as
expected), some people feel very passionately about which ones are
correct. Pick one that works for you, and that you think will work for
others. If you're participating in a team effort, it is good practice
for all developers to use similar styles.

``` R
    # Difficult to read
    for(x in c(10,20,30)){
    print(x)
    if (x > 10) {print("Above ten")
    if (x > 20) {print("and also above 20!")
    } else {print("but not above 20.")}
    } else {print("Equal or below 10.")}

    # Easier to read
    for(x in c(10,20,30)){
        print(x)
        if (x > 10) {
            print("Above ten")
            if (x > 20) {
                print("and also above 20!")
            } else {
                print("but not above 20.")
            }
        } else {
            print("Equal or below 10.")
        }
    }
```

#### Modularity

Splitting our code into somewhat independent building blocks makes it
easier to understand debug, and repurpose. We will cover useful
approaches to this end in R, such as defining functions and running
individual scripts from the terminal.

## Loops and Conditionals

As we've seen before, the ability for our code to perform similar
versions of the same task many times (loops), and to automatically make
simple decisions (based on conditionals) is central to writing more
complex and efficient programs. Below we will go over conditional
statements and basic loops in R.

### Conditionals

R uses the functions `if()`,
`else if()`, and
`else()` to handle conditionals.
The basic anatomy of an if \... else statement in R is

``` R
    if(condition is met){
        do(something)
    } else {
        do(some other thing) #optional
    }
```

Note how the `else` statement is in
the same line as the closing brackets from
`if()`. This is so R knows that the
`else` statement corresponds to that `if`. To demonstrate conditionals
in R, lets write a script that takes a user input and tells us whether
it is an even or odd number.

``` R
    # read user input and convert to numeric data
    z <- readline(prompt = "Enter a nuber: ")
    z <- as.numeric(z)

    # Test whether it is even or odd and print result
    if(z %% 2 == 0){
      print(paste(z, "is even"))

    } else {
      print(paste(z, "is odd"))
    }
```

Run this in RStudio with `Ctrl+Shift+S` (not `Ctrl+Enter` like we do for
individual lines of code). This runs your code as an entire script and
not as if you were inputting each line independently onto the console.

``` R
    Enter a nuber: 5
    [1] "5 is odd"
```

``` R
    Enter a nuber: 18
    [1] "18 is even"
```

**Exercise:** Write a script that takes a number from the user
interactively and returns either \"Fizz\", \"Buzz\", or the number,
based on the [*fizz, buzz*](https://en.wikipedia.org/wiki/Fizz_buzz)
game.

### Loops

R provides three different loop architectures: `for`, `while`, and
`repeat`. `for` loops run over a defined set of values, while the other
two run until a pre-specified condition is met (`repeat`) or stops being
true (`while`).

#### `for`

In R, `for` loops iterate over the elements of a vector or a list. Their
basic architecture is

``` R
    for(i in [vector]){
        execute
        some
        commands
    } # moves to the next element
```

For example

``` R
    v <- 1:10
    for(i in v){
      print(paste(c(i , i^3), sep="\t" ))
    }
```

When convenient, we can also specify our vector/list within the
`for()` command.

``` R
    for(i in 1:10){
      print(paste(c(i , i^3), sep="\t" ))
    }
```

We can save the output of a loop in an object by creating an empty
object beforehand and populating it as the loop iterates.

``` R
    # Perform an operation on every element of a vector
    # and save the output to a new vector

    v <- 1:10

    #create empty vector for results
    v_3 <- c()

    for(i in v){
      v_3[i] <- v[i]^3
    }
```

Each iteration, the code above saves the cube of the `i`th element of
`v` as the `i`th element of `v_3`.

#### `while`

The `while` loop, on the other hand, iterates as long as a condition is
met. This means that we must define the starting condition, and we must
`update` this condition in every iteration in some way so the loop
eventually stops. The basic architecture of `while` loops is

``` R
    while(condition is TRUE){
        execute 
        commands

        update condition
    }
```

For instance, if we want to find the first four numbers divisible by
137, we could use the following `while` loop:

``` R
    # Begin at 137, which is the smallest number divisible by 137
    x <- 137

    # Empty vector to store results
    res <- c()

    # Counter for number of found items
    found <- 0

    # While we have found less than 4 numbers
    # Ask whether a number is divisible by 11
    # If yes, store it in results, if not keep going

    while(found < 4){
        if(x %% 137 == 0){
            res <- c(res, x)
            found <- found + 1
        }
        x <- x + 1
    }
```

If we run the code above, the vector `res` will end up with four
numbers.

``` R
    > res
    [1] 137 274 411 548
```

Which are, indeed, the first four multiples of 137.

#### `repeat`

`repeat` loops are very similar to `while` loops. They will iterate
until we tell them to stop. Like any command, we can do this manually by
hitting `Ctrl + c` or the `esc` key (this only works in R), but this
would be very impractical, so we usually stop `repeat` loops using
conditionals and the `(`break)
command.

For example, if we wanted to print a statement 5 times with a `repeat`
loop, we could use the following code.

``` R
    times <- 0
    repeat{
      print("Hello!")
      times <- times+1
      if(times >= 5){
        break
      }
    }
```

**Exercise:** Write a `repeat` loop that finds the first four numbers
divisible by 137, as we did using a `while` loop in the previous
section.

## Functions and packages

One of the biggest strengths of coding up your own statistical analyses
is that you can create your own functions that allow users to conduct a
specific analysis in an automated way. As in other languages, users
often publish compilations of such functions, together with
documentation and example datasets, as *packages*.

### Functions

In R, functions are defined using
`function()`. In its simplest form,
a function executes a fixed set of commands any time it is called.

``` R
    tellfortune <- function(){
        fortune <- sample(
        c("Today will be great", "Don't get out of bed"),
         1, p=c(0.25, 0.75))
        
        print(fortune)
    }
```

The function above will always do exactly the same: Print
randomly-generated advice to the screen so the user knows what to do in
the morning. If we want to be able to save the output of our function as
a variable, we can use `return()`.

``` R
    tellfortune <- function(){
        fortune <- sample(
        c("Today will be great", "Don't get out of bed"),
         1, p=c(0.25, 0.75))
        
        return(fortune)
    }
```

``` R
    > tellfortune()
    [1] "Today will be great"
    > what_to_do <- tellfortune()
    > what_to_do
    [1] "Don't get out of bed"
```

We can add further flexibility to our functions by passing arguments
that are saved as variables

``` R
    tellfortune <- function(day){
        if(day == "Monday"){
            fortune <- "Don't get out of bed"
        } else{
            fortune <- sample(
            c("Today will be great", "Don't get out of bed"),
             1, p=c(0.25, 0.75))
            }
        return(fortune)
    }
```

Functions can get quite complex and often use many arguments. If we
don't want to have to explicitly declare each argument every time we run
a function, we can include *default* values in our function declaration.

``` R
    tellfortune <- function(day="Wednesday"){
        if(day == "Monday"){
            fortune <- "Don't get out of bed"
        } else{
            fortune <- sample(
            c("Today will be great", "Don't get out of bed"),
             1, p=c(0.25, 0.75))
            }
        return(fortune)
    }
```

**Exercise:** Write a function that tests whether an integer number is
prime (i.e. only divisible by 1 and itself).

#### Loading functions from files

If you have a function that you use often, you may want to avoid writing
it into every script where you need to use it. This can be avoided by
saving your function (or multiple functions) in a text file (usually
with a `.R` extension), and load it
using the `source()` command. For
instance, if we saver our function above in a file called `fortune.R`,
we can call it from a new script as

``` R
    > load(fortune.R)
    > tellfortune(day="Monday")
    [1] "Don't get out of bed"
```

### Packages

As mentioned above, there are thousands of R packages available for use.
The \"official\" repopsitory for R packages is called the Comprehensive
R Archive Network, and has over 25,000 packages. Packages from CRAN can
be installed in two ways. From the R console we can use
`install.packages("package_name")`
to download and install packages. Some IDEs also have \"point and
click\" ways to install packages. In RStudio this can be done under the
\"Packages\" tab in the bottom right panel. Once a package is installed
it can be loaded using the
`library([package_name])` command.

Many biology packages are, however, not hosted on CRAN. Many of them are
hosted on GitHub and on the [Bioconductor](https://bioconductor.org/)
repository, which focuses on high-throughput sequencing and other
genetic data. Packages from both repositories can be installed with
dedicated functions.

To illustrate package use lets install the `edgeR` package, which has
several functions to analyze gene expression data. First, lets install
the `BiocManager` package from CRAN. This package allows us to install
other packages hosted in Bioconductor.

``` R
    install.packages("BiocManager")
```

You may be prompted to pick a server from which to download the
packages. Any of them will do. Now lets use `BiocManager` to install
`edgeR`

``` R
    library(BiocManager)
    install("edgeR")
```

Because function names such as
`install()` are probably in many
packages, we can specify which one we mean by appending the package name
to the function name, separated by two colons
(`::`).

``` R
    library(BiocManager)
    BiocManager::install("edgeR")
```

## Final Problems

Answer the following questions in a **single markdown-formatted
document** within a folder in your GitHub repository (e.g.
`Practicals/W9/`). Add any scripts and other files you create to the
folder as well.

### File Processing

The folder `R/DataFiles/Saavedra2013` contains a large number of text
files, each of which contains a matrix of different dimensions. Each
matrix contains a series of 1 and 0 entries that encode a network of
ecological interactions.

Write an R script that loads every file, reports the number of rows and
columns in each matrix, as well as the proportion of entries that are 1
and 0. Report your results in a tab-delimited file called
`MatrixStats.tsv` as follows

``` R
    File    Nrow    Ncol    p_1 p_0
    n1.txt  97  80  0.0458  0.9541
    ...
```

**Note:** you may want to use either some `Unix` commands or the
`list.files()` function to get a
list of file names that you can loop over.

### Leaf areas

A researcher took images of plants a two time points during an
experiment, and wants to calculate the leaf area of each plant based on
the photos as a measure of growth between time points. She also wrote an
R function that uses the EBImage package, available from Bioconductor.
The directory `R/DataFiles/leafarea` contains all photos, and their file
names include the time point and individual plant number. For example
`t2_B21m.JPG` is individual `B21m` imaged at timepoint `t2`.

1.  Install the `EBImage` package as specified
    [here](https://bioconductor.org/packages/release/bioc/html/EBImage.html).

2.  Write a for loop that processes all images using the function
    getArea, which is provided in `R/DataFiles/leafarea/getArea.R`. The
    function accepts a single file name as an argument, and returns the
    projected leaf area, measured in pixels. Your loop should record the
    leaf area for each image, and store it in the data frame `results`.
    You can, again, use `Unix` or
    `file.list()` to loop over all
    files with extension `.JPG`.

3.  Calculate the change in leaf area between time points 1 and 2 for
    each plant, and add it as a column in your data frame. How much did
    the leaves grow between time points on average?

4.  Save your results as a comma-separated file and include them in your
    repository.
