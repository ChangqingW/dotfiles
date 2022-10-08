local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    close_command = "BufDel",
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    tab_size = 18,
    truncate_names = false,
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true
      }
    }
  }
}
