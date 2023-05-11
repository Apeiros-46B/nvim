-- configuration for nvim-web-devicons plugin
return function(theme)
    -- {{{ imports
    local colors   = theme.colors
    local devicons = require('nvim-web-devicons')
    -- }}}

    -- {{{ setup
    devicons.setup({
        color_icons = true,
        default = true,
    })
    -- }}}

    -- {{{ set icons
    -- default
    devicons.set_default_icon('󰈙', colors.white)

    -- overrides
    local function media(type, name)
        local icon

        if type == 'image' then
            icon = ''
        elseif type == 'audio' then
            icon = '󰎈'
        elseif type == 'video' then
            icon = '󰟞'
        end

        return {
            icon = icon,
            color = colors.purple,
            cterm_color = '5',
            name = name,
        }
    end

    devicons.set_icon({
        -- {{{ plain-text documents/markup langs
        txt = {
            icon = '',
            color = colors.blue,
            cterm_color = '4',
            name = 'Text',
        },
        md = {
            icon = '',
            color = colors.purple,
            cterm_color = '5',
            name = 'Markdown',
        },
        norg = {
            icon = '',
            color = colors.red,
            cterm_color = '1',
            name = 'Norg',
        },
        xml = {
            icon = '',
            color = colors.orange,
            cterm_color = '208',
            name = 'XML',
        },
        -- }}}

        -- {{{ other documents
        pdf = {
            icon = '󰈦',
            color = colors.red,
            cterm_color = '1',
            name = 'PDF'
        },
        xls = {
            icon = '󰈛',
            color = colors.green,
            cterm_color = '2',
            name = 'ExcelLegacy',
        },
        xlsx = {
            icon = '󰈛',
            color = colors.green,
            cterm_color = '2',
            name = 'Excel',
        },
        -- }}}

        -- {{{ media
        png  = media('image', 'PNG'),
        jpg  = media('image', 'JPG'),
        jpeg = media('image', 'JPEG'),
        tif  = media('image', 'TIF'),
        tiff = media('image', 'TIFF'),
        webp = media('image', 'WebP'),
        gif  = media('image', 'GIF'),
        psd  = media('image', 'PSD'),
        xcf  = media('image', 'XCF'),

        mp3  = media('audio', 'MP3'),
        wav  = media('audio', 'WAV'),
        flac = media('audio', 'FLAC'),

        mp4  = media('video', 'MP4'),
        mov  = media('video', 'MOV'),
        webm = media('video', 'WebM'),
        -- }}}

        -- {{{ other files
        zip = {
            icon = '󰀼',
            color = colors.red,
            cterm_color = '1',
            name = 'Zip',
        },
        -- }}}
    })
    -- }}}
end
