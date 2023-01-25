local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.autopep8,
    formatting.google_java_format,
    formatting.format_r.with({ args = require("null-ls.helpers").range_formatting_args_factory({
      "--slave",
      "--no-restore",
      "--no-save",
      "-e",
      'formatR::tidy_source(source="stdin", indent = getOption("formatR.indent", 2))',
    }, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
    }),
    -- diagnostics.flake8
  },
})
