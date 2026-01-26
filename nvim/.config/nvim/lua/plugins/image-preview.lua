return {
  "3rd/image.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "3rd/image.nvim",
      build = false, -- 避免在安裝時自動編譯，減少錯誤
    },
  },
  opts = {
    backend = "kitty", -- 如果你用 Kitty 終端機
    -- backend = "ueberzug", -- 如果你用 Alacritty (但在 Mac 上不推薦)
    -- 注意：如果你使用的是 iTerm2 或 WezTerm，通常它會自動偵測，或者你可以不設定 backend
    
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki", "html" }, 
      },
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "norg" },
      },
      html = {
        enabled = true,
      },
      css = {
        enabled = true,
      },
    },
    max_width = 1024, -- 圖片最大寬度
    max_height = 960, -- 圖片最大高度
    max_width_window_percentage = math.huge,
    max_height_window_percentage = math.huge,
    window_overlap_clear_enabled = false, -- 是否讓浮動視窗遮住圖片
    editor_only_render_when_focused = true, -- 只有當前視窗才渲染
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- 打開這些檔案時直接顯示圖片
  },
}
