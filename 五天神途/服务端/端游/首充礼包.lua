local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")  --���ؽ��沼��

lualib:SetFormAllowFunc({"ButtonFirstLingQu","show_first_bill_gift_main"})

local zhongzhidu = 50 --��ֵ���ٸ��׳�


--�׳佱������Ʒ�󶨵��߱��--��ʽΪ��ƷKeyName,��Ʒ����,��Ʒ�󶨻��߲���

local item_gift_table =
{
    {
        {"�׳�ƽ�׹�",1,1},
        {"δ�����ķ���",60,1},
        {"��������",1,1},
        {"����֮��",1,1},
        {"����ʱװ(��)",1,1},
    }
}

-------------------------------------------------------------------------

--��ȡ�ճ�����(����Ͷ��)
function GetPlayerDayDB(player)
    local id = tostring(lualib:UserID(player))
    local user_id = lualib:UserID(player)
    local job = lualib:Job(player)
    local gender = lualib:Gender(player)
    if gender == 1 then
        item_gift_table[1][5][1] = "����ʱװ(��)"
    else
        item_gift_table[1][5][1] = "����ʱװ(Ů)"
    end
    --����Ԫ����
    local new_table = {}
    local all_table=item_gift_table[job]
    new_table["all_cz"] = math.floor((lualib:GetTotalBill(player)/100) + lualib:GetDBNum("ljczje"..user_id))
    new_table["all_ds_num"]	= zhongzhidu		--�ۼƳ�ֵ��ȡ����
    --��ȡ���������
    lualib:ShowFormWithContent(player,"form�ļ���","���׳����#"..serialize(all_table).."#"..serialize(new_table))

    return ""
end

---------ͼ����ʾ---------
function first_bill_gift_xianshi(player)--���׳����
    local id = tostring(lualib:UserID(player))
    local all_count = lualib:GetDBNum(id.."|first_cz_num1")
    if all_count  < 1 then
        if lualib:GetClientType(player) == 0 then
            AddSEIcon(player,1, -2, "���׳������", 1906100005, "���׳������", "show_first_bill_gift_main", "�׳����", "�׳����!")
        end
    end
    return ""
end

function guanbi_xianshi(player)
    DelIcon(player,"���׳������")
end
-------------------ͼ�걻���-----------------------
function show_first_bill_gift_main(player)
    GetPlayerDayDB(player)
    return ""

end
---------------------
function close(player)
    return ""
end

--�ͻ��˵��ã��ճ��콱
--��ֵ���laye�ύ
function ButtonFirstLingQu(player,param)
    local id = tostring(lualib:UserID(player))
    local user_id = lualib:UserID(player)
    local job = lualib:Job(player)
    local all_yuanbao = (lualib:GetTotalBill(player)/100)  + lualib:GetDBNum("ljczje"..user_id)
    local all_count = lualib:GetDBNum(id.."|first_cz_num1")	--�״γ�ֵ��ȡ����
    local gender = lualib:Gender(player)
    if gender == 1 then
        item_gift_table[1][5][1] = "����ʱװ(��)"
    else
        item_gift_table[1][5][1] = "����ʱװ(Ů)"
    end
    if all_yuanbao < zhongzhidu  then
        lualib:MsgBox(player, "��ĳ�ֵ����"..zhongzhidu.."Ԫ��������ȡ���׳��������ǰ��������ֵ!")
        return ""
    end
    if all_count > 0 then
        lualib:MsgBox(player, "���Ѿ���ȡ���׳������!")
        return ""
    end

    if lualib:BagFree(player,true,false,false) < 6 then
        lualib:MsgBox(player, "�����ռ䲻����������ȡ,������6�����ϵı����ٽ�����ȡ��")
        return ""
    end



    local lq_item = nil
    local lq_item = item_gift_table[job]

    if lq_item ~= nil then

        lualib:SetDBNumEx(id.."|first_cz_num1",1,2)
        for i=1,(#lq_item) do
            lualib:AddSingleItem(player, lq_item[i][1], lq_item[i][2], lq_item[i][3], "�״γ�ֵ����Ʒ", "�״����")

        end
        lualib:SysPromptMsg(player, "��ȡ "..zhongzhidu.." �״γ�ֵ����ɹ���" )
        guanbi_xianshi(player)

    else
        lualib:NPCTalk(player,"�Ƿ����������Ѿ�����¼�ڰ���")
        lualib:Error(lualib:Name(player).."�Ƿ����������ȡ����¼�ڰ���")
    end
    return ""
end
