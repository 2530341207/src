activity = {}
local _Handle = 0
local showtable = {
    {
        "ȫ�����һ��",
        "�����ɶ�      ���鱩��",
        "�����",
        "�ʱ����ֹ�Ȧ,ռ���Ȧ���ɻ�ý���λ�ò�ͬ��ý�����ͬ,���ÿ��ɻ��400����+80��Ԫ��",
        "����35���Ӻ���У�ÿ��18:00���У�",
        "��ô�������+Ԫ������",
        "ȫ��������Ҿ��ɲ���",
        "����"
    },
    {
        "ȫ���������",
        "��ͱ���      ȫ�澺��",
        "ʱ�侺��",
        "���ֹ�������,��ڵ�����λ�ü��ɴ򿪱���,����һ�ν�����ص���ڴ�,����100����������",
        "����60���Ӻ���У�ÿ��15���У�",
        "�����ñ���������Ʒ",
        "�ȼ��ﵽ65��������Ҷ����Բ���",
        "����"
    },
    {
        "ȫ���������",
        "�л�����      ��һ����",
        "�лᾺ���",
        "�22:15�׼ʱ����,22:25���Źر�,����ʣ���һ���л����ȡ����,���ߴ�70����Ա���н���",
        "�������첻���У�ÿ��22:15���У�",
        "����Ԫ��28888,��Ա2000",
        "��Ҫ�����л�,�ȼ��ﵽ70���ɲμ�",
        "����"
    },
    {
        "ȫ������ģ�",
        "ȺӢ����      �귨����",
        "����",
        "�19:00-19:10����Ԥѡ����,19:11�����������,��ʤ��ֱ̭�����һ���ڳ����ɻ�ý���!",
        "�������첻���У�ÿ��19:00���У�",
        "���ܻ�ʤ�߽���Ԫ��58888 hp+200",
        "�ȼ��ﵽ70������ҿɲ���",
        "����"
    },
    {
        "ȫ������壩",
        "ȫ��Ѻ��      ���鱩��",
        "���鸣��",
        "�19:30����,20:00���Źرս����ҡ���ԯ�ھ֡�����쭳�����ͬ��ͼ������ʦ�����ɻ�þ��齱��",
        "��������50���Ӻ�ÿ��19:30���У�",
        "��ɻ��2000-5000����",
        "�ȼ��ﵽ50����ҿɲμ�",
        "����"
    },
    {
        "ȫ���������",
        "���д���      ����˫��",
        "���ֻ",
        "�14:00��22:30����,������������,����ʱ��Ϊ30���ӣ��ɻ�ñ��䣬���಻ͬ���Ӿ��鲻ͬ",
        "��������70���ӣ�ÿ��19:30��20:30���У�",
        "���顢Ԫ����װ�������ϡ�VIP֤��",
        "ȫ��������Ҿ��ɲ���",
        "����"
    },
}
function activity.main()
    local handle = GetWindow(nil, "frameActivity")
    if handle ~= 0 then WndClose(handle) return end
    local str = [[
		<form>
			<dialog id="frameActivity" image="1800830000,1800830001,1800830002,1800830003,1800830008,1800830004,1800830005,1800830006,1800830007" w="700" h="500" x="0" y="0"  close="false" esc_close="true"  center="true" revmsg="true" OnInit="activity.Init" magic="1">
				<wnd id="wnd1" x="0" y="0" w="700" h="500">	
					<richedit id="wnd1_Txt1" x="290" y="10" w="150" h="30" text="���ʹ" text_color="GOLD" canedit="false" font="SIMLI18" />
					<image id="wnd1_Img2" x="15" y="40" w="673" h="443" image="1830700017" fitsize="true" gray="false" />
					<button id="wnd1_btn1" x="20" y="50" w="140" h="50" image="1857410016" text_color="GOLD2" param="1" text="�����ɶ�" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn2" x="20" y="110" w="140" h="50" image="1857410016" text_color="GOLD2" param="2" text="��ͱ���" OnLButtonClick="activity.activities"/>					
					<button id="wnd1_btn3" x="20" y="170" w="140" h="50" image="1857410016" text_color="GOLD2" param="3" text="�л�����" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn4" x="20" y="230" w="140" h="50" image="1857410016" text_color="GOLD2" param="4" text="ȫӢ����" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn5" x="20" y="290" w="140" h="50" image="1857410016" text_color="GOLD2" param="5" text="ȫ��Ѻ��" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn6" x="19" y="353" w="140" h="50" image="1857410016" text_color="GOLD2" param="6" text="��������" OnLButtonClick="activity.activities"/>
					<button id="wnd1_btn7" x="240" y="440" w="90" h="30" image="1853730055" text_color="GOLD2" text="]]..showtable[1][8]..[[" OnLButtonClick="activity.submit"/>
					
					<button id="wnd1_btn8" x="470" y="440" w="90" h="30" image="1853730055" text_color="GOLD2" text="�رնԻ�" OnLButtonClick="activity.colse"/>
					<image id="wnd1_Img3" x="165" y="40" w="525" h="150" image="1806000001" fitsize="true" gray="false" />
					<richedit id="wnd1_txt11" x="199" y="58" w="200" h="30" text="]]..showtable[1][1]..[[" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt12" x="211" y="115" w="350" h="30" text="]]..showtable[1][2]..[[" text_color="GOLD" canedit="false" font="SIMLI18" />
					<image id="wnd1_Img4" x="170" y="194" w="510" h="230" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<richedit id="wnd1_txt3" x="180" y="200" w="130" h="30" text="�����:" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt4" x="180" y="230" w="130" h="30" text="�����:" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt5" x="180" y="320" w="130" h="30" text="�ʱ��:" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt6" x="180" y="350" w="130" h="30" text="�����:" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt7" x="180" y="380" w="130" h="30" text="�����:" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt13" x="290" y="200" w="400" h="30" text="]]..showtable[1][3]..[[" text_color="RED" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt14" x="290" y="230" w="380" h="90" text="]]..showtable[1][4]..[[" text_color="SIMLI18" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt15" x="290" y="320" w="400" h="30" text="]]..showtable[1][5]..[[" text_color="GOLD" canedit="false" font="SIMLI18" />
					<richedit id="wnd1_txt16" x="290" y="350" w="400" h="30" text="]]..showtable[1][6]..[[" canedit="false" font="SIMLI18" text_color="BLUE" />
					<richedit id="wnd1_txt17" x="290" y="380" w="400" h="30" text="]]..showtable[1][7]..[[" canedit="false" font="SIMLI18" text_color="GREENG" />
				</wnd>
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
        UI:Lua_SubmitForm("���ʻ", "receive", tostring(num))
    elseif num == 2 then
        UI:Lua_SubmitForm("���ʻ", "receive", tostring(num))
    elseif num == 3 then
        UI:Lua_SubmitForm("���ʻ", "receive", tostring(num))
    elseif num == 4 then
        UI:Lua_SubmitForm("���ʻ", "receive", tostring(num))
    elseif num == 5 then
        UI:Lua_SubmitForm("���ʻ", "receive", tostring(num))
    elseif num == 6 then
        UI:Lua_SubmitForm("���ʻ", "receive", tostring(num))
    end
end

function activity.colse(this)
    WndClose(0,"frameActivity")
end

activity.main()