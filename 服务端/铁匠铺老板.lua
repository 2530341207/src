function main(npc, player)
    lualib:AddShop(npc, 1)
    local msg = "\n  ���ˣ������ɺã���ʲô�ܰ����ġ�\n"
    msg = msg..""
    msg = msg.."  #OFFSET<X:0,Y:5>##IMAGE1902700037##OFFSET<X:0,Y:-1># <@OpenShop#1 *01*��>����                <@SellItem#1 *01*��>����\n  #OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@ShowRepire#1 *01*����>����\n  #OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@ShowRepireEx#1 *01*��������>\n"
    msg = msg..""
    --msg = msg.."  #OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@maincaihe *01*���>����\n"
    --msg = msg.."  #OFFSET<X:0,Y:3>##IMAGE1902700017##OFFSET<X:0,Y:-1># <@fengyinjiesao *01*����>˵��\n"
    msg = msg.."  #OFFSET<X:0,Y:3>##IMAGE1902700017##OFFSET<X:0,Y:-1># <@talk *01*����>����֮�е���Ϣ \n"
    msg = msg.."  #OFFSET<X:0,Y:5>##IMAGE<ID:1902700034>##OFFSET<X:0,Y:-2># <@leave *01*�뿪>\n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg
end

function OpenShop(npc, player, id)
    lualib:OpenShop(npc, player, tonumber(id))
    return ""
end

function ShowRepire(npc, player)
    lualib:ShowForm(player, "�����")
    return ""
end

function ShowRepireEx(npc, player)
    lualib:ShowForm(player, "���������")
    return ""
end

function SellItem(npc, player, id)
    lualib:ShowForm(player, "������Ʒ��")
    return ""
end

function leave(player)
    return ""
end


function main_ex(npc, player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."��#COLORCOLOR_LIGHTBROWN#�X���������[���X���������[���X���������[���X���������[#COLOREND#\n"
    msg = msg.."#COLORCOLOR_RED#��#COLOREND##COLORCOLOR_LIGHTBROWN#��#COLOREND#<@InfoItemRefine *01*װ������>#OFFSET<X:-2,Y:0>##COLORCOLOR_LIGHTBROWN#��#COLOREND##COLORCOLOR_RED#��#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#��#COLOREND#<@FengYin *01*�����ӡ>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#��#COLOREND##COLORCOLOR_RED#��#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#��#COLOREND#<@jinglianzhuanyi *01*����ת��>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#��#COLOREND##COLORCOLOR_RED#��#COLOREND##COLOREND##COLORCOLOR_LIGHTBROWN#��#COLOREND#<@jingliangaibian *01*�����ı�>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#��#COLOREND##COLORCOLOR_RED#��#COLOREND#\n"
    msg = msg.."��#COLORCOLOR_LIGHTBROWN#�^���������a���^���������a���^���������a���^���������a#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."��#OFFSET<X:0,Y:4>##IMAGE<ID:1902700017>#<@jinglianjiesao *01*[����˵��]>#IMAGE<ID:1902700017>#<@fengyinjiesao *01*[��ӡ˵��]>#IMAGE<ID:1902700017>#<@zhuanyijiesao *01*[ת��˵��]>#IMAGE<ID:1902700017>#<@gaibianjieshao *01*[�ı�˵��]>\n"
    return msg
end

function zhuanyijiesao(npc, player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."��ҿ�������#COLORCOLOR_GOLD#ת��ʯ#COLOREND#����������ת�Ƶ�ͬ����װ���ϣ�#COLORCOLOR_GOLD#ת��ʯ#COLOREND#ӵ�ж��ּ��𣬿��Զ�Ӧת�Ʋ�ͬ����ľ�������.\n"
    msg = msg.."�������Ϸ�п�ͨ���������ͻ�ķ�ʽ���#COLORCOLOR_GOLD#ת��ʯ#COLOREND#��\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."����������������������������������            ����#OFFSET<X:0,Y:1>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01* [����]>\n"
    return msg
end


function gaibianjieshao(npc, player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."��ҿ�������#COLORCOLOR_GOLD#��Ԫ����#COLOREND#���������Ըı�ɴ�װ���ɾ����������������ԡ�\n"
    msg = msg.."�������Ϸ�п�ͨ����ķ�ʽ���#COLORCOLOR_GOLD#��Ԫ����#COLOREND#��\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."����������������������������������        ��    ��#OFFSET<X:0,Y:2>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01* [����]>\n"
    return msg
end


function jinglianjiesao(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-6>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."#OFFSET<X:0,Y:-4>##COLORCOLOR_RED#��#COLOREND#������һ����Ϊ15���ȼ����ȼ�Խ�ߣ������ɹ�����Խ�ͣ���\n \n"
    msg = msg.."#OFFSET<X:0,Y:-2>#����Ԫ������ҲԽ��С��Ŷ������ʧ�ܿ��ǻ������Ŷ\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@main *01*����һҳ��>��������������������������      <@jinglianjiesao1 *01*����һҳ��>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao1(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-6>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."#OFFSET<X:0,Y:-4>##COLORCOLOR_RED#��#COLOREND#����ͬ����װ�����������������Ͳ�ͬ����ͬʱֻ�ܾ���һ\n \n"
    msg = msg.."#OFFSET<X:0,Y:-2>#����������\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao *01*����һҳ��>��������������������������      <@jinglianjiesao2 *01*����һҳ��>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao2(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-6>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."#OFFSET<X:0,Y:-4>##COLORCOLOR_RED#��#COLOREND#�����Я��ȫ�׾���+6��+9��+12��+15��װ�����и������ԣ���\n \n"
    msg = msg.."#OFFSET<X:0,Y:-2>#�������������Խ������ʾ�������£�\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao1 *01*����һҳ��>��������������������������      <@jinglianjiesao3 *01*����һҳ��>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#"
    return msg
end




function zbxiayiye(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-9>##COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#========================================================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n \n"
    msg = msg.."������ #OFFSET<X:0,Y:-5>##COLORCOLOR_BLUE#�X�j�j�j�j�j�j�j�[�������X�j�j�j�j�j�j�j�[#COLOREND#\n"
    msg = msg.."������ #OFFSET<X:0,Y:-4>##COLORCOLOR_BLUE#�d#COLOREND#<@shuxingduiying *01*װ����Ӧ������>#OFFSET<X:-2,Y:0>##COLORCOLOR_BLUE#�p�p�p�p�p#COLOREND#<@fujia *01*װ�����ӵ�����>#OFFSET<X:-2,Y:0>##COLORCOLOR_BLUE#�g#COLOREND#\n"
    msg = msg.."������ #OFFSET<X:0,Y:-4>##COLORCOLOR_BLUE#�^�m�m�m�m�m�m�m�a���p���^�m�m�m�m�m�m�m�a#COLOREND#\n"
    msg = msg.."���������� #OFFSET<X:0,Y:-3>##COLORCOLOR_RED#�d#COLOREND##COLORCOLOR_GOLD#�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T#COLOREND##COLORCOLOR_RED#�e#COLOREND#\n \n"

    msg = msg.."��#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>#<@jinglianjiesao *01*����һҳ��>��#OFFSET<X:1,Y:0>##COLORCOLOR_GOLD#����������������������#COLOREND#��#IMAGE<ID:1902700019>#<@main *01*��������ҳ��>\n\n"

    return msg
end


function jinglianjiesao3(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_RED#װ���ɾ���������#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_GOLD#��   ��������ָ�� #OFFSET<X:2,Y:0>#��#COLOREND##COLORCOLOR_RED#������#COLOREND##COLORCOLOR_ORANGE#�﹥���ޡ�ħ�����ޡ���������#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_GOLD#���·���ͷ����Ь�ӡ�#COLOREND##COLORCOLOR_RED#������#COLOREND##COLORCOLOR_ORANGE#������ޡ�ħ������#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_GOLD#���������������#COLOREND##COLORCOLOR_RED#������#COLOREND##COLORCOLOR_ORANGE#HP���ޡ�MP����#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_BLUE#�������Զ�Ϊ�ٷֱȣ������������������ԡ�#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao2 *01*����һҳ��>��������������������������      <@jinglianjiesao4 *01*����һҳ��>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n \n"
    return msg
end

function jinglianjiesao4(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#���ȫ��+6װ�����ԣ�\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#������ޡ��������ٷ�֮����#COLORCOLOR_RED#��#COLOREND#�﹥���ޡ��������ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#ħ�����ޡ��������ٷ�֮����#COLORCOLOR_RED#��#COLOREND#ħ�����ޡ��������ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#*HP*���ޡ�#OFFSET<X:1,Y:0>#�������ٷ�֮����#COLORCOLOR_RED#��#COLOREND#�������ޡ��������ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#��#COLOREND#*MP*���ޡ�#OFFSET<X:1,Y:0>#������#OFFSET<X:1,Y:0>#�ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao3 *01*����һҳ��>��������������������������      <@jinglianjiesao5 *01*����һҳ��>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao5(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#���ȫ��+9װ�����ԣ�\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#������ޡ��������ٷ�֮����#COLORCOLOR_RED#��#COLOREND#�﹥���ޡ��������ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#ħ�����ޡ��������ٷ�֮����#COLORCOLOR_RED#��#COLOREND#ħ�����ޡ��������ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#*HP*���ޡ�#OFFSET<X:1,Y:0>#�������ٷ�֮����#COLORCOLOR_RED#��#COLOREND#�������ޡ��������ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#��#COLOREND#*MP*���ޡ�#OFFSET<X:1,Y:0>#������#OFFSET<X:1,Y:0>#�ٷ�֮��\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao4 *01*����һҳ��>��������������������������      <@jinglianjiesao6 *01*����һҳ��>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao6(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#���ȫ��+12װ�����ԣ�\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#������ޡ������ٷ�֮ʮ��#COLORCOLOR_RED#��#COLOREND#�﹥���ޡ������ٷ�֮ʮ\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#ħ�����ޡ������ٷ�֮ʮ��#COLORCOLOR_RED#��#COLOREND#ħ�����ޡ������ٷ�֮ʮ\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#*HP*���ޡ�#OFFSET<X:1,Y:0>#�����ٷ�֮ʮ��#COLORCOLOR_RED#��#COLOREND#�������ޡ������ٷ�֮ʮ\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#��#COLOREND#*MP*���ޡ�#OFFSET<X:1,Y:0>#�����ٷ�֮ʮ\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao5 *01*����һҳ��>��������������������������      <@jinglianjiesao7 *01*����һҳ��>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao7(npc , player)
    local msg = " #COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ����װ������ϵͳ#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#���ȫ��+15װ�����ԣ�\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#������ޡ������ٷ�֮ʮ�塡#COLORCOLOR_RED#��#COLOREND#�﹥���ޡ������ٷ�֮ʮ��\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#ħ�����ޡ������ٷ�֮ʮ�塡#COLORCOLOR_RED#��#COLOREND#ħ�����ޡ������ٷ�֮ʮ��\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#��#COLOREND#*HP*���ޡ�#OFFSET<X:1,Y:0>#�����ٷ�֮ʮ�塡#COLORCOLOR_RED#��#COLOREND#�������ޡ������ٷ�֮ʮ��\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#��#COLOREND#*MP*���ޡ�#OFFSET<X:1,Y:0>#�����ٷ�֮ʮ��\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao7 *01*����һҳ��>������������������������       #OFFSET<X:0,Y:2>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*������ҳ>\n"
    return msg
end


function fengyinjiesao(npc , player)
    local msg = ""
    msg = msg.."�٣�װ������������װ���������벻�������ԣ�\n"
    msg = msg.."�ڣ�װ������ʱ��߿ɻ��3�����ԣ��������м��ʻ�ñ�������     Ѫ��ϡ�����ԣ�\n"
    msg = msg.."�ۣ������ظ������������ʲô���ԾͿ������������\n"
    msg = msg.."\n\n"
    msg = msg.."#OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@FengYin *01*װ������>\n"
    msg = msg.."#OFFSET<X:0,Y:5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2># <@main *01*����>\n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg

end

function InfoItemRefine(npc, player)
    lualib:ShowForm(player, "������2")

    return ""
end

function FengYin(npc, player)
    --[[local msg = ""
    local StartServerTime = lualib:GetConstVar("StartServerTime")
    local StartServerTime_int = lualib:Str2Time(StartServerTime)
    local times = lualib:GetAllTime()
    local timesStr = lualib:Time2Str( "%Y-%m-%d %H:%M:%S", times)

    local time_cha = times - StartServerTime_int

    if time_cha < 86400 * 5 then 	--(5��)
        msg = msg .. "#OFFSET<X:0,Y:2>##COLORCOLOR_GREENG#��ӡ����ϵͳ���ڿ���5���������5���������~\n"
        msg = msg.."������������������������������������������������#OFFSET<X:0,Y:2>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01* [����]>\n"
        return msg
    end--]]

    --lualib:ShowForm(player, "������")
    lualib:ShowFormWithContent(player, "form�ļ���", "װ������2")

    return ""
end

function jinglianzhuanyi(npc, player)
    lualib:ShowForm(player, "����ת�Ʊ�")

    return ""
end

function jingliangaibian(npc, player)
    lualib:ShowForm(player, "�����ı��")

    return ""
end

-----��������-----

function talk(npc, player)
    if lualib:Level(player) < 35 then
        lualib:SetPanelSize(npc, 400, 200)
        return "\n �˵��ǻ�������ģ���˵����û����ħǿ�������ǣ������ǿ���\n ��������õı�����Ȼ���������ʵ�����ݴ���һֻ��������\n �������ˣ���֪���Ƿ���˵��\n\n\n  #COLORCOLOR_MAGENTA#�������������������ȼ��ﵽ35����Я��3�鴿��15���Ͻ��#COLOREND#\n  #COLORCOLOR_MAGENTA#����֮�л�ȡ˵���������ȡ����!"
    end
    local msg = ""
    local itemName = {"���ʯ15", "���ʯ16", "���ʯ17", "���ʯ18", "���ʯ19", "���ʯ20"}
    local count = 0
    for i = 1, #itemName do
        count = count + lualib:ItemCountByKey(player, itemName[i], true, false, false, 2)
    end

    local my_quest = lualib:GetInt(player, "my_quest")

    if count > 0 and my_quest == 0 then
        lualib:SetInt(player, "my_quest", 1)
        msg = [[\n  ����﷢�����ʲô?�ѵ��ǽ��?
		��Щ�õĿ�ʯ������ô�����ģ�
		��������������Ϊ����������֮����\n\n



		<@talk *01*�����Ի�>]]
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end

    if my_quest == 1 and count >= 3 then
        msg = [[\n  ��˵�����������ˣ�
		����Ӧ����Ϊ����������֮�У����Ͼ�����ʹ��ˣ�
		��������ѿ�ʯ���ң�Ȼ��ȥ���ҵ�ʦ���������ģ�
		���İ����ǿ���ʦ��ͬ�š�\n\n
		
		<@give *01*�õĸ���> 
		<@refuse *01*�ܾ�>]]
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end

    if my_quest == 2 then
        msg = [[\n  �治����˼��
		�ҹ���ſ���Щ��ʯ�ˣ�
		�ҵ�ʦ�ܾ�����ɽ�ǵ���������\n\n


		
		<@leave *01*�õģ�лл>]]
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end

    msg = "\n �˵��ǻ�������ģ���˵����û����ħǿ�������ǣ������ǿ���\n ��������õı�����Ȼ���������ʵ�����ݴ���һֻ��������\n �������ˣ���֪���Ƿ���˵��\n\n"
    --msg = msg.."#OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@maincaihe *01*������>����\n\n\n\n"
    --msg = msg.."<@leave *01*֪����> \n"
    msg = msg.." #COLORCOLOR_MAGENTA#����������������������ȼ��ﵽ35��Я��3�鴿��15���Ͻ��#COLOREND#\n"
    msg = msg.." #COLORCOLOR_MAGENTA#����֮�л�ȡ˵���������ȡ����!#COLOREND#\n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg

end

function refuse(npc, player)
    local msg = [[\n ʲô��������������Ŷ�����������ڻ����ҡ�
	��ô�������˰���
	�������������֣��Ժ���Ҳ�п��ܲ�����������
	�㻹��־ܾ���\n
	
	
	 <@give *01*�õĸ���>
	 <@refuseEx *01*���Ǿܾ�> \n]]
    lualib:SetPanelSize(npc, 400, 200)
    return msg
end

function refuseEx(npc, player)
    local msg = "\n �����ô�����?\n �����Ҿ�û�취��?���߰�!\n \n\n\n\n\n\n"
    --msg = msg.."<@leave *01*�رնԻ�> \n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg
end

function give(npc, player)
    local msg = ""
    local count = 0
    local itemName = {"���ʯ15", "���ʯ16", "���ʯ17", "���ʯ18", "���ʯ19", "���ʯ20"}
    local delItem = {}
    for i = 1, #itemName do
        count = count + lualib:ItemCountByKey(player, itemName[i], true, false, false, 2)
    end

    if count < 3  then
        msg = "\n �˵��ǻ�������ģ���˵����û����ħǿ�������ǣ������ǿ���\n ��������õı�����Ȼ���������ʵ�����ݴ���һֻ��������\n �������ˣ���֪���Ƿ���˵��\n ����������������������ȼ��ﵽ35��Я��3�鴿��15���Ͻ��\n \n \n"
        --msg = msg.."<@leave *01*�رնԻ�> \n"
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end
    local x = 0
    for i = 1, #itemName do
        local itemCount = lualib:ItemCount(player,itemName[i])
        x = #delItem
        for j=1,itemCount do
            delItem[x+j] = itemName[i]
        end

        if #delItem >= 3 then
            for k = 1, 3 do
                lualib:DelItem(player,delItem[k],1,2,"����֮������","������")
            end
            lualib:SetInt(player, "dddddd   d   dddddddd", 2)
            lualib:SetPanelSize(npc, 400, 200)
            return "\n  �ô��Ŀ�ʯ����������ȥ����ʦ�ܰɣ���վ��������\n\n \n \n\n \n \n  <@talk *01*�㻹û�и�����ȥ��Ѱ�����ʦ��>"
        end

    end

    return msg
end


--------���------


--��ע������"#"�������װ��������   chai_ex#Բ��  ��������

local chai_t = {--������ = {�����Сֵ. ������ֵ. ����Ĳ���������, ���Ľ��}
    ["Բ��"] = {1, 5, "����", 100000},
    ["����֮��"] = {5, 10, "����", 10000},
}

local he_t = {--������ = {{����...},{��Ӧ����...},���Ľ��}
    ["��˵֮��"] = {{"����֮��", "����", "����֮��"}, {1, 50, 5}, 1000000},
    ["����֮��"] = {{"Բ��", "����", "����֮��"}, {1, 20, 2}, 500000},
}

function maincaihe(npc, player)
    local msg = [[
    �͹����ã��ҿ��԰���ѵͼ��Ķ��Ʋ���Ϊ#COLORCOLOR_GOLD#��������#COLOREND#��ÿ�β�������������������Ƕ���߼����Ʊر����ϣ������ѡ����Ҫ���еĲ����ɡ�
	
#IMAGE1902700035#<@chai *01*���>����        #COLORCOLOR_GREENG#�뽫��Ҫ���Ķ��Ʒ��ڱ���#COLOREND#
#IMAGE1902700035#<@he *01*����>�߼�����    #COLORCOLOR_GREENG#�뽫������Ҫ�Ĳ��Ϸ��ڱ���#COLOREND#
	
]]
    lualib:SetPanelSize(npc, 400, 188)
    return msg
end


function chai(npc, player)
    local msg = [[
��ѡ����Ҫ���Ķ��ƣ�


#IMAGE1902700035#<@chai_ex#Բ�� *01*���>Բ��        #COLORCOLOR_GREENG#����������1~5������#COLOREND#

	]]
    lualib:SetPanelSize(npc, 400, 188)
    return msg
end

function chai_ex(npc, player, key)
    lualib:SetPanelSize(npc, 400, 188)
    if lualib:ItemCount(player, key) < 1 then
        return "���ı����в�û�С�#COLORCOLOR_GREENG#"..key.."#COLOREND#����"
    end
    if lualib:GetBagFree(player) < 1 then
        return "���ı����ռ䲻��һ��"
    end
    if not lualib:SubGold(player, chai_t[key][4], "���Ʋ��", npc) then
        return "���Ľ�Ҳ��㡰#COLORCOLOR_GREENG#"..chai_t[key][4].."#COLOREND#����"
    end
    if not lualib:DelItem(player, key, 1, 2, "���Ʋ��", npc) then
        return "ɾ������ʧ�ܡ�"
    end
    local rnd = lualib:GenRandom(chai_t[key][1], chai_t[key][2])
    lualib:AddItem(player, chai_t[key][3], rnd, false, "���Ʋ��", npc)
    return "��ϲ���ɹ���⡰#COLORCOLOR_GREENG#"..key.."#COLOREND#������� #COLORCOLOR_GREENG#"..rnd.."#COLOREND# ��#COLORCOLOR_GREENG#"..chai_t[key][3].."#COLOREND#��\n\n\n<@chai_ex#Բ�� *01*����>���Բ��\n"
end


function he(npc, player)
    local msg = [[
��ѡ����Ҫ����Ķ��ƣ�


#IMAGE1902700035#<@he_ex#����֮�� *01*����>����֮��    #COLORCOLOR_GREENG#    Բ��+����20��+����֮��2��+ 50����#COLOREND#
#IMAGE1902700035#<@he_ex#��˵֮�� *01*����>��˵֮��    #COLORCOLOR_GREENG#����֮��+����50��+����֮��5��+100����#COLOREND#

	]]
    lualib:SetPanelSize(npc, 400, 188)
    return msg
end


function he_ex(npc, player, key)
    lualib:SetPanelSize(npc, 400, 188)
    if lualib:GetBagFree(player) < 1 then
        return "���ı����ռ䲻��һ��"
    end
    for i = 1, #he_t[key][1] do
        if lualib:ItemCount(player, he_t[key][1][i]) < he_t[key][2][i] then
            return "���ı����в�û���㹻�����ġ�#COLORCOLOR_GREENG#"..he_t[key][1][i].."#COLOREND#����"
        end
    end
    if lualib:GetGold(player) < he_t[key][3] then
        return "��Ǹ�����Ľ�Ҳ���#COLORCOLOR_GREENG#"..he_t[key][3].."#COLOREND#��"
    end
    for k = 1, #he_t[key][1] do
        if not lualib:DelItem(player, he_t[key][1][k], he_t[key][2][k], 2, "���ƶ���", npc) then
            return "ɾ��ԭ����ʧ�ܡ�"
        end
    end
    if not lualib:SubGold(player, he_t[key][3], "���ƶ���", npc) then
        return "�۳����ʧ�ܡ�"
    end
    lualib:AddItem(player, key, 1, false, "���ƶ���", npc)
    lualib:SysMsg_SendBroadcastColor("��ҡ�"..lualib:Name(player).."������ǧ��������ڳɹ������������Ʒ��"..lualib:KeyName2Name(key, 4).."��", "ϵͳ֪ͨ", 7, 13)
    return "��ϲ���ɹ����조#COLORCOLOR_GREENG#"..key.."#COLOREND#����"
end