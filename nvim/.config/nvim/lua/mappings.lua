require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>e",function()
  require("snacks").explorer()
end, {desc = "open file explorer "})
map('n', '<leader>v',
    ":lua if vim.fn.match(vim.fn.expand('%:e'), 'mp4\\|mkv\\|avi\\|mov') >= 0 then vim.fn.system('mpv ' .. vim.fn.expand('%:p') .. ' &') else print('Not a video file') end<CR>",
    { noremap = true, silent = true }
)

map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
