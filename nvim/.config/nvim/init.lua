if not vim.g.vscode then
-- Edit from https://github.com/mjlbach/defaults.nvim
-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'       -- Package manager
  use 'tpope/vim-fugitive'           -- Git commands in nvim
  use 'tpope/vim-commentary'         -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  -- use 'nvim-lua/popup.nvim'
  -- use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  -- use {'~/dev/projects/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use 'morhetz/gruvbox' -- gruvbox theme
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  use 'neovim/nvim-lspconfig'        -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe'           -- Autocompletion plugin
  use 'dart-lang/dart-vim-plugin'    -- filetype detection, syntax highlighting, and indentation for Dart code in Vim.
  use 'akinsho/flutter-tools.nvim'   -- flutter-tools
  use 'mfussenegger/nvim-dap' -- debug tool
  use 'SirVer/ultisnips' 	     -- for snippets
  use 'f-person/pubspec-assist-nvim' -- assist insert pubspec
  use 'f-person/nvim-sort-dart-imports' -- sort imports for dart
  use 'nvim-treesitter/nvim-treesitter'
  use 'tamago324/compe-zsh' --zsh source for compe
  use 'kevinhwang91/nvim-bqf' -- quickfix better
  use 'akinsho/nvim-bufferline.lua' --tabline
  use 'gennaro-tedesco/nvim-jqx' -- view json
  use {'kevinhwang91/nvim-hlslens'} -- search highlight
  use {"npxbr/glow.nvim", run = "GlowInstall"} -- preview markdown
  use 'kdheepak/lazygit.nvim' -- call lazygit in vim
  use 'ray-x/lsp_signature.nvim' -- signature pop up help
  use {
  'kyazdani42/nvim-tree.lua', -- file manager
  requires = "kyazdani42/nvim-web-devicons",
  }
  use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
		auto_open = false, -- automatically open the list when you have diagnostics
		auto_close = true, -- automatically close the list when you have no diagnostics
		auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
		auto_fold = false,
    }
  end
  }
end)


--Incremental live completion
vim.o.inccommand = "nosplit"

--Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers
vim.o.hidden = true

-- Some tab space
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4


--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd[[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn="yes"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd[[colorscheme gruvbox]]


--Remap tab on ultisnips so we can use tab for complete
vim.g.UltiSnipsExpandTrigger="C-<tab>"
--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap= true, expr = true, silent = true})

--Remap escape to leave terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<c-\><c-n>]], {noremap = true})

--Add map to enter paste mode
vim.o.pastetoggle="<F3>"

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

-- Telescope
local trouble = require("trouble.providers.telescope")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
	  n = { ["<c-t>"] = trouble.open_with_trouble },
    },
    -- generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  }
}
--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})
-- Trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})
--
-- LSP settings
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require "lsp_signature".on_attach()

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls', 'bashls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

local sumneko_root_path = vim.fn.getenv("HOME").."/dev/projects/lua-language-server" -- Change to your sumneko root installation
local sumneko_binary_path = "/bin/macOS/lua-language-server" -- Change to your OS specific output folder
nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_root_path .. sumneko_binary_path, "-E", sumneko_root_path.."/main.lua" };
  on_attach = on_attach,
  settings = {
      Lua = {
          runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
              globals = {'vim'},
          },
          workspace = {
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
          },
      },
  },
}


-- Setup flutter
require("flutter-tools").setup{
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
  },

  debugger = { -- integrate with nvim dap
    enabled = true,
  },
  flutter_path = vim.fn.getenv("FLUTTER").."/flutter",
  -- flutter_lookup_cmd =vim.fn.getenv("FLUTTER").."/flutter", -- example "dirname $(which flutter)" or "asdf where flutter"
  widget_guides = {
    enabled = false,
  },
  closing_tags = {
    -- highlight = "ErrorMsg", -- highlight for the closing tag
    -- prefix = ">", -- character to use for close tag e.g. > Widget
    enabled = true -- set to false to disable
  },
  dev_log = {
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
  },
  lsp = {
    on_attach = on_attach,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
    }
  }
}

