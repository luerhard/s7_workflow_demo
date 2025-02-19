#import "@preview/touying:0.5.5": *
#import themes.metropolis: *
#import "@preview/fletcher:0.4.4" as fletcher: node, edge
#import "@preview/showybox:2.0.1": showybox

#let uniBlue = rgb("#004191")
#let uniLightBlue = rgb("#00BEFF")
#let uniGray = rgb("#3E444C")
#let uniYellow = rgb("#FFD500")


#let bluebox(..args) = {
  let title = ""
  let body = ""
  if args.pos().len() > 1 {
    title = args.pos().at(0)
    body = args.pos().slice(1)
  } else {
    body = args.pos()
  }
  showybox(
    frame: (
      border-color: uniBlue.darken(10%),
      title-color: uniBlue,
      body-color: uniBlue.lighten(80%),
    ),
    title-style: (
      color: white,
      weight: "bold",
      align: center
    ),
    body-style: (
      color: black
    ),
    shadow: (
      offset: 0pt,
    ),
    title: title,
    ..body
  )
}


#show: metropolis-theme.with(
  config-colors(
    primary: uniBlue,
    primary-light: uniLightBlue,
    secondary: uniBlue,
  ),
  config-info(
    title: [A Reproducible Research Pipeline],
    subtitle: [Using Git and Data Version Control (dvc)],
    author: [Lukas Erhard],
    date: datetime.today(),
    institution: [University of Stuttgart, CSS Lab],
    logo: image("img/logos/logo_s7_bg_none.png", height: 60%)
  )
)

// #set text(font: ("SF Camera", "Cantarell"))
#set text(font: "Univers for UniS 55 Roman Rg")
#set list(tight: false, marker: ([•], [--]), spacing: 19pt)
#set enum(number-align: end + bottom, spacing: 19pt)


#let miniheader(content, text-color: uniBlue, size: 30pt) = {
  set text(weight: "bold", fill: text-color, size: size)
  content
  v(1pt)
}

#title-slide()

= The Big Problem

How can we work on the same research project collaboratively?

== Having multiple people work on code

#miniheader([Working on research together has major advantages])

- The research is faster
- The code has less bugs
- It keeps the research reproducible

== Requirements to work together

#miniheader([What do we need to work together?])

1. Same code
2. Same data
3. Same environment
4. Ensured order of execution

#miniheader([What do we want for compute-intensive projects?])

1. Being able to run code on clusters
2. Not re-run all code every time

= Problem 1

Having the same code

#block[
  #v(20pt)
  #set text(size: 18pt)
  This is what git is for, so we can skip this problem...
]


#focus-slide[
  Do we all know what a `.gitignore` file is?
]

= Problem 2

Having the same data

#block[
  #v(20pt)
  #set text(size: 18pt)
  aka "oh no, my data is too big for git, let's use `data_final_corrected_final2_superfinal.csv`"
]

== Introduction to dvc as storage

#miniheader([What is dvc?])

- Tool (written in Python) that augments the functionality of git 
- DVC stands for: *Data Version Control*
- provides the commmand: *dvc*



== How to add/track data with dvc

#miniheader[command: dvc add \[path/to/file\]]
- adds any file or folder to a `.gitignore` file
- creates a `.dvc` file instead which is still tracked by git

  - contains the md5-hash of the original file
  - is used to keep dvc and git in sync

- moves the file to `.dvc/cache/` and links to it from its original position

#miniheader[command: dvc commit \[path/to/file\]]
- if a file changes and you want to add the changes, run *dvc commit* to update it

== How to push data with dvc

  #miniheader[command: dvc push]
  - pushes all dvc tracked data to a specified remote
  - There are many backends available, *we have our own*

#focus-slide[
  Demo Time: Introducing MinIO S3 Storage
]

== How using dvc changes the git workflow
#grid(
columns: (1fr, 1fr, 1fr),
rows:(auto, 1fr),
gutter: 5pt,
grid.cell(
  colspan: 3,
  [
  #miniheader[Consequences of this approach]
  The workflow for using git + dvc changes to:
  #v(38pt)

],
),
[
  #align(top)[
  #miniheader(size: 19pt)[Sending data]
  1. dvc add 
  2. git add
  3. git commit
  4. dvc push
  5. git push
]],
[
  #align(top)[
  #miniheader(size: 19pt)[Getting data]
  1. git pull
  2. dvc pull
]],
[
#align(top)[
  #miniheader(size: 19pt)[Switching branch]
  1. git checkout `BRANCH`
  2. dvc checkout / pull
]],
)


= Problem 3

Same environment

#block[
  #v(20pt)
  #set text(size: 18pt)
  We had a talk on this recently, a possible solution would be *nix*
]

#focus-slide[
  Demo Time: A `flake.nix` file for us
]


= Problem 4

Ensure the order of execution  & not re-run all code every time

#block[
  #set text(size: 17pt)
  aka "Well, it worked on my machine OR oh, you need to run `prepare_data23.py` BEFORE `create_model.R`"
]

== Using dvc pipelines

With *dvc* you can create a DAG of all steps of your research pipeline

- A pipeline is defined in stages which depend on one another

#miniheader()[command: dvc repro \[STAGE\]]

- Command is used to reproduce a research pipeline
- Re-runs only stages that have changed, used cached results for everything else
- Result caches are shared by using dvc

#bluebox([What does this mean?], [We can run different parts of the pipeline on different computers (e.g., parts of it on a cluster)!])


== A dvc pipeline

The pipeline is defined in a file called `dvc.yaml`

#miniheader()[Pipeline is defined in stages]
- Each stage can have *dependencies* and *outputs*. These determine the DAG.
#pause
- A dependency can be any hashable object, e.g.:

  - outputs of previous stages (This is how we define the DAG)
  - folders with data in it
  - python / R files with code in it

#pause
- Each stage has a *single command* that is executed, e.g.:
  
  - python pipeline/some_python_script.py
  - Rscript pipeline/some_r_script.R
#focus-slide[
  Demo Time 1: Show `dvc dag`

  Demo Time 2: A look at the `dvc.yaml`
]
