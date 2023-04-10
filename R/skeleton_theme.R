#' Bicycle theme
#'
#' @param ... Any additional ggplot2 theme arguments that need to be overwritten
#' @import ggplot2
#' @return custom theme
#' @export
#'
#' @examples theme_bicycle()
theme_bicycle = function(...){
  ggplot2::theme(
    panel.background = ggplot2::element_blank(),
    panel.grid = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(color = "black"),
    legend.box.background = ggplot2::element_blank(),
    legend.key = ggplot2::element_rect(fill = NA),
    text = ggplot2::element_text(family = 'New Grotesk', face = 'bold'),
    plot.title = ggplot2::element_text(size = 16),
    strip.background = ggplot2::element_rect(fill="#7d19ff ")
    # also need facet text color? strip.text.x = element_text(colour = 'x', size = XX)
  )
} ## this will be built up/adjusted much more, but this works for now


## custom geoms ----
# this makes point at least size 3, bars have white outlines and lines size 1
#update_geom_defaults("point", list(size = 3))
#update_geom_defaults("bar", list(color = "white"))
#update_geom_defaults("line", list(size = 1))

## color palette ----
## bicycle colors ----
bicycle_colors <- c(
  indigo = '#7d19ff',
  neongreen = '#63ec00',
  fusciapink = '#f851d4',
  electricblue = '#00fafa',
  acidyellow = '#e0ff2e',
  warmred = '#d31526',
  mint = '#82dc9c',
  royalblue = '#0041c2',
  lavender = '#9b4fff',
  charcoal = '#404040',
  grapefruit = '#ee7461',
  applegreen = '#82d500',
  majorelleblue = '#0b57ff',
  orchid = '#bb3fb5',
  graphite = '#666666',
  citrus = '#ff852e',
  forestgreen = '#00a900',
  skyblue = '#009ae7',
  hotpink = '#f0569a',
  stone = '#999999',
  lemon = '#e8e719',
  lockwood = '#006a00',
  cyan = '#00d9ff',
  violet = '#5818ab',
  steel = '#e5e5e5'
)



## a function to get colors by name ----
#' Function to extract bicycle colors as hex codes
#' @import ggplot2
#' @return a vector of hex codes
#' @param ... Character names of bicycle_colors
#' @export
#' @examples bicycle_cols()
#' bicycle_cols('indigo')
#' bicycle_cols('forestgreen', 'lockwood')
bicycle_cols <- function(...) {
  cols <- c(...)
  if (is.null(cols))
    return (bicycle_colors)
  bicycle_colors[cols]
}


## palettes ----
bicycle_palettes <- list(
  forwardfacing = bicycle_cols('indigo', 'neongreen', 'fusciapink', 'electricblue', 'acidyellow'),
  main = bicycle_cols('warmred', 'mint', 'royalblue', 'lavender', 'charcoal'),
  cool = bicycle_cols('grapefruit', 'applegreen', 'majorelleblue', 'orchid', 'graphite'),
  bright = bicycle_cols('citrus', 'forestgreen', 'skyblue', 'hotpink', 'stone'),
  bold = bicycle_cols('lemon', 'lockwood', 'cyan', 'violet', 'steel'),
  reds = bicycle_cols('warmred', 'grapefruit', 'citrus', 'lemon'),
  greens = bicycle_cols('mint', 'applegreen', 'forestgreen', 'lockwood'),
  blues = bicycle_cols('royalblue', 'majorelleblue', 'skyblue', 'cyan'),
  purples = bicycle_cols('lavender', 'orchid', 'hotpink', 'violet'),
  grays = bicycle_cols('charcoal', 'graphite', 'stone', 'steel')
  all_cols = bicycle_cols()
)

## STILL NEED A PALETTE THAT HAS THEM ALL!!!!!

## function to use them ----
#' Return function to interpolate a bicycle color palette
#' @import grDevices
#' @param palette Character name of palette in bicycle_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#' @export
#' @examples bicycle_pal('bright')(2)
bicycle_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- bicycle_palettes[[palette]]
  if (reverse) pal <- rev(pal)
  grDevices::colorRampPalette(pal, ...)
}


## scale fxns ----
#' Color scale constructor for bicycle colors
#'
#' @param palette Character name of palette in bicycle_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#' @export
#' @examples
#' ggplot(mtcars, aes(wt, mpg, color = mpg)) +
#' geom_point(size = 4) + theme_bicycle() +
#'  scale_color_bicycle(palette = 'main', discrete = FALSE)
#'  ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
#' geom_point(size = 4) + theme_bicycle() +
#'   scale_color_bicycle(palette = 'main')
scale_color_bicycle <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- bicycle_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("bicycle_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for bicycle colors
#'
#' @param palette Character name of palette in bicycle_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#' @export
#' @examples ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
#' geom_bar() +
#'   theme_bicycle() +
#'   scale_fill_bicycle(palette = "grays")
scale_fill_bicycle <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- bicycle_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("bicycle_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}
