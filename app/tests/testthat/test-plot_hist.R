test_that("Check plot_hist function works as expected", {
  result <- plot_hist()
  expect_true(is.null(result))
})

test_that("{shinytest2} recording: e2e_plot_hist", {
  app <- shinytest2::AppDriver$new(app_dir = system.file("shiny", package = "SSdemo"), name = "e2e_plot_hist")
  app$set_inputs(tabs = "plot")
  app$set_inputs(plotSel = "plot_hist")
  app$click("plot_hist-run")
  common <- app$get_value(export = "common")
  expect_true(is.null(common$scatter))
})

