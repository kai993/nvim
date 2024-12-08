-- <leader>をスペースキーに設定
vim.g.mapleader = " "

---------------
-- lazy.nvim --
---------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
 performance = {
   rtp = {
     disabled_plugins = {
       "netrw",
       "netrwPlugin",
       "netrwSettings",
       "netrwFileHandlers",
     },
   },
 },
 checker = {
   enabled = false,
 }
})

-----------
-- Basic --
-----------
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.o.number = true
vim.cmd('set binary noeol')
vim.cmd('set nrformats=')
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.o.clipboard = 'unnamedplus'
vim.o.clipboard = 'unnamedplus'
vim.cmd('nnoremap j gj')
vim.cmd('nnoremap k gk')
-- vim.cmd('set completeopt=menuone,noinsert,noselect')
vim.cmd('inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "<CR>"')

-- ファイルごとのインデント設定
local filetype_tabstop = {
  lua=2,
  java=4,
  php=2,
  go=2,
  json=2,
  markdown=2,
}
local usrftcfg = vim.api.nvim_create_augroup("UserFileTypeConfig", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = usrftcfg,
  callback = function (args)
    local ftts = filetype_tabstop[args.match]
    if ftts then
      vim.bo.tabstop = ftts
      vim.bo.shiftwidth = ftts
    end
  end
})

-- タブ移動
vim.cmd('nnoremap <leader>bp <cmd>bp<CR>')
vim.cmd('nnoremap <leader>bn <cmd>bn<CR>')

--------------------
-- Plugin setting --
--------------------
-- alpha-nvim
require('alpha').setup(require'alpha.themes.startify'.config)

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  sort = {
    sorter = "name",
    folders_first = true,
  },
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = "default",
  select_prompts = false,
  view = {
    centralize_selection = false,
    cursorline = true,
    debounce_delay = 15,
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    highlight_modified = "none",
    root_folder_label = ":~:s?$?/..?",
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    git_ignored = true,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 400,
  },
  modified = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      eject = true,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
    absolute_path = true,
  },
  ui = {
    confirm = {
      remove = true,
      trash = true,
    },
  },
  experimental = {},
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
} -- END_DEFAULT_OPTS

-- local function open_nvim_tree()
--   require("nvim-tree.api").tree.open()
-- end
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.api.nvim_set_keymap('n', '<C-N><C-E>', ':NvimTreeToggle<CR>', { noremap = true, silent = true})

-- lualine.nvim
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- toggleterm.nvim
require("toggleterm").setup{
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  autochdir = false,
  highlights = {
    NormalFloat = {
      link = 'Normal'
    },
  },
  shade_terminals = false, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}
vim.api.nvim_set_keymap('n', '<C-t><C-e>', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<esc>", [[<C-\><C-N>]], { noremap = true })

-- ctrlp.vim
vim.cmd("let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']")

-- telescope
vim.cmd('nnoremap <leader>tf <cmd>Telescope find_files<cr>')
vim.cmd('nnoremap <leader>tg <cmd>Telescope live_grep<cr>')
vim.cmd('nnoremap <leader>tb <cmd>Telescope buffers<cr>')
vim.cmd('nnoremap <leader>th <cmd>Telescope help_tags<cr>')

-- markdown
vim.cmd('let g:vim_markdown_folding_disabled = 1')

local wk = require("which-key")
wk.add({
  { "<leader>f", group = "file" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fb", function() print("hello") end, desc = "Foobar" },
  { "<leader>fn", desc = "New File" },
  { "<leader>f1", hidden = true }, -- hide this keymap
  { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  { "<leader>b", group = "buffers", expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})

-- coc.nvim
vim.cmd('nnoremap <leader>gd <cmd>call CocAction("jumpDefinition")<CR>')
vim.cmd('nnoremap <leader>gs <cmd>call CocAction("jumpDefinition", "split")<CR>')
vim.cmd('nnoremap <leader>gvs <cmd>call CocAction("jumpDefinition", "vsplit")<CR>')
vim.cmd('nnoremap <leader>gr <cmd>call CocAction("jumpReferences")<CR>')
vim.cmd('nnoremap <leader>a <cmd>CocOutline<CR>')

-----------------
-- color scheme
-----------------
-- vim.cmd('colorscheme nightfox')
-- vim.g.lightline = { colorscheme = "nightfox" }
require('material').setup({
 contrast = {
     sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
     floating_windows = false, -- Enable contrast for floating windows
     line_numbers = true, -- Enable contrast background for line numbers
     sign_column = false, -- Enable contrast background for the sign column
     cursor_line = true, -- Enable darker background for the cursor line
     non_current_windows = false, -- Enable darker background for non-current windows
     popup_menu = false, -- Enable lighter background for the popup menu
 },

 italics = {
     comments  = true, -- Enable italic comments
     keywords  = true, -- Enable italic keywords
     functions = false, -- Enable italic functions
     strings   = false, -- Enable italic strings
     variables = true -- Enable italic variables
 },

 contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
     "terminal", -- Darker terminal background
     "packer", -- Darker packer background
     "qf" -- Darker qf list background
 },

 high_visibility = {
     lighter = false, -- Enable higher contrast text for lighter style
     darker = false -- Enable higher contrast text for darker style
 },

 disable = {
     colored_cursor = false, -- Disable the colored cursor
     borders = false, -- Disable borders between verticaly split windows
     background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
     term_colors = false, -- Prevent the theme from setting terminal colors
     eob_lines = false -- Hide the end-of-buffer lines
 },

 lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

 async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

 custom_highlights = {}, -- Overwrite highlights with your own

 plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
     trouble = true,
     nvim_cmp = true,
     neogit = true,
     gitsigns = true,
     git_gutter = true,
     telescope = true,
     nvim_tree = true,
     sidebar_nvim = true,
     lsp_saga = true,
     nvim_dap = true,
     nvim_navic = true,
     which_key = true,
     sneak = true,
     hop = true,
     indent_blankline = true,
     nvim_illuminate = true,
 }
})
vim.g.material_style = "ocean"
vim.cmd 'colorscheme material'

-- github-nvim-theme
-- @see https://github.com/projekt0n/github-nvim-theme
-- vim.cmd('colorscheme github_dark')
-- vim.cmd('colorscheme github_dark_dimmed')
-- vim.cmd('colorscheme github_dark_high_contrast')
-- vim.cmd('colorscheme github_dark_colorblind')
-- vim.cmd('colorscheme github_light')
