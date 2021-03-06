local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")
local sanrenfuli_tbl = {----道具名称  元宝数量
	--圣战系列
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},500,500},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},2500,1000},
	{"完美战刃",1,{},10000,3000},
	{"完美战刃",1,{},10000,3000},
	{"完美战刃",1,{},10000,3000},
	{"完美战刃",1,{},10000,3000},
	{"完美战刃",1,{},10000,3000},
	{"完美战刃",1,{},20000,5000},
}

local sanrenjiesao = [[
#OFFSET##COLOR#首爆奖励：#COLOR#第一个捡取以上装备的玩家自动获得对应奖励！
#OFFSET##COLOR#限时首爆：#COLOR#时间限制为开区72小时内，散人福利！
]]

-----------------------图标显示-----------------------------

function main(player)
	for i = 1,#sanrenfuli_tbl do
		sanrenfuli_tbl[i][6] = lualib:GetDBStr("首爆BOSS"..i)
	end
	local strStartServerTime = lualib:GetConstVar("StartServerTime")
	local dwStarServerTime =  lualib:Str2Time(strStartServerTime) + 100000000
	local dwCurTimes = lualib:GetAllTime()

	lualib:ShowFormWithContent(player, "脚本表单", "daojishitime="..(dwStarServerTime - dwCurTimes))
	lualib:ShowFormWithContent(player, "脚本表单", "sanrenjiesao="..string.format("%q", sanrenjiesao))
	lualib:ShowFormWithContent(player, "脚本表单", "sanrenfuli_tbl="..serialize(sanrenfuli_tbl))
	lualib:ShowFormWithContent(player,"form文件表单","首爆奖励")
	return ""
end

function firstDrop(player,item,item_id,keyname)
	local strStartServerTime = lualib:GetConstVar("StartServerTime");
	local dwStarServerTime =  lualib:Str2Time(strStartServerTime) + 100000000;
	local dwCurTimes = lualib:GetAllTime()
	local id = 0
	if dwCurTimes > dwStarServerTime then
		lualib:MsgBox(player,"兑换失败，兑换时间为新区(24小时)内！")
		return ""
	end
	for k,v in pairs(sanrenfuli_tbl) do
		lualib:SysMsg_SendBroadcastMsg(tostring(v[1]).."||"..tostring(keyname),"首爆")
		if lualib:KeyName(item) == v[1] then
			id = k
			break
		end
	end

	lualib:SysMsg_SendBroadcastMsg(tostring(id),"首爆")

	if id == 0 then
		return ""
	end
	if lualib:GetDBStr("首爆BOSS"..id) ~= "" then
		return ""
	end

	local item_tbl = {}
	local djs = ""
	for i = 1,#sanrenfuli_tbl[id][3]  do
		lualib:AddItem(player,sanrenfuli_tbl[id][3][i][1],sanrenfuli_tbl[id][3][i][2],false,"首爆奖励","")
		if djs == "" then
			djs = djs..lualib:KeyName2Name(sanrenfuli_tbl[id][3][i][1],4).."×"..sanrenfuli_tbl[id][3][i][2]
		else
			djs = djs.." "..lualib:KeyName2Name(sanrenfuli_tbl[id][3][i][1],4).."×"..sanrenfuli_tbl[id][3][i][2]
		end
	end


	lualib:AddIngot(player,sanrenfuli_tbl[id][4],"首爆奖励","")
	lualib:MsgBox(player,"兑换失败，兑换时间为新区(24小时)内！")
	lualib:SetDBStr("首爆BOSS"..id,lualib:Name(player))
	lualib:SetInt(item,"领取奖励",1)
	for i = 1,3 do
		lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_BROWN#恭喜玩家#COLORCOLOR_BLUE#["..lualib:Name(player).."]#COLORCOLOR_BROWN#获得限时首爆奖励[#COLORCOLOR_GOLD2#"..sanrenfuli_tbl[id][4].."元宝"..djs.."]#COLORCOLOR_BROWN#！！！！！！！！","",1,12)
	end
	return ""
end

