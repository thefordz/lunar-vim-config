-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- general
lvim.colorscheme = "catppuccin"
lvim.format_on_save.pattern = { "*.lua", "*.js", "*.jsx", "*ts", "*tsx" }
lvim.format_on_save.enabled = true
lvim.transparent_window = true

vim.opt.wrap = false
vim.opt.relativenumber = true
lvim.debug = false
local opts = {}
require("lvim.lsp.manager").setup("tailwindcss", opts)
require("lvim.lsp.manager").setup("eslint", opts)

lvim.builtin.lualine.active = false
lvim.builtin.lualine.style = "lvim"



-- nvimtree setup
lvim.builtin.nvimtree.active = true
-- lvim.builtin.nvimtree.setup.auto_reload_on_write = true
-- lvim.builtin.nvimtree.setup.disable_netrw = true
-- lvim.builtin.nvimtree.setup.hijack_netrw = true
-- lvim.builtin.nvimtree.setup.hijack_cursor = true
-- lvim.builtin.nvimtree.setup.hijack_unnamed_buffer_when_opening = false
-- lvim.builtin.nvimtree.setup.sync_root_with_cwd = true
-- lvim.builtin.nvimtree.setup.update_focused_file.update_root = false
-- lvim.builtin.nvimtree.setup.view.adaptive_size = false
-- lvim.builtin.nvimtree.setup.view.preserve_window_proportions = true
-- lvim.builtin.nvimtree.setup.filesystem_watchers.enable = true
-- lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_closed = ""
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_open = ""


-- NOTE: This setup for float nvimtree
local HEIGHT_RATIO = .7
local WIDTH_RATIO = .7
local screen_w = vim.opt.columns:get()
local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
local window_w = screen_w * WIDTH_RATIO
local window_h = screen_h * HEIGHT_RATIO
local window_w_int = math.floor(window_w)
local window_h_int = math.floor(window_h)
local center_x = (screen_w - window_w) / 2
local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_netrw = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.sync_root_with_cwd = true
lvim.builtin.nvimtree.setup.view.float.enable = true
lvim.builtin.nvimtree.setup.view.float.open_win_config.border = "rounded"
lvim.builtin.nvimtree.setup.view.float.open_win_config.relative = "editor"
lvim.builtin.nvimtree.setup.view.float.open_win_config.row = center_y
lvim.builtin.nvimtree.setup.view.float.open_win_config.col = center_x
lvim.builtin.nvimtree.setup.view.float.open_win_config.width = window_w_int
lvim.builtin.nvimtree.setup.view.float.open_win_config.height = window_h_int
lvim.builtin.nvimtree.setup.view.width = math.floor(vim.opt.columns:get() * WIDTH_RATIO)
lvim.builtin.telescope.theme = "center"
--

-- telescope config
-- lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
-- lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
-- lvim.builtin.telescope.defaults.winblend = 0
-- lvim.builtin.telescope.theme = 'ivy'
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
  pcall(telescope.load_extension, "neoclip")
end


-- keymap
lvim.keys.normal_mode["<C-h>"] = "<cmd> TmuxNavigateLeft<CR>"
lvim.keys.normal_mode["<C-l>"] = "<cmd> TmuxNavigateRight<CR>"
lvim.keys.normal_mode["<C-j>"] = "<cmd> TmuxNavigateDown<CR>"
lvim.keys.normal_mode["<C-k>"] = "<cmd> TmuxNavigateUp<CR>"


-- Additional Plugins
lvim.plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- {
  --   "Pocco81/auto-save.nvim",
  --   config = function()
  --     require("auto-save").setup()
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {

      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },
  -- {
  --   'b0o/incline.nvim',
  --   config = function()
  --     require('incline').setup()
  --   end,
  --   -- Optional: Lazy load Incline
  --   event = 'VeryLazy',
  -- },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "proselint",
  },
}

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

table.insert(lvim.plugins, {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      desc = "Incremental rename",
      mode = "n",
      noremap = true,
      expr = true,
    },
  },
  config = true,
})

-- table.insert(lvim.plugins, {
--   'b0o/incline.nvim',
--   event = "BufReadPre",
--   config = function()
--     local helpers = require("incline.helpers")
--     require("incline").setup({
--       window = {
--         padding = 0,
--         margin = { horizontal = 0 },
--       },
--       render = function(props)
--         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
--         local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
--         local modified = vim.bo[props.buf].modified
--         local buffer = {
--           ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
--           or "",
--           " ",
--           { filename, gui = modified and "bold,italic" or "bold" },
--           " ",
--           guibg = "#363944",
--         }
--         return buffer
--       end,
--     })
--   end,
-- })
