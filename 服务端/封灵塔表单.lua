function main(player)
    lualib:ShowFormWithContent(player,"form文件表单","封灵塔")

    return ""
end

local countryName = {
    "魏国",
    "蜀国",
    "吴国"
}

local countryPosition  = {
    "国王",
    "丞相",
    "大将军",
    "大司马",
    "大都督",
}

function accept(player)
    local country = lualib:GetStr(player,"countryName")
    local name = lualib:Name(player)
    local countryList = lualib:GetDBStr(country.."excessiveRanking")            --官职排行榜
    local countryRanking = lualib:GetDBStr(country.."Ranking")                  --捐献排行榜
    local list = lualib:StrSplit(countryList,"#")
    local ranking = lualib:StrSplit(countryRanking,"#")
    --判断元宝数量
    if lualib:GetIngot(player) < 5000 then
        lualib:MsgBox(player,"您的元宝不足5000，无法使用此功能！")
        return ""
    end
    --判断是否已经叛国并没有加入其他国家
    if country == "" then
        lualib:MsgBox(player,"您已经不再任何国家，请勿重复点击！")
        return ""
    end
    --删除守护灵
    lualib:DelayCall(player,1,"warGodForm:resetPlayerHeroAllValue",country)
    --删除原有国家官职buff
    for i=1,#countryPosition do
        if  lualib:HasBuff(player,countryPosition[i]) then
            lualib:DelBuff(player,countryPosition[i])
        end
    end
    lualib:DelBuff(player,country)
    --删除原有国家捐赠元宝
    local countryIntegral = lualib:SetDBNumEx(name..country.."countryIntegral",0,2)
    --删除官职排行榜中角色信息
    lualib:SetDBStrEx(country.."excessiveRanking","",6)
    for i,v in pairs(list) do
        if v ~= name and v ~= "" then
            lualib:SetDBStrEx(country.."excessiveRanking",lualib:GetDBStr(country.."excessiveRanking").."#"..v,6)
        end
    end
    --lualib:SysMsg_SendBroadcastMsg(countryList.."||"..countryRanking,"更新")
    --删除捐献排行榜中角色信息
    lualib:SetDBStrEx(country.."Ranking","",6)
    for i,v in pairs(ranking) do
        if v ~= name and v ~= "" then
            lualib:SetDBStrEx(country.."Ranking",lualib:GetDBStr(country.."Ranking").."#"..v,6)
        end
    end
    lualib:DelayCall(player,1,"三国表单:refresh","")
    countryList = lualib:GetDBStr(country.."excessiveRanking")            --官职排行榜
    countryRanking = lualib:GetDBStr(country.."Ranking")                  --捐献排行榜


    --删除"_na_"变量中国家属性
    local str = ""
    for i=1,#countryName do
        if country == countryName[i] then
            lualib:SetInt(player,"panbian",i)
        end
    end
    lualib:SetStr(player,"Country",str)
    --删除国家标识
    lualib:SetStr(player,"countryName","")
    --删除元宝
    if lualib:Player_SubIngot(player,5000,false,"叛国扣除元宝","封灵塔表单") == false then
        lualib:MsgBox(player,"扣除元宝失败，请联系客服处理！")
        return ""
    end
    --清空抽奖变量
    lualib:DelayCall(player,1,"country:main","")
    lualib:ShowFormWithContent(player,"form文件表单","country")
    lualib:ShowFormWithContent(player,"脚本表单","tower.close()")
    lualib:SysPromptMsg(player,"叛出成功，请重新选择国家！！!")


    return ""
end