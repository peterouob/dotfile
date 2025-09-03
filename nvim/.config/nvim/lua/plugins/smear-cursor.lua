return {
  "sphamba/smear-cursor.nvim",
  opts = {
    -- 關掉容易造成誇張拖影的行為
    smear_between_buffers = false,
    smear_between_neighbor_lines = false,
    scroll_buffer_space = false,
    smear_insert_mode = false,

    -- 不改變顏色（用目標文字色），更不顯眼
    cursor_color = "none",

    -- 「平滑但無拖尾」的建議值
    stiffness = 0.5,                 -- ← 你原本打成 stiffnes（少一個 s）
    trailing_stiffness = 0.5,
    stiffness_insert_mode = 0.5,
    trailing_stiffness_insert_mode = 0.5,
    matrix_pixel_threshold = 0.5,

    -- 盡快停止動畫
    damping = 0.95,
    damping_insert_mode = 0.95,
    distance_stop_animating = 0.1,

    -- 避免游標重影（必要時再開）
    hide_target_hack = true,
  },
}
