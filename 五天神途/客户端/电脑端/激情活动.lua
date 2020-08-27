activity = {}
local _Handle = 0
local showtable = {
    {
        "全服活动（一）",
        "火魔争霸		超级福利",
        "福利活动",
        "拥有龙传封号+200元宝方可传送",
        "每天19:30是火魔刷新时间",
        "必出10000元宝,火龙及以上装备2-5件",
        "全服所有玩家均可参与",
        "进入火魔争霸"
    },
    {
        "全服活动（二）",
        "马拉松跑酷		全面竞速",
        "时间竞速",
        "【第一名:800元宝1000万经验】【第四名:400元宝500万经验】【第二名:600元宝1000万经验】【第五名:300元宝500万经验】【第三名:500元宝1000万经验】【第六名:200元宝500万经验】",
        "新区60分钟后举行,仅两分钟",
        "达到终点获得前六(70以上不获得经验)",
        "全服所有玩家均可参与",
        "进入活动"

    },
    {
        "全服活动（三）",
        "行会争霸		第一帮派",
        "行会竞技活动",
        "活动22:15活动准时进行，22：25大门关闭，比赛实行优胜劣汰直到剩余最后一个行会获得领取奖励，在线达到70级成员均有奖励",
        "新区当天不举行（每天晚上22:15举行）",
        "掌门奖元宝28888HP+300,成员奖2000HP+200",
        "需要加入行会，等级达到70即可参加",
        "进入行会争霸"
    },
    {
        "全服活动（四）",
        "群英争霸		玛法主宰",
        "比武活动",
        "活动19:00-19:10进入预选房间，19:11进入正式比赛场地，优胜劣汰直到最后一名在场即可获得奖励！（所有人为神秘人）",
        "新区当天不举行（每天下午19:00举行）",
        "最总获胜者奖励元宝58888 hp+200",
        "等级达到70以上玩家可参与",
        "进入群英争霸"
    },
    {
        "全服活动（五）",
        "全民押镖		经验暴涨",
        "经验福利",
        "活动19:30活动准时进行，20:00大门关闭进入找“轩辕镖局”接收飙车送往同地图“接镖师”即可获得经验奖励",
        "新区开放50分钟后（每天下午19:30举行）",
        "完成获得2000-5000万经验",
        "等级达到50级玩家可参加",
        "进入全民押镖"
    },
    {
        "全服活动（六）",
        "休闲垂钓		放松双手",
        "娱乐活动",
        "活动14:00、22:30活动准时进行，活动送免费鱼竿鱼饵，钓鱼时间为30分钟，可获得宝箱，鱼类不同增加经验不同",
        "新区开放70分钟（每天下午19:30、20:30举行）",
        "经验、元宝、装备、材料、VIP证等",
        "全服所有玩家均可参与",
        "进入垂钓功能"
    },
}
function activity.main()
    local handle = GetWindow(nil, "frameActivity")
    if handle ~= 0 then WndClose(handle) return end
    local str = [[
		<form>
			<dialog id="frameActivity" image="1800830000,1800830001,1800830002,1800830003,1800830008,1800830004,1800830005,1800830006,1800830007" w="700" h="500" x="0" y="0"  close="false" esc_close="true"  center="true" revmsg="true" OnInit="activity.Init" magic="1">
				<wnd id="wnd1" x="0" y="0" w="700" h="500">	
					<richedit id="wnd1_Txt1" x="290" y="10" w="80" h="30" text="活动大使" text_color="GOLD" canedit="false" font="SIMLI18" />
					<image id="wnd1_Img2" x="15" y="40" w="673" h="443" image="1830700017" fitsize="true" gray="false" />
					<button id="wnd1_btn1" x="20" y="50" w="140" h="50" image="1857410016" text_color="GOLD2" param="1" text="激情派对" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn2" x="20" y="110" w="140" h="50" image="1857410016" text_color="GOLD2" param="2" text="跑酷竞速" OnLButtonClick="activity.activities"/>					
					<button id="wnd1_btn3" x="20" y="170" w="140" h="50" image="1857410016" text_color="GOLD2" param="3" text="行会争霸" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn4" x="20" y="230" w="140" h="50" image="1857410016" text_color="GOLD2" param="4" text="全英争霸" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn5" x="20" y="290" w="140" h="50" image="1857410016" text_color="GOLD2" param="5" text="全名押镖" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn6" x="19" y="353" w="140" h="50" image="1857410016" text_color="GOLD2" param="6" text="垂钓休闲" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn7" x="240" y="440" w="90" h="30" image="1853730055" text_color="GOLD2" text="]]..showtable[1][8]..[[" OnLButtonClick="activity.submit"/>
					
					<button id="wnd1_btn8" x="470" y="440" w="90" h="30" image="1853730055" text_color="GOLD2" text="关闭对话" OnLButtonClick="activity.colse"/>
					<image id="wnd1_Img3" x="165" y="40" w="525" h="150" image="1806400000" fitsize="true" gray="false" />
					<richedit id="wnd1_txt11" x="199" y="58" w="150" h="30" text="]]..showtable[1][1]..[[" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt12" x="211" y="115" w="250" h="30" text="]]..showtable[1][2]..[[" text_color="GOLD" canedit="false" font="SIMLI18" />
					<image id="wnd1_Img4" x="170" y="194" w="510" h="230" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<richedit id="wnd1_txt3" x="180" y="200" w="100" h="30" text="活动类型：" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt4" x="180" y="230" w="100" h="30" text="活动规则：" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt5" x="180" y="320" w="100" h="30" text="活动时间：" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt6" x="180" y="350" w="100" h="30" text="活动奖励：" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt7" x="180" y="380" w="100" h="30" text="活动条件：" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt13" x="280" y="200" w="350" h="30" text="]]..showtable[1][3]..[[" text_color="RED" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt14" x="280" y="230" w="350" h="90" text="]]..showtable[1][4]..[[" text_color="SIMLI18" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt15" x="280" y="320" w="450" h="30" text="]]..showtable[1][5]..[[" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt16" x="280" y="350" w="350" h="30" text="]]..showtable[1][6]..[[" canedit="false" font="SIMLI18" text_color="BLUE" />
					<richedit id="wnd1_txt17" x="280" y="380" w="350" h="30" text="]]..showtable[1][7]..[[" canedit="false" font="SIMLI18" text_color="GREENG" />
				</wnd>
  				<button id="wnd1_btn8" x="660" y="5" w="90" h="30" image="1800900119" OnLButtonClick="activity.colse"/>
			</dialog>
		</form>
	]]
    GenFormByString(str)
end

function activity.Init(this)
    _Handle = GetWindow(0,"frameActivity,wnd1")
    local _BtnHandle = GetWindow(0,"frameActivity,wnd1,wnd1_btn7")
    if _BtnHandle ~= 0 then
        GUI:WndSetParam(_BtnHandle,1)
    end

    local _BtnHandle = GetWindow(0,"frameActivity,wnd1,wnd1_btn1")
    if _BtnHandle ~= 0 then
        GUI:ButtonSetTextFont(_BtnHandle,"SIMLI18")
    end
end

function activity.activities(this)
    local num = GUI:WndGetParam(this)

    for i=1,7 do
        local _EditHandle = GetWindow(_Handle,"wnd1_txt1"..i)
        if _EditHandle ~= 0 then
            GUI:RichEditClear(_EditHandle)
            GUI:RichEditAppendString(_EditHandle,showtable[num][i])
        end
    end

    if num == 2 then
        local _EditHandle = GetWindow(_Handle,"wnd1_txt4")
        if _EditHandle ~= 0 then
            GUI:RichEditClear(_EditHandle)
            GUI:RichEditAppendString(_EditHandle,"活动奖励：")
        end
        local _EditHandle = GetWindow(_Handle,"wnd1_txt6")
        if _EditHandle ~= 0 then
            GUI:RichEditClear(_EditHandle)
            GUI:RichEditAppendString(_EditHandle,"活动规则：")
        end
        local _EditHandle = GetWindow(_Handle,"wnd1_txt14")
        if _EditHandle ~= 0 then
            GUI:RichEditSetCurFont(_EditHandle,"system")
            GUI:RichEditClear(_EditHandle)
            GUI:RichEditAppendString(_EditHandle,showtable[num][4])
        end
    end

    local _BtnHandle = GetWindow(0,"frameActivity,wnd1,wnd1_btn7")
    if _BtnHandle ~= 0 then
        GUI:WndSetParam(_BtnHandle,tonumber(num))
        GUI:WndSetTextM(_BtnHandle,showtable[num][8])
    end

    local _BtnHandle = GetWindow(0,"frameActivity,wnd1,wnd1_btn"..num)
    if _BtnHandle ~= 0 then
        GUI:ButtonSetTextFont(_BtnHandle,"SIMLI18")
    end

    for i=1,6 do
        local _BtnHandle = GetWindow(0,"frameActivity,wnd1,wnd1_btn"..i)
        if i == num then
            if _BtnHandle ~= 0 then
                GUI:ButtonSetTextFont(_BtnHandle,"SIMLI18")
            end
        else
            if _BtnHandle ~= 0 then
                GUI:ButtonSetTextFont(_BtnHandle,"system")
            end
        end
    end
end

function activity.submit(this)
    local num = GUI:WndGetParam(this)
    if num == 1 then
        UI:Lua_SubmitForm("火魔争霸", "enter", tostring(num))
    elseif num == 2 then
        UI:Lua_SubmitForm("Ya酷跑活动", "receive", tostring(num))
    elseif num == 3 then
        UI:Lua_SubmitForm("行会争霸表单", "receive", tostring(num))
    elseif num == 4 then
        UI:Lua_SubmitForm("全英争霸", "receive", tostring(num))
    elseif num == 5 then
        UI:Lua_SubmitForm("全民押镖", "receive", tostring(num))
    elseif num == 6 then
        UI:Lua_SubmitForm("垂钓休闲", "receive", tostring(num))
    end
end

function activity.colse(this)
    WndClose(0,"frameActivity")
end

activity.main()