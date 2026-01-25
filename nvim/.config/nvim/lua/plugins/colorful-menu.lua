return {
  "xzbdmw/colorful-menu.nvim",
  event = "InsertEnter", -- 優化：只有進入插入模式時才載入
  config = function()
    require("colorful-menu").setup({
      ls = {
        -- 1. Lua 設定
        lua_ls = {
          -- 讓參數顯示稍微暗一點，避免搶了函式名的風頭
          arguments_hl = "@comment",
        },

        -- 2. Golang 設定 (重點)
        gopls = {
          -- 將型別對齊到最右側 (e.g., "foo        *Foo")，視覺更整潔
          align_type_to_right = true,
          -- Go 語法習慣不加冒號，保持原汁原味
          add_colon_before_type = false,
          -- 即使選單寬度不夠，也優先保留型別資訊
          preserve_type_when_truncate = true,
        },

        -- 3. Rust 設定 (重點)
        ["rust-analyzer"] = {
          align_type_to_right = true,
          -- 把像是 (as Iterator) 這種額外資訊變暗，減少視覺干擾
          extra_info_hl = "@comment",
          preserve_type_when_truncate = true,
        },

        -- 4. C/C++ 設定
        clangd = {
          align_type_to_right = true,
          extra_info_hl = "@comment",
          -- 讓 import 的點 (•std::...) 變暗
          import_dot_hl = "@comment",
          preserve_type_when_truncate = true,
        },

        -- 5. 其他語言 (Python, TypeScript, Zig, etc.)
        basedpyright = { extra_info_hl = "@comment" },
        vtsls = { extra_info_hl = "@comment" },
        ts_ls = { extra_info_hl = "@comment" },
        zls = { align_type_to_right = true },
        
        -- 對於未支援的語言，嘗試 fallback
        fallback = true,
        fallback_extra_info_hl = "@comment",
      },

      -- 若無法判定 highlight group，預設使用的顏色
      fallback_highlight = "@variable",
      
      -- 限制最大寬度 (字元數或百分比 0-1)
      max_width = 60,
    })
  end,
}
