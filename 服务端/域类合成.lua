local clothes_t = {--�·����ϱ���д�ڵ�����λ�ã���Ҫ�Ķ�
    {
        {
            {
                { "ս������", 10 },
                { "ʥս��ָ", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ͭ���ָ",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "ս������", 10 },
                { "ʥս����", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ͭ������",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "ս������", 10 },
                { "ʥս����", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ͭ������",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "ս������", 10 },
                { "ʥսͷ��", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ͭ��ͷ��",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
    },
    {
        {
            {
                { "��������", 10 },
                { "�����ָ", 1 },
                { "����װ��", 1 }
            },
            10000,
            "�����ָ",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "��������", 10 },
                { "��������", 1 },
                { "����װ��", 1 }
            },
            10000,
            "��������",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "��������", 10 },
                { "��������", 1 },
                { "����װ��", 1 }
            },
            10000,
            "��������",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "��������", 10 },
                { "����ͷ��", 1 },
                { "����װ��", 1 }
            },
            10000,
            "����ͷ��",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
    },
    {
        {
            {
                { "��������", 10 },
                { "�����ָ", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ˮ���ָ",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "��������", 10 },
                { "��������", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ˮ������",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "��������", 10 },
                { "��������", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ˮ������",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
        {
            {
                { "��������", 10 },
                { "����ͷ��", 1 },
                { "����װ��", 1 }
            },
            10000,
            "ˮ��ͷ��",
            10
        }, --{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
    }
}



local tab = {
    ["����װ��"] = {"ʥ����"},--����װ����Ҫ�ӽ���

}

function main(npc, player)
    local msg = [[
\n  �����ˣ������ˣ����²����ˣ�ǧ���ȥ�ˣ�һЩ����߶�װ�����ط����������ˣ�������̨�����ˣ�

  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes#1 *01*�ϳ�ͭ��>
  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes#2 *01*�ϳ�����>
  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes#3 *01*�ϳ�ˮ��>
  #OFFSET<X:2,Y:5>##IMAGE1902700034# #OFFSET<Y:-1>#<@leave *01*�뿪>
]]
    lualib:SetPanelSize(npc, 420, 188)
    return msg
end

function hcclothes(npc, player,num)
    local num = tonumber(num)
    local msg = [[
\n  ���ã���ѡ����Ҫ�ϳɵ�װ�������ĵ������ӿ�ͨ���ֽ����װ���á�

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#1 *01*]]..clothes_t[num][1][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#2 *01*]]..clothes_t[num][2][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#3 *01*]]..clothes_t[num][3][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#4 *01*]]..clothes_t[num][4][3]..[[>
]]
    lualib:SetPanelSize(npc, 420, 200)
    return msg
end


function hcontent(npc, player,num, idx)
    local num = tonumber(num)
    local idx = tonumber(idx)

    lualib:SetPanelSize(npc, 420, 220)
    local msg = "\n  �ϳɡ�"..lualib:KeyName2Name(clothes_t[num][idx][3],4).."����Ҫ����������\n\n"
    msg = msg.. "  ����װ����"..lualib:KeyName2Name(clothes_t[num][idx][1][2][1],4).."��"..clothes_t[num][idx][1][3][2].."\n"
    msg = msg.. "  ������ϣ���Ӧְҵ�����ӡ�10\n"
    msg = msg.. "  ����������ʥ�����1������ͷĿ���䣩\n"
    msg = msg.. "  �ɹ����ʣ�10%��10�αسɣ����߼��ϳɼ���100%,������15��Ԫ��\n"
    msg = msg.. "  ��ܰ��ʾ��ʧ�ܺ�ֻ��������װ�����������Ͽ۳�\n\n"
    msg = msg.. "  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..num.."#"..idx.."#1 *01*�߼��ϳ�>"
    msg = msg.. "  #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..num.."#"..idx.."#2 *01*10000Ԫ���ϳ�>\n"
    return msg
end


function hcclothesex(npc, player, num ,idx, types)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local num = tonumber(num)
    local ingot = clothes_t[num][idx][2]
    local target = clothes_t[num][idx][3]
    if lualib:GetBagFree(player) <= 0 then
        return "�����ռ䲻��һ��"
    end
    if types == "2" then
        if lualib:GetIngot(player) < ingot then
            return "\n  ��Ǹ������Ԫ������"..ingot.."��\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
        end
    end
    if types == "1" then
        if lualib:GetIngot(player) < 250000 then
            return "\n  ��Ǹ������Ԫ������150000��\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
        end
    end

    for k, v in ipairs(clothes_t[num][idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) >= v[2] then
                    ttt = m
                    break
                end
            end
            if ttt == "" then
                return "\n  ��Ǹ��������"..v[1].."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*������ҳ>"
            end
        else
            if lualib:ItemCount(player, v[1]) < v[2] then
                return "\n  ��Ǹ��������"..lualib:KeyName2Name(v[1],4).."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*������ҳ>"
            end
        end
    end

    local fail = lualib:GenRandom(1, 100) > clothes_t[num][idx][4]
    --lualib:SysMsg_SendBroadcastMsg(tostring(fail), "dijia")

    if types == "1" then
        fail = false
    end
    if lualib:GetInt(player,"caifeng") == 15 then
        fail = false
    end

    for k, v in ipairs(clothes_t[num][idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) > 0 then
                    ttt = m
                    break
                end
            end
            if ttt ~= "" then
                if not lualib:DelItem(player, ttt, v[2], 2, "ɾ��:��������", npc) then
                    return "\n  ��Ǹ��������"..v[1].."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*������ҳ>"
                end
            end
        else
            if fail and types == "2" and k == 3 then

            else
                if not lualib:DelItem(player, v[1], v[2], 2, "ɾ��:��������", npc) then
                    return "\n  ��Ǹ��������"..lualib:KeyName2Name(v[1],4).."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*������ҳ>"
                end
            end
        end
    end

    if types == "2" then
        if not lualib:SubIngot(player, ingot, "��Ԫ�����·��ϳ�", npc) then
            return "ʧ�ܣ�ϵͳ����"
        end
    end
    if types == "1" then
        if not lualib:SubIngot(player, 150000, "��Ԫ�����·��ϳ�", npc) then
            return "ʧ�ܣ�ϵͳ����"
        end
    end
    if fail then
        lualib:SetInt(player,"caifeng",lualib:GetInt(player,"caifeng")+1)
        return "\n ���ź������κϳ����·�ʧ���ˡ�"
    end

    lualib:AddItem(player, target, 1, false, "����Ʒ����������", npc)

    local msg = "��ϲ��ҡ�"..lualib:Name(player).."���ɹ��ϳɡ�"..lualib:KeyName2Name(target,4).."������ʵ��Ʒ�����ˡ�"
    lualib:SetInt(player,"caifeng",0)
    lualib:SysMsg_SendBroadcastMsg(msg, "ϵͳ")

    return "\n  ��ϲ���ɹ��ϳ�"..lualib:KeyName2Name(target, 4).."��\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*������ҳ>"
end


function leave(npc, player)
    return ""
end