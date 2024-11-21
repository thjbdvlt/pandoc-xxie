-- pandoc-xxie
-- ===========
--
-- smallcaps for centuries written with latin numeric.
--
-- xxi^e^ -> [xii]{.smallcaps}^e^
--
-- Copyright 2024 thjbdvlt (MIT license)

function smallcapitalize(inlines)
    local elem
    local prev
    local s
    local sup
    for i=1, #inlines do
        elem = inlines[i]
        -- only on elements Str
        if elem.t == 'Superscript' then
            sup = elem.c[1].text
            if sup ~= nil and string.find(sup, '^e$') then
                prev = inlines[i-1]
                s = prev.text
                if prev.t == 'Str'
                    and s ~= nil
                    and string.find(s, '^[xvi]+$')
                    then
                        inlines[i-1] = pandoc.SmallCaps(s)
                end
            end
        end
    end
    return inlines
end

return {Inlines = smallcapitalize}
