GameMainBar = {}
GameMainBar_Msg = {}
function GameMainBar.main()
    local _Parent = LuaGlobal["AttachPartent"]
    local _GUIHandle = _Parent
    local _DeviceSizeX = CL:GetScreenWidth()
    local _DeviceSizeY = CL:GetScreenHeight()
    local x = 0
    local y = 0
    if GUI:WndGetPosM(_GUIHandle) then
        local x =LuaRet[1]
        local y =LuaRet[2]
    end


    local SurfaceOffX = 66
    local SurfaceOffY = 60
    local _Handle = GUI:ImageCreate(_Parent,"SurfaceImg",0,0,0)
    if _Handle ~= 0 then
        GUI:WndSetParam(_Handle, 0)
        GUI:WndSetSizeM(_Handle,142+SurfaceOffX, 162+SurfaceOffY)
    end

    _Handle = GUI:ImageCreate(_Parent,"xuetubj",1612100049,-17+SurfaceOffX,40+SurfaceOffY)
    if _Handle ~= 0 then
        GUI:WndSetParam(_Handle, 0)
        GUI:WndSetSizeM(_Handle,66, 30)
    end

    _Handle = GUI:ImageCreate(_Parent,"HPEffect",1612000006,-14+SurfaceOffX,48+SurfaceOffY)
    if _Handle ~= 0 then
        GUI:WndSetParam(_Handle, 0)
        GUI:WndSetSizeM(_Handle,66, 30)
    end


    _Handle = GUI:ImageCreate(_Parent,"MPEffect",1612000007,40+SurfaceOffX,48+SurfaceOffY)
    if _Handle ~= 0 then
        GUI:WndSetParam(_Handle, 0)
        GUI:WndSetSizeM(_Handle,66, 30)
    end


    _Handle = GUI:ImageCreate(_Parent,"PlayerHP",1612000006,-14+SurfaceOffX, 48+SurfaceOffY)
    if _Handle ~= 0 then
        GUI:WndSetParam(_Handle, 0)
        GUI:WndSetSizeM(_Handle,100, 150)
    end


    _Handle = GUI:ImageCreate(_Parent,"PlayerMP",1612000007,  40+SurfaceOffX,  48+SurfaceOffY)
    if _Handle ~= 0 then
        GUI:WndSetParam(_Handle, 0)
        GUI:WndSetSizeM(_Handle,100, 150)
    end

    local _GUIHand = GUI:ImageCreate(_Parent, "redPacketBtnMagic", 3020300100, x + 70 , y - 110)
    if _GUIHand ~= 0 then
        GUI:WndSetSizeM(_GUIHand,12, 12)
        GUI:WndSetVisible(_GUIHand, false)
    end
    local _RoleBtn = GUI:ButtonCreate(_GUIHandle, "Role", 0, 820, 159)
    if _RoleBtn ~= 0 then
        GUI:WndSetSizeM(_GUIHand,1, 1)
    end
    local _BackImage = GUI:ImageCreate(_GUIHandle, "BackImage", 1612000005, 207, 0)
    if _BackImage ~= 0 then
    end

    local _BackImage0 = GUI:ImageCreate(_GUIHandle, "BackImage0", 1612000003, 0, 42)
    if _BackImage0 ~= 0 then
    end

    local _BackImage1 = GUI:ImageCreate(_GUIHandle, "BackImage1", 1612000004, 722, 91)
    if _BackImage1 ~= 0 then
    end

    _fuhuo = GUI:ImageCreate(_GUIHandle, "fuhuo", 1892100059, 263, 35)
    if _fuhuo ~= 0 then
        GUI:WndSetVisible(_fuhuo,false)
        GUI:ImageSetFitSize(_fuhuo, true)
        GUI:WndSetSizeM(_fuhuo, 40, 40)
        WndAddEffect(_fuhuo, nil, 1069000000, -4, -4, 150, 0)
    end

    _fuhuowenzi = GUI:EditCreate(_GUIHandle,"fuhuowenzi", 267, 50, 65, 18)
    if _fuhuowenzi ~= 0 then
        GUI:WndSetVisible(_fuhuowenzi,false)
        GUI:WndSetEnableM(_fuhuowenzi, true)
        GUI:WndSetParam(_fuhuowenzi, 0)
        GUI:WndSetTextColorM(_fuhuowenzi, 4291736418)
        GUI:EditSetTextM(_fuhuowenzi,"复活")
        GUI:EditSetCanEdit(_fuhuowenzi, false)
    end


    local _TradeBtn = GUI:ButtonCreate(_GUIHandle, "Trade", 1930000044, 200, 100)
    if _TradeBtn ~= 0 then
        GUI:WndSetHint(_TradeBtn, "交易(Alt+T)")
        GUI:WndRegistScript(_TradeBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnTradeBtn")
        local _TradeMagic = GUI:ImageCreate(_GUIHandle, "TradeMagic", 1089100000, 212, 45)
        if _TradeMagic ~= 0 then
            GUI:WndSetVisible(_TradeMagic, false)
            GUI:WndSetCanRevMsg(_TradeMagic, false)
            GUI:ImageSetCheckPoint(_TradeMagic, 0)
        end
    end

    local _TeamBtn = GUI:ButtonCreate(_GUIHandle, "MakeTeam", 1930000048, 233, 100)
    if _TeamBtn ~= 0 then
        GUI:WndSetHint(_TeamBtn, "组队(Ctrl+D)")
        GUI:WndRegistScript(_TeamBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnTeamBtn")
        local _TeamMagic = GUI:ImageCreate(_GUIHandle, "TeamMagic", 1089100000, 245, 45)
        if _TeamMagic ~= 0 then
            GUI:WndSetVisible(_TeamMagic, false)
            GUI:WndSetCanRevMsg(_TeamMagic, false)
            GUI:ImageSetCheckPoint(_TeamMagic, 0)
        end
    end

    local zhansha = GUI:ImageCreate(_GUIHandle, "zhansha", 1802200024, 750, 48)
    if zhansha ~= 0 then
        GUI:ImageSetFitSize(zhansha,true)
        GUI:WndSetVisible(zhansha, true)
        GUI:WndSetCanRevMsg(zhansha, true)
        GUI:ImageSetGray(zhansha,true)
        --GUI:ImageSetCheckPoint(zhansha, 0)
        GUI:WndSetSizeM(zhansha, 43, 43)
        --GUI:WndSetPosByDeviceSize(zhansha,true,true)
    end

    local zhansha = GUI:ImageCreate(_GUIHandle, "zhansha1", 1802200024, 750, 48)
    if zhansha ~= 0 then
        GUI:ImageSetFitSize(zhansha,true)
        GUI:WndSetVisible(zhansha, true)
        GUI:WndSetCanRevMsg(zhansha, true)
        --GUI:ImageSetGray(zhansha,true)
        --GUI:ImageSetCheckPoint(zhansha, 0)
        GUI:WndSetSizeM(zhansha, 43, 43)
        --GUI:WndSetPosByDeviceSize(zhansha,true,true)
        GUI:ImageSetDrawRect(zhansha,0,0,0,0)
    end

    local baojian = GUI:ImageCreate(_GUIHandle, "baojian", 1933600001, 150, 48)
    if baojian ~= 0 then
        GUI:WndSetVisible(baojian, true)
        GUI:WndSetCanRevMsg(baojian, true)
        GUI:ImageSetCheckPoint(baojian, 0)
        GUI:ImageSetFitSize(baojian,true)
        GUI:WndSetSizeM(baojian, 150, 40)
        GUI:WndSetPosByDeviceSize(baojian,true,true)
    end

    local baojian = GUI:ImageCreate(_GUIHandle, "baojian1", 1933600002, 150, 48)
    if baojian ~= 0 then
        GUI:WndSetVisible(baojian, true)
        GUI:WndSetCanRevMsg(baojian, true)
        GUI:ImageSetCheckPoint(baojian, 0)
        GUI:ImageSetFitSize(baojian,true)
        GUI:WndSetSizeM(baojian, 150, 40)
        GUI:WndSetPosByDeviceSize(baojian,true,true)
        GUI:ImageSetDrawRect(baojian,0,0,0,0)
    end



    local _ContactBtn = GUI:ButtonCreate(_GUIHandle, "Contact", 1930000064, 266, 100)
    if _ContactBtn ~= 0 then
        GUI:WndSetHint(_ContactBtn, "社会关系(Ctrl+F)")
        GUI:WndRegistScript(_ContactBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnContactBtn")
    end

    local _HangHuiBtn = GUI:ButtonCreate(_GUIHandle, "HangHui", 1930000052, 299, 100)
    if _HangHuiBtn ~= 0 then
        GUI:WndSetHint(_HangHuiBtn, "行会(Ctrl+G)")
        GUI:WndRegistScript(_HangHuiBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnHangHuiBtn")
    end


    local _SettingBtn = GUI:ButtonCreate(_GUIHandle, "Setting", 1930000068, 333, 100)
    if _SettingBtn ~= 0 then
        GUI:WndSetHint(_SettingBtn, "系统设置")
        GUI:WndRegistScript(_SettingBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnSettingBtn")
    end

    local _MailBtn = GUI:ButtonCreate(_GUIHandle, "Mail", 1930000060, 366, 100)
    if _MailBtn ~= 0 then
        GUI:WndSetHint(_MailBtn, "邮件")
        GUI:WndRegistScript(_MailBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnMailBtn")
    end


    local _ShowHideBtn = GUI:ButtonCreate(_GUIHandle, "ShowPlayer", 1930000072, 399, 100)
    if _ShowHideBtn ~= 0 then
        GUI:WndSetHint(_ShowHideBtn, "显示/隐藏生物(Ctrl+Z)")
        GUI:WndRegistScript(_ShowHideBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnShowHideBtn")
    end

    local _RideBtn = GUI:ButtonCreate(_GUIHandle, "guaji", 1611700041, 433, 102)
    if _RideBtn ~= 0 then
        GUI:WndSetHint(_RideBtn, "自动挂机")
        GUI:WndRegistScript(_RideBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.guaji")
    end



    local _QuiteToLoginBtn = GUI:ButtonCreate(_GUIHandle, "QuiteToLogin", 1930000080, 704, 94)
    if _QuiteToLoginBtn ~= 0 then
        GUI:WndSetHint(_QuiteToLoginBtn, "退到选择角色界面(Alt+X)")
        GUI:WndRegistScript(_QuiteToLoginBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnQuiteToLoginBtn")
    end

    local _QuiteGameBtn = GUI:ButtonCreate(_GUIHandle, "Quite", 1930000084, 737, 94)
    if _QuiteGameBtn ~= 0 then
        GUI:WndSetHint(_QuiteGameBtn, "退出游戏(Alt+Q)")
        GUI:WndRegistScript(_QuiteGameBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnQuiteGameBtn")
    end






    local _QuestBtn = GUI:ButtonCreate(_GUIHandle, "jishou", 1612000044, 960, 175)
    if _QuestBtn ~= 0 then
        GUI:WndSetHint(_QuestBtn, "寄售系统")
        GUI:WndRegistScript(_QuestBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.jishou")
    end





    local _RoleBtn = GUI:ButtonCreate(_GUIHandle, "Roles", 1612000024, 840, 62)
    if _RoleBtn ~= 0 then
        GUI:WndSetHint(_RoleBtn, "角色(F10)")
        GUI:WndRegistScript(_RoleBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnRoleBtn")
    end

    local _PakageBtn = GUI:ButtonCreate(_GUIHandle, "Pakages", 1612000032, 885, 62)
    if _PakageBtn ~= 0 then
        GUI:WndSetHint(_PakageBtn, "包裹(F9)")
        GUI:WndRegistScript(_PakageBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnPakageBtn")
    end

    local _SkillBtn = GUI:ButtonCreate(_GUIHandle, "Skills", 1612000028, 930, 62)
    if _SkillBtn ~= 0 then
        GUI:WndSetHint(_SkillBtn, "技能(F10)")
        GUI:WndRegistScript(_SkillBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnSkillBtn")
    end

    local _GameMallBtn = GUI:ButtonCreate(_GUIHandle, "Shops", 1612000036, 975, 62)
    if _GameMallBtn ~= 0 then
        GUI:WndSetHint(_GameMallBtn, "游戏商城(Ctrl+B)")
        GUI:WndRegistScript(_GameMallBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.GameMallBtn")
    end











    local _MuteSoundBtn = GUI:ButtonCreate(_GUIHandle, "MuteSound", 1808900062, 982, 123)
    if _MuteSoundBtn ~= 0 then
        GUI:WndRegistScript(_MuteSoundBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnMuteSound")
    end

    local _AttackModeBtn = GUI:ButtonCreate(_GUIHandle, "AttackMode", 0, 875, 133)
    if _AttackModeBtn ~= 0 then
        GUI:WndSetSizeM(_AttackModeBtn, 116, 16)
        GUI:WndRegistScript(_AttackModeBtn, RDWndBaseCL_mouse_lbUp, "GameMainBar.OnAttackMode")
        local _Color = CL:MakeARGB(255, 194, 182, 160)
        GUI:WndSetTextColorM(_AttackModeBtn, _Color)
    end



    local _PlayerLevelEdit = GUI:EditCreate(_GUIHandle, "PlayerLevelEdit", 855, 131, 24, 19)
    if _PlayerLevelEdit ~= 0 then
        GUI:EditSetCanEdit(_PlayerLevelEdit, false)
        GUI:WndSetEnableM(_PlayerLevelEdit,false)
        GUI:EditSetFontCenter(_PlayerLevelEdit)
    end
    local _LevelInfo = GUI:EditCreate(_PlayerLevelEdit, "PlayerLeveltInfo", -65,-45, 24, 14)
    if _LevelInfo ~= 0 then
        GUI:EditSetCanEdit(_LevelInfo, false)
        GUI:WndSetEnableM(_LevelInfo,false)
        --GUI:EditSetTextM(_LevelInfo, "Lv:")
        GUI:EditSetTextColor(_LevelInfo, CL:MakeARGB(255,207,186,157))
    end

    local _HPInfo = GUI:EditCreate(_GUIHandle, "HPInfo", 3, 217, 74, 14)
    if _HPInfo ~= 0 then
        GUI:EditSetCanEdit(_HPInfo, false)
        GUI:WndSetEnableM(_HPInfo,false)
        GUI:EditSetFontCenter(_HPInfo)
    end

    local _MPInfo = GUI:EditCreate(_GUIHandle, "MPInfo", 86, 217, 74, 14)
    if _MPInfo ~= 0 then
        GUI:EditSetCanEdit(_MPInfo, false)
        GUI:WndSetEnableM(_MPInfo,false)
        GUI:EditSetFontCenter(_MPInfo)
    end

    local _MapInfo = GUI:EditCreate(_GUIHandle, "MapInfo", 5, 238, 161, 14)
    if _MapInfo ~= 0 then
        GUI:EditSetCanEdit(_MapInfo, false)
        GUI:EditSetFontCenter(_MapInfo)
    end

    local _MuteEdit = GUI:EditCreate(_GUIHandle, "MuteEdit", 994, 135, 74, 14)
    if _MuteEdit ~= 0 then
        GUI:EditSetCanEdit(_MuteEdit, false)
    end

    local _AngryMagicImage = GUI:ImageCreate(_GUIHandle, "AngryMagic", 1046700000, 823, 100)
    if _AngryMagicImage ~= 0 then
        GUI:ImageSetAnimateEnable(_AngryMagicImage, true, 100)
        GUI:WndSetCanRevMsg(_AngryMagicImage, false)
        GUI:ImageSetFitSize(_AngryMagicImage, true)
        GUI:WndSetSizeM(_AngryMagicImage, 7, 105)
    end

    local _PkgLeftCountImage = GUI:ImageCreate(_GUIHandle, "PkgLeftCount", 0, 901, 76)
    if _PkgLeftCountImage ~= 0 then
    end

    local _PlayerWeightEffect = GUI:ImageCreate(_GUIHandle, "PlayerWeightEffect", 1046800000, 843, 233)
    if _PlayerWeightEffect ~= 0 then
    end

    GameMainBar.UIInit(_GUIHandle)


end

--UI Logic Code Start
GameMainBar.WndHandle = 0
function GameMainBar.UIInit(_Parent)
    LuaGlobal["GameMainBar_BackImageYOff"] = 95   --主界面聊天框背景y轴位置
    GameMainBar.WndHandle = _Parent
    GameMainBar.UpdataScreenSize(_Parent)

    local _ImageHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "BackImage")
    if 0 ~= _ImageHandle then
        GUI:WndSetVisible(_ImageHandle, false)
        local _ImageID = GUI:WndGetImageID(_ImageHandle)
        if _ImageID == 1930000003 then
            CL:SetChatWindowIsWhite(true)
            CL:SetColorTableData(27, 10, 90, 0, 255)
            CL:SetGUIFormColorData(5, 10, 90, 0, 255)
        else
            CL:SetChatWindowIsWhite(false)
            CL:SetColorTableData(27, 44, 169, 71, 255)
            CL:SetGUIFormColorData(5, 44, 169, 71, 255)
        end
    end
    GameMainBar.heji()
    GameMainBar.zhansha()
    GameMainBar.UpdataSize()
    local _EditHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "MuteEdit")
    CL:OnSoundMute(_EditHandle)
    CL:OnSoundMute(_EditHandle)


    CL:AddDelayTask("GameMainBar.SetMaskImage()", 500, 1)
    local _GUIHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "HPEffect")
    if _GUIHandle ~= 0 then
        GUI:WndSetVisible(_GUIHandle, false)
    end
    local _GUIHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "MPEffect")
    if _GUIHandle ~= 0 then
        GUI:WndSetVisible(_GUIHandle, false)
    end
    local _GUIHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "EffectMask")
    if _GUIHandle ~= 0 then
        GUI:WndSetVisible(_GUIHandle, false)
    end
    GUI:WndAddTimerBrief(_Parent, 30, "GameMainBar.OnUpdata")
end


function GameMainBar.UpdataScreenSize(_ParentHandle)
    local UIPOS_CHANGEGUI = {
        "BackImage1",
        "jishou",
        "Pakages",
        "Role",
        "Roles",
        "Skills",
        "Quest",
        "PlayerWeight",
        "QuiteToLogin",
        "Quite",
        "Shops",
        "HeroList",
        "HeroPkg",
        "HeroProp",
        "HeroSkill",
        "SummonHero",
        "PkgLeftCount",
        "AttackMode",
        "PlayerLevelEdit",
        "PlayerEXP",
        "Angry",
        "MuteSound",
        "MuteEdit",
        "PlayerWeightEffect",
        "AngryMagic",
        "baojian",
        "baojian1",
    }

    local _DeviceSizeX = CL:GetScreenWidth()
    for _Idx = 1, #UIPOS_CHANGEGUI do
        local _GUIHandle = GUI:WndFindChildM(_ParentHandle, UIPOS_CHANGEGUI[_Idx])
        if 0 ~= _GUIHandle then
            if GUI:WndGetPosM(_GUIHandle) then
                local _XOldPos = LuaRet[1]
                local _YOldPos = LuaRet[2]
                local _XDiff = _DeviceSizeX - 1024
                GUI:WndSetPosM(_GUIHandle, _XOldPos + _XDiff, _YOldPos + 4)
            end
        end
    end


    --[[	local ssswww = {

    "Trade111",
    "MakeTeam111",
    "Contact111",
    "HangHui111",
    "Mail111",
    "Setting111",
    "ShowPlayer111",
    "guaji111",
        }
        local newX = CL:GetScreenWidth()
        for _Idx = 1, #ssswww do
            local _GUIHandle = GUI:WndFindChildM(_ParentHandle, ssswww[_Idx])
            if 0 ~= _GUIHandle then
                if GUI:WndGetPosM(_GUIHandle) then
                    local _XOldPos = LuaRet[1]
                    local _YOldPos = LuaRet[2]
            if newX < 1151 then
                GUI:WndSetPosM(_GUIHandle, newX / 2 -  490 + _XOldPos, _YOldPos + 4)
            elseif newX < 1300 then
                GUI:WndSetPosM(_GUIHandle, newX / 2 -  499 + _XOldPos, _YOldPos + 4)
            elseif newX < 1500 then
                GUI:WndSetPosM(_GUIHandle, newX / 2 -  500 + _XOldPos, _YOldPos + 4)
            else
                GUI:WndSetPosM(_GUIHandle, newX / 2 -  500 + _XOldPos, _YOldPos + 4)
            end


                    --local _XDiff = _DeviceSizeX - 1024 - 440
                    --GUI:WndSetPosM(_GUIHandle, _XOldPos + _XDiff, _YOldPos + 4)
                end
            end
        end--]]

end

function GameMainBar.guaji()
    UI:Lua_SubmitForm("自动挂机", "guaji", "")
end

function GameMainBar.jishou()
    UI:Lua_SubmitForm("自动挂机", "jishou", "")
end

function GameMainBar.SetMaskImage()
    -- CL:SetHPMPMaskImage(1808900123, 62, 75)
end

function GameMainBar.OnUpdata()
    local _BtnHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "Mail")
    if 0 ~= _BtnHandle then
        if CL:GetCallBackCount("新邮件提醒") > 0 then
            GUI:ButtonSetShine(_BtnHandle, true)
        else
            GUI:ButtonSetShine(_BtnHandle, false)
        end
    end

    _BtnHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "Trade")
    if 0 ~= _BtnHandle then
        if CL:GetCallBackCount("交易请求消息") > 0 then
            GUI:ButtonSetShine(_BtnHandle, true)
            local _ImageHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "TradeMagic")
            if 0 ~= _ImageHandle then
                if GUI:WndGetVisible(_ImageHandle) == false then
                    CL:SetGUIAnimate(_ImageHandle, true)
                end
            end
        else
            GUI:ButtonSetShine(_BtnHandle, false)
            local _ImageHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "TradeMagic")
            if 0 ~= _ImageHandle then
                CL:SetGUIAnimate(_ImageHandle, false)
            end
        end
    end

    _BtnHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "MakeTeam")
    if 0 ~= _BtnHandle then
        if CL:GetCallBackCount("组队请求消息") > 0 then
            GUI:ButtonSetShine(_BtnHandle, true)
            local _ImageHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "TeamMagic")
            if 0 ~= _ImageHandle then
                if GUI:WndGetVisible(_ImageHandle) == false then
                    CL:SetGUIAnimate(_ImageHandle, true)
                end
            end
        else
            GUI:ButtonSetShine(_BtnHandle, false)
            local _ImageHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "TeamMagic")
            if 0 ~= _ImageHandle then
                CL:SetGUIAnimate(_ImageHandle, false)
            end
        end
    end
end

function GameMainBar.OnContactBtn()
    CL:OnFriendWindow()
end

function GameMainBar.OnTradeBtn()
    local _BtnHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "Trade")
    if 0 ~= _BtnHandle then
        GUI:ButtonSetShine(_BtnHandle, false)
    end
    CL:OnTradeBtn()
end

function GameMainBar.OnTeamBtn()
    local _TeamBtnHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "MakeTeam")
    if 0 ~= _TeamBtnHandle then
        GUI:ButtonSetShine(_TeamBtnHandle, false)
    end
    CL:OnTeamBtn()
end

function GameMainBar.OnQuiteToLoginBtn()
    CL:QuiteToLogin()
end

function GameMainBar.OnQuiteGameBtn()
    CL:QuiteGame()
end

function GameMainBar.GameMallBtn()
    CL:OnGameMallWindow()
end


function GameMainBar.OnPakageBtn()
    CL:OnOpenPakage()
end

function GameMainBar.OnSkillBtn()
    local _HRoleGui = GetWindow(0, "RoleGUI")
    if _HRoleGui == 0 then
        CL:OnSkillWindow()
    else
        GUI:WndClose(_HRoleGui)
    end
end

function GameMainBar.OnQuestBtn()
    CL:OnQuestWindow()
end

function GameMainBar.OnHangHuiBtn()
    CL:OnFamilyWindow()
end

function GameMainBar.OnSettingBtn()
    CL:OnSettingWindow()
end

function GameMainBar.OnMailBtn()
    local _BtnHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "Mail")
    if 0 ~= _BtnHandle then
        GUI:ButtonSetShine(_BtnHandle, false)
    end
    CL:OnMailWindow()
end


function GameMainBar.OnRoleBtn()
    local _HRoleGui = GetWindow(0, "RoleGUI")
    if _HRoleGui == 0 then
        CL:OnRoleWindow()
    else
        GUI:WndClose(_HRoleGui)
    end
end


function GameMainBar.OnShowHideBtn()
    CL:OnShowHide()
end


function GameMainBar.OnRideBtn()
    CL:OnRide()
end


function GameMainBar.OnAddPropertyBtn()
    CL:OnEhanceRolePreperyWindow()
end


function GameMainBar.OnAchieveBtn()
    CL:OnAchieveWindow()
end


function GameMainBar.OnHeroList()
    CL:OnHeroListWindow()
end


function GameMainBar.OnHeroPakage()
    CL:OnHeroPakageWindow()
end

function GameMainBar.OnHeroProp()
    CL:OnHeroPropWindow()
end

function GameMainBar.OnSummomHero()
    CL:OnSummonHero()
end


function GameMainBar.OnMuteSound()
    local _EditHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "MuteEdit")
    CL:OnSoundMute(_EditHandle)
end


function GameMainBar.OnAttackMode()
    CL:OnAttackMode()
    endeveWindow()
end


function GameMainBar.OnHeroList()
    CL:OnHeroListWindow()
end


function GameMainBar.OnHeroPakage()
    CL:OnHeroPakageWindow()
end

function GameMainBar.OnHeroProp()
    CL:OnHeroPropWindow()
end

function GameMainBar.OnSummomHero()
    CL:OnSummonHero()
end


function GameMainBar.OnMuteSound()
    local _EditHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "MuteEdit")
    CL:OnSoundMute(_EditHandle)
end

function GameMainBar.OnRedPacketClicked()
    UI:Lua_OpenWindow(0, "RedPacketWnd.lua")
    GameMainBar.DelRedPacketBtnEffect()
end

function GameMainBar.AddRedPacketBtnEffect()
    _GUIHand = GetWindow(GameMainBar.WndHandle, "redPacketBtnMagic")
    if _GUIHand ~= 0 then
        GUI:WndSetVisible(_GUIHand, true)
    end
end

function GameMainBar.DelRedPacketBtnEffect()
    _GUIHand = GetWindow(GameMainBar.WndHandle, "redPacketBtnMagic")
    if _GUIHand ~= 0 then
        GUI:WndSetVisible(_GUIHand, false)
    end
end

function GameMainBar.ClientCenterMessage(str)
    UI:Lua_GetScreenSize()
    local x = LuaRet[1]/2-191
    local y = LuaRet[2]-200
    msg_tip(str,x,y)
end

GameMainBar.SendMsg = function(str, color)
    local handle = GetWindow(nil, "GameMainInterface,GameMainBar,消息框,内容");
    if handle == 0 then return end
    if color == nil then
        color = "WHITE";
    end

    GameMainBar_Msg[#GameMainBar_Msg+1] = "#COLORCOLOR_"..color.."#"..str.."#COLOREND#";
    local difline = #GameMainBar_Msg - 8;
    if difline > 0 then
        for j = 1, difline do
            table.remove(GameMainBar_Msg, 1);
        end
    end

    RichEditClear(handle);
    for _, v in ipairs(GameMainBar_Msg) do
        RichEditAppendString(handle, nil, v.."\n");
    end
end

GameMainBar.UpdataSize = function()
    local handle = GetWindow(nil, "GameMainInterface,GameMainBar");
    if handle == 0 then
        return;
    end
    local handle1 = GetWindow(handle, "zhansha");
    local handle2 = GetWindow(handle, "baojian");
    local handle3 = GetWindow(handle, "baojian1");
    local handle4 = GetWindow(handle, "zhansha1");
    local x1, y1 = WndGetPos(handle1);
    local x2, y2 = WndGetPos(handle2);
    local x3, y3 = WndGetPos(handle3);
    local x4, y4 = WndGetPos(handle4);
    local h = CL:GetScreenHeight()
    local h1 = 0
    if h > 768 then
        h1 = math.floor((h-768)/10)
    end
    if UI:Lua_GetScreenWidth() then
        x1 = math.floor(LuaRet*4/5) - 55;
        x2 = LuaRet/5 - 65;
        x3 = LuaRet/5 - 65;
        x4 = math.floor(LuaRet*4/5) - 55;
        y2 = math.floor(h/20) - h1
        y3 = math.floor(h/20) - h1
        WndSetPos(handle1, nil, x1, y1);
        WndSetPos(handle2, nil, x2, y2);
        WndSetPos(handle3, nil, x3, y3);
        WndSetPos(handle4, nil, x4, y4);
    end
end

function GameMainBar.fuhuo(bh)
    Handle = GameMainBar.WndHandle
    if bh == 0 then
        _GUIHandle = GUI:WndFindWindow(Handle, "fuhuo")
        GUI:WndSetVisible(_GUIHandle,false)
        _GUIHandle = GUI:WndFindWindow(Handle, "fuhuowenzi")
        GUI:WndSetVisible(_GUIHandle,false)
    else
        _GUIHandle = GUI:WndFindWindow(Handle, "fuhuo")
        GUI:WndSetVisible(_GUIHandle,true)
        _GUIHandle = GUI:WndFindWindow(Handle, "fuhuowenzi")
        GUI:WndSetVisible(_GUIHandle,true)
    end

end

function GameMainBar.OnAttackMode()
    CL:OnAttackMode()
end

function GameMainBar.zhansha()
    local _ImageHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "zhansha1")
    if _ImageHandle ~= 0 then
        local tip = "["..tipText(""..zhansha_tb[mv_level][1].."\n", "PURPLE","system")
        tip = tip ..tipText("------------------------------------------\n", "GRAY","system")
        tip = tip ..tipText(""..zhansha_tb[mv_level][2].."\n", "GREENG","system")
        tip = tip ..tipText("------------------------------------------\n", "GRAY","system")
        tip = tip ..tipText(""..zhansha_tb[mv_level][3].."\n", "BLUE","system")
        tip = tip ..tipText(""..zhansha_tb[mv_level][4].."\n", "BLUE","system")
        tip = tip.. "{}]"
        WndSetTipInfo(_ImageHandle, nil, tip)
    end
end

function GameMainBar.heji()
    local _ImageHandle = GUI:WndFindChildM(GameMainBar.WndHandle, "baojian1")
    if _ImageHandle ~= 0 then
        local tip = "["..tipText("进度条满后攻击自动释放合击\n", "YELLOW","system")
        tip = tip ..tipText("------------------------------\n", "GRAY","system")
        tip = tip ..tipText("打开美人面板可免费激活美人\n", "GREENG","system")
        tip = tip ..tipText("激活美人功能后即可领悟合击\n", "GREENG","system")
        tip = tip ..tipText("美人进阶可加快合击恢复速度\n", "GREENG","system")
        tip = tip ..tipText("------------------------------\n", "GRAY","system")
        tip = tip ..tipText("《"..zhansha_tb[mv_level][1].."》合击冷却时间："..skill_cd[mv_level].."\n", "BLUE","system")
        tip = tip.. "{}]"
        WndSetTipInfo(_ImageHandle, nil, tip)
    end
end

function GameMainBar.coolDown(num)
    local handle = GetWindow(nil, "GameMainInterface,GameMainBar");
    if handle == 0 then
        return;
    end
    local handle3 = GetWindow(handle, "zhansha1");
    GUI:ImageSetDrawRect(handle3,0,1,tonumber(1-num),1)
end

CL:SetAnimateData(3020800000,100)
GameMainBar.main()