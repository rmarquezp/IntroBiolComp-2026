# R III - Simulation, Randomization, and Faster Code

## Testing Hypotheses Using Computers

Testing statistical hypotheses is one of the most common tasks performed
by scientists. In very brief terms, statistical hypothesis testing
entails evaluating whether a particular explanation for our observations
(i.e. a hypothesis) is likely to be true. To achieve this, we calculate
the *probability* of observing our data given our hypothesis. In the
vast majority of cases, this calculation is performed using a
*mathematical model*, that is, a set of mathematical equations that
capture the key features of our hypothesis, which we can use to
calculate the probability of a particular dataset if the hypothesis were
true.

However, there are cases where an explicit mathematical model to test a
hypothesis against our data is not available, for example because
describing the phenomena we're interested in is mathematically
challenging, or because statisticians haven't gotten around to develop
such model. In these cases, computers can come in very handy, since they
allow us to perform large numbers of operations through which we may be
able to evaluate the support of our data for a given hypothesis.

### Null Hypotheses

Arguably, the most common type of hypothesis test done in the biological
sciences is that of a *null hypothesis*. Null hypotheses are usually
statements of \"no effect\" or \"no relationship\" between variables.
More informally, it can be seen as the skeptical point of view: Our
observations are due to chance and not to a particular biological
process or mechanism.

To better understand this idea, consider the following example: A team
of physicians wants to test whether a vaccine is effective ar preventing
a given disease. To do so, they administer injections to a large number
of patients. Half of them receive the vaccine, and the other half
receive a placebo. A good null hypothesis here is that the likelihood of
getting sick is the same regardless of whether patients received the
vaccine or placebo. The counterpart of the null hypothesis is the
*alternative hypothesis*. In this example, the alternative hypothesis
would be that the likelihood of getting sick is different between
vaccinated and placebo subjects.

### Testing Null Hypotheses

To evaluate whether the null or alternative hypothesis is a better
explanation for our observations, we usually test the null. That is, we
calculate the probability of observing our data if the null is true
(e.g. if vaccination status has no effect on the likelihood of catching
the disease). This probability is the famous *$p$-value*. If the
$p$-value is low enough for us to be convinced that the null is a bad
explanation for our data (e.g. $p<0.05$), we can reject it, and
therefore conclude that the alternative hypothesis is true. Even if it
seems counter intuitive at first, this framework has been used by
statisticians for centuries, in part because null hypotheses are much
more straightforward to formulate, both mathematically and
computationally. It is easier to write a precise model or computer
simulation describing what we expect if we assume things are solely due
to chance than if we assume they are due to other factors.

### Testing Null Hypotheses Using Computers

As mentioned above, the probability of observing some data if the null
hypothesis were true can be calculated using a mathematical equation
derived from probability theory. In cases where this is not feasible, we
can use computers to *generate imaginary datasets* that look like what
we would expect if the null hypothesis were true. If we do this many
times, we can get an idea of how likely it is to observe our data if the
null were true. Today's class will focus on two methods to do so:
Simulation, where we generate datasets from scratch by random sampling,
and Randomization where we break up associations between variables by
randomly disorganizing our data. We will also cover ways to speed up
these and other operations in R.

## Simulation

To illustrate how we can simulate datasets and then use them for
hypothesis testing, lets work through an example. In the 1990s some
researchers wondered if, similar to humans, toads display
handedness[^1]. That is, they preferentially use one of their hands (I,
for instance, am right-handed). To test this, they conducted a simple
experiment: They stuck a strip of paper to the snout of a toad multiple
times and recorded which had it used to remove the strip. They repeated
this experiment across multiple toads to evaluate if a particular side
was more dominant than the other.

Lets assume the first toad was tested 16 times, and used its right hand
in 11 of them. Since we want to test whether this toad is more prone to
use one hand than the other, a good null hypothesis can be that the
probability of using the right hand, $p$, is equal to $0.5$. Our
alternative hypothesis is therefore $p \neq 0.5$. The expected value
under our null ($p=0.5$) would be that a toad use its right hand 8 times
and its left another 8. But expecting to observe exactly 50

So, how unexpected would it be to observe 13 right hands out of 16
trials if $p=0.5$? We can evaluate this by simulating our experiment in
R many times to see how often this happens. Lets begin by simulating one
experiment:

``` R
    # Sample "right" or "left" 16 times with replacement
    experiment <- sample(c("R", "L"), size=16, prob=c(0.5, 0.5), replace=T)

    # Count the number of "R"
    right <- sum(experiment == "R")
```

The object `experiment` contains the result of our simulated experiment,
and `right` contains the number of times our simulated toad used their
right hand.

``` R
    > experiment
     [1] "L" "L" "L" "R" "L" "L" "L" "L" "R" "R" "L" "L" "R"
    [14] "L" "L" "L"
    > right
    [1] 6
```

In this case we observed 6 out of 16 trials were \"right-handed\"
trials. Now lets use a loop to repeat our simulated experiment 100
times, and see what the

``` R
    # Define empty vector to save results
    right_ct <- c()

    # Define number of experiments
     nExp <- 100
     
    # Simulate
     
    for(i in 1:nExp){
        # Sample "right" or "left" 16 times with replacement
        experiment <- sample(c("R", "L"), size=16, prob=c(0.5, 0.5), replace=T)
        
        # Count the number of "R"
        right <- sum(experiment == "R")
        
        # Save results
        right_ct[i] <- right
    }
```

The number of right hands in each experiment is stored in the vector
`right_ct`.

``` R
    > right_ct
      [1]  8 11  8  8  5  8 10  5  9 11  7  9 12 10 10  6  9
     [18]  5  6  7  7  7 10  5  7  7  8  9 11  6  8  5  6  9
     [35]  8  9  6 10  8  5  9  3  8  7  9 10 10 12  9  5  7
     [52]  8  9  8  4  7  8  8  4  8  9  9  7  9  7  7 11 10
     [69]  9  9  9 10  8 10  9  7 11  5 12  7  5  8  6  9  7
     [86]  5  6 10  8  5  9 10  4  9 10 11  8  6  9  4
```

We can summarize this using the function
`table`

``` R
    > table(right_ct)
    right_ct
     3  4  5  6  7  8  9 10 11 12 
     1  4 11  8 15 18 21 13  6  3 
```

Most experiments did result in 8 right hands, as expected, but there was
considerable *variance* around this expected value. Because we are
interested in probabilities, we can estimate these by dividing our
observations by the total number of simulations conducted (100,000).

``` R
    > table(right_ct)/nExp
    right_ct
        3     4    5     6    7    8    9   10    11    12 
     0.01  0.04 0.11  0.08 0.15 0.18 0.21 0.13  0.06  0.03 
```

Note how some values, including 13, were not observed. This could be
either because these events are impossible, or they are rare enough that
we didn't observe them after 100 experiments. To be sure we observe rare
events, it is good to run a larger number of simulations. As a rule of
thumb we should run *at least* $n$ simulations if we want to observe an
event that has $\frac{1}{n}$ probability. Lets run 100,000 simulations.

``` R
    # Define empty vector to save results
    right_ct <- c()

    # Define number of experiments
     nExp <- 100000
     
    # Simulate
     
    for(i in 1:nExp){
        # Sample "right" or "left" 16 times with replacement
        experiment <- sample(c("R", "L"), size=16, prob=c(0.5, 0.5), replace=T)
        
        # Count the number of "R"
        right <- sum(experiment == "R")
        
        # Save results
        right_ct[i] <- right
    }

    # Calculate probabilities
    probs <- table(right_ct)/nExp
```

``` R
    > probs
    right_ct
          0       1       2       3       4       5       6 
    0.00001 0.00023 0.00190 0.00898 0.02831 0.06659 0.12171 
          7       8       9      10      11      12      13 
    0.17533 0.19705 0.17490 0.12200 0.06550 0.02728 0.00804 
         14      15      16 
    0.00190 0.00026 0.00001
```

Now all values were observed. We can better visualize these results by
plotting them (more on that next time!).

``` R
    barplot(probs, xlab="Number of Rights", ylab="Proportion of Simulations")
```

The probability of observing 13/16 is very low (0.008). However, when
testing a null hypothesis we usually ask the probability of observing a
result *as unusual or more unusual* than what we observed if the null
hypothesis were true. With this in mind, we will calculate our $p$-value
as the probability of observing 13 or more right hands, or 13 or more
left hands (i.e. 3 or less right hands). That is:

$$P[\texttt{13 or more rights}] = P[13]+P[14]+P[15]+P[16]$$
$$P[\texttt{13 or more lefts}] = P[0]+P[1]+P[2]+P[3]$$

We extract these numbers from our table

``` R
    > probs[1:4]
    right_ct
          0       1       2       3 
    0.00001 0.00023 0.00190 0.00898 
    > probs[14:17]
    right_ct
         13      14      15      16 
    0.00804 0.00190 0.00026 0.00001 
```

And add them

``` R
    > sum(c(probs[1:4], probs[14:17]))
    [1] 0.02133
```

The probability that this particular toad does not display handedness is
0.021, which is lower than the typically used *critical value* of
$p=0.05$, so we can reject the null hypothesis, and conclude that this
toad preferentially uses one of its hands to remove objects from its
snout. Given the right hand was used more often than the left, we can
say this toad is right handed.

**Exercise:** The investigators ran handedness trials on another three
toads. The first one used its right hand in 2 out of 16 trials, the
second in 15 out of 16, and the third in 13 out of 18. Use simulated
data to statistically test whether they are right or left handed.

## Randomization

Simulation is a powerful tool to test statistical hypotheses when
traditional tests are not appropriate. However, in cases where we want
to preserve specific features of our data that are hard to simulate
without certain assumptions, such as the appropriate *sampling
distributions* for simulation, we can use other computational
approaches.

Randomization tests can be used to test for associations between
variables. Briefly, randomization tests consist of reorganizing our data
to obtain a new (randomized) dataset where each individual keeps its
measurement for one variable but has another individual's value randomly
assigned for the other variable. This breaks up any associations between
variables in our original data. We then calculate some measure of
association between variables (i.e. a *test statistic*), such as a
correlation coefficient (e.g. $r^2$), and compare it with the same
statistic calculated from our observed data. If we repeat this procedure
many times, we can get an idea of how likely it would be for our
observations to be due to chance.

Lets work through another example. In the 1960s NIH scientist Nathan
Mantel wanted to test whether cases of leukemia in the US tended to
appear together at particular times and places (i.e. they are
spatiotemporally clustered). To do so, he wanted to test whether cases
that appeared close to each other in space also appeared at similar
times. He wanted to do so by evaluating the correlation between the
spatial and temporal distances between all pairs of cases. Because he
was dealing with *pairwise* comparisons, his data points were not
independent from each other, which is a key assumption of traditional
correlation analyses. He used randomization instead.

The raw data used by Mantel are not publicly available, but we can
create an example dataset for the sake of this class. Lets imagine that
a team of medical scientists followed the incidence of leukemia across a
region over multiple years, over which 92 cases were reported. The
scientists recorded the time an place of all reported cases and
calculated the geographic distance between all pairs of cases, as well
as the time that passed between all pairs. These data were recorded in
two 92 x 92 *distance matrices*, which are in the `R/DataFiles/` folder.
Lets see what they look like:

``` R
    # Geographic distnaces
    geo_dist <- read.csv("Leuk_geoDist.csv", row.names=1)

    # Temporal distances
    temp_dist <- read.csv("Leuk_tempDist.csv", row.names=1)

    # both are 92 x 92
    dim(geo_dist)
    [1] 92 92
    dim(temp_dist)
    [1] 92 92

    # Visualize the first few cells
    geo_dist[1:5, 1:5]
             X1       X2       X3        X4       X5
    1  0.000000 15.67063 66.69461  7.366596 46.79583
    2 15.670629  0.00000 54.93859 16.762133 31.82382
    3 66.694605 54.93859  0.00000 70.877638 51.88239
    4  7.366596 16.76213 70.87764  0.000000 44.97176
    5 46.795829 31.82382 51.88239 44.971759  0.00000

    temp_dist[1:5, 1:5]
            X1       X2       X3       X4       X5
    1   0.0000 241.0196 399.8340 176.0777 449.3349
    2 241.0196   0.0000 388.4792 254.4863 313.1033
    3 399.8340 388.4792   0.0000 283.5804 356.6883
    4 176.0777 254.4863 283.5804   0.0000 211.9422
    5 449.3349 313.1033 356.6883 211.9422   0.0000
```

