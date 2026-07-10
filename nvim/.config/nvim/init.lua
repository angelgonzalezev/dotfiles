-- La tecla líder será Espacio
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Opciones básicas
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.cmdheight = 0
vim.opt.pumblend = 12
vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "",
  foldclose = "",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

local colors = {
  crust = "#11111b",
  mantle = "#181825",
  surface0 = "#313244",
  surface1 = "#45475a",
  overlay0 = "#6c7086",
  text = "#cdd6f4",
  subtext0 = "#a6adc8",
  lavender = "#b4befe",
}

local function set_wezterm_highlights()
  local highlights = {
    Normal = { bg = "NONE", fg = colors.text },
    NormalNC = { bg = "NONE", fg = colors.subtext0 },
    NormalFloat = { bg = colors.mantle, fg = colors.text },
    FloatBorder = { bg = colors.mantle, fg = colors.surface1 },
    Pmenu = { bg = colors.mantle, fg = colors.text },
    PmenuSel = { bg = colors.lavender, fg = colors.crust, bold = true },
    CursorLine = { bg = colors.surface0 },
    LineNr = { fg = colors.overlay0 },
    CursorLineNr = { fg = colors.lavender, bold = true },
    SignColumn = { bg = "NONE" },
    StatusLine = { bg = colors.crust, fg = colors.text },
    StatusLineNC = { bg = colors.crust, fg = colors.overlay0 },
    WinSeparator = { fg = colors.surface0 },
    TabLineFill = { bg = colors.crust, fg = colors.crust },
    WezTabActive = { bg = colors.lavender, fg = colors.crust, bold = true },
    WezTabActiveEdge = { bg = colors.crust, fg = colors.lavender },
    WezTabInactive = { bg = colors.mantle, fg = colors.subtext0 },
    WezTabInactiveEdge = { bg = colors.crust, fg = colors.mantle },
    WezTabModified = { bg = colors.mantle, fg = colors.text, bold = true },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

local function tab_title(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)

  if name == "" then
    return "[Sin nombre]"
  end

  return vim.fn.fnamemodify(name, ":t")
end

function _G.wezterm_style_tabline()
  local current = vim.api.nvim_get_current_buf()
  local parts = { "%#TabLineFill#" }
  local index = 0

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then
      index = index + 1

      local active = bufnr == current
      local modified = vim.bo[bufnr].modified
      local tab_group = active and "WezTabActive" or "WezTabInactive"
      local edge_group = active and "WezTabActiveEdge" or "WezTabInactiveEdge"
      local title_group = modified and not active and "WezTabModified" or tab_group
      local title = vim.fn.strcharpart(tab_title(bufnr), 0, 24)
      local marker = modified and " +" or ""

      parts[#parts + 1] = "%#" .. edge_group .. "#"
      parts[#parts + 1] = "%#" .. tab_group .. "#  " .. index .. " "
      parts[#parts + 1] = "%#" .. title_group .. "#" .. title .. marker .. "  "
      parts[#parts + 1] = "%#" .. edge_group .. "#"
      parts[#parts + 1] = "%#TabLineFill#   "
    end
  end

  return table.concat(parts)
end

vim.opt.tabline = "%!v:lua.wezterm_style_tabline()"

-- Instalar lazy.nvim automáticamente
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
      },
      integrations = {
        snacks = true,
        native_lsp = {
          enabled = true,
        },
      },
      custom_highlights = function()
        return {
          TabLineFill = { bg = colors.crust, fg = colors.crust },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
      set_wezterm_highlights()
    end,
  },

  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      picker = {
        enabled = true,
      },
    },

    keys = {
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Buscar archivos",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Buscar texto",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buscar buffers",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      options = {
        theme = {
          normal = {
            a = { bg = colors.lavender, fg = colors.crust, gui = "bold" },
            b = { bg = colors.surface0, fg = colors.text },
            c = { bg = colors.crust, fg = colors.subtext0 },
          },
          insert = {
            a = { bg = "#a6e3a1", fg = colors.crust, gui = "bold" },
          },
          visual = {
            a = { bg = "#f5c2e7", fg = colors.crust, gui = "bold" },
          },
          replace = {
            a = { bg = "#f38ba8", fg = colors.crust, gui = "bold" },
          },
          command = {
            a = { bg = "#fab387", fg = colors.crust, gui = "bold" },
          },
          inactive = {
            a = { bg = colors.crust, fg = colors.overlay0 },
            b = { bg = colors.crust, fg = colors.overlay0 },
            c = { bg = colors.crust, fg = colors.overlay0 },
          },
        },
        component_separators = "",
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " +",
              readonly = " ",
              unnamed = "[Sin nombre]",
            },
          },
        },
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_wezterm_highlights,
})
