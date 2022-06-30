if ValueSearch_lua then
    menu.notify('ValueSearch.lua already loaded.')
    return
end

local numberResults = {}
local stringResults = {}

local numberValues = {51796432, 60149385, 265489073, 21039768, 26589743, 1906354, 91304675}
local numbers = menu.add_feature('Number Value Search', 'parent')
local numbersearch = menu.add_feature('Value Search: ', 'action_value_str', numbers.id, function(f)
    local code, value = input.get('Enter Search Value', '', 10, 3)

    while code == 1 do
        coroutine.yield(0)
        code, value = input.get('Enter Search Value', '', 10, 3)
    end

    if code == 2 then
        menu.notify('Input canceled.')
        return
    end

    if #numberResults > 0 then
        for i = 1, #numberResults do
            menu.delete_feature(numberResults[i].id)
            numberResults[i] = nil
        end
    end

    for i = 1, #numberValues do
        if string.find(numberValues[i], value, 1) then
            numberResults[#numberResults + 1] = menu.add_feature(numberValues[i], 'action', numbers.id, function()
                menu.notify(numberValues[i])
                print(numberValues[i])
            end)
        end
    end

    menu.notify(#numberResults .. ' results')

    f:set_str_data({value})
end)
numbersearch:set_str_data({' '})

menu.add_feature('Clear Search', 'action', numbers.id, function(f)
    if #numberResults > 0 then
        for i = 1, #numberResults do
            menu.delete_feature(numberResults[i].id)
            numberResults[i] = nil
        end
        for i = 1, #numberValues do
            numberResults[#numberResults + 1] = menu.add_feature(numberValues[i], 'action', numbers.id, function()
                menu.notify(numberValues[i])
                print(numberValues[i])
            end)
        end
        menu.notify('Search cleared.')
    else
        menu.notify('No results found.')
    end
    numbersearch:set_str_data({' '})
end)


local stringValues = {'Spaghetti', 'Meatballs', 'Sauce', 'Cupcakes', 'Chocolate', 'Vanilla', 'Cheese'}
local strings = menu.add_feature('String Value Search', 'parent')
local stringsearch = menu.add_feature('Value Search: ', 'action_value_str', strings.id, function(f)
    local code, value = input.get('Enter Search Value', '', 10, 1)

    while code == 1 do
        coroutine.yield(0)
        code, value = input.get('Enter Search Value', '', 10, 1)
    end

    if code == 2 then
        menu.notify('Input canceled.')
        return
    end

    if #stringResults > 0 then
        for i = 1, #stringResults do
            menu.delete_feature(stringResults[i].id)
            stringResults[i] = nil
        end
    end

    for i = 1, #stringValues do
        if string.find(stringValues[i], value, 1) then
            stringResults[#stringResults + 1] = menu.add_feature(stringValues[i], 'action', strings.id, function()
                menu.notify(stringValues[i])
                print(stringValues[i])
            end)
        end
    end

    menu.notify(#stringResults .. ' results')

    local spaces = ' '
    for i = 1, (75 - string.len(value)) do
        spaces = spaces .. ' '
    end

    f:set_str_data({value})
end)
stringsearch:set_str_data({' '})

menu.add_feature('Clear Search', 'action', strings.id, function(f)
    if #stringResults > 0 then
        for i = 1, #stringResults do
            menu.delete_feature(stringResults[i].id)
            stringResults[i] = nil
        end
        for i = 1, #stringValues do
            stringResults[#stringResults + 1] = menu.add_feature(stringValues[i], 'action', strings.id, function()
                menu.notify(stringValues[i])
                print(stringValues[i])
            end)
        end
        menu.notify('Search cleared.')
    else
        menu.notify('No results found.')
    end
    stringsearch:set_str_data({' '})
end)

for i = 1, #numberValues do
    numberResults[#numberResults + 1] = menu.add_feature(numberValues[i], 'action', numbers.id, function()
        menu.notify(numberValues[i])
        print(numberValues[i])
    end)
end

for i = 1, #stringValues do
    stringResults[#stringResults + 1] = menu.add_feature(stringValues[i], 'action', strings.id, function()
        menu.notify(stringValues[i])
        print(stringValues[i])
    end)
end

ValueSearch_lua = true