-- Neovim >= 0.12 required

----------------------------------------------------------------------
-- General settings
----------------------------------------------------------------------

-- Trailing whitespace highlight
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    vim.fn.matchadd('ErrorMsg', [[\s\+$]])
  end,
})

-- Color scheme
vim.cmd.colorscheme('catppuccin')

-- Column indicators
vim.o.colorcolumn = '80,120'

-- Line numbers
vim.o.number = true

-- Cursor line
vim.o.cursorline = true

-- Block cursor in all modes
vim.o.guicursor = 'a:block'

-- Case-insensitive search (smartcase makes it case-sensitive when uppercase is used)
-- In 0.12, smartcase also applies to completion filtering
vim.o.ignorecase = true
vim.o.smartcase = true

-- Don't wrap long lines
vim.o.wrap = false

-- Indentation
vim.o.copyindent = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 8
vim.o.shiftround = true
vim.o.expandtab = true

-- Context lines around cursor
vim.o.scrolloff = 4

-- Max open tabs
vim.o.tabpagemax = 50

-- Ignore patterns in file listings
vim.o.wildignore = '.git/*,.svn/*,.hg/*,_darcs/*,build/*,dist/*,*.o,*.so,*.pyc,node_modules/'

-- Cursor can go one past end of line
vim.o.virtualedit = 'onemore'

-- Persistent undo across sessions
vim.o.undofile = true

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line = mark[1]
    if line > 1 and line <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

----------------------------------------------------------------------
-- Neovim 0.12 features
----------------------------------------------------------------------

-- Native autocompletion popup
vim.o.autocomplete = true

-- Rounded border on completion popup
vim.o.pumborder = 'rounded'

-- Sort completions by proximity to cursor
vim.o.completeopt = 'menu,menuone,nearest'

-- Modern cmdline and messages UI (experimental)
require('vim._core.ui2').enable({})

-- Diagnostic display configuration
vim.diagnostic.config({
  virtual_text = { spacing = 2 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN]  = 'W',
      [vim.diagnostic.severity.INFO]  = 'I',
      [vim.diagnostic.severity.HINT]  = 'H',
    },
  },
  underline = true,
  severity_sort = true,
})

-- Built-in visual undo tree
vim.cmd.packadd('nvim.undotree')

-- External plugins (vim.pack)
vim.pack.add({
  'https://github.com/junegunn/fzf',
  'https://github.com/junegunn/fzf.vim',
})

----------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------

vim.g.mapleader = ','

-- Navigate splits with Ctrl+arrows
vim.keymap.set('n', '<C-Left>',  '<C-w>h')
vim.keymap.set('n', '<C-Down>',  '<C-w>j')
vim.keymap.set('n', '<C-Up>',    '<C-w>k')
vim.keymap.set('n', '<C-Right>', '<C-w>l')

-- New empty buffer
vim.keymap.set('n', '<leader>n', ':enew<CR>')

-- Next / previous buffer
vim.keymap.set('n', '<C-l>', ':bnext<CR>')
vim.keymap.set('n', '<C-h>', ':bprevious<CR>')

-- Close buffer (jump to previous, then delete the one we left)
vim.keymap.set('n', '<leader>bq', ':bp <BAR> bd #<CR>')

-- List buffers (built-in, replaces Unite)
vim.keymap.set('n', '<leader>bl', ':ls<CR>:b<Space>')

-- Clear search highlight
vim.keymap.set('n', '<leader>l', ':nohlsearch<CR>', { silent = true })

-- Open current directory in netrw
vim.keymap.set('n', '<leader>o', ':Explore .<CR>', { silent = true })

-- Toggle line numbers
vim.keymap.set('', '<F2>', ':set invnumber<CR>', { silent = true })

-- jj as Escape in insert mode
vim.keymap.set('i', 'jj', '<Esc>')

-- fzf
vim.keymap.set('n', '<C-p>', ':Files<CR>', { silent = true })
vim.keymap.set('n', '<leader>f', ':Rg<CR>', { silent = true })
vim.keymap.set('n', '<leader>b', ':Buffers<CR>', { silent = true })

-- Clipboard operations
vim.keymap.set('v', '<C-c>', '"+yi')
vim.keymap.set('v', '<C-x>', '"+c')
vim.keymap.set('v', '<C-v>', 'c<Esc>"+p')
vim.keymap.set('i', '<C-v>', '<Esc>"+pa')

----------------------------------------------------------------------
-- Commands
----------------------------------------------------------------------

-- Save with sudo
vim.api.nvim_create_user_command('W', function()
  vim.cmd([[silent w !sudo tee % > /dev/null]])
  vim.cmd.edit()
end, {})
vim.api.nvim_create_user_command('Wq', function()
  vim.cmd('W')
  vim.cmd('q')
end, {})
vim.api.nvim_create_user_command('WQ', function()
  vim.cmd('Wq')
end, {})
