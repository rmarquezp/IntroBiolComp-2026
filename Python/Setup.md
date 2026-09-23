# Setup for Python sessions

It is possible that your computer already has Python installed. In fact, some operating systems come with multiple copies on Python that are used for different purposes. To make sure things work similarly for everyone, we recommend installing Python through the `conda` package manager, which is a relatively platform-independent way to manage python and its packages (as well as a lot of other software). We will also install a program called `Jupyter` which allows us to run Python from a web browser and annotate our code directly using Markdown.

## Installing Conda

Go to the [Conda downloads site](https://www.anaconda.com/download/), and download the appropriate "Miniconda" installer for your operating system. Follow the prompts of the installer. 

## Installing Python and Jupyter

Now that Conda is installed, we can use it to install other software. When we ask it to install a particular program, Conda will install several other programs that are needed (these are called *dependencies*). For example, if we install Jupyter but our computer doesn't already have Python, it will also be installed. 

### Linux

Open a terminal and run 
```bash
conda install jupyter
```
To verify it worked type
```bash
python --version
jupyter --version
```
### Mac OSX

Open a terminal and run 
```bash
conda install jupyter
```
If you get an error saying the command `conda` was not found, close the terminal and open it again. 

To verify the installation worked type
```bash
python --version
jupyter --version
```
### Windows

Conda should have installed a program called "Anaconda Prompt" or "Anaconda Powershell Prompt", which you can find in your startup menu. Open either and type 
```bash
conda install jupyter
```
You may need to run the Anaonda prompt as administrator to install software. You can do this by right-clicking the application and selecting "Run as Administrator".

To verify the installation worked, open the Anaconda prompt and type 
```bash
python --version
jupyter --version
```

## Alternatives

If you already have Python installed and a way to create Jupyter notebooks (e.g. on Visual Studio Code) feel free to use that. You should be able to do everything we will cover in class. 
