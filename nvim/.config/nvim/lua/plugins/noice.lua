return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- 這裡可以調整設定，但預設值通常就符合你的需求
    lsp = {
      -- 覆蓋 markdown 渲染等功能
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = false, -- 搜尋 / 還是留在底部 (看個人喜好，設為 false 會移到中間)
      command_palette = true, -- 將 cmdline 和 popupmenu 整合在一起 (類似 VS Code)
      long_message_to_split = true, -- 長訊息拆分到視窗
      inc_rename = true, -- 啟用增量重新命名輸入框
      lsp_doc_border = true, -- 為文檔添加邊框
    },
  },
  dependencies = {
    -- 如果你還沒有安裝這些依賴
    "MunifTanjim/nui.nvim",
  },
}
