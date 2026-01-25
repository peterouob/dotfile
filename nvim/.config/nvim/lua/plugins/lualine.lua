return{
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 1. 定義粉色系色票
    local colors = {
      bg       = '#202328',
      fg       = '#bbc2cf',
      yellow   = '#ECBE7B',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#98be65',
      orange   = '#FF8800',
      violet   = '#a9a1e1',
      magenta  = '#c678dd',
      blue     = '#51afef',
      red      = '#ec5f67',
      -- 粉色特調區
      sakura   = '#ffb7b2', -- 櫻花粉 (適合 Insert 模式)
      hotpink  = '#ff75a0', -- 熱粉紅 (適合 Normal 模式)
      purple   = '#d3869b', -- 紫粉色 (適合 Visual 模式)
      black    = '#1c1e26', -- 字體顏色
    }

    -- 2. 定義自訂主題結構
    local pink_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.hotpink, gui = 'bold' },
        b = { fg = colors.hotpink, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      insert = {
        a = { fg = colors.black, bg = colors.sakura, gui = 'bold' },
        b = { fg = colors.sakura, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      visual = {
        a = { fg = colors.black, bg = colors.purple, gui = 'bold' },
        b = { fg = colors.purple, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      replace = {
        a = { fg = colors.black, bg = colors.red, gui = 'bold' },
        b = { fg = colors.red, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      command = {
        a = { fg = colors.black, bg = colors.yellow, gui = 'bold' },
        b = { fg = colors.yellow, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        a = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
    }

    -- 3. 套用設定與氣泡樣式
    require("lualine").setup({
      options = {
        theme = pink_theme, -- 使用上面的粉色主題
        component_separators = '',
        section_separators = { left = '', right = '' }, -- 氣泡圓角
        globalstatus = true, -- 只有一條狀態列貫穿底部 (更現代)
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {
          -- 顯示 LSP 診斷訊息 (紅/粉/黃)
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
              error = { fg = colors.red },
              warn  = { fg = colors.yellow },
              info  = { fg = colors.cyan },
            },
          }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
    })
  end,
}
