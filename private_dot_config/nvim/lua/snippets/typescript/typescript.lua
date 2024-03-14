-- luasnip
local ls = require('luasnip')
local extras = require('luasnip.extras')
local fmt = require('luasnip.extras.fmt').fmt
local rep = extras.rep

-- lib
local get_filename_without_ext =
  require('snippets.lib.get_filename_without_ext')

local consoleLog = ls.snippet('clg', {
  ls.text_node('console.log('),
  ls.insert_node(1),
  ls.text_node(')'),
})

local interfaceSnippet = ls.snippet(
  'i',
  fmt(
    [[
interface {} {{
  {}
}}
]],
    {
      ls.insert_node(1, 'InterfaceName'), -- Placeholder for interface name
      ls.insert_node(2), -- Placeholder for interface body
    }
  )
)

local importFrom = ls.snippet(
  'im',
  fmt("import {{{}}} from '{}'", {
    ls.insert_node(2), -- Placeholder for the module name
    ls.insert_node(1), -- Placeholder for the module path
  })
)

local exportFrom = ls.snippet(
  'ex',
  fmt("export {{{}}} from '{}'", {
    ls.insert_node(2), -- Placeholder for the module name
    ls.insert_node(1), -- Placeholder for the module path
  })
)

local exportAll = ls.snippet(
  'ea',
  fmt("export * from '{}'", {
    ls.insert_node(1), -- Placeholder for the module path
  })
)

local exportInterface = ls.snippet(
  'ei',
  fmt(
    [[
export interface {} {{
  {}
}}
]],
    {
      ls.insert_node(1, 'InterfaceName'), -- Placeholder for interface name
      ls.insert_node(2), -- Placeholder for interface body
    }
  )
)

local exportConst = ls.snippet(
  'ec',
  fmt('export const {} = {}', {
    ls.insert_node(1), -- Placeholder for the constant name
    ls.insert_node(2), -- Placeholder for the value
  })
)

local toggleFeatureComponent = ls.snippet(
  'tfc',
  fmt(
    [[
<ToggleFeature name='{}' on={{{}}} off={{{}}} />
    ]],
    {
      ls.insert_node(1, 'featureName'), -- Placeholder for feature name
      ls.insert_node(2), -- Placeholder for 'on' prop
      ls.insert_node(3), -- Placeholder for 'off' prop
    }
  )
)

local toggleFeatureFunction = ls.snippet(
  'tff',
  fmt(
    [[
toggleFeature({{ name: {}, on: {}, off: {} }})
]],
    {
      ls.insert_node(1, "'featureName'"), -- Placeholder for feature name
      ls.insert_node(2, '() => '), -- Placeholder for 'on' function
      ls.insert_node(3, '() => '), -- Placeholder for 'off' function
    }
  )
)

ls.add_snippets('typescriptreact', {
  consoleLog,
  ls.snippet('co', {
    ls.dynamic_node(function()
      local register_data = vim.fn.getreg() .. ''
      if string.match(register_data, '[%d-]+,%s*[%d-]+') then
        return ls.snippet_node(nil, {
          ls.text_node('position([' .. register_data .. '])'),
        })
      end
    end),
  }),
  interfaceSnippet,
  exportInterface,
  toggleFeatureComponent,
  toggleFeatureFunction,
  importFrom,
  exportFrom,
  exportAll,
  exportConst,
})

ls.add_snippets('typescript', {
  consoleLog,
  interfaceSnippet,
  exportInterface,
  toggleFeatureComponent,
  toggleFeatureFunction,
  importFrom,
  exportFrom,
  exportAll,
  exportConst,
})
