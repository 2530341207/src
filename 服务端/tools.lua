function removeRepeated(a)                          --table???(a?????????table)
    for k,v in pairs(a) do
        local count=0
        for j in pairs(a)do count=count+1 end
        for i=k+1,count do
            if v==a[i] then
                table.remove(a,i)
            end
        end
    end
end

function insertTable(table1,table2)                              --??2??table????1??table??table2???{k1,v1,k2,v2...}??
    local y = {}
    for i = 1,(#table2)/2 do
        table.insert(y,table2[(i-1)*2 + 1])
        y.table2[(i-1)*2 + 1] = table2[2*i]
    end
    table.insert(table1,y)
end

