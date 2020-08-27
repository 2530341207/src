local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")
local sanrenfuli_tbl = {----��������  Ԫ������
	--ʥսϵ��
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},500,500},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},2500,1000},
	{"����ս��",1,{},10000,3000},
	{"����ս��",1,{},10000,3000},
	{"����ս��",1,{},10000,3000},
	{"����ս��",1,{},10000,3000},
	{"����ս��",1,{},10000,3000},
	{"����ս��",1,{},20000,5000},
}

local sanrenjiesao = [[
#OFFSET##COLOR#�ױ�������#COLOR#��һ����ȡ����װ��������Զ���ö�Ӧ������
#OFFSET##COLOR#��ʱ�ױ���#COLOR#ʱ������Ϊ����72Сʱ�ڣ�ɢ�˸�����
]]

-----------------------ͼ����ʾ-----------------------------

function main(player)
	for i = 1,#sanrenfuli_tbl do
		sanrenfuli_tbl[i][6] = lualib:GetDBStr("�ױ�BOSS"..i)
	end
	local strStartServerTime = lualib:GetConstVar("StartServerTime")
	local dwStarServerTime =  lualib:Str2Time(strStartServerTime) + 100000000
	local dwCurTimes = lualib:GetAllTime()

	lualib:ShowFormWithContent(player, "�ű���", "daojishitime="..(dwStarServerTime - dwCurTimes))
	lualib:ShowFormWithContent(player, "�ű���", "sanrenjiesao="..string.format("%q", sanrenjiesao))
	lualib:ShowFormWithContent(player, "�ű���", "sanrenfuli_tbl="..serialize(sanrenfuli_tbl))
	lualib:ShowFormWithContent(player,"form�ļ���","�ױ�����")
	return ""
end

function firstDrop(player,item,item_id,keyname)
	local strStartServerTime = lualib:GetConstVar("StartServerTime");
	local dwStarServerTime =  lualib:Str2Time(strStartServerTime) + 100000000;
	local dwCurTimes = lualib:GetAllTime()
	local id = 0
	if dwCurTimes > dwStarServerTime then
		lualib:MsgBox(player,"�һ�ʧ�ܣ��һ�ʱ��Ϊ����(24Сʱ)�ڣ�")
		return ""
	end
	for k,v in pairs(sanrenfuli_tbl) do
		lualib:SysMsg_SendBroadcastMsg(tostring(v[1]).."||"..tostring(keyname),"�ױ�")
		if lualib:KeyName(item) == v[1] then
			id = k
			break
		end
	end

	lualib:SysMsg_SendBroadcastMsg(tostring(id),"�ױ�")

	if id == 0 then
		return ""
	end
	if lualib:GetDBStr("�ױ�BOSS"..id) ~= "" then
		return ""
	end

	local item_tbl = {}
	local djs = ""
	for i = 1,#sanrenfuli_tbl[id][3]  do
		lualib:AddItem(player,sanrenfuli_tbl[id][3][i][1],sanrenfuli_tbl[id][3][i][2],false,"�ױ�����","")
		if djs == "" then
			djs = djs..lualib:KeyName2Name(sanrenfuli_tbl[id][3][i][1],4).."��"..sanrenfuli_tbl[id][3][i][2]
		else
			djs = djs.." "..lualib:KeyName2Name(sanrenfuli_tbl[id][3][i][1],4).."��"..sanrenfuli_tbl[id][3][i][2]
		end
	end


	lualib:AddIngot(player,sanrenfuli_tbl[id][4],"�ױ�����","")
	lualib:MsgBox(player,"�һ�ʧ�ܣ��һ�ʱ��Ϊ����(24Сʱ)�ڣ�")
	lualib:SetDBStr("�ױ�BOSS"..id,lualib:Name(player))
	lualib:SetInt(item,"��ȡ����",1)
	for i = 1,3 do
		lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_BROWN#��ϲ���#COLORCOLOR_BLUE#["..lualib:Name(player).."]#COLORCOLOR_BROWN#�����ʱ�ױ�����[#COLORCOLOR_GOLD2#"..sanrenfuli_tbl[id][4].."Ԫ��"..djs.."]#COLORCOLOR_BROWN#����������������","",1,12)
	end
	return ""
end

