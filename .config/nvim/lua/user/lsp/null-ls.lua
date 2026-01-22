local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

local h = require("null-ls.helpers")
local styler = h.make_builtin({
    name = "format_r",
    meta = {
        url = "https://github.com/yihui/formatR",
        description = "Format R code automatically.",
    },
    method = { "NULL_LS_FORMATTING", "NULL_LS_RANGE_FORMATTING" },
    filetypes = { "r", "rmd" },
    generator_opts = {
        command = "Rscript",
        args = h.range_formatting_args_factory({
        "--slave",
        "--no-restore",
        "--no-save",
        "-e",
        [[args <- commandArgs(trailingOnly = TRUE)
        input <- readLines(file("stdin"))
        if (length(args) == 4) {
          start <- as.integer(args[2])
          end <- as.integer(args[4])
          indent <- regmatches(input[start],regexpr("^ +",input[start])) |> nchar()
          if (length(indent) == 0) {
            indent <- 0
          }
          styled <- styler::style_text(text = input[start:end], base_indention = indent)
          if (start > 1) {
            styled <- c(input[1:(start - 1)], styled)
          }
          if (end < length(input)) {
            styled <- c(styled, input[(end + 1):length(input)])
          }
            styler:::construct_vertical(styled)
        } else {
          styler::style_text(text = input)
        }]],
      }, "", "", {  use_rows = true }),
        to_stdin = true,
    },
    factory = h.formatter_factory,
})

null_ls.setup({
  debug = false,
  sources = {
    formatting.google_java_format,
    -- formatting.clang_format,
    styler,
  },
})
