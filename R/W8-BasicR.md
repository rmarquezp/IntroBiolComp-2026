# Statistical Computing in R: The Basics

## What is Statistical Computing?

Using statistics to analyze data and make inferences is at the core of
science. Not surprisingly, a vast amount of software has been developed
to do this, including programming languages that allow users to write
code that performs their analyses. Using these languages to analyze our
data makes us more efficient at it, and, most importantly, allows us to
repeat analyses *exactly* as we did previously. This makes our science
more transparent and replicable.

Over the previous few weeks we have been using textttPython, which is a
very powerful *general-purpose* programming language. Although one
modules to conduct statistical analyses have been developed in `Python`,
it is good to learn how to use programming languages specifically
written with a particular task in mind, such as statistics. In this
class we will be using the 'R' language for statistical computing. This
being said, other programs such as `MATLAB` (or its open-source clone
`Octave`), `Julia`, and `Mathematica` are also popular in the
statistical/mathematical computing world, and worth looking into if you
feel `R` is not well-suited for your particular needs.

## The `R` language

`R` is arguably the most popular statistical programming language in the
biological sciences community. It was developed specifically for
statsitical analysis and data visualization. Similar to `Python` its
core code can be complemented by the use of *packages* (similar to
modules). Given its popularity, thousands of `R` packages have been
developed to implement all sorts of biological data analyses. With this
in mind, beinf fluent in `R` will definitely work to your advantage in
our field.

## Getting started in `R`

### Running `R` from the Terminal

The most basic way to start an `R` session is from the terminal, by
using the command `R`. This will
launch an `R` interpreter with which we can interact by typing commands.

``` R
    # Launch R
    $ R
    R version 4.5.2 (2025-10-31) -- "[Not] Part in a Rumble"
    Copyright (C) 2025 The R Foundation for Statistical Computing
    Platform: x86_64-pc-linux-gnu

    R is free software and comes with ABSOLUTELY NO WARRANTY
    You are welcome to redistribute it under certain conditions.
    Type 'license()' or 'licence()' for distribution details
    ...

    Type 'q()' to quit R.

    > print("Hello world")
    [1] "Hello world"

    # Squared root of 4
    > sqrt(4)
    [1] 2

    # End session 
    q()
```

As with other languages, we can also run `R` scripts directly from the
terminal.

``` R
    #!/usr/bin/env Rscript

    print("Hello world, the squared root of 2 is")
    sqrt(2)
```

We can run it from the terminal

``` R
    $ Rscript hello.R
    [1] "Hello world, the squared root of 2 is"
    [1] 1.414214
```

**Note:** The `R` prompt is `>`.

It is very common for users to run commands \"line by line\" when
working in `R` especially if they're doing statistics, since we often
want to know the output of a function before deciding the next step.
This being said, sometimes having an `R` script that does a complex task
can be very helpful, for example to process large numbers of files (or
very big files) in the same way.

### Getting help

Just like every other computer language, `R` is to extensive for one
person to learn. If you have an idea of what you want to do, but not of
the specific commands you should use, it is always a god idea to start
by searching the internet. Searches such as \"reading a table into R\"
can be very efficient in revealing the relevant commands for you to
start coding.

In addition, `R` has a built-in manual. To access the manual for a
specific command/function, you can type
`?[command name]`. For example
`?mean`. If you're not sure of the
specific name of the command you're looking, you can search for key
words across the documentation for all functions installed in your
computer using `??`. For instance
`?glm` will search for all
functions that include \"glm\" in their name or associated key words.
You can even use regular expressions in your searches.
`??"^glm"` will, for example, look
for all functions whose names or key words *start* with \"glm\".

### `RStudio`

There are many integrated development environments (IDEs) that can be
used to run R. It is most likely that your installation of `R` came with
a very basic IDE where you can write and run `R` code. A very popular
IDE is `RStudio`, which includes a text editor and console, and makes
many aspects of your workspace easily accessible (e.g. variables,
directories, plots). If you haven't installed `RStudio`, you can find
instructions
[here](https://github.com/rmarquezp/IntroBiolComp-2026/blob/main/R/Setup.md).

To start coding from `RStudio`, open it and go to
`File `$\rightarrow$` New File `$\rightarrow$` ``R`` Script`. You can
also use `Ctrl + Shift + N` to do this (or `Command + Shift + N` on
mac). A script editor should open. You can type your code in it, and use
`Ctrl + Enter` to run each line. You can select multiple lines with your
mouse and use `Ctrl + Enter` to run them all at once. `Ctrl + Shift + S`
to run your entire script at once.

Finally, like many other IDEs (and the Unix shell), hitting the `Tab`
key serves an auto-complete function.

**Exercise:** Run code that prints "Hello world\" to the screen on the
terminal and in `RStudio`.

### Basic operations

In R, most functions are run by invoking the function name, and
enclosing its arguments in parenthesis. For example, above we calculated
$\sqrt{2}$ using

``` R
    > sqrt(2)
```

Typing `Ctrl + Enter` runs the command:

``` R
    > sqrt(2)
    [1] 1.414214
```

In addition to functions, `R` has many arithmetic and logical operators
that can be used. For example

``` R
    > 2 + 2 * 3  # addition and multiplication
    [1] 8
    > (2 + 2) * 3 # parentheses for order of operations
    [1] 12
    > 3 / 2 # division
    [1] 1.5
    > 5 %/% 2 # integer division
    [1] 2
    > 5 %% 2 # modulo division
    [1] 1
    > 5^3 # exponential
    [1] 125
    > 4 > 1 # "greater than" operator
    [1] TRUE
    > 2 + 2 == 5 # "is equal to" opeartor False
    [1] FALSE
    > 3 != 2 # "is not equal to" operator True
    [1] TRUE
```

### Variables

In `R` variables can be assigned in two ways. The traditional way uses
an arrow built by combining the \"minus\" and \"less than\" characters:
`<-`. In most IDEs this character
can be generated by pressing `Alt + -` (i.e. `Alt` and the minus sign).

``` R
    > x <- 5 
    > x 
    [1] 5

    # works in the oposite direction
    > 16 -> a
    > a
    [16]

    # Perform operations with variables
    > x * a
    [80]
```

Variables can also be assigned using a single \"equals\" sign
`=`, but this is frowned upon by
some `R` purists.

``` R
    > x = 5 
    > x 
    [1] 5
```

If we want to list the variables currently defined in out environment we
can use

``` R
    > ls()
    [1] "x" "b"
```

## Data Types

R has a multitude of data types implemented, which define the types of
operations that can be performed on them. In fact, many `R` packages
define new data types and their corresponding operations. We can know
the data type of a particular variable using the
`class()` command, and can convert
between data types using the
`as.[type]()` command. We can also
ask whether a variable is of a particular data type using
`is.[type]()`.

``` R
    # Define a numeric variable
    > x <- 5.2
    > class(x)
    [1] "numeric"

    # Convert to integer
    > b <- as.integer(x)
    > b
    [1] 5
    > class(b)
    [1] "integer"

    # ask if x is an integer
    > is.integer(x)
    [1] FALSE
```

### Numerical data types

Numerical data can be saved as three different types. We just saw
`integer` and `numeric` variables above. `Numeric` data are *floating
point* numbers, that is, numbers that represent a position along a
continuous scale, and can therefore have decimals. By default, numbers
are stored as `numeric` data in `R`. `Integers` are whole numbers, often
used to express count data. To save variables as integers one must use
`as.integer()`, as done above.

A third numerical data type in R are complex numbers, which include a
real and an imaginary part, such as $3+2i$, where $i=\sqrt{-1}$ is the
imaginary part. They must be defined using $a+bi$ notation.

``` R
    > f <- 3+2i
    > class(f)
    [1] "complex"
```

Being meant for statistical and mathematical computation, there are
plenty of built-in functions in R that can be applied to numerical
variables. For example

``` R
    > abs(-4.22) # absolute value
    [1] 4.22
    > ceiling(4.22) # Nearest integer upwards
    [1] 5
    > floor(4.22) # Nearest integer downwards
    [1] 4
    > trunc(4.22) # Integer portion
    [1] 4
    > log(100) # Natural log
    [1] 4.60517
    > log10(100) # Base 10 log
    [1] 2
    > exp(2.3) # e^x
    [1] 9.974182
    > 2e4 # 2*10^4
    [1] 20000
    > round(7.3355526622, digits=2) # round to two decimals
    [1] 7.34
    > pi # pi is saved as a variable
    [1] 3.141593
    > cos(pi) # cosine 
    [1] -1
```

### Characters (i.e. Strings)

Single elements consisting of a string of characters can be saved as
character data. Although R is not especially fast or flexible for text
manipulation (as, for example `Python` is), it has several built-in
functions to manipulate strings.

To assign a string we need to surround it with quotation marks.

``` R
    > seq <- "GAT TAG ACT TTA"
    > class(seq)
    [1] "character"

    > strsplit(seq, split=" ") #Split by specific character
    [[1]]
    [1] "GAT" "TAG" "ACT" "TTA"

    > substr(seq, start=5, stop=8) # extract a substring
    [1] "TAG "

    > gsub("T", "U", seq) # replace a substring
    [1] "GAU UAG ACU UUA"

    > nchar(seq) #Count the number of characters
    [1] 15

    > tolower(seq)        # Set to lowercase
    [1] "gat tag act tta"
    > toupper(seq)        # Set to uppercase
    [1] "GAT TAG ACT TTA"

    > seq2 <- gsub(" ", "", seq) # Remove spaces

    # join strings and insert separator
    > paste("The sequence is", seq2, sep=" ")
    [1] "The sequence is GATTAGACTTTA"

    # join strings with other data types
    > paste("The sequence has", nchar(seq2), "base pairs", sep=" ") 
    [1] "The sequence has 12 base pairs"
```

### Logical (i.e. Boolean)

R also allows us to use logical variables, also known as boolean, which
can be either `TRUE` or `FALSE`. These variables behave similarly to
integers, in that the value "True\" takes a value of 1 and "False\" of
0.

``` R
    > closed <- TRUE
    > class(closed)
    [1] "logical"

    # TRUE and FALSE can be abbreviated
    > open <- FALSE
    > open
    [1] FALSE

    > open <- F
    > open
    [1] FALSE

    > closed <- T
    > closed
    [1] TRUE

    # We can perform mathematical operations on logical variables

    > open + closed
    [1] 1
```

Logical variables are the output of logical operators, such as
`==` (\"is equal to\"). Some
commonly used logical operators are below.

``` R
    > 2 == 3 # is equal to
    [1] FALSE
    > 2 != 3 # is not equal to
    [1] TRUE
    > 5 > 5 # greater than
    [1] FALSE
    > 5 >= 5 # greater than or equal to
    [1] TRUE
    > 5 <= 5 # less than or equal to
    [1] TRUE
    > 5 < 4 # less than 
    [1] FALSE
    > is.numeric(4) & 4 %% 2 == 0 # 4 is numeric AND (&) divisible by 2
    [1] TRUE
    > 4 < 2 | 2 > 1 # 4 < 2 OR (|) 2 > 1
    [1] TRUE
```

## Data structures

R allows us to organize data made up of multiple elements in several
different types of data structures, each of which has specific
operations that can be performed on it.

### Vectors

The simplest data structure in R is called a *vector*. Vectors are
ordered collections of values of the *same data type*. They are declared
using the `c()` command, which
<u>c</u>oncatenates multiple elements.

``` R
    > x <- c(3, 4, 2, 5, 6, 7, 22, 3, 4, 3, 2)
    > x
     [1]  3  4  2  5  6  7 22  3  4  3  2
```

We can access the elements of our vector by *indexing* them with square
brackets.

``` R
    > x[2]  # Access the second element
    [1] 4
    > x[3:6]  # Access elements 3-6
    [1] 2 5 6 7
    > x[c(1,3,5)]  # Access values 1, 3, 5
    [1] 3 2 6

    # Replace elements 2 and 4 for different values
    > x[c(2,4)] = c(0,45)
    > x
     [1]  3  0  2 45  6  7 22  3  4  3  2
     
     # Remove element 7
     > x[-7]
     [1]  3  0  2 45  6  7  3  4  3  2
```

Note that, in contrast to `Python` and `Unix`, `R` is one-indexed, so it
begins counting at 1, and does include the last value of a given range.

We can also declare vectors made up of other data types, such as logical
or character elements.

``` R
    > x <- c(3, 4, 2, 5, 6, 7, 22, 3, 4, 3, 2) # numeric vector
    > class(x)
    [1] "numeric"
    > y <- c("one", "two", "three", " four") # character vector
    > class(y)
    [1] "character"
    z <- c(T, T, F, T, F) # logical vector
    > z
    [1]  TRUE  TRUE FALSE  TRUE FALSE
    > class(z)
    [1] "logical"
```

As mentioned above, all elements in a vector have to be of the same data
type. If we pass elements of different types, R will coerce them all
into the same type, and will try to guess which is more appropriate

``` R
    > n <- c(1, 3, TRUE, FALSE)
    > n
    [1] 1 3 1 0  #converted conditionals to numbers
    > class(n)
    [1] "numeric"

    > m <- c(1, 3, "hello", TRUE, FALSE)
    > m
    [1] "1"     "3"     "hello" "TRUE"  "FALSE" 
    > class(m)
    [1] "character"  # Converted all elements to characters
```

We can define long vectors using ranges and sequences

``` R
    # All numbers from 5-42
    > vec <- 5:42
    > vec
     [1]  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 
    [18] 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 
    [35] 39 40 41 42
     
    # 5.5 to 10.5
    > vec <- 5.5:10.5
    > vec
    [1]  5.5  6.5  7.5  8.5  9.5 10.5

    # From 0 to 1 every 0.25
    > vec <- seq(0, 1, 0.25)
    > vec
```

We can also use the `rep()`
function to repeat values multiple times.

``` R
    # Repeat "hello" 5 times
    > rep("hello", 5)
    [1] "hello" "hello" "hello" "hello" "hello"

    # Repeat the sequence (3,1,2) 4 times. 
    > rep(c(3, 1, 2), 4)
     [1] 3 1 2 3 1 2 3 1 2 3 1 2

    # Repeat "how" twice, "are" once, and "you" 4 times. 
    > rep(c("how","are","you"), c(2,1,4))
    [1] "how" "how" "are" "you" "you" "you" "you"
```

There are many built-in statistical functions that can be performed on
vectors.

``` R
    > length(x) # number of elements
    [1] 11
    > sum(x) # sum of all elements
    [1] 61
    > prod(x) # product of all elements
    [1] 7983360
    > min(x) # minimum value
    [1] 2
    > max(x) # maximum value
    [1] 22
    > range(x) # range of values
    [1]  2 22
    > mean(x) # arithmetic mean
    [1] 5.545455
    > median(x) # median
    [1] 4
    > var(x) # sample variance
    [1] 32.27273
    > sd(x) sample standard deviation
    [1] 5.680909
    > quantile(x, 0.9) # nth quantile (or percentile)
    90% 
      7 
    > summary(x) # print a summary
       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      2.000   3.000   4.000   5.545   5.500  22.000 
```

#### Factors

A key type of variable in statistics are *factors*. These are variables
used for grouping subjects according to some condition. For example, the
treatments in an experiment, the sex of study subjects, or the disease
status of a patient. R usually won't define a vector as a factor, so we
often have to do this manually using
`as.factor()`.

``` R
    > vis <- c("bear", "racoon", "cat", "bear", "racoon", "cat", "racoon", "cat", "racoon", "racoon", "racoon")
    > class(vis)
    [1] "character"
    > summary(visits)
       Length     Class      Mode 
           11 character character

    # Convert to factor
    > visits <- as.factor(vis)
    > class(visits)
    [1] "factor"

    > summary(visits)
      bear    cat racoon 
         2      3      6 
         
```

**Exercises:**

1.  Create a vector containing all the even numbers between 2 and 100
    (inclusive) and store it in the variable z.

2.  What is the sum of all the elements of z?

3.  Is the sum of the elements of z equal to 51 × 50?

4.  What happens if you type `z^2`?

5.  What happens if you type
    `z >= 90`?

6.  What happens if you type
    `which(z >= 90)`?

### Matrices

R has several data structures with more than one dimension. For example,
matrices are two-dimensional tables, made up of elements of a single
type. They can be very useful to perform matrix operations (e.g.
inverse, decomposition, etc\...), which are at the heart of multivariate
statistical analyses.

Matrices are declared with the
`matrix()` function, which takes
three arguments: A vector with values, the number of rows and columns.
Some additional (optional) arguments are whether we want to populate our
matrix by rows or columns, or assign dimension names.

``` R
    # 3 rows, two columns, fill by columns (default)
    > mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3, ncol = 2)
    > mat
         [,1] [,2]
    [1,]    1    4
    [2,]    2    5
    [3,]    3    6

    # Fill by rows
    > mat <- matrix(1:6, nrow = 3, ncol = 2, byrow = T)
    > mat
         [,1] [,2]
    [1,]    1    2
    [2,]    3    4
    [3,]    5    6

    # Name rows and columns
    > dimnames(mat) <- list(c("r1","r2","r3"), c("c1","c2"))
    > mat
       c1 c2
    r1  1  2
    r2  3  4
    r3  5  6

    # Matrix of character elements
    # Note how nrow and ncol don't need to be defined if they are in the right order. 
    > m <- matrix(c("one", "two", "three", "four"), 2, 2)
    > m
         [,1]  [,2]   
    [1,] "one" "three"
    [2,] "two" "four"
```

We don't always need to provide each individual value for a matrix. If
we provide a vector shorter than the number of elements in a matrix,
this vector will get *recycled* until the matrix is filled.

``` R
    # matrix made up entirely of ones
    > matrix(1, nrow = 3, ncol = 2)
         [,1] [,2]
    [1,]    1    1
    [2,]    1    1
    [3,]    1    1

    # every row is 1  2
    > matrix(1:2, nrow = 3, ncol = 2, byrow = T)
    > mat
         [,1] [,2]
    [1,]    1    2
    [2,]    1    2
    [3,]    1    2

    # Same as above but populate by columns
    > matrix(1:2, nrow = 3, ncol = 2, byrow = F)
         [,1] [,2]
    [1,]    1    2
    [2,]    2    1
    [3,]    1    2
```

We can gather information about a matrix

``` R
    > nrow(mat) # number of rows
    [1] 3
    > ncol(mat) # number of columns
    [1] 2
    > dim(mat) #dimensions
    [1] 3 2
```

We can index matrices in a similar way to vectors, using square
brackets. However, since they have two dimensions, we must provide two
indices as `mat[row,col]`.

``` R
    > mat
       c1 c2
    r1  1  2
    r2  3  4
    r3  5  6

    # access 3rd row second column. 
    > mat[3,2]
    [1] 6

    # access the entire second row
    > mat[2,]
    c1 c2 
     3  4 
     
     # access the entire first column
     > mat[,1]
    r1 r2 r3 
     1  3  5 
```

R can readily perform many operations on matrices using built-in
functions.

``` R
    > M <- matrix(c(4,3,5,6), nr=2, nc=2)
    > M
         [,1] [,2]
    [1,]    4    5
    [2,]    3    6

    # Perform an operation on every element
    > M + 2
         [,1] [,2]
    [1,]    6    7
    [2,]    5    8

    # Inverse of a matrix
    > solve(M)
               [,1]       [,2]
    [1,]  0.6666667 -0.5555556
    [2,] -0.3333333  0.4444444

    # Matrix multiplication
    > M %*% solve(M)
         [,1] [,2]
    [1,]    1    0
    [2,]    0    1

    # Extract the diagonal elements
    > diag(M)
    [1] 4 6

    # Transpose a matrix
    > B <- matrix(1:3, 3, 2)
    > B
         [,1] [,2]
    [1,]    1    1
    [2,]    2    2
    [3,]    3    3
    > t(B)               # t() transposes
         [,1] [,2] [,3]
    [1,]    1    2    3
    [2,]    1    2    3
```

### Data Frames

Scientific data is very often made up of variables containing different
data types. Data frames are tables whose columns can be of different
data types, similar to a typical spreadsheet containing data. Typically,
the rows of a data frame contain different samples (e.g. patients,
experimental subjects, replicates of an experiment), and columns
different variables measured on these samples.

Data frames can be created using the
`data.frame()` function, which
takes multiple vectors that will make up the columns of our data frame.
For example

``` R
    > ID <- c("Plant_1", "Plant_2", "Plant_3", "Plant_4") 
    > Treatment <- as.factor(c("Fertilizer", "Control", "Fertilizer", "Control"))
    > DryWeight <- c(22, 24, 31, 27)
    > df <- data.frame(ID, Treatment, DryWeight)
    > df
           ID  Treatment DryWeight
    1 Plant_1 Fertilizer        22
    2 Plant_2    Control        24
    3 Plant_3 Fertilizer        31
    4 Plant_4    Control        27
```

We can gather information about a data frame similar to how we did with
matrices.

``` R
    > nrow(df) # number of rows
    [1] 4
    > ncol(df) # number of columns
    [1] 3

    > str(df) # structure of the data frame
    'data.frame':   4 obs. of  3 variables:
     $ ID       : chr  "Plant_1" "Plant_2" "Plant_3" "Plant_4"
     $ Treatment: Factor w/ 2 levels "Control","Fertilizer": 2 1 2 1
     $ DryWeight: num  22 24 31 27

    > head(df, 2) # print first two rows. 
           ID  Treatment DryWeight
    1 Plant_1 Fertilizer        22
    2 Plant_2    Control        24
```

Data frames elements are also indexed

``` R
    > df[1:3,] # First three rows
           ID  Treatment DryWeight
    1 Plant_1 Fertilizer        22
    2 Plant_2    Control        24
    3 Plant_3 Fertilizer        31

    > df[,c(2,3)] # Second and third column
       Treatment DryWeight
    1 Fertilizer        22
    2    Control        24
    3 Fertilizer        31
    4    Control        27

    > df$Treatment # Select column by name
    [1] "Fertilizer" "Control"    "Fertilizer" "Control"   
    > df$Treatment[4] # Select column by name, return 4th element. 
    [1] "Control"

     #Use conditionals to select rows on value
    > df[df$Treatment == "Control",]
           ID Treatment DryWeight
    2 Plant_2   Control        24
    4 Plant_4   Control        27
```

We can also add new columns to data frames, or merge different data
frames.

``` R
    # Join two data framesby column
    df2 <- data.frame(height = c(125, 110, 108, 146), LArea = c(4, 8, 2, 5))
    > df2
      height LeafArea
    1    125        4
    2    110        8
    3    108        2
    4    146        5

    # cbind() joins by columns, rbind() by rows
    > df_all <- cbind(df, df2) 
    > df_all
           ID  Treatment DryWeight height  LArea
    1 Plant_1 Fertilizer        22    125      4
    2 Plant_2    Control        24    110      8
    3 Plant_3 Fertilizer        31    108      2
    4 Plant_4    Control        27    146      5

    # Add a column named "Exp"
    > df_all$Exp <- c("Sarah", "Sarah", "John", "John")
    > df_all
           ID  Treatment DryWeight height  LArea     Exp
    1 Plant_1 Fertilizer        22    125      4   Sarah
    2 Plant_2    Control        24    110      8   Sarah
    3 Plant_3 Fertilizer        31    108      2    John
    4 Plant_4    Control        27    146      5    John
```

**Exercises:**

Typing data frames into R can be tedious. We usually read them in from
files, as we will see in section 6. R ships with many example datasets,
which can be loaded with the command
`data()`. For the following
exercises we will use a dataset called `trees`.

1.  Load the `trees` dataset by typing
    `data(trees)`. How many rows
    and columns does this data frame have? What types of data are in
    each one?

2.  What is the average height of the cherry trees?

3.  How many trees are more than 75ft tall?

4.  What is the average girth of those that are more than 75ft tall?

### Lists

When we want to store more complex objects that are themselves made up
of multiple objects, we can use *lists*. Lists can come in very handy
when we want to store and perform operations on large amounts of data.
For example, R handles phylogenetic trees as lists that contain a vector
with species names, and several matrices and vectors describing the
topology and branch lengths of the tree. Optionally data about each node
(e.g. ancestral states) can be included as well.

Lists are defined using the
`list()` command, which takes as
argument each of the objects stored in the list, known as elements.
Optionally, we can asskign names to these objects as we did above for
the dataframe `df2`.

``` R
    > my_list <- list(df = df, Matrix = M, visits = visits, numbers = seq(0,20,4))
    > my_list
    $df
           ID  Treatment DryWeight
    1 Plant_1 Fertilizer        22
    2 Plant_2    Control        24
    3 Plant_3 Fertilizer        31
    4 Plant_4    Control        27

    $Matrix
         [,1] [,2]
    [1,]    4    5
    [2,]    3    6

    $visits
     [1] bear   racoon cat    bear   racoon cat    racoon cat    racoon racoon
    [11] racoon
    Levels: bear cat racoon

    $numbers
    [1]  0  4  8 12 16 20
```

Lists can be indexed in a similar way to other objects.

``` R
    # Access element "visits" by name
    > my_list$visits
     [1] bear   racoon cat    bear   racoon cat    racoon cat    racoon racoon
    [11] racoon
    Levels: bear cat racoon

    # Access the third element by its index
    > my_list[[3]]
     [1] bear   racoon cat    bear   racoon cat    racoon cat    racoon racoon
    [11] racoon
    Levels: bear cat racoon

    # Access the second column of the first row of the matrix in the second element of the list. 
    > my_list[[2]][1,2]
    [1] 5
```

## Reading and Writing Files

Unless you're doing pure theoretical work (e.g. simulations), you will
load your data into R from files. There are packages with functions to
read virtually every data type into R. However, for most basic
statistical applications our best bet are delimited tables. In R,
delimited tables can be imp\[orted using the
`read.table()` function. As oposed
to `Python`, `R` reads in files and saves them as objects automatically.
This has the advantage that we don't have to iterate through the whole
file to save it or perform operations, but has the disadvantage of
needing much more memory to load the entire file (especially for large
files!).

In `IntroBiolComp-2026/R/DataFiles` there is a file called
`H938_Euro_chr6.geno`, which contains genotypes at roughly 43,000 sites
of chromosome 6 for subjects of European ancestry. Lets take a peek at
this file on the terminal to gather some initial information:

``` R
    $ head -n 4 H938_Euro_chr6.geno
    CHR SNP A1 A2 nA1A1 nA1A2 nA2A2
    6 rs4959515 A G 0 17 107
    6 rs719065 A G 0 26 98
    6 rs6596790 C T 0 4 119
```

The file has 7 columns, and seems to be separated by spaces. Lets read
it into R.

``` R
    # read in table delimited by spaces (" ")
    > geno <- read.table("H938_Euro_chr6.geno", sep=" ")
    > str(geno)
    'data.frame':   43142 obs. of  7 variables:
     $ V1: chr  "CHR" "6" "6" "6" ...
     $ V2: chr  "SNP" "rs4959515" "rs719065" "rs6596790" ...
     $ V3: chr  "A1" "A" "A" "C" ...
     $ V4: chr  "A2" "G" "G" "T" ...
     $ V5: chr  "nA1A1" "0" "0" "0" ...
     $ V6: chr  "nA1A2" "17" "26" "4" ...
     $ V7: chr  "nA2A2" "107" "98" "119" ...
```

Our file was read in with no errors, but it seems like all variables
were read in as characters. This is probably because R wasn't expecting
our file to have a *header* line. That is, a first line with column
names.

``` R
    > geno <- read.table("H938_Euro_chr6.geno", sep=" ", h=T)
    > str(geno)
    'data.frame':   43141 obs. of  7 variables:
     $ CHR  : int  6 6 6 6 6 6 6 6 6 6 ...
     $ SNP  : chr  "rs4959515" "rs719065" "rs6596790" "rs6596796" ...
     $ A1   : chr  "A" "A" "C" "A" ...
     $ A2   : chr  "G" "G" "T" "G" ...
     $ nA1A1: int  0 0 0 0 5 0 0 0 0 1 ...
     $ nA1A2: int  17 26 4 22 39 3 1 21 1 1 ...
     $ nA2A2: int  107 98 119 102 80 121 123 103 123 121 ...
     
    # Now some columns are characters and others integers...makes sense

    # Convert strings to factors where relevant
    > geno$A1 <- as.factor(geno$A1)
    > geno$A2 <- as.factor(geno$A2)

    > head(geno) #look at the first few lines
      CHR        SNP A1 A2 nA1A1 nA1A2 nA2A2
    1   6  rs4959515  A  G     0    17   107
    2   6   rs719065  A  G     0    26    98
    3   6  rs6596790  C  T     0     4   119
    4   6  rs6596796  A  G     0    22   102
    5   6  rs1535053  G  A     5    39    80
    6   6 rs12660307  C  T     0     3   121

    > tail(geno, n=4) # Last four lines
          CHR        SNP A1 A2 nA1A1 nA1A2 nA2A2
    43138   6   rs960744  T  C    32    60    32
    43139   6  rs4428484  A  G     1    11   112
    43140   6  rs7775031  T  C    26    56    42
    43141   6 rs12213906  C  T     1    11   112
```

To avoid having to write out all the arguments for
`write.table()`, `R` has some
related functions that are tuned to common file formats, such as
comma-separated `read.csv()` and
tab-separated `read.delim()`.

We can also write out data frames as delimited table files. The function
`wirte.table()`, and its cousin
`write.csv()`.

``` R
    # Write out a tab-delimited file with the first 8 lines of geno
    # Print out column names but not row names
    > geno_first <- head(geno, n=8)
    > write.table(geno_first, file="geno_first.tsv", sep="\t", row.names=F, col.names=T)

    # Now append the last 4 lines of geno to our file
    # Note how we disable column names so they don't get written again
    # Since we're appending
    > geno_last <- tail(geno, n=4)
    > write.table(geno_last, file="geno_first.tsv", sep="\t", row.names=F, col.names=F, append=T)
```

## Final Problems

Answer the following questions in a **single markdown-formatted
document** within a folder in your GitHub repository (e.g.
`Practicals/W8/`. Add any scripts and other files you create to the
folder as well.

### Disease Risks

The file `R/DataFiles/H938_Euro_chr6.geno` contains genotype data for
over 40,000 people of European descent at many sites across Chromosome
6. The first three columns contain information about the genomic
position of each site, and the alleles present in the population, and
the last three contain the number of individuals exhibiting
$\texttt{A}_{1}\texttt{A}_{1}$, $\texttt{A}_{1}\texttt{A}_{2}$, and
$\texttt{A}_{2}\texttt{A}_{2}$ alleles.

1.  How many people were sampled in total? The total number of genotypes
    at each site gives us the total number of people sequenced, but not
    everyone is sequenced for every site. Find the maximum of the sum of
    `nA1A1`, `nA1A2`, and `nA2A2`.

2.  Use the function `rowSums()` to
    get the same result.

3.  The file `R/DataFiles/SNP_risks.csv` is a comma-separated file that
    contains data on whether ach of the sites genotyped is associated
    with the risk of developing a disease. Read this table into R and,
    and join its third column to the six columns of
    `H938_Euro_chr6.geno`.

4.  On average, how many individuals are heterozygous (i.e.
    $\texttt{A}_{1}\texttt{A}_{2}$) at sites associated with disease
    risk? On sites not associated with disease risk?

### Data cleanup

Smith et al. (2003) compiled a database of the body mass of mammals of
the late Quaternary period, which are saved in the tab-delimited file
`R/DataFiles/Smith2003_data.txt.`

1.  Read the file into R. How many species are represented in the file?

2.  Column 7 contains $log(\texttt{body mass})$, and column 8 contains
    raw body mass values. Missing values are expressed as \"-999\". R
    uses \"NA\" for missing values. Write code that replaces \"-999\"
    for \"NA\" in both columns, and writes a file with the \"clean\"
    data.
