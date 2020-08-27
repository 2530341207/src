FirstConsume ={}
local ui ="<form> <dialog OnInit='FirstConsume.UIInit' id='FirstConsume' image='0' x='0' y='0' w='1014' h='620' center='true' esc_close='true' revmsg='true'>"
        .."	<image id='ClickBack' image='0' OnLButtonUp='FirstConsume.wndClose' revmsg='true'/>"
        .."	<image id='BG' image='1853500000' revmsg='true'/>"
        .."	<image id='wndTitleImage' image='1853500001' x='360' y='15' w='213' h='52' revmsg='true' enable='false'/>"

        .."	<image id='Girl' image='1853510000' x='670' y='5' w='66' h='26' enable='false'/>"
        .."	<button id='closeBtn' image='1853530000' x='930' y='40' w='34' h='33' OnLButtonUp='FirstConsume.wndClose' revmsg='true'/>"
        .."	<image id='TextImg1' image='1853500002' x='250' y='100' w='66' h='26' enable='false'/>"
        .."	<image id='TextImg5' image='1853500003' x='410' y='180' w='66' h='26' enable='false'/>"
        .."	<image id='TextImg8' image='1853500034' x='440' y='242' w='66' h='26' enable='false'/>"
        .."	<image id='TextImg9' image='1853500004' x='500' y='245' w='66' h='26' enable='false'/>"
        .."	<image id='Halo' image='1813600025' x='-35' y='120' w='512' h='512' fitsize=true enable='false'/>"

        .."	<image id='Weapon' image='1892750000' type=animate x='-20' y='-30' fitsize=true w='750' h='750' enable='false'/>"
        .."	<image id='ItemBG' image='1853520000'  x='280' y='280' w='750' h='750' enable='false'/>"

        .. "<image id='image1' x='440' y='325'  image='1800000385' revmsg='true' enable='false'/>"
        .. "<image id='image2' x='515' y='325'  image='1800000385' revmsg='true' enable='false'/>"
        .. "<image id='image3' x='590' y='325'  image='1800000385' revmsg='true' enable='false'/>"
        .. "<image id='image4' x='665' y='325'  image='1800000385' revmsg='true' check_point='0' OnMouseIn='FirstConsume.onIn' OnMouseOut='FirstConsume.onOut'/>"
        .. "<image id='item3_Magic' x='560' y='294'  image='3020110200' revmsg='false' enable='true'/>"
        .. "<image id='item1_Magic' x='410' y='294'  image='3020110200' revmsg='true' enable='false'/>"
        .. "<image id='item2_Magic' x='485' y='294'  image='3020110200' revmsg='true' enable='false'/>"
        .. "<image id='item4_Magic' x='635' y='294'  image='3020110200' revmsg='true' enable='true' OnMouseIn='FirstConsume.onIn' OnMouseOut='FirstConsume.onOut'/>"

        .."	<itemctrl id='item1' x='441' y='326' w='60' h='60' use_back='false' />"
        .."	<itemctrl id='item2' x='516' y='326' w='60' h='60' use_back='false' />"
        .."	<itemctrl id='item3' x='591' y='326' w='60' h='60' use_back='false'/>"
        .."	<itemctrl id='item4' x='666' y='326' w='60' h='60' use_back='false' />"

        .."	<button id='rechargeBtn' image='1805300080' x='550' y='450' w='134' h='59' OnLButtonUp='FirstConsume.rechargeBtn_LC' revmsg='true'/>"
        .."	<button id='GetGiftBtn' image='1802900013' x='550' y='450' w='124' h='49' OnLButtonUp='FirstConsume.GetGiftBtn_LQ' revmsg='true'/>"
        .." </dialog>"
        .."</form>"

function FirstConsume.main()
    local handle = GetWindow(0,"FirstConsume")
    if handle ~= 0 then
        GUI:WndClose(handle)
    else
        GenFormByString(ui)
    end
end

function FirstConsume.UIInit(_Handle)
    FirstConsume.WndHandle = _Handle
    local _GUIHandle = 0
    GUI:WndSetSizeM(FirstConsume.WndHandle,920,583)
    CenterWnd(FirstConsume.WndHandle)

    _GUIHandle = GUI:WndFindWindow(_Handle, "weaponIC")
    if _GUIHandle ~= 0 then
        GUI:ImageSetDrawCenter(_GUIHandle,true)
        WndAddEffect(_Handle,"weaponIC",3020070000,0,0,150,0)
        FirstConsume._weaponIC = _GUIHandle
    end

    _GUIHandle = GUI:WndFindWindow(_Handle, "itemBackImg")
    if _GUIHandle ~= 0 then
        GUI:ImageSetDrawCenter(_GUIHandle,true)
        WndAddEffect(_Handle,"itemBackImg",3020080000,0,0,150,0)
    end
    local _BtnHandle1 = GUI:WndFindWindow(0,"FirstConsume,GetGiftBtn")
    local _BtnHandle2 = GUI:WndFindWindow(0,"FirstConsume,rechargeBtn")

    if satisfy == 1 then
        if _BtnHandle1 ~= 0 and _BtnHandle2 ~= 0 then
            GUI:WndSetVisible(_BtnHandle1,true)
            GUI:WndSetVisible(_BtnHandle2,false)
        end
    else
        if _BtnHandle1 ~= 0 and _BtnHandle2 ~= 0 then
            GUI:WndSetVisible(_BtnHandle2,true)
            GUI:WndSetVisible(_BtnHandle1,false)
        end
    end
    for i=1,#rewardItem do
        local _ItemHandle = GUI:WndFindWindow(0,"FirstConsume,item"..i)
        if _ItemHandle ~= 0 then
            RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",rewardItem[i][1],rewardItem[i][2],true)
        end
    end

end

function FirstConsume.rechargeBtn_LC()
    CL:OpenUrlUseIEByType(3)
end

function FirstConsume.GetGiftBtn_LQ()
    UI:Lua_SubmitForm("Ê×³äÀñ°ü","receive","")
end

function FirstConsume.wndClose()
    if FirstConsume.WndHandle ~= 0 then
        GUI:WndClose(FirstConsume.WndHandle)
    end
end

FirstConsume.main()