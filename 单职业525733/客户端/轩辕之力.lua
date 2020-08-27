violent = {}
local _Handle = 0
function violent.main()
    local handle = GetWindow(nil, "frameViolent")
    if handle ~= 0 then WndClose(handle) return end
    local str = [[
		<form>
			<dialog id="frameViolent" image="0" w="500" h="600" x="0" y="0" close="false" esc_close="true" drag="true" center="true" revmsg="true" OnInit="violent.Init" magic="1">
				<wnd id="wnd1" x="6" y="2" w="500" h="600">
					<image id="wnd1_Img1" x="0" y="0" w="500" h="600" image="4000010000" fitsize="true" gray="false" />
					<image id="wnd1_Img2" x="0" y="145" w="500" h="420" image="4000110000" fitsize="true" gray="false" />
					<image id="wnd1_Img3" x="103" y="121" w="53" h="150" image="1813000040" fitsize="true" gray="false" />
					<richedit id="wnd1_txt1" x="118" y="137" w="30" h="100" text="轩辕之力" text_color="DARKGOLD" canedit="false" font="SIMLI18" />
					<image id="wnd1_Img4" x="280" y="275" w="140" h="140" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" type="around" />
					<image id="wnd1_Img5" x="100" y="285" w="150" h="150" image="1803900003" fitsize="true" gray="false"  />
					<richedit id="wnd1_txt2" x="98" y="290" w="90" h="20" text="增加属性:" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd1_txt3" x="98" y="320" w="90" h="20" text="增加属性:" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd1_txt4" x="98" y="350" w="90" h="20" text="增加属性:" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd1_txt5" x="98" y="380" w="90" h="20" text="增加属性:" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd1_txt6" x="98" y="410" w="90" h="20" text="增加属性:" text_color="DARKGOLD" canedit="false" font="system" />

					<richedit id="wnd1_txt7" x="158" y="290" w="120" h="20" text="致命一击+1%" text_color="WHITE" canedit="false" font="system" />
					<richedit id="wnd1_txt8" x="158" y="320" w="120" h="20" text="攻击伤害+5%" text_color="WHITE" canedit="false" font="system" />
					<richedit id="wnd1_txt9" x="158" y="350" w="120" h="20" text="生命上限+10%" text_color="WHITE" canedit="false" font="system" />
					<richedit id="wnd1_txt10" x="158" y="380" w="120" h="20" text="怪物爆率+5%" text_color="WHITE" canedit="false" font="system" />
					<richedit id="wnd1_txt11" x="158" y="410" w="120" h="20" text="自身防爆+5%" text_color="WHITE" canedit="false" font="system" />

					<richedit id="wnd1_txt12" x="328" y="270" w="100" h="20" text="温馨提示" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd1_txt13" x="290" y="300" w="120" h="100" text="轩辕之力一旦开启，除非死亡，否则一直生效，下线保存轩辕之力，击杀携带轩辕之力者获得34444元宝奖励" text_color="DARKGOLD" canedit="false" font="system" />

					<richedit id="wnd1_txt15" x="98" y="450" w="100" h="20" text="当前状态:" text_color="BROWN2" canedit="false" font="system" />
					<image id="wnd1_bgk1" x="160" y="448" w="100" h="20"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
					<richedit id="wnd1_txt16" x="170" y="451" w="80" h="20" text="暂未开启" text_color="RED" font="system"/>

					<richedit id="wnd1_txt17" x="98" y="480" w="100" h="20" text="元宝开启:" text_color="BROWN2" canedit="false" font="system" />
					<image id="wnd1_bgk2" x="160" y="478" w="100" h="20"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
					<richedit id="wnd1_txt18" x="170" y="481" w="80" h="20" text="68888" text_color="BGREENG" font="system"/>

					<richedit id="wnd1_txt19" x="85" y="510" w="110" h="20" text="轩辕币开启:" text_color="BROWN2" canedit="false" font="system" />
					<image id="wnd1_bgk3" x="160" y="508" w="100" h="20"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
					<richedit id="wnd1_txt20" x="170" y="511" w="80" h="20" text="20" text_color="BGREENG" font="system"/>
					<button id="wnd1_btn1" x="280" y="440" image="1807900003" text="元宝开启" shine="true" text_color="GOLD2" param="1" OnLButtonClick="violent.submit" />
					<button id="wnd1_btn2" x="280" y="490" image="1807900003" text="轩辕币开启" shine="true" text_color="GOLD2" param="2" OnLButtonClick="violent.submit" />
				</wnd>
				<button id="wndColse" x="380" y="40" w="137" h="47" image="4000230000"  OnLButtonClick="violent.close"/>
			</dialog>
		</form>
	]]
    GenFormByString(str)
    _Handle = GetWindow(0,"frameViolent,wnd1")
    local _ImgHandle =  GetWindow(_Handle,"wnd1_Img4")
    GUI:ImageSetAlpha(_ImgHandle,150)

	local _EditHandle = GetWindow(_Handle,"wnd1_txt16")
	if _EditHandle ~= 0 then
		GUI:RichEditClear(_EditHandle)
		GUI:RichEditAppendString(_EditHandle,"已开启")
	end

end

function violent.Init(this)

end

function violent.submit(this)
	local num = GUI:WndGetParam(this)
	UI:Lua_SubmitForm("轩辕之力", "receive", tostring(num))
end

function violent.close(this)
    WndClose(0,"frameViolent")
end

function violent.update()
	local _EditHandle = GetWindow(_Handle,"wnd1_txt16")
	if _EditHandle ~= 0 then
		GUI:RichEditClear(_EditHandle)
		GUI:RichEditAppendString(_EditHandle,"已开启")
	end
end

violent.main()