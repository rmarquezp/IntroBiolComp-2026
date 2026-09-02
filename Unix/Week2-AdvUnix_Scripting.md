# Refresher

Last week we covered how `UNIX` commands are run in general, and how
they can be used to perform basic tasks from the command line. In
general, commands are executed by typing the command name, followed by
the respective arguments and options. For example:

``` bash
    $ rm -r ./Folder
```

Calls the `rm` command, witn the
`-r` option, and
`./Folder` argument. Can you
remember what this command line would do?

Lets do a couple of quick exercises to bring ourselves back to speed.

1.  Navigate to your `IntroBiolComp-2026` directory.

2.  Update your repository using the
    `git` command with the
    `pull` argument (you can run
    this command without any additional arguments or options).

3.  How many folders and files are there in the `Unix` directory? Which
    ones have been updated since last class?

# UNIX tips and tircks

Now that we've been using the command line for some time, you may
appreciate the need for tools to save time and avoid mistakes while
typing on the terminal. There are a number of tricks and shortcuts
available on UNIX (and other languages) that can make interacting with
the terminal much easier. We will cover some of the min ones below, but
some web research will reveal many more.

## Command history

Most command line prompts allow you to see previous commands that you
have entered, and not have to retype them every time. The easiest way to
do this is to use the $\uparrow$ and $\downarrow$ keys. All the commands
you enter into the terminal are saved in a file on your computer, from
which you can retreive them. The name and location of this file wil vary
depending on your operating system. For example, on Ubuntu Linux
machines, this file is `~/.bash_history`, and on OSX it is `~/.zsh_history`. We
can use this files to, for example, look at the last five commands that
were entered:

``` bash
    $ tail -n 5 ~/.zsh_history
```

To avoid having to memorize this file, many operating systems have this
file set as as an *environment variable* called `$HISTFILE` (we will
talk more about variables later). The command

``` bash
    $ tail -n 5 $HISTFILE
```

Produces the same output as the previous command. Linux and Windows (via
`GitBash`) both have this set, but OSX unfortunately doesn't.

## Keyboard Shortcuts

Similar to using the upo/down arrows to see ur command history, we can
use other keyboard shortcuts as we type. Another key shortcut is using
the `Tab` key to autocomplete your command lines. If you hit `Tab` as
you type, the shell will attempt to autocomplete your command or path.
This not only saves you time, but reduces the probability of typos. In
cases where there are multiple options matching what you have typed, you
can hit `tab` twice to see them.

Finally, there are several shortcuts to to navigate along commands.
Below is a non-extensive list of shortcuts that you may find useful.

  `Ctrl+a`   Move the cursor to the beginning of the line.<br>
  `Ctrl+e`   Move the cursor to the end of the line.<br>
  `Ctrl+l`   Clear the screen (except for the command being typed.<br>
  `Ctrl+c`   Kill the command that is currently running. Useful when commands get stuck.<br>
  `Ctrl+l`   Clear the screen (except for the command being typed).<br>
  `Ctrl+k`   Delete all characters after the cursor.<br>
  `Ctrl+d`   Delete the character directly under the cursor. If no characters, exit the shell.

Incorporating these shortcuts will make you much more efficient at
typing on the terminal. You may want to keep this list handy when you're
working on the terminal.

## Wildcards

Wildcards are characters that serve as placeholders for other
characters. They can be very useful when we want to refer to multiple
things at once, such as filenames. The two mos widely used wildcards are
the asterisk (`*`), which stands for any combination of characters, and
the question mark (`?`), which stands for any *single* character. Lets
look at some examples

``` bash
    # Navigate to the Unix/DataFiles/ directory
    $ cd ~/IntroBiolComp-2026/Unix/DataFiles
    # List all files with .tsv as their extension
    $ ls -lh *.tsv
    # Count the number of lines in each .fasta file
    $ wc -l *.fasta
    # Print the first three lines of all files whose name starts with "C"
    $ head -n 3 C*
```

**Exercise:** The folder `Saavedra2013` contains files named
`n1.txt, n2.txt, n3.txt, ..., n59.txt`. Count the number of lines of
files `n10.txt to n19.txt`.

# More complex commands

## More advanced text file handling

### Finding things with `grep`

The `grep` function is a powerful
tool to find lines within files that contain a particular pattern, which
can then be printed, counted, etc\... For instance, the file
`BeeSpecies.txt` contains a list of over 19,000 bee species, as well as
the author and year of their original description, and their specific
identifier in the Integrated Taxonomic Information System (ITIS).

We can use `grep`, for example, to explore the honeybee species (genus
*Apis*) on the list. `grep` takes two arguments, the search string
followed by the file(s) we want to search.

``` bash
    # Print lines containing "Apis" 
    $ grep Apis BeeSpecies.txt
    # Count the number of lines containing "Apis"
    $ grep -c Apis BeeSpecies.txt 
```

We can find additional information about matches, for example, if we
wanted to know the exact line where *Apis melifera* is mentioned, we can
use

``` bash
    # Use quotes because the search term includes a space
    $ grep -n "Apis mellifera" BeeSpecies.txt
    # Line 3683
```

It is important to find good search terms. For example, lets search for
bee species in the genus *Ancyla*:

``` bash
    $ grep Ancyla BeeSpecies.txt
```

We get species in the genus *Ancyla*, as well as those in *Ancylandrena*
(which also contains the string `Ancyla`. We can use the option
`-w` to restrict the output to full
words.

``` bash
    $ grep -w Ancyla BeeSpecies.txt
    # Count matches
    $ grep -w -c Ancyla BeeSpecies.txt
```

In some cases, we may want to see all the lines in a file that *don't*
match our search term. This can be done using the
`-v` option. For example, lets find
the names of students not named "Juliana\" in ClassList.txt.

``` bash
    # Number of students named Juliana 
    $ grep -c Juliana ClassList.txt # 1 student
    # Names of those not named Juliana 
    $ grep -v Juliana ClassList.txt
```

Finally, `grep` can also print the lines <u>b</u>efore and/or
<u>a</u>fter a match, which can be specified with the
`-A` and
`-B` options (note the capital
letters).

``` bash
    # Print the two lines before and three lines after the matching line
    $ grep -A 2 -B 3 "Apis mellifera" BeeSpecies.txt
    # Add -n to see line numbers
    $ grep -A 2 -B 3 -n "Apis mellifera" BeeSpecies.txt
```

As you can see `grep` is incredibly powerful. We have only covered a few
of the many things this command can do. Additional options that may be
of interest are `-i`, which makes
matching case-insensitive (ie. searches match both lower and upper case
strings), and `-r` which allows you
to search across all files in a directory.

### Extracting columns with `cut`

It is common for biological data to be saved in tabular format (i.e. as
a table with rows and columns). The simplest formats to save tabular
data are text files where each line is a row, and columns are separated
by a *delimiter*, which is often a comma, a semicolon, or a `tab`
character. We usually pick a delimiter that isn't present in the data.
For example, the files `B_bet.tsv` and `B_bet.csv` contain the same
data, but one is separated by commas (`.csv`), and the other by tabs
(`.tsv`).

``` bash
    # Tab-delimited
    $ head -n 3 B_bet.tsv 
    Year    carbonaria  typica
    1967    47  0
    1968    58  0

    # Comma-delimited
    $ head -n 3 B_bet.csv 
    Year,carbonaria,typica
    1967,47,0
    1968,58,0
```

The `cut` command is a great tool
to handle tabular files, since it allows us to extract specific columns
from a table. This can be useful, for example, to obtain a subset of a
table, or if you wanted to perform further operations on just one of the
columns (more on that later).

For example, we can extract columns of a file as follows:

``` bash
    # Extract column 2 from B_bet.tsv.
    # Use -f 2 to specify which column. Tab is the default delimiter for cut so we don't need to specify one
    $ cut -f 2 B_bet.tsv 

    # Now do the same for the comma-delimited file. 
    # Note how we use "," to specify the delimiter is a comma. 
    $ cut -f 2 -d "," B_bet.csv  

    # Cut columns 1 and 3
    $ cut -f 1,3 -d "," B_bet.csv
    # Cut columns 1 through 3
    $ cut -f 1-3 -d "," B_bet.csv
```

Later today we will see how this command can be combined with others to
do complex table handling operations.

### Pipes and redirects

Until now, we have been printing the output of each individual command
to the screen/ However, it is easy to use the output of a command for
new operations. The two main ways to do this are *redirections*, where
the output of a command is redirected to a file (or vice versa), and
*pipes*, where the output of a command is passed as input for another
command.

Redirections are denoted using the
`>` symbol.

``` bash
    $ [COMMAND] > filename
```

Will pass the output of any command to a file of the specified name. If
a file of that name already exists, this command will overwrute it. If
we want to *append* the output of our comand to a pre-existing file we
can use.

``` bash
    $ [COMMAND] >> filename
```

Similarly, we can direct the contents of a file as input to a command
using the `<` symbol.

``` bash
    $ [COMMAND] < filename
```

Lets run some examples. Please use `cd` move to the `Unix/sandbox`
directory. We have used `echo` to print strings to the screen (e.g.
`"Hello world"`). We can also save the output of `echo` into a new file.

``` bash
    # Navigate to sandbox
    $ cd ../sandbox
    # Save string of text to a file
    $ echo "This will go in a file" > myfile.txt
```

Use `less` to inspect your new
file. We can now append a second line to this file using
`>>`.

``` bash
    # Append a line at the end of a file.
    $ echo "This will also go in my file" >> myfile.txt
```

Open the file again. Does it look like you expected?

Lets work on a more realistic example: We ran blood tests on multiple
patient samples, and the machine we used output one file with the
results from each patient. We now want to count the number of files
produced. Lets pretend the data are in `Unix/DataFiles/Saavedra2013`.
One way to count them is to create a list of all files, and then count
how many there are:

``` bash
    # create a list with file contents by saving the output of the 'ls' command
    $ ls ../DataFiles/Saavedra2013 > filelist.txt
    ## See what it looks like
    $ head filelist.txt # one file name per line

    ## Now count the number of lines 
    $ wc -l filelist.txt
    ## Delete the file (to keep things tidy)
    $ rm filelist.txt
```

A more efficient way to do this would avoid creating a file that we will
delete immediately after one use. We can do this by *piping* the output
of one command into the other using the
`|` symbol, often called \"pipe\"
in UNIX. We can take the output of
`ls` and use it as input for
`wc -l`

``` bash
    # number of files in directory
    $ ls ../DataFiles/Saavedra2013 | wc -l
    # Did you get the same result as above?
```

We can use pipes to string together multiple commands to do similar
things as above. For example, lets count the number of genera
represented in the `BeeSpecies.txt` table (tab-delimited). First lets
visualize the structure of the data

``` bash
    # Navigate to DataFiles directory
    $ cd ../DataFiles

    #Print the first three lines 
    $ head -n 3 BeeSpecies.txt
    Genus   Species Taxon Author    tsn
    Alocandrena porteri Michener, 1986  752055
    Ancylandrena    atoposoma   (Cockerell, 1934)   654122
```

This table has three columns. The information we want is in the first
column.

``` bash
    # Extract the first column and look at the first three lines of the output.
    $ cut -f 1 BeeSpecies.txt | head -n 3
    Genus
    Alocandrena
    Ancylandrena
```

We can now make a list of the unique words in our output using the
`uniq` command. This command
requires a sorted input, so we will also use
`sort`.

``` bash
    # Extract the unique words in the first column and look at the first 4 lines of the output.
    $ cut -f 1 BeeSpecies.txt | sort | uniq | head -n 4
    Acamptopoeum
    Acanthopus
    Acedanthidium
    Aethammobates
```

Finally, we can use `wc -l` to count.

``` bash
    # Extract the unique words in the first column and count the number of lines in the output.
    $ cut -f 1 BeeSpecies.txt | sort | uniq | wc -l
    480
```

**Exercise:** There is an error in the code above. Can you spot it? How
would you fix it?

**Solution:** We are counting the header of the column (`Genus`) as one
of the genera represented. We can fix this using `tail` to grab all
lines in the file except the first one (which contains the header).

``` bash
    # Remove the header, then extract the unique words in the first column, then count the number of lines.
    $ tail -n +2 BeeSpecies.txt | cut -f 1 | sort | uniq | wc -l
    479
```

# Scripting in Bash

As we add more commands to our pipeline, it becomes convenient to put it
in a *script*. Scripts are lists of commands that are executed one after
the other in an automated way whenever the script is *run*. As you may
imagine, scripting is a central part of scientific computation, as it
allows us to automate tasks in a replicable way. We will spend the
majority of this class learning how to write scripts that execute
particular algorithms efficiently and correctly.

## A note on text editors

A key part of writing computer programs is the software in which we do
the actual writing. Nowadays most coding is done through Integrated
Development Environments (IDEs), where a text editor is integrated with
other features, such as a terminal, code and file lookup, and in this
day and age even AI coding agents. Some IDEs you may have heard of are
`RStudio`, `XCode` or `VS Code`. Although we will use IDEs for parts of
this class, it may be good to start with a more basic text editor that
just highlights the syntax of your code. If you already have a preferred
text editor or IDE, feel free to continue using that. If not, you will
need to install one. Below are suggestions for each operating system.

1.  systems usually ship with a suitable text editor. Ubuntu's
    `Text Editor`, and `Gedit` are great options. More advanced users
    may want to use `emacs` or `vim`.

2.  `BBEdit`. There is a paid version with a lot of features but the
    free version is more than sufficient for this class, and for most
    basic and intermediate scientific computing. It can be donwloaded
    [here](https://www.barebones.com/products/bbedit/).

3.  `Notepad++` is a classic option that can be donwloaded
    [here](https://notepad-plus-plus.org/).

**If you don't have an appropriate text editor installed in your
computer please install one now**.

## Writing a script

To illustrate how scripts work, we will turn the pipeline from section
3.1.3 into a script. The first step is to create a new file. You can do
this from your text editor. Now copy the entire command line into this
file (in a single line).

``` bash
    tail -n +2 BeeSpecies.txt | cut -f 1 | sort | uniq | wc -l
```

Now save the file in the `sandbox` and use the `bash` command to run it.

``` bash
    $ bash CountFirstColumn.sh
```

It is always good practice to write comments onto our scripts, so that
future readers (including yourself!) have an easier time understanding
what the code does.

``` bash
    # Remove the header of a tab-delimited table 
    # output the number of unique elements in the first column

    tail -n +2 BeeSpecies.txt | cut -f 1 | sort | uniq | wc -l
```

This script is not very useful in its current form. Both the input file
and the column we want to process are *hard coded*. That is, they are
fixed to a single value. We can change this by using *variables*, which
can be set by the user each time. In BASH, it is easy for users to
define variables by passing them as arguments for our script. These
variables are saved as `$1` for the first argument, `$2` for the second
one, etc\... When the script is run, these variables are replaced by the
arguments provided by the user.

Lets incorporate this into our script:

``` bash
    # Remove the header of a tab-delimited table (first argument)
    # output the number of unique elements in the column given by the second argument

    tail -n +2 $1 | cut -f $2 | sort | uniq | wc -l
```

Note how `$1` is now where the file name for `tail` was, and `$2`
replaced the column number for `cut`. We can now run our script as
follows:

``` bash
    $ bash CountFirstColumn.sh BeeSpecies.txt 1
```

If we want to count the number of unique words in column 2 (i.e. species
names) we can now run:

``` bash
    $ bash CountFirstColumn.sh BeeSpecies.txt 2
```

We can also define additional variables within scripts. These can be,
for example, a particular string of text we want to use multiple times,
or the output of a command. Variables are defined using the `=` sign,
and called by adding `$` beofre the variable name. For example:

``` bash
    # Save my name as a variable (note, no spaces surrounding "=")
    $ name=Roberto
    # Print it to the screen
    $ echo "My name is $name"
```

Lets go back to our script and make it nicer. First, we can improve its
output so it is more informative than just a number. We can do this by
saving the output of the main command as a variable, and then using
`echo` to print a more informative output. To save the output of a
command as a variable we can enclose the command in backtick
(``` `` ```) characters:
`` myVar = `[COMMAND] [ARGS]` ``.

``` bash
    # Remove the header of a tab-delimited table (first argument)
    # output the number of unique elements in the column given by the second argument

    # Save the output as variable $number.
    number=`tail -n +2 $1 | cut -f $2 | sort | uniq | wc -l`

    # Print output
    echo "File $1 has $number unique elements in column $2"
```

We can do two more things to improve our script's readability. First, is
adding a line that tells the computer the language our code is written
in (`bash` in this case), and where the program that interprets it is
located (this is sometimes called a *shebang*).

``` bash
    #!/usr/bin/bash

    # The first line is not a comment. 
    # It tells the computer where to find bash.
    # This should be the first line of all your bash scripts

    # Remove the header of a tab-delimited table (first argument)
    # output the number of unique elements in the column given by the second argument

    # Save the output as variable $number.
    number=`tail -n +2 $1 | cut -f $2 | sort | uniq | wc -l`

    # Print output
    echo "File $1 has $number unique elements in column $2"
```

Note that `bash` may be in a different location in your computer. You
can find this out by typing
`which bash`. The `which` command
tells you where any command is located.

Finally, although our five-command pipe is pretty clever, it can be
difficult to read and understand by others. We can break up our code
into smaller chunks to improve this.

``` bash
    #!/usr/bin/bash

    # The first line is not a comment.
    # It tells the computer where to find bash.
    # This should be the first line of all your bash scripts

    # This script remove the header of a tab-delimited table (first argument)
    # Then output the number of unique elements in the column given by the second argument

    # Remove the first line of the file
    tail -n +2 $1 > tmp1

    # Extract the relevant column
    cut -f $2 tmp1 > tmp2

    # Gather unique elements
    sort tmp2 | uniq > tmp3

    # count and save the output as $number
    number=`wc -l tmp3`

    #remove temporary files
    rm tmp*

    # Print output
    echo "File $1 has $number unique elements in column $2"
```

This script is more readable, but also more wasteful, as it creates
temporary files that will immediately be deleted. These files, however,
may be helpful for code *debugging*. In the end, writing good code is a
balance between efficiency and readability.

## For loops

Being able to repeat the same task many times with slight variations can
be incredibly useful. For example, we may want to use the same script to
process many different files, or run the same analysis on each line of a
file. This can be achieved using *loops*. Briefly, these are commands
that iterate a variable over many different value, and use it to perform
some operation.

A common used kind of loop is the `for` loop, which iterates over a
predefined set of elements. For example, we could print out all numbers
from one to 20

``` bash

    $ for i in {1..20}
        do echo $i
      done
```

Lets unpack what we did there. We created a variable called `i`, which
took all the values specified after `in`, in this case all numbers from
$1-20$, specified using `{1..20}`,
and then asked the terminal to print the current value of `$i`. Finally,
we closed off our loop using the command `done`.

Now lets do some more applicable examples. First lets count the number
of lines in the fasta files in `DataFiles/miRNA`.

``` bash
    # Go to directory
    $ cd miRNA

    # loop to count lines in three files
    $ for file in hsa_miR.fasta  ppa_miR.fasta  ppy_miR.fasta
        do wc -l $file
      done
```

Here we created a variable named `$file`, that iterated through the
three file names specified after `in`, and then used
`wc -l` to count the number of
lines in each one. We can use *wildcards* to make this more efficient.

``` bash
    # loop to count the lines in all fasta files
    $ for file in *.fasta
        do wc -l $file
      done
```

Each of the files in our current directory contains micro RNA sequences
for a different species. Lets say we needed files with the sequences for
each specific miRNA from all species. We can do this with a loop

``` bash
    # loop to extract sequences for each miRNA from all species-specific files
    # and save them into a file

    $ for seqname in miR-208a miR-564 miR-3170
        do grep -h -A 1 $seqname *.fasta > $seqname.fasta
      done
```

Here, we iterated the variable `seqname` over three different miRNA
snames (`miR-208a, miR-564, miR-3170`), and used `grep` to grab the line
containing that miRNA name and the one following it. Recall that in
`fasta` files each sequence is reported in two lines, the first one has
the name (preceded by `>`), and the second one the sequence.

Lets see how our files look:

``` bash
    $ head -n 5 miR-208a.fasta
    >hsa-miR-208a-5p MIMAT0026474
    GAGCUUUUGGCCCGGGUUAUAC
    --
    >hsa-miR-208a-3p MIMAT0000241
    AUAAGACGAGCAAAAAGCUUGU
```

Loops are very powerful to perform large numbers of operations in BASH,
and many other computing languages. In addition to `for` loops, there
are several other kinds, such as `while`, and `until`, which run
<u>while</u> or <u>until</u> some condition is met. We
will dig deeper into these and other iterative procedures later in the
course using `Python` and `R`.

# Final Problems

## What does this command line do

1.  `man pwd`

2.  `ls -lh | less`

3.  `mkdir -p /test1/test2/test3`

4.  `du -h -d 1  / | sort -r -h | head -n 10`

5.  `mv file.txt newfilename.txt`

## Fasta files

DNA sequences are often save in a format called FASTA. These files
contain sequence data in text format. Each sequence segment is preceded
by a single-line description. The first character of the description
line is a "greater than" sign (`>`).

The data set we will be working with was published by Marra and DeWoody
(2014), who investigated the immunogenetic repertoire of rodents. You
will find the sequence file `Marra2014_data.fasta` in the directory
`Unix/DataFiles`. The file contains sequence segments (contigs) of
variable size. The description of each contig provides its length, the
number of reads that contributed to the contig, its isogroup
(representing the collection of alternative splice products of a
possible gene), and the isotig status.

1.  Change directory to `Unix/sandbox`.

2.  What is the size of the file Marra2014_data.fasta?

3.  Create a copy of `Marra2014_data.fasta` in the sandbox and name it
    `my_file.fasta`.

4.  How many contigs are classified as `isogroup00036`?

5.  How many unique isogroups are in the file?

6.  Which contig has the highest number of reads (numreads)? How many
    reads does it have?

## Semicolon-delimited to comma-delimited

It is common for table files to be distributed in comma-delimited format
(as we saw above), but some software outputs semicolon-delimited tables.
Write a script to convert a semicolon-delimited file in the format

``` bash
    Year;carbonaria;typica
    1967;47;0
    1968;58;0
```

To a comma-delimited file in the format

``` bash
    Year,carbonaria,typica
    1967,47,0
    1968,58,0
```

**Hint:** The `tr` command can be
used to replace one character for another as
`tr [FROM] [TO]`. For example:

``` bash
    $ echo "aaabbbccc" | tr "a" "d"
    dddbbbccc
```

Replaces `a` for `d`. Note that `tr` only takes the output of other
commands via a pipe (`|`).

Use your script to convert the file `Pacifici2013_data.csv` to
comma-delimited. Include the first five lines of this file in your
answer.
