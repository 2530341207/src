function insertTable(table1,table2)                             --��2��table����1��table��table2��ʽ{k1,v1,k2,v2...}��
    local y = {}
	local leng = #table/2
    for i = 1,leng do
		
        table.insert(y,table2[(i-1)*2 + 1])
        y.table2[(i-1)*2 + 1] = table2[2*i]
    end
    table.insert(table1,y)
end

local test2 ={
                {id=1, name="deng"},
                {id=9, name="luo"},
                {id=2, name="yang"},
                {id=8, name="ma"},
                {id=5, name="wu"},
}
	
local test1 = {
	"id",
	10,
	"name",
	"սʿ"
}

insertTable(test2,test1)

--table.sort(test2,function(a,b) return a.id<b.id end )

for i in pairs(test2) do
   print(test2[i].id,test2[i].name)
end

