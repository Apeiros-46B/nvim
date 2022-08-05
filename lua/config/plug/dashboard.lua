local db = require('dashboard')
local scheme = require('lib.scheme')
local colors = scheme.colors
local set_hl = vim.api.nvim_set_hl

db.hide_statusline = false
db.hide_tabline = false

db.custom_header = {
    '',
    '',
    '┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓',
    '┃ ⠀⠀⣀⠔⠉⠀⠀⠀⠀⠀⣀⡀⠀⢀⠀⠀⠀⠁⠀⠀⠀⠀⢀⣀⣀⣰⣁⠴⣧⠴⠷⠖⠒⠒⣲⠞ ┃',
    '┃ ⣠⠞⡁⠀⠀⠀⠀⢀⡤⠊⠀⠹⡆⠈⢦⠀⠀⢀⣤⣤⣬⣯⣥⣄⣠⡗⠁⠀⢁⠀⠀⠀⢀⠞⠁⠀ ┃',
    '┃ ⢁⠀⡄⠀⠀⣠⡔⠡⣤⠄⠂⠂⠉⠀⣈⣃⣀⡠⡦⠤⠦⠀⢳⡀⡹⠋⢉⡽⠋⠀⢀⡔⠁⠀⡀⠐ ┃',
    '┃ ⣤⠾⠗⠒⢉⠀⢀⣴⠉⠀⠀⠀⠀⠈⢿⡉⠉⠃⢸⠘⠋⠎⠀⣹⠃⡴⠋⠀⢀⡴⠋⠀⠐⠂⠀⠠ ┃',
    '┃ ⣷⡶⢀⣶⣧⣠⣾⢿⣧⡀⠀⠀⠀⠠⣌⣷⡀⠀⠀⢇⠌⠀⡰⣡⠞⣷⠀⡠⠊⠀⠀⠀⠀⠀⡀⠀ ┃',
    '┃ ⣿⣶⣿⣿⣿⣿⠟⢇⠻⣷⡴⢦⣀⠀⠀⢻⢿⡦⠀⠎⡀⣠⠞⠁⠀⠘⠊⠀⢄⠀⠀⢀⣠⠞⢀⠀ ┃',
    '┃ ⣿⣿⡟⣿⣿⢫⣴⠁⠀⢸⣿⡄⡀⢹⠆⣠⡎⢹⣞⢈⡿⠁⠀⠀⠀⢀⣠⡠⠴⠿⢟⡿⠿⢶⡿⢤ ┃',
    '┃ ⣮⡙⣿⡿⢡⣏⠸⠀⠀⡼⠈⢿⡖⢋⠞⠁⢰⠎⠙⠋⣠⡀⠀⠀⢀⡏⢁⣤⠄⢠⠞⠻⣶⣦⣵⣼ ┃',
    '┃ ⣿⣿⣿⣧⡀⠉⠁⡐⣾⢇⡰⣋⢿⣇⠀⠀⠀⡀⠀⡀⠁⣸⣶⣾⠋⢸⣠⢏⡴⠃⠀⠐⠛⠻⢯⣉ ┃',
    '┃ ⣾⣿⠈⣿⣿⡳⣶⣿⡧⠋⠰⠃⠀⢻⣧⠀⠈⣉⡾⠀⠶⢚⣿⠁⠰⣿⣧⠜⠁⢠⣤⣀⣶⣂⣈⠻ ┃',
    '┃ ⢯⣘⣷⣿⣿⣿⣿⡛⢿⣄⠠⠒⢈⡠⠻⣷⣡⠏⠀⠀⣸⡟⢻⣀⡌⣸⡿⣦⠐⠻⡿⠟⠉⠁⠀⠠ ┃',
    '┃ ⠤⠽⢿⣿⣿⣿⡟⣿⢚⣿⣦⠔⠏⠐⠀⠽⣿⡀⠀⠀⠉⠉⠙⠃⢰⡿⠀⠈⢳⣄⠀⠀⠀⢀⠀⠀ ┃',
    '┃ ⣀⣀⣂⣈⣯⣈⣛⣦⣀⣙⢿⣧⣄⠊⣲⣁⣘⣷⣀⢀⠤⢁⡴⠃⣾⠉⠀⠀⠀⠈⠢⡀⠀⢀⡄⠀ ┃',
    '┃ ⣻⣟⡛⠛⢛⠻⣛⠛⠛⠋⠀⠻⣧⡐⠛⠛⠛⠛⢻⠏⢠⠊⠀⢸⡏⠀⠀⢨⠧⡀⠀⠹⣎⠀⢸⠆ ┃',
    '┃ ⣿⣿⣧⣶⢿⡷⠋⢢⡄⠀⠀⠀⠹⣷⡄⢀⡴⢃⣫⡨⠚⣿⠀⣾⣀⡀⠀⠿⠀⠛⢦⡄⠈⠳⡀⠀ ┃',
    '┃ ⣿⣻⣿⣷⠈⣿⠆⢀⠘⣴⣿⣦⡀⠙⣿⣾⣿⣟⣸⢉⣥⡿⢤⣽⠉⠉⣉⠉⠛⠖⠦⠹⣄⢠⣽⣆ ┃',
    '┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛',
    '',
    '',
}

db.custom_center = {
    { icon = '  ', desc = 'New File                        ', shortcut = 'SPC n f', action = 'DashboardNewFile', },
    { icon = '  ', desc = 'Bookmarks                       ', shortcut = 'SPC f b', action = 'Telescope marks', },
    { icon = '  ', desc = 'Browse Files                    ', shortcut = 'SPC f f', action = 'Telescope find_files', },
    { icon = '  ', desc = 'Recent Files                    ', shortcut = 'SPC f r', action = 'Telescope oldfiles', },
    { icon = '  ', desc = 'Find Word                       ', shortcut = 'SPC f w', action = 'Telescope live_grep', },
}

db.custom_footer = {
    '',
    '[ neovim ]',
}

set_hl(0, "DashboardShortcut",   { fg = colors.blue   })
set_hl(0, "DashboardCenterIcon", { fg = colors.green  })
set_hl(0, "DashboardCenter",     { fg = colors.green  })
set_hl(0, "DashboardHeader",     { fg = colors.yellow })
set_hl(0, "DashboardFooter",     { fg = colors.red    })
