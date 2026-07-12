return {
  "nvim-mini/mini.indentscope",
  version = false,
  config = function()
    require("mini.indentscope").setup({
      draw = {
        delay = 100,
        -- omit animation = ... to use the plugin's built-in default (20ms/step)
        predicate = function(scope) return not scope.body.is_incomplete end,
        priority = 2,
      },
      mappings = {
        object_scope = "ii",
        object_scope_with_border = "ai",
        goto_top = "[i",
        goto_bottom = "]i",
      },
      options = {
        border = "both",
        indent_at_cursor = true,
        n_lines = 10000,
        try_as_border = false,
      },
      symbol = "╏",
    })
  end,
}
