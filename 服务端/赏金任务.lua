    local lua_path = lualib:IO_GetLuaPath()
    local package_path = package.path
    package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
    require("system/serializer")
    local renwu = {
        [1] ={
            [0] = {   --1星任务
                --地图KEY 怪物KEY  击杀数量 奖励经验 奖励功勋  任务说明
                {"妖幻大厅","巫山白野猪",8,{"转生材料","莫邪之血"},{10,10},"前往【猪洞地图】击杀8只【巫山白野猪】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","巫山白野猪",10,{"转生材料","莫邪之血"},{15,15},"前往【猪洞地图】击杀10只【巫山白野猪】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","巫山白野猪",12,{"转生材料","莫邪之血"},{20,20},"前往【猪洞地图】击杀12只【巫山白野猪】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","巫山白野猪",15,{"转生材料","莫邪之血"},{25,25},"前往【猪洞地图】击杀15只【巫山白野猪】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","巫山白野猪",18,{"转生材料","莫邪之血"},{30,30},"前往【猪洞地图】击杀18只【巫山白野猪】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","巫山白野猪",20,{"转生材料","莫邪之血"},{35,35},"前往【猪洞地图】击杀20只【巫山白野猪】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","巫山白野猪",25,{"转生材料","莫邪之血"},{40,40},"前往【猪洞地图】击杀25只【巫山白野猪】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","巫山白野猪",35,{"转生材料","莫邪之血"},{45,45},"前往【猪洞地图】击杀35只【巫山白野猪】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","巫山白野猪",45,{"转生材料","莫邪之血"},{50,50},"前往【猪洞地图】击杀45只【巫山白野猪】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","巫山白野猪",65,{"转生材料","莫邪之血"},{60,60},"前往【猪洞地图】击杀65只【巫山白野猪】"},  --指定地图 击杀指定怪物

            },
            [1] = {  --2星任务
                {"妖幻大厅","白野猪",8,{"转生材料","莫邪之血"},{10,10},"前往【封魔洞】击杀8只【白野猪】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","白野猪",10,{"转生材料","莫邪之血"},{15,15},"前往【封魔洞】击杀10只【白野猪】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","白野猪",12,{"转生材料","莫邪之血"},{20,20},"前往【封魔洞】击杀12只【白野猪】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","白野猪",15,{"转生材料","莫邪之血"},{25,25},"前往【封魔洞】击杀15只【白野猪】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","白野猪",18,{"转生材料","莫邪之血"},{30,30},"前往【封魔洞】击杀18只【白野猪】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","白野猪",20,{"转生材料","莫邪之血"},{35,35},"前往【封魔洞】击杀20只【白野猪】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","白野猪",25,{"转生材料","莫邪之血"},{40,40},"前往【封魔洞】击杀25只【白野猪】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","白野猪",35,{"转生材料","莫邪之血"},{45,45},"前往【封魔洞】击杀35只【白野猪】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","白野猪",45,{"转生材料","莫邪之血"},{50,50},"前往【封魔洞】击杀45只【白野猪】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","白野猪",65,{"转生材料","莫邪之血"},{60,60},"前往【封魔洞】击杀65只【白野猪】"},  --指定地图 击杀指定怪物

            },
            [2] = {
                {"妖幻大厅","奥玛卫士",8,{"转生材料","莫邪之血"},{10,10},"前往【奥玛庙】击杀8只【奥玛卫士】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","奥玛卫士",10,{"转生材料","莫邪之血"},{15,15},"前往【奥玛庙】击杀10只【奥玛卫士】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","奥玛卫士",12,{"转生材料","莫邪之血"},{20,20},"前往【奥玛庙】击杀12只【奥玛卫士】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","奥玛卫士",15,{"转生材料","莫邪之血"},{25,25},"前往【奥玛庙】击杀15只【奥玛卫士】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","奥玛卫士",18,{"转生材料","莫邪之血"},{30,30},"前往【奥玛庙】击杀18只【奥玛卫士】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","奥玛卫士",20,{"转生材料","莫邪之血"},{35,35},"前往【奥玛庙】击杀20只【奥玛卫士】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","奥玛卫士",25,{"转生材料","莫邪之血"},{40,40},"前往【奥玛庙】击杀25只【奥玛卫士】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","奥玛卫士",35,{"转生材料","莫邪之血"},{45,45},"前往【奥玛庙】击杀35只【奥玛卫士】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","奥玛卫士",45,{"转生材料","莫邪之血"},{50,50},"前往【奥玛庙】击杀45只【奥玛卫士】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","奥玛卫士",65,{"转生材料","莫邪之血"},{60,60},"前往【奥玛庙】击杀65只【奥玛卫士】"},  --指定地图 击杀指定怪物

            },
            [3] = {
                {"妖幻大厅","邪恶钳虫",8,{"转生材料","莫邪之血"},{10,10},"前往【蜈蚣洞】击杀8只【邪恶钳虫】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","邪恶钳虫",10,{"转生材料","莫邪之血"},{15,15},"前往【蜈蚣洞】击杀10只【邪恶钳虫】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","邪恶钳虫",12,{"转生材料","莫邪之血"},{20,20},"前往【蜈蚣洞】击杀12只【邪恶钳虫】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","邪恶钳虫",15,{"转生材料","莫邪之血"},{25,25},"前往【蜈蚣洞】击杀15只【邪恶钳虫】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","邪恶钳虫",18,{"转生材料","莫邪之血"},{30,30},"前往【蜈蚣洞】击杀18只【邪恶钳虫】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","邪恶钳虫",20,{"转生材料","莫邪之血"},{35,35},"前往【蜈蚣洞】击杀20只【邪恶钳虫】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","邪恶钳虫",25,{"转生材料","莫邪之血"},{40,40},"前往【蜈蚣洞】击杀25只【邪恶钳虫】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","邪恶钳虫",35,{"转生材料","莫邪之血"},{45,45},"前往【蜈蚣洞】击杀35只【邪恶钳虫】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","邪恶钳虫",45,{"转生材料","莫邪之血"},{50,50},"前往【蜈蚣洞】击杀45只【邪恶钳虫】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","邪恶钳虫",65,{"转生材料","莫邪之血"},{60,60},"前往【蜈蚣洞】击杀65只【邪恶钳虫】"},  --指定地图 击杀指定怪物

            },
            ["z"] = {"等级卷",5}
        },


        [2] ={
            [0] = {   --1星任务
                --地图KEY 怪物KEY  击杀数量 奖励经验 奖励功勋  任务说明
                {"妖幻大厅","魔龙巨蛾",8,{"龙珠碎片","莫邪之血"},{10,10},"前往【魔龙地图】击杀8只【魔龙巨蛾】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙巨蛾",10,{"龙珠碎片","莫邪之血"},{15,15},"前往【魔龙地图】击杀10只【魔龙巨蛾】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙巨蛾",12,{"龙珠碎片","莫邪之血"},{20,20},"前往【魔龙地图】击杀12只【魔龙巨蛾】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙巨蛾",15,{"龙珠碎片","莫邪之血"},{25,25},"前往【魔龙地图】击杀15只【魔龙巨蛾】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙巨蛾",18,{"龙珠碎片","莫邪之血"},{30,30},"前往【魔龙地图】击杀18只【魔龙巨蛾】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙巨蛾",20,{"龙珠碎片","莫邪之血"},{35,35},"前往【魔龙地图】击杀20只【魔龙巨蛾】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙巨蛾",25,{"龙珠碎片","莫邪之血"},{40,40},"前往【魔龙地图】击杀25只【魔龙巨蛾】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙巨蛾",35,{"龙珠碎片","莫邪之血"},{45,45},"前往【魔龙地图】击杀35只【魔龙巨蛾】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙巨蛾",45,{"龙珠碎片","莫邪之血"},{50,50},"前往【魔龙地图】击杀45只【魔龙巨蛾】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙巨蛾",65,{"龙珠碎片","莫邪之血"},{60,60},"前往【魔龙地图】击杀65只【魔龙巨蛾】"},  --指定地图 击杀指定怪物

            },
            [1] = {  --2星任务
                {"妖幻大厅","魔龙战将",8,{"龙珠碎片","莫邪之血"},{10,10},"前往【魔龙地图】击杀8只【魔龙战将】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙战将",10,{"龙珠碎片","莫邪之血"},{15,15},"前往【魔龙地图】击杀10只【魔龙战将】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙战将",12,{"龙珠碎片","莫邪之血"},{20,20},"前往【魔龙地图】击杀12只【魔龙战将】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙战将",15,{"龙珠碎片","莫邪之血"},{25,25},"前往【魔龙地图】击杀15只【魔龙战将】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙战将",18,{"龙珠碎片","莫邪之血"},{30,30},"前往【魔龙地图】击杀18只【魔龙战将】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙战将",20,{"龙珠碎片","莫邪之血"},{35,35},"前往【魔龙地图】击杀20只【魔龙战将】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙战将",25,{"龙珠碎片","莫邪之血"},{40,40},"前往【魔龙地图】击杀25只【魔龙战将】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙战将",35,{"龙珠碎片","莫邪之血"},{45,45},"前往【魔龙地图】击杀35只【魔龙战将】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙战将",45,{"龙珠碎片","莫邪之血"},{50,50},"前往【魔龙地图】击杀45只【魔龙战将】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙战将",65,{"龙珠碎片","莫邪之血"},{60,60},"前往【魔龙地图】击杀65只【魔龙战将】"},  --指定地图 击杀指定怪物

            },
            [2] = {
                {"妖幻大厅","魔龙力士",8,{"龙珠碎片","莫邪之血"},{10,10},"前往【魔龙地图】击杀8只【魔龙力士】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙力士",10,{"龙珠碎片","莫邪之血"},{15,15},"前往【魔龙地图】击杀10只【魔龙力士】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙力士",12,{"龙珠碎片","莫邪之血"},{20,20},"前往【魔龙地图】击杀12只【魔龙力士】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙力士",15,{"龙珠碎片","莫邪之血"},{25,25},"前往【魔龙地图】击杀15只【魔龙力士】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙力士",18,{"龙珠碎片","莫邪之血"},{30,30},"前往【魔龙地图】击杀18只【魔龙力士】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙力士",20,{"龙珠碎片","莫邪之血"},{35,35},"前往【魔龙地图】击杀20只【魔龙力士】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙力士",25,{"龙珠碎片","莫邪之血"},{40,40},"前往【魔龙地图】击杀25只【魔龙力士】"},  --指定地图 击杀指定怪物
                {"妖幻大厅","魔龙力士",35,{"龙珠碎片","莫邪之血"},{45,45},"前往【魔龙地图】击杀35只【魔龙力士】"},  --指定地图 击杀任意怪物
                {"妖幻大厅","魔龙力士",45,{"龙珠碎片","莫邪之血"},{50,50},"前往【魔龙地图】击杀45只【魔龙力士】"},  --任意地图 击杀指定怪物
                {"妖幻大厅","魔龙力士",65,{"龙珠碎片","莫邪之血"},{60,60},"前往【魔龙地图】击杀65只【魔龙力士】"},  --指定地图 击杀指定怪物

            },
            ["z"] = {"BOS召唤令",5}
        },



        [3] ={
            [0] = {   --1星任务
                --地图KEY 怪物KEY  击杀数量 奖励经验 奖励功勋  任务说明
                {"天栾大殿","魔龙力士",5,{"血石碎片","神羽碎片"},{200,200},"前往【魔龙地图】击杀5只【天栾神将】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",6,{"血石碎片","神羽碎片"},{230,230},"前往【魔龙地图】击杀6只【天栾神将】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",7,{"血石碎片","神羽碎片"},{260,260},"前往【魔龙地图】击杀7只【天栾神将】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",8,{"血石碎片","神羽碎片"},{290,290},"前往【魔龙地图】击杀8只【天栾神将】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",9,{"血石碎片","神羽碎片"},{320,320},"前往【魔龙地图】击杀9只【天栾神将】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",10,{"血石碎片","神羽碎片"},{350,350},"前往【魔龙地图】击杀10只【天栾神将】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",11,{"血石碎片","神羽碎片"},{380,380},"前往【魔龙地图】击杀11只【天栾神将】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",12,{"血石碎片","神羽碎片"},{420,420},"前往【魔龙地图】击杀12只【天栾神将】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",6,{"血石碎片","神羽碎片"},{460,460},"前往【魔龙地图】击杀6只【天栾精英】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",10,{"血石碎片","神羽碎片"},{500,500},"前往【魔龙地图】击杀10只【天栾精英】"},  --指定地图 击杀指定怪物

            },
            [1] = {  --2星任务
                {"天栾大殿","魔龙力士",5,{"斗笠碎片","符文碎片"},{200,200},"前往【魔龙地图】击杀5只【天栾巨犀】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",6,{"斗笠碎片","符文碎片"},{230,230},"前往【魔龙地图】击杀6只【天栾巨犀】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",7,{"斗笠碎片","符文碎片"},{260,260},"前往【魔龙地图】击杀7只【天栾巨犀】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",8,{"斗笠碎片","符文碎片"},{290,290},"前往【魔龙地图】击杀8只【天栾巨犀】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",9,{"斗笠碎片","符文碎片"},{320,320},"前往【魔龙地图】击杀9只【天栾巨犀】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",10,{"斗笠碎片","符文碎片"},{350,350},"前往【魔龙地图】击杀10只【天栾巨犀】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",11,{"斗笠碎片","符文碎片"},{380,380},"前往【魔龙地图】击杀11只【天栾巨犀】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",12,{"斗笠碎片","符文碎片"},{420,420},"前往【魔龙地图】击杀12只【天栾巨犀】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",6,{"斗笠碎片","符文碎片"},{460,460},"前往【魔龙地图】击杀6只【天栾精英】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",10,{"斗笠碎片","符文碎片"},{500,500},"前往【魔龙地图】击杀10只【天栾精英】"},  --指定地图 击杀指定怪物

            },
            [2] = {
                {"天栾大殿","魔龙力士",5,{"盾牌碎片","龙珠碎片"},{200,200},"前往【魔龙地图】击杀5只【天栾长枪】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",6,{"盾牌碎片","龙珠碎片"},{230,230},"前往【魔龙地图】击杀6只【天栾长枪】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",7,{"盾牌碎片","龙珠碎片"},{260,260},"前往【魔龙地图】击杀7只【天栾长枪】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",8,{"盾牌碎片","龙珠碎片"},{290,290},"前往【魔龙地图】击杀8只【天栾长枪】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",9,{"盾牌碎片","龙珠碎片"},{320,320},"前往【魔龙地图】击杀9只【天栾长枪】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",10,{"盾牌碎片","龙珠碎片"},{350,350},"前往【魔龙地图】击杀10只【天栾长枪】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",11,{"盾牌碎片","龙珠碎片"},{380,380},"前往【魔龙地图】击杀11只【天栾长枪】"},  --指定地图 击杀指定怪物
                {"天栾大殿","魔龙力士",12,{"盾牌碎片","龙珠碎片"},{420,420},"前往【魔龙地图】击杀12只【天栾长枪】"},  --指定地图 击杀任意怪物
                {"天栾大殿","魔龙力士",6,{"盾牌碎片","龙珠碎片"},{460,460},"前往【魔龙地图】击杀6只【天栾精英】"},  --任意地图 击杀指定怪物
                {"天栾大殿","魔龙力士",10,{"盾牌碎片","龙珠碎片"},{500,500},"前往【魔龙地图】击杀10只【天栾精英】"},  --指定地图 击杀指定怪物

            },
            [3] = {
                {"无尽深渊","魔龙力士",5,{"五行碎片","转生材料"},{200,200},"前往【魔龙地图】击杀5只【无尽巨斧】"},  --指定地图 击杀指定怪物
                {"无尽深渊","魔龙力士",6,{"五行碎片","转生材料"},{230,230},"前往【魔龙地图】击杀6只【无尽巨斧】"},  --指定地图 击杀任意怪物
                {"无尽深渊","魔龙力士",7,{"五行碎片","转生材料"},{260,260},"前往【魔龙地图】击杀7只【无尽巨斧】"},  --任意地图 击杀指定怪物
                {"无尽深渊","魔龙力士",8,{"五行碎片","转生材料"},{290,290},"前往【魔龙地图】击杀8只【无尽巨斧】"},  --指定地图 击杀指定怪物
                {"无尽深渊","魔龙力士",9,{"五行碎片","转生材料"},{320,320},"前往【魔龙地图】击杀9只【无尽双刀】"},  --指定地图 击杀任意怪物
                {"无尽深渊","魔龙力士",10,{"五行碎片","转生材料"},{350,350},"前往【魔龙地图】击杀10只【无尽双刀】"},  --任意地图 击杀指定怪物
                {"无尽深渊","魔龙力士",11,{"五行碎片","转生材料"},{380,380},"前往【魔龙地图】击杀11只【无尽双刀】"},  --指定地图 击杀指定怪物
                {"无尽深渊","魔龙力士",12,{"五行碎片","转生材料"},{420,420},"前往【魔龙地图】击杀12只【无尽双刀】"},  --指定地图 击杀任意怪物
                {"无尽深渊","魔龙力士",6,{"五行碎片","转生材料"},{460,460},"前往【魔龙地图】击杀6只【无尽精英】"},  --任意地图 击杀指定怪物
                {"无尽深渊","魔龙力士",10,{"五行碎片","转生材料"},{500,500},"前往【魔龙地图】击杀10只【无尽精英】"},  --指定地图 击杀指定怪物

            },

            ["z"] = {"赤炎令",3}
        },
    }

    local zanzhu = {
        [1] = 5,
        [2] = 10,
        [3] = 15,
        [4] = 25,
        [5] = 30,
        [6] = 50,
        [7] = 100,
    }

    function show(player,num)
        local cs = 5
        local zz = lualib:GetInt(player,"zanzhu")
        if zanzhu[zz] ~= nil then
            cs = cs + zanzhu[zz]
        end
        if lualib:GetVipLevel(player) > 0 then
            cs = cs + 10
        end
        local a = lualib:GetAllDays(0)
        local la = lualib:GetInt(player,"shuax"..a)
        local num = tonumber(num)
        local today = lualib:GetAllDays(0)
        if lualib:GetInt(player,"gongxunrw") ~= today then
            lualib:SetInt(player,"gongxunrw",today)
            lualib:SetInt(player,"gxcs1",0)
            lualib:SetInt(player,"gxcs2",0)
            lualib:SetInt(player,"gxcs3",0)
        end
        if lualib:GetInt(player,"gxhang"..num) < 1 then
            lualib:SetInt(player,"gxhang"..num,1)
        end
        if lualib:GetClientType(player) ~= 2 then
            local data = serialize(renwu[num]).."#"..num.."#"..lualib:GetInt(player,"gxcs"..num).."#"..lualib:GetInt(player,"gxhang"..num).."#"..lualib:GetInt(player,"gxzt").."#"..cs.."#"..la
            lualib:ShowFormWithContent(player, "form文件表单", "赏金任务#"..data)
        else
            local t = {}
            t[1] = renwu[num]
            t[2] = num
            t[3] = lualib:GetInt(player,"gxcs"..num)
            t[4] = lualib:GetInt(player,"gxhang"..num)
            t[5] = lualib:GetInt(player,"gxzt")
            t[6] = cs
            t[7] = la
            local script = ""
            script = script.." Gx_sc_ec = "..serialize(t)
            lualib:ShowFormWithContent(player, "脚本表单", script)
            lualib:ShowFormWithContent(player, "form文件表单", "赏金任务")
        end
        return ""
    end

    function shua(player,num)
        local a = lualib:GetAllDays(0)
        local cs = 5
        local zz = lualib:GetInt(player,"zanzhu")
        if zanzhu[zz] ~= nil then
            cs = cs + zanzhu[zz]
        end
        if lualib:GetVipLevel(player) > 0 then
            cs = cs + 10
        end
        local num = tonumber(num)
        if lualib:GetInt(player,"gxzt")  == 1 then
            return"当前任务进行中无法刷星"
        end
        if lualib:GetInt(player,"gxcs"..num) >= 7 then
            return"今日任务已完成,请明日再来"
        end
        if lualib:GetInt(player,"gxhang"..num) >= 10 then
            return"当前任务已满星,请接受吧"
        end
        if lualib:GetInt(player,"shuax"..a) <  cs then
            lualib:SetInt(player,"shuax"..a,lualib:GetInt(player,"shuax"..a)+1)
        else
            if not lualib:SubIngot(player,200, "任务刷星", lualib:Name(player)) then
                return"刷星需要200元宝"
            end
        end
        lualib:SetInt(player,"gxhang"..num,lualib:GenRandom(1, 10))
        return show(player,num)
    end

    function jie(player,num)
        local num = tonumber(num)
        if lualib:GetInt(player,"gxcs"..num) >= 7 then
            return"今日任务已完成,请明日再来"
        end
        if lualib:GetInt(player,"gxzt")  == 1 then
            wancheng(player)
            return""
        end
        lualib:SetInt(player,"gxzt",1)
        lualib:SetInt(player,"gxrw",num)
        x = lualib:GetInt(player,"gxcs"..num)
        y = lualib:GetInt(player,"gxhang"..num)
        lualib:SysMsg_SendPromptMsg(player, "任务接受成功！"..renwu[num][x][y][6])
        return show(player,num)
    end

    function gongxunrenwu(monster,killer)
        if killer ~= nil and killer ~= "" then

            if lualib:Player_IsPlayer(killer) then
                if lualib:GetInt(killer,"gxzt") == 1 then

                    e = lualib:GetInt(killer,"gxrw")
                    x = lualib:GetInt(killer,"gxcs"..e)
                    y = lualib:GetInt(killer,"gxhang"..e)
                    map = lualib:MapGuid(killer)
                    map_key = lualib:KeyName(map)
                    mon_key  = lualib:KeyName(monster)
                    if renwu[e][x][y][1] ~= "0"  and renwu[e][x][y][2] ~= "0" then
                        if  renwu[e][x][y][2] == mon_key then
                            if lualib:GetInt(killer,"gxjs") >= renwu[e][x][y][3] then
                                lualib:SysMsg_SendPromptMsg(killer, "当前任务已完成,请在[每日任务]处提交任务")
                            else
                                lualib:SetInt(killer,"gxjs",lualib:GetInt(killer,"gxjs")+1)
                                lualib:SysMsg_SendPromptMsg(killer, "当前击杀任务完成进度("..lualib:GetInt(killer,"gxjs").."/"..renwu[e][x][y][3]..")")
                            end
                        end
                    elseif  renwu[e][x][y][1] == "0" and  renwu[e][x][y][2] ~= "0" then
                        if renwu[e][x][y][2] == mon_key then
                            if lualib:GetInt(killer,"gxjs") >= renwu[e][x][y][3] then
                                lualib:SysMsg_SendPromptMsg(killer, "当前任务已完成,请在[每日任务]处提交任务")
                            else
                                lualib:SetInt(killer,"gxjs",lualib:GetInt(killer,"gxjs")+1)
                                lualib:SysMsg_SendPromptMsg(killer, "当前击杀任务完成进度("..lualib:GetInt(killer,"gxjs").."/"..renwu[e][x][y][3]..")")
                            end
                        end
                    elseif  renwu[e][x][y][1] ~= "0" and  renwu[e][x][y][2] == "0" then

                        if lualib:GetInt(killer,"gxjs") >= renwu[e][x][y][3] then
                            lualib:SysMsg_SendPromptMsg(killer, "当前任务已完成,请在[每日任务]处提交任务")
                        else
                            lualib:SetInt(killer,"gxjs",lualib:GetInt(killer,"gxjs")+1)
                            lualib:SysMsg_SendPromptMsg(killer, "当前击杀任务完成进度("..lualib:GetInt(killer,"gxjs").."/"..renwu[e][x][y][3]..")")
                        end

                    end
                end
            else

                player_name = lualib:Monster_GetMaster(killer)
                if player_name ~= "" then
                    player = lualib:Name2Guid(player_name)
                    if lualib:GetInt(player,"gxzt") == 1 then
                        e = lualib:GetInt(player,"gxrw")
                        x = lualib:GetInt(player,"gxcs"..e)
                        y = lualib:GetInt(player,"gxhang"..e)
                        map = lualib:MapGuid(player)
                        map_key = lualib:KeyName(map)
                        mon_key  = lualib:KeyName(monster)
                        if renwu[e][x][y][1] ~= "0"  and renwu[e][x][y][2] ~= "0" then
                            if  renwu[e][x][y][2] == mon_key then
                                if lualib:GetInt(player,"gxjs") >= renwu[e][x][y][3] then
                                    lualib:SysMsg_SendPromptMsg(player, "当前任务已完成,请在[每日任务]处提交任务")
                                else
                                    lualib:SetInt(player,"gxjs",lualib:GetInt(player,"gxjs")+1)
                                    lualib:SysMsg_SendPromptMsg(player, "当前击杀任务完成进度("..lualib:GetInt(player,"gxjs").."/"..renwu[e][x][y][3]..")")
                                end
                            end
                        elseif  renwu[e][x][y][1] == "0" and  renwu[e][x][y][2] ~= "0" then
                            if renwu[e][x][y][2] == mon_key then
                                if lualib:GetInt(player,"gxjs") >= renwu[e][x][y][3] then
                                    lualib:SysMsg_SendPromptMsg(player, "当前任务已完成,请在[每日任务]处提交任务")
                                else
                                    lualib:SetInt(player,"gxjs",lualib:GetInt(player,"gxjs")+1)
                                    lualib:SysMsg_SendPromptMsg(player, "当前击杀任务完成进度("..lualib:GetInt(player,"gxjs").."/"..renwu[e][x][y][3]..")")
                                end
                            end
                        elseif  renwu[e][x][y][1] ~= "0" and  renwu[e][x][y][2] == "0" then

                            if lualib:GetInt(player,"gxjs") >= renwu[e][x][y][3] then
                                lualib:SysMsg_SendPromptMsg(player, "当前任务已完成,请在[每日任务]处提交任务")
                            else
                                lualib:SetInt(player,"gxjs",lualib:GetInt(player,"gxjs")+1)
                                lualib:SysMsg_SendPromptMsg(player, "当前击杀任务完成进度("..lualib:GetInt(player,"gxjs").."/"..renwu[e][x][y][3]..")")
                            end	end 	end end end end
    end


    function wancheng(player)
        if lualib:GetInt(player,"gxzt") == 0  then
            lualib:SysMsg_SendPromptMsg(player, "您尚未接取任务")
            return""
        end
        e = lualib:GetInt(player,"gxrw")
        x = lualib:GetInt(player,"gxcs"..e)
        y = lualib:GetInt(player,"gxhang"..e)
        if lualib:GetInt(player,"gxcs"..e) >= 7 then
            lualib:SysMsg_SendPromptMsg(player, "今日任务已完成,请明日再来")
            return""
        end
        if lualib:GetInt(player,"gxjs") < renwu[e][x][y][3] then
            lualib:SysMsg_SendPromptMsg(player, "当前任务尚未完成")
            return""
        end
        if lualib:GetBagFree(player) < 2 then
            lualib:MsgBox(player,"请留出2个包裹位置")
            return ""
        end

        lualib:SetInt(player,"gxhang"..e,1)
        lualib:SetInt(player,"gxcs"..e,x+1)
        lualib:SetInt(player,"gxjs",0)
        lualib:SetInt(player,"gxzt",0)
        lualib:AddItem(player,renwu[e][x][y][4][1],renwu[e][x][y][5][1],true,"每日任务", player)
        lualib:AddItem(player,renwu[e][x][y][4][2],renwu[e][x][y][5][2],true,"每日任务", player)
        lualib:MsgBox(player,"恭喜您！提交成功！！！")
        local s = "#COLORCOLOR_YELLOW#每日任务#COLORCOLOR_BLUE#：恭喜玩家#COLORCOLOR_ORANGE#「"..lualib:Name(player).."」#COLORCOLOR_BLUE#完成每日任务获得#COLORCOLOR_MAGENTA#["..lualib:KeyName2Name(renwu[e][x][y][4][1],4).."×"..renwu[e][x][y][5][1].."  "..lualib:KeyName2Name(renwu[e][x][y][4][2],4).."×"..renwu[e][x][y][5][2].."] #COLORCOLOR_BLUE#再接再厉！！"
        lualib:SysMsg_SendBroadcastColor(s, "", 1, 11)
        return show(player,e)
    end
    local dad={
        [1] = 200,
        [2] = 500,
        [3] = 1000,
    }

    function yjwc(player)
        if lualib:GetInt(player,"gxzt") == 0  then
            lualib:SysMsg_SendPromptMsg(player, "您尚未接取任务")
            return""
        end
        e = lualib:GetInt(player,"gxrw")
        x = lualib:GetInt(player,"gxcs"..e)
        y = lualib:GetInt(player,"gxhang"..e)
        if lualib:GetInt(player,"gxcs"..e) >= 7 then
            lualib:SysMsg_SendPromptMsg(player, "今日任务已完成,请明日再来")
            return""
        end

        if lualib:GetBagFree(player) < 2 then
            lualib:MsgBox(player,"请留出2个包裹位置")
            return ""
        end

        if not lualib:SubIngot(player, dad[e], "一键完成任务", lualib:Name(player)) then
            lualib:MsgBox(player,"一键完成需要元宝"..dad[e])
            return""
        end


        lualib:SetInt(player,"gxhang"..e,1)
        lualib:SetInt(player,"gxcs"..e,x+1)
        lualib:SetInt(player,"gxjs",0)
        lualib:SetInt(player,"gxzt",0)
        lualib:AddItem(player,renwu[e][x][y][4][1],renwu[e][x][y][5][1],true,"每日任务", player)
        lualib:AddItem(player,renwu[e][x][y][4][2],renwu[e][x][y][5][2],true,"每日任务", player)
        lualib:MsgBox(player,"恭喜您！提交成功！！！")
        local s = "#COLORCOLOR_YELLOW#每日任务#COLORCOLOR_BLUE#：恭喜玩家#COLORCOLOR_ORANGE#「"..lualib:Name(player).."」#COLORCOLOR_BLUE#完成每日任务获得#COLORCOLOR_MAGENTA#["..lualib:KeyName2Name(renwu[e][x][y][4][1],4).."×"..renwu[e][x][y][5][1].."  "..lualib:KeyName2Name(renwu[e][x][y][4][2],4).."×"..renwu[e][x][y][5][2].."] #COLORCOLOR_BLUE#再接再厉！！"
        lualib:SysMsg_SendBroadcastColor(s, "", 1, 11)
        return show(player,e)
    end


    function paodiansj(player)
        local rw = ""
        local rwn = ""
        local rww = ""
        local wc = ""
        if lualib:GetInt(player,"gxzt")  == 1 then
            rw = "【每日任务】"
            e = lualib:GetInt(player,"gxrw")
            x = lualib:GetInt(player,"gxcs"..e)
            y = lualib:GetInt(player,"gxhang"..e)
            rwn = renwu[e][x][y][6]
            if  lualib:GetInt(player,"gxjs") >= renwu[e][x][y][3] then
                wc = "已完成"
            else
                wc = ""
            end
            rww = "您当前完成进度：("..lualib:GetInt(player,"gxjs").."/"..renwu[e][x][y][3]..")"..wc
        end
        local str = "GameMainBar.lempa(\""..rw.."\",\""..rwn.."\",\""..rww.."\")";
        lualib:ShowFormWithContent(player, "脚本表单", str);
        return""
    end

    local jiangli_t = {
        [1] = {"天荒令",10},
        [2] = {"火焰令",6},
        [3] = {"赤炎令",3},

    }

    function lingjiang(player,num)
        local num = tonumber(num)
        if jiangli_t[num] == nil then
            lualib:MsgBox(player,"系统错误请从新打开！")
            return""
        end
        if lualib:GetInt(player,"gxcs"..num) < 7 then
            lualib:MsgBox(player,"您尚未完成所有任务！")
            return""
        end
        local today = lualib:GetAllDays(0)
        if lualib:GetInt(player,"mrrwljl"..num..today) == 1 then
            lualib:MsgBox(player,"该奖励已领取过了！")
            return""
        end
        lualib:AddItem(player,jiangli_t[num][1],jiangli_t[num][2],true,"每日任务", player)
        lualib:SetInt(player,"mrrwljl"..num..today,1)
        local s = "#COLORCOLOR_YELLOW#每日任务#COLORCOLOR_BLUE#：恭喜玩家#COLORCOLOR_ORANGE#「"..lualib:Name(player).."」#COLORCOLOR_BLUE#完成所有每日任务获得#COLORCOLOR_MAGENTA#["..jiangli_t[num][1].."] "..jiangli_t[num][2].."个#COLORCOLOR_BLUE#再接再厉！！"
        lualib:SysMsg_SendBroadcastColor(s, "", 1, 11)
        return""
    end


    function ditu(player)
        if lualib:Level(player) < 65 then
            return "你的等级小于65级，还是不要去了！"
        end
        lualib:Player_MapMove(player, "任务地图")
        return""
    end