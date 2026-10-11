# Assignment 1: Unix and Python

Provide your answers in markdown format, in a document named `Lastname_A1.md`. *Include all code used* (in code boxes). Please explain in detail what your code is doing. When you are done please follow the submission instructions in Problem 4.


## 1. Number of Subjects (3pt)

Gesquiere et al. (2011) measured hormone levels in the blood of baboons. Every individual was sampled several times.

- **A.** The file you will need for this exercise are in the `IntroBiolComp-2026/Assignment1/` directory of the class GitHub. Use `git` commands to download them. 
- **B.** How many times were individuals 8 and 22 sampled?
- **C.** Write a script that takes the file name and the individual ID and returns the number of times that individual was sampled. Paste your script in a code box with your answer (and explain what it does). Also include the script itself. You can use `Unix` or `python` for this.
- **D.** Write a script that returns a delimited table (e.g. comma-separated or tab-separated) with the number of times each individual was sampled, and saves it as `Num_samples.csv`. The beginning of your file should look similar to this:

    ```
    maleID	Num_samples
    1 	 805
    2 	 457
    3 	 408
    4 	 471
    ...
    ```

## 2. Mining The Origin of Species (5pt)
For many decades, it was commonly accepted among evolutionary biologists that, even if Darwin's *On the Origin of Species by Means of Natural Selection* did a good job laying out his ideas on evolution by natural selection, it failed to address the question in the title (how do new species form?). In this exercise you will mine the entire text of *The Origin* to evaluate if this is the case. 

- **A.** Use the `curl` command to download a text version of *The Origin* from https://www.gutenberg.org/cache/epub/1228/pg1228.txt. Use the `-o` flag to name your file (otherwise the whole file will be dumped to the screen).
- **B.** The current view on the origin of new species is that *reproductive isolation* plays a key role. How many times are the words "sterility" and "isolation" mentioned in the book? **Hint:** don't forget to make your search case-insensitive.
- **C.** To get a better idea of the *context* in which Darwin mentioned these words, search for the 3 lines before and after each occurrence of the key words in point B, and save your results to a text file. Save one file for each key word. 
- **D.** A good way to explore broad patterns of word usage is a diagram called a [word cloud](https://en.wikipedia.org/wiki/Tag_cloud) (also known as a tag cloud).

    Use `Conda` to install a program called [wordcloud](https://anaconda.org/channels/conda-forge/packages/wordcloud/overview), and follow the instructions for command-line usage of this tool, available in the developers' [GitHub](https://github.com/amueller/word_cloud?ref=itsfoss.com#command-line-usage) to generate one word cloud for "sterility" and one for "isolation". Include them in your markdown document. Images can be included in a markdown document as follows. 
    ```
    Below is an image
    ![Name1](Image1.png)

    And here is another 
    ![Name2](Image2.png)
    ```
    `Name1` and `Name2` are names so you can keep track of your images (they can be whatever you want), and `Image1.png` and `Image2.png` are the paths to the image files. In the example above, the images are in the same folder as the markdown document. 

- **E.** Based on your word clouds, do you agree with the idea that Darwin did not address the processes that lead to the formation of new species?

## 3. Twelve days of Christmas (6pt)

The popular Christmas carol *The Twelve Days of Christmas* is a classic example of a cumulative song, where each verse builds on previous verses. In it, the singer describes an increasingly longer list of gifts received by their true love over 12 days of Christmas. The first few verses are below:

```
On the First day of Christmas my true love gave to me:
A Partridge in a Pear Tree

On the Second day of Christmas my true love gave to me:
Two Turtle Doves, and
A Partridge in a Pear Tree

On the Third day of Christmas my true love gave to me:
Three French Hens
Two Turtle Doves, and
A Partridge in a Pear Tree

...
```

The full list of items added to the list is:

- First Day: A Partridge in a Pear Tree
- Second Day: 2 Turtle Doves
- Third Day: 3 French Hens
- Fourth Day: 4 Colly Birds
- Fifth Day: 5 Gold Rings
- Sixth Day: 6 Geese-a-Laying
- Seventh Day: 7 Swans-a-Swimming
- Eight Day: 8 Maids-a-Milking
- Ninth Day: 9 Ldaies Dancing
- Tenth Day: 10 Lords-a-Leaping
- Eleventh Day: 11 Pipers Piping
- Twelfth Day: 12 Drummers Drumming

Write a `python` script that outputs the full lyrics of the song, as displayed in the file `TwelveDaysOfChristmas.txt`, available in the `IntroBiolComp-2026/Assignment1/` directory. 

**Hint:** You may need to use a *nested* loop to do this. This means writing one loop within another loop so that for each iteration of the "outer" loop, the "inner" loop runs its full course. Below is a toy example of a nested loop:

```python
# Outer loop: A-C. 
for i in ["A", "B", "C"]:
    print("Iteration", i, "of the outer loop")
    
    #Inner loop: 0-4.
    for j in range(0,5):
        print("Iteration", j, "of the inner loop")
    print("\n")
```

The outer loop iterates `i` between "A", "B", and "C", and the inner loop iterates `j` from 0 to 4. 

## 4. Submission instructions (1pt)
Once you are done please create a folder called `Assignments` in your GitHub repository. Add your answers and all other relevant files to this folder and upload to GitHub. Report the code you used to add/commit/push the file to the remote repository. 
