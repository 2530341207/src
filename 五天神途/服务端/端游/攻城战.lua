<form >
<script><![CDATA[
gcz = {}
gcz.hh = FormParam[1]
gcz.cz = FormParam[2]
gcz.zl1 = FormParam[3]
gcz.zl2 = FormParam[4]

gcz.Init = function(this)
---------------------------------------���ô���ID
local zhixing = 0
local QXID = {1729}--����ID��
if not UI:Lua_GetAgentID() then WndClose(this) end
local SID = LuaRet
for i = 1 , #QXID do
if QXID[i] == tonumber(SID) then
zhixing = 1
end
end

if zhixing == 0 then
MessageBox(MESSAGE_STYLE_OK, "Ȩ�޲��㣬���ҵۺ���;��QQ��964561888������!!")
WndClose(this)
end
-------------------------------------------------------
RichEditClear(nil, "����ս,����")
RichEditAppendString(nil, "����ս,����", gcz.hh.."")

RichEditClear(nil, "����ս,������")
RichEditAppendString(nil, "����ս,������", gcz.cz.."")

RichEditClear(nil, "����ս,����������")
RichEditAppendString(nil, "����ս,����������", gcz.zl1.."")

RichEditClear(nil, "����ս,����������")
RichEditAppendString(nil, "����ս,����������", gcz.zl2.."")

t = deserialize(FormParam[5])

local msg1 = "���ڹ��ǻ�������£�";
msg1 = msg1 .. "Ԫ��������";
msg1 = msg1 .. t.ingot;
msg1 = msg1 .. "�̶�������";
for _, v in ipairs(t[1]) do
msg1 = msg1 .. v[1].."*"..v[2].." ";
end
msg1 = msg1 .. "����������ɵ�����֮һ����";
for _, u in ipairs(t[2]) do
msg1 = msg1 .. u[1].."*"..u[2].." ";
end

tishi = deserialize(FormParam[6])

script = [[<form default_parent=����ս>]]
script = script..[[<button id="ǰ������" image="1803600005" x="70" y="395" num=1 tip="��Ҫ]]..tishi[1][1]..[[���" OnLButtonClick="gcz.OK"

/>]]
script = script..[[<button id="1�ŵ�" x="260" y="390" w="50" h="50" image="1803900005" text="����һ�ŵ�" text_color="GOLD" num=2 tip="��

Ҫ]]..tishi[2][1]..[[���" OnLButtonClick="gcz.OK" />]]
script = script..[[<button id="2�ŵ�" x="380" y="390" w="50" h="50" image="1803900005" text="���Ƕ��ŵ�" text_color="GOLD" num=3 tip="��

Ҫ]]..tishi[3][1]..[[���" OnLButtonClick="gcz.OK" />]]
script = script..[[<button id="3�ŵ�" x="500" y="390" w="50" h="50" image="1803900005" text="�������ŵ�" text_color="GOLD" num=4 tip="��

Ҫ]]..tishi[4][1]..[[���" OnLButtonClick="gcz.OK" />]]
script = script..[[</form>]]
GenFormByString(script)
end

gcz.uduf = function(this)
WndClose(nil, "����ս")
end

gcz.OK = function(this)
local num = tonumber(WndGetProperty(this, nil, "num"))
UI:Lua_SubmitForm("����ս", "wfudhk", ""..num)
WndClose(nil, "����ս")

end

gcz.mobai = function(this)
UI:Lua_SubmitForm("���������", "update", "")
end

gcz.wybc = function(this)
UI:Lua_SubmitForm("����ս", "wybcuqdd", "")
end
]]></script>
<dialog id="����ս" x="0" y="0" w="666" h="470" image="1803600000" title=""  fitsize="true" close="false" center="true" OnInit=gcz.Init >
<button id="�ر�" x="600" y="30" w="50" h="50" image="1822000006" text_color="GOLD" OnLButtonClick="gcz.uduf" />
<image id="����ս����" image="1803600003" x="250" y="8" w="341" h="429" fitsize="false" />
<image id="����װ�" image="1803600002" x="50" y="70" w="341" h="429" fitsize="false" />
<image id="���ǹ���" image="1803600009" x="70" y="70" w="341" h="429" fitsize="false" />
<richedit id="����" x=60 y=100 w=480 h=50 />
<image id="�м���Ч" x="-50" y="-155" w=750 h=665  type=animate image=1041400000,200 fitsize=true/>
<image id="�м���Ч1" x="-230" y="-95" w=750 h=665  type=animate image=1041000000,200 fitsize=true/>
<image id="�м���Ч3" x="150" y="-100" w=750 h=665  type=animate image=1041200000,200 fitsize=true/>
<image x=185 y=10 id="��������" image=1890910050 />
<image x=300 y=70 id="��������" image=1803600010 />
<richedit id="������" x=300 y=150 w=480 h=50 />

<image x=10 y=80 id="��������" image=1890910054 />
<image x=110 y=140 id="�����������" image=1803600011 />
<richedit id="����������" x=120 y=220 w=480 h=50 />

<image x=385 y=80 id="��������" image=1890910052 />
<image x=485 y=140 id="�������ұ���" image=1803600011 />
<richedit id="����������" x=495 y=220 w=480 h=50 />


<image id="������ʾ�װ�" image="1803600004" x="215" y="275" w="341" h="429" fitsize="false" />
<richedit id="������ʾ1" x=270 y=340 w=480 h=50 text="����������20��00����" text_color="GREENG"/>
<richedit id="������ʾ2" x=265 y=360 w=480 h=50 text="֮�������������չ���" text_color="RED" />


<--button id="Ĥ��" x="360" y="70" w="50" h="50" image="1810000005" text="Ĥ��" text_color="GOLD" OnLButtonClick="gcz.mobai" />
</dialog>
</form>