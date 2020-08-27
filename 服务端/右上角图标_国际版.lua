local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("form/Common")

function main(player)


    local khdlx = lualib:GetClientType(player)
    if khdlx == 0 then


        local y = -0.11
        local x =  2.5-1.9

        x = x - 1.3
        AddSEIcon(player, 1+y+0.3, x+2.38, "��", 1930000176, "��", "main", "", "��","")

        x = x - 1.3
        AddSEIcon(player, 1+y+0.3, x+1, "weixin", 1906100145, "΢�����", "weixin_main", "", "΢�����","")

        x = x - 1.3
        AddSEIcon(player, 1+y+0.3, x+1.3, "QQqun", 1906100165, "QQȺ���", "qqqun_main", "", "QQȺ","")

        x = x - 1.3
        AddSEIcon(player, 1+y+0.4, x+1.6, "��ֵ���", 1906100013, "��ֵ���", "WndRefresh", "", "��ֵ���","")

        x = x - 1.3
        AddSEIcon(player, 1.8+y+0.3, x+5.8, "���ζ�ά��", 1853730028, "���ζ�ά��", "main", "", "���ζ�ά��","")


        AddSEIcon(player, 1.8+y+0.3, x+2.38, "�������", 1906100049, "�������", "showns2", "ÿ������", "ÿ������!")
    end


end

function ShowTimeCount(player, time, icon, notify)
    local content = time.."\n"..icon.."\n"..notify
    lualib:Player_SetCustomVarInt(player, notify.."����ʱ", lualib:GetTime() + time)
    lualib:ShowFormWithContent(player, "����ʱ", content)
end

function ShowTimeCount2(player, time, icon, notify, xianshi, ziti)
    local content = time.."\n"..icon.."\n"..notify.."\n"..xianshi.."\n"..ziti
    lualib:Player_SetCustomVarInt(player, notify.."����ʱ", lualib:GetTime() + time)
    lualib:ShowFormWithContent(player, "����ʱ", content)
end

function ShowTimeCount3(player, time, icon, notify, xianshi, ziti, str)
    local content = time.."\n"..icon.."\n"..notify.."\n"..xianshi.."\n"..ziti.."\n"..str
    lualib:Player_SetCustomVarInt(player, notify.."����ʱ", lualib:GetTime() + time)
    lualib:ShowFormWithContent(player, "����ʱ", content)
end


--�У���, ͼ��Ψһ�ı�ʶ, ͼ�꣬ ������ļ���������˺���������
function AddSEIcon(player, hang, dian, biaoshi, icon, biaodan, hanshu, canshu, tips, text)
    if tips == nil or type(tips) ~= "string" then
        tips = ""
    end
    if text == nil or type(text) ~= "string" then
        text = ""
    end
    local script = "AddSEIcon("..hang..","..dian..","..string.format("%q", biaoshi)..","..icon..","..string.format("%q", biaodan)..","..string.format("%q", hanshu)..","..string.format("%q", canshu)..","..string.format("%q", tips)..","..string.format("%q", text)..")"
    lualib:ShowFormWithContent(player, "�ű���", script)
end














--�У���, ͼ��Ψһ�ı�ʶ, ͼ�꣬ ������ļ���������˺���������ʱ����������
function AddSETimeIcon(player, hang, dian, biaoshi, icon, biaodan, hanshu, time, canshu, tips)
    if tips == nil or type(tips) ~= "string" then
        tips = ""
    end
    local script = "AddSETimeIcon("..hang..","..dian..","..string.format("%q", biaoshi)..","..icon..","..string.format("%q", biaodan)..","..string.format("%q", hanshu)..","..time..","..string.format("%q", canshu)..","..string.format("%q", tips)..")"
    lualib:ShowFormWithContent(player, "�ű���", script)

end

-- ��ӣ�ͼ��Ψһ�ı�ʶ, ͼ��ID�� x��y(��Ը�ICON��ƫ��)����Ч��֮֡���ʱ����(����)
function AddIconMagic(player, name, image, x, y, elapse)
    Invoke(player, "AddIconMagic", name, image, x, y, elapse)
    --local script = "AddSETimeIcon("..name..","..image..","..x..","..y..","..elapse..")"
    -- lualib:ShowFormWithContent(player, "�ű���", script)
end

--ɾ����ͼ��Ψһ�ı�ʶ
function DelIconMagic(player, name)
    Invoke(player, "DelIconMagic", name)
    local script = "AddSETimeIcon("..name..")"
    lualib:ShowFormWithContent(player, "�ű���", script)
end



-- �ļ���
function DelIcon(player, file)
    local script = "DelIcon("..string.format("%q", file)..")"
    lualib:ShowFormWithContent(player, "�ű���", script)
end

