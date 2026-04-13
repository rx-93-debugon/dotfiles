return {
  "ojroques/nvim-osc52",
  lazy = false,
  config = function()
    local osc52 = require("osc52")

    osc52.setup({
      max_length = 0,
      silent = true,
      trim = false,
    })

    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        osc52.copy_register('"')
      end,
    })
  end,
}
