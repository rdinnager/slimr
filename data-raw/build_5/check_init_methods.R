all_methods <- readRDS('data-raw/build_5/all_methods_data.rds')
init_methods <- all_methods[['Initialize']]

cat('Initialize method count:', nrow(init_methods), '\n\n')
cat('All Initialize methods:\n')
print(init_methods$function_name)

cat('\n\nMethods starting with "initialize":\n')
init_prefix <- init_methods[grepl('^initialize', init_methods$function_name),]
cat('Count:', nrow(init_prefix), '\n')
print(init_prefix$function_name)

cat('\n\nMethods NOT starting with "initialize" (should be SLiMBuiltin):\n')
builtin <- init_methods[!grepl('^initialize', init_methods$function_name),]
cat('Count:', nrow(builtin), '\n')
if(nrow(builtin) > 0) {
  print(builtin$function_name)
}
