return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", 
    build = ":TSUpdate",
    config = function()
        -- 1. Manually ensure parsers are installed 
        -- (Since .setup is gone, we use the command or the internal install module)
        local install = require('nvim-treesitter.install')
        install.prefer_git = true
        
        -- 2. Define your list of languages
        local languages = {
            "vim", "vimdoc", "html", "css", "javascript",
            "elixir", "lua", "erlang", "heex", "eex", "query"
        }

        -- 3. THE NATIVE HIGHLIGHTER (With Safety Check)
        -- This is what actually makes the colors appear in 0.11+
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local bufnr = args.buf
                local ft = vim.bo[bufnr].filetype
                
                -- 1. Get the official Treesitter name for this filetype
                local lang = vim.treesitter.language.get_lang(ft)
                
                -- 2. SAFETY CHECK: Only start if we have a parser installed for it
                if lang then
                    local has_parser, _ = pcall(vim.treesitter.get_parser, bufnr, lang)
                    if has_parser then
                        vim.treesitter.start(bufnr, lang)
                    end
                end
            end,
        })

        -- 4. Enable Indentation (Native Lua way)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                -- This uses the treesitter engine for indentation logic
                vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
            end,
        })
    end,
}
