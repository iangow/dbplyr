% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/verb-pivot-longer.R
\name{pivot_longer.tbl_lazy}
\alias{pivot_longer.tbl_lazy}
\title{Pivot data from wide to long}
\usage{
pivot_longer.tbl_lazy(
  data,
  cols,
  names_to = "name",
  names_prefix = NULL,
  names_sep = NULL,
  names_pattern = NULL,
  names_ptypes = NULL,
  names_transform = NULL,
  names_repair = "check_unique",
  values_to = "value",
  values_drop_na = FALSE,
  values_ptypes,
  values_transform = NULL,
  ...
)
}
\arguments{
\item{data}{A data frame to pivot.}

\item{cols}{Columns to pivot into longer format.}

\item{names_to}{A string specifying the name of the column to create
from the data stored in the column names of \code{data}.}

\item{names_prefix}{A regular expression used to remove matching text
from the start of each variable name.}

\item{names_sep, names_pattern}{If \code{names_to} contains multiple values,
these arguments control how the column name is broken up.}

\item{names_ptypes}{A list of column name-prototype pairs.}

\item{names_transform, values_transform}{A list of column name-function pairs.}

\item{names_repair}{What happens if the output has invalid column names?}

\item{values_to}{A string specifying the name of the column to create
from the data stored in cell values. If \code{names_to} is a character
containing the special \code{.value} sentinel, this value will be ignored,
and the name of the value column will be derived from part of the
existing column names.}

\item{values_drop_na}{If \code{TRUE}, will drop rows that contain only \code{NA}s
in the \code{value_to} column.}

\item{values_ptypes}{Not supported.}

\item{...}{Additional arguments passed on to methods.}
}
\description{
\code{pivot_longer()} "lengthens" data, increasing the number of rows and
decreasing the number of columns. The inverse transformation is
`tidyr::pivot_wider()]

Learn more in \code{vignette("pivot", "tidyr")}.

While most functionality is identical there are some differences to
\code{pivot_longer()} on local data frames:
\itemize{
\item the output is sorted differently/not explicitly,
\item the coercion of mixed column types is left to the database,
\item \code{values_ptypes} NOT supported.
}

Note that \code{build_longer_spec()} and \code{pivot_longer_spec()} do not work with
remote tables.
}
\details{
The SQL translation basically works as follows:
\enumerate{
\item split the specification by its key columns i.e. by variables crammed
into the column names.
\item for each part in the splitted specification \code{transmute()} \code{data} into the
following columns
}
\itemize{
\item id columns i.e. columns that are not pivotted
\item key columns
\item value columns i.e. columns that are pivotted
}
\enumerate{
\item combine all the parts with \code{union_all()}
}
}
\examples{
\dontshow{if (rlang::is_installed("tidyr", version = "1.0.0")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# See vignette("pivot") for examples and explanation

# Simplest case where column names are character data
memdb_frame(
  id = c("a", "b"),
  x = 1:2,
  y = 3:4
) \%>\%
  tidyr::pivot_longer(-id)
\dontshow{\}) # examplesIf}
}
