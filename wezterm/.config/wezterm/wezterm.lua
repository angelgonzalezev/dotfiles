local wezterm = require("wezterm")

local config = wezterm.config_builder()

local colors = {
  base = "#1e1e2e",
  crust = "#11111b",
  mantle = "#181825",
  surface0 = "#313244",
  surface1 = "#45475a",
  overlay0 = "#6c7086",
  text = "#cdd6f4",
  subtext0 = "#a6adc8",
  lavender = "#b4befe",
}

local terminal_background = "rgba(30, 30, 46, 0.84)"

config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.84
config.macos_window_background_blur = 35
config.line_height = 1.05

config.window_padding = {
  left = 16,
  right = 16,
  top = 14,
  bottom = 12,
}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "MacOsNative"
config.integrated_title_button_alignment = "Left"
config.integrated_title_buttons = { "Close", "Hide", "Maximize" }
config.window_frame = {
  font = wezterm.font("JetBrains Mono", { weight = "DemiBold" }),
  font_size = 15.5,
  active_titlebar_bg = terminal_background,
  inactive_titlebar_bg = terminal_background,
  active_titlebar_fg = colors.text,
  inactive_titlebar_fg = colors.overlay0,
  button_fg = colors.text,
  button_bg = terminal_background,
  button_hover_fg = colors.crust,
  button_hover_bg = colors.lavender,
}

config.colors = {
  tab_bar = {
    background = terminal_background,
    active_tab = {
      bg_color = colors.lavender,
      fg_color = colors.crust,
    },
    inactive_tab = {
      bg_color = colors.mantle,
      fg_color = colors.subtext0,
    },
    inactive_tab_hover = {
      bg_color = colors.surface0,
      fg_color = colors.text,
    },
  },
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 36

config.keys = {
  {
    key = "LeftArrow",
    mods = "CMD|OPT",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "CMD|OPT",
    action = wezterm.action.ActivateTabRelative(1),
  },
}

local function tab_title(tab)
  local title = tab.tab_title

  if title == nil or title == "" then
    title = tab.active_pane.title
  end

  return title:gsub("^%s*(.-)%s*$", "%1")
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, hover, max_width)
  local background = colors.mantle
  local foreground = colors.subtext0

  if tab.is_active then
    background = colors.lavender
    foreground = colors.crust
  elseif hover then
    background = colors.surface1
    foreground = colors.text
  end

  local left_edge = utf8.char(0xe0b6)
  local right_edge = utf8.char(0xe0b4)
  local index = tostring(tab.tab_index + 1)
  local title = wezterm.truncate_right(tab_title(tab), math.max(8, max_width - 14))

  return {
    { Background = { Color = terminal_background } },
    { Foreground = { Color = background } },
    { Text = left_edge },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = "  " .. index .. " " },
    { Foreground = { Color = tab.is_active and colors.crust or colors.text } },
    { Text = title .. "  " },
    { Background = { Color = terminal_background } },
    { Foreground = { Color = background } },
    { Text = right_edge },
    { Background = { Color = terminal_background } },
    { Foreground = { Color = terminal_background } },
    { Text = "   " },
  }
end)

return config
