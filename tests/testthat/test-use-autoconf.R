context("use-autoconf.R")

test_that("use_autoconf() requires a package", {
  scoped_temporary_project()
  expect_error(use_autoconf(), "not an R package")
})

test_that("use_autoconf() creates files/dirs and edits .gitignore", {
  pkg <- scoped_temporary_package()
  capture_output(use_autoconf())

  expect_true(dir.exists(proj_path("src")))
  expect_true(file.exists(proj_path("configure.ac")))
  expect_true(file.exists(proj_path("cleanup")))
  expect_true(file.exists(proj_path("src/Makevars.in")))

  ignores <- readLines(proj_path("src", ".gitignore"))
  expect_true(all(c("autom4te.cache/", "config.log", "config.status",
                    "src/Makevars") %in% ignores))
})
