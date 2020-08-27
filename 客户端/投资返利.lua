<form>
<script><![CDATA[
fqpgrmuq = {}
fqpgrmuq.time_id = 0
fqpgrmuq.Init = function(this)
RichEditClear(this, "介绍")
RichEditAppendString(this, "介绍", fqpgrmuq_jiesao)
if fqpgrmuq.time_id == 0 then
if UI:Lua_AddDelayTask("fqpgrmuq.gengxin()", 1000, 0) then
fqpgrmuq.time_id = tonumber(LuaRet)
end
end
end

fqpgrmuq.gengxin = function(this)
RichEditClear(nil, "元宝投资,时间")
if tonumber(fqpgrmuq_Time) > 0 then
RichEditAppendString(nil, "元宝投资,时间", GetLeaveTimeString(fqpgrmuq_Time))
for i = 1, 3 do
ButtonSetProp(nil,"元宝投资,投资"..i, true, true, true,1803700007)
ButtonSetProp(nil,"元宝投资,领取"..i, true, false, true,1803700007)
if fqpgrmuq_Ming[i][2] > 0 then
ButtonSetProp(nil,"元宝投资,投资"..i, true, false, true,1803700007)
end
end

else
RichEditAppendString(nil, "元宝投资,时间", "投资已终止")
for i = 1, 3 do
ButtonSetProp(nil,"元宝投资,投资"..i, true, false, true,1803700007)
ButtonSetProp(nil,"元宝投资,领取"..i, true, false, true,1803700007)
if gotAward[i] ~= 1 then
ButtonSetProp(nil,"元宝投资,领取"..i, true, true, true,1803700007)
end
end
end

for i = 1 , #fqpgrmuq_Ming do
RichEditClear(nil, "元宝投资,名额"..i)
RichEditAppendString(nil, "元宝投资,名额"..i, tostring(fqpgrmuq_Ming[i][1]))
end


end

fqpgrmuq.OnMouseIn = function(this)
if CL:GetCurMapKeyName() ~= "巫山城" then
WndClose(nil,"元宝投资")
end
end

fqpgrmuq.ok = function(this)
if CL:GetCurMapKeyName() ~= "巫山城" then
WndClose(nil,"元宝投资")
return
end
local num = WndGetProperty(this, nil, "num")
UI:Lua_SubmitForm("元宝投资", "rmuq", tostring(num))
end

fqpgrmuq.lq = function(this)
if CL:GetCurMapKeyName() ~= "巫山城" then
WndClose(nil,"元宝投资")
return
end
local num = WndGetProperty(this, nil, "num")
UI:Lua_SubmitForm("元宝投资", "wybc", tostring(num))
end

fqpgrmuq.uduf = function(this)
WndClose(nil, "元宝投资")
end
]]></script>
<dialog id="元宝投资" x="0" y="0" w="666" h="470" image="1801000001" title=""  fitsize="true" close="false" center="true"  OnMouseIn="fqpgrmuq.OnMouseIn" OnInit=fqpgrmuq.Init >
<richedit id="标题" x=295 y=25 w=440 h=50 text="元宝投资" font=SIMLI18 text_color="GOLD2" />
<button id="关闭" x="620" y="30" w="50" h="50" image="1803400011" text_color="GOLD" OnLButtonClick="fqpgrmuq.uduf" />
<image id="活动图片" image="1801500032" x="65" y="80" w="81" h="29" fitsize="true"  />
<richedit id="时间" x=60 y=120 w=440 h=50 text="" font=SIMLI18 text_color="GREENG" />
<image id="面板底片" image="1806000001" x="33" y="160" w="598" h="280" fitsize="true"  />
<image id="底图1" image="1805000002" x="38" y="170" w="60" h="33" fitsize="true" />
<image id="底图2" image="1805000002" x="100" y="170" w="130" h="33" fitsize="true" />
<image id="底图3" image="1805000002" x="232" y="170" w="130" h="33" fitsize="true" />
<image id="底图4" image="1805000002" x="363" y="170" w="130" h="33" fitsize="true" />
<image id="底图5" image="1805000002" x="494" y="170" w="130" h="33" fitsize="true" />

<richedit id="编辑框1" x=50 y=185 w=480 h=50 text="序号" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="编辑框2" x=125 y=185 w=480 h=50 text="投资元宝" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="编辑框3" x=257 y=185 w=480 h=50 text="名额剩余" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="编辑框4" x=385 y=185 w=480 h=50 text="确定投资" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="编辑框5" x=519 y=185 w=480 h=50 text="领取返利" font=SIMLI18 text_color="SKYBLUE" />

<image id="竖线1" image="1803800035" x="98" y="170" w="3" h="255" fitsize="true" />
<image id="竖线2" image="1803800035" x="230" y="170" w="3" h="255" fitsize="true" />
<image id="竖线3" image="1803800035" x="362" y="170" w="3" h="255" fitsize="true" />
<image id="竖线4" image="1803800035" x="493" y="170" w="3" h="255" fitsize="true" />

<image id="横线1" image="1904500008" x="40" y="260" w="584" h="2" fitsize="true" />
<image id="横线2" image="1904500008" x="40" y="325" w="584" h="2" fitsize="true" />

<image id="数字1" image="1801500039" x="55" y="215" w="20" h="29" fitsize="false"  />
<image id="数字2" image="1801500040" x="55" y="280" w="20" h="29" fitsize="false"  />
<image id="数字3" image="1801500041" x="55" y="340" w="20" h="29" fitsize="false"  />

<richedit id="元宝1" x=145 y=220 w=440 h=50 text="50000" font=SIMLI18 text_color="ORANGE" />
<richedit id="元宝2" x=145 y=285 w=440 h=50 text="30000" font=SIMLI18 text_color="ORANGE" />
<richedit id="元宝3" x=145 y=345 w=440 h=50 text="10000" font=SIMLI18 text_color="ORANGE" />

<richedit id="名额1" x=285 y=220 w=440 h=50 text="" font=SIMLI18 text_color="ORANGE" />
<richedit id="名额2" x=285 y=285 w=440 h=50 text="" font=SIMLI18 text_color="ORANGE" />
<richedit id="名额3" x=285 y=345 w=440 h=50 text="" font=SIMLI18 text_color="ORANGE" />

<button id="投资1" x="385" y="215" image="1803700007" num=1 text="投  资" text_color="BROWN" OnLButtonClick="fqpgrmuq.ok" />
<button id="投资2" x="385" y="275" image="1803700007" num=2 text="投  资" text_color="BROWN" OnLButtonClick="fqpgrmuq.ok" />
<button id="投资3" x="385" y="335" image="1803700007" num=3 text="投  资" text_color="BROWN" OnLButtonClick="fqpgrmuq.ok" />

<button id="领取1" x="515" y="215" image="1803700007" num=1 text="领取返利" text_color="BROWN" OnLButtonClick="fqpgrmuq.lq" />
<button id="领取2" x="515" y="275" image="1803700007" num=2 text="领取返利" text_color="BROWN" OnLButtonClick="fqpgrmuq.lq" />
<button id="领取3" x="515" y="335" image="1803700007" num=3 text="领取返利" text_color="BROWN" OnLButtonClick="fqpgrmuq.lq" />

<image id="面板底火1" image="3020010000" x="18" y="350" w="300" h="100" type="animate" fitsize="true"  />
<image id="面板底火2" image="3020010000" x="238" y="350" w="300" h="100" type="animate" fitsize="true"  />
<image id="面板底火3" image="3020010000" x="458" y="350" w="190" h="100" type="animate" fitsize="true"  />
<richedit id="介绍" x=160 y=85 w=445 h=50 font=SIMLI18 text="" />



</dialog>
</form>