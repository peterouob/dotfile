return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "User FilePost", 
  config = function()
    local todo = require("todo-comments")

    -- 定義你的粉色系
    local colors = {
      sakura   = '#ffb7b2',  -- 櫻花粉
      hotpink  = '#ff75a0',  -- 熱粉紅
      purple   = '#d3869b',  -- 紫粉
      bg_dark  = '#202328',  -- 背景深色 (讓字變清楚)
    }

    todo.setup({
      -- 這裡設定各種類型對應的顏色
      keywords = {
        FIX = {
          icon = " ", 
          color = "hotpink", -- 使用下面的自訂色名
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, 
        },
        TODO = { 
          icon = " ", 
          color = "sakura", 
          alt = { "TIP" } 
        },
        HACK = { 
          icon = " ", 
          color = "purple" 
        },
        WARN = { 
          icon = " ", 
          color = "warning", 
          alt = { "WARNING", "XXX" } 
        },
        PERF = { 
          icon = " ", 
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } 
        },
        NOTE = { 
          icon = " ", 
          color = "hint", 
          alt = { "INFO" } 
        },
      },
      
      -- 【關鍵】在這裡定義顏色的實際 Hex 代碼
      colors = {
        hotpink = { colors.hotpink }, -- 定義 hotpink 對應什麼色碼
        sakura  = { colors.sakura },
        purple  = { colors.purple },
        -- 預設的其他顏色
        error   = { "#DC2626" },
        warning = { "#FBBF24" },
        info    = { "#2563EB" },
        hint    = { "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test    = { "Identifier", "#FF00FF" }
      },
      
      -- 讓背景稍微圓潤一點，符合你的 UI 風格
      gui_style = {
        fg = "BOLD", -- 字體加粗
        bg = "BOLD",
      },
    })
    
    -- 設定快速鍵：跳到下一個 TODO
    vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "Next TODO" })
    vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "Prev TODO" })
  end,
}
