local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("form/��Ϸ����")

require("form/���˲��")
require("form/����")
require("form/��Ӫ�")
require("form/�Ϸ��")
require("form/��ӭ�´�")
require("form/����BOSS")
require("form/��ԯ֮��")
require("form/���ʻ")
function main(player)
    lualib:Warn("��������ͼ�귽��")
    local line = 1
    local pos = 0

    if GongGao_show(player,line,pos) then
        pos = pos - 1
    end

    if belleForm_show(player,line,pos) then
        pos = pos - 1
    end

    if xuanyuan_show(player,line,pos) then
        pos = pos - 1
    end

    if operation_active_show(player,line,pos) then
        pos = pos - 1
    end

    if NewYear_show(player,line,pos) then
        pos = pos - 1
    end

    if exciting_activities_show(player,line,pos) then
        pos = pos - 1
    end

    local line = 2
    local pos = 1

end