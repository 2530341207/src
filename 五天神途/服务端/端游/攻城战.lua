<form >
<script><![CDATA[
gcz = {}
gcz.hh = FormParam[1]
gcz.cz = FormParam[2]
gcz.zl1 = FormParam[3]
gcz.zl2 = FormParam[4]

gcz.Init = function(this)
---------------------------------------设置代理ID
local zhixing = 0
local QXID = {1729}--代理ID表，
if not UI:Lua_GetAgentID() then WndClose(this) end
local SID = LuaRet
for i = 1 , #QXID do
if QXID[i] == tonumber(SID) then
zhixing = 1
end
end

if zhixing == 0 then
MessageBox(MESSAGE_STYLE_OK, "权限不足，请找帝豪神途（QQ：964561888）购买!!")
WndClose(this)
end
-------------------------------------------------------
RichEditClear(nil, "攻城战,公会")
RichEditAppendString(nil, "攻城战,公会", gcz.hh.."")

RichEditClear(nil, "攻城战,城主名")
RichEditAppendString(nil, "攻城战,城主名", gcz.cz.."")

RichEditClear(nil, "攻城战,副城主左名")
RichEditAppendString(nil, "攻城战,副城主左名", gcz.zl1.."")

RichEditClear(nil, "攻城战,副城主右名")
RichEditAppendString(nil, "攻城战,副城主右名", gcz.zl2.."")

t = deserialize(FormParam[5])

local msg1 = "本期攻城活动奖励如下：";
msg1 = msg1 .. "元宝奖励：";
msg1 = msg1 .. t.ingot;
msg1 = msg1 .. "固定奖励：";
for _, v in ipairs(t[1]) do
msg1 = msg1 .. v[1].."*"..v[2].." ";
end
msg1 = msg1 .. "随机奖励（可得其中之一）：";
for _, u in ipairs(t[2]) do
msg1 = msg1 .. u[1].."*"..u[2].." ";
end

tishi = deserialize(FormParam[6])

script = [[<form default_parent=攻城战>]]
script = script..[[<button id="前往神歌城" image="1803600005" x="70" y="395" num=1 tip="需要]]..tishi[1][1]..[[金币" OnLButtonClick="gcz.OK"

/>]]
script = script..[[<button id="1号点" x="260" y="390" w="50" h="50" image="1803900005" text="攻城一号点" text_color="GOLD" num=2 tip="需

要]]..tishi[2][1]..[[金币" OnLButtonClick="gcz.OK" />]]
script = script..[[<button id="2号点" x="380" y="390" w="50" h="50" image="1803900005" text="攻城二号点" text_color="GOLD" num=3 tip="需

要]]..tishi[3][1]..[[金币" OnLButtonClick="gcz.OK" />]]
script = script..[[<button id="3号点" x="500" y="390" w="50" h="50" image="1803900005" text="攻城三号点" text_color="GOLD" num=4 tip="需

要]]..tishi[4][1]..[[金币" OnLButtonClick="gcz.OK" />]]
script = script..[[</form>]]
GenFormByString(script)
end

gcz.uduf = function(this)
WndClose(nil, "攻城战")
end

gcz.OK = function(this)
local num = tonumber(WndGetProperty(this, nil, "num"))
UI:Lua_SubmitForm("攻城战", "wfudhk", ""..num)
WndClose(nil, "攻城战")

end

gcz.mobai = function(this)
UI:Lua_SubmitForm("城主雕像表单", "update", "")
end

gcz.wybc = function(this)
UI:Lua_SubmitForm("攻城战", "wybcuqdd", "")
end
]]></script>
<dialog id="攻城战" x="0" y="0" w="666" h="470" image="1803600000" title=""  fitsize="true" close="false" center="true" OnInit=gcz.Init >
<button id="关闭" x="600" y="30" w="50" h="50" image="1822000006" text_color="GOLD" OnLButtonClick="gcz.uduf" />
<image id="攻城战标题" image="1803600003" x="250" y="8" w="341" h="429" fitsize="false" />
<image id="公会底板" image="1803600002" x="50" y="70" w="341" h="429" fitsize="false" />
<image id="王城公会" image="1803600009" x="70" y="70" w="341" h="429" fitsize="false" />
<richedit id="公会" x=60 y=100 w=480 h=50 />
<image id="中间特效" x="-50" y="-155" w=750 h=665  type=animate image=1041400000,200 fitsize=true/>
<image id="中间特效1" x="-230" y="-95" w=750 h=665  type=animate image=1041000000,200 fitsize=true/>
<image id="中间特效3" x="150" y="-100" w=750 h=665  type=animate image=1041200000,200 fitsize=true/>
<image x=185 y=10 id="城主人物" image=1890910050 />
<image x=300 y=70 id="城主标题" image=1803600010 />
<richedit id="城主名" x=300 y=150 w=480 h=50 />

<image x=10 y=80 id="副城主左" image=1890910054 />
<image x=110 y=140 id="副城主左标题" image=1803600011 />
<richedit id="副城主左名" x=120 y=220 w=480 h=50 />

<image x=385 y=80 id="副城主右" image=1890910052 />
<image x=485 y=140 id="副城主右标题" image=1803600011 />
<richedit id="副城主右名" x=495 y=220 w=480 h=50 />


<image id="攻城提示底板" image="1803600004" x="215" y="275" w="341" h="429" fitsize="false" />
<richedit id="攻城提示1" x=270 y=340 w=480 h=50 text="新区第三天20：00攻城" text_color="GREENG"/>
<richedit id="攻城提示2" x=265 y=360 w=480 h=50 text="之后周五周六周日攻城" text_color="RED" />


<--button id="膜拜" x="360" y="70" w="50" h="50" image="1810000005" text="膜拜" text_color="GOLD" OnLButtonClick="gcz.mobai" />
</dialog>
</form>