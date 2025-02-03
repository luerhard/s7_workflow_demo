// This theme is inspired by https://github.com/zbowang/BeamerTheme
// The typst version was written by https://github.com/OrangeX4

#import "@preview/touying:0.5.5": *

#let uniBlue = rgb("#004191")
#let uniLightBlue = rgb("#00BEFF")
#let uniGray = rgb("#3E444C")
#let uniYellow = rgb("#FFD500")

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  // set page
  let header(self) = {
    set align(top)
    show: components.cell.with(fill: self.colors.primary, inset: 1em)
    set align(horizon)
    set text(fill: self.colors.neutral-lightest, size: .7em)
    utils.display-current-heading(level: 1)
    linebreak()
    set text(size: 1.5em)
    if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2)
    }
  }

  let footer(self) = {
    set align(bottom)
    show: pad.with(.4em)
    set text(fill: self.colors.neutral-darkest, size: .8em)
    utils.call-or-display(self, self.store.footer)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(self: self, ..args)
})

#let stuttgart-theme(
  aspect-ratio: "16-9",
  footer: none,
  ..args,
  body,
) = {
  set text(size: 20pt)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 4em, bottom: 1.5em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
    ),
    config-methods(
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      neutral-darkest: rgb("#000000"),
      neutral-dark: uniGray,
      neutral-light: uniLightBlue,
      neutral-lightest: rgb("#ffffff"),
      primary: uniBlue,
    ),
    config-store(
      title: none,
      footer: footer,
    ),
    ..args,
  )

  body
}


#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  // set page
  let header(self) = {
    set align(top)
    show: components.cell.with(fill: self.colors.primary, inset: 1em)
    set align(horizon)
    set text(fill: self.colors.neutral-lightest, size: .7em)
    utils.display-current-heading(level: 1)
    linebreak()
    set text(size: 2.5em)
    if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2)
    }
  }
  let footer(self) = {
    set align(bottom)
    show: pad.with(.4em)
    set text(fill: self.colors.neutral-darkest, size: .8em)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(self: self, ..args)
})

#let stuttgart-theme(
  aspect-ratio: "16-9",
  header: self => utils.display-current-heading(depth: self.slide-level),
  footer: context utils.slide-counter.display(),
  ..args,
  body, 
) = {
  set text(size: 20pt)
  show: touying-slides.with(
    config-page(paper: "presentation-" + aspect-ratio),
    config-common(
      slide-fn: slide,
    ),
    config-colors(
      neutral-darkest: rgb("#000000"),
      neutral-dark: uniGray,
      neutral-light: uniLightBlue,
      neutral-lightest: rgb("#ffffff"),
      primary: uniBlue,
    ),
    config-methods(
      alert: (self: none, it) => text(fill: self.colors.primary, it)
    ),
    // config-page(
    //   header: header,
    //   footer: footer,
    // ),
    config-store(
      title: none,
      footer: footer,
  ),
    ..args,
  )

  body
}
}
/*
#let slide(
  self: none,
  subsection: none,
  title: none,
  footer: auto,
  ..args,
) = {
  self.page-args += (
    fill: self.colors.neutral-lightest,
  )
  if footer != auto {
    self.m-footer = footer
  }
  (self.methods.touying-slide)(
    ..args.named(),
    self: self,
    subsection: subsection,
    title: title,
    setting: body => {
      set text(fill: self.colors.neutral-darkest)
      show heading: set text(fill: self.colors.primary)
      show: args.named().at("setting", default: body => body)
      if self.auto-heading-for-subsection and subsection != none {
        heading(level: 1, states.current-subsection-with-numbering(self))
      }
      if self.auto-heading and title != none {
        heading(level: 2, title)
      }
      body
    },
    ..args.pos(),
  )
}

#let title-slide(
  self: none,
  extra: none,
  ..args,
) = {
  self = utils.empty-page(self)
  self.page-args += (fill: gradient.linear(uniBlue, uniLightBlue, angle: 1deg))
  let info = self.info + args.named()
  let content = {
    set text(size: 28pt, fill: self.colors.neutral-darkest)
    set align(top + right)
    block(width: 100%, inset: 3em, {
      place(
        top + left,
        dx: -60pt,
        dy: -60pt,
        image("img/logos/logo_us_white.png", width: 30%)
      )
      place(
        top + left,
        dx: 610pt,
        dy: -60pt,
        image("img/logos/logo_iris_full_white.png", width: 20%)
      )
      place(
        top + left,
        dx: -70pt,
        dy: 245pt,
        image("img/logos/logo_s7_bg_none.png", width: 20%)
      )
      place(
        right,
        dx: 110pt,
        dy: 10pt,
      circle(
        fill: uniGray,
        radius: 280pt,
      )[
        #set text(fill: white)
        #set align(left + horizon)
        #info.title
        #linebreak()
        #set text(size: .8em)
        #block(
          if info.author != none {
            block(spacing: 1em, info.author)
          }
        )
      #v(1em)
      #block(if info.date != none {
        block(spacing: 1em, utils.info-date(self))
      }
      )
      #set text(size: .8em)
      #block(if info.institution != none {
        block(spacing: 1em, info.institution)
      }
      )
      #block(if extra != none {
        block(spacing: 1em, extra)
      }
      )
      ]
      )
    })
  }
  (self.methods.touying-slide)(self: self, repeat: none, content)
}

#let outline-slide(self: none, ..args) = {
  (self.methods.slide)(self: self, heading(level: 2, self.outline-title) + parbreak() + (self.methods.touying-outline)(self: self, cover: false))
}

#let focus-slide(self: none, body) = {
  self = utils.empty-page(self)
  self.page-args += (
    fill: self.colors.primary,
    margin: 2em,
  )
  set text(fill: self.colors.neutral-lightest, size: 1.5em)
  (self.methods.touying-slide)(self: self, repeat: none, align(horizon + center, body))
}

#let new-section-slide(self: none, section) = {
  (self.methods.slide)(self: self, section: section, heading(level: 2, self.outline-title) + parbreak() + (self.methods.touying-outline)(self: self))
}

#let d-outline(self: none, enum-args: (:), list-args: (:), cover: true) = states.touying-progress-with-sections(dict => {
  let (current-sections, final-sections) = dict
  current-sections = current-sections.filter(section => section.loc != none)
  final-sections = final-sections.filter(section => section.loc != none)
  let current-index = current-sections.len() - 1
  let d-cover(i, body) = if i != current-index and cover {
    (self.methods.d-cover)(self: self, body)
  } else {
    body
  }
  set enum(..enum-args)
  set list(..enum-args)
  set text(fill: self.colors.primary)
  for (i, section) in final-sections.enumerate() {
    d-cover(i, {
      enum.item(i + 1, [#link(section.loc, section.title)<touying-link>] + if section.children.filter(it => it.kind != "slide").len() > 0 {
        let subsections = section.children.filter(it => it.kind != "slide")
        set text(fill: self.colors.neutral-dark, size: 0.9em)
        list(
          ..subsections.map(subsection => [#link(subsection.loc, subsection.title)<touying-link>])
        )
      })
    })
    parbreak()
  }
})


#let d-mini-slides(self: none) = states.touying-progress-with-sections(dict => {
  let (current-sections, final-sections) = dict
  current-sections = current-sections.filter(section => section.loc != none)
  final-sections = final-sections.filter(section => section.loc != none)
  let current-i = current-sections.len() - 1
  let cols = ()
  let current-count = 0
  for (i, section) in current-sections.enumerate() {
    if self.d-mini-slides.section {
      for slide in section.children.filter(it => it.kind == "slide") {
        current-count += 1
      }
    }
    for subsection in section.children.filter(it => it.kind != "slide") {
      for slide in subsection.children {
        current-count += 1
      }
    }
  }
  let final-count = 0
  for (i, section) in final-sections.enumerate() {
    let primary-color = if i != current-i { uniGray.lighten(50%) } else { white }
    cols.push({
      set align(left)
      set text(fill: primary-color)
      [#link(section.loc, utils.section-short-title(section.title))<touying-link>]
      linebreak()
      if self.d-mini-slides.section {
        for slide in section.children.filter(it => it.kind == "slide") {
          final-count += 1
          if i == current-i and final-count == current-count {
            [#link(slide.loc, sym.circle.filled)<touying-link>]
          } else {
            [#link(slide.loc, sym.circle)<touying-link>]
          }
        }
      }
      if self.d-mini-slides.section and self.d-mini-slides.subsection {
        linebreak()
      }
      for subsection in section.children.filter(it => it.kind != "slide") {
        for slide in subsection.children {
          final-count += 1
          if i == current-i and final-count == current-count {
            [#link(slide.loc, sym.circle.filled)<touying-link>]
          } else {
            [#link(slide.loc, sym.circle)<touying-link>]
          }
        }
        if self.d-mini-slides.subsection {
          linebreak()
        }
      }
    })
  }
  set align(top)
  show: block.with(fill: uniBlue.lighten(10%), inset: (top: .6em, x: 2em, bottom: .4em))
  show linebreak: it => it + v(-1em)
  set text(size: .7em)
  grid(columns: cols.map(_ => auto).intersperse(1fr), ..cols.intersperse([]))
})

#let slides(self: none, title-slide: true, outline-slide: true, slide-level: 2, ..args) = {
  if title-slide {
    (self.methods.title-slide)(self: self)
  }
  if outline-slide {
    (self.methods.outline-slide)(self: self)
  }
  (self.methods.touying-slides)(self: self, slide-level: slide-level, ..args)
}

#let register(
  self: themes.default.register(),
  aspect-ratio: "16-9",
  navigation: "sidebar",
  sidebar: (width: 10em),
  mini-slides: (height: 4em, x: 2em, section: false, subsection: true),
  footer: [],
  footer-right: states.slide-counter.display() + " / " + states.last-slide-number,
  alpha: 70%,
  ..args,
) = {
  assert(navigation in ("sidebar", "mini-slides", none), message: "navigation must be one of sidebar, mini-slides, none")
  // color theme
  self = (self.methods.colors)(
    self: self,
    neutral-darkest: rgb("#000000"),
    neutral-dark: uniGray,
    neutral-light: uniLightBlue,
    neutral-lightest: rgb("#ffffff"),
    primary: uniBlue,
  )
  // save the variables for later use
  self.d-navigation = navigation
  self.d-mini-slides = mini-slides
  self.d-footer = footer
  self.d-footer-right = footer-right
  self.d-alpha = alpha
  self.auto-heading = true
  self.auto-heading-for-subsection = true
  self.outline-title = [Outline]
  // set page
  let header(self) = {
      (self.methods.d-mini-slides)(self: self)
  }
  let footer(self) = {
    set text(size: 0.8em)
    set align(bottom)
    show: pad.with(.5em)
    text(fill: self.colors.neutral-darkest.lighten(40%), utils.call-or-display(self, self.d-footer))
    h(1fr)
    text(fill: self.colors.neutral-darkest.lighten(20%), utils.call-or-display(self, self.d-footer-right))
  }
  self.page-args += (
    paper: "presentation-" + aspect-ratio,
    fill: self.colors.neutral-lightest,
    header: header,
    footer: footer,
    header-ascent: 0em,
    footer-descent: 0em,
  ) + if navigation == "sidebar" {(
    margin: (top: 2em, bottom: 1em, x: sidebar.width),
  )} else if navigation == "mini-slides" {(
    margin: (top: mini-slides.height, bottom: 2em, x: mini-slides.x),
  )} else {(
    margin: (top: 2em, bottom: 2em, x: mini-slides.x),
  )}
  // self = (self.methods.numbering)(self: self, section: "1.", "1.1")
  // register methods
  self.methods.slide = slide
  self.methods.title-slide = title-slide
  self.methods.outline-slide = outline-slide
  self.methods.focus-slide = focus-slide
  self.methods.new-section-slide = new-section-slide
  self.methods.touying-new-section-slide = none
  self.methods.slides = slides
  self.methods.d-cover = (self: none, body) => {
    utils.cover-with-rect(fill: utils.update-alpha(
      constructor: rgb, self.page-args.fill, self.d-alpha), body)
  }
  self.methods.touying-outline = d-outline
  self.methods.d-outline = d-outline
  self.methods.d-mini-slides = d-mini-slides
  self.methods.alert = (self: none, it) => text(fill: self.colors.primary, it)
  self.methods.init = (self: none, body) => {
    set heading(outlined: false)
    set text(size: 20pt)
    set par(justify: true)
    show heading: set block(below: 1.5em)

    //disable section numbers
    body
  }
  self
}
*/