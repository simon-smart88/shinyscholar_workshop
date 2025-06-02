test_that("Check transform_filter function works as expected", {
  result <- transform_filter()
  expect_true(is.null(result))
})

test_that("{shinytest2} recording: e2e_transform_filter", {
  app <- shinytest2::AppDriver$new(app_dir = system.file("shiny", package = "SSdemo"), name = "e2e_transform_filter")
  app$set_inputs(tabs = "transform")
  app$set_inputs(transformSel = "transform_filter")
  app$click("transform_filter-run")
  common <- app$get_value(export = "common")
  expect_true(is.null(common$scatter))
})

