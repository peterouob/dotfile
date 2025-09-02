
return {
  "mvllow/modes.nvim",
  event = "VeryLazy",
  opts = {
    colors = {
      visual = "#89b4fa",  -- Visual 模式主色（自己改）
      copy   = "#a6e3a1",
      delete = "#f38ba8",
      insert = "#94e2d5",
    },
    line_opacity  = 0.15,  -- 游標行底色透明度
    set_cursor    = true,  -- 改變終端游標顏色（支援則生效）
    set_cursorline= true,  -- 高亮游標行
    set_number    = true,  -- 高亮行號
  },
}
