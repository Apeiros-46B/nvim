local db = require('dashboard')

db.hide_statusline = false
db.hide_tabline = false

db.custom_header = {
    -- '',
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
	{ icon = '  ', desc = 'Browse Files                     ', action = 'Telescope find_files', },
	{ icon = '  ', desc = 'Recent Files                     ', action = 'Telescope oldfiles', },
	{ icon = '  ', desc = 'Find Word                        ', action = 'Telescope live_grep', },
	{ icon = '  ', desc = 'New File                         ', action = 'DashboardNewFile', },
	{ icon = '  ', desc = 'Bookmarks                        ', action = 'Telescope marks', },
}

db.custom_footer = {
    '',
	'[ neovim ]',
}
