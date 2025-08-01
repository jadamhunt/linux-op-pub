local map = vim.keymap.set
map("n", "<leader>t", function()
  Snacks.terminal(nil, { win = { position = "float" } })
end)
