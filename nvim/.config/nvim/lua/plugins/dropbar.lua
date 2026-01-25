-- lua/plugins/dropbar.lua
return {
  "Bekaboo/dropbar.nvim",
  event = "LspAttach",
  config = function()
    -- 修正點 1：分開引入 API 模組，避免 nil 錯誤
    local dropbar_api = require("dropbar.api")
    -- 1. 設定你的粉色系色票
    local colors = {
      sakura   = '#ffb7b2', 
      hotpink  = '#ff75a0', 
      purple   = '#d3869b', 
      bg_hover = '#303440', 
    }

    -- 2. 基本設定
    require("dropbar").setup({
      bar = {
        sources = function(buf, _)
          local sources = require("dropbar.sources")
          return {
            sources.path, -- 檔案路徑
            sources.lsp,  -- LSP 結構
          }
        end,
        padding = { left = 1, right = 1 },
      },
      menu = {
        win_configs = { border = "rounded" },
      },
    })

    -- 3. 【風格魔改區】強制套用粉色系 Highlight
    vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { fg = colors.purple, bold = true })
    vim.api.nvim_set_hl(0, "DropBarKindFile", { fg = colors.sakura, bold = true })
    vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { fg = colors.hotpink, bg = colors.bg_hover })

    -- 4. 修正後的按鍵綁定
    -- 使用我們最上面引入的 dropbar_api 變數
    vim.keymap.set('n', '<Leader>p', dropbar_api.pick, { desc = 'Pick Dropbar' })
  end,
}
