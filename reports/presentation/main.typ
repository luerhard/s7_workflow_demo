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
#set text(font: "App")
#set text(font: "Univers for UniS 55 Roman Rg")
#set list(tight: false, marker: ([•], [--]), spacing: 19pt)
#set enum(number-align: end + bottom, spacing: 19pt)


#let miniheader(content, text-color: uniBlue) = {
  set text(weight: "bold", fill: text-color, size: 30pt)
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
4. Code needs to be run in the same order

= Problem 1

Having the same code

#block[
  #v(20pt)
  #set text(size: 18pt)
  This is what git is for, so we can skip this issue...
]

== Knowledge requirement check

#block[
#set text(size: 36pt)
- Do we all know what a `.gitignore` file is?
]

= Problem 2

Having the same data

#block[
  #v(20pt)
  #set text(size: 18pt)
  aka "oh no, my data is too big for git"
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

#miniheader[Consequences of this approach]

The workflow for using git + dvc changes to:
#block[
#set enum(spacing: 8pt)
1. dvc add / commit
2. git add
3. git commit
4. dvc push
5. git push
]


#focus-slide[
  Demo Time: Introducing MinIO S3 Storage
]


= Problem 3

Ensure the order of execution 

#block[
  #v(20pt)
  #set text(size: 18pt)
  aka "Why are my results from today different from yesterday?"
]

== Using the dvc DAG

TODO: Explain dvc.yaml and the DAG
// #bluebox([Test this], [crazy])
