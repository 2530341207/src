local clothes_t = {--�·����ϱ���д�ڵ�����λ�ã���Ҫ�Ķ�
    [1] = {{{"��������", 80}, {"����", 80}, {"����", 1}, {"����װ��", 1}}, 500000, "�Ž�����", 100},	--{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
    [2] = {{{"��������", 80}, {"����", 80}, {"����", 1}, {"����װ��", 1}}, 500000, "��Ѫ����", 100},
    [3] = {{{"��������", 80}, {"����", 80}, {"����", 1}, {"����װ��", 1}}, 500000, "��ڤ��ն", 100},
    [4] = {{{"��������", 80}, {"����", 80}, {"�Ȼ귨��", 1}, {"����װ��", 1}}, 500000, "���Ƿ���", 100},
    [5] = {{{"��������", 80}, {"����", 80}, {"�Ȼ귨��", 1}, {"����װ��", 1}}, 500000, "����Ȩ��", 100},
    [6] = {{{"��������", 80}, {"����", 80}, {"�Ȼ귨��", 1}, {"����װ��", 1}}, 500000, "����", 100},
    [7] = {{{"��������", 80}, {"����", 80}, {"�����ֻط�", 1}, {"����װ��", 1}}, 500000, "��ڤ����", 100},
    [8] = {{{"��������", 80}, {"����", 80}, {"�����ֻط�", 1}, {"����װ��", 1}}, 500000, "������", 100},
    [9] = {{{"��������", 80}, {"����", 80}, {"�����ֻط�", 1}, {"����װ��", 1}}, 500000, "��ȸ��", 100},
}

local clothes1_t = {--�·����ϱ���д�ڵ�����λ�ã���Ҫ�Ķ�
    [1] = {{{"��������", 80}, {"����", 80},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1}}, 500000, "�Ž�����", 100},	--{{����+����}....}+Ԫ��+Ŀ����Ʒ+�ɹ����ʰٷֱ�
    [2] = {{{"��������", 80}, {"����", 80},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1}}, 500000, "��Ѫ����", 100},
    [3] = {{{"��������", 80}, {"����", 80},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1},{"ʥ����",1}}, 500000, "��ڤ��ն", 100},
}

local tab = {
    ["����װ��"] = {"ͭ������", "ͭ������", "ͭ���ָ", "ͭ��ͷ��", "ˮ���ָ", "ˮ������", "ˮ������", "ˮ��ͷ��", "�����ָ", "��������", "����ͷ��", "��������"},--����װ����Ҫ�ӽ���
}


local huishou_t = {
    {"�þ�֮��", "����", 2, 6, 500000},--Ŀ����� + ���պ������� + ��������С + ����������(��С֮�����) + ���Ľ��
    {"���ƽ�", "����", 2, 6, 500000},
    {"����Ȩ��", "����", 2, 6, 500000},
    {"ŭն", "��������", 2, 6, 500000},
    {"����", "��������", 2, 6, 500000},
    {"��ң��", "��������", 2, 6, 500000},
}


function main(npc, player)
    local msg = [[
\n  ���ã����Ǹɽ������Īа��֪��ȥ���ˣ�Ӧ��ȥѰ�ұ���ȥ�ˣ��͹��Ƿ����Ұ�æ��

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishou *01*�ֽ�����>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hechengs *01*�ϳ�����>
  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes *01*�ϳ����>
  #OFFSET<X:2,Y:5>##IMAGE1902700034# #OFFSET<Y:-1>#<@leave *01*�뿪>
]]
    lualib:SetPanelSize(npc, 420, 188)
    return msg
end


function huishou(npc, player)
    local msg = [[
\n  ���ã���ѡ����Ҫ�ֽ����������������2-6������������������ÿ������  500000��ҡ�

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#1 *01*�ֽ�]]..huishou_t[1][1]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#2 *01*�ֽ�]]..huishou_t[2][1]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#3 *01*�ֽ�]]..huishou_t[3][1]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#4 *01*�ֽ�]]..huishou_t[4][1]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#5 *01*�ֽ�]]..huishou_t[5][1]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#6 *01*�ֽ�]]..huishou_t[6][1]..[[>
]]
    lualib:SetPanelSize(npc, 420, 188)
    return msg
end


