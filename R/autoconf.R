#' Use Autoconf
#'
#' Creates an example `configure.ac` file that can be used to configure how a
#' package is built by R during installation. This is primarily useful when you
#' are writing a package that uses some system C or C++ libraries, and want to
#' detect the presence of these libraries during installation.
#'
#' @details
#'
#' This function also sets up various other `autoconf`-releated files, namely by
#' generating a `cleanup` script and a `src/Makevars.in` file. It will also
#' create a git commit hook (if git appears to be used by the package) and add
#' various files to the ignore files.
#'
#' You may want to consult R's [documentation](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Configure-example)
#' on configure scripts for additional examples.
#'
#' @inheritParams use_template
#' @export
#' @examples
#' \dontrun{
#' use_autoconf()
#' }
use_autoconf <- function(open = interactive()) {
  check_is_package("use_autoconf()")

  if (uses_git()) {
    use_git_ignore(c("autom4te.cache/", "config.log", "config.status",
                     "src/Makevars"))
    use_git_hook("pre-commit", render_template("autoconf-pre-commit.sh"))
  }

  # Create a Makevars.in or migrate an existing Makevars.
  use_directory("src")
  makevars_path <- proj_path("src/Makevars")
  if (file.exists(makevars_path)) {
    file.rename(makevars_path, proj_path("src/Makevars.in"))
    done("Moving", value("src/Makevars"), "to", value("src/Makevars.in"))
  } else {
    use_template("Makevars.in", save_as = "src/Makevars.in",
                 data = package_data(), open = FALSE)
  }
  use_build_ignore("src/Makevars")

  # Create a cleanup/configure scripts.
  use_template("cleanup", data = package_data(), open = FALSE)
  use_template("configure.ac", data = package_data(), open = open)

  todo("Run", value("autoconf"), "to generate the configure script from",
       value("configure.ac"))
}

uses_autoconf <- function() {
  file.exists(proj_path("configure.ac"))
}
