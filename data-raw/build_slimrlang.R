## code to prepare `build_slimrlang` dataset goes here

library(dplyr)

slim_lang_txtfiles <- list.files("data-raw/build/slim_reference", full.names = TRUE)

initialize_methods_index <- grep("Initialize", slim_lang_txtfiles, fixed = TRUE)
initialize_methods_txtfile <- slim_lang_txtfiles[initialize_methods_index]
slim_lang_txtfiles <- slim_lang_txtfiles[-initialize_methods_index]

slim_lang_methods_txtfiles <- grep("_methods", slim_lang_txtfiles, value = TRUE, fixed = TRUE)
slim_lang_properties_txtfiles <- grep("_properties", slim_lang_txtfiles, value = TRUE, fixed = TRUE)

slim_lang_methods_txt <- purrr::map(slim_lang_methods_txtfiles,
                                        ~readr::read_lines(.x) %>%
                                          paste(collapse = "\n")) %>%
  setNames(basename(slim_lang_methods_txtfiles))

type_legend <- dplyr::tibble(abbr = c("v", "N", "i", "f", "l", "s", "n", "+", "*"),
                             type = c("void", "null", "integer", "float", "logical", "string",
                               "numeric", "any but object", "any"))

# arg_type <- func_data$return_type
collect_types <- function(arg_type) {
  obs <- stringr::str_match(arg_type, "o(bject)?<(.*?)>")
  new_arg_types <- stringr::str_remove_all(arg_type, "o(bject)?<(.*?)>")
  types <- stringr::str_match(new_arg_types, "void|integer|float|logical|string|numeric|\\+|\\*")
  types[ , 1] <- stringr::str_sub(types[ , 1], 1, 1)
  if(any(is.na(types[ , 1]))) {
    multiple_types <- stringr::str_match_all(new_arg_types, "(v|N|i|f|l|s)")
    multiple_types <- purrr::map(multiple_types,
                                 ~.x[ , 2])
    multiple_types[!is.na(types[ , 1])] <- types[!is.na(types[ , 1]), 1]
    types <- multiple_types

  } else {
    types <- list(types[ , 1])
  }

  types <- purrr::map_chr(types,
                          ~ dplyr::tibble(abbr = .x) %>%
                            dplyr::left_join(type_legend, by = "abbr") %>%
                            dplyr::pull(type) %>%
                            paste(collapse = " or "))

  types[types == ""] <- NA

  objects <- obs[ , 3]
  objects[!is.na(objects)] <- paste(objects[!is.na(objects)], "object")
  types <- cbind(types, objects)
  types <- apply(types, 1, function(x) paste(na.omit(x), collapse = " or "))
  types
}

#txt <- initialize_txt
#txt <- slim_lang_methods_txt[1]
extract_methods <- function(txt, init = FALSE) {

  txt <- stringr::str_replace_all(txt, "\nTOC.*?\n", "\n")
  txt <- stringr::str_replace_all(txt, "\nEidos events.*?\n", "\n")
  if(init) {
    txt <- stringr::str_replace_all(txt, "\n((?!\\((void|object|integer|float|logical|string|numeric|\\*|\\+)))", " \\1")
  } else {
    txt <- stringr::str_replace_all(txt, "\n([^–+])", " \\1")
  }
  txt <- stringr::str_split(txt, "\n")[[1]]

  if(init) {
    func_data <- unglue::unglue_data(txt,
                                     "({return_type}){function_name}({arguments}){description}")
  } else {
    func_data <- unglue::unglue_data(txt,
                                     "{symbol} ({return_type}){function_name}({arguments}){description}")
  }

  #args_txt <- func_data$arguments[[1]]
  gather_args <- function(args_txt) {
    arg_df <- dplyr::tibble(args = stringr::str_split(args_txt, stringr::fixed(", "))[[1]]) %>%
      dplyr::mutate(arg_num = 1:n())
    patterns <- unglue::unglue_data(arg_df$args,
                               c("[{arg_type} {arg_name} = {arg_default}]",
                                 "{arg_type} {arg_name}",
                                 "{arg_name}"))

    if(!"arg_default" %in% colnames(patterns)) {
      patterns <- patterns %>%
        dplyr::mutate(arg_default = NA)
    }

    if(!"arg_type" %in% colnames(patterns)) {
      patterns <- patterns %>%
        dplyr::mutate(arg_type = "?")
    }

    arg_df <- arg_df %>%
      dplyr::bind_cols(patterns)

    types <- collect_types(arg_df$arg_type)

    arg_df <- arg_df %>%
      dplyr::mutate(arg_type_desc = types) %>%
      dplyr::mutate(arg_singleton = ifelse(stringr::str_detect(arg_type, "\\$"),
                                           TRUE,
                                           FALSE))

    arg_df
  }

  func_data <- func_data %>%
    dplyr::mutate(arg_data = purrr::map(arguments,
                                        ~gather_args(.x)))

  func_data <- func_data %>%
    dplyr::mutate(return_type_desc = collect_types(return_type)) %>%
    dplyr::mutate(return_singleton = ifelse(stringr::str_detect(return_type, "\\$"),
                                         TRUE,
                                         FALSE))

  func_data
}

initialize_txt <- readr::read_lines(initialize_methods_txtfile) %>%
  paste(collapse = "\n")

initialize_methods_data <- extract_methods(initialize_txt, init = TRUE)

builtin_txt <- slim_lang_methods_txt$SLiMBuiltin_methods.txt
builtin_methods_data <- extract_methods(builtin_txt, init = TRUE)

slim_lang_methods_txt <- slim_lang_methods_txt[-which(names(slim_lang_methods_txt) == "SLiMBuiltin_methods.txt")]

all_methods_data <- purrr::map(slim_lang_methods_txt,
                               ~extract_methods(.x, init = FALSE))
names(all_methods_data) <- stringr::str_remove(names(all_methods_data), "_methods.txt")

all_methods_data <- c(list(initialize_methods_data),
                      all_methods_data)

names(all_methods_data)[1] <- "Initialize"

all_methods_data <- c(all_methods_data,
                      list(builtin_methods_data))

names(all_methods_data)[length(all_methods_data)] <- "SLiMBuiltin"

#usethis::use_data(all_methods_data, overwrite = TRUE, internal = TRUE)

####### generate roxygen docs #############

func_template <- "
SLiM method <<function_name>>

Documentation for SLiM function \\code{<<function_name>>}, which is a method of the SLiM class \\code{<<class_name>>}.
Note that the R function is a stub, it does not do anything in R (except bring up this documentation). It will only do
anything useful when used inside a \\code{\\link{slim_block}} function further nested in a \\code{\\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a full SLiM script.

<<params>>

@aliases <<class_name>>$<<function_name>> <<class_abbr>>$<<function_name>>
@return An object of type <<return_type_desc>>. <<ifelse(return_singleton, 'Return will be of length 1 (a singleton)', '')>>
@details <<description>>
@section Copyright:
This is documentation for a function in the SLiM software, and has been reproduced from the official manual,
which can be found here: \\url{http://benhaller.com/slim/SLiM_Manual.pdf}. This documentation is
Copyright © 2016–2020 Philipp Messer. All rights reserved. More information about SLiM can be found
on the official website: \\url{https://messerlab.org/slim/}
@author Benjamin C Haller (\\email{bhaller@benhaller.com}) and Philipp W Messer (\\email{messer@cornell.edu})
<<ifelse(class_name %in% c('Initialize', 'SLiMBuiltin'), '@export', '')>>
#..<<function_name>> <- function(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>) {
#..  <<class_abbr>>$<<function_name>>(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>)
#..}"

method_code <- "#..<<class_name>>$<<function_name>> <- <<class_abbr>>$<<function_name>> <- function(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>) {
#..  ?<<function_name>>
#..}"

arg_roxy_template <- "
@param {arg_name} An object of type {arg_type_desc}. {ifelse(arg_singleton, 'Must be of length 1 (a singleton). ', ' ')} {ifelse(is.na(arg_default), '', paste0('The default value is \\\\code{', arg_default, '}.'))} See details for description.
"

func_table <- all_methods_data$Initialize[1,]
class_name <- "Initialize"
class_abbr <- ".Init"
template <- func_template
make_slim_function <- function(func_table, class_name, class_abbr, template) {
  params <- purrr::map_chr(purrr::transpose(func_table$arg_data[[1]]),
                           ~glue::glue_data(.x, arg_roxy_template) %>%
                             stringr::str_wrap()) %>%
    paste(collapse = "\n")


  func_txt <- glue::glue_data(c(func_table, list(class_name = class_name,
                                                 class_abbr = class_abbr)),
                              template, .open = "<<", .close = ">>")

  func_txt <- func_txt %>%
    stringr::str_split("\n") %>%
    purrr::map(~stringr::str_wrap(.x) %>%
                 stringr::str_split("\n") %>%
                 unlist() %>%
                 paste0("#'", .)) %>%
    unlist()

  func_section <- stringr::str_which(func_txt, stringr::fixed("#'#..")) %>%
    range()

  func_txt[func_section[1]:func_section[2]] <- func_txt[func_section[1]:func_section[2]] %>%
    stringr::str_remove_all("(#'#..|#')")

  func_txt <- func_txt %>%
    paste(collapse = "\n")

  func_txt


}

make_slim_function(func_table, class_name, class_abbr, template = func_template) %>%
  cat()

make_slim_function(func_table, class_name, class_abbr, template = method_code) %>%
  cat()

class_abbrs <- tibble::tribble(~class_name, ~class_abbr,
                               "Initialize", ".Init",
                               "Chromosome", ".c",
                               "Genome", ".G",
                               "GenomicElement", ".GE",
                               "GenomicElementType", ".GET",
                               "Individual", ".I",
                               "InteractionType", ".IT",
                               "Mutation", ".M",
                               "MutationType", ".MT",
                               "SLiMBuiltin", ".SB",
                               "SLiMEidosBlock", ".SEB",
                               "SLiMSim", ".SS",
                               "Subpopulation", ".P",
                               "Substitution", ".S")

method_make_df <- dplyr::tibble(class_name = names(all_methods_data)) %>%
  dplyr::left_join(class_abbrs)

method_table <- all_methods_data[[1]]
make_class_funcs <- function(method_table, class_name, class_abbr, template) {
  methods_list <- purrr::map(seq_len(nrow(method_table)),
                             ~method_table[.x, ])

  methods_txt <- purrr::map_chr(methods_list,
                                ~make_slim_function(.x,
                                                    class_name,
                                                    class_abbr,
                                                    template))
  paste(methods_txt, collapse = "\n\n")
}

all_methods_txt <- purrr::pmap_chr(list(all_methods_data,
                                   method_make_df$class_name,
                                   method_make_df$class_abbr),
                                   ~make_class_funcs(..1, ..2, ..3,
                                                     func_template)) %>%
  paste(collapse = "\n\n\n\n")

all_methods_code <- purrr::pmap_chr(list(all_methods_data,
                                         method_make_df$class_name,
                                         method_make_df$class_abbr),
                                    ~make_class_funcs(..1, ..2, ..3,
                                                      method_code)) %>%
  paste(collapse = "\n\n\n\n")

## fix issue with assignment operator wrapping
all_methods_code <- stringr::str_replace_all(all_methods_code,
                                             "\n\\<\\-",
                                             " <-")

all_methods_code <- stringr::str_replace_all(all_methods_code,
                                             "\n\\$",
                                             "$")

######### deal with properties ##############

slim_lang_properties_txt <- purrr::map(slim_lang_properties_txtfiles,
                                    ~readr::read_lines(.x) %>%
                                      paste(collapse = "\n")) %>%
  setNames(basename(slim_lang_properties_txtfiles))

# txt <- slim_lang_properties_txt[[1]]
extract_properties <- function(txt) {
  txt <- stringr::str_replace_all(txt, "\nTOC.*?\n", "\n")
  txt <- stringr::str_replace_all(txt, "\nEidos events.*?\n", "\n")
  txt <- stringr::str_split(txt, "\n")[[1]]
  props <- stringr::str_which(txt,
                      "(.*?) (\\<\\–\\>|\\=\\>) \\((.*?)\\)",
                      negate = FALSE)

  txt[props] <- paste0("\n", txt[props])
  txt <- paste(txt, collapse = " ")
  txt <- stringr::str_split(txt, "\n")[[1]]

  prop_dat <- unglue::unglue_data(txt,
                                  "{property} {symbol} ({property_type}){description}") %>%
    tidyr::drop_na() %>%
    dplyr::mutate(property_type_desc = collect_types(property_type)) %>%
    dplyr::mutate(property_singleton = ifelse(stringr::str_detect(property_type, "\\$"),
                                            TRUE,
                                            FALSE),
                  modifiable = ifelse(symbol == "<–>",
                                      "a variable, so it is modifiable",
                                      "a constant, so it is not modifiable"))

  prop_dat

}

all_properties_data <- purrr::map(slim_lang_properties_txt,
                               ~extract_properties(.x))
names(all_properties_data) <- stringr::str_remove(names(all_properties_data), "_properties.txt")

properties_create <- "
{class_name}${property} <- {class_abbr}${property} <- '{property}'"

property_make_df <- dplyr::tibble(class_name = names(all_properties_data)) %>%
  dplyr::left_join(class_abbrs)

# property_table <- all_properties_data[[1]]
create_properties <- function(property_table, class_name, class_abbr) {
  purrr::map_chr(purrr::transpose(property_table %>%
                     dplyr::select(property)),
                 ~glue::glue_data(.x,
                                  properties_create)) %>%
    paste(collapse = "\n")
}

property_txt <- purrr::pmap_chr(list(all_properties_data,
                                property_make_df$class_name,
                                property_make_df$class_abbr),
                                ~create_properties(..1, ..2, ..3)) %>%
  paste(collapse = "\n")

############ make documentation for all SLiM classes ##########

function_names <- purrr::map(all_methods_data,
                             ~.x %>%
                               dplyr::pull(function_name)) %>%
  dplyr::tibble(class_name = names(all_methods_data),
                function_name = .)

all_class_data <- class_abbrs %>%
  dplyr::left_join(function_names) %>%
  dplyr::left_join(dplyr::tibble(class_name = names(all_properties_data),
                                 properties_data = all_properties_data))

property_roxy <- "\\item{<<property>>}{A property of type <<property_type_desc>>. <<ifelse(property_singleton, 'It is of length one (a singleton).', '')>> This property is <<modifiable>>. \\strong{Property Description:} <<description>>}"

property_table <- all_properties_data$Chromosome
make_property_roxy <- function(property_table) {
  purrr::map_chr(purrr::transpose(property_table),
                 ~glue::glue_data(.x, property_roxy,
                                  .open = "<<",
                                  .close = ">>")) %>%
    paste("\n")
}

make_property_roxy(property_table) %>%
  cat()

function_name <- all_class_data$function_name[[1]]
paste0('\\item{\\code{\\link{', function_name, '}}}') %>%
  paste(collapse = "\n") %>%
  cat()

class_roxy <- "
<<class_name>>

Documentation for <<class_name>> class from SLiM

@aliases <<class_abbr>>
@details This class has the following methods (functions):
\\itemize{
<<ifelse(function_name[[1]][1] != 'None', paste0('\\\\item{\\\\code{\\\\link{', function_name[[1]], '}}}') %>% paste(collapse = '\n'), '\\\\item{None. This class has no methods.}')>>
}
This class has the following properties:
\\describe{
<<property_list>>
}
#..'<<class_name>>'"

class_table <- purrr::map(seq_len(nrow(all_class_data)),
                          ~all_class_data[.x, ])[[1]]
make_class_roxy <- function(class_table) {
  #print(class_table$class_name)
  if(is.null(class_table$properties_data[[1]])) {
    property_list <- list("\\item{None.}{This class has no properties.}")
  } else {
    property_list <- make_property_roxy(class_table$properties_data[[1]]) %>%
      paste(collapse = "")
  }
  if(is.null(class_table$function_name[[1]])) {
    class_table$function_name <- list("None")
  }
  class_txt <- glue::glue_data(class_table, class_roxy,
                  .open = "<<",
                  .close = ">>") %>%
    stringr::str_split("\n") %>%
    unlist() %>%
    purrr::map_chr(~stringr::str_wrap(.x)) %>%
    paste(collapse = "\n") %>%
    stringr::str_split("\n") %>%
    unlist()
  class_txt <- paste0("#'", class_txt) %>%
    paste(collapse = "\n")
  class_txt
}

class_roxies <- purrr::map(seq_len(nrow(all_class_data)),
                           ~all_class_data[.x, ]) %>%
  purrr::map_chr(~make_class_roxy(.x)) %>%
  paste(collapse = "\n") %>%
  stringr::str_remove_all("#'#\\.\\.")

########## lastly, make the class object code ###########

class_create <- "{class_name} <- {class_abbr} <- list()"
class_make_code <- purrr::transpose(class_abbrs) %>%
  purrr::map_chr(~glue::glue_data(.x, class_create)) %>%
  paste(collapse = "\n")

cat(class_make_code)


######## put it all together ###########

temp_source <- tempfile(fileext = ".R")
readr::write_lines(class_make_code, temp_source)
source(temp_source)
readr::write_lines(all_methods_code, temp_source)
source(temp_source)
readr::write_lines(property_txt, temp_source)
source(temp_source)

r_script <- paste(
  all_methods_txt,
  class_roxies,
  sep = "\n\n\n\n\n\n\n\n"
)

## fix up random weirdnesses

r_script <- stringr::str_replace_all(r_script,
                                     "“",
                                     '"')

readr::write_lines(r_script, "R/slim_lang.R")

slim_classes <- class_abbrs

usethis::use_data(Initialize,
                  Chromosome,
                  Genome,
                  GenomicElement,
                  GenomicElementType,
                  Individual,
                  InteractionType,
                  Mutation,
                  MutationType,
                  SLiMBuiltin,
                  SLiMEidosBlock,
                  SLiMSim,
                  Subpopulation,
                  Substitution,
                  .Init,
                  .c,
                  .G,
                  .GE,
                  .GET,
                  .I,
                  .IT,
                  .M,
                  .MT,
                  .SB,
                  .SEB,
                  .SS,
                  .P,
                  .S,
                  slim_classes,
                  overwrite = TRUE
)

## fix bad filenames

bad_files <- list.files("data", all.files = TRUE, pattern = "^\\.", no.. = TRUE)

file.rename(file.path("data", bad_files), file.path("data", stringr::str_remove(bad_files, "^\\.")))

