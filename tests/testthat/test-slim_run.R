# test_that("simulated slimr_output is parsed correctly", {
#
#   set.seed(12345)
#
#   lines_per_iter <- c(1, 100)
#   out_list <- list()
#   i <- 0L
#
#   to_process <- list()
#   outs <- list()
#   leftovers <- character(0)
#
#   out <- slim_basic_sim(runif(1, lines_per_iter[1], lines_per_iter[2]))
#   while(out[[1]] != "finished") {
#     i <- i + 1L
#     to_process[[i]] <- c(leftovers, out)
#     outs[[i]] <- out
#     out_list[[i]] <- slim_process_output(c(leftovers, out))
#     leftovers <- out_list[[i]]$leftovers
#     out <- slim_basic_sim(floor(runif(1, lines_per_iter[1], lines_per_iter[2])))
#   }
#
#   out_list[[i + 1L]] <- slim_process_output(leftovers)
#
#   out_tr <- purrr::transpose(out_list)
#   out_df <- dplyr::bind_rows(out_tr$data)
#
#   extra_out <- out_tr$extra_out %>%
#     purrr::flatten_chr()
#
#   expect_true(all(1:80 %in% out_df$generation))
#   expect_identical(extra_out[1:12], c("// Initial random seed:",
#                                       "1593628773993",
#                                       "",
#                                       "// RunInitializeCallbacks():",
#                                       "initializeMutationRate(1e-07);",
#                                       "initializeMutationType(1, 0.5, \"f\", 0);",
#                                       "initializeGenomicElementType(1, m1, 1);",
#                                       "initializeGenomicElement(g1, 0, 99999);",
#                                       "initializeRecombinationRate(1e-08);",
#                                       "",
#                                       "// Starting run at generation <start>:",
#                                       "1"))
#
#   expect_true(all(extra_out[13:length(extra_out)] %in%
#                     c("", "Another successful round of evolution completed!")))
#
# })
