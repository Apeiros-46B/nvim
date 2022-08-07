local neorg = require('neorg')

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    school = "~/notes/school",
                    home   = "~/notes/home",
                }
            }
        }
    }
})
