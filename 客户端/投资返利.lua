<form>
<script><![CDATA[
fqpgrmuq = {}
fqpgrmuq.time_id = 0
fqpgrmuq.Init = function(this)
RichEditClear(this, "����")
RichEditAppendString(this, "����", fqpgrmuq_jiesao)
if fqpgrmuq.time_id == 0 then
if UI:Lua_AddDelayTask("fqpgrmuq.gengxin()", 1000, 0) then
fqpgrmuq.time_id = tonumber(LuaRet)
end
end
end

fqpgrmuq.gengxin = function(this)
RichEditClear(nil, "Ԫ��Ͷ��,ʱ��")
if tonumber(fqpgrmuq_Time) > 0 then
RichEditAppendString(nil, "Ԫ��Ͷ��,ʱ��", GetLeaveTimeString(fqpgrmuq_Time))
for i = 1, 3 do
ButtonSetProp(nil,"Ԫ��Ͷ��,Ͷ��"..i, true, true, true,1803700007)
ButtonSetProp(nil,"Ԫ��Ͷ��,��ȡ"..i, true, false, true,1803700007)
if fqpgrmuq_Ming[i][2] > 0 then
ButtonSetProp(nil,"Ԫ��Ͷ��,Ͷ��"..i, true, false, true,1803700007)
end
end

else
RichEditAppendString(nil, "Ԫ��Ͷ��,ʱ��", "Ͷ������ֹ")
for i = 1, 3 do
ButtonSetProp(nil,"Ԫ��Ͷ��,Ͷ��"..i, true, false, true,1803700007)
ButtonSetProp(nil,"Ԫ��Ͷ��,��ȡ"..i, true, false, true,1803700007)
if gotAward[i] ~= 1 then
ButtonSetProp(nil,"Ԫ��Ͷ��,��ȡ"..i, true, true, true,1803700007)
end
end
end

for i = 1 , #fqpgrmuq_Ming do
RichEditClear(nil, "Ԫ��Ͷ��,����"..i)
RichEditAppendString(nil, "Ԫ��Ͷ��,����"..i, tostring(fqpgrmuq_Ming[i][1]))
end


end

fqpgrmuq.OnMouseIn = function(this)
if CL:GetCurMapKeyName() ~= "��ɽ��" then
WndClose(nil,"Ԫ��Ͷ��")
end
end

fqpgrmuq.ok = function(this)
if CL:GetCurMapKeyName() ~= "��ɽ��" then
WndClose(nil,"Ԫ��Ͷ��")
return
end
local num = WndGetProperty(this, nil, "num")
UI:Lua_SubmitForm("Ԫ��Ͷ��", "rmuq", tostring(num))
end

fqpgrmuq.lq = function(this)
if CL:GetCurMapKeyName() ~= "��ɽ��" then
WndClose(nil,"Ԫ��Ͷ��")
return
end
local num = WndGetProperty(this, nil, "num")
UI:Lua_SubmitForm("Ԫ��Ͷ��", "wybc", tostring(num))
end

fqpgrmuq.uduf = function(this)
WndClose(nil, "Ԫ��Ͷ��")
end
]]></script>
<dialog id="Ԫ��Ͷ��" x="0" y="0" w="666" h="470" image="1801000001" title=""  fitsize="true" close="false" center="true"  OnMouseIn="fqpgrmuq.OnMouseIn" OnInit=fqpgrmuq.Init >
<richedit id="����" x=295 y=25 w=440 h=50 text="Ԫ��Ͷ��" font=SIMLI18 text_color="GOLD2" />
<button id="�ر�" x="620" y="30" w="50" h="50" image="1803400011" text_color="GOLD" OnLButtonClick="fqpgrmuq.uduf" />
<image id="�ͼƬ" image="1801500032" x="65" y="80" w="81" h="29" fitsize="true"  />
<richedit id="ʱ��" x=60 y=120 w=440 h=50 text="" font=SIMLI18 text_color="GREENG" />
<image id="����Ƭ" image="1806000001" x="33" y="160" w="598" h="280" fitsize="true"  />
<image id="��ͼ1" image="1805000002" x="38" y="170" w="60" h="33" fitsize="true" />
<image id="��ͼ2" image="1805000002" x="100" y="170" w="130" h="33" fitsize="true" />
<image id="��ͼ3" image="1805000002" x="232" y="170" w="130" h="33" fitsize="true" />
<image id="��ͼ4" image="1805000002" x="363" y="170" w="130" h="33" fitsize="true" />
<image id="��ͼ5" image="1805000002" x="494" y="170" w="130" h="33" fitsize="true" />

<richedit id="�༭��1" x=50 y=185 w=480 h=50 text="���" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="�༭��2" x=125 y=185 w=480 h=50 text="Ͷ��Ԫ��" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="�༭��3" x=257 y=185 w=480 h=50 text="����ʣ��" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="�༭��4" x=385 y=185 w=480 h=50 text="ȷ��Ͷ��" font=SIMLI18 text_color="SKYBLUE" />
<richedit id="�༭��5" x=519 y=185 w=480 h=50 text="��ȡ����" font=SIMLI18 text_color="SKYBLUE" />

<image id="����1" image="1803800035" x="98" y="170" w="3" h="255" fitsize="true" />
<image id="����2" image="1803800035" x="230" y="170" w="3" h="255" fitsize="true" />
<image id="����3" image="1803800035" x="362" y="170" w="3" h="255" fitsize="true" />
<image id="����4" image="1803800035" x="493" y="170" w="3" h="255" fitsize="true" />

<image id="����1" image="1904500008" x="40" y="260" w="584" h="2" fitsize="true" />
<image id="����2" image="1904500008" x="40" y="325" w="584" h="2" fitsize="true" />

<image id="����1" image="1801500039" x="55" y="215" w="20" h="29" fitsize="false"  />
<image id="����2" image="1801500040" x="55" y="280" w="20" h="29" fitsize="false"  />
<image id="����3" image="1801500041" x="55" y="340" w="20" h="29" fitsize="false"  />

<richedit id="Ԫ��1" x=145 y=220 w=440 h=50 text="50000" font=SIMLI18 text_color="ORANGE" />
<richedit id="Ԫ��2" x=145 y=285 w=440 h=50 text="30000" font=SIMLI18 text_color="ORANGE" />
<richedit id="Ԫ��3" x=145 y=345 w=440 h=50 text="10000" font=SIMLI18 text_color="ORANGE" />

<richedit id="����1" x=285 y=220 w=440 h=50 text="" font=SIMLI18 text_color="ORANGE" />
<richedit id="����2" x=285 y=285 w=440 h=50 text="" font=SIMLI18 text_color="ORANGE" />
<richedit id="����3" x=285 y=345 w=440 h=50 text="" font=SIMLI18 text_color="ORANGE" />

<button id="Ͷ��1" x="385" y="215" image="1803700007" num=1 text="Ͷ  ��" text_color="BROWN" OnLButtonClick="fqpgrmuq.ok" />
<button id="Ͷ��2" x="385" y="275" image="1803700007" num=2 text="Ͷ  ��" text_color="BROWN" OnLButtonClick="fqpgrmuq.ok" />
<button id="Ͷ��3" x="385" y="335" image="1803700007" num=3 text="Ͷ  ��" text_color="BROWN" OnLButtonClick="fqpgrmuq.ok" />

<button id="��ȡ1" x="515" y="215" image="1803700007" num=1 text="��ȡ����" text_color="BROWN" OnLButtonClick="fqpgrmuq.lq" />
<button id="��ȡ2" x="515" y="275" image="1803700007" num=2 text="��ȡ����" text_color="BROWN" OnLButtonClick="fqpgrmuq.lq" />
<button id="��ȡ3" x="515" y="335" image="1803700007" num=3 text="��ȡ����" text_color="BROWN" OnLButtonClick="fqpgrmuq.lq" />

<image id="���׻�1" image="3020010000" x="18" y="350" w="300" h="100" type="animate" fitsize="true"  />
<image id="���׻�2" image="3020010000" x="238" y="350" w="300" h="100" type="animate" fitsize="true"  />
<image id="���׻�3" image="3020010000" x="458" y="350" w="190" h="100" type="animate" fitsize="true"  />
<richedit id="����" x=160 y=85 w=445 h=50 font=SIMLI18 text="" />



</dialog>
</form>