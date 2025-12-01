local wezterm = require("wezterm")
local builtin = wezterm.color.get_builtin_schemes()

-- print("=== Color Schemes ===")
-- for name in pairs(builtin) do
-- 	print("• " .. name)
-- end

-- Utility: deep-copy a table safely
-- • returns non-tables (including nil) unchanged
-- • handles recursive (self-referential) tables
-- • preserves metatables without triggering metamethods
-- • uses raw iteration (next) to avoid custom __pairs
local function deep_copy(orig, seen)
	if type(orig) ~= "table" then
		return orig
	end
	seen = seen or {}
	if seen[orig] then
		return seen[orig]
	end
	local copy = {}
	seen[orig] = copy
	for k, v in next, orig do
		copy[deep_copy(k, seen)] = deep_copy(v, seen)
	end
	return setmetatable(copy, getmetatable(orig))
end

-- Start with all built‑ins
local color_schemes = {}
for name, scheme in pairs(builtin) do
	color_schemes[name] = scheme
end

-- Everforest
color_schemes["Everforest Custom"] = (function()
	local base = builtin["Everforest Dark (Gogh)"]
	local cs = deep_copy(base)
	cs.background = "#272E33"
	return cs
end)()

color_schemes["Everforest Dark (Gogh) Blue Modded"] = (function()
	local base = builtin["Everforest Dark (Gogh)"]
	local cs = deep_copy(base)
	cs.background = "#000B17"
	return cs
end)()

color_schemes["Everforest Dark (Gogh) Black Modded"] = (function()
	local base = builtin["Everforest Dark (Gogh)"]
	local cs = deep_copy(base)
	cs.background = "#000000"
	return cs
end)()

-- Catppuccin
color_schemes["Catppuccin Mocha Blue Modded"] = (function()
	local base = builtin["Catppuccin Mocha"]
	local cs = deep_copy(base)
	cs.background = "#000B17"
	return cs
end)()

color_schemes["Catppuccin Mocha Black Modded"] = (function()
	local base = builtin["Catppuccin Mocha"]
	local cs = deep_copy(base)
	cs.background = "#000000"
	return cs
end)()

-- Gruvbox
color_schemes["Gruvbox Material (Gogh) Brown Modded"] = (function()
	local base = builtin["Gruvbox Material (Gogh)"]
	local cs = deep_copy(base)
	cs.background = "#0E0B00"
	return cs
end)()

color_schemes["Gruvbox Material (Gogh) Black Modded"] = (function()
	local base = builtin["Gruvbox Material (Gogh)"]
	local cs = deep_copy(base)
	cs.background = "#000000"
	return cs
end)()

-- Rosé Pine
color_schemes["rose-pine-moon Blue Modded"] = (function()
	local base = builtin["rose-pine-moon"]
	local cs = deep_copy(base)
	cs.background = "#000B17"
	return cs
end)()

color_schemes["rose-pine-moon Black Modded"] = (function()
	local base = builtin["rose-pine-moon"]
	local cs = deep_copy(base)
	cs.background = "#000000"
	return cs
end)()

-- Export merged table
return color_schemes
