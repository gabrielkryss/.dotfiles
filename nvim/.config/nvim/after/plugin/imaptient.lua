-- nvim command
-- :LuaCacheClear:

-- Remove the loaded cache and delete the cache file. A new cache file will be created the next time you load Neovim.

_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_modpaths',
    }
}
require('impatient')