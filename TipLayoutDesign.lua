EFONT = {}
ECOLOR = {}

EFONT["00"] = "system"
EFONT["01"] = "SIMLI18"

ECOLOR[1] = 255
ECOLOR[2] = 80
ECOLOR[3] = 80
ECOLOR[4] = 80


ECOLOR["000"] = 4294967295--0xFFFFFFFF  4278190079
ECOLOR["001"] = 4293050946--0xFFE2C242:ARGBColor(255,226,194,66)
ECOLOR["002"] = 4292884223--0xFFE036FF:ARGBColor(255,224,54,255)
ECOLOR["003"] = 4294963200--0xFFFFF000:ARGBColor(255,255,240,0)
ECOLOR["004"] = 4281908223--0xFF38BBFF:ARGBColor(255,56,187,255)
ECOLOR["005"] = 4294957056--0xFFFFD800:ARGBColor(255,255,216,0)
ECOLOR["006"] = 4294901760--0xFFFF0000:ARGBColor(255,255,0,0)
ECOLOR["007"] = 4292884223--0xFFE036FF:ARGBColor(255,224,54,255)
ECOLOR["008"] = 4293050946--0xFFE2C242:ARGBColor(255,226,194,66)
ECOLOR["009"] = 4278276095--0xFF014FFF:ARGBColor(255,1,79,255)
ECOLOR["010"] = 4281645312--0xFF34B900:ARGBColor(255,52,185,0)
ECOLOR["011"] = 4294901760--0xFFFF0000:ARGBColor(255,255,0,0)
ECOLOR["012"] = 4289309097--0xFFA9A9A9:ARGBColor(255,169,169,169)
ECOLOR["013"] = 4294955892--0xFFFFD374:ARGBColor(255,255,211,116)
ECOLOR["014"] = 4294944768--0xFFFFA800:ARGBColor(255,255,168,0)
ECOLOR["015"] = 4286185269--0xFF79FF35:ARGBColor(255,121,255,53)
ECOLOR["016"] = 4294573201--0xFFF9FC91:ARGBColor(255,249,252,145)	--幸运+1颜色
ECOLOR["017"] = 4294436147--0xFFF7E533:ARGBColor(255,247,229,51)	--幸运+2颜色
ECOLOR["018"] = 4294753536--0xFFFCBD00:ARGBColor(255,252,189,0)		--幸运+3颜色
ECOLOR["019"] = 4292083464--0xFFD3FF08:ARGBColor(255,211,255,8)		--幸运+4颜色
ECOLOR["020"] = 4293590784--0xFFEAFF00:ARGBColor(255,234,255,0)		--幸运+5颜色
ECOLOR["021"] = 4294145170--0xFFF37492:ARGBColor(255,243,116,146)	--诅咒+1颜色
ECOLOR["022"] = 4293673014--0xFFEC4036:ARGBColor(255,236,64,54)		--诅咒+2颜色
ECOLOR["023"] = 4289339424--0xFFAA2020:ARGBColor(255,170,32,32)		--诅咒+3颜色
ECOLOR["024"] = 4292219163--0xFFD6111B:ARGBColor(255,214,17,27)		--诅咒+4颜色
ECOLOR["025"] = 4294901760--0xFFFF0000:ARGBColor(255,255,0,0)		--诅咒+5颜色
ECOLOR["026"] = 4287265790--0xFF8A7BFE:ARGBColor(255,138,123,254)
ECOLOR["027"] = 4278190335--0xFF0000FF:ARGBColor(255,0,0,255)
ECOLOR["028"] = 4294953984--0xFFFFCC00:ARGBColor(255,255,204,0)
ECOLOR["029"] = 4287861651--0xFF939393:ARGBColor(255,147,147,147)
ECOLOR["030"] = 4287550230--0xFF8ED316:ARGBColor(255,142,211,22)
ECOLOR["031"] = 4279689899--0xFF16E2AB:ARGBColor(255,22,226,171)
ECOLOR["032"] = 4293935424--0xFFF04140:ARGBColor(255,240,65,64)
ECOLOR["033"] = 4294417725--0xFFF79D3D:RDColor(255,247,157,61)
ECOLOR["034"] = 4286111031--0xFF78DD37:RDColor(255,120,221,55)
ECOLOR["035"] = 4279755435--0xFF17E2AB:RDColor(255,23,226,171)
ECOLOR["036"] = 4294761476--0xFFFCDC04:ARGBColor(255,252,220,4)
ECOLOR["037"] = 4281843773--0xFF37C03D:RDColor(255,55,192,61)
ECOLOR["038"] = 4283021466--0xFF49B89A:RDColor(255,73,184,154)
ECOLOR["039"] = 4286578816--0xFF800080:RDColor(255,128,0,128)
ECOLOR["040"] = 4294967168--0xFFFFFF80:RDColor(255,255,255,128)
ECOLOR["041"] = 4283453520--0xFF505050:RDColor(255,80,80,80)

ECOLOR["042"] = 4283453520--0xFF505050:RDColor(255,80,80,80)
ECOLOR["043"] = 4281908223--0xFF38BBFF:ARGBColor(255,56,187,255)
ECOLOR["044"] = 4281908223--0xFF38BBFF:ARGBColor(255,56,187,255)
ECOLOR["045"] = 4281908223--0xFF38BBFF:ARGBColor(255,56,187,255)
ECOLOR["046"] = 4281908223--0xFF38BBFF:ARGBColor(255,56,187,255)
ECOLOR["047"] = 4281908223--0xFF38BBFF:ARGBColor(255,56,187,255)


--获取tip参数--
function GetTipParam(name)
    if name == nil then return end
    return TipParam[name]
end

--设置tip参数--
function SetTipParam(name, value)
    TipParam[name] = value
end

--tip的jason开始串--
function GetTipBegin()
    return "["
end

--tip的jason结束串--
function GetTipEnd()
    return "{}]"
end

--向tip中添加文字，不自动换行，tip的宽度根据文字的长度自动调整--
function tipText(info, color, font)
    local ret = "{\"type\":\"text\""
    if info ~= nil and info ~= "" then
        ret = ret..",\"info\":\""..info.."\""
    end
    if color ~= nil then
        if type(color) == "number" and color ~= 0 then
            ret = ret..",\"color\":"..color
        elseif type(color) == "string" and color ~= "" then
            ret = ret..",\"color\":"..string.format("%q", color)
        end
    end
    if font ~= nil and font ~= "" then
        ret = ret..",\"font\":\""..font.."\""
    end
    ret = ret.."},"; return ret
end

--向tip中添加文字，自动换行，tip的宽度不会根据文字的长度自动调整--
function tipText2(info, color, font)
    local ret = "{\"type\":\"text\",\"autoline\":true"
    if info ~= nil and info ~= "" then
        ret = ret..",\"info\":\""..info.."\""
    end
    if color ~= nil then
        if type(color) == "number" and color ~= 0 then
            ret = ret..",\"color\":"..color
        elseif type(color) == "string" and color ~= "" then
            ret = ret..",\"color\":"..string.format("%q", color)
        end
    end
    if font ~= nil and font ~= "" then
        ret = ret..",\"font\":\""..font.."\""
    end
    ret = ret.."},"; return ret
end

--[[向tip中添加文字，自动换行，left指定下一行距离tip左边的偏移
align指定第一行文字的垂直对齐方式，0顶对齐，1居中对齐，2底端对齐
width指定文本的占用宽度--]]
function tipText3(info, left, align, width)
    local ret = "{\"type\":\"text\",\"autoline\":true"
    if info ~= nil and info ~= "" then
        ret = ret..",\"info\":\""..info.."\""
    end
    if left ~= nil and left ~= "" then
        ret = ret..",\"left\":"..left
    end
    if align ~= nil and align ~= "" then
        ret = ret..",\"align\":"..align
    end
    if width ~= nil and width ~= "" then
        ret = ret..",\"width\":"..width
    end
    ret = ret.."},"; return ret
end

--[[向tip中添加图片，若width和height都不为空，那么指定图片会
根据指定的宽度和高度进行缩放否则图片正常绘制不会缩放--]]
function tipImage(id, width, height)
    if id == nil or id == "" or id == 0 then return "" end
    local ret = "{\"type\":\"img\",\"imgid\":"..id
    if width ~= nil and width ~= "" and height ~= nil and height ~= "" then
        ret = ret..",\"width\":"..width..",\"height\":"..height
    end
    ret = ret.."},"; return ret
end

--向tip中添加图片，color指定图片的颜色, gray指定图片是否灰色显示--
function tipImage2(id, color, gray)
    if id == nil or id == "" or id == 0 then return "" end
    local ret = "{\"type\":\"img\",\"imgid\":"..id
    if color ~= nil then
        if type(color) == "number" and color ~= 0 then
            ret = ret..",\"color\":"..color
        elseif type(color) == "string" and color ~= "" then
            ret = ret..",\"color\":"..string.format("%q", color)
        end
    end
    if true == gray then
        ret = ret..",\"gray\":true"
    end
    ret = ret.."},"; return ret
end

--向tip中添加图片，宽，高，颜色，是否灰色显示
function tipImage3(id, width, height, color, gray)
    if id == nil or id == "" or id == 0 then return "" end
    local ret = "{\"type\":\"img\",\"imgid\":"..id
    if width ~= nil and width ~= "" and height ~= nil and height ~= "" then
        ret = ret..",\"width\":"..width..",\"height\":"..height
    end
    if color ~= nil then
        if type(color) == "number" and color ~= 0 then
            ret = ret..",\"color\":"..color
        elseif type(color) == "string" and color ~= "" then
            ret = ret..",\"color\":"..string.format("%q", color)
        end
    end
    if true == gray then
        ret = ret..",\"gray\":true"
    end
    ret = ret.."},"; return ret
end

--向tip中添加动画，speed指定动画帧的时间间隔单位毫秒，默认值100毫秒
function tipAnimate(id, color)
    if id == nil or id == "" or id == 0 then return "" end
    local ret = "{\"type\":\"img\",\"animate\":true,\"imgid\":"..id
    if color ~= nil then
        if type(color) == "number" and color ~= 0 then
            ret = ret..",\"color\":"..color
        elseif type(color) == "string" and color ~= "" then
            ret = ret..",\"color\":"..string.format("%q", color)
        end
    end
    ret = ret.."},"; return ret
end

--设定tip的宽度和高度--
function tipAll(width, height)
    local ret = "{\"type\":\"all\""
    if width ~= nil and width ~= "" then
        ret = ret..",\"width\":"..width
    end
    if height ~= nil and height ~= "" then
        ret = ret..",\"height\":"..height
    end
    ret = ret.."},"; return ret
end

--设定tip的当前水平和垂直偏移--
function tipSet(offx, offy)
    local ret = "{\"type\":\"set\""
    if offx ~= nil and offx ~= "" then
        ret = ret..",\"offx\":"..offx
    end
    if offy ~= nil and offy ~= "" then
        ret = ret..",\"offy\":"..offy
    end
    ret = ret.."},"; return ret
end

--指定tip的当前水平和垂直绝对位置
function tipSet2(posx, posy)
    local ret = "{\"type\":\"set\""
    if posx ~= nil and posx ~= "" then
        ret = ret..",\"posx\":"..posx
    end
    if posy ~= nil and posy ~= "" then
        ret = ret..",\"posy\":"..posy
    end
    ret = ret.."},"; return ret
end

--添加tip的中间间隔横线--
function tipLine()
    local ret = tipSet(0, 4)
    ret = ret.."{\"type\":\"line\"},{\"type\":\"text\",\"info\":\"\n\"},"
    ret = ret..tipSet(0, 2)
    return ret
end