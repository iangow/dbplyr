% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db-sql.R
\name{db-sql}
\alias{db-sql}
\alias{sql_expr_matches}
\alias{sql_translation}
\alias{sql_random}
\alias{sql_table_analyze}
\alias{sql_table_index}
\alias{sql_query_explain}
\alias{sql_query_fields}
\alias{sql_query_save}
\alias{sql_query_wrap}
\alias{sql_indent_subquery}
\alias{sql_query_rows}
\alias{supports_window_clause}
\alias{supports_star_without_alias}
\alias{sql_query_select}
\alias{sql_query_join}
\alias{sql_query_semi_join}
\alias{sql_query_set_op}
\alias{sql_returning_cols}
\title{SQL generation generics}
\usage{
sql_expr_matches(con, x, y)

sql_translation(con)

sql_random(con)

sql_table_analyze(con, table, ...)

sql_table_index(con, table, columns, name = NULL, unique = FALSE, ...)

sql_query_explain(con, sql, ...)

sql_query_fields(con, sql, ...)

sql_query_save(con, sql, name, temporary = TRUE, ...)

sql_query_wrap(con, from, name = NULL, ..., lvl = 0)

sql_indent_subquery(from, con, lvl = 0)

sql_query_rows(con, sql, ...)

supports_window_clause(con)

supports_star_without_alias(con)

sql_query_select(
  con,
  select,
  from,
  where = NULL,
  group_by = NULL,
  having = NULL,
  window = NULL,
  order_by = NULL,
  limit = NULL,
  distinct = FALSE,
  ...,
  subquery = FALSE,
  lvl = 0
)

sql_query_join(
  con,
  x,
  y,
  vars,
  type = "inner",
  by = NULL,
  na_matches = FALSE,
  ...,
  lvl = 0
)

sql_query_semi_join(con, x, y, anti = FALSE, by = NULL, ..., lvl = 0)

sql_query_set_op(con, x, y, method, ..., all = FALSE, lvl = 0)

sql_returning_cols(con, cols, table, ...)
}
\description{
SQL translation:
\itemize{
\item \code{sql_expr_matches(con, x, y)} generates an alternative to \code{x = y} when a
pair of \code{NULL}s should match. The default translation uses a \verb{CASE WHEN}
as described in \url{https://modern-sql.com/feature/is-distinct-from}.
\item \code{sql_translation(con)} generates a SQL translation environment.
\item \code{sql_random(con)} generates SQL to get a random number which can be used
to select random rows in \code{slice_sample()}.
\item \code{supports_window_clause(con)} does the backend support named windows?
\item \code{supports_star_without_alias(con)} does the backend support using \code{*}
in a \code{SELECT} query without prefixing by a table alias?
}

Tables:
\itemize{
\item \code{sql_table_analyze(con, table)} generates SQL that "analyzes" the table,
ensuring that the database has up-to-date statistics for use in the query
planner. It called from \code{\link[=copy_to]{copy_to()}} when \code{analyze = TRUE}.
\item \code{sql_table_index()} generates SQL for adding an index to table. The
}

Query manipulation:
\itemize{
\item \code{sql_query_explain(con, sql)} generates SQL that "explains" a query,
i.e. generates a query plan describing what indexes etc that the
database will use.
\item \code{sql_query_fields()} generates SQL for a 0-row result that is used to
capture field names in \code{\link[=tbl_sql]{tbl_sql()}}
\item \code{sql_query_save(con, sql)} generates SQL for saving a query into a
(temporary) table.
\item \code{sql_query_wrap(con, from)} generates SQL for wrapping a query into a
subquery.
}

Query indentation:
\itemize{
\item \code{sql_indent_subquery(from, con, lvl)} helps indenting a subquery.
}

Query generation:
\itemize{
\item \code{sql_query_select()} generates SQL for a \code{SELECT} query
\item \code{sql_query_join()} generates SQL for joins
\item \code{sql_query_semi_join()} generates SQL for semi- and anti-joins
\item \code{sql_query_set_op()} generates SQL for \code{UNION}, \code{INTERSECT}, and \code{EXCEPT}
queries.
}

Query generation for manipulation:
\itemize{
\item \code{sql_query_insert()} and \code{sql_query_append()} generate SQL for an \verb{INSERT FROM} query.
\item \code{sql_query_update_from()} generates SQL for an \verb{UPDATE FROM} query.
\item \code{sql_query_upsert()} generates SQL for an \code{UPSERT} query.
\item \code{sql_query_delete()} generates SQL for an \verb{DELETE FROM} query
\item \code{sql_returning_cols()} generates SQL for a \code{RETURNING} clause
}
}
\section{dbplyr 2.0.0}{


Many \verb{dplyr::db_*} generics have been replaced by \verb{dbplyr::sql_*} generics.
To update your backend, you'll need to extract the SQL generation out of your
existing code, and place it in a new method for a dbplyr \code{sql_} generic.
\itemize{
\item \code{dplyr::db_analyze()} is replaced by \code{dbplyr::sql_table_analyze()}
\item \code{dplyr::db_explain()} is replaced by \code{dbplyr::sql_query_explain()}
\item \code{dplyr::db_create_index()} is replaced by \code{dbplyr::sql_table_index()}
\item \code{dplyr::db_query_fields()} is replaced by \code{dbplyr::sql_query_fields()}
\item \code{dplyr::db_query_rows()} is no longer used; you can delete it
\item \code{dplyr::db_save_query()} is replaced by \code{dbplyr::sql_query_save()}
}

The query generating functions have also changed names. Their behaviour is
unchanged, so you just need to rename the generic and import from dbplyr
instead of dplyr.
\itemize{
\item \code{dplyr::sql_select()} is replaced by \code{dbplyr::sql_query_select()}
\item \code{dplyr::sql_join()} is replaced by \code{dbplyr::sql_query_join()}
\item \code{dplyr::sql_semi_join()} is replaced by \code{dbplyr::sql_query_semi_join()}
\item \code{dplyr::sql_set_op()} is replaced by \code{dbplyr::sql_query_set_op()}
\item \code{dplyr::sql_subquery()} is replaced by \code{dbplyr::sql_query_wrap()}
}

Learn more in \code{vignette("backend-2.0")}
}

\seealso{
Other generic: 
\code{\link{db_connection_describe}()},
\code{\link{db_copy_to}()},
\code{\link{sql_escape_logical}()}
}
\concept{generic}
\keyword{internal}
