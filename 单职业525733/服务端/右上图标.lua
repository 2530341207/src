local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("form/游戏公告")

require("form/美人册封")
require("form/端午活动")
require("form/运营活动")
require("form/合服活动")
require("form/恭迎新春")
require("form/世界BOSS")
require("form/轩辕之力")
require("form/精彩活动")
function main(player)
    lualib:Warn("调用右上图标方法")
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