test_that("Check select_async function works as expected", {
  result <- select_async()
  expect_true(is.null(result))
})

test_that("{shinytest2} recording: e2e_select_async", {
  app <- shinytest2::AppDriver$new(app_dir = system.file("shiny", package = "SSdemo"), name = "e2e_select_async")
  app$set_inputs(tabs = "select")
  app$set_inputs(selectSel = "select_async")
  app$click("select_async-run")
  common <- app$get_value(export = "common")
  expect_true(is.null(common$scatter))
})