function huishouex(npc, player, idx)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local count = lualib:ItemCount(player, huishou_t[idx][1])
    if count < 1 then
        return "\n  ��������û������Ҫ��������"
    end
    if lualib:GetGold(player) < count * huishou_t[idx][5] then
        return "\n  ���Ľ�Ҳ���".. count * huishou_t[idx][5] .."���޷��ֽ⡣"
    end
    local total = 0
    for i = 1, count do
        total = total + lualib:GenRandom(huishou_t[idx][3], huishou_t[idx][4])
    end
    if not lualib:DelItem(player, huishou_t[idx][1], count, 2, "�·��ֽ�", npc) then
        return "�۳�����ʧ�ܡ�"
    end
    if lualib:SubGold(player, count * huishou_t[idx][5], "�·��ֽ�", npc) == false then
        return "\n  �۳����ʧ�ܡ�"
    end
    lualib:AddItem(player, huishou_t[idx][2], total, false, "�·��ֽ�", npc)
    lualib:MsgBox(player, "��ϲ�����["..(total).."]��["..huishou_t[idx][2].."]��")
    return main(npc, player)
end

function hechengs(npc, player)
    local msg = [[
\n  ���ã���ѡ����Ҫ�ϳɵ����������ĵĲ��Ϲ������ϡ�й��������

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hecheng#1 *01*]]..clothes1_t[1][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hecheng#2 *01*]]..clothes1_t[2][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hecheng#3 *01*]]..clothes1_t[3][3]..[[>
]]
    lualib:SetPanelSize(npc, 420, 200)
    return msg
end

function hcclothes(npc, player)
    local msg = [[
\n  ���ã���ѡ����Ҫ�ϳɵ����������ĵ�����������������ͨ���ֽ��á�

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#1 *01*]]..clothes_t[1][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#2 *01*]]..clothes_t[2][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#3 *01*]]..clothes_t[3][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#4 *01*]]..clothes_t[4][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#5 *01*]]..clothes_t[5][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#6 *01*]]..clothes_t[6][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#7 *01*]]..clothes_t[7][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#8 *01*]]..clothes_t[8][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#9 *01*]]..clothes_t[9][3]..[[>
]]
    lualib:SetPanelSize(npc, 420, 200)
    return msg
end

function hecheng(npc, player, idx)
    local idx = tonumber(idx)
    lualib:SetPanelSize(npc, 420, 220)
    local msg = "\n  �ϳɡ�"..lualib:KeyName2Name(clothes1_t[idx][3],4).."����Ҫ����������\n\n"
    msg = msg.. "  ����װ����"..lualib:KeyName2Name(clothes1_t[idx][1][3][1],4).."��"..clothes1_t[idx][1][3][2].."\n"
    msg = msg.. "  ������ϣ�����ͼֽ1-4��\n"
    msg = msg.. "  ����������ʥս���Ρ�1��������������\n"
    msg = msg.. "  �ɹ����ʣ�100%\n"
    msg = msg.. "  ��ܰ��ʾ���ϳ�ʧ�����в�����ʧ��ʹ��Ԫ���ϳɱ�֤����������ʧ\n"
    msg = msg.. "  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hechengex#"..idx.."#1 *01*����ϳ�>       "
    -- msg = msg.. "  #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..idx.."#2 *01*10000Ԫ���ϳ�>\n"
    return msg
end


function hcontent(npc, player, idx)
    local idx = tonumber(idx)
    lualib:SetPanelSize(npc, 420, 220)
    local msg = "\n  �ϳɡ�"..lualib:KeyName2Name(clothes_t[idx][3],4).."����Ҫ����������\n\n"
    msg = msg.. "  ����װ����"..lualib:KeyName2Name(clothes_t[idx][1][3][1],4).."��"..clothes_t[idx][1][3][2].."\n"
    msg = msg.. "  ������ϣ�����������20��������80\n"
    msg = msg.. "  �����������������Ρ�1��������������\n"
    msg = msg.. "  �ɹ����ʣ�100%\n"
    msg = msg.. "  ��ܰ��ʾ���ϳ�ʧ�����в�����ʧ��ʹ��Ԫ���ϳɱ�֤����������ʧ\n"
    msg = msg.. "  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..idx.."#1 *01*����ϳ�>       "
    -- msg = msg.. "  #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..idx.."#2 *01*10000Ԫ���ϳ�>\n"
    return msg
end

