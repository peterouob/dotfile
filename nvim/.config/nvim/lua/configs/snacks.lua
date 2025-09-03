---@diagnostic disable: missing-fields
require("snacks").setup {
    picker = {
    matcher = { frecency = true, cwd_bonus = true, history_bonus = true },
    formatters = { icon_width = 3 },
    win = { input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } } },

 sources = {
      explorer = { hidden = true, ignored = false, follow = true },
      files    = { hidden = true, ignored = false, follow = true },
      grep     = { hidden = true, ignored = false },
    },
  },

  explorer = {
    enabled = true,
  },
  notifier = { enabled = false },
  scroll = { enabled = true },
  words = { enabled = true },
  dashboard = {
    enabled = true,
    width = 60,
    row = nil, -- dashboard position. nil for center
    col = nil, -- dashboard position. nil for center
    pane_gap = 4, -- empty columns between vertical panes
    autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
    -- These settings are used by some built-in sections
    preset = {
      -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
      ---@type fun(cmd:string, opts:table)|nil
      pick = nil,
      -- Used by the `keys` section to show keymaps.
      -- Set your custom keymaps here.
      -- When using a function, the `items` argument are the default keymaps.
      ---@type snacks.dashboard.Item[]
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      -- Used by the `header` section
      header = [[
██████╗ ███████╗████████╗███████╗██████╗ 
██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗
██████╔╝█████╗     ██║   █████╗  ██████╔╝
██╔══   ██╔══╝     ██║   ██╔══╝  ██╔══██╗
██║     ███████╗   ██║   ███████╗██║  ██║
╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
]],
    },
    -- item field formatters
    formats = {
      icon = function(item)
        if item.file and item.icon == "file" or item.icon == "directory" then
          return M.icon(item.file, item.icon)
        end
        return { item.icon, width = 2, hl = "icon" }
      end,
      footer = { "%s", align = "center" },
      header = { "%s", align = "center" },
      file = function(item, ctx)
        local fname = vim.fn.fnamemodify(item.file, ":~")
        fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
        if #fname > ctx.width then
          local dir = vim.fn.fnamemodify(fname, ":h")
          local file = vim.fn.fnamemodify(fname, ":t")
          if dir and file then
            file = file:sub(-(ctx.width - #dir - 2))
            fname = dir .. "/…" .. file
          end
        end
        local dir, file = fname:match "^(.*)/(.+)$"
        return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
      end,
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "startup" },
    },
  },
  image = {
    enabled = true,
    doc = { enabled = true, inline = false, float = true, max_width = 80, max_height = 20 },
    -- resolve = function(_, src)
    --   local vault_path = vim.fn.expand '~' .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault'
    --
    --   -- when the file path is *attachments/*
    --   local att_path = src:match '(attachments/.*)'
    --   if att_path then
    --     return vault_path .. '/' .. att_path
    --   end
    --
    --   -- when the file path is pure basename without any directory component
    --   if not src:match '[/\\]' then
    --     return vault_path .. '/attachments/' .. src
    --   end
    --
    --   -- when the file path is absolute path
    --   if src:match '^/' then
    --     return src
    --   end
    --
    --   return src
    -- end,
  },
  indent = {
    enabled = true,
    indent = { enabled = false },
    animate = { duration = { step = 10, duration = 100 } },
    scope = { enabled = true, char = "┊", underline = false, only_current = true, priority = 1000 },
  },
  styles = {
    snacks_image = {
      border = "rounded",
      backdrop = false,
    },
  },
   statuscolumn = {
     left = { 'mark', 'git' },
     right = {},
     folds = { open = true, git_hl = true },
     git = { patterns = { 'GitSign', 'MiniDiffSign' } },
   },
}