-- nvim_lsp.dartls.setup{
--   cmd = { "dart", vim.fn.getenv("FLUTTER").."/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" };
--   on_attach = on_attach;
--   settings = {
--     closingLabels  = true,
--     flutterOutline = true,
--   };
--   init_options = {
-- 	closingLabels = true,
-- 	flutterOutline = true,
-- 	onlyAnalyzeProjectsWithOpenFiles = false,
-- 	outline = true,
-- 	suggestFromUnimportedLibraries = true
--   };
-- }


-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert"

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
	tags = true;
	zsh = true;
    nvim_lsp = true;
    buffer = true;
    calc = true;
    nvim_lua = true;
    vsnip = true;
	spell = true;
    ultisnips = true;
    luasnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {expr=true, silent=true})
-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr=true, silent=true})
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
-- Double esc to clear search highlight
vim.api.nvim_set_keymap("n", "<esc><esc>", ":noh<CR>", {silent=true})

-- format after save
vim.api.nvim_exec([[
  augroup FormatAfterSave
    autocmd!
	autocmd BufWrite *.dart :DartSortImports
    autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil,1000)
  augroup end
]], false)
---------------NVIM TREE---------------------------------
--Config nvim tree
vim.g.nvim_tree_side = 'right' --left by default
vim.g.nvim_tree_width = 40 --30 by default, can be width_in_columns or 'width_in_percent%'
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } --empty by default
vim.g.nvim_tree_gitignore = 1 --0 by default
vim.g.nvim_tree_auto_open = 1 --0 by default, opens the tree when typing `vim $DIR` or `vim`
vim.g.nvim_tree_auto_close = 1 --0 by default, closes the tree when it's the last window
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } --empty by default, don't auto open tree on specific filetypes.
vim.g.nvim_tree_quit_on_open = 0 --0 by default, closes the tree when you open a file
vim.g.nvim_tree_follow = 1 --0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_indent_markers = 1 --0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_hide_dotfiles = 1 --0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_git_hl = 1 --0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_highlight_opened_files = 1 --0 by default, will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_root_folder_modifier = ':~' --This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_tab_open = 1 --0 by default, will open the tree when entering a new tab and the tree was previously open
vim.g.nvim_tree_auto_resize = 0 --1 by default, will resize the tree to its saved width when opening a file
vim.g.nvim_tree_disable_netrw = 0 --1 by default, disables netrw
vim.g.nvim_tree_hijack_netrw = 0 --1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
vim.g.nvim_tree_add_trailing = 1 --0 by default, append a trailing slash to folder names
vim.g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_lsp_diagnostics = 1 --0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
vim.g.nvim_tree_disable_window_picker = 1 --0 by default, will disable the window picker.
vim.g.nvim_tree_hijack_cursor = 0 --1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
vim.g.nvim_tree_icon_padding = ' ' --one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
vim.g.nvim_tree_update_cwd = 1 --"0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.

-- open nvim tree
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {})


-- " a list of groups can be found at `:help nvim_tree_highlight`
-- highlight NvimTreeFolderIcon guibg=blue

---------------------- Trouble config --------------------------
-- jump to the next item, skipping the groups
require("trouble").next({skip_groups = true, jump = true});

-- jump to the previous item, skipping the groups
require("trouble").previous({skip_groups = true, jump = true});
--------------------bufferline config---------------------------
require("bufferline").setup{
	diagnostics = "nvim_lsp",
	custom_areas = {
	  right = function()
		local result = {}
		local error = vim.lsp.diagnostic.get_count(0, [[Error]])
		local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
		local info = vim.lsp.diagnostic.get_count(0, [[Information]])
		local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

		table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
		if error ~= 0 then
		  table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
		end

		if warning ~= 0 then
		  table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
		end

		if hint ~= 0 then
		  table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
		end

		if info ~= 0 then
		  table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
		end
		return result
	  end,
	}
}
end