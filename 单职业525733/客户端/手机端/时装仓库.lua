warehouse = {}
local _Handle = 0
local txt = {
    "ʱװ�ֿ�ɴ��25��ʱװ�����������������⣬���뵽5.10.15.20���ܶ���������",
    "����������ϸ˵��:",
    "��ͨʱװ����:",
    "S��ʱװ����:",
    "ÿ������2-2������",
    "ÿ������5-5������",
    "�������������ϸ˵��:",
    "��ͨʱװ 5��:",
    "��ͨʱװ10��:",
    "��ͨʱװ15��:",
    "��ͨʱװ20��:",
    "��ͨʱװ25��:",
    "S ��ʱװ 5��:",
    "S ��ʱװ10��:",
    "S ��ʱװ15��:",
    "S ��ʱװ20��:",
    "S ��ʱװ25��:",
    "����.ħ��: 5-5  ׼ȷ+2",
    "����.ħ��:10-10 ׼ȷ+4",
    "����.ħ��:15-15 ׼ȷ+6  ��������+1% �����˺�+2%",
    "����.ħ��:20-20 ׼ȷ+8  ��������+2% �����˺�+3%",
    "����.ħ��:25-25 ׼ȷ+10 ��������+3% �����˺�+4%",
    "����.ħ��:10-10 ׼ȷ+4",
    "����.ħ��:20-20 ׼ȷ+8",
    "����.ħ��:30-30 ׼ȷ+12 ��������+1% �����˺�+2%",
    "����.ħ��:40-40 ׼ȷ+16 ��������+2% �����˺�+3%",
    "����.ħ��:50-50 ׼ȷ+20 ��������+3% �����˺�+4%",
}
function warehouse.main()
    local handle = GetWindow(nil, "frameWarehouse")
    if handle ~= 0 then WndClose(handle) return end
    local str = [[
		<form>
			<dialog id="frameWarehouse" image=""  w="800" h="580" x="0" y="0" close="false" esc_close="true" drag="true" center="true" revmsg="true" OnInit="warehouse.Init" magic="1">
				<image id="Img1" x="16" y="-6" w="775" h="596" image="4000800000" fitsize="true" gray="false" />
				<richedit id="Txt1" x="343" y="50" w="100" h="30" text="ʱװ�ֿ�" text_color="GOLD" canedit="false" font="SIMLI18" />
				<wnd id="wnd1" x="0" y="0" w="800" h="580">
					<image id="wnd1_Img2" x="80" y="120" w="640" h="410" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd1_Img3" x="81" y="190" w="639" h="2" image="1801800025" fitsize="true" gray="false" />
					<image id="wnd1_Img4" x="81" y="260" w="639" h="2" image="1801800025" fitsize="true" gray="false" />
					<image id="wnd1_Img5" x="81" y="330" w="639" h="2" image="1801800025" fitsize="true" gray="false" />
					<image id="wnd1_Img6" x="81" y="400" w="639" h="2" image="1801800025" fitsize="true" gray="false" />
					<image id="wnd1_Img7" x="81" y="470" w="639" h="2" image="1801800025" fitsize="true" gray="false" />
					<image id="wnd1_Img8" x="81" y="530" w="639" h="2" image="1801800025" fitsize="true" gray="false" />

					<image id="wnd1_Img9" x="208" y="122" w="2" h="410" image="1803900022" fitsize="true" gray="false" />
					<image id="wnd1_Img10" x="336" y="122" w="2" h="410" image="1803900022" fitsize="true" gray="false" />
					<image id="wnd1_Img11" x="464" y="122" w="2" h="410" image="1803900022" fitsize="true" gray="false" />
					<image id="wnd1_Img12" x="592" y="122" w="2" h="410" image="1803900022" fitsize="true" gray="false" />

					<image id="wnd1_Img13" x="90" y="125" w="60" h="60" image="1803900001" fitsize="true" gray="false" />
					<image id="wnd1_Img14" x="218" y="125" w="60" h="60" image="1803900001" fitsize="true" gray="false" />
					<image id="wnd1_Img14" x="346" y="125" w="60" h="60" image="1803900001" fitsize="true" gray="false" />
					<image id="wnd1_Img14" x="218" y="125" w="60" h="60" image="1803900001" fitsize="true" gray="false" />
					<image id="wnd1_Img14" x="218" y="125" w="60" h="60" image="1803900001" fitsize="true" gray="false" />
					<richedit id="wnd1_Txt2" x="90" y="475" w="600" h="30" text=]]..txt[1]..[[ text_color="DARK" canedit="false" font="SIMLI18"  />
					<richedit id="wnd1_Txt3" x="550" y="500" w="100" h="30" text="��ϸ���" text_color="GOLD" canedit="false" font="SIMLI18" revmsg="true" param="1" OnLButtonClick="warehouse.detailed"/>
				</wnd>
				<wnd id="wnd2" x="0" y="0" w="800" h="580">
					<image id="wnd2_Img1" x="80" y="120" w="640" h="410" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd2_Img2" x="81" y="470" w="639" h="2" image="1801800025" fitsize="true" gray="false" />
					<richedit id="wnd2_Txt1" x="90" y="475" w="600" h="30" text=]]..txt[1]..[[ text_color="DARK" canedit="false" font="SIMLI18"/>
					<richedit id="wnd2_Txt2" x="550" y="500" w="100" h="30" text="������ҳ" text_color="GOLD" canedit="false" font="SIMLI18" revmsg="true" param="2" OnLButtonClick="warehouse.detailed"/>
					<richedit id="wnd2_Txt3" x="90" y="130" w="180" h="30" text=]]..txt[2]..[[ text_color="YELLOW" canedit="false" font="system"/>
					<richedit id="wnd2_Txt4" x="90" y="155" w="130" h="30" text=]]..txt[3]..[[ text_color="DARK" canedit="false" font="system"/>
					<richedit id="wnd2_Txt5" x="90" y="180" w="130" h="30" text=]]..txt[4]..[[ text_color="DARK" canedit="false" font="system"/>
					<richedit id="wnd2_Txt6" x="210" y="155" w="200" h="30" text=]]..txt[5]..[[ text_color="GREENG" canedit="false" font="system"/>
					<richedit id="wnd2_Txt7" x="210" y="180" w="200" h="30" text=]]..txt[6]..[[ text_color="GREENG" canedit="false" font="system"/>
					<richedit id="wnd2_Txt8" x="90" y="205" w="200" h="30" text=]]..txt[7]..[[ text_color="YELLOW" canedit="false" font="system"/>

				</wnd>
				<button id="wndColse" x="630" y="40" w="137" h="47" image="4000230000"  OnLButtonClick="warehouse.close" />
			</dialog>
		</form>
	]]
    GenFormByString(str)
end

function warehouse.Init(this)			--��ʼ��

    _Handle = GetWindow(0,"frameWarehouse,wnd1")
    local num = 0
    local positionY = 0		--λ��Y
    local positionX = 0
    for j=1 ,5 do
        for i = 1,5 do
            num = 12
            positionY = 125
            positionX = 90
            local _ImgHandle = GUI:ImageCreate(_Handle,"wnd1_Img"..(num + (j-1)*5 +i),1803900001,positionX+(i-1)*128,positionY + (j-1)*70)--������Ʒ���ͼ
            if _ImgHandle ~= 0 then
                GUI:WndSetSizeM(_ImgHandle,60,60)
                GUI:ImageSetFitSize(_ImgHandle,true)
            end

            num = 0
            positionY = 135
            positionX = 100
            local _ItemHandle = GUI:ItemCtrlCreate(_Handle,"wnd1_Item"..(num + (j-1)*5 +i),0,positionX+(i-1)*128,positionY + (j-1)*70,45,45)--������Ʒ��
            if _ItemHandle ~= 0 then
                RDItemCtrlSetProp(_ItemHandle,"",true,false,true,true,false,true)
            end

            num = 1
            positionY = 130
            positionX = 160
            local _EditHandle = GUI:RichEditCreate(_Handle,"wnd1_Edit"..(num + (j-1)*5 +i),positionX+(i-1)*128,positionY + (j-1)*70,60,30)
            if _EditHandle ~= 0 then
                GUI:WndSetParam(_EditHandle,(j-1)*5 + i)
                GUI:WndRegistScript(_EditHandle,RDWndBaseCL_mouse_lbUp,"warehouse.depositUp")
                RichEditSetProp(_EditHandle,"",true,false,true,SIMLI18,GUI:MakeColor(255, 0, 255, 255),"����")
            end


            num = 26
            positionY = 155
            positionX = 160
            local _EditHandle = GUI:RichEditCreate(_Handle,"wnd1_Edit"..(num + (j-1)*5 +i),positionX+(i-1)*128,positionY + (j-1)*70,60,30)
            if _EditHandle ~= 0 then
                GUI:WndSetParam(_EditHandle,(j-1)*5 + i)
                GUI:WndRegistScript(_EditHandle,RDWndBaseCL_mouse_lbUp,"warehouse.retrieveUp")
                RichEditSetProp(_EditHandle,"",true,false,true,SIMLI18,GUI:MakeColor(255, 0, 255, 255),"ȡ��")
            end

        end
    end

    for i = 1,25 do

        if accessTable[i] ~= 0 then
            local _ItemHandle = GetWindow(_Handle,"wnd1_Item"..i)

            if _ItemHandle ~= 0 then
                RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashion[accessTable[i]][1],1,false)
            end
        end
    end

    local _WndHandle = GetWindow(0,"frameWarehouse,wnd2")
    if _WndHandle ~= 0 then
        GUI:WndSetVisible(_WndHandle,false)
    end
end

function warehouse.close(this)		--�رմ���
    WndClose(0,"frameWarehouse")
end

function warehouse.depositUp(this)
    local num = GUI:WndGetParam(this)
    UI:Lua_SubmitForm("ʱװ�ֿ��", "deposit", tostring(num))
end

function warehouse.retrieveUp(this)
    local num = GUI:WndGetParam(this)
    UI:Lua_SubmitForm("ʱװ�ֿ��", "retrieve", tostring(num))
end

function warehouse.update()		--���´���
    local _ItemHandle = GetWindow(_Handle,"wnd1_Item"..number)
    if _ItemHandle ~= 0 then
        RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashion[position][1],1,false)
    end
end

function warehouse.fashionClear()		--����ȡ��
    local _ItemHandle = GetWindow(_Handle,"wnd1_Item"..number)
    if _ItemHandle ~= 0 then
        GUI:ItemCtrlClearItemData(_ItemHandle)
    end
end

function warehouse.detailed(this)
    local num = GUI:WndGetParam(this)
    local positionY = 0		--λ��Y
    local positionX = 0
    if num == 1 then
        local _WndHandle = GetWindow(0,"frameWarehouse,wnd1")
        if _WndHandle ~= 0 then
            GUI:WndSetVisible(_WndHandle,false)
        end

        local _WndHandle = GetWindow(0,"frameWarehouse,wnd2")
        if _WndHandle ~= 0 then
            GUI:WndSetVisible(_WndHandle,true)
        end

        for i=1,10 do
            num = 8
            positionX = 90
            positionY = 230
            local _WndHandle = GetWindow(0,"frameWarehouse,wnd2")
            local _EditHandle = GUI:RichEditCreate(_WndHandle,"wnd2_txt"..(num + i),positionX,positionY + (i-1)*25,150,30)
            if _EditHandle ~= 0 then
                RichEditSetProp(_EditHandle,"",true,false,true,system,GUI:MakeColor(255, 0, 255, 255),txt[i+7])
            end

            num = 18
            positionX = 225
            positionY = 230
            local _WndHandle = GetWindow(0,"frameWarehouse,wnd2")
            local _EditHandle = GUI:RichEditCreate(_WndHandle,"wnd2_txt"..(num + i),positionX,positionY + (i-1)*25,500,30)
            if _EditHandle ~= 0 then
                RichEditSetProp(_EditHandle,"",true,false,true,system,GUI:MakeColor(255, 0, 255, 255),txt[i+17])
            end
        end

    else
        local _WndHandle = GetWindow(0,"frameWarehouse,wnd2")
        if _WndHandle ~= 0 then
            GUI:WndSetVisible(_WndHandle,false)
        end

        local _WndHandle = GetWindow(0,"frameWarehouse,wnd1")
        if _WndHandle ~= 0 then
            GUI:WndSetVisible(_WndHandle,true)
        end
    end

end

warehouse.main()