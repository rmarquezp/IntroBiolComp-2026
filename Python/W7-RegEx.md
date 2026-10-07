# Python IV - More Best Practices and Regular Expressions

## Dealing with Logical Errors

### Debugging Logical Errors

We've now covered how to debug errors that stop execution of a program.
If we start `pdb`, it will trigger debugging mode as soon as an
exception or error occurs. This, of course, only works with errors that
stop the execution of the code. Logical errors don't cause execution to
stop, so they must be debugged in a slightly different way: We can use
the `pdb.set_trace()` function to
create a *breakpoint* in the code, where a debugger will start. Lets try
this with our `GC_content` function, now with a logical error instead of
a `TypeError`.

``` python
    def GC_content(seq):
        
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        # Calculate GC
        gc = (g_cont + c_cont) * len(seq)
        
        # Output result
        return(gc)
```

Sequence `AAGTCGTGAGCA` is 12 nucleotides long, and has 4 `G` and 2 `C`
bases, so we expect the GC content to be $\frac{4+2}{12}=0.5$. If we run
our function we get

``` python
    >>> GC_content("AAGTCGTGAGCA")
        72
```

This is clearly wrong, not does it not match our calculation above, but
it is greater than 1, and considering the GC content is the proportion
of GC nucleotides in a sequence, it should range between 0 and 1. Lets
set a break point to see if the G and C counts are being done correctly.

``` python
    import pdb

    def GC_content(seq):
        
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        pdb.set_trace()
        
        # Calculate GC
        gc = (g_cont + c_cont) * len(seq)
        
        # Output result
        return(gc)
```

When we run our function, the debugger will launch, and we can begin
debugging.

``` python
    GC_content("AAGTCGTGAGCA")

    ipdb> c_cont
    2
    ipdb> g_cont
    4
```

These values are as expected. Lets move the debugger a bit further down
the code.

``` python
    def GC_content(seq):
        
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        # Calculate GC
        gc = (g_cont + c_cont) * len(seq)
        
        pdb.set_trace()
        
        # Output result
        return(gc)
```

Now lets see what `gc` is being stored as.

``` python
    GC_content("AAGTCGTGAGCA")

    ipdb>  gc
    72
```

So we know the error is not due to the G and C counts, but rather due to
how the GC content is being calculated. We were multiplying instead of
dividing by the sequence length. When writing code that you think is
prone to errors (e.g. complex functions), it is always a good idea to
periodically set breakpoints to preemptively make sure things look
right. Logical errors are the hardest to spot so preventing them should
be a priority in scientific computing.

### Unit Testing

The main practice to minimize the probability of logical errors is
calling *unit testing*. In simple terms, this means writing independent
tests for each unit of our code. For instance, whenever we write a
function we also create a small test to make sure it produces the
expected result. Errors introduced when modifying preexisting code are
particularly dangerous, since we come in with the expectation that the
coda has already been tested and works as intended. However, even small
modifications, for instance to add a new feature or the ability to deal
with slightly different conditions (e.g. input data), can introduce
bugs. With this in mind, it is ideal to write tests that are run
automatically whenever we modify the code. If the tests fail, we know we
have introduced a bug, and can fix it straight away.

#### The `doctest` module

Python has several modules specifically meant for unit testing. A
commonly used one is `doctest`, which allows users to write tests into
functions as a specific type of comment called a *docstring*, which is
enclosed in triple quotes (we have previously covered this way of
commenting).

Lets continue working with our GC content function (correctly defined
this time).

``` python
    def GC_content(seq):
        
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        # Calculate GC
        gc = (g_cont + c_cont) / len(seq)
        
        # Output result
        return(gc)
```

We then add the tests within a docstring comment. These consist of
examples of function input and expected output, marked by a \"$>>>$\",
which, as you may recall, is the python prompt on the command line. It
is always good to write multiple tests that cover many scenarios.

``` python
    def GC_content(seq):
        
        """ Function to return the GC content of a sequence
        Tests:
        >>> GC_content("AAATAAATTTA")
        0.0
        >>> GC_content("GCGCGCGCGCGCGCGCGCG")
        1.0
        >>> GC_content("AAATAAATTTA")
        0.5
        """
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        # Calculate GC
        gc = (g_cont + c_cont) / len(seq)
        
        # Output result
        return(gc)
```

All text within the triple quotes will be ignored by Python, unless we
call the `doctest` module. To run the tests from Jupyter we must after
defining our function.

``` python
    def GC_content(seq):
        
        """ Function to return the GC content of a sequence
        Tests:
        >>> GC_content("AAATAAATTTA")
        0.0
        >>> GC_content("GCGCGCGCGCGCGCGCGCG")
        1.0
        >>> GC_content("AAATAAATTTA")
        0.5
        """
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        # Calculate GC
        gc = (g_cont + c_cont) / len(seq)
        
        # Output result
        return(gc)

    import doctest
    doctest.testmod()
```

If we run this, we should get a message saying how many tests were
attempted and how manny failed. If the tests deviate from the expected
result we will get additional information on the failed test. Try adding
our previous error to the code (i.e. replace
`gc = (g_cont + c_cont) / len(seq)`
for
`gc = (g_cont + c_cont) * len(seq)`.
There will, of course, be failed tests.

It is worth noting that tests will fail if our code doesn't produce
*exactly* the expected result we provided. For example, if we specified
the following tests (note 0 instead of 0.0)

``` python
    def GC_content(seq):
        
        """ Function to return the GC content of a sequence
        Tests:
        >>> GC_content("AAATAAATTTA")
        0
        >>> GC_content("GCGCGCGCGCGCGCGCGCG")
        1.0
        >>> GC_content("AAATAAATTTA")
        0.5
        """
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        # Calculate GC
        gc = (g_cont + c_cont) / len(seq)
        
        # Output result
        return(gc)

    import doctest
    doctest.testmod()
```

The first test would fail.

When writing more complex programs that import functions from modules it
is impractical to run tests from a Jupyter notebook, especially if we
want to do so automatically. Tests can be run in a similar way from the
terminal. Copy the code for our function (without the test line) into a
script called `GC_connt.py`.

``` python
    def GC_content(seq):
        
        """ Function to return the GC content of a sequence
        Tests:
        >>> GC_content("AAATAAATTTA")
        0
        >>> GC_content("GCGCGCGCGCGCGCGCGCG")
        1.0
        >>> GC_content("AAATAAATTTA")
        0.5
        """
        # Count Gs and Cs
        g_cont = seq.count("G")
        c_cont = seq.count("C")
        
        # Calculate GC
        gc = (g_cont + c_cont) / len(seq)
        
        # Output result
        return(gc)
```

If we run this on the terminal

``` python
    python GC_cont.py
```

Nothing happens (since all we did was define a function. However, if we
add the `-m doctest` flag to ask
Python to run the functions in the `doctest` on our script, the tests
will be performed.

``` python
    python -m doctest GC_cont.py
```

Because we left in a misspecified result (i.e. 0 instead of 0.0), we
should see an error. If we fix the error, rerunning the command above
should not produce an output. If we want to see what tests are being run
and the results they produce, even if they pass, we can add the
`-v` flag to ask Python for a
*verbose* output.

``` python
    python -m doctest -v GC_cont.py
```

Every time you modify functions in a module you should run tests. For
this to happen automatically, you can add the following lines to the end
of your module:

``` python
    if __name__ == "__main__":
        import doctest
        doctest.testmod()
```

Briefly, what this `if` statement is doing is asking if the file is
being executed by itself (i.e. as a script from the command line). If
this is the case, then `doctest` is imported and the `testmod` function
is run. Because this will only happen when the module is run as a
script, tests will not be run when it is imported by another script (as
a module). Now tests will be run if we execute our script as

``` python
    python GC_cont.py
```

If you want to get a verbose output, you can either run Python with a
`-v` flag, or use
`doctest.testmod(verbose=True)` in
your script.

### Final Considerations

As you have seen, writing good code involves many decisions and personal
choices. Is code written a particular way more understandable? Should
you rewrite a block of code that does the job correctly, or should you
dedicate that time to another task? In the end, my advice is to find a
style that works for you, that you like and understand, and be
intentional when using it. When in doubt prioritize correctness above
all else, then replicability, and then clarity. When in doubt, you can
always ask Python for help.

``` python
    import this
```

## Regular Expressions

Scientific data are usually expressed as text of some sort. The
numerical values in a data matrix to, the letters in a DNA or protein
sequence, the words in a field notebook or patient visit summary, and
even the output of most lab machines are all stored as text. Being able
to find specific patterns in text is a key task in scientific
computation. For instance, you may want to find all numbers that look
like a ZIP code (e.g. 24061-1040), or some specific motif in a DNA
sequence. *Regular expressions* are a type of code syntax that allows us
to search for general patterns in text. We have used some of them in the
past, for example the wildcards \"\*\" and \"?\", which match \"any
combination of characters\" or \"a silge character\", respectively.

Today we will take a first glimpse at the world of regular expressions.
As you may imagine, this task can get quite complex if we are trying to
match complicated patterns. As with most topics of this class, there are
entire books about regular expressions. Hopefully what you will leran
today will allow you to learn what you need about regular expressions in
the future.

### The `re` Module

Regular expressions are available in most (if not all) widely used
languages for scientific computing. Even if they way in which they are
executed may vary, the expressions themselves tend to be largely
equivalent across languages. In Python the module `re` is the most
widely used implementation of regular expressions.

The most basic (and main) function of this module is
`search()`, which takes two
arguments: The pattern we're looking for and the string we're looking
in. Restriction enzymes are a type of nuclease that cleaves DNA at a
particular sequence motif. The *EcoRI* enzyme cuts at `GAATTC`. Lets
find that motif in a DNA sequence.

``` python
    import re

    dna = "ACAAAATACGTTTTGAAATGTTGTGCTGTTAACACTGTCGACTAAACTT
           GGTAGCAAACACTTCCAAAAGGAATTCACCGGTTTCCAAAGACAGTCTT
           CTAATTCCTCATTAGTAATAAGTAAAATGTTTATTGTTGTAGCTCTGGA
           CCGGTTTCCAAAGACAGTCTTCTAATTCCTCATTAGTAATAAGTAAAAT
           GTTTATTGTTGTATACCTGG"

    match = re.search(r"GAATTC",dna)

    print(match)
    <re.Match object; span=(70, 76), match='GAATTC'>
```

Note how we pasred the string as `r"my string"`. This is so special
characters, such as newlines (`\n`) are not interpreted, so we can
search for them within strings (\"r\" stands for \"raw\"). The `match`
object contains information on the first match four our pattern. It
occurrs between nucleotides 70-75 of our sequence, and is (not
surprisingly), exactly \"`GATTC`.\" If we only want to return the match
we can use the `.group()` method.

``` python
    print(match.group())
    'GAATC'
```

If there are no matches, the `search()` function returns \"`None"`.

``` python
    # Search for a protein sequence
    match = re.search(r"MYIFLY",dna)
    print(match)
    None
```

`find()` only saves the frist match of our pattern in the string. If we
want to retreive them all we can use `findall`.

``` python
    # Search for short sequence motif
    matches = re.findall(r"TCC",dna)

    print(matches)
    ['TTC', 'TTC', 'TTC', 'TTC', 'TTC', 'TTC', 'TTC', 'TTC']

    # Count number of matches
    len(matches)
    8
```

### Building Regular Expressions

For now, all we've done is finding *literal* matches to one specific
string within a larger string. This can, of course, be useful in many
cases, such as finding specific motifs within a genetic sequence, or a
subject's ID within a large text file. However, the true power of
regular expressions comes from more general patterns that match multiple
strings. For example, some restriction enzymes cut at several motifs,
such as *Xmil*, which cuts at:

- GTAGAC

- GTCGAC

- GTATAC

- GTCTAC

We can build a regular expression that matches all four sites.

``` python
    match = re.findall(r"GT[AC][GT]AC",dna)

    print(match) # two matches. 
    ['GTCGAC', 'GTATAC']
```

For the remainder of this lesson, we will look at how general
expressions can be built to match general patterns.

#### Metacharacters

A regular expression is made up of multiple bits called *atoms*, which
can either be either matched literally or more generally (e.g. A-Z, a-z,
0-9). One type of the later are *metacharacters*, which match a a
well-defined class of other characters. For example:

  ------ -------------------------------------------------------
  `\d`   Match a single digit (i.e. 0 to 9).
  `\D`   Match anything but a digit.
  `\s`   Match a white space (e.g. tab, space, newline).
  `\w`   Match a word character (alphanumeric and underscore).
  `\W`   Match anything but a word character.
  `.`    Match any single character.
  ------ -------------------------------------------------------

For example

``` python
    string = "I've gotta get a goat and name it Goat5"

    # All four-character strings starting with 'g' and ending with 't.'
    m1 = re.findall(r"g..t", string)
    m1
    ['gott', 'goat']

    # All five-letter words preceded by a space
    m2 = re.findall(r"\s\w\w\w\w\w", string)
    m2
    [' gotta', ' Goat5']
```

#### Sets

Metacharacters fill in for specific *sets* of characters. For instance
`\d` is equivalent to the set of digits from 0-9, and `\s` is equivalent
to the set containing `\n`, `\t`, and (there is a white space there). We
can specify any set we want by enclosing its elements, either as atoms
or as a range, within square brackets. For instance `[ATCGatcg]`
contains all upper and lowercase letters that stand for nucleotides,
`[a-z]` contains all lowercase letters, and `[A-Za-z0-9_]` contails all
alphanumeric characters and the underscore (i.e. the set invoked by
`\w`).

For instance:

``` python
    # All five-letter words starting with g or G
    m1 = re.findall(r"[gG]\w\w\w\w", string)
    m1
    ['gotta', 'Goat5']
```

Note that we also used sets to find *Xmil* cut sites in a sequence.

#### Quantifiers

We have been typing each atom (i.e. bit) of our regular expression
individually. For example, a three letter word is matched by `\w\w\w`.
As our expressions grow longer this is, of course, impractical. A much
more practical way to incorporate repetition into our regular expression
is using *quantifiers*. For example, our search for five-letter words
starting with a \"G\" (case insensitive) can also be written as

``` python
    # All five-letter words starting g or G
    m1 = re.findall(r"[gG]\w{4}", string)
    m1
    ['gotta', 'Goat5']
```

Where we use the `{4}` quantifier to look for patterns that repeat the
`\w` atom for times. Below are other commonly used quantifiers.

  --------- -------------------------------------------------
  `?`       Match zero or one time.
  `*`       Match zero or more times.
  `+`       Match one or more time.
  `{n}`     Match exactly `n` times.
  `{n,}`    Match at least `n` times.
  `{n,x}`   Match at least `n` but not more than `x` times.
  --------- -------------------------------------------------

For instance, if we had a long text file that included DNA sequences we
could extract them as

``` python
    re.findall(r"[ACTG]{2,}", string)
    ['gotta', 'Goat5']
```

Which matches all strings of `[ACTG]` longer than 3.

We can also use quantifiers to match groups of specific characters. For
example

``` python
    # Match G followed by 4 Ts
    re.search(r"GT{4}", "ATGGTGTCCGTTTTGTT").group()
    'GTTTT'

    # Match "GC" repeated 3 or more times
    re.search(r"(GT){3,}", "ATGGTGTGTGTCGCGCGCGCGCGCTCCGT").group()
    'GTGTGTGT'
```

Note how we enclosed groups of atoms in parentheses to indicate that
we're looking for a repetition of that group as a whole.

#### Anchors

Sometimes we want our pattern to match patterns that are found in a
particular place of our string, such as the beginning or end of the
string or word. For example, we may want to determine if a sequence is
an mRNA by asking if it has a poly-A tail (i.e. a string of As at the
eng of the sequence).

``` python
    mRNA = "TGCAAACTCTGAGGGCAGCAAAAAACATGAGAAAAAAAAAA"

    #If A string of As greater than 3 is present tell us it is an mRNA
    if re.search(r"A{3,}", mRNA):
        print("It is an mRNA!")
    else:
        print("No poly-A tail")
```

This is a good start, but you've probably found several strings of As
that are not at the tail. We can use the `$` atom to specify the end of
the string. This type of atom is called an *anchor*.

``` python
    mRNA = "TGCAAACTCTGAGGGCAGCAAAAAACATGAGAAAAAAAAAA"

    #If A string of As greater than 3 is present 
    # *at the end* of the sequence tell us it is an mRNA
    if re.search(r"A{3,}$", mRNA):
        print("It is an mRNA!")
    else:
        print("No poly-A tail")
    It is an mRNA!

    # Try with a sequence lacking polyA tail
    rand_seq = "TGGTCTATCGTAGAGTATCGGATAAAAAAAAGCGTAGTGAT"

    if re.search(r"A{3,}$", rand_seq):
        print("It is an mRNA!")
    else:
        print("No poly-A tail")
    No poly-A tail
```

Similar to `$`, the `^` character matches the beginning of the string.
An interesting anchor is `\b`, which matches the boundary between words.
This can be the begining or end of a string, a period, a space, etc\...
For example, if you want to perform a \"whole words only\" search, you
can enclose your expression in `\b` atoms (e.g. \"`\bword\b`\").

**Exercises (A & W Intermezzo 5.1):** Describe the following regular
expressions in plain English. What does the regular expression match?
You can type each command into your notebook to see the result.

1.  `re.search(r"\d" , "it takes 2 to tango").group()`

2.  `re.search(r"\w*\s\d.*\d", "take 2 grams of H2O").group()`

3.  `re.search(r"\s\w*\s", "once upon a time").group()`

4.  `re.search(r"\s\w{1,3}\s", "once upon a time").group()`

5.  `re.search(r"\s\w*$", "once upon a time").group()`

#### Either, Or

Another useful regular expression tool is searching for strings that
match either of two patterns. We indicate using the notation
\"`PAT1|PAT2`\" character. Strings matching the pattern at either side
of the bar will be returned. For example:

``` python
    my_string = "I found my cat!"
    re.search(r"cat|mouse", my_string).group()
    cat
```

**Exercises:**

1.  Use regular expressions to write a script that calculates the GC
    content of a given sequence.

2.  The National Center for Biotechnology Information is an institute at
    the NIH that maintains very large publicly available databases
    containing data previously generated and made available by
    scientists. One of the largest databases is called GenBank, which
    contains virtually every protein and nucleotide sequence ever
    produced. Each sequence has a unique identifier called an accession.
    You can tell whether a sequence is a protein, single gene, or whole
    genome sequence based on its accession as follows:

    - Protein: 3 letters followed by 5 numerals.

    - Whole genome: 4 letters followed by 2 numerals indicating the
      genome assembly version, and finally 6--8 numerals.

    - Nucleotide: 1 letter followed by 5 numerals, or 2 letters followed
      by 6 numerals.

    Build regular expressions that would match each type of accession.

#### Escaping metacharacters

There may be cases where we want to match a character or string that is
used to build regular expressions. For instance, if we wanted to find
strings that look like prices, we may want to include the \"dollars\"
sign (\$) in our pattern, but not to signal the end of a string. To do
this we need to *escape* these characters. This is easily achieved using
the backslash (\"\\\") character.

``` python
    string = "The price was $252.00"

    # Match the price
    re.search(r"\$\d+\.\d{2}", string).group()
    $252.00
```

Note how we escaped both the \"\$\" and \".\" characters. Finally, if
you need to escape a character that already has a backslash, you just
use two backslashes. For example \"`\\n`\" escapes the newline
character.

### Additional Functions of `re`

The `search()` and `fidnall()` functions in `re` are very powerful, and
will probably be your main workhorses when working with regular
expressions in Python. However, there are other useful functions that we
will mention briefly.

First `re.compile()` allows us to define a regular expression once for
multiple uses. For example, if we're looking for restriction enzyme cut
sites across multiple sequences, we can do the following:

``` python
    xMil = re.compile(r"GT[AC][GT]AC")
    seq = "TGCAAACTCTGTCTACAGGGCAGCAAAAAACATGAG"
    re.search(xMil, seq).group()
    'GTCTAC'
```

We can also split our string by matches using `re.split()`. FOr
instence,

``` python
    seq2 = "TGCAAACTCTGTCTACAGGGCAGTCTACTATACAAAACATGAG"
    re.split(xMil, seq2)
    ['TGCAAACTCT', 'AGGGCA', 'TATACAAAACATGAG']
```

Finally, whenever there are multiple matches, we may want to iterate
across them to perform some operation. For example, if our sequence had
two cut sites, we could obtain their coordinates as follows:

``` python
    hits = re.finditer(xMil, seq2)

    for item in hits:
        print(item.start() + 1, item.group())
    11 GTCTAC
    23 GTCTAC
```

## Final Problems

Answer the following questions in a **single markdown-formatted
document** within a folder in your GitHub repository (e.g.
`Practicals/W7/`. Add any scripts and other files you create to the
folder as well.

### A Map of Science (A & W 5.9.2) 

Where does science come from? This question has fascinated researchers
for decades, and has even led to the birth of the field of the "science
of science," where researchers use the same tools they invented to
investigatenature to gain insights into the development of science
itself. In this exercise, you will build a "map of Science," showing
where articles published in Science magazine have originated. You will
find two files in the directory `Python/DataFiles/MapOfScience`. The
first, `pubmed_results.txt`, is the output of a query to PubMed, listing
all the papers published in Science in 2015. You will extract the US ZIP
codes from this file, and then use the file `zipcodes_coordinates.txt`
to extract the geographic coordinates for each ZIP code.

1.  Read the file `pubmed_results.txt`, and extract all the US ZIP
    codes.

2.  Create the lists `zip_code`, `zip_long`, `zip_lat`, and `zip_count`,
    containing the unique ZIP codes, their longitudes, latitudes, and
    counts (number of occurrences in Science), respectively. **Hint:**
    Use the `csv` module to parse the `zipcodes_coordinates.txt`.

3.  To visualize the data you've generated, use the following code (you
    can copy and paste this from GitHub):

    ``` python

        import matplotlib.pyplot as plt
        # let plots be produced within the IPython notebook
        %matplotlib inline

        plt.scatter(zip_long, zip_lat, s = zip_count, c= zip_count)
        plt.colorbar()

        # only continental us without Alaska
        plt.xlim(-125,-65)
        plt.ylim(23, 50)

        # add a few cities for reference (optional)
        ard = dict(arrowstyle="->")
        plt.annotate('Los Angeles', xy = (-118.25, 34.05), 
                       xytext = (-108.25, 34.05), arrowprops = ard)
        plt.annotate('Palo Alto', xy = (-122.1381, 37.4292), 
                       xytext = (-112.1381, 37.4292), arrowprops= ard)
        plt.annotate('Cambridge', xy = (-71.1106, 42.3736), 
                       xytext = (-73.1106, 48.3736), arrowprops= ard)
        plt.annotate('Chicago', xy = (-87.6847, 41.8369), 
                       xytext = (-87.6847, 46.8369), arrowprops= ard)
        plt.annotate('Seattle', xy = (-122.33, 47.61), 
                       xytext = (-116.33, 47.61), arrowprops= ard)
        plt.annotate('Miami', xy = (-80.21, 25.7753), 
                       xytext = (-80.21, 30.7753), arrowprops= ard)

        params = plt.gcf()
        plSize = params.get_size_inches()
        params.set_size_inches( (plSize[0] * 3, plSize[1] * 3) )

        plt.show()
    ```

    **Note:** The `matplotlib` module provides powerful functions to
    create graphics in Python. We will not cover it here, but I
    encourage you to give it a look if you're interested in plotting the
    results of your Python analyses.