In our martices, each cell contains a comparison between two cases, for
instance, row `geo_dist[2,4]` contains the distance between cases 2 and
4.

R has a data class specifically for distance matrices, which will
facilitate our work. Lets convert our matrices.

``` R
    geo_dist <- as.dist(geo_dist)
    temp_dist <- as.dist(temp_dist)

    class(geo_dist)
    [1] dist

    class(temp_dist)
    [1] dist
```

Now lets visualize the relationship between matrices, and check for a
correlation by calculating Spearman's correlation coefficient, which is
sometimes denoted as $\rho$.

``` R
    plot(geo_dist, temp_dist, xlab="Geographic Distance (Km)", ylab="Temporal Distance (days)")

    ## There does seem to be a correlation, lets quantify it
    cor(geo_dist, temp_dist, method="spearman")
    [1] 0.387516
```

So our variables seem to be correlated. How do we test whether this
correlation is expected due to chance? Mantel's approach involved
randomly shuffling one of the matrices and recalculating the correlation
coefficient many times to then compare with his empirical correlation.
Lets try one iteration of shuffling the temporal distance and
correlating it with the unperturbed geographic distance matrix. We will
first generate a random order by randomly sampling all numbers from 1 to

``` R
    # Get random order
    order <- sample(1:length(temp_dist), size=length(temp_dist), rep=F)

    #create shuffled distance matrix
    temp_shuf <- temp_dist[order]

    # visualize -- correlations seems to have disappeared
    plot(geo_dist, temp_shuf, xlab="Geographic Distance (Km)", ylab="Temporal Distance (days)")

    ## Correlation is also much lower
    cor(geo_dist, temp_shuf, method="spearman")
    [1] -0.01120947
```

Now lets repeat this procedure many times, and see how similar our
observed correlation coefficient is to the randomized ones.

``` R
    # Number of permutations
    nPer <- 10000

    # Empty vector to save correlation coefficients
    cor_coef <- c()

    #Randomization
    for(i in 1:nPer){

        # Get random order
        order <- sample(1:length(temp_dist), size=length(temp_dist), rep=F)

        #create shuffled distance matrix
        temp_shuf <- temp_dist[order]

        ## Save correlation coefficient
        cor_coef[i] <- cor(geo_dist, temp_shuf, method="spearman")
    }
```

The `cor_coef` vector now contains our 10,000 random correlation
coefficients. Lets see how many are equal or larger in magnitude than
our observation of $\rho=0.387$.

``` R
    # Number of random coefficients equal or larger than 0.387
    sum(cor_coef >= 0.387)
    [1] 0
    # Number of random coefficients equal or smaller than -0.387
    sum(cor_coef <=- 0.387)
    [1] 0

    # Neater way to do the same 
    sum(abs(cor_coef) >= 0.387)
    [1] 0
```

None of our randomizations found a correlation as strong as what we
observed in our data. This result tells us that our $p$-value is
probably smaller than $\frac{1}{10,000} = 0.0001$ (reported as
$p<0.0001$), so we can definitely reject the null and conclude that
leukemia cases may have been clustered in time and space in our
imaginary region.

**Exercise:** Female pseudoscorpions of the species *Cordylochernes
scorpioides* often mate with multiple males before laying eggs. A team
of researchers wanted to test whether multiple mating leads to a higher
number of successful clutches. To do so, they reared 36 females in the
lab, and paired them with one male. A few weeks later they removed the
male and either introduced a new male (DM treatment), or put the same
male back into the enclosure (SM treatment). The researchers then
counted the number of successful broods each female had at the and of
the reproductive season. Their data are in the tab-delimited file
`Pseudoscorpion_mating.tsv`. In this exercise you will test whether the
number of successful broods differs between treatments using
randomization.

1.  Load the data into R and calculate the mean number of successful
    broods for females in the DM and SM treatment separately. Which one
    is larger? By how much?

2.  Write a function to randomize the order of the variable
    `Successful_broods` (i.e. the *response variable*).

3.  Calculate the difference between means of the two treatments for
    your new randomized variable.

4.  Repeat steps 2 and 3 10,000 times, saving the difference in means in
    a vector.

