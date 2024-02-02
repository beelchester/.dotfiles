require('ayu').setup({
    theme = 'dark',
    transparent = true,
    term_colors = true,
    overrides = {
        SignColumn = { bg = "none" },
        Constant = { fg = "#f66565" },
        Keyword = { fg = "#8e95fd" },
        Number = { fg = "#ef9ad5" },
        Operator = { fg = "#f66565" },
    }
})


function ColorMyPencils(color) 
	color = color or "ayu"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
