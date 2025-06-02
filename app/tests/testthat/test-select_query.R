test_that("Check select_query function works as expected", {
  result <- select_query()
  expect_true(is.null(result))
})

test_that("{shinytest2} recording: e2e_select_query", {
  app <- shinytest2::AppDriver$new(app_dir = system.file("shiny", package = "SSdemo"), name = "e2e_select_query")
  app$set_inputs(tabs = "select")
  app$set_inputs(selectSel = "select_query")
  app$click("select_query-run")
  common <- app$get_value(export = "common")
  expect_true(is.null(common$scatter))
})

