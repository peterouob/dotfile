require("modes").setup({
  colors = {
    bg     = "#FFF9FB",     -- 若想跟 Normal 一樣，也可留空字串
    copy   = "#F5C359",   -- 柔黃：複製
    delete = "#E16B8A",   -- 粉紅偏紅：刪除
    change = "#E69AAE",   -- 比 delete 淡一點：編輯/變更
    format = "#E9A6AF",   -- 排版/格式
    replace= "#86D7CF",   -- 取代用溫和青綠，與粉系不打架
    select = "#FFB6C1", -- 你指定的 #FFB6C1
    visual = "#FFB6C1",
  },
  line_opacity   = 0.18,
  set_cursor     = true,
  set_cursorline = true,
  set_number     = true,
  set_signcolumn = true,
  -- 可視需要忽略某些面板，避免過度上色
  -- ignore = { "TelescopePrompt", "NvimTree" },
  --
})
