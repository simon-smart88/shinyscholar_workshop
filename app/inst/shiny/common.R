  common_class <- R6::R6Class(
    classname = "common",
    public = list(raster = NULL,
 histogram = NULL,
 scatter = NULL,
 meta = NULL,
 logger = NULL,
 state = NULL,
 poly = NULL,
 tasks = list(),
 reset = function(){
self$raster <- NULL
 self$histogram <- NULL
 self$scatter <- NULL
 self$meta <- NULL
 self$state <- NULL
 self$poly <- NULL
 invisible(self)})
  )

