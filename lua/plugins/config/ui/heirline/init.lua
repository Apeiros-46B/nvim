-- call all heirline configs
return function(theme)
    require('plugins.config.ui.heirline.statusline')(theme)
    require('plugins.config.ui.heirline.tabline')(theme)
    require('plugins.config.ui.heirline.winbar')(theme)
end
