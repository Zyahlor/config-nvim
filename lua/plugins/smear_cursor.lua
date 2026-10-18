return {
  "sphamba/smear-cursor.nvim",
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    smear_insert_mode = true,

    cursor_color = "#FFFFFF",

    -- Smooth but not ridiculously slow.
    stiffness = 0.6,
    trailing_stiffness = 0.45,
    stiffness_insert_mode = 0.5,
    trailing_stiffness_insert_mode = 0.5,

    damping = 0.85,
    damping_insert_mode = 0.9,

    distance_stop_animating = 0.1,
  },
}