function hechengex(npc, player, idx, types)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local ingot = clothes1_t[idx][2]
    local target = clothes1_t[idx][3]
    if lualib:GetBagFree(player) <= 0 then
        return "�����ռ䲻��һ��"
    end
    if types == "1" then
        if lualib:GetIngot(player) < ingot then
            return "\n  ��Ǹ������Ԫ������"..ingot.."��\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*������ҳ>"
        end
    end

    for k, v in ipairs(clothes1_t[idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) >= v[2] then
                    ttt = m
                    break
                end
            end
            if ttt == "" then
                return "\n  ��Ǹ��������"..v[1].."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*������ҳ>"
            end
        else
            if lualib:ItemCount(player, v[1]) < v[2] then
                return "\n  ��Ǹ��������"..lualib:KeyName2Name(v[1],4).."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*������ҳ>"
            end
        end
    end

    local fail = lualib:GenRandom(1, 100) > clothes1_t[idx][4]

    for k, v in ipairs(clothes1_t[idx][1]) do
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
                    return "\n  ��Ǹ��������"..v[1].."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*������ҳ>"
                end
            end
        else
            if fail and types == "1" and k == 3 then

            else
                if not lualib:DelItem(player, v[1], v[2], 2, "ɾ��:��������", npc) then
                    return "\n  ��Ǹ��������"..lualib:KeyName2Name(v[1],4).."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*������ҳ>"
                end
            end
        end
    end

    if types == "1" then
        if not lualib:SubIngot(player, ingot, "��Ԫ�����·��ϳ�", npc) then
            return "ʧ�ܣ�ϵͳ����"
        end
    end

    if fail then
        return "\n ���ź������κϳ��Ϲ����ʧ���ˡ�"
    end

    lualib:AddItem(player, target, 1, false, "����Ʒ����������", npc)

    local msg = "��ϲ��ҡ�"..lualib:Name(player).."���ɹ��ϳɡ�"..lualib:KeyName2Name(target,4).."������ʵ��Ʒ�����ˡ�"
    lualib:SysMsg_SendBroadcastMsg(msg, "ϵͳ")

    return "\n  ��ϲ���ɹ��ϳ�"..lualib:KeyName2Name(target, 4).."��\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*������ҳ>"
end

function hcclothesex(npc, player, idx, types)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local ingot = clothes_t[idx][2]
    local target = clothes_t[idx][3]
    if lualib:GetBagFree(player) <= 0 then
        return "�����ռ䲻��һ��"
    end
    if types == "1" then
        if lualib:GetIngot(player) < ingot then
            return "\n  ��Ǹ������Ԫ������"..ingot.."��\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
        end
    end

    for k, v in ipairs(clothes_t[idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) >= v[2] then
                    ttt = m
                    break
                end
            end
            if ttt == "" then
                return "\n  ��Ǹ��������"..v[1].."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
            end
        else
            if lualib:ItemCount(player, v[1]) < v[2] then
                return "\n  ��Ǹ��������"..lualib:KeyName2Name(v[1],4).."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
            end
        end
    end

    local fail = lualib:GenRandom(1, 100) > clothes_t[idx][4]

    for k, v in ipairs(clothes_t[idx][1]) do
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
                    return "\n  ��Ǹ��������"..v[1].."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
                end
            end
        else
            if fail and types == "1" and k == 3 then

            else
                if not lualib:DelItem(player, v[1], v[2], 2, "ɾ��:��������", npc) then
                    return "\n  ��Ǹ��������"..lualib:KeyName2Name(v[1],4).."��������"..v[2].."����\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
                end
            end
        end
    end

    if types == "1" then
        if not lualib:SubIngot(player, ingot, "��Ԫ�����·��ϳ�", npc) then
            return "ʧ�ܣ�ϵͳ����"
        end
    end

    if fail then
        return "\n ���ź������κϳ��Ϲ����ʧ���ˡ�"
    end

    lualib:AddItem(player, target, 1, false, "����Ʒ����������", npc)

    local msg = "��ϲ��ҡ�"..lualib:Name(player).."���ɹ��ϳɡ�"..lualib:KeyName2Name(target,4).."������ʵ��Ʒ�����ˡ�"
    lualib:SysMsg_SendBroadcastMsg(msg, "ϵͳ")

    return "\n  ��ϲ���ɹ��ϳ�"..lualib:KeyName2Name(target, 4).."��\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*������ҳ>"
end


function leave(npc, player)
    return ""
end