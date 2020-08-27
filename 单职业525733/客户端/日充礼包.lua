dayCharge = {}
local _Handle = 0
function dayCharge.main()
    local handle = GetWindow(nil, "framedayCharge")
    if handle ~= 0 then WndClose(handle) return end
    local txt = {
        "充值礼包：通过充值、一定数额的充值卡、久玩币全部计入累计充值,当充值达到可看见下一层奖励!!"
    }
    local str = [[
	<form>
		<dialog id="framedayCharge" image="4010060000" w="900" h="700" x="0" y="0" close="false" esc_close="true" drag="true" center="true" revmsg="true" OnInit="dayCharge.Init">
			<image id="wnd1_Img1" x="73" y="147" w="900" h="700" image="4010060000" fitsize="true"/>
			<wnd id="wnd1" x="73" y="147" w="900" h="700" drag="true">

				<button id="wndColse" x="680" y="30" w="70" h="70" image="4000230000" OnLButtonClick="dayCharge.close" page_btn="true" shine="true" />
				<richedit id="txt1" x="403" y="99" w="80" h="30" text="累充礼包" canedit="false" font="SIMLI18" text_color="DBLUE" />
				<richedit id="txt2" x="149" y="138" w="110" h="20" text="您已经充值：" text_color="GOLD" canedit="false" font="SIMLI18" />
				<richedit id="txt3" x="150" y="168" w="450" h="50" text=]]..txt[1]..[[ text_color="GOLD" canedit="false" font="SIMLI18" />
				<button id="btn1" x="593" y="145" w="200" h="90" image="4000240032" text="前往充值" page_btn="false" shine="true" OnLButtonUp="dayCharge.recharge" />
			</wnd>
		</dialog>
	</form>
	]]
    GenFormByString(str)
end

function dayCharge.Init(this)
    _Handle = GUI:WndFindWindow(0,"framedayCharge,wnd1")
    local _GUIHandle = GUI:WndCreateScrollWnd(_Handle,"wnd1_wnd1",100,270,700,350)
    if _GUIHandle ~= 0 then
        --GUI:WndSetSizeM(_GUIHandle,700,350)
        --GUI:WndSetScrollType(_GUIHandle,2)
    end
    local _RichHandle = GUI:RichEditCreate(_Handle,"wnd1_ingots",260,138,80,30) --创建多功能编辑框
    if _RichHandle ~= 0 then
        GUI:RichEditSetCurFont(_RichHandle, "SIMLI18")
        GUI:RichEditSetDefaultTextColor(_RichHandle, COLOR_ORANGE)
        GUI:RichEditAppendString(_RichHandle, ingots.."元")
        GUI:RichEditSetEditEnable(_RichHandle, false)
    end

    for i=1,#dayChargeGift do
        local x = 0
        local y = (i-1) * 80
        local _ImgHandle = GUI:ImageCreate(_GUIHandle,"img"..i, 4000620015, x, y)
        if _ImgHandle ~= 0 then
            if i > canClaim then
                GUI:WndSetVisible(_ImgHandle, false)
            end
            GUI:WndSetSizeM(_ImgHandle,680,80)
            GUI:ImageSetFitSize(_ImgHandle, true)
        end

        local _RichHandle = GUI:RichEditCreate(_GUIHandle,"wnd1_wnd1_txt"..i,10,30+y,80,30) --创建多功能编辑框
        if _RichHandle ~= 0 then
            if i > canClaim then
                GUI:WndSetVisible(_RichHandle, false)
            end
            GUI:RichEditSetCurFont(_RichHandle, "SIMLI18")
            GUI:RichEditSetDefaultTextColor(_RichHandle, COLOR_ORANGE)
            GUI:RichEditAppendString(_RichHandle, dayChargeGift[i][1].."元")
            GUI:RichEditSetEditEnable(_RichHandle, false)
        end

        for j=1,6 do
            x = (j-1) * 80
            local _ImgHandle = GUI:ImageCreate(_GUIHandle,"img"..i..j, 4000630034, 80+x, 15+y)
            if _ImgHandle ~= 0 then
                if i > canClaim then
                    GUI:WndSetVisible(_ImgHandle, false)
                end
                GUI:WndSetSizeM(_ImgHandle,50,50)
                GUI:ImageSetFitSize(_ImgHandle, true)

            end

            local _ItemHandle = GUI:ItemCtrlCreate(_GUIHandle,"Item"..i..j,0,80+x,10+y,60,60) --创建物品框
            if _ItemHandle ~= 0 then
                if i > canClaim then
                    GUI:WndSetVisible(_ItemHandle, false)
                end
                GUI:ItemCtrlSetEffectImageID(_ItemHandle,3020110200,0.7)

                RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",dayChargeGift[i][2][j],1,true)
            end

            local _RichHandle = GUI:RichEditCreate(_GUIHandle,"wnd1_wnd1Count_txt"..i..j,110+x,45+y,50,20) --创建多功能编辑框
            if _RichHandle ~= 0 then
                if i > canClaim then
                    GUI:WndSetVisible(_RichHandle, false)
                end
                GUI:RichEditSetCurFont(_RichHandle, "SIMLI18")
                GUI:RichEditSetDefaultTextColor(_RichHandle, COLOR_ORANGE)
                GUI:RichEditAppendString(_RichHandle, tostring(dayChargeGiftCount[i][j]))
                GUI:RichEditSetEditEnable(_RichHandle, false)
            end
        end

        local _BtnHandle = GUI:ButtonCreate(_GUIHandle,"btnLq"..i,1855810044,560,y+15)
        if _BtnHandle ~= 0 then
            if i > canClaim then
                GUI:WndSetVisible(_BtnHandle, false)
                GUI:WndSetCanRevMsg(_BtnHandle,false)
            elseif i <= receiveNum then
                GUI:ButtonSetIsActiveBtn(_BtnHandle,true)
                GUI:ButtonSetTextFont(_BtnHandle,"SIMLI18")
                GUI:WndSetTextM(_BtnHandle,"已领取")
                GUI:WndSetTextOffset(_BtnHandle,0,-5)
                GUI:WndSetCanRevMsg(_BtnHandle,false)
                GUI:WndSetParam(_BtnHandle,i)
                GUI:ButtonSetShowDisable(_BtnHandle,true)
            elseif i <= peak then
                GUI:ButtonSetIsActiveBtn(_BtnHandle,true)
                GUI:ButtonSetTextFont(_BtnHandle,"SIMLI18")
                GUI:WndSetTextM(_BtnHandle,"可领取")
                GUI:WndSetTextOffset(_BtnHandle,0,-5)
                GUI:WndSetParam(_BtnHandle,i)
                GUI:WndRegistScript(_BtnHandle, RDWndBaseCL_mouse_lbClick, "dayCharge.submit")
            else
                GUI:ButtonSetIsActiveBtn(_BtnHandle,true)
                GUI:ButtonSetTextFont(_BtnHandle,"SIMLI18")
                GUI:WndSetTextM(_BtnHandle,"未达标")
                GUI:WndSetTextOffset(_BtnHandle,0,-5)
                GUI:WndSetParam(_BtnHandle,i)
                GUI:ButtonSetShowDisable(_BtnHandle,true)
            end
        end
    end

end

function dayCharge.recharge()
    CL:OpenUrlUseIEByType(3)
end

function dayCharge.submit(this)
    local num = GUI:WndGetParam(this)

    UI:Lua_SubmitForm("日充礼包", "receive", tostring(num))
end

function dayCharge.close(this)
    WndClose(0,"framedayCharge")
end

function dayCharge.update()

    local _BtnHandle = GUI:WndFindWindow(_Handle,"wnd1_wnd1,btnLq"..receiveNum)

    if _BtnHandle ~= 0 then
        msg(tostring(receiveNum))
        GUI:WndSetTextM(_BtnHandle,"已领取")
        GUI:WndSetTextOffset(_BtnHandle,0,-5)
        GUI:WndSetCanRevMsg(_BtnHandle,true)
        GUI:ButtonSetShowDisable(_BtnHandle,true)
        GUI:WndSetCanRevMsg(_BtnHandle,false)
    end
end

dayCharge.main()