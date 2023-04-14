# function to get user parameters as a list for `httr`
get_args <- function(...) {

  args <- rlang::list2(...)

  return(args)

}
