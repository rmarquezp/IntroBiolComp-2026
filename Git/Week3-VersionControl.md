# What is version control and why use it?

You have surely worked on a project that involves multiple file
versions. These can be different drafts of an essay or manuscript,
datasets at different stages of collection, or perhaps files generated
by different people working together on the same project. It can happen
very quickly that the files associated quickly become hard to manage, to
the point where it is easy to lose track of who did what when and why.

*Version control systems* are tools that allow us to record and organize
the history of changes to a set of files and directories. They don't
only keep track of changes, but maintain backups that can be used to
seamlessly return to previous versions of files, or allow multiple
people to work on the same files at any given time to then seamlessly
merge their progress into a single file. Even if it may seem like
overkill at first, the use of version control systems is among the most
prominent "good habits\" recommended by veteran software developers.

# `git` and GitHub

We will use `git` throughout this course. Originally developed to
support the development of the Linux operating system, this version
control system has become one of the most popular version control
systems in the biological sciences. A very useful feature of version
control systems is the ability to store project repositories in *remote
servers* (i.e."the cloud\"). We will be using
[GitHub](https://www.github.com/) for this purpose. GitHub is also a
very popular choice to host repositories among biologists and other
scientists.

## Basic `git`

### Setup

If you've attended the previous two lectures you should already have
`git` installed in your machine, and have used it to download files from
our course
[repository](https://github.com/rmarquezp/IntroBiolComp-2026), which is
hosted in GitHub. Before using `git` for most taks (other than
downloading repositories) we must set up a few things for `git`, such as
our username and email (so it can record *who* made specific changes).
This only needs to be done the first time you use `git` in a particular
computer.

``` bash
    $ git config --global user.name hokieBird
    $ git config --global user.email giant_turkey@vt.edu
```

Among the many other things you can configure about your `git`
environment is whether different font colors are used to highlight
changes to files. This is optional but can be very helpful.

``` bash
    $ git config --global color.ui true
```

If you want to see all your settings and available options type

``` bash
    $ git config --list
```

### Getting help

In addition to the now familiar
`man git` way of getting help,
typing `git help` will show you an
overview of git functionalities. In addition, the `git`
[website](https://git-scm.com/) is a great resource to learn more or
troubleshoot. It even has a freely available
[book](https://git-scm.com/book/) that you can download, and is also
available on the course's Canvas page. In this class we will barely
scratch the surface of `git` functionalities, so these resources will be
useful if you want to learn more.

### Basic workflow

Incorporating `git` into your working routine involves a very basic
workflow. Once you have created a repository and worked on your files to
the point where you want to create a snapshot of your work, known as a
*commit*, you can keep track of the changes you've made, decide the
files you will include in your commit, and create it by committing your
changes. You can then continue working, and repeat the process whenever
you want to create a new snapshot. Each of these functions is achieved
with a different `git` subcommand, as summarized in Figure
[1](#workflow){reference-type="ref" reference="workflow"}.

<figure id="workflow" data-latex-placement="!ht">
<div class="centering">
<embed src="GitFlow_AllesinaWilmes.pdf" style="width:9cm" />
</div>
<figcaption>Once a new repository is created and changes have been made,
a snapshot of the project can be created by inspcting the changes,
choosing which ones will be included in the snapshot and committing the
changes. Each stage of the workflow includes example <code>git</code>
commands. Reproduced from Allesina &amp; Wilmes 2019.</figcaption>
</figure>

Lets create a simple repository to explore this workflow. Navigate to
`Git/sandbox`, create a new directory called `test_repo`, and navigate
into it.

``` bash
    $ cd ~/IntroBiolComp-2026/Git/sandbox
    $ mkdir test_repo
    $ cd test_repo

    # Make sure we are in the right place
    $ pwd
    /Users/roberto/IntroBiolComp-2026/Git/sandbox/test_repo
    # Initialize repository
    $ git init
```

After naviating to the directory where we wanted to create our
repository we used the command
`git init` to
<u>init</u>ialize a new repository. It is always worth checking
your current directory before running `git init`. YOu wouldn't want to
track changes to a large folder containing many projects (or even your
entire computer!) just because you forgot to navigate to the right
place!

Lets check the status of our new repository.

``` bash
    $ git status
```

As expected, our repository doesn't have anything to commit, since we
haven't added anything. Lets create a file.

``` bash
``` {upquote="true"}
$ echo -e 'ONE, TWO! ONE, TWO!\nHokie Hokie Hokie Hy' > OldHokie.txt
```
```

We could have, of course, used a text editor or some other program to
create this file, but for simplicity we will stick to the command line.
Lets check out our file

``` bash
    $ cat OldHokie.txt
    ONE, TWO! ONE, TWO!
    Hokie Hokie Hokie Hy
```

Now, if we type `git status` again,
we will see that it identifies `OldHokie.txt` as an "untracked\" file.
This means that `git` is not keeping track of changes in this file. This
is `git`'s default behavior. It will not track files unless we tell it
to.

``` bash
    # Add file to repository
    $ git add OldHokie.txt

    # Check status
    $ git status 
    No commits yet

    Changes to be committed:
      (use "git rm --cached <file>..." to unstage)

        new file:   OldHokie.txt
```

Now our file is being tracked, and will be included in any snapshots we
create. Every time we want a file to be tracked we need to add it using
`git add`. We can add multiple
files at once using wildcards, and we can add all the files in a
directory by passing the path to that directory. For example
`git add .` adds all the files in
the current directory. If we want to add all files in the directory we
can use `git add --all`.

Once we're ready to create a snapshot of our repository we can use
`git commit` to do so. Every time
we commit changes to a repository, we must include a short explanation
of what these changes were. This is usually done with the
`-m` flag, which stands for
"message\". If this flag is not passed, `git` will open a text editor
for the user to provide a message.

``` bash
    $ git commit -m "Started writing the Old Hokie cheer"
```

Writing meaningful messages is key. They let you know what was done in
each commit, which is key to understanding the project's history. Your
future self will thank you in a few months once you've forgotten the
details of wach commit. You can see the history of a repository by
typing

``` bash
    $ git log
```

The output lists all commits, with the newest listed first. As expected,
at this point we have only one commit. Lets continue writing our Hokie
chant.

``` bash
``` {upquote="true"}
# Add second stanza
$ echo 'Tech Tech V.P.I!' >> OldHokie.txt

# Check final product
$ cat OldHokie.txt 
ONE, TWO! ONE, TWO!
Hokie Hokie Hokie Hy
Tech Tech V.P.I!
```
```

If we check our repository status, we will see that this file has been
changed, but these changes haven't been *staged* to be committed. If we
committed changes at this point, our most recent edit of the file would
not be included. We can keep editing, and once we're ready to commit we
can add the relevant files to the commit with
`git add`.

``` bash
    $ git status 
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   OldHokie.txt

    no changes added to commit (use "git add" and/or "git commit -a")


    # Add all files in the current directory
    $ git add .

    # Check status again to be sure our file is included.
    $ git status

    # Commit!
    $ git commit -m "Added the second stanza of the Old Hokie cheer."
```

If we look at the commit history, we can see there are now two commits.

``` bash
``` {upquote="true"}
# Add second stanza
$ git log
```
```

**Exercises:**

1.  Create the file `todo.txt` containing the line
    `- Fluff up feathers for game vs ODU`.

2.  Add this file to the next snapshot.

3.  Commit snapshot with a meaningful message.

### Visualizing changes

You've now learned 95% of what you'll need for day-to-day version
control. We will now go over a few slightly more advanced tasks, the
firs of which is visualizing the changes made since the last commit. We
can do this wit `git diff`. If you
look at the `OldHokie.txt` you will see that there is a dot missing at
the end of \"V.P.I\". Fix that on a tex editor and save the file. Once
you're done type

``` bash
``` {upquote="true"}
# Add second stanza
$ git diff
diff --git a/OldHokie.txt b/OldHokie.txt
index 5f00bda..1e09bab 100644
--- a/OldHokie.txt
+++ b/OldHokie.txt
@@ -1,3 +1,3 @@
 ONE, TWO! ONE, TWO!
 Hokie Hokie Hokie Hy
-Tech Tech V.P.I!
+Tech Tech V.P.I.!
```
```

The last two lines show that the line `Tech Tech V.P.I!` was deleted,
indicated by "$-$\", and the line `Tech Tech V.P.I.!` was added, as
marked by the "$+$\".

Now, to finish

``` bash
    # Add second stanza
    $ git add OldHokie.txt
    $ git commit -m "Fixed typo in OldHokie.txt"
```

### Moving and removing files

If you move or remove files using `mv` and `rm`, these changes will not
be reflected on the index of files that `git` is tracking. This can be
done using `add/commit`, but the best way to let `git` know of these
changes is using `git rm` and
`git mv`.

``` bash
    # Remove file toremove.tsv
    $ git rm toremove.tsv
    # Remove all files ending in .fasta
    $ git rm *.fasta
    # Remove file toremove.tsv
    $ git mv oldfile.txt newfile.txt
```

## Troubleshooting

Even if the cases above may seem straightforward, there will be plenty
of cases where you want to change, undo or otherwise deal with mistakes
that you've made. Below are a few ways in which you can do so.

### Amending a commit

A classic mistake with version control is realizing you missed something
right after you commit changes. You may have forgotten to add a
particular file, or realized you made a typo or forgot to remove one
line of code. YOu could fix this by creating another commit, but, over
time, accumulating a lot of small commits mau make it harder to
understand the general history of your repository. You can make these
small changes by running

``` bash
    # Add forgotten changes
    $ git add forgottenfile.txt 
    $ git add fixedcode.py

    # Commit and update the message
    $ git commit --amend -m "updated message"
```

If you don't want to update the message of the previous commit, you can
use

``` bash
    # Add forgotten changes
    $ git add forgottenfile.txt 
    $ git add fixedcode.py

    # Commit and update the message
    $ git commit --amend no-edit
```

Bear in mind that when you amend a commit, textttgit will overwrite the
previous commit, so you can't go back to the \"unamended\" version of
the commit.

### Unstaging a file

Another common mistake is to add a file th a snapshot that you did not
intend to. This can be easily fixed using
`git reset`.

``` bash
    # Remove changes to filetounstage.py from the staging area.
    $ git reset HEAD filetounstage.py
    # Commit and update the message
```

### Reverting to a previous commit

Messups **will** happen. Sometimes they are bad enough that we may want
to travel back to a time before we made those changes. If the changes
haven't been staged (`git add`), you can recover the last committed
version of your file using

``` bash
    $ git checkout toreset.txt
```

Use this command with caution. Once you checkout a file any changes you
made will be lost.

# Remote repositories on GitHib

You now know how to run a version-controlled repository on your local
computer. However, to really take advantage of the benefits of version
control systems, repositories can be hosted in remote servers,
accessible from anywhere with an internet connection. This allows you to
work from multiple computers (e.g. home, office, laptop), and allows
multipel users to contribute to the same repository.

We will now set up a remote repository on GitHub, and learn how to work
with it from the terminal.

## Setup

Our first step is to setup a GitHub account that you can access from the
terminal in your computer. If you already have an account you are
welcome to use it. To create one, navigate to the GitHub
[website](https://www.github.com/), click on "Sign up\" in the top right
corner, and follow the prompts. When choosing which email to use, bear
in mind that you may be using GitHub after you graduate, and possibly
lose access to your VT email (or at least I hope you will :-).

Many of the basic version control tasks can be performed directly on the
GitHub site using an internet browser, but this can be limiting, and
often inefficient. We can access remote repositories directly from the
terminal using `git` (you have already done this when you cloned and
pulled our course repository). However, to do anything other than
copying files from a server to our computer, we need tighter security.
Instead of user names and passwords, GitHub (and many other remote
services) use a type of security known as SSH keys (SSH stands for
*secure shell*). These are files that act as a \"key and lock\"
mechanism, where a file on the server side (the "lock\", also known as
the *public key*), only lets you interact with the server if your
computer has a corresponding *private* key (the "key\"). To set this up
we need to create a private key and its corresponding public key in our
computer, and then give GitHub the public key.

First lets create a key in our computer. The section below follows a
much more detailed
[tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=mac)
from the GitHub docs, and assumes we are using Ubuntu. If you are using
Windows or Mac please follow the platform-specific instructions on the
GitHub site,a s there will be key differences.

``` bash
    # Create ssh key using the email address associated with your GitHub account
    $ ssh-keygen -t ed25519 -C "giant_turkey@vt.edu"
```

This will generate a new prompt asking you for a file in which to save
the key,

``` bash
    > Enter file in which to save the key (/home/rmarquezp/.ssh/id_ed25519):
    # Your path may be different, especially on Windows. Refer to the Github site if in doubt. 
```

You can just hit `Enter` to use the default name in parenthesis, but it
is generally good to have different keys for different servers, so you
may want to give it a name that you can recognize later on. You have to
type this directly on the terminal

``` bash
    > Enter file in which to save the key (/home/rmarquezp/.ssh/id_ed25519): /home/rmarquezp/.ssh/of_gh_ed25519
    # THe name above indicates that this is the GitHub key on my office PC (of_gh), and that the encryption algorithm it uses is ed25519. 
```

You will then be prompted to enter a password to protect the key from
unauthorized users. I strongly encourage you to set one. Next we add the
key to our *key manager*, a program that manages all the SSH keys in our
machine.

``` bash
    # Launch the agent in the background
    $ eval "$(ssh-agent -s)"
    Agent pid 18299

    # Add key to the agent
    $ ssh-add ~/.ssh/of_gh_ed25519
```

Thats it! You now have an SSH key on your computer. Lets add it now to
our GitHub account. Go to your GitHub dashboard and click on your
profile picture in the upper right hand corner. A drop-down menu should
appear. Click on "Settings.\" Then:

1.  On the left sidebar click on "SSH and GPG keys\" under "Access\".

2.  Click "New SSH key\".

3.  Give a key an informative title (e.g. "Laptop\", "Office\").

4.  Obtain the public part of your key:

    ``` bash
        # Output public key contents
        $ cat  ~/.ssh/of_gh_ed25519.pub
    ```

5.  Copy and paste it into the \"key\" box on GitHub.

6.  Click on \"Add SSH key\".

7.  Test whether you can connect.

    ``` bash
        # Attempt to SSH into github
        $ ssh -T git@github.com
    ```

You may get a warning saying the authenticity of the host can't be
established, and asking if you want to continue. Type
`yes` and hit `enter`. If
everything work you should get a message saying you successfully
authenticated (but GitHub doesn't provide shell access).

## Creating a new repository

To create a remote repository we must do two things. We must create the
repository, and link it with a local repository on our machine. We will
now create a repository where you will keep your course files, including
problem sets and assignments.

### Local repository

Lets first create the local version of our repository. First **navigate
away from our common course repository (`IntroBiolComp-2026`)**.
Creating a repository within another repository will make `git` very
unhappy. Once you are in a different directory, create your new
repository. Make sure you give it an informative name. I will call mine
`IBC_2025_student`.

``` bash
    # Create directory and navigate to it
    $ mkdir IBC_2025_student
    $ cd IBC_2025_student

    # Initialize directory
    $ git init
```

Now lets create our first file. Usually repositories have a file called
a `README`, which has a description of what is in the repository. GitHub
likes these files in `Markdown` format, which is a text file that can be
rendered by a program to look nice, similar to the way web browsers
render `html` files into websites. Create a file called `README.md` in a
text editor, and type something along the following lines (include all
`#` symbols).

``` bash
    # BIOL 2214 Student Repository for Roberto Marquez
    Here you will find my practicals, assignments, and final project for BIOL 2214: Intro to Biological Computation.
```

Save your file, and add and commit it to the new repository.

``` bash
    # Add file to snapshot
    $ git add README.md

    # Commit changes
    $ git commit -m "Initial commit"
```

Our local repository is ready, lets build the remote version now.

### Remote repository

Go to your GitHub dashboard, and on the left sidebar click on the "New\"
green button. In the new window that pops up give your repository a
name, and write a short, informative description. The click on "Create
repository\" at the bottom. A page with the directions to link (or
create) a local repository will now appear. Since we have already
created a repository, we can follow the directions to "push an existing
repository\". Before continuing be sure to select `SSH` and not `HTTP`
in the blue top panel where it says "Quick setup\".

``` bash
    # Link our local and remote repositories
    $ git remote add origin git@github.com:rmarquezp/IBC_2025_student.git

    # Rename the main branch to "main" (instead of "master")
    $ git branch -M main

    # Push files to the remote repository
    $ git push -u origin main
```

If you click on the name of your repository, you will go to its landing
page, where the recently created `README.md` file should have been
uploaded. You can see the contents of this file, properly rendered in
Markdown format. Congratulations, you have now created your first
repository!

**Exercises:**

1.  Create a new directory called `Practicals` inside your repository.

2.  Copy your answers for the Week 1 practical into a text file and add
    it to the repository. Name the file `Lastname_P1.txt`, replacing
    "Lastname\" with your lastname.

3.  Push the file to your remote repository (`add/commit/push`).

# Markdown: Documenting repositories

`git` and most other version control systems are designed to work very
well with text files, such as scripts, text-based data files (e.g.
`.csv`), LaTeXfiles, etc\... You can also track `binary` files (i.e.
those that need a dedicated program to be opened, e.g. `.docx`, `.pdf`,
etc..), but `git` will only save a new version every time you commit,
and will not be able to see the differences between file versions.

Text files are great for many things due to their simplicity. Publishing
information in a way that looks nice and is pleasant to read is not one
of them. People often use file formats that tell a particular program
(an *interpreter*) to how display information in terms of format, font,
images placement, etc\... The GitHub website has an interpreter for a
text-based publishing format called *Markdown*. We will spend our
remaining time exploring this format, which we will use for assignments
from now on.

In very basic terms, markdown uses text characters to signal the format
for particular blocks of text, which the interpreter then displays. To
get an idea of how it works, go to your newly created GitHub repository,
click the "Add file\" button, and select "create new file\". Name it
`test.md`. Now type the following into the text box

```
    # This is a big heading
    This is some normal text. 
    ## This is a smaller heading
    ### This one is even smaller.
    #### And smaller

    ## Emphasis and quotes
    I can ictalize text using *asterisks* or _underscores_, and bold it using **double asterisks**. 
    > I can format text as quotes

    ## Lists

    I can write lists using:

    1. Numbers
    * Bullets
      * Sub-list.
      1. Even using numerals.

    ## Code

    A very cool functionality of markdown is we can very nicely document code. We can print code `inline` using backticks. We can also print code blocks highlighted by language. 

    Here is some bash code:

    ```bash
    for i in {1..10}
      do
      echo "This is awesome"
    done
    ```
    Works in R too:

    ```R
    data=read.csv("my_data.csv")

    par(mfrow=c(3,3))

    for(i in 1:9){
      hist(data[,i], main=colnames(data)[i], col="black", border=NULL)
    }
    ```
    Unhiglighted code box:
    ```
    This is some unhilighted text.

    Anything I type here is printed 'as is' instead of formatted as markdown.
    ```
```

You can toggle between "Edit\" and "Preview\" mode to see what your file
will look like when rendered. Once you're happy with it, you can commit
the changes by clicking the green button in the top right. Remember to
add a descriptive message!

This was only a small sample of what you can do with Markdown. Github
has extensive
[documentation](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/)
for its own "flavor\" of markdown, and googling will reveal endless tips
and tricks. Another useful way to learn is looking at other people's
code (for example, the guides for this class!). Whenever you click on a
markdown (`.md`) file on GitHub, you can toggle between "Preview\" and
"Code\" tabs.

# Final Problems

Now that you know how to use `git` and write markdown files, please
write your answers in a markdown file hosted in your remote repository.
Use code boxes to print your code, and either comment lines or regular
text to explain what your code is doing each step of the way. Each week
you will create a folder within your `Practicals` folder called `Wx`,
where `x` is the week of the semester we are in. For example this week
would be `W3`. This folder should contain all the files associated with
your answers, such as a main markdown document and any scripts you were
asked to write.

On canvas submit a link to your file.

## Markdown homework

Translate your answers to the Week 1 practical to Markdown format, and
save them in a file called `Lastname_P1.txt`. Synchronize your local and
remote repositories so the file is in both of them. Report the code you
used to do so.

## Semicolon-delimited to comma-delimited

Last class you were asked to write a script that converts table files
delimited with semicolon (`;`) to
comma-delimited (`,`). If needed,
modify this script so it takes the name of the file to be converted as
an argument and writes out the converted file under a different name.
You should be able to run it as follows:

``` bash
    $ bash semicolon_csv_converter.sh file_to_convert.csv
```

Add the script to your local repository and push it to the remote
repository. Report your code every step of the way in the main markdown
file.
