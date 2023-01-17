-- call all heirline configs
return function(theme)
    -- {{{ imports
    local heirline = require('heirline')
    local utils    = require('heirline.utils')
    local conds    = require('heirline.conditions')

    heirline.load_colors(theme.colors)
    -- }}}

    -- {{{ paddings & separators
    local sp    = { provider = '%1( %)'   }
    local sep   = { provider = '%3( ~ %)' }
    local sepl  = { provider = '%2( ~%)'  }
    local sepr  = { provider = '%2(~ %)'  }
    local align = { provider = '%='       }
    -- }}}

    -- {{{ setup
    local function cfg(module)
        return require('plugins.config.ui.heirline.' .. module)(conds, utils, sp, sep, sepl, sepr, align)
    end

    heirline.setup({
        statusline = cfg('statusline'),
        tabline = cfg('tabline'),
    })
    -- }}}
end
