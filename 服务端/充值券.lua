local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("form/�����а�")
local chongzhi = {
    ["��ֵ��10Ԫ"] = 1000,
    ["��ֵ��50Ԫ"] = 5000,
    ["��ֵ��100Ԫ"] = 10000,

}
function main(player,item)
    local player_name = lualib:Name(player)
    local key = lualib:KeyName(item)
    local id = lualib:UserID(player)				--ȡ����ҵ��ʺ�ID.
    lualib:SetDBNum("define_bill"..id,lualib:GetDBNum("define_bill"..id)+chongzhi[key])
    lualib:SysMsg_SendWarnMsg(player, "���ֵ��"..chongzhi[key].."Ԫ��")
    lualib:SysMsg_SendBroadcastColor("��ϲ��ҡ�"..player_name.."�����߳�ֵ���" .. chongzhi[key] ..  "Ԫ��","[��ֵ��ʾ]", 2, 11)
    lualib:Player_AddIngot(player, chongzhi[key], false, "��Ԫ����ʹ��Ԫ������", player)
    Creat_tage_blee(player)
    lualib:DelayCall(player, 1, "������:chongzhi_paihang", "")
    return true
end
