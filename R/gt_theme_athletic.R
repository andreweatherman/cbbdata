#' The Athletic `gt` Table Theme
#'
#' A theme for styling `gt` tables similar to The Athletic.
#'
#' @returns Returns data with an appended HTML column.
#' @param gt_object An existing gt table object of class `gt_tbl`
#' @param ... Optional additional arguments to `gt::table_options()`
#' @import gt
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{try(mtcars %>% head() %>% gt::gt() %>% cbbdata::gt_theme_athletic())}
#'
#' @export
gt_theme_athletic <- function(gt_object, ...) {

  stopifnot(`'gt_object' must be a 'gt_tbl', have you accidentally passed raw data?` = "gt_tbl" %in%
              class(gt_object))

  table_id <- subset(gt_object[['_options']], parameter == 'table_id')$value[[1]]

  if (is.na(table_id)) {
    table_id <- gt::random_id()
    opt_position <- which("table_id" %in% gt_object[["_options"]][["parameter"]])[[1]]
    gt_object[["_options"]][["value"]][[opt_position]] <- table_id
  }

  table <- gt_object %>%
    gt::opt_table_font(
      font = list(
        gt::google_font('Spline Sans Mono'),
        gt::default_fonts()
      ),
      weight = 500
    ) %>%
    gt::tab_style(
      locations = gt::cells_column_labels(
        columns = gt::everything()
      ),
      style = gt::cell_text(
        font = gt::google_font('Work Sans'),
        weight = 650,
        size = px(12),
        transform = 'uppercase'
      )
    ) %>%
    gt::tab_style(
      locations = gt::cells_title('title'),
      style = gt::cell_text(
        font = gt::google_font('Work Sans'),
        weight = 650
      )
    ) %>%
    gt::tab_style(
      locations = gt::cells_title('subtitle'),
      style = gt::cell_text(
        font = gt::google_font('Work Sans'),
        weight = 500
      )
    ) %>%
    gt::tab_style(
      style = gt::cell_borders(sides = 'left', weight = px(0.5), color = 'black'),
      locations = gt::cells_body(
        columns = c(-names(gt_object[['_data']])[1])
      )
    ) %>%
    gt::tab_style(
      style = gt::cell_borders(sides = "top", color = 'black', weight = px(1.5), style = 'dotted'),
      locations = gt::cells_body(
        rows = gt::everything()
      )
    ) %>%
    gt::cols_align(
      align = 'center',
      columns = gt::everything()
    ) %>%
    gt::tab_options(
      table.font.size = 12,
      column_labels.border.bottom.width = 2,
      column_labels.border.bottom.color = 'black',
      column_labels.border.top.color = 'white',
      row_group.border.bottom.color = 'white',
      table.border.top.style = 'none',
      table.border.bottom.style = 'none',
      heading.border.bottom.style = 'none',
      heading.align = 'left',
      heading.title.font.size = px(26),
      source_notes.border.lr.style = 'none',
      source_notes.font.size = 10,
      ...
    ) %>%
    gt::opt_css(
      paste0("#", table_id, " tbody tr:last-child {border-bottom: 2px solid #ffffff00;}"),
      add = TRUE
    )

  return(table)

}
