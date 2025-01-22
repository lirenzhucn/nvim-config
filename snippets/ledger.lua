local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt

--- @class DivNodesResult
--- @field nodes any[]
--- @field jump_index_offset integer

--- Generate nodes for one ticker's dividend reinvest snippet
--- @param ticker string The ticker
--- @param lot string A string representing the lot of the reinvestment purchase
--- @param start_jump_index integer The starting jump index for this segment of nodes
--- @return DivNodesResult
local generate_div_nodes_for_ticker = function(ticker, lot, start_jump_index)
  return {
    nodes = fmt(
      [[
    div:{ticker_lower}              $-{amount}
    base:{ticker_lower}:{lot}    {quantity} {ticker_repeat} @@ ${amount_repeat}
]],
      {
        ticker_lower = t(vim.trim(string.lower(ticker))),
        amount = i(start_jump_index),
        lot = t(lot),
        quantity = i(start_jump_index + 1),
        ticker_repeat = t(ticker),
        amount_repeat = f(function(args)
          return vim.trim(args[1][1])
        end, { start_jump_index }),
      },
      { dedent = false }
    ),
    jump_index_offset = 2,
  }
end

--- Generate a SnippetNode for a list of tickers' dividend reinvest snippet
--- @param tickers string[] A list of tickers in a table
--- @param lot string A string representing the lot of the reinvestment purchase
local generate_div_nodes = function(tickers, lot)
  local nodes = {}
  local curr_jump_index = 1
  for _, ticker in ipairs(tickers) do
    ticker = vim.trim(ticker)
    if ticker ~= '' then
      local res = generate_div_nodes_for_ticker(ticker, lot, curr_jump_index)
      curr_jump_index = curr_jump_index + res.jump_index_offset
      table.move(res.nodes, 1, #res.nodes, #nodes + 1, nodes)
      -- insert a new line at the end of each segment
      table.insert(nodes, t { '', '' })
    end
  end
  return sn(nil, nodes)
end

return {
  s(
    { trig = 'rediv' },
    fmt(
      [[
{year}-{month}-{day} * Reinvest {ticker} Dividend
{div_pair}
{exit}]],
      {
        year = i(1, os.date '%Y'),
        month = i(2, os.date '%m'),
        day = i(3, os.date '%d'),
        ticker = i(4),
        div_pair = d(5, function(args)
          local lot = vim.trim(args[1][1]) .. vim.trim(args[2][1]) .. vim.trim(args[3][1])
          local tickers_string = vim.trim(args[4][1])
          local tickers = vim.split(tickers_string, ',')
          return generate_div_nodes(tickers, lot)
        end, { 1, 2, 3, 4 }),
        exit = i(0),
      }
    )
  ),
}
