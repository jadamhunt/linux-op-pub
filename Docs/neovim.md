# Neovim Shortcuts
--- 

| Key | Function |
| --- | --- |
| ctrl+y | auto complete |
| *navigation*   |
|down 1 page | ctrl+f |
|up 1 page | ctrl+b |
|up 1/2 page| ctrl+u |
|down 1/2 page| ctrl+d |


## Editing

Yank content from first pair of parenthesis, braces or brackets: 

```yib```

Paste inside pair of parenthesis, braces or brackets: 

```vibp``` *Visually, Inside-of Braces, Paste*

--- 
## Vim Plugins
### Markdown Plugin - [github site](https://github.com/MeanderingProgrammer/render-markdown.nvim) 
  * LazyVIM: 

Add to *init.lua*: 
``` {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
} ```

To Initialize Markdown Preview in Vim: **Normal Mode** 
 ```:RenderMarkdown```

