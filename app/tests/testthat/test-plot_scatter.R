test_that("Check plot_scatter function works as expected", {
  result <- plot_scatter()
  expect_true(is.null(result))
})

test_that("{shinytest2} recording: e2e_plot_scatter", {
  app <- shinytest2::AppDriver$new(app_dir = system.file("shiny", package = "SSdemo"), name = "e2e_plot_scatter")
  app$set_inputs(tabs = "plot")
  app$set_inputs(plotSel = "plot_scatter")
  app$click("plot_scatter-run")
  common <- app$get_value(export = "common")
  expect_true(is.null(common$scatter))
})

