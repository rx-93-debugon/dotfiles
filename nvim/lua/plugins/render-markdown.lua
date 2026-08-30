return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "markdown.mdx" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    heading = {
      enabled = true,
    },
    checkbox = {
      enabled = true,
    },
    latex = {
      enabled = vim.fn.executable("latex2text") == 1,
      converter = "latex2text",
      highlight = "RenderMarkdownMath",
    },
  },
}
