local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end

local sources = cmp_status_ok.get_config().sources
for i = #sources, 1, -1 do
    if sources[i].name == 'Snippet' then
        table.remove(sources, i)
    end
end

cmp.setup.buffer({ sources = sources })
