-- ===== init.lua (fixed) =====
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- PATH
vim.env.PATH = vim.fn.expand "~/.local/bin" .. ":" .. vim.env.PATH
-- Bootstrap lazy.nvim（一定要先做再 require("lazy")）
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true
-- filetype 延伸
vim.filetype.add {
  extension = { mdx = "markdown" },
}

-- 讀 lazy 設定（沒有就用空表，避免噴錯）
local ok, lazy_config = pcall(require, "configs.lazy")
if not ok then
  lazy_config = {}
end

-- Plugins：用 spec 形式，並保留 NvChad + 你的 plugins
require("lazy").setup({
  spec = {
    { "NvChad/NvChad", lazy = false, branch = "v2.5", import = "nvchad.plugins" },
    { import = "plugins" },
  },
}, lazy_config)

-- NvChad base46 快取（沒有也不會報錯）
pcall(dofile, vim.g.base46_cache .. "defaults")
pcall(dofile, vim.g.base46_cache .. "statusline")

-- 其餘載入
require "options"
require "nvchad.autocmds"

-- LeetCode（包一層 pcall，沒裝也不會炸）
pcall(function()
  require("leetcode").setup {
    lang = "cpp",
    storage = { home = vim.fn.expand "$HOME" .. "/.leetcode" },
  }
end)

require "faster"

-- mappings
vim.schedule(function()
  require "mappings"
end)

require("cmp").setup({enabled = false})

-- mdx → markdown
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})

