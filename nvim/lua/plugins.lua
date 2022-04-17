-- nvim: plugins.lua

-- execute PackerCompile after saving this file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'
    -- Themes
    use { 'dracula/vim', as = 'dracula' }
    use { 'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- Fuzzy finder
    use { 'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim' }
    -- LSP
    use 'neovim/nvim-lspconfig'
    -- Completion
    use { 'ms-jpq/coq_nvim',
        branch = 'coq',
        run = ':COQdeps',
        requires = {
            { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
        }
    }
    -- Syntax
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate' }
    -- Markdown
    use { "ellisonleao/glow.nvim" }
end)

