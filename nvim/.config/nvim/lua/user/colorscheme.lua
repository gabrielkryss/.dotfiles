-- color scheme selections
-------------------------
-- default
-- gruvbox
-- nightfox
-- tokyonight
-- everforest
-- bluewery

local colorscheme = "default" -- change color scheme here 

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
