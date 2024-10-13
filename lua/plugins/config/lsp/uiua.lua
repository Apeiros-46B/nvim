return function(theme)
    local colors = theme.colors

    vim.g.uiua_recommended_style = true
    vim.g.uiua_format_on_save = true
    vim.g.uiua_path = 'uiua'
    vim.g.uiua_dark_mode = true

    local hl = {
        uiuaRed            = { fg = colors.red      },
        uiuaOrange         = { fg = colors.orange   },
        uiuaYellow         = { fg = colors.yellow   },
        uiuaBeige          = { fg = colors.sand     },
        uiuaGreen          = { fg = colors.green    },
        uiuaAqua           = { fg = colors.teal     },
        uiuaBlue           = { fg = colors.blue     },
        uiuaIndigo         = { fg = colors.lavender },
        uiuaPurple         = { fg = colors.purple   },
        uiuaPink           = { fg = colors.pink     },
        uiuaLightPink      = { fg = colors.pink     },
        uiuaFaded          = { fg = colors.gray7    },
        uiuaForegroundDark = { fg = colors.white    },

        uiuaMacroSpecial     = { link = 'uiuaRed'      },
        uiuaPunctuation      = { link = 'uiuaFaded'    },
        uiuaMonadicP         = { link = 'uiuaOrange'   },
        uiuaDyadicP          = { link = 'uiuaOrange'   },
        uiuaPentadic         = { fg = colors.alt_blue  },
        uiuaNum              = { link = 'uiuaPurple'   },
        uiuaNumShadow        = { link = 'uiuaNum'      },
        uiuaEsc              = { link = 'uiuaYellow'   },
        uiuaFmt              = { link = 'uiuaIndigo'   },
        uiuaUnicodeLiteral   = { link = 'uiuaIndigo'   },
        uiuaSignature        = { link = 'uiuaYellow'   },
        uiuaModPunct         = { link = 'uiuaFaded'    },
        uiuaLabel            = { fg = colors.alt_green },
        uiuaSemanticComment  = { link = 'uiuaRed'      },
        uiuaSignatureComment = { link = 'uiuaPurple'   },
        uiuaComment          = { link = 'Comment'      },
    }

    for k, v in pairs(hl) do vim.api.nvim_set_hl(0, k, v) end
end
