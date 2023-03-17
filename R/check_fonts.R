#' Install Bicycle font if needed
#' @import extrafont
#' @import systemfonts
#' @return Nothing
#' @export
#'
#' @examples check_fonts()
check_fonts <- function() {
  extrafont::loadfonts()
  font_set <- systemfonts::system_fonts()
  if (!'New Grotesk' %in% font_set$family) {
    font_import('Font_files/TTF/New Grotesk/')
    extrafont::loadfonts()
  }
}
