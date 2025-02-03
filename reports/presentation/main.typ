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

#set text(font: ("SF Camera", "Cantarell"))
#set list(tight: false, marker: ([•], [--]))

#title-slide()

= Problem 1

How to write code collaboratively

== Having multiple people work on code

Being able to work on code with multiple people has major advantages

- The research is way faster
- The code has less bugs
- It keeps the research reproducible

#pause
#v(20pt)
#bluebox([BUT WHAT ABOUT PYTHON VS R?????])

= Problem 2

Keeping track of the data

#block[
  #v(20pt)
  #set text(size: 18pt)
  aka "oh no, my data is too big for git"
]

== Introduction to dvc as storage

TODO: What is dvc?

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