5.  Find the number of randomizations in which you obtained a mean
    difference of magnitude larger than or equal to the difference
    calculated for the observed data in step 1.

6.  Calculate a $p$-value by dividing your result from 5 by the number
    of randomizations performed. Does your result support the idea that
    mating with two males result in more successful broods?

## Speeding up your code

R is a very powerful language for statistics, but one of its main
drawbacks is that it is very slow for cyclical operations, such as `for`
and `while` loops. This is because R translates your code to \"machine
language\" (i.e. 1s and 0s) at every step of the way, instead of doing
it all at once.

In most cases these run time differences will be nearly (or actually)
unperceivable for you. Yet, in some cases you may want to optimize your
code to avoid long run times. For these cases, R has several functions
that can speed up certain operations. We will briefly cover two of them.
They may be a bit more advanced than what this class calls for, but it
is good to be aware of them in case learning them comes in handy in the
future.

### Vectorizing

In R vectors and matrices can only contain data of a single type. This
allows R to quickly perform the same operation to all elements of a
vector or matrix. Not only does this save us lines of code, but can save
us considerable time. Lets do a simple example: We want to divide each
element of a long vector by 4 and save the results to a new vector. We
can create a function that does that, and compare its run time vs the
command `x/4`.

``` R
    # randomly sample 10 million numbers
    vec <- runif(1e7)

    # Function to divide vector x by 4
    divide_by4 <- function(x){
        # Empty vector for results
        newvec <- c()
        
        # Loop through vector elements
        for(i in 1:length(x)){
            # Divide by 4
            newvec[i] <- x[i]/4
        }
        return(newvec)
    }

    # time of execution of loop
    system.time(divide_by4(vec))
       user  system elapsed 
      1.110   0.344   1.462 
     
    # time of execution of vectorized operation
    system.time(vec/4)
       user  system elapsed 
      0.006   0.016   0.022 
```

Vectorizing is **considerably** faster. This could save you a lot of
time if you need to do a very large number of complex operations.

### Apply loops

R has a collection of functions that perform the same operations cross
elements of a vector, matrix or list. These are sometimes known as
\"Apply\" functions. The base function is
`apply()`, and there are several
versions of it intended for slightly different uses. For instance,
`lapply()` applies the same
function to all elements in a vector or list and returns a list, and
`sapply()` does the same but
returns a vector. These can be faster than the `for` and `while` loops
that we've been using, but not in every case. I encourage you to read
about them if you need to optimize your code's runtime.

## Final Problems

Answer the following questions in a **single markdown-formatted
document** within a folder in your GitHub repository (e.g.
`Practicals/W10/`). Add any scripts and other files you create to the
folder as well.

### Are most toads right handed?

Humans do not only show preferential use of one of our hands, but the
majority of the population also shows preference for using the right
hand. In other words, most humans are right-handed. In this exercise you
will test whether the same is true for toads.

The file `R/DataFiles/Toad_Handedness.tsv` contains their results.

1.  For each toad, use simulations to determine whether the results
    support right handedness, left handedness or no handedness.

2.  Using your results from 1. test the null hypothesis that a frog is
    equally likely to be right or left handed.

3.  Using *randomization* test the null hypothesis that males and
    females are equally likely to be right handed

### Assortative Mating in Animals (A & W 4.10.1)

Jiang et al. (2013) studied assortative mating in animals. They compiled
a large database, reporting the results of many experiments on mating.
In par ticular, for several taxa they provide the value of correlation
among the sizes of the mates. A positive value of r stands for
assortative mating (large animals tend to mate with large animals), and
a negative value for disassortative mating. 1. 2.

1.  You can find the data in `R/DataFiles//Jiang2013_data.csv`. Write a
    function that takes as input the desired Taxon and returns the mean
    value of r.

2.  You should see that fish have a positive value of r, but that this
    is also true for other taxa. Is the mean value of r especially high
    for fish? To test this, compute a $p$-value by repeatedly sampling
    37 values of r at random from the entire dataset (37 experiments on
    fish are reported in the database), and calculating the probability
    of observing a higher mean value of r. To get an accurate estimate
    of the $p$-value, use 50,000 randomizations.

3.  Repeat the procedure for all taxa.

[^1]: <https://doi.org/10.1038/379408a0>
