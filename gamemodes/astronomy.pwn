// Astronomy Role Play by tsunamicxde (01.06.2017 version)
main() { }
// ============================= [ Include's ] =================================
#include 	<a_samp>
#include 	<a_mysql>
#include 	<foreach>
#include 	<mxdate>
#include 	<Pawn.CMD>
#include 	<streamer>
#include 	<sscanf2>
#include 	<a_engine>
// ============================= [ Color's ] ===================================
#define     COLOR_GREY      		0xBEBEBEFF
#define     COLOR_WHITE     		0xFFFFFFFF
#define     COLOR_LRED 				0xF85E43AA
#define		COLOR_GOLD				0xFFD700FF
#define     COLOR_YELLOW            0xFFFF00FF
#define     COLOR_PURPLE    		0x6A5ACDFF
#define     COLOR_VIOLET    		0x483D8BFF
#define		COLOR_ORANGE			0xFF4500FF
#define		COLOR_LGREEN			0x32CD32FF
#define		COLOR_GREEN				0x008000FF
#define		COLOR_ASTRONOMY			0x4169E1FF
#define     COLOR_BLUE              0x4682B4FF
// ============================= [ Define's ] ==================================
#define     SCM             		SendClientMessage
#define     SCMTA           		SendClientMessageToAll
#define     GN(%0)					player_name[%0]
#define     SPD             		ShowPlayerDialog
#define     DSL             		DIALOG_STYLE_LIST
#define     DSI             		DIALOG_STYLE_INPUT
#define     DSM             		DIALOG_STYLE_MSGBOX
#define     DSP             		DIALOG_STYLE_PASSWORD
#define     tkick(%0)       		SetTimerEx("@_TimeKick", 100, false, "i", %0)
#define     ftime(%0)       		SetTimerEx("@_FarmTime", 1000, false, "i", %0)
#define     Freeze                  TogglePlayerControllable
// ============================= [ Data Base ] =================================
#define 	MYSQL_HOST      		"127.0.0.1"
#define 	MYSQL_USER      		"root"
#define 	MYSQL_DB     			"astronomyrp"
#define 	MYSQL_PASS     			""
// ============================= [ Variable's ] ================================
//                               [ MYSQL ]
new
	connect_mysql,
	player_name[MAX_PLAYERS][MAX_PLAYER_NAME+1];
// ============================= [ Massive's ] =================================
//                               [ Statistic ]
enum pInfo {
	pid,
	ppassword[32+1],
 	pmail[64+1],
	psex,
	page,
	ppass,
	pskin,
	plevel,
	pexp,
	pcash,
	pmoney,
	pdate_reg[10+1],
	pquest,
	pquestpoint,
	ppquest,
	psquest,
	pprava,
	pgold,
	papple,
	pwork,
	pfskill,
	pcatalina,
	pbcar,
	pbhacker,
	pstart,
	pfactskill,
	pmetall,
	pcrisp,
	pshawarma,
	psprunk,
	pcola,
	pbeer,
	pcigarette,
	pzhiga,
	pphone,
	pbook,
	pmag,
	prguitar,
	pbguitar,
	pwguitar,
	pmeat,
	pcozha,
	pmprava,
	pgunlic,
	phuntlic,
	pfishlic
	
}
new
	player[MAX_PLAYERS][pInfo];
//                               [ Choose Skin ]
new number_skin[MAX_PLAYERS char];
new Text: td_select_skin[MAX_PLAYERS][3];
new bool: login_check[MAX_PLAYERS char];
new bool: EngineState[MAX_VEHICLES];

new number_pass[MAX_PLAYERS char];
new login_timer[MAX_PLAYERS];
new update_timer[MAX_PLAYERS];
//                               [ Twice massive's ]
new sex_info[3][7+1] = {
	{"-"}, {"�������"}, {"�������"}
};

new
    hour_server,
    minute_server,
    second_server;
    
new Farmenter;
new Farmexit;
new Farmbox;
new Farmclothes;
new farmer[2];
new sadler[6];

new zero;
new zeropick;
new basepick;
new rcpd[2];
new mayor[3];
new catalina[2];
new mad;
//new alcoseller;

new autoschool[3];

new qtractor[4];
new tractor[4];

new farmquest[MAX_PLAYERS];

new pfarm[MAX_PLAYERS];
enum
{
	CHECKPOINT_1,
	CHECKPOINT_2,
	CHECKPOINT_3,
	CHECKPOINT_4,
	CHECKPOINT_5,
	CHECKPOINT_6,
	CHECKPOINT_7,
	CHECKPOINT_8,
	CHECKPOINT_9,
	CHECKPOINT_10,
	CHECKPOINT_11,
	CHECKPOINT_12,
	CHECKPOINT_13,
	CHECKPOINT_14,
	CHECKPOINT_15,
	CHECKPOINT_16,
	CHECKPOINT_17,
	CHECKPOINT_18,
	CHECKPOINT_19,
	CHECKPOINT_20,
	CHECKPOINT_21,
	CHECKPOINT_22,
	CHECKPOINT_23,
	CHECKPOINT_24,
	CHECKPOINT_25,
	CHECKPOINT_26,
	CHECKPOINT_27
}

new
	sabre,
	bobcat,
	rumpo;
	
new starterpack;
new agun;
new factory[11];
new ftractor[5];

new eva[2];
new shop24[4];
new aaron[3];
new victim[3];

new deer[3];
new lesnik[2];
new ammo[4];
new lesnikcar[2];
new deerkill[MAX_PLAYERS];
// ============================= [ Public's ] ==================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case 1:// Registration
		{
			if(response)
			{
				new len = strlen(inputtext);
			    if(isnull(inputtext))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}�� ������ �� �����");
				    RegDialog(playerid);
				    return true;
				}
				if(!(6 <= len <= 32))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}�������� ����� ������");
				    RegDialog(playerid);
				    return true;
				}
				if(CheckRussianText(inputtext, len+1))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}������ �� ����� ��������� ������� �������");
				    RegDialog(playerid);
				    return true;
				}
				MailDialog(playerid);
				strmid(player[playerid][ppassword], inputtext, 0, len+1, 33);
			}
			else
			{
			    SCM(playerid, COLOR_LRED, !"����� �����, ������� (/q)uit");
			    tkick(playerid);
			}
		}
		case 2:// Mail
		{
			if(response)
			{
				new len = strlen(inputtext);
			    if(isnull(inputtext))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}�� ������ �� �����");
				    MailDialog(playerid);
				    return true;
				}
				if(len > 64)
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}�������� ����� ����������� �����");
				    MailDialog(playerid);
				    return true;
				}
				if(CheckRussianText(inputtext, len+1))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}����� �� ����� ��������� ������� �������");
				    MailDialog(playerid);
				    return true;
				}
				if(strfind(inputtext, "@", true) == -1 || strfind(inputtext, ".", true) == -1)
				{
    				SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}������������ ����� ����������� �����");
				    MailDialog(playerid);
				    return true;
				}
				SexDialog(playerid);
				strmid(player[playerid][pmail], inputtext, 0, len, 64+1);
			}
			else
			{
			    RegDialog(playerid);
			}
		}
		case 3:// Sex
		{
		    if(response)
		    {
				player[playerid][psex] = 1;
				SetPlayerSkin(playerid, 184);
				number_skin{playerid} = 1;
		    }
		    else
		    {
		        player[playerid][psex] = 2;
		        SetPlayerSkin(playerid, 93);
		        number_skin{playerid} = 11;
		    }
		    for(new i; i != 3; i++) TextDrawShowForPlayer(playerid, td_select_skin[playerid][i]);
			//SpawnPlayer(playerid);
			SelectTextDraw(playerid, 0xFF0000FF);
			SetPlayerPos(playerid, 868.4749,-29.1391,63.1953);
			SetPlayerFacingAngle(playerid, 156.8917);
			SetPlayerVirtualWorld(playerid, playerid);
			SetPlayerCameraPos(playerid, 866.6572,-33.0052,63.1953);
			SetPlayerCameraLookAt(playerid, 868.4749,-29.1391,63.1953);
			Freeze(playerid, 0);
		}
		case 4:
		{
		    if(response)
		    {
		        if(!strlen(inputtext))
		        {
		            SCM(playerid, COLOR_GREY, !"�� ������ �� �����");
		            AutorizationDialog(playerid);
		            return true;
		        }
		        static
				    fmt_str[] = "SELECT * FROM `accounts` WHERE `Name` = '%s' AND `Password` = '%s'";
				new
					string[sizeof(fmt_str)+MAX_PLAYER_NAME+29];
				mysql_format(connect_mysql, string, sizeof(string), fmt_str, GN(playerid), inputtext);
				mysql_function_query(connect_mysql, string, true, "@_OnLogin", "d", playerid);
		    }
		    else
		    {
		        SCM(playerid, COLOR_LRED, !"����� �����, ������� (/q)uit");
			    tkick(playerid);
		    }
		}
		case 5:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0: ShowStats(playerid, playerid);
		        }
			}
		}
		case 6:
		{
		    if(!response)
		    {
		        callcmd::menu(playerid);
			}
		}
		case 7:
		{
		    if(response)
		    {
			    if(GetPVarInt(playerid, "Box") == 0)
			    {
					SetPlayerSkin(playerid, 202);
					SetPVarInt(playerid, "Box", 1);
					SCM(playerid, COLOR_GREEN, "�� ������ ������� ����. �������� ������ ���� ��� ������ ������.");
				}
				else
				{
				    SetPlayerSpecialAction(playerid, 0);
				    SetPlayerSkin(playerid, player[playerid][pskin]);
				    if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) RemovePlayerAttachedObject(playerid, 1);
				    player[playerid][pcash] += (GetPVarInt(playerid, "BoxK")*15);
					new string[30];
					format(string, sizeof(string), "�� ���������� %d ��������", GetPVarInt(playerid, "BoxK")*15);
					SCM(playerid, COLOR_GREEN, string);
					DeletePVar(playerid, "BoxK");
					DeletePVar(playerid, "Box");
					DeletePVar(playerid, "BoxW");
					DisablePlayerCheckpoint(playerid);
				}
			}
		}
		case 8:
		{
		    if(response)
		    {
		        SetPVarInt(playerid, "Database", 1);
		        SetPlayerCheckpoint(playerid, 626.9654,-571.8405,17.9207, 5.0);
				SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}����� ��������� �� ��������� ������� �������, ������ ����� ������ � ������. �������� ���� :*");
		    }
		}
		case 9:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
			        case 0:
			        {
						SCM(playerid, COLOR_ORANGE, !"����� ���� ������ - 10 ���������");
						SPD(playerid, 10, DSL, "����� ���� ������", "2. ����� ���� ���� ������", "�����", "������");
					}
				}
		    }
		}
		case 10:
		{
		    if(response)
		    {
		    	switch(listitem)
		        {
			        case 0:
			        {
			            SCM(playerid, COLOR_ORANGE, !"���� ���� ������ - 30 ���������");
						SCM(playerid, COLOR_YELLOW, !"�������� ���� �� ���������� ����� � ����-����");
						SPD(playerid, 12, DSL, "����� ���� ������", "1. ���� �������\n2. ��������������\n3. ���������� ����� ����-����\n4. ���������������� ����� �������", "�����", "������");
					}
				}
		    }
		}
		case 12:
		{
			if(response)
		    {
		        switch(listitem)
		        {
			        case 0:
			        {
						SCM(playerid, COLOR_ORANGE, !"���� 241: ���� ������� - Michael Coleman");
					}
					case 1:
			        {
						SCM(playerid, COLOR_ORANGE, !"���� 695: �������������� - Jessica Wexler");
					}
					case 2:
			        {
						new string[88];
			            SCM(playerid, COLOR_ORANGE, !"���� ���� ������ - 60 ���������");
						format(string, sizeof(string), "���� 404: ���������� ����� ����-���� - %s", GN(playerid));
						SCM(playerid, COLOR_YELLOW, string);
						SPD(playerid, 13, DSL, "����� ���� ������", "������� ������", "�����", "������");
					}
					case 3:
			        {
						SCM(playerid, COLOR_ORANGE, !"���� 308: ��������� - Vincento Plootin");
					}
				}
		    }
		}
		case 13:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
			        case 0:
			        {
						SCM(playerid, COLOR_ORANGE, !"����� ���� ������ - 99 ���������");
						SCM(playerid, COLOR_YELLOW, !"����� ���� ������ - 100 ���������");
	                    SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}�� ������� ������� ������ � ���� � ���� ������. ���������� � ����.");
	                    SetPlayerCheckpoint(playerid, 194.5604,-114.9737,1.5497, 3.0);
	                    SetPVarInt(playerid, "Database", 3);
			        }
				}
		    }
		}
		case 14:
		{
		    if(response)
		    {
		        SetPVarInt(playerid, "zeropass", 1);
		        SetPlayerCheckpoint(playerid, 1481.0521,-1772.3132,18.7958, 3.0);
				SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}������������� � ������ ����� ���-�������");
		    }
		}
		case 15:
		{
		    if(response)
		    {
		        SPD(playerid, 16, DSI, "��������� ��������", "������� ��� ���?", "�����", "������");
		    }
		}
		case 16:
		{
		    if(response)
		    {
		        new val = strval(inputtext);
			    if(isnull(inputtext))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}�� ������ �� �����");
				    SPD(playerid, 16, DSI, "��������� ��������", "������� ��� ���?", "�����", "������");
				    return true;
				}
				if(!(18 <= val <= 60))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}������� ������ ���� �� 18 �� 60 ���");
				    SPD(playerid, 16, DSI, "��������� ��������", "������� ��� ���?", "�����", "������");
				    return true;
				}
				player[playerid][page] = val;
		        SPD(playerid, 17, DSI, "��������� ��������", "� ����� ������ �� ��������?", "�����", "������");
		    }
		}
		case 17:
		{
		    if(response)
		    {
		        if(isnull(inputtext))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}�� ������ �� �����");
				    SPD(playerid, 17, DSI, "��������� ��������", "� ����� ������ �� ��������?", "�����", "������");
				    return true;
				}
				SPD(playerid, 18, DSI, "��������� ��������", "��������� ���� �������:", "�����", "������");
		    }
		}
		case 18:
		{
			if(response)
			{
			    new len = strlen(inputtext);
			    if(isnull(inputtext))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}�� ������ �� �����");
				    SPD(playerid, 18, DSI, "��������� ��������", "��������� ���� �������:", "�����", "������");
				    return true;
				}
				if(!(3 <= len <= 10))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}������� ������ ��������� �� 3 �� 10 ��������");
				    SPD(playerid, 18, DSI, "��������� ��������", "��������� ���� �������:", "�����", "������");
				    return true;
				}
				if(CheckRussianText(inputtext, len+1))
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}������� �� ����� ��������� ������� �������");
				    SPD(playerid, 18, DSI, "��������� ��������", "��������� ���� �������:", "�����", "������");
				    return true;
				}
				player[playerid][ppass] = 1;
				SCM(playerid, COLOR_GREEN, "[����������] {FFFFFF}����������� � ���������� ��������!");
				SCM(playerid, COLOR_ASTRONOMY, "[�����] {FFFFFF}���������� � ����.");
				SetPVarInt(playerid, "zeropass", 2);
				SetPlayerCheckpoint(playerid, 194.5604,-114.9737,1.5497, 3.0);
			}
		}
		case 19:
		{
			if(response)
		    {
		        SetPVarInt(playerid, "zerocat", 1);
		        SetPlayerCheckpoint(playerid, -76.2200,97.4648,3.1172, 3.0);
				SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}������������� �� ����� �����");
		    }
		}
		case 20:
		{
		    if(response)
		    {
				player[playerid][pexp] += 1;
				player[playerid][pquestpoint] = 4;
        		if(player[playerid][pexp] == player[playerid][plevel]*4)
				{
				    player[playerid][pexp] = 0;
				    player[playerid][plevel] ++;
				    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
				}
		    }
		}
		case 21:
		{
			if(response)
		    {
                player[playerid][pquestpoint] = 5;
				SCM(playerid, COLOR_GREEN, "[�����]: {FFFFFF}�������� � ������ ����� � ���������� �� ������ ����������� �������");
		    }
		}
		case 22:
		{
			if(response)
		    {
				SCM(playerid, COLOR_GREEN, "[�����]: {FFFFFFF}�������� � ������ ����� � ���������� �� ������ ����������� �������");
		    }
		}
		case 23:
		{
		    if(response)
			{
				SetPlayerCheckpoint(playerid, 1374.1296,404.9809,19.9555, 3.0);
				SCM(playerid, COLOR_ASTRONOMY, "[�����] {FFFFFF}������������� � ������ ��������� � ����������.");
				SetPVarInt(playerid, "zeroschool", 1);
			}
		}
		case 24:
		{
		    if(response)
			{
			    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}����� ������������ �������� � ������?");
				SPD(playerid, 25, DSL, "�������", "1.��� �����������\n2.120 ��/�\n3.60 ��/�\n4.30 ��/�", "�����", "������");
			}
			else
			{
			    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
			}
		}
		case 25:
		{
		    if(response)
			{
				switch(listitem)
				{
					case 0:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 1:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 2:
					{
					    SCM(playerid, COLOR_YELLOW, "����� ������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}����� ������������ �������� � �� �������?");
						SPD(playerid, 26, DSL, "�������", "1.��� �����������\n2.80 ��/�\n3.120 ��/�\n4.100 ��/�", "�����", "������");
					}
					case 3:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
				}
			}
			else
			{
			    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
			}
		}
		case 26:
		{
		    if(response)
			{
				switch(listitem)
				{
					case 0:
					{
					    SCM(playerid, COLOR_YELLOW, "����� ������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}� ����� ������� �������� ����� ����������");
						SPD(playerid, 27, DSL, "�������", "1.� �����\n2.� ������\n3.� �����", "�����", "������");
					}
					case 1:
					{
                        SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 2:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 3:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
				}
			}
			else
			{
			    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
			}
		}
        case 27:
		{
		    if(response)
			{
				switch(listitem)
				{
					case 0:
					{
					    SCM(playerid, COLOR_YELLOW, "����� ������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}��� ����� ������� � ����� ����� �����?");
						SPD(playerid, 28, DSL, "�������", "1.������ ����\n2.���������� �� �������\n3.�������� ����\n4.������� � ������� � ����������", "�����", "������");
					}
					case 1:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 2:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 3:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
				}
			}
			else
			{
			    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
			}
		}
		case 28:
		{
		    if(response)
			{
				switch(listitem)
				{
					case 0:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 1:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
					case 2:
					{
					    SCM(playerid, COLOR_YELLOW, "����� ������");
						SCM(playerid, COLOR_ORANGE, "����������� � �������� ����������� �����!");
						SCM(playerid, COLOR_YELLOW, "[�����] {FFFFFF}��������� � �����, ����� �������� ��������� �������");
						SetPlayerCheckpoint(playerid, -76.2200,97.4648,3.1172, 3.0);
						SetPVarInt(playerid, "gps", 1);
						DeletePVar(playerid, "zeroschool");
                        player[playerid][pexp] += 1;
						player[playerid][pquestpoint] = 7;
						player[playerid][pprava] = 1;
						SCM(playerid, COLOR_LGREEN, !"[�������] {FFFFFF}���������: ������������ ������������� � 1 exp");
						if(player[playerid][pexp] == player[playerid][plevel]*4)
						{
						    player[playerid][pexp] = 0;
						    player[playerid][plevel] ++;
						    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
						}
					}
					case 3:
					{
					    SCM(playerid, COLOR_LRED, "���� �� �������� ��������");
					    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
					}
				}
			}
			else
			{
			    SCM(playerid, COLOR_ORANGE, "[���������] {FFFFFF}�� ������ ��������� � ������ ��������� � ��� ��� ������ ����.");
			}
		}
		case 29:
		{
		    if(response)
		    {
		        if(player[playerid][pcash] >= 30)
		        {
		            SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ���������� ����������");
		            player[playerid][pcash] -= 30;
					SetPVarInt(playerid, "sadler", 1);
		        }
		        else
		        {
		            SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ������������ �����");
		            RemovePlayerFromVehicle(playerid);
		        }
		    }
		    else
		    {
		        RemovePlayerFromVehicle(playerid);
		    }
		}
		case 30:
		{
		    SetPVarInt(playerid, "Melnik", 1);
		    SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}��������� �����");
		}
		case 31:
		{
		    if(response)
		    {
		        SetPVarInt(playerid, "Water", 1);
                SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}��������� ��� ������ � �����");
		    }
		}
		case 32:
		{
		    if(response)
		    {
				if(player[playerid][pcash] >= 500)
				{
				    player[playerid][pcash] -= 500;
					SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 5.0);
					SetPVarInt(playerid, "Water", 2);
					SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�� ������� ����������� �����");
				}
				else
				{
				    SCM(playerid, COLOR_LRED, !"������� ���������! � ��� ������������ �����");
				    DeletePVar(playerid, "Water");
				    DisablePlayerCheckpoint(playerid);
				}
		    }
		    else
		    {
		        SCM(playerid, COLOR_LRED, !"������� ���������!");
		    	DeletePVar(playerid, "Water");
		    	DisablePlayerCheckpoint(playerid);
		    }
		}
		case 33:
		{
		    if(response)
		    {
		        if(player[playerid][pcash] >= 30)
		        {
		            SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ���������� ����������");
		            player[playerid][pcash] -= 30;
		            if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 7)
					{
                        SetPVarInt(playerid, "Melnik", 2);
                        SetPlayerCheckpoint(playerid, 2156.2085,-119.7273,1.3841, 5.0);
		    			SCM(playerid, COLOR_ASTRONOMY, "[�����] {FFFFFF}������� � ������ ������, ����� ���� ��������� ������� � �����");
					}
					SetPVarInt(playerid, "sadler", 1);
		        }
		        else
		        {
		            SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ������������ �����");
		            RemovePlayerFromVehicle(playerid);
		        }
		    }
		    else
		    {
		        RemovePlayerFromVehicle(playerid);
		    }
		}
		case 34:
		{
		    if(response)
		    {
		        if(player[playerid][pcash] >= 30)
		        {
		            SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ���������� ����������");
		            player[playerid][pcash] -= 30;
					SetPVarInt(playerid, "sadler", 1);
		        }
		        else
		        {
		            SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ������������ �����");
		            RemovePlayerFromVehicle(playerid);
		        }
		    }
		    else
		    {
		        RemovePlayerFromVehicle(playerid);
		    }
		}
		case 35:
		{
		    if(response)
		    {
		        if(player[playerid][pcash] >= 30)
		        {
		            SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ���������� ����������");
		            player[playerid][pcash] -= 30;
					SetPVarInt(playerid, "sadler", 1);
		        }
		        else
		        {
		            SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ������������ �����");
		            RemovePlayerFromVehicle(playerid);
		        }
		    }
		    else
		    {
		        RemovePlayerFromVehicle(playerid);
		    }
		}
		case 36:
		{
		    if(response)
		    {
		        if(player[playerid][pcash] >= 30)
		        {
		            SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ���������� ����������");
		            player[playerid][pcash] -= 30;
					SetPVarInt(playerid, "sadler", 1);
		        }
		        else
		        {
		            SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ������������ �����");
		            RemovePlayerFromVehicle(playerid);
		        }
		    }
		    else
		    {
		        RemovePlayerFromVehicle(playerid);
		    }
		}
		case 37:
		{
		    if(response)
		    {
		        if(player[playerid][pcash] >= 30)
		        {
		            SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ���������� ����������");
		            player[playerid][pcash] -= 30;
					SetPVarInt(playerid, "sadler", 1);
		        }
		        else
		        {
		            SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ������������ �����");
		            RemovePlayerFromVehicle(playerid);
		        }
		    }
		    else
		    {
		        RemovePlayerFromVehicle(playerid);
		    }
		}
		case 38:
		{
		    if(response)
		    {
				SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 5.0);
				SetPVarInt(playerid, "Melnik", 2);
				SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�� ������� ��������� ������� � �����");
			}
		    else
		    {
		        SCM(playerid, COLOR_LRED, !"������� ���������!");
		    	DeletePVar(playerid, "Melnik");
		    }
		}
		case 39:
		{
		    if(response)
		    {
			    SetPlayerAttachedObject(playerid, 1, 19637, 1,-0.050000,0.463495,-0.024351,357.460632,87.350753,88.068374);
				ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
				SetPlayerSpecialAction(playerid, 25);
				SetPlayerCheckpoint(playerid, -70.1338,18.4345,3.1172, 3.0);
				SetPVarInt(playerid, "BoxW", 1);
				SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ���� �����. �������� ��� �� ����� �����");
			}
		}
		case 40:
		{
		    if(response)
		    {
		        SetPVarInt(playerid, "Corn", 1);
                SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}��������� ��� ������ � �����");
		    }
		}
		case 41:
		{
		    if(response)
		    {
				if(player[playerid][pcash] >= 500)
				{
				    player[playerid][pcash] -= 500;
					SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 5.0);
					SetPVarInt(playerid, "Corn", 2);
					SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�� ������� ����������� ������");
				}
				else
				{
				    SCM(playerid, COLOR_LRED, !"������� ���������! � ��� ������������ �����");
				    DeletePVar(playerid, "Corn");
				    DisablePlayerCheckpoint(playerid);
				}
		    }
		    else
		    {
		        SCM(playerid, COLOR_LRED, !"������� ���������!");
		    	DeletePVar(playerid, "Corn");
		    	DisablePlayerCheckpoint(playerid);
		    }
		}
		case 42:
		{
		    if(response)
		    {
		        SetPVarInt(playerid, "ntractor", 1);
		        SetPlayerCheckpoint(playerid, 1077.4578,-288.2145,73.9560, 5.0);
		        SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}���������� �� �������� � �������� �����");
		    }
		}
		case 43:
		{
		    if(response)
		    {
		        farmquest[playerid] = 1;
		        SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}�������� ������ �������");
		    }
		}
		case 44:
		{
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
			            if(player[playerid][pwork] == 1 || player[playerid][pwork] == 2 || player[playerid][pwork] == 3)
			            {
			                if(player[playerid][pwork] != 0)
			                {
			                    if(player[playerid][pwork] == 1)
			                	{
					                if(GetPVarInt(playerid, "Box") == 0) SPD(playerid, 7, DSM, "����������", "�� ������ ������ ������ ��������?", "��", "���");
									else SPD(playerid, 7, DSM, "����������", "�� ������ ��������� ������� ����?", "��", "���");
								}
							}
							else
							{
								SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}��� ������ ���������� �� ������");
							}
			            }
			        }
			        case 1:
			        {
						player[playerid][pwork] = 1;
						SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ���������� �� ������ ��������� �������");
			        }
			        case 2:
			        {
			            if(player[playerid][pfskill] >= 250)
			            {
							player[playerid][pwork] = 2;
							SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ���������� �� ������ �����������");
						}
						else
						{
						    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}� ��� ������������ ������ ������� (( /fskill ))");
						}
			        }
			        case 3:
			        {
			            if(player[playerid][pfskill] >= 1000)
			            {
							player[playerid][pwork] = 3;
							SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ���������� �� ������ ����������");
						}
						else
						{
						    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}� ��� ������������ ������ ������� (( /fskill ))");
						}
			        }
			    }
			}
		}
		case 45:
		{
		    if(response)
		    {
		        if(player[playerid][pgold] >= 15)
		        {
		            player[playerid][pquest] = 2;
		            player[playerid][pquestpoint] = 1;
		            SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}��� �������� ������� ��� ���������� � ����������");
		        }
		        else
				{
				    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ������������ gold coins");
				}
		    }
		}
		case 46:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(player[playerid][pquestpoint] == 1)
		                {
	              			SPD(playerid, 47, DSM, "��������",
							"\
								{FFFFFF}� ������ ������� ��� � ����� ����� �� ���� ����� ������. ����� � ��� ����� �� ������� ���� � ����� ���-�������.\
								\n{FFFFFF}��� ���������: 30 �������� �� �������� Desert Eagle � 20 �������� �� ��������.\
								\n{FFFFFF}�������, ��� ����� ���������� �� ������� ���� � �� �������� �� �����.\
								\n{008000}[�������]:{FFFFFF} ������� ���� ������ �� ������� ����\
								\n{4169E1}[�������]:{FFFFFF} 1 exp", "�����", "������\
							");
		                }
		            }
		            case 1:
		            {
		                if(player[playerid][pquestpoint] == 2)
		                {
	              			SPD(playerid, 48, DSM, "��������",
							"\
								{FFFFFF}����� ��������� �����, �� ������ �������� ����������. � ��������� ���-������� ����� ��������� ���������, �� ����� �����.\
								\n{FFFFFF}�� � ��� ������ �������� � �����������, ��� �������� �� ���� �� ����� � ���������� �����, ������� �� ��������.\
								\n{FFFF00}[����������] {FFFFFF}��������, ���������� Sabre ������� 10 ������� � ���������, ����� ���������� �������� ��������.\
								\n{FFFF00}[����������] {FFFFFF}����� Bobcat ������� 30 ������� � ���������, ����� ������� ��������.\
								\n{FFFF00}[����������] {FFFFFF}������ Rumpo ������� 60 ������� � ���������, ����� ������ ��������.\
								\n{008000}[����������]:{FFFFFF} �������� ��������� ��� ������", "�����", "������\
							");
		                }
		            }
		            case 2:
		            {
		                if(player[playerid][pquestpoint] == 3)
		                {
	              			SPD(playerid, 50, DSM, "��������",
							"\
								{FFFFFF}� ���� ������� ������ ������� �����. �� ����� ��������� ������������, �� ������� ������� ����.\
								\n{FFFFFF}���� ��� ������, ���������� ���. �� � ��� ������ ������ � ������ ��������.\
								\n{FFFF00}[����������] {FFFFFF}��������, �������� ����� - ���������� ����� �������, ������� ������ �������� ������������. ��� ������� 20 ��������� �� �������.\
								\n{FFFF00}[����������] {FFFFFF}���� - ������, ����� ����� ���������� �������������, �� ������� ��������� ������. �� ������� 5 ��������� �� �������.\
								\n{008000}[����������]:{FFFFFF} �������� ������", "�����", "������\
							");
		                }
		            }
		        }
		    }
		}
		case 47:
		{
		    if(response)
		    {
			    SetPVarInt(playerid, "bgun", 1);
			    SetPlayerCheckpoint(playerid, 2788.6790,-2464.1206,13.6334, 3.0);
			    SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}������������� � ���� ���-������� � �������� ���� � �������");
			}
		}
		case 48:
		{
		    if(response)
		    {
		        SPD(playerid, 49, DSL, "��������� ��� ������", "{4169E1}[1] {FFFFFF}Sabre\n{4169E1}[2] {FFFFFF}Bobcat\n{4169E1}[3] {FFFFFF}Rumpo", "�����", "������");
			}
		}
		case 49:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
						SCM(playerid, COLOR_YELLOW, "[����������] {FFFFFF}���������� Sabre ����������� � ��������� Cluckin Bell � ���-�������");
						SetPVarInt(playerid, "sabre", 1);
						SetPlayerCheckpoint(playerid, 2380.2622,-1927.7852,13.1886, 5.0);
		            }
		            case 1:
		            {
						SCM(playerid, COLOR_YELLOW, "[����������] {FFFFFF}���������� Bobcat ����������� � �������� 24/7 � ���-�������");
						SetPVarInt(playerid, "bobcat", 1);
						SetPlayerCheckpoint(playerid, 2052.6885,-1903.9987,13.5363, 5.0);
		            }
		            case 2:
		            {
						SCM(playerid, COLOR_YELLOW, "[����������] {FFFFFF}���������� Rumpo ����������� � �������� 24/7 � ���-�������");
						SetPVarInt(playerid, "rumpo", 1);
						SetPlayerCheckpoint(playerid, 2489.4246,-1953.2429,13.5372, 5.0);
		            }
		        }
		    }
		}
		case 50:
		{
		    if(response)
		    {
		        SPD(playerid, 51, DSL, "�����", "{4169E1}[1] {FFFFFF}�������� �����\n{4169E1}[2] {FFFFFF}����", "�����", "������");
			}
		}
		case 51:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
						SCM(playerid, COLOR_YELLOW, "[����������] {FFFFFF}�������� ����� ���� �� ��������, ���������� � ���");
						SetPVarInt(playerid, "pagehack", 1);
						SetPlayerCheckpoint(playerid, 1531.9976,-807.8114,72.3779, 3.0);
		            }
		            case 1:
		            {
						SCM(playerid, COLOR_YELLOW, "[����������] {FFFFFF}���� ���� � ����� Blueberry, ���������� � ���");
						SetPVarInt(playerid, "zerohack", 1);
						SetPlayerCheckpoint(playerid, 194.5604,-114.9737,1.5497, 3.0);
		            }
		        }
		    }
		}
		case 52:
		{
		    if(response)
		    {
				SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}��������� ����� ������� �������!");
				player[playerid][pgold] += 5;
				player[playerid][papple] += 10;
				player[playerid][pstart] = 1;
			}
		}
		case 53:
		{
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
			            if(player[playerid][pwork] == 4 || player[playerid][pwork] == 5 || player[playerid][pwork] == 6)
			            {
			                if(player[playerid][pwork] != 0)
			                {
			                    if(player[playerid][pwork] == 4)
			                	{
					                if(GetPVarInt(playerid, "Fact") == 0) SPD(playerid, 54, DSM, "����������", "�� ������ ������ ������ �� ������?", "��", "���");
									else SPD(playerid, 54, DSM, "����������", "�� ������ ��������� ������� ����?", "��", "���");
								}
							}
							else
							{
								SCM(playerid, COLOR_GREY, !"[����������] {FFFFFF}��� ������ ���������� �� ������");
							}
			            }
			        }
			        case 1:
			        {
						player[playerid][pwork] = 4;
						SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ���������� �� ������ ���������� �������");
			        }
			        case 2:
			        {
			            if(player[playerid][pfactskill] >= 250)
			            {
							player[playerid][pwork] = 5;
							SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ���������� �� ������ ��������������������� ��������");
						}
						else
						{
						    SCM(playerid, COLOR_GREY, !"[����������] {FFFFFF}� ��� ������������ ������ (( /factoryskill ))");
						}
			        }
			        case 3:
			        {
			            if(player[playerid][pfactskill] >= 1000)
			            {
							player[playerid][pwork] = 6;
							SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ���������� �� ������ ������������");
						}
						else
						{
						    SCM(playerid, COLOR_GREY, !"[����������] {FFFFFF}� ��� ������������ ������ (( /factoryskill ))");
						}
			        }
			    }
			}
		}
		case 54:
		{
		    if(response)
		    {
			    if(GetPVarInt(playerid, "Fact") == 0)
			    {
					SetPlayerSkin(playerid, 50);
					SetPVarInt(playerid, "Fact", 1);
					SCM(playerid, COLOR_BLUE, "[�����] {FFFFFF}�� ������ ������� ����. �������� ��������� ��� ������������ ������.");
				}
				else
				{
				    SetPlayerSkin(playerid, player[playerid][pskin]);
				    if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) RemovePlayerAttachedObject(playerid, 1);
				    SetPlayerSpecialAction(playerid, 0);
				    player[playerid][pcash] += (GetPVarInt(playerid, "FactK")*15);
					new string[30];
					format(string, sizeof(string), "�� ���������� %d ��������", GetPVarInt(playerid, "FactK")*15);
					SCM(playerid, COLOR_BLUE, string);
					DeletePVar(playerid, "FactK");
					DeletePVar(playerid, "Fact");
					DisablePlayerCheckpoint(playerid);
				}
			}
		}
		case 55:
		{
			if(response)
			{
		    	SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}�������� 20 ������� �� ������ � �������� �������");
			}
		}
		case 56:
		{
		    if(response)
		    {
		    	SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}�������� ������� �� ����� � �������� �������");
			}
		}
		case 57:
		{
		    if(response)
		    {
		        SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}������������� � ������� 24/7 � �������� � ������ ��� ����� �������.");
		        SCM(playerid, COLOR_LGREEN, !"[���������] {FFFFFF}����� �������� �� ���������.");
		        SetPVarInt(playerid, "gps", 1);
		        SetPlayerCheckpoint(playerid, 171.8525,-200.8556,1.5703, 3.0);
		    }
		}
		case 58:
		{
			if(response)
			{
			    switch(listitem)
			    {
			        case 0: SPD(playerid, 59, DSL, "���", "{FF0000}1. {FFFFFF}����� - 100$\n{FF0000}2. {FFFFFF}������ - 200$", "������", "�����");
			        case 1: SPD(playerid, 60, DSL, "�������", "{FF0000}1. {FFFFFF}������ - 50$\n{FF0000}2. {FFFFFF}����-���� - 80$\n{FF0000}3. {FFFFFF}���� - 100$", "������", "�����");
			        case 2: SPD(playerid, 61, DSL, "��������", "{FF0000}1. {FFFFFF}Marlboro Red - 250$\n{FF0000}2. {FFFFFF}Captain Black - 350$\n{FF0000}3. {FFFFFF}American Spirit - 600$\n{FF0000}4. {FFFFFF}��������� Zippo - 100$", "������", "�����");
			        case 3: SPD(playerid, 62, DSL, "�������", "{FF0000}1. {FFFFFF}Xiaomi Redmi 4a - 500$\n{FF0000}2. {FFFFFF}���������� ����� - 100$", "������", "�����");
			    }
			}
		}
		case 59:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(player[playerid][pcash] >= 100)
		                {
		                    if(player[playerid][pcrisp] < 10)
		                    {
			                    player[playerid][pcash] -= 100;
			                    player[playerid][pcrisp] += 1;
			                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ����� ������ �� 100 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
			                    SPD(playerid, 59, DSL, "���", "{FF0000}1. {FFFFFF}����� - 100$\n{FF0000}2. {FFFFFF}������ - 200$", "������", "�����");
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 10 ����� ������");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		            case 1:
		            {
		                if(player[playerid][pcash] >= 200)
		                {
		                    if(player[playerid][pshawarma] < 5)
		                    {
			                    player[playerid][pcash] -= 200;
			                    player[playerid][pshawarma] += 1;
			                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ������ �� 200 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
			                    SPD(playerid, 59, DSL, "���", "{FF0000}1. {FFFFFF}����� - 100$\n{FF0000}2. {FFFFFF}������ - 200$", "������", "�����");
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 5 ������");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		        }
		    }
		    else
		    {
		        SPD(playerid, 58, DSL, "������� 24/7", "{FF0000}1. {FFFFFF}���\n{FF0000}2. {FFFFFF}�������\n{FF0000}3. {FFFFFF}��������\n{FF0000}4. {FFFFFF}�������", "�����", "������");
		    }
		}
		case 60:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(player[playerid][pcash] >= 50)
		                {
		                    if(player[playerid][psprunk] < 10)
		                    {
			                    player[playerid][pcash] -= 50;
			                    player[playerid][psprunk] += 1;
			                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ����� ������� �� 50 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
	                            SPD(playerid, 60, DSL, "�������", "{FF0000}1. {FFFFFF}������ - 50$\n{FF0000}2. {FFFFFF}����-���� - 80$\n{FF0000}3. {FFFFFF}���� - 100$", "������", "�����");
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 10 ����� �������");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		            case 1:
		            {
		                if(player[playerid][pcash] >= 80)
		                {
		                    if(player[playerid][pcola] < 10)
		                    {
			                    player[playerid][pcash] -= 80;
			                    player[playerid][pcola] += 1;
			                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ����� ���� �� 80 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
			                    SPD(playerid, 60, DSL, "�������", "{FF0000}1. {FFFFFF}������ - 50$\n{FF0000}2. {FFFFFF}����-���� - 80$\n{FF0000}3. {FFFFFF}���� - 100$", "������", "�����");
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 10 ����� ����-����");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		            case 2:
		            {
		                if(player[playerid][pcash] >= 100)
		                {
		                    if(player[playerid][pbeer] < 5)
		                    {
			                    player[playerid][pcash] -= 100;
			                    player[playerid][pbeer] += 1;
			                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ������� ���� �� 100 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
			                    SPD(playerid, 60, DSL, "�������", "{FF0000}1. {FFFFFF}������ - 50$\n{FF0000}2. {FFFFFF}����-���� - 80$\n{FF0000}3. {FFFFFF}���� - 100$", "������", "�����");
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 5 ������� ����");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		        }
		    }
		    else
		    {
		        SPD(playerid, 58, DSL, "������� 24/7", "{FF0000}1. {FFFFFF}���\n{FF0000}2. {FFFFFF}�������\n{FF0000}3. {FFFFFF}��������\n{FF0000}4. {FFFFFF}�������", "�����", "������");
		    }
		}
		case 61:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(player[playerid][pcash] >= 250)
		                {
							if(player[playerid][pcigarette] <= 80)
							{
			                    player[playerid][pcash] -= 250;
			                    player[playerid][pcigarette] += 20;
			                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ����� ������� �� 250 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
	                            SPD(playerid, 61, DSL, "��������", "{FF0000}1. {FFFFFF}Marlboro Red - 250$\n{FF0000}2. {FFFFFF}Captain Black - 350$\n{FF0000}3. {FFFFFF}American Spirit - 600$\n{FF0000}4. {FFFFFF}��������� Zippo - 100$", "������", "�����");
                                if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 14)
								{
								    if(player[playerid][pphone] == 1)
								    {
								        player[playerid][pquestpoint] = 15;
										player[playerid][pgold] += 1;
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������� ��������. ��������� � ���, ����� �������� ��� �������");
								        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 1 gold coin � 1 exp");
								        player[playerid][pexp] += 1;
								        if(player[playerid][pexp] == player[playerid][plevel]*4)
										{
										    player[playerid][pexp] = 0;
										    player[playerid][plevel] ++;
										    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
										}
										SetPVarInt(playerid, "gps", 1);
										SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
								    }
								    else
								    {
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������ ������ �������");
								    }
								}
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 5 ����� �������");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		            case 1:
		            {
		                if(player[playerid][pcash] >= 350)
		                {
		                    if(player[playerid][pcigarette] <= 80)
							{
			                    player[playerid][pcash] -= 350;
			                    player[playerid][pcigarette] += 20;
			                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ����� ������� �� 350 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
			                    SPD(playerid, 61, DSL, "��������", "{FF0000}1. {FFFFFF}Marlboro Red - 250$\n{FF0000}2. {FFFFFF}Captain Black - 350$\n{FF0000}3. {FFFFFF}American Spirit - 600$\n{FF0000}4. {FFFFFF}��������� Zippo - 100$", "������", "�����");
                                if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 14)
								{
								    if(player[playerid][pphone] == 1)
								    {
								        player[playerid][pquestpoint] = 15;
										player[playerid][pgold] += 1;
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������� ��������. ��������� � ���, ����� �������� ��� �������");
								        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 1 gold coin � 1 exp");
								        player[playerid][pexp] += 1;
								        if(player[playerid][pexp] == player[playerid][plevel]*4)
										{
										    player[playerid][pexp] = 0;
										    player[playerid][plevel] ++;
										    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
										}
										SetPVarInt(playerid, "gps", 1);
										SetPlayerCheckpoint(playerid, 386.1475,-1811.5171,7.8316, 3.0);
								    }
								    else
								    {
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������ ������ �������");
								    }
								}
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 5 ����� �������");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		            case 2:
		            {
		                if(player[playerid][pcash] >= 600)
		                {
		                    if(player[playerid][pcigarette] <= 80)
							{
		                    	player[playerid][pcash] -= 600;
		                    	player[playerid][pcigarette] += 20;
		                    	SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ����� ������� �� 600 ��������");
			                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
		                    	SPD(playerid, 61, DSL, "��������", "{FF0000}1. {FFFFFF}Marlboro Red - 250$\n{FF0000}2. {FFFFFF}Captain Black - 350$\n{FF0000}3. {FFFFFF}American Spirit - 600$\n{FF0000}4. {FFFFFF}��������� Zippo - 100$", "������", "�����");
                                if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 14)
								{
								    if(player[playerid][pphone] == 1)
								    {
								        player[playerid][pquestpoint] = 15;
										player[playerid][pgold] += 1;
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������� ��������. ��������� � ���, ����� �������� ��� �������");
								        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 1 gold coin � 1 exp");
								        player[playerid][pexp] += 1;
								        if(player[playerid][pexp] == player[playerid][plevel]*4)
										{
										    player[playerid][pexp] = 0;
										    player[playerid][plevel] ++;
										    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
										}
										SetPVarInt(playerid, "gps", 1);
										SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
								    }
								    else
								    {
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������ ������ �������");
								    }
								}
							}
							else
							{
							    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� �� ������ ������ ������ 5 ����� �������");
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		            case 3:
		            {
		                if(player[playerid][pcash] >= 100)
		                {
		                    player[playerid][pcash] -= 100;
		                    player[playerid][pzhiga] = 1;
		                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ��������� �� 100 ��������");
		                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
		                    SPD(playerid, 61, DSL, "��������", "{FF0000}1. {FFFFFF}Marlboro Red - 250$\n{FF0000}2. {FFFFFF}Captain Black - 350$\n{FF0000}3. {FFFFFF}American Spirit - 600$\n{FF0000}4. {FFFFFF}��������� Zippo - 100$", "������", "�����");
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		        }
		    }
		    else
		    {
		        SPD(playerid, 58, DSL, "������� 24/7", "{FF0000}1. {FFFFFF}���\n{FF0000}2. {FFFFFF}�������\n{FF0000}3. {FFFFFF}��������\n{FF0000}4. {FFFFFF}�������", "�����", "������");
		    }
		}
		case 62:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(player[playerid][pcash] >= 500)
		                {
		                    player[playerid][pcash] -= 500;
		                    player[playerid][pphone] = 1;
		                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ������� �� 500 ��������");
		                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
		                    SPD(playerid, 62, DSL, "�������", "{FF0000}1. {FFFFFF}Xiaomi Redmi 4a - 500$\n{FF0000}2. {FFFFFF}���������� ����� - 100$", "������", "�����");
							if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 14)
							{
							    if(player[playerid][pcigarette] >= 40)
							    {
							        player[playerid][pquestpoint] = 15;
									player[playerid][pgold] += 1;
							        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������� ��������. ��������� � ���, ����� �������� ��� �������");
							        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 1 gold coin � 1 exp");
							        player[playerid][pexp] += 1;
							        if(player[playerid][pexp] == player[playerid][plevel]*4)
									{
									    player[playerid][pexp] = 0;
									    player[playerid][plevel] ++;
									    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
									}
									SetPVarInt(playerid, "gps", 1);
									SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
							    }
							    else
							    {
							        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������ ������ ��� ����� �������");
							    }
							}
						}
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		            case 1:
		            {
		                if(player[playerid][pcash] >= 100)
		                {
		                    player[playerid][pcash] -= 100;
		                    player[playerid][pbook] = 1;
		                    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������ ���������� ����� �� 100 ��������");
		                    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}����� ������� ���������, ������� /inv ��� ������� N");
		                    SPD(playerid, 62, DSL, "�������", "{FF0000}1. {FFFFFF}Xiaomi Redmi 4a - 500$\n{FF0000}2. {FFFFFF}���������� ����� - 100$", "������", "�����");
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
		                }
		            }
		        }
		    }
		    else
		    {
		        SPD(playerid, 58, DSL, "������� 24/7", "{FF0000}1. {FFFFFF}���\n{FF0000}2. {FFFFFF}�������\n{FF0000}3. {FFFFFF}��������\n{FF0000}4. {FFFFFF}�������", "�����", "������");
		    }
		}
		case 63:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(player[playerid][papple] != 0)
		                {
		                    player[playerid][pcash] += player[playerid][papple]*100;
		                    new string[40];
							format(string, sizeof(string), "�� ������� ������ �� %d ��������",player[playerid][papple]*100);
							SCM(playerid, COLOR_GREEN, string);
							player[playerid][papple] = 0;
							if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 15)
							{
							    if(player[playerid][pmetall] == 0)
							    {
							        player[playerid][pquestpoint] = 16;
									player[playerid][pgold] += 5;
							        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������� ��������. ��������� � ���, ����� �������� ��������� �������");
							        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 5 gold coin � 1 exp");
							        player[playerid][pexp] += 1;
							        if(player[playerid][pexp] == player[playerid][plevel]*4)
									{
									    player[playerid][pexp] = 0;
									    player[playerid][plevel] ++;
									    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
									}
									SetPVarInt(playerid, "gps", 1);
									SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
							    }
							    else
							    {
							        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}������ �������� ���� ������");
							    }
							}
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ��� �����");
		                }
		            }
		            case 1:
		            {
		                if(player[playerid][pmetall] != 0)
		                {
		                    player[playerid][pcash] += player[playerid][pmetall]*100;
		                    new string[40];
							format(string, sizeof(string), "�� ������� ������ �� %d ��������",player[playerid][pmetall]*100);
							SCM(playerid, COLOR_GREEN, string);
							player[playerid][pmetall] = 0;
							if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 15)
							{
							    if(player[playerid][papple] == 0)
							    {
							        player[playerid][pquestpoint] = 16;
									player[playerid][pgold] += 5;
							        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������� ��������. ��������� � ���, ����� �������� ��������� �������");
							        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 5 gold coin � 1 exp");
							        player[playerid][pexp] += 1;
							        if(player[playerid][pexp] == player[playerid][plevel]*4)
									{
									    player[playerid][pexp] = 0;
									    player[playerid][plevel] ++;
									    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
									}
									SetPVarInt(playerid, "gps", 1);
									SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
							    }
							    else
							    {
							        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}������ �������� ��� ������");
							    }
							}
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ��� �������");
		                }
		            }
			        case 2:
					{
					    if(player[playerid][pcozha] != 0)
					    {
					        player[playerid][pcash] += player[playerid][pcozha]*500;
		                    new string[40];
							format(string, sizeof(string), "�� ������� ����� �� %d ��������",player[playerid][pcozha]*500);
							SCM(playerid, COLOR_GREEN, string);
							player[playerid][pcozha] = 0;
							if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 4)
							{
							    if(player[playerid][pmeat] == 0)
							    {
								    player[playerid][pquestpoint] = 5;
									player[playerid][pgold] += 10;
							        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ������. ��������� � �������, ����� �������� ��������� �������");
							        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins � 1 exp");
							        player[playerid][pexp] += 1;
							        if(player[playerid][pexp] == player[playerid][plevel]*4)
									{
									    player[playerid][pexp] = 0;
									    player[playerid][plevel] ++;
									    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
									}
									SetPVarInt(playerid, "gps", 1);
									SetPlayerCheckpoint(playerid, 2355.4419,-657.4797,128.0547, 3.0);
								}
								else
								{
								    SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}������ �������� �� ����");
								}
							}
						}
						else
		                {
		                    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ��� ����");
		                }
					}
					case 3:
					{
					    if(player[playerid][pmeat] != 0)
					    {
					        player[playerid][pcash] += player[playerid][pmeat]*30;
		                    new string[40];
							format(string, sizeof(string), "�� ������� ���� �� %d ��������",player[playerid][pmeat]*30);
							SCM(playerid, COLOR_GREEN, string);
							player[playerid][pmeat] = 0;
						    if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 4)
							{
							    if(player[playerid][pcozha] == 0)
							    {
								    player[playerid][pquestpoint] = 5;
									player[playerid][pgold] += 10;
							        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ������� ������. ��������� � �������, ����� �������� ��������� �������");
							        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins � 1 exp");
							        player[playerid][pexp] += 1;
							        if(player[playerid][pexp] == player[playerid][plevel]*4)
									{
									    player[playerid][pexp] = 0;
									    player[playerid][plevel] ++;
									    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
									}
									SetPVarInt(playerid, "gps", 1);
									SetPlayerCheckpoint(playerid, 2355.4419,-657.4797,128.0547, 3.0);
								}
								else
								{
								    SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}������ �������� ��� �����");
								}
							}
						}
						else
		                {
		                    SCM(playerid, COLOR_LRED, !"[������] {FFFFFF}� ��� ��� ����");
		                }
					}
				}
		    }
		}
		case 64:
		{
		    SetPVarInt(playerid, "gps", 1);
		    SetPlayerCheckpoint(playerid, 1730.1331,97.6677,32.5878, 3.0);
		    SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}���������� �� ��������");
		}
		case 65:
		{
		    SetPVarInt(playerid, "gps", 1);
		    SetPlayerCheckpoint(playerid, 461.7127,-1500.8525,31.0447, 3.0);
		    SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}���������� �� �������� ������");
		}
		case 66:
		{
		    if(response)
		    {
				switch(listitem)
				{
				    case 0:
				    {
				        player[playerid][pmag] = 1;
						SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}���������: ����� ����");
						SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}����� ������ ���������, ������� /inv ��� ������� N");
				        SetPVarInt(playerid, "eva", 1);
				        SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
				        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}���������� �� ��� � ��������� ������� �������");
				    }
				    case 1:
				    {
				        player[playerid][prguitar] = 1;
						SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}���������: ������� ������");
						SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}����� ������ ���������, ������� /inv ��� ������� N");
				        SetPVarInt(playerid, "eva", 1);
				        SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
				        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}���������� �� ��� � ��������� ������� �������");
				    }
				    case 2:
				    {
				        player[playerid][pbguitar] = 1;
						SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}���������: ׸���� ������");
						SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}����� ������ ���������, ������� /inv ��� ������� N");
				        SetPVarInt(playerid, "eva", 1);
				        SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
				        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}���������� �� ��� � ��������� ������� �������");
				    }
				    case 3:
				    {
				        player[playerid][pwguitar] = 1;
						SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}���������: ����� ������");
						SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}����� ������ ���������, ������� /inv ��� ������� N");
				        SetPVarInt(playerid, "eva", 1);
				        SetPlayerCheckpoint(playerid, 383.2361,-1812.7334,7.8319, 3.0);
				        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}���������� �� ��� � ��������� ������� �������");
				    }
				}
		    }
		}
		case 68:
		{
		    if(response)
		    {
		        if(player[playerid][pgunlic] == 0 || player[playerid][phuntlic] == 0)
		        {
					player[playerid][pquest] = 2;
					player[playerid][pquestpoint] = 1;
			        SetPVarInt(playerid, "gps", 1);
			        SetPlayerCheckpoint(playerid, 1374.1296,404.9809,19.9555, 3.0);
			        SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}���������� �� ��������� � ������ �������� �� ����� � ������");
				}
				else
				{
				    SetPVarInt(playerid, "hlic", 1);
				    SetPlayerCheckpoint(playerid, 2355.4419,-657.4797,128.0547, 3.0);
					SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}� ��� ��� ���� ��������. ��������� � �������, ����� ������ �����");
				}
			}
		}
		case 69:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
		                if(player[playerid][pprava] == 0)
		                {
		                    if(player[playerid][pcash] >= 1000)
		                    {
		                        player[playerid][pprava] = 1;
		                        player[playerid][pcash] -= 1000;
		                        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}�� ������ �������� �� ���������� �� 1000 ��������");
                                SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
							}
							else
							{
								SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
							}
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ��� ���� ������������ �����");
		                    SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
		                }
		            }
		            case 1:
		            {
		                if(player[playerid][pmprava] == 0)
		                {
		                    if(player[playerid][pcash] >= 2000)
		                    {
		                        player[playerid][pmprava] = 1;
		                        player[playerid][pcash] -= 2000;
		                        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}�� ������ �������� �� ��������� �� 1000 ��������");
                                SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
							}
							else
							{
								SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
							}
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ��� ���� ����� �� ��������");
		                    SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
		                }
		            }
		            case 2:
		            {
		                if(player[playerid][pgunlic] == 0)
		                {
		                    if(player[playerid][pcash] >= 30000)
		                    {
		                        player[playerid][pgunlic] = 1;
		                        player[playerid][pcash] -= 30000;
		                        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}�� ������ �������� �� ������ �� 1000 ��������");
                                SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
                                if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 1)
								{
								    if(player[playerid][phuntlic] == 1)
								    {
								        SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}������� ��������. ��������� � �������, ����� �������� �������");
				                        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins � 1 exp");
								        player[playerid][pquestpoint] = 2;
								        player[playerid][pgold] += 10;
								        player[playerid][pexp] += 1;
								        Lvlup(playerid);
								        SetPVarInt(playerid, "gps", 1);
								        SetPlayerCheckpoint(playerid, 2355.4419,-657.4797,128.0547, 3.0);
								    }
								    else
								    {
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������ ������ �������� �� �����");
								    }
								}
							}
							else
							{
								SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
							}
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ��� ���� �������� �� ������");
		                    SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
		                }
		            }
		            case 3:
		            {
		                if(player[playerid][phuntlic] == 0)
		                {
		                    if(player[playerid][pcash] >= 10000)
		                    {
		                        player[playerid][phuntlic] = 1;
		                        player[playerid][pcash] -= 10000;
		                        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}�� ������ �������� �� ����� �� 1000 ��������");
                                SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
								if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 1)
								{
								    if(player[playerid][pgunlic] == 1)
								    {
								        SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}������� ��������. ��������� � �������, ����� �������� ���������");
				                        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins � 1 exp");
								        player[playerid][pquestpoint] = 2;
								        player[playerid][pgold] += 10;
								        player[playerid][pexp] += 1;
								        Lvlup(playerid);
								        SetPVarInt(playerid, "gps", 1);
								        SetPlayerCheckpoint(playerid, 2355.4419,-657.4797,128.0547, 3.0);
								    }
								    else
								    {
								        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������ ������ �������� �� ������");
								    }
								}
							}
							else
							{
								SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
							}
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ��� ���� �������� �� �����");
		                    SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
		                }
		            }
		            case 4:
		            {
		                if(player[playerid][pfishlic] == 0)
		                {
		                    if(player[playerid][pcash] >= 5000)
		                    {
		                        player[playerid][pfishlic] = 1;
		                        player[playerid][pcash] -= 5000;
		                        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}�� ������ �������� �� ������� �� 1000 ��������");
                                SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
							}
							else
							{
								SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
							}
		                }
		                else
		                {
		                    SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ��� ���� �������� �� �������");
		                    SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
		                }
		            }
		        }
		    }
		}
		case 70:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 5:
		            {
		                if(player[playerid][pcash] >= 5000)
		                {
		                    player[playerid][pcash] -= 5000;
							GivePlayerWeapon(playerid, 33, 50);
							SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}�� ������ 50 �� Country Rifle �� 5000 $");
							if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 2)
							{
							    SetPVarInt(playerid, "gps", 1);
			        			SetPlayerCheckpoint(playerid, 2355.4419,-657.4797,128.0547, 3.0);
							    player[playerid][pquestpoint] = 3;
							    player[playerid][pgold] += 10;
							    player[playerid][pexp] += 1;
							    Lvlup(playerid);
							    SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}������� ��������. ��������� � �������, ����� �������� ���������");
							    SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins � 1 exp");
							}
		                }
		                else
						{
							SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}� ��� ������������ �����");
						}
		            }
		        }
		    }
		}
		case 71:
		{
		    if(response)
		    {
		        SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���������� �� �������� ������ � ������ Country Rifle");
		        SetPVarInt(playerid, "gps", 1);
		        SetPlayerCheckpoint(playerid, 1368.9189,-1279.8000,13.5469,5.0);
		    }
		}
		case 72:
		{
		    if(response)
		    {
		        SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}������� � ������ 4 ������");
		    }
		}
		case 73:
		{
		    if(response)
		    {
				SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}�������� � ����� �������");
		    }
		}
		case 74:
		{
		    if(response)
		    {
		        if(player[playerid][pcozha] == 0 && player[playerid][pmeat] == 0)
		        {
		            player[playerid][pquestpoint] = 5;
					player[playerid][pgold] += 10;
			        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ��� ������� ������. ��������� � �������, ����� �������� ��������� �������");
			        SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coin � 1 exp");
			        player[playerid][pexp] += 1;
			        if(player[playerid][pexp] == player[playerid][plevel]*4)
					{
					    player[playerid][pexp] = 0;
					    player[playerid][plevel] ++;
					    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
					}
					SetPVarInt(playerid, "gps", 1);
					SetPlayerCheckpoint(playerid, 2355.4419,-657.4797,128.0547, 3.0);
		        }
		        else
		        {
		            SetPVarInt(playerid, "gps", 1);
					SetPlayerCheckpoint(playerid, 1730.1331,97.6677,32.5878, 3.0);
					SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���������� �� ��������");
		        }
		    }
		}
	}
	return true;
}
public OnGameModeInit()
{
	SetGameModeText("Astronomy");
	AddPlayerClass(0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
	ShowNameTags(true);
	SetNameTagDrawDistance(20.0);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights();
	connect_mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	mysql_function_query(connect_mysql, "SET NAMES utf8", false, "", "");
	mysql_function_query(connect_mysql, "SET CHARACTER SET 'cp1251'", false, "", "");
	
    gettime(hour_server, minute_server, second_server);
	SetTimer("@_UpdateServer", 1000, false);
	SetTimer("@_UpdateTime", 1000, true);
	SetWorldTime(hour_server);
	
	Farmenter = CreatePickup(1318,2,-77.7740,90.1817,3.1172);
	Farmexit = CreatePickup(1318,2,311.0793,307.1111,1003.3047,1);
	Farmbox = CreatePickup(19639,23,-80.5480,82.7625,3.1096,0);
	Farmclothes = CreatePickup(1275,2,300.4799,305.8118,1003.5391,1);
	
	CreateObject(792, -306.56921, 216.32730, 8.82183,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -120.30130, 102.20810, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -116.52771, 110.07938, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -112.98419, 118.81579, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -109.81620, 127.62020, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -107.36500, 136.46249, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -104.99010, 145.37500, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -112.74260, 148.95110, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -116.16460, 139.16090, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -118.97719, 131.04875, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -122.16990, 121.77790, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -124.51219, 113.45513, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -127.87188, 104.49107, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -121.19360, 151.61670, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -124.51739, 142.47743, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -127.29050, 134.97360, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -129.65036, 124.78491, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -133.04620, 117.25540, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -136.58189, 108.24380, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -129.64529, 154.48920, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -132.47400, 145.75470, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -135.59081, 137.88229, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -137.66719, 128.14461, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -141.01241, 120.88610, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -143.70840, 110.92540, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -137.27400, 157.71970, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -140.65849, 149.31180, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -142.62917, 140.57639, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -146.38150, 131.58130, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -148.67220, 124.73340, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -151.81239, 114.76940, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -145.28020, 160.82829, 3.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -148.13730, 153.06760, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -151.01669, 145.01579, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -154.59790, 135.32390, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -157.74350, 128.41270, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -160.60100, 117.97793, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -168.17390, 121.86800, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -165.07909, 131.20996, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -162.43161, 138.25240, 2.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -159.44490, 148.14580, 3.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -156.61459, 156.21310, 3.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -153.61079, 163.63789, 4.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -162.19020, 165.86400, 5.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -164.79610, 159.68730, 4.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -167.43430, 152.20720, 3.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -171.03000, 142.32350, 3.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -173.52538, 134.53644, 3.00000,   0.00000, 0.00000, 0.00000);
	CreateObject(792, -176.25130, 125.69810, 2.00000,   0.00000, 0.00000, 0.00000);
	
    zero = CreateActor(289, 195.0379,-115.4922,1.5499,41.9901);
    zeropick = CreatePickup(1239,2,194.5604,-114.9737,1.5497,0);
    basepick = CreatePickup(1239,2,326.7894,304.4804,999.1484,-1);
    rcpd[0] = CreatePickup(1318,2,626.9654,-571.8405,17.9207);
	rcpd[1] = CreatePickup(1318,2,322.1577,302.3583,999.1484,-1);
	
	mayor[0] = CreatePickup(1318,2,1481.0521,-1772.3132,18.7958);
	mayor[1] = CreatePickup(1318,2,390.7690,173.7667,1008.3828,1);
	mayor[2] = CreatePickup(1581,2,358.2367,169.0213,1008.3828,1);
	
	catalina[0] = CreateActor(298, 877.2381,-30.5948,63.1953,163.5416);
	catalina[1] = CreatePickup(1239,2,877.0898,-31.2817,63.1953,0);
	
	farmer[0] = CreateActor(158, -75.1447,97.2261,3.1172,72.8187);
	farmer[1] = CreatePickup(1239,2,-76.2200,97.4648,3.1172,0);
	
	autoschool[0] = CreatePickup(1318,2,1374.1296,404.9809,19.9555);
	autoschool[1] = CreatePickup(1318,2,-2026.9296,-103.6018,1035.1835,1);
	autoschool[2] = CreatePickup(1239,2,-2026.7808,-114.3420,1035.1719,1);
	
	sadler[0] = AddStaticVehicle(543,-78.8956,75.5324,2.9273,69.0322,99,99);
	sadler[1] = AddStaticVehicle(543,-80.4235,71.5349,2.9388,69.6426,99,99);
	sadler[2] = AddStaticVehicle(543,-81.7407,67.4738,2.9338,69.7129,99,99);
	sadler[3] = AddStaticVehicle(543,-83.2357,62.9749,2.9383,69.4650,99,99);
	sadler[4] = AddStaticVehicle(543,-69.6287,103.5041,2.9276,71.6901,99,99);
	sadler[5] = AddStaticVehicle(543,-68.3204,108.0005,2.9388,73.0889,99,99);
	
	qtractor[0] = AddStaticVehicle(531,1077.4578,-288.2145,73.9560,177.8939,222,222);
	qtractor[1] = AddStaticVehicle(531,1074.0842,-288.2949,73.9598,178.9152,222,222);
	qtractor[2] = AddStaticVehicle(531,1070.7030,-288.3053,73.9598,181.4594,222,222);
	qtractor[3] = AddStaticVehicle(531,1067.1368,-288.5568,73.9562,180.9164,222,222);
	
	tractor[0] = AddStaticVehicle(531,-101.8617,23.5282,3.0801,68.3539,86,86);
	tractor[1] = AddStaticVehicle(531,-103.6193,19.8100,3.0808,68.0460,86,86);
	tractor[2] = AddStaticVehicle(531,-104.9616,16.0586,3.0781,69.0255,86,86);
	tractor[3] = AddStaticVehicle(531,-106.3368,12.5286,3.0787,69.4231,86,86);
	
	sabre = AddStaticVehicle(475,2380.2622,-1927.7852,13.1886,359.1244,6,6);
	bobcat = AddStaticVehicle(422,2052.6885,-1903.9987,13.5363,179.1208,7,7);
	rumpo = AddStaticVehicle(440,2489.4246,-1953.2429,13.5372,359.9983,3,3);
	
	mad = CreateActor(191, 1533.6042,-807.8335,72.3146,91.2674);
	
	//alcoseller = CreateActor(191, 252.5770,-54.8286,1.5776,181.4827);
	
	starterpack = CreatePickup(1276,2,196.9530,-103.7179,1.5506,0);
	
	agun = CreatePickup(3014,2,2788.6790,-2464.1206,13.6334,0);

	factory[0] = CreateActor(259, -106.8317,-311.1241,1.4297,275.2108);
    factory[1] = CreatePickup(1275,2,2567.5784,-1280.2489,1044.1250,1);
    factory[2] = CreatePickup(1239,23,2543.1038,-1287.2180,1044.1250,1);
    factory[3] = CreatePickup(1239,23,2551.1064,-1287.2184,1044.1250,1);
    factory[4] = CreatePickup(1239,23,2543.1038,-1287.2180,1044.1250,1);
    factory[5] = CreatePickup(1239,23,2543.1086,-1300.0944,1044.1250,1);
    factory[6] = CreatePickup(1239,23,2551.1738,-1300.0945,1044.1250,1);
    factory[7] = CreatePickup(1239,23,2559.1179,-1300.0945,1044.1250,1);
    factory[8] = CreatePickup(1318,23,-86.2744,-299.3629,2.7646,0);
    factory[9] = CreatePickup(1318,23,2570.4868,-1301.8997,1044.1250,1);
    factory[10] = CreatePickup(1239,2,-106.1318,-311.0517,1.4297,0);
    
    ftractor[0] = AddStaticVehicle(531,106.6736,-290.9833,1.5409,0.5952,198,198);
	ftractor[1] = AddStaticVehicle(531,102.1054,-291.0260,1.5425,357.6959,198,198);
	ftractor[2] = AddStaticVehicle(531,97.7804,-290.9246,1.5445,359.0871,198,198);
	ftractor[3] = AddStaticVehicle(531,93.4588,-290.8277,1.5427,358.0938,198,198);
	ftractor[4] = AddStaticVehicle(531,88.9214,-290.5841,1.5419,357.0355,198,198);
	
	shop24[0] = CreatePickup(1318,23,171.8525,-200.8556,1.5703,0);
	shop24[1] = CreatePickup(1318,23,-25.8501,-188.2535,1003.5469,1);
	shop24[2] = CreatePickup(1239,2,-28.9359,-185.1332,1003.5469,1);
	shop24[3] = CreateActor(128, -28.7544,-186.8231,1003.5469,359.9793);
	SetActorVirtualWorld(shop24[3], 1);
	
	eva[0] = CreateActor(93, 385.1399,-1812.8562,7.8319,86.3145);
	eva[1] = CreatePickup(1239,2,383.2361,-1812.7334,7.8319,0);
	
	aaron[0] = CreateActor(34, 1728.8546,96.3444,32.4457,320.7414);
	aaron[1] = CreatePickup(1239,2,1730.1331,97.6677,32.5878,0);
	aaron[2] = AddStaticVehicle(440,1728.1439,95.0785,32.4518,226.1709,10,10);
	
	victim[0] = CreatePickup(1318,23,461.7127,-1500.8525,31.0447,0);
	victim[1] = CreatePickup(1318,23,227.5633,-8.0949,1002.2109,1);
	victim[2] = CreatePickup(1239,2,213.5755,-5.1505,1001.2109,1);
	
	deer[0] = CreateObject(19315,2368.8831,-148.5168,27.0989,0.0,0.0,0.0);
	SetTimerEx("@_deer1", 5000, false, "i", deer[0]);
	deer[1] = CreateObject(19315,2622.9863,-62.5590,51.8781,0.0,0.0,0.0);
	SetTimerEx("@_deer2", 5000, false, "i", deer[1]);
	deer[2] = CreateObject(19315,2504.0647,-218.2203,24.6313,0.0,0.0,0.0);
	SetTimerEx("@_deer3", 5000, false, "i", deer[2]);
	
	lesnik[0] = CreateActor(179, 2354.5500,-657.4869,128.0547,276.7301);
	lesnik[1] = CreatePickup(1239,2,2355.4419,-657.4797,128.0547,0);
	
	ammo[0] = CreatePickup(1318,23,1368.9189,-1279.8000,13.5469,0);
	ammo[1] = CreatePickup(1318,23,285.4039,-41.7438,1001.5156,1);
	ammo[2] = CreatePickup(1239,2,296.1549,-38.5151,1001.5156,1);
	ammo[3] = CreateActor(25, 296.3550,-40.2886,1001.5156,358.1000);
	SetActorVirtualWorld(ammo[3], 1);
	
	lesnikcar[0] = AddStaticVehicle(422,2351.6956,-653.6010,128.0469,178.4496,222,6);
	lesnikcar[1] = AddStaticVehicle(422,2342.5264,-652.1407,128.5863,0.5565,227,226);
	return true;
}
public OnGameModeExit()
{
	return true;
}
public OnPlayerRequestClass(playerid, classid)
{
    SetSpawnInfo(playerid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); 
	TogglePlayerSpectating(playerid, true); 
	TogglePlayerSpectating(playerid, 0);
	SetPlayerCameraPos(playerid, -2625.480712, 2251.552246, 12.997936); 
	SetPlayerCameraLookAt(playerid, -2620.974853, 2249.394042, 12.796076);
	return false;
}
public OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, player_name[playerid], MAX_PLAYER_NAME+1);
	static
	    fmt_str[] = "SELECT `ID` FROM `accounts` WHERE `Name` = '%s'";
	new
		string[sizeof(fmt_str)+MAX_PLAYER_NAME-1];
	mysql_format(connect_mysql, string, sizeof(string), fmt_str, GN(playerid));
	mysql_function_query(connect_mysql, string, true, "@_OnPlayerCheck", "d", playerid);
	Clear(playerid);
	PlayerTextDraws(playerid);
	SetPlayerMapIcon(playerid,0,-77.7740,90.1817,3.1172,52,0);
	return true;
}
public OnPlayerDisconnect(playerid, reason)
{
	if(login_check{playerid} == true)
	{
		SavePlayerAll(playerid);
	}
	KillTimers(playerid);
	return true;
}
public OnPlayerSpawn(playerid)
{
	if(login_check{playerid} == true)
	{
	    SetPlayerSpawn(playerid);
	}
	return true;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	return true;
}
public OnVehicleSpawn(vehicleid)
{
	return true;
}
public OnVehicleDeath(vehicleid, killerid)
{
	return true;
}
public OnPlayerText(playerid, text[])
{
	if(login_check{playerid} == false)
	{
	    SCM(playerid, COLOR_GREY, !"�� �� ��������������");
	    return false;
	}
	return false;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	return false;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		if(vehicleid == sadler[0])
		{
			if(player[playerid][pprava] == 1)
	        {
			    if(GetPVarInt(playerid, "sadler") != 1)
			    {
			        SPD(playerid, 29, DSM, "������ ����������", "{FFFFFF}�� ������ ���������� ��� ������������ ��������?\n\n{008000}������: Sadler\n\n���������: 30 ��������", "��", "���");
			    }
			    else
			    {
       				if(GetPVarInt(playerid, "Melnik") == 1)
			        {
			            SetPlayerCheckpoint(playerid, 2156.2085,-119.7273,1.3841, 5.0);
			        }
			        if(GetPVarInt(playerid, "Melnik") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Water") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, -14.6160,-272.3340,5.4297, 5.0);
					}
					if(GetPVarInt(playerid, "Water") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, 2216.6099,-2286.3069,14.7647, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
				}
			}
	        else
	        {
	             SendClientMessage(playerid, COLOR_GREY, "� ��� ��� ������������� �������������");
	             RemovePlayerFromVehicle(playerid);
	        }
		}
		if(vehicleid == sadler[1])
		{
			if(player[playerid][pprava] == 1)
	        {
			    if(GetPVarInt(playerid, "sadler") != 2)
			    {
			        SPD(playerid, 33, DSM, "������ ����������", "{FFFFFF}�� ������ ���������� ��� ������������ ��������?\n\n{008000}������: Sadler\n\n���������: 30 ��������", "��", "���");
			    }
			    else
			    {
       				if(GetPVarInt(playerid, "Melnik") == 1)
			        {
			            SetPlayerCheckpoint(playerid, 2156.2085,-119.7273,1.3841, 5.0);
			        }
			        if(GetPVarInt(playerid, "Melnik") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Water") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, -14.6160,-272.3340,5.4297, 5.0);
					}
					if(GetPVarInt(playerid, "Water") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, 2216.6099,-2286.3069,14.7647, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
				}
			}
	        else
	        {
	             SendClientMessage(playerid, COLOR_GREY, "� ��� ��� ������������� �������������");
	             RemovePlayerFromVehicle(playerid);
	        }
		}
		if(vehicleid == sadler[2])
		{
			if(player[playerid][pprava] == 1)
	        {
			    if(GetPVarInt(playerid, "sadler") != 3)
			    {
			        SPD(playerid, 34, DSM, "������ ����������", "{FFFFFF}�� ������ ���������� ��� ������������ ��������?\n\n{008000}������: Sadler\n\n���������: 30 ��������", "��", "���");
			    }
			    else
			    {
       				if(GetPVarInt(playerid, "Melnik") == 1)
			        {
			            SetPlayerCheckpoint(playerid, 2156.2085,-119.7273,1.3841, 5.0);
			        }
			        if(GetPVarInt(playerid, "Melnik") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Water") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, -14.6160,-272.3340,5.4297, 5.0);
					}
					if(GetPVarInt(playerid, "Water") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, 2216.6099,-2286.3069,14.7647, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
				}
			}
	        else
	        {
	             SendClientMessage(playerid, COLOR_GREY, "� ��� ��� ������������� �������������");
	             RemovePlayerFromVehicle(playerid);
	        }
		}
		if(vehicleid == sadler[3])
		{
			if(player[playerid][pprava] == 1)
	        {
			    if(GetPVarInt(playerid, "sadler") != 4)
			    {
			        SPD(playerid, 35, DSM, "������ ����������", "{FFFFFF}�� ������ ���������� ��� ������������ ��������?\n\n{008000}������: Sadler\n\n���������: 30 ��������", "��", "���");
			    }
			    else
			    {
       				if(GetPVarInt(playerid, "Melnik") == 1)
			        {
			            SetPlayerCheckpoint(playerid, 2156.2085,-119.7273,1.3841, 5.0);
			        }
			        if(GetPVarInt(playerid, "Melnik") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Water") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, -14.6160,-272.3340,5.4297, 5.0);
					}
					if(GetPVarInt(playerid, "Water") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, 2216.6099,-2286.3069,14.7647, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
				}
			}
	        else
	        {
	             SendClientMessage(playerid, COLOR_GREY, "� ��� ��� ������������� �������������");
	             RemovePlayerFromVehicle(playerid);
	        }
		}
		if(vehicleid == sadler[4])
		{
			if(player[playerid][pprava] == 1)
	        {
			    if(GetPVarInt(playerid, "sadler") != 5)
			    {
			        SPD(playerid, 36, DSM, "������ ����������", "{FFFFFF}�� ������ ���������� ��� ������������ ��������?\n\n{008000}������: Sadler\n\n���������: 30 ��������", "��", "���");
			    }
			    else
			    {
       				if(GetPVarInt(playerid, "Melnik") == 1)
			        {
			            SetPlayerCheckpoint(playerid, 2156.2085,-119.7273,1.3841, 5.0);
			        }
			        if(GetPVarInt(playerid, "Melnik") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Water") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, -14.6160,-272.3340,5.4297, 5.0);
					}
					if(GetPVarInt(playerid, "Water") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, 2216.6099,-2286.3069,14.7647, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
				}
			}
	        else
	        {
	             SendClientMessage(playerid, COLOR_GREY, "� ��� ��� ������������� �������������");
	             RemovePlayerFromVehicle(playerid);
	        }
		}
		if(vehicleid == sadler[5])
		{
			if(player[playerid][pprava] == 1)
	        {
			    if(GetPVarInt(playerid, "sadler") != 6)
			    {
			        SPD(playerid, 37, DSM, "������ ����������", "{FFFFFF}�� ������ ���������� ��� ������������ ��������?\n\n{008000}������: Sadler\n\n���������: 30 ��������", "��", "���");
			    }
			    else
			    {
       				if(GetPVarInt(playerid, "Melnik") == 1)
			        {
			            SetPlayerCheckpoint(playerid, 2156.2085,-119.7273,1.3841, 5.0);
			        }
			        if(GetPVarInt(playerid, "Melnik") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Water") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, -14.6160,-272.3340,5.4297, 5.0);
					}
					if(GetPVarInt(playerid, "Water") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 1)
			        {
			        	SetPlayerCheckpoint(playerid, 2216.6099,-2286.3069,14.7647, 10.0);
					}
					if(GetPVarInt(playerid, "Corn") == 2)
			        {
			        	SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 10.0);
					}
				}
			}
	        else
	        {
	             SendClientMessage(playerid, COLOR_GREY, "� ��� ��� ������������� �������������");
	             RemovePlayerFromVehicle(playerid);
	        }
		}
		if(vehicleid >= qtractor[0] && vehicleid <= qtractor[3])
		{
			if(GetPVarInt(playerid, "ntractor") != 0)
		    {
		        if(GetPVarInt(playerid, "ntractor") == 1)
		        {
			        SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�� ������� ���� � �������");
			        SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 5.0);
			        SetPVarInt(playerid, "ntractor", 2);
				}
				if(GetPVarInt(playerid, "ntractor") == 2)
			    {
			        SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 5.0);
			    }
		    }
		}
	}
	return true;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(vehicleid >= sadler[0] && vehicleid <= sadler[5])
    {
    	DisablePlayerCheckpoint(playerid);
	}
	if(vehicleid >= qtractor[0] && vehicleid <= qtractor[3])
    {
    	DisablePlayerCheckpoint(playerid);
	}
	if(vehicleid == sabre)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(vehicleid == bobcat)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(vehicleid == rumpo)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(vehicleid >= ftractor[0] && vehicleid <= ftractor[4])
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(vehicleid >= lesnikcar[0] && vehicleid <= lesnikcar[1])
	{
		if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 4)
	    {
	        DisablePlayerCheckpoint(playerid);
	    }
	}
	return true;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new carid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    if(EngineState[carid] == false)
	    {
	        SCM(playerid, COLOR_GREEN, "����� ������� ������������ ��������, ������� �� ������� {FFFFFF}'2'");
	    }
	}
	if(carid >= lesnikcar[0] && carid <= lesnikcar[1])
	{
	    if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 4)
	    {
	        SetPVarInt(playerid, "hunthelp", 1);
	        SetPlayerCheckpoint(playerid, 939.5695,-1086.7515,24.2962, 3.0);
	        SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}�������� ���� �� ��������");
	    }
	    else
	    {
	        RemovePlayerFromVehicle(playerid);
	    }
	}
	if(carid >= qtractor[0] && carid <= qtractor[3])
	{
	    if(GetPVarInt(playerid, "ntractor") != 0)
	    {
	        if(GetPVarInt(playerid, "ntractor") == 1)
	        {
		        SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�� ������� ���� � �������");
		        SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 5.0);
		        SetPVarInt(playerid, "ntractor", 2);
			}
			if(GetPVarInt(playerid, "ntractor") == 2)
		    {
		        SetPlayerCheckpoint(playerid, -77.7740,90.1817,3.1172, 5.0);
		    }
	    }
	    else
	    {
	        RemovePlayerFromVehicle(playerid);
	    }
	}
	if(carid >= tractor[0] && carid <= tractor[3])
	{
		if(farmquest[playerid] != 0)
		{
	        SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}���������� �� �������� �� ���������� � ������� ����");
	        SetPlayerRaceCheckpoint(playerid, 0, -124.7671,58.9227,3.0826, -142.4556,16.2783,3.0863, 5.0);
	        pfarm[playerid] = CHECKPOINT_1;
		}
	}
	if(carid == sabre)
	{
		if(GetPVarInt(playerid, "sabre") != 0)
		{
		    if(GetPVarInt(playerid, "sabre") == 1)
			{
				SetPVarInt(playerid, "sabre", 2);
				SetPlayerCheckpoint(playerid, 238.5528,-44.8661,1.3060, 3.0);
				SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�������� ���������� �� �������� ����� ������������ ��������");
			}
		}
		else
		{
		    RemovePlayerFromVehicle(playerid);
		}
	}
	if(carid == bobcat)
	{
		if(GetPVarInt(playerid, "sabre") != 0)
		{
		    if(GetPVarInt(playerid, "sabre") == 1)
			{
				SetPVarInt(playerid, "sabre", 2);
				SetPlayerCheckpoint(playerid, 238.5528,-44.8661,1.3060, 3.0);
				SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�������� ���������� �� �������� ����� ������������ ��������");
			}
		}
		else
		{
		    RemovePlayerFromVehicle(playerid);
		}
	}
	if(carid == rumpo)
	{
		if(GetPVarInt(playerid, "sabre") != 0)
		{
		    if(GetPVarInt(playerid, "sabre") == 1)
			{
				SetPVarInt(playerid, "sabre", 2);
				SetPlayerCheckpoint(playerid, 238.5528,-44.8661,1.3060, 3.0);
				SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�������� ���������� �� �������� ����� ������������ ��������");
			}
		}
		else
		{
		    RemovePlayerFromVehicle(playerid);
		}
	}
	if(carid >= ftractor[0] && carid <= ftractor[4])
	{
	    if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 13)
	    {
	        SetPlayerCheckpoint(playerid, -62.2798,44.7885,3.1103, 3.0);
	        SetPVarInt(playerid, "ftractor", 1);
	    }
	    else
	    {
	        RemovePlayerFromVehicle(playerid);
	    }
	}
	return true;
}
public OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid, "hunthelp") == 1)
	{
	    DeletePVar(playerid, "hunthelp");
	    DisablePlayerCheckpoint(playerid);
	    SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�����������! �� ������ ��� ������ �� �������");
		player[playerid][pquest] = 0;
		player[playerid][pquestpoint] = 0;
		player[playerid][pgold] += 10;
		player[playerid][pexp] += 1;
		SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins � 1 exp");
		Lvlup(playerid);
		RemovePlayerFromVehicle(playerid);
	}
	if(GetPVarInt(playerid, "eva") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "eva");
	    player[playerid][pquest] = 0;
	    player[playerid][pquestpoint] = 0;
	    player[playerid][ppquest] = 0;
	    player[playerid][psquest] = 1;
	    player[playerid][pgold] += 10;
	    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}��������� ��������� ������� ��������! �������: 10 gold coins");
	    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}������ ��� �������� ������, ������ � ���������� (( /gps - ������� ))");
        SCM(playerid, COLOR_ASTRONOMY, !"[����������] {FFFFFF}������������ ����� ��������� 1 �����, 1 ������ � 1 ����������");
	}
    if(GetPVarInt(playerid, "ftractor") == 1)
    {
        player[playerid][pquestpoint] = 14;
        player[playerid][pcash] += 1000;
        SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}�� ������ ������� �� �����");
        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}������ ��� �������� ������� �� ���. �������� ������� �������� �� ���������.");
		DeletePVar(playerid, "ftractor");
        RemovePlayerFromVehicle(playerid);
    }
	if(GetPVarInt(playerid, "gps") == 1)
	{
	    DeletePVar(playerid, "gps");
	    DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, "Box") == 2)
	{
	    if(GetPVarInt(playerid, "BoxW") == 0)
	    {
	        SPD(playerid, 39, DSM, "�����", "�� ������ ������� ������ � ������?", "��", "���");
		}
		else
		{
		    new string[50];
			SCM(playerid, COLOR_GREEN, "[�����] {FFFFFF}�� ������� ������ �� ����� �����.");
			player[playerid][pfskill] += 1;
		    DisablePlayerCheckpoint(playerid);
		    ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
		    if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) RemovePlayerAttachedObject(playerid, 1);
			SetPlayerSpecialAction(playerid, 25);
			SetPVarInt(playerid, "BoxK", GetPVarInt(playerid, "BoxK")+1);
			DeletePVar(playerid, "BoxW");
			SetPlayerSpecialAction(playerid, 0);
			SetPVarInt(playerid, "Box", 1);
			format(string, sizeof(string), "��� ����� �������: {FFFFFF}%d/250 {FFFF00}�����", player[playerid][pfskill]);
			SCM(playerid, COLOR_YELLOW, string);
			if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 5)
			{
			    player[playerid][ppquest] += 1;
				if(player[playerid][ppquest] == 30)
				{
				    player[playerid][pquestpoint] = 6;
				    player[playerid][ppquest] = 0;
				    player[playerid][pcash] += 500;
					player[playerid][pgold] += 5;
					player[playerid][papple] += 30;
				    SCM(playerid, COLOR_ASTRONOMY, "[�����] {FFFFFF}����� �������. ��������� � �����, ����� �������� ���������.");
				    SCM(playerid, COLOR_YELLOW, "[�������] {FFFFFF}���������: 50 ��������, 30 �� �����, 5 gold coins, 1 exp");
                    SetPlayerCheckpoint(playerid, -76.2200,97.4648,3.1172, 3.0);
					SetPVarInt(playerid, "gps", 1);
					player[playerid][pexp] += 1;
				    if(player[playerid][pexp] == player[playerid][plevel]*4)
					{
					    player[playerid][pexp] = 0;
					    player[playerid][plevel] ++;
					    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
					}
				}
			}
		}
	}
	if(GetPVarInt(playerid, "Database") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	    SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}��������� � ���������� � ������� ���������� �� ���� ������");
	}
	if(GetPVarInt(playerid, "Database") == 3)
	{
	    SCM(playerid, COLOR_ASTRONOMY, !"[����]: {FFFFFF}��������! �� �����!.. �������!");
	    SCM(playerid, COLOR_LGREEN, "[�����] {FFFFFF}��������� � ����, ����� �������� ��������� �������");
	    SetPlayerCheckpoint(playerid, 195.0379,-115.4922,1.5499, 3.0);
		SetPVarInt(playerid, "gps", 1);
		DeletePVar(playerid, "Database");
		player[playerid][pcash] += 200;
		player[playerid][pexp] += 1;
		player[playerid][pquest] = 1;
		player[playerid][pquestpoint] = 2;
		if(player[playerid][pexp] == player[playerid][plevel]*4)
		{
		    player[playerid][pexp] = 0;
		    player[playerid][plevel] ++;
		    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
		ApplyActorAnimation(zero, "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
	}
	if(GetPVarInt(playerid, "zeropass") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, "zeropass") == 2)
	{
	    SCM(playerid, COLOR_ASTRONOMY, !"[�����]: {FFFFFF}������� ���������");
	    SCM(playerid, COLOR_LGREEN, "[�����] {FFFFFF}��������� � ����, ����� �������� ��������� �������");
	    SetPlayerCheckpoint(playerid, 195.0379,-115.4922,1.5499, 3.0);
		SetPVarInt(playerid, "gps", 1);
		DeletePVar(playerid, "zeropass");
		player[playerid][pcash] += 300;
		player[playerid][pexp] += 1;
		player[playerid][pquest] = 1;
		player[playerid][pquestpoint] = 3;
		if(player[playerid][pexp] == player[playerid][plevel]*4)
		{
		    player[playerid][pexp] = 0;
		    player[playerid][plevel] ++;
		    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
		ApplyActorAnimation(zero, "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
	}
	if(GetPVarInt(playerid, "zerocat") == 1)
	{
		SPD(playerid, 20, DSM, "����", "{FFFFFF}���-��, ������, �����!\n�� ����� ����� ���������� �����? ���� ���, �� ��� ���� ����� ������.\n������� ��������� ���� ������� � � ���� ���������� ������� �����.\n{008000}[�������]: {FFFFFF}��������� ��������� �����\n{4169E1}[�������]: {FFFFFF}1 exp", "�����", "������");
        DisablePlayerCheckpoint(playerid);
        DeletePVar(playerid, "zerocat");
		ApplyActorAnimation(zero, "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
	}
	if(GetPVarInt(playerid, "zeroschool") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, "Melnik") == 1)
	{
	    SPD(playerid, 38, DSM, "�������� �������", "�� ������ ��������� ����� ������� � �����?", "��", "���");
	}
	if(GetPVarInt(playerid, "Melnik") == 2)
	{
	    DeletePVar(playerid, "Melnik");
		SCM(playerid, COLOR_ASTRONOMY, "[�����] {FFFFFF}����� ��������");
		SCM(playerid, COLOR_LGREEN, !"[�������] {FFFFFF}���������: 1000 �������� � 1 exp");
		SCM(playerid, COLOR_YELLOW, "[�����] {FFFFFF}��������� � �����, ����� �������� ��������� �������");
		SetPlayerCheckpoint(playerid, -76.2200,97.4648,3.1172, 3.0);
		SetPVarInt(playerid, "gps", 1);
		player[playerid][pexp] += 1;
		player[playerid][pquestpoint] = 8;
		player[playerid][pcash] += 1000;
		if(player[playerid][pexp] == player[playerid][plevel]*4)
		{
		    player[playerid][pexp] = 0;
		    player[playerid][plevel] ++;
		    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
		ApplyActorAnimation(farmer[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
	}
	if(GetPVarInt(playerid, "Water") == 1)
	{
		SPD(playerid, 32, DSM, "������� ����", "�� ������ ������ 500 �� �������� ���� �� 500 ��������?", "��", "���");
	}
	if(GetPVarInt(playerid, "Water") == 2)
	{
		DeletePVar(playerid, "Water");
		SCM(playerid, COLOR_ASTRONOMY, !"[�����]: {FFFFFF}������� ���������");
	    SCM(playerid, COLOR_YELLOW, !"[�����] {FFFFFF}��������� � �����, ����� �������� ��������� �������");
	    SetPlayerCheckpoint(playerid, -76.2200,97.4648,3.1172, 3.0);
		SetPVarInt(playerid, "gps", 1);
		player[playerid][pexp] += 1;
		player[playerid][pquestpoint] = 9;
		player[playerid][pcash] += 1300;
		SCM(playerid, COLOR_LGREEN, !"[�������] {FFFFFF}���������: 1300 �������� � 1 exp");
		if(player[playerid][pexp] == player[playerid][plevel]*4)
		{
		    player[playerid][pexp] = 0;
		    player[playerid][plevel] ++;
		    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
	}
	if(GetPVarInt(playerid, "Corn") == 1)
	{
		SPD(playerid, 41, DSM, "������� �����", "�� ������ ������ 10 �� ����� �� 500 ��������?", "��", "���");
	}
	if(GetPVarInt(playerid, "Corn") == 2)
	{
		DeletePVar(playerid, "Corn");
		SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}������� ���������");
	    SCM(playerid, COLOR_YELLOW, !"[�����] {FFFFFF}��������� � �����, ����� �������� ��������� �������");
		SetPlayerCheckpoint(playerid, -76.2200,97.4648,3.1172, 3.0);
		SetPVarInt(playerid, "gps", 1);
		player[playerid][pexp] += 1;
		player[playerid][pquestpoint] = 10;
		player[playerid][pcash] += 1300;
		SCM(playerid, COLOR_LGREEN, !"[�������] {FFFFFF}���������: 1300 �������� � 1 exp");
		if(player[playerid][pexp] == player[playerid][plevel]*4)
		{
		    player[playerid][pexp] = 0;
		    player[playerid][plevel] ++;
		    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
	}
	if(GetPVarInt(playerid, "ntractor") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, "ntractor") == 2)
	{
	    RemovePlayerFromVehicle(playerid);
	    DeletePVar(playerid, "ntractor");
		SCM(playerid, COLOR_ASTRONOMY, "[�����] {FFFFFF}������� ���������");
	    SCM(playerid, COLOR_YELLOW, "[�����] {FFFFFF}��������� � �����, ����� �������� ��������� �������");
		SetPlayerCheckpoint(playerid, -76.2200,97.4648,3.1172, 3.0);
		SetPVarInt(playerid, "gps", 1);
		player[playerid][pexp] += 1;
		player[playerid][pquestpoint] = 11;
		player[playerid][pcash] += 1000;
		SCM(playerid, COLOR_LGREEN, !"[�������] {FFFFFF}���������: 1000 �������� � 1 exp");
		if(player[playerid][pexp] == player[playerid][plevel]*4)
		{
		    player[playerid][pexp] = 0;
		    player[playerid][plevel] ++;
		    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
	}
	if(GetPVarInt(playerid, "bgun") == 2)
	{
		DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "bgun");
	    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}������� ��������");
	    player[playerid][pquestpoint] = 2;
	    player[playerid][pexp] += 1;
	    if(player[playerid][pexp] == player[playerid][plevel]*4)
		{
		    player[playerid][pexp] = 0;
		    player[playerid][plevel] ++;
		    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
	}
	if(GetPVarInt(playerid, "sabre") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, "bobcat") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, "rumpo") == 1)
	{
	    DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, "sabre") == 2)
	{
	    RemovePlayerFromVehicle(playerid);
	    DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "sabre");
	    player[playerid][pquestpoint] = 3;
	    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}������� ��������");
	    player[playerid][pbcar] = 475;
	}
	if(GetPVarInt(playerid, "bobcat") == 2)
	{
	    RemovePlayerFromVehicle(playerid);
	    DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "bobcat");
	    player[playerid][pquestpoint] = 3;
	    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}������� ��������");
	    player[playerid][pbcar] = 422;
	}
	if(GetPVarInt(playerid, "rumpo") == 2)
	{
	    RemovePlayerFromVehicle(playerid);
	    DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "rumpo");
	    player[playerid][pquestpoint] = 3;
	    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}������� ��������");
	    player[playerid][pbcar] = 440;
	}
	if(GetPVarInt(playerid, "zerohack") == 1)
	{
	    SCM(playerid, COLOR_GREEN, !"[����] {FFFFFF}���-��, ��������, ��� ����� ��?! ���� �������, �� � ���������� ������.");
		DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "zerohack");
	    player[playerid][pquestpoint] = 4;
	    SCM(playerid, COLOR_GOLD, !"[SMS]: � ��� �� ������! �����������: Catalina.");
	    player[playerid][pbhacker] = 1;
	}
	if(GetPVarInt(playerid, "pagehack") == 1)
	{
	    SCM(playerid, COLOR_GREEN, !"[��������] {FFFFFF}[����������� �������]: �� � �������� ������ � ���� � ������ ���������. ������ ���� �� �����������.");
		DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "pagehack");
	    player[playerid][pquestpoint] = 4;
	    SCM(playerid, COLOR_GOLD, !"[SMS]: � ��� �� ������! �����������: Catalina.");
	    ApplyActorAnimation(mad, "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
	    player[playerid][pbhacker] = 2;
	}
	if(GetPVarInt(playerid, "Fact") == 2)
	{
	    DisablePlayerCheckpoint(playerid);
	    SetPlayerSpecialAction(playerid, 0);
	    ApplyAnimation(playerid, "OTB", "BETSLP_LOOP", 4.1, 1, 0, 0, 0, 0);
	    ApplyAnimation(playerid, "OTB", "BETSLP_LOOP", 4.1, 1, 0, 0, 0, 0);
	    SetPlayerAttachedObject(playerid, 2, 6, 18644);
	    SetPlayerAttachedObject(playerid, 1, 18635, 5, 0.036999, 0.071999, 0.000000, 155.000000, 0.000000, 0.000000, 1.000000, 1.00, 1.000000);
		SetTimerEx("@_UnivPub", 20000, false, "i", playerid);
	}
	if(GetPVarInt(playerid, "Fact") == 3)
	{
	    SetPVarInt(playerid, "Fact", 1);
	    SCM(playerid, COLOR_BLUE, !"[�����] {FFFFFF}�� ������� ������� ������ �� �����");
	    if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) RemovePlayerAttachedObject(playerid, 1);
	    new string[64];
		player[playerid][pfactskill] += 1;
	    DisablePlayerCheckpoint(playerid);
	    ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
		SetPlayerSpecialAction(playerid, 25);
		SetPVarInt(playerid, "FactK", GetPVarInt(playerid, "FactK")+1);
		SetPlayerSpecialAction(playerid, 0);
		format(string, sizeof(string), "��� ����� ������ �� ������: {FFFFFF}%d/250 {008000}�����", player[playerid][pfactskill]);
		SCM(playerid, COLOR_GREEN, string);
		if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 12)
		{
		    player[playerid][ppquest] += 1;
			if(player[playerid][ppquest] == 20)
			{
			    player[playerid][pmetall] += 50;
			    player[playerid][pquestpoint] = 13;
			    player[playerid][ppquest] = 0;
			    player[playerid][pcash] += 1500;
				player[playerid][pgold] += 5;
			    SCM(playerid, COLOR_ASTRONOMY, "[�����] {FFFFFF}����� �������. ��������� � �����, ����� �������� ���������.");
			    SCM(playerid, COLOR_LGREEN, "[�������] {FFFFFF}���������: 1500 �������� + 5 gold coins + 1 ex + 50 �������");
			    SetPlayerCheckpoint(playerid, -106.1318,-311.0517,1.4297, 3.0);
				SetPVarInt(playerid, "gps", 1);
			    player[playerid][pexp] += 1;
			    if(player[playerid][pexp] == player[playerid][plevel]*4)
				{
				    player[playerid][pexp] = 0;
				    player[playerid][plevel] ++;
				    SCM(playerid, COLOR_LGREEN, !"�����������! ��� ������� ������� �������");
				}
			}
		}
	}
	if(GetPVarInt(playerid, "hlic") == 1)
	{
	    DeletePVar(playerid, "hlic");
	    DisablePlayerCheckpoint(playerid);
	    player[playerid][pquestpoint] = 2;
	    SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}������� ��������");
	    SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins + 1 exp");
	}
	return true;
}
public OnPlayerLeaveCheckpoint(playerid)
{
	return true;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
	switch(pfarm[playerid])
	{
	    case CHECKPOINT_1:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -142.4556,16.2783,3.0863, -174.2698,-64.0075,3.0819, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 1/25");
			pfarm[playerid] = CHECKPOINT_2;
		}
		case CHECKPOINT_2:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -174.2698,-64.0075,3.0819, -196.0700,-80.7250,3.0775, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 2/25");
			pfarm[playerid] = CHECKPOINT_3;
		}
		case CHECKPOINT_3:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -174.2698,-64.0075,3.0819, -196.0700,-80.7250,3.0775, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 3/25");
			pfarm[playerid] = CHECKPOINT_4;
		}
		case CHECKPOINT_4:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -196.0700,-80.7250,3.0775, -182.7634,-40.3116,3.0832, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 4/25");
			pfarm[playerid] = CHECKPOINT_5;
		}
		case CHECKPOINT_5:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -182.7634,-40.3116,3.0832, -162.7518,13.4519,3.0833, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 5/25");
			pfarm[playerid] = CHECKPOINT_6;
		}
		case CHECKPOINT_6:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -162.7518,13.4519,3.0833, -144.6536,66.3741,3.0828, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 6/25");
			pfarm[playerid] = CHECKPOINT_7;
		}
		case CHECKPOINT_7:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -144.6536,66.3741,3.0828, -155.5487,72.4565,3.0799, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 7/25");
			pfarm[playerid] = CHECKPOINT_8;
		}
		case CHECKPOINT_8:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -155.5487,72.4565,3.0799, -176.3374,12.0112,3.0751, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 8/25");
			pfarm[playerid] = CHECKPOINT_9;
		}
		case CHECKPOINT_9:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -176.3374,12.0112,3.0751, -207.5150,-81.7095,3.0828, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 9/25");
			pfarm[playerid] = CHECKPOINT_10;
		}
		case CHECKPOINT_10:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -207.5150,-81.7095,3.0828, -219.0724,-80.5287,3.0839, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 10/25");
			pfarm[playerid] = CHECKPOINT_11;
		}
		case CHECKPOINT_11:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -219.0724,-80.5287,3.0839, -195.1409,-8.2283,3.0752, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 11/25");
			pfarm[playerid] = CHECKPOINT_12;
		}
		case CHECKPOINT_12:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -195.1409,-8.2283,3.0752, -167.2957,75.4596,3.0836, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 12/25");
			pfarm[playerid] = CHECKPOINT_13;
		}
		case CHECKPOINT_13:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -167.2957,75.4596,3.0836, -182.2013,82.5797,3.0800, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 13/25");
			pfarm[playerid] = CHECKPOINT_14;
		}
		case CHECKPOINT_14:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -182.2013,82.5797,3.0800, -203.7786,19.4469,3.0830, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 14/25");
			pfarm[playerid] = CHECKPOINT_15;
		}
		case CHECKPOINT_15:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -203.7786,19.4469,3.0830, -236.0739,-77.2600,3.0844, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 15/25");
			pfarm[playerid] = CHECKPOINT_16;
		}
		case CHECKPOINT_16:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -236.0739,-77.2600,3.0844, -247.5325,-73.3840,3.0841, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 16/25");
			pfarm[playerid] = CHECKPOINT_17;
		}
		case CHECKPOINT_17:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -247.5325,-73.3840,3.0841, -221.3031,4.6078,3.0830, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 17/25");
			pfarm[playerid] = CHECKPOINT_18;
		}
		case CHECKPOINT_18:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -221.3031,4.6078,3.0830, -194.5201,84.3286,3.0834, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 18/25");
			pfarm[playerid] = CHECKPOINT_19;
		}
		case CHECKPOINT_19:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -194.5201,84.3286,3.0834, -205.2534,91.5705,2.9313, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 19/25");
			pfarm[playerid] = CHECKPOINT_20;
		}
		case CHECKPOINT_20:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -205.2534,91.5705,2.9313, -229.0756,20.7435,3.0488, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 20/25");
			pfarm[playerid] = CHECKPOINT_21;
		}
		case CHECKPOINT_21:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -205.2534,91.5705,2.9313, -229.0756,20.7435,3.0488, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 21/25");
			pfarm[playerid] = CHECKPOINT_22;
		}
		case CHECKPOINT_22:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -229.0756,20.7435,3.0488, -258.1690,-66.7875,3.0839, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 22/25");
			pfarm[playerid] = CHECKPOINT_23;
		}
		case CHECKPOINT_23:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -258.1690,-66.7875,3.0839, -270.7608,-58.5004,3.0824, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 23/25");
			pfarm[playerid] = CHECKPOINT_24;
		}
		case CHECKPOINT_24:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -270.7608,-58.5004,3.0824, -241.4292,34.2803,2.4526, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� ������� �� 24/25");
			pfarm[playerid] = CHECKPOINT_25;
		}
		case CHECKPOINT_25:
		{
			SetPlayerRaceCheckpoint(playerid, 0, -241.4292,34.2803,2.4526,-218.4525,95.2129,2.4068, 5.0);
			SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}���� �������!");
			pfarm[playerid] = CHECKPOINT_26;
		}
		case CHECKPOINT_26:
		{
		    SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}����������� �������.");
			SetPlayerRaceCheckpoint(playerid, 0, -101.3263,29.7849,3.0766, -101.3263,29.7849,3.0766, 5.0);
			pfarm[playerid] = CHECKPOINT_27;
		}
		case CHECKPOINT_27:
		{
		    RemovePlayerFromVehicle(playerid);
			DisablePlayerRaceCheckpoint(playerid);
			farmquest[playerid] = 0;
			player[playerid][pquestpoint] = 12;
			player[playerid][pgold] += 10;
			player[playerid][papple] += 50;
			player[playerid][pcash] += 500;
			SCM(playerid, COLOR_GREEN, !"[�������] {FFFFFF}���������: 10 gold coins, 50 �� �����");
			SCM(playerid, COLOR_YELLOW, !"[SMS]: � ����� ���� ������� ��������! ���� ���� ��� ����� ����� ������, ������� �������� �� �����. ��������: Mike Farmer.");
			SCM(playerid, COLOR_ASTRONOMY, !"[�����] {FFFFFF}��� ������� �� ����� ���������! ������ ��� �������� ������� �� �����.");
			SetPVarInt(playerid, "gps", 1);
			SetPlayerCheckpoint(playerid, -106.1318,-311.0517,1.4297, 3.0);
			player[playerid][pexp] += 1;
			SCM(playerid, COLOR_LGREEN, !"[�������] {FFFFFF}���������: 500 ��������, 1 exp, 10 gold coins, 50 �� �����");
			if(player[playerid][pexp] == player[playerid][plevel]*4)
			{
			    player[playerid][pexp] = 0;
			    player[playerid][plevel] ++;
			    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
			}
		}
	}
	return true;
}
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return true;
}
public OnRconCommand(cmd[])
{
	return true;
}
public OnPlayerRequestSpawn(playerid)
{
	return false;
}
public OnObjectMoved(objectid)
{
	return true;
}
public OnPlayerObjectMoved(playerid, objectid)
{
	return true;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == Farmenter)
	{
		SetPlayerPos(playerid,307.8253,307.0400,1003.3047);
		SetPlayerFacingAngle(playerid,90.1973);
		SetPlayerInterior(playerid,4);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == Farmexit)
	{
		SetPlayerPos(playerid,-81.7285,91.6207,3.1172);
		SetPlayerFacingAngle(playerid,66.3602);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == Farmbox)
	{
		if(GetPVarInt(playerid, "Box") == 1)
		{
		    SetPVarInt(playerid, "Box", 2);
		    SetPlayerAttachedObject(playerid, 1, 19639, 1,-0.050000,0.463495,-0.024351,357.460632,87.350753,88.068374);
			ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, 0, 0, 0, 0, 0, 1);
			SetPlayerSpecialAction(playerid, 25);
			switch(random(10))
	        {
                case 0: SetPlayerCheckpoint(playerid,-119.7825,101.6909,3.1172,3.0);
                case 1: SetPlayerCheckpoint(playerid,-115.4210,109.5138,3.1172,3.0);
                case 2: SetPlayerCheckpoint(playerid,-108.7573,127.0161,3.1172,3.0);
                case 3: SetPlayerCheckpoint(playerid,-115.1143,137.9697,3.1128,3.0);
                case 4: SetPlayerCheckpoint(playerid,-121.5498,121.7618,3.1172,3.0);
                case 5: SetPlayerCheckpoint(playerid,-127.2766,104.2008,3.1172,3.0);
                case 6: SetPlayerCheckpoint(playerid,-135.9805,108.1390,3.1172,3.0);
                case 7: SetPlayerCheckpoint(playerid,-129.1041,124.2374,3.1295,3.0);
                case 8: SetPlayerCheckpoint(playerid,-123.9211,142.0882,3.3176,3.0);
                case 9: SetPlayerCheckpoint(playerid,-134.3900,137.6174,3.5413,3.0);
	        }
		}
	}
	if(pickupid == Farmclothes)
	{
	    SPD(playerid, 44, DSL, "{008000}�������� �����", "{008000}[1] {FFFFFF}�����������\n{008000}[2] {FFFFFF}���������� �� ������ ��������� �������\n{008000}[3] {FFFFFF}���������� �� ������ �����������\n{008000}[4] {FFFFFF}���������� �� ������ ����������", "�����", "������");
	}
	if(pickupid == zeropick)
	{
	    if(player[playerid][pquest] == 1 && player[playerid][psquest] == 0)
		{
		    if(player[playerid][pquestpoint] == 1)
		    {
				SPD(playerid, 8, DSM, "�������� - ����",
				"\
					{FFFFFF}���, �� ���! ������, �� �������, ��� ����� ���������?\
					\n{FFFFFF}����� �� �������� ���� � ����-����, �� ������ �� ����� �� ��������� � ������ ������� � �����.\
					\n{FFFFFF}����� � ��� ���� � �������� � �� ������� ����.\
					\n{FFFFFF}��� ��� �������� � ������, ������� ���� ����� ������� ��� �� ���� ������ �������.\
					\n{FFFFFF}���� ������, � �������� ���� ���� � ��������.\
					\n{008000}[�������]:{FFFFFF} ������� ���������� � ���� �� ���� ������\
					\n{4169E1}[�������]:{FFFFFF} 200$ � 1 exp", "�����", "������\
				");
				ApplyActorAnimation(zero, "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
			if(player[playerid][pquestpoint] == 2)
		    {
				SPD(playerid, 14, DSM, "�������� - ����",
				"\
					{FFFFFF}������ ���� ��������� ����� �������, ��� ��� �� ������� ��� � ���������. �� �����, ��� ������������ ���� - ������� ����.\
					\n{FFFFFF}������� �������� � ����� ���-������� � �������� ����� �������, ��� ���� �� �� ������� ���� �� ������ ����������.\
					\n{008000}[�������]:{FFFFFF} �������� ����� �������\
					\n{4169E1}[�������]:{FFFFFF} 300$ � 1 exp", "�����", "������\
				");
				ApplyActorAnimation(zero, "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
			if(player[playerid][pquestpoint] == 3)
		    {
				SPD(playerid, 19, DSM, "�������� - ����",
				"\
					{FFFFFF}��� �������� ���� �������� ���������� �����. �� ������� ���� ������� �������������.\
					\n{FFFFFF}����������� � ���� � ���������� ������ ������.\
					\n{008000}[�������]:{FFFFFF} ������������ � ������\
					\n{4169E1}[�������]:{FFFFFF} 1 exp", "�����", "������\
				");
				ApplyActorAnimation(zero, "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
		}
	}
	if(pickupid == basepick)
	{
	    SPD(playerid, 9, DSL, "����� ���� ������", "1. ��������� ������ �� ������� ������", "�����", "������");
	}
	if(pickupid == rcpd[0])
	{
	    if(GetPVarInt(playerid, "Database") == 1)
	    {
			SetPlayerPos(playerid,321.9299,305.7007,999.1484);
			SetPlayerFacingAngle(playerid,355.1806);
			SetPlayerInterior(playerid,5);
			SetPlayerVirtualWorld(playerid, playerid);
			SetCameraBehindPlayer(playerid);
			SetPVarInt(playerid, "Database", 2);
		}
	}
	if(pickupid == rcpd[1])
	{
		SetPlayerPos(playerid,631.2165,-571.6110,16.3359);
		SetPlayerFacingAngle(playerid,267.5455);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == mayor[0])
	{
		SetPlayerPos(playerid,386.1975,173.9187,1008.3828);
		SetPlayerFacingAngle(playerid,90.1970);
		SetPlayerInterior(playerid,3);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
		SetPVarInt(playerid, "Database", 2);
	}
	if(pickupid == mayor[1])
	{
		SetPlayerPos(playerid,1480.9487,-1767.7563,18.7958);
		SetPlayerFacingAngle(playerid,358.3895);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == mayor[2])
	{
	    if(player[playerid][pquest] == 1 && player[playerid][pquestpoint] == 2)
	    {
	    	SPD(playerid, 15, DSM, "��������� ��������", "�� ������ �������� �������?", "�����","������");
		}
	}
	if(pickupid == farmer[1])
	{
		if(player[playerid][pquestpoint] == 4)
	    {
			SPD(playerid, 21, DSM, "����",
			"\
				{FFFFFF}���, � ��� ���� ������! ������ ������ ��� �� ����� � �������� ����� ��������.\
				\n{FFFFFF}����� ������ ����� ��� �����, ����� ��������� �������, � ��� ������� ������� � ���-������.\
				\n{FFFFFF}������ ��� ������� 30 ������ �����, � � ���� ��� ���� ������, �� � �������� ����������� ����� �������.\
				\n{FFFF00}[����������]: {FFFFFF}������ ����� ������� �������� (( /gps - ������� ��������. 1 �� = 100 �������� )) \
                \n{FFFF00}[����������]: {FFFFFF}gold coins - ��� ����� ������, ������� ����� �������� �� ���������� ������� ��� /donate\
				\n{008000}[�������]:{FFFFFF} ������� 30 ������ �����\
				\n{4169E1}[�������]:{FFFFFF} 500 �������� + 30 ��������� ����� + 5 gold coins + 1 exp", "�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 5)
	    {
			SPD(playerid, 22, DSM, "����",
			"\
				{FFFFFF}���, � ��� ���� ������! ������ ������ ��� �� ����� � �������� ����� ��������.\
				\n{FFFFFF}����� ������ ����� ��� �����, ����� ��������� �������, � ��� ������� ������� � ���-������.\
				\n{FFFFFF}������ ��� ������� 30 ������ �����, � � ���� ��� ���� ������, �� � ��� ���������� ����� �������.\
				\n[����������]: ������ ����� ������� �������� (( /gps - ������� ��������. 1 �� = 100 �������� )) \
                \n[����������]: gold coins - ��� ����� ������\
				\n{008000}[�������]:{FFFFFF} ������� 30 ������ �����\
				\n{4169E1}[�������]:{FFFFFF} 500 �������� + 30 ��������� ����� + 5 gold coins + 1 exp", "�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
	    if(player[playerid][pquestpoint] == 6)
	    {
			SPD(playerid, 23, DSM, "����",
			"\
				{FFFFFF}��� ���������� ������� ���� ����������� ����� �����. ��� ������ ���� �������� ��� � � � ��� �����������.\
				\n{FFFFFF}�� ������� ����� ������� �� ����� ���������. ��������� ��������� � ������� ����������.\
				\n{008000}[�������]:{FFFFFF} ����� ������� �� ������������ �������������\
				\n{4169E1}[�������]:{FFFFFF} 1 exp", "�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 7)
	    {
			SPD(playerid, 30, DSM, "����",
			"\
				{FFFFFF}�� ���� �������� ����� ��������� �������, � ��� ���������� ��� ���������� � ����������� �����.\
				\n{FFFFFF}� ������ ������ � ��������-���� ����� ��������� ����� ����. �������, ������� �� ���, � � ����� ����� ���� � ����� �� ��������.\
				\n{FFFFFF}������, ������� ��� ����� ���� �� ������� �� �����, ������� �������� ������.\
				\n{008000}[�������]:{FFFFFF} �������� ����� ����� ������� ��� ��������\
				\n{4169E1}[�������]:{FFFFFF} 1000 �������� � 1 exp", "�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 8)
	    {
			SPD(playerid, 31, DSM, "����",
			"\
				{FFFFFF}�� ����� ��������� ��� ������ ����, ���� �� ������� �������� ���� �� �������� �������� ����.\
				\n{FFFFFF}�� ���������� ����� ������� ������������ ����, ������ � ���. ���� ���������� ����.\
				\n{FFFFFF}��� ������ ����� ���� ����� ����� �����. ������ ������� �� ������ ���� ���������� �����.\
				\n{008000}[�������]:{FFFFFF} �������� 500 �� �������� ����\
				\n{4169E1}[�������]:{FFFFFF} 1300 �������� � 1 exp", "�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 9)
	    {
			SPD(playerid, 40, DSM, "����",
			"\
				{FFFFFF}����� ������ ������ ��� ����� �������� ������� �����. ��� ����� ���� ������ �����.\
				\n{FFFFFF}� ����� ���-������� ����� ����� ������ ��������� 10 �����. ����������� ���� � ��������.\
				\n{FFFFFF}��� ������ ����� ���� ����� ����� �����. ������ ������� �� ������ ���� ���������� �����.\
				\n{008000}[�������]:{FFFFFF} �������� 10 �� ����� � ����� ���-�������\
				\n{4169E1}[�������]:{FFFFFF} 1300 �������� � 1 exp", "�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 10)
	    {
			SPD(playerid, 42, DSM, "����",
			"\
				{FFFFFF}��� ���������� ����� ����� ����� �������. � ������� ����� �� �������-����, �� ��������� � �� ��������.\
				\n{FFFFFF}������ ��� ���� ������� � ������� ��� ����.\
				\n{008000}[�������]:{FFFFFF} �������� ����� ������� �� �����\
				\n{4169E1}[�������]:{FFFFFF} 1000 �������� � 1 exp", "�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 11)
	    {
			SPD(playerid, 43, DSM, "����",
			"\
				{FFFFFF}���� ��������� ����� ������. ������ ������ ������� � ����� ����.\
				\n{FFFFFF}����� ����� ��� ��� ������� ��� ���� ����������.\
				\n{FFFFFF}������� ������� ���� �� ������ �� �����! �� ��� ����� ���������� ����� ������� �� �������� ����� ����� �����������.\
				\n{008000}[�������]:{FFFFFF} ������� ����\
				\n{4169E1}[�������]:{FFFFFF} 500 �������� + 1 exp + 10 gold coins + 50 �� �����","�����", "������\
			");
			ApplyActorAnimation(farmer[1], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
	}
	if(pickupid == autoschool[0])
	{
		SetPlayerPos(playerid,-2029.7418,-108.5319,1035.1719);
		SetPlayerFacingAngle(playerid,179.5449);
		SetPlayerInterior(playerid,3);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == autoschool[1])
	{
		SetPlayerPos(playerid,1369.4928,406.4674,19.7325);
		SetPlayerFacingAngle(playerid,64.5271);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == autoschool[2])
	{
		if(GetPVarInt(playerid, "zeroschool") == 1)
		{
	    	SPD(playerid, 24, DSM, "�������", "�� ������ ��������� ����� ������ �� ��������?", "��", "���");
		}
		else
		{
		    SPD(playerid, 69, DSL, "{4169E1}���������", "{4169E1}[1] {FFFFFF}������ �������� �� ���� - 1000 $\n{4169E1}[2] {FFFFFF}������ �������� �� ���� - 2000 $\n{4169E1}[3] {FFFFFF}������ �������� �� ������ - 30000 $\n{4169E1}[4] {FFFFFF}������ �������� �� ����� - 10000 $\n{4169E1}[5] {FFFFFF}������ �������� �� ������� - 5000 $","������","������");
		}
	}
	if(pickupid == catalina[1])
	{
	    if(player[playerid][psquest] == 1)
	    {
	        if(player[playerid][pcatalina] == 0)
	        {
	            if(player[playerid][pquest] == 0 && player[playerid][pquestpoint] == 0)
	            {
					SPD(playerid, 45, DSM, "��������",
					"\
						{FFFFFF}���� �� ������ �� ��� - ��������, �� ������ ���������� � �����������?\
						\n{FFFFFF}������ ���� � ��� �� ������� - ���������� ������������ �������� � ������� Blueberry.\
						\n{FFFFFF}��� ���������� ��������� �������������. � ��� �� ������ �������� �����, ��� �� ����� ���� �����.\
						\n{FFD700}[����������]:{FFFFFF} ��� ������ ������� �� �������� �� ������ �������� ����� � ������� 15 gold coins\
						\n{FFD700}[����������]:{FFFFFF} �� ����������� ��������� ������� ������� �� �������� ��� ��� 15 gold coins\
						\n{FFD700}[����������]:{FFFFFF} ��� �� gold coins �� ������� �������� ��� ����������� ������� (( /gps - ������ )) ���� ����� (( /donate ))","��������", "������\
					");
				}
				if(player[playerid][pquest] == 2)
	            {
					SPD(playerid, 46, DSL, "��������", "{FFFFFF}1. ���������� ����������� {008000}[��������]\n{FFFFFF}2. ���������� ��� ������ {008000}[��������]\n{FFFFFF}3. ����� {008000}[��������]", "�����", "������");
				}
			}
		}
	}
	if(pickupid == starterpack)
	{
	    if(player[playerid][pstart] == 0)
	    {
	        SPD(playerid, 52, DSM, "{008000}��������� �����", "{FFFFFF}��������� ����� ��� �������� �������� � ����:\n{008000}[1] {FFFFFF}20 ����� ������� {008000}[����������] {FFFFFF}������ - ��� �������, ��������� �����. ��� ������������� ������� (( /sprunk )). ����� ���������� �����, ������� (( /satiety ))\n{008000}[2] {FFFFFF}10 ������� ����� {008000}[����������] {FFFFFF}����� �������� �������. ����� ������������, ������� (( /eat )). ����� ���������� �������, ������� (( /satiety ))\n{008000}[3] {FFFFFF}10 �� ����� {008000}[����������] {FFFFFF}������ ����� ������� �������� ������� (( /gps - ������� ������� )))\n{008000}[4] {FFFF00}5 gold coins {008000}[����������] {FFFFFF}gold coins - ��� ����� ������ (( /donate )). ����� ��� ������ ��� ���������� �������. ����� ��� ����������� ����������", "��������", "������");
	    }
	    else
	    {
	        SCM(playerid, COLOR_LGREEN, !"[����������] {FFFFFF}�� ��� ����� ��������� �����");
	    }
	}
	if(pickupid == agun)
	{
	    if(GetPVarInt(playerid, "bgun") == 1)
		{
		    SetPlayerCheckpoint(playerid, 877.0898,-31.2817,63.1953, 3.0);
		    SetPVarInt(playerid, "bgun", 2);
		    SCM(playerid, COLOR_YELLOW, !"[����������] {FFFFFF}���������� ���������� � ���������� ������� ����, ����� ��� �� ��������");
		    SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�������� ���� � ���� ��������");
		}
	}
	if(pickupid == factory[1])
	{
	    SPD(playerid, 53, DSL, "{4169E1}�����", "{4169E1}[1] {FFFFFF}�����������\n{4169E1}[2] {FFFFFF}���������� �� ������ ���������� �������\n{4169E1}[3] {FFFFFF}���������� �� ������ �������������� ��������\n{008000}[4] {FFFFFF}���������� �� ������ ������������ ��������", "�����", "������");
	}
	if(pickupid == factory[2] || pickupid == factory[3] || pickupid == factory[4] || pickupid == factory[5] || pickupid == factory[6] || pickupid == factory[7])
	{
		if(GetPVarInt(playerid, "Fact") == 1)
		{
		    SetPVarInt(playerid, "Fact", 2);
			SCM(playerid, COLOR_BLUE, !"�� ����� ���������. �������� �� ��� ������");
			switch(random(6))
	        {
                case 0: SetPlayerCheckpoint(playerid,2558.6047,-1291.0056,1044.1250,1.0);
                case 1: SetPlayerCheckpoint(playerid,2553.9358,-1291.0052,1044.1250,1.0);
                case 2: SetPlayerCheckpoint(playerid,2541.9514,-1291.0038,1044.1250,1.0);
                case 3: SetPlayerCheckpoint(playerid,2541.9985,-1295.8514,1044.1250,1.0);
                case 4: SetPlayerCheckpoint(playerid,2553.8188,-1295.8499,1044.1250,1.0);
                case 5: SetPlayerCheckpoint(playerid,2558.6665,-1295.8506,1044.1250,1.0);
	        }
		}
		else
		{
		    SCM(playerid, COLOR_BLUE, !"[����������] {FFFFFF}�� ��� ����� ���������");
		}
	}
	if(pickupid == factory[8])
	{
		SetPlayerPos(playerid,2568.0764,-1297.9017,1044.1250);
		SetPlayerFacingAngle(playerid,358.0999);
		SetPlayerInterior(playerid,2);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == factory[9])
	{
		SetPlayerPos(playerid,-92.8675,-300.6735,2.3326);
		SetPlayerFacingAngle(playerid,91.1607);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == factory[10])
	{
	    if(player[playerid][pquestpoint] == 12)
	    {
			SPD(playerid, 55, DSM, "�����",
			"\
				{FFFFFF}������� �������������, � ������������� ����� ����������� ������ - �����. ���� ������, ������� ������ ����������.\
				\n{FFFFFF}�� ������ ������ ������� ��� ������� � ����� - ������, ����������, ���������� ���������.\
				\n{FFFFFF}��� ����� ���������� ������� �������, �� ��� �� ������� ���������. ������ 20 ������� � �������� ������.\
                \n{FFFF00}[����������]:{FFFFFF} ������ ����� ������� �������� (( /gps - ������� ))\
				\n{008000}[�������]:{FFFFFF} ������� 20 �������\
				\n{4169E1}[�������]:{FFFFFF} 1500 �������� + 50 ������������� ������� + 1 exp + 5 gold coins", "�����", "������\
			");
			ApplyActorAnimation(factory[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 13)
	    {
			SPD(playerid, 56, DSM, "�����",
			"\
				{FFFFFF}������ ���� ��������� �������� ������, ������� ����� ������� �� ������������� �����. �� � ���� ��� �� ������� ������� ����.\
				\n{FFFFFF}�� � ������ ��������� ������ ��� ������� ���������� ���������. ������ ��� ������� ������� �� �����.\
				\n{008000}[�������]:{FFFFFF} ������� ������� �� �����\
				\n{4169E1}[�������]:{FFFFFF} 1000 �������� + 1 exp", "�����", "������\
			");
			ApplyActorAnimation(factory[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
	}
	if(pickupid == eva[1])
	{
	    if(player[playerid][pquestpoint] == 14)
	    {
			SPD(playerid, 57, DSM, "���",
			"\
				{FFFFFF}��, � �������, ��� ���� ��������� �� �������? ������ �� � ����� ��� ��������. � ���� ������ ������ �����������.\
				\n{FFFFFF}� Blueberry ����� ������� 24/7 � ���������� ������.\
				\n{FFFFFF}������ ��� ��� ����� ������� � ���� ������� ���. �� � ���� ��� ���� �������.\
				\n{008000}[�������]:{FFFFFF} ������ ��� ����� ������� � ������� � 24/7 � Blueberry\
				\n{4169E1}[�������]:{FFFFFF} 1 gold coin + 1 exp", "�����", "������\
			");
			ApplyActorAnimation(eva[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 15)
	    {
			SPD(playerid, 64, DSM, "���",
			"\
				{FFFFFF}�����, �� � ���� �� �������� ����� ��������! ��� ��� ������? �� ����� �������.\
				\n{FFFFFF}������ �� ��������� ����� ��������� ����� - ������� ������� � ������ ��������.\
				\n{FFFFFF}������ ��� ��, ��� � ���� ����. �� ���� ������ �������� ��������.\
				\n{008000}[�������]:{FFFFFF} ������� ������� ������\
				\n{4169E1}[�������]:{FFFFFF} 5 gold coin + 1 exp", "�����", "������\
			");
			ApplyActorAnimation(eva[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
		if(player[playerid][pquestpoint] == 16)
	    {
			SPD(playerid, 65, DSM, "���",
			"\
				{FFFFFF}��� ������� �������� � �������� ������, ������, ��� ������ ���.\
				\n{FFFFFF}� � ��� ������������ � ��� ������� ��������� ���� ���� ���� ���������� ���������.\
				\n{FFFFFF}������ ���, � ����� ������� � ����� ������ ������.\
				\n{008000}[�������]:{FFFFFF} �������� ���������\
				\n{4169E1}[�������]:{FFFFFF} ���������� ���������� ���������", "�����", "������\
			");
			ApplyActorAnimation(eva[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
		}
	}
	if(pickupid == shop24[0])
	{
	    SetPlayerPos(playerid,-25.5625,-185.3812,1003.5469);
		SetPlayerFacingAngle(playerid,354.3159);
		SetPlayerInterior(playerid,17);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == shop24[1])
	{
	    SetPlayerPos(playerid,174.5394,-202.9774,1.5703);
		SetPlayerFacingAngle(playerid,226.2084);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == shop24[2])
	{
	    SPD(playerid, 58, DSL, "������� 24/7", "{FF0000}1. {FFFFFF}���\n{FF0000}2. {FFFFFF}�������\n{FF0000}3. {FFFFFF}��������\n{FF0000}4. {FFFFFF}�������", "�����", "������");
	}
	if(pickupid == aaron[1])
	{
	    SPD(playerid, 63, DSL, !"�����", "{008000}[1] {FFFFFF}������� ��� ������ ( 1�� = 100 �������� )\n{008000}[2] {FFFFFF}������� ���� ������ ( 1 ������ = 100 �������� )\n{008000}[3] {FFFFFF}������� ��� ����� ( 1 ����� = 500 �������� )\n(008000}[4] {FFFFFF}������� ���� ����� ( 50 �� = 1000 �������� )", "�������", "������");
	}
	if(pickupid == victim[0])
	{
	    SetPlayerPos(playerid,223.0537,-8.2871,1002.2109);
		SetPlayerFacingAngle(playerid,91.2070);
		SetPlayerInterior(playerid,5);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == victim[1])
	{
	    SetPlayerPos(playerid,457.2283,-1501.4272,31.0387);
		SetPlayerFacingAngle(playerid,98.0773);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == victim[2])
	{
	    if(player[playerid][pquestpoint] == 16)
	    {
			SPD(playerid, 66, DSL, "���������� ����������", "{FF0000}1. {FFFFFF}����� ����\n{FF0000}2. {FFFFFF}������� ������\n{FF0000}3. {FFFFFF}׸���� ������\n{FF0000}4. {FFFFFF}����� ������", "��������", "������");
		}
	}
	if(pickupid == lesnik[1])
	{
	    if(player[playerid][psquest] == 1)
	    {
			if(player[playerid][pquest] != 2)
			{
			    SPD(playerid, 68, DSM, "{008000}������", "{FFFFFF}����� ���������� � ��� ������ �������, ��������! ����� �� ��� �������� �����-�� �������� ������.\n����� ��� ������ ������� ������������, �� � � ������� ��� ������!\n�� �� �����, ���-�� � �����������. ����� - �������� �������, ������� ����� �������� �������� ������.\n����� ������ ���������, ���� ����� ������ �������� �� ������ � �� �����.\n�������� �� ��������� � ��������� ��������!\n\n{008000}[�������]: {FFFFFF}������ �������� �� ������ � �����\n{4169E1}[�������]: {FFFFFF}10 gold coins � 1 exp", "�����", "������");
                ApplyActorAnimation(lesnik[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
			if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 2)
			{
			    SPD(playerid, 71, DSM, "{008000}������",
				"\
					{FFFFFF}��������� �� ������ ����������� ���� � �����, ��� ������������.\
					\n{FFFFFF}����� � ������� ������ � ������ ���-������� � ���� ����� Country Rifle.\
					\n\n{FFFFFF}��-��-��! �������� ��� ���� �������. ��� ����� ���� ��� ����� �� ����� � ������ �� �����.\
					\n{FFFFFF}� ����� ��������� �� ������ � ������������ ���� �����! ������, ������ ��� �� ���������.\
					\n\n{008000}[�������]:{FFFFFF} Country Rifle\
					\n{4169E1}[�������]:{FFFFFF} 10 gold coins + 1 exp", "�����", "������\
				");
				ApplyActorAnimation(lesnik[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
			if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 3)
			{
			    SPD(playerid, 72, DSM, "{008000}������",
				"\
					{FFFFFF}���� ���������� � ����� �����. � ���� ���� ����� �����. �������� ����������� 4 �����.\
					\n{FFFFFF}������ �� ����������� � ��� � �� �������. � ������� �� � ���� ����, � �� ��������� ����.\
					\n\n{008000}[�������]:{FFFFFF} ����������� 10 ������\
					\n{4169E1}[�������]:{FFFFFF} 10 gold coins + 1 exp", "�����", "������\
				");
				ApplyActorAnimation(lesnik[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
			if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 4)
			{
			    SPD(playerid, 74, DSM, "{008000}������",
				"\
					{FFFFFF}���� ������� ��� ���� ������! ��, ��������, ��� ������, ��� ����� ������� �����?\
					\n{FFFFFF}������ ��� ��� ����� � ����, �� ��� �� �� ��������.\
					\n\n{FFFFFF}������, �����, �����-�� ������ ���������� �������� ����� ������, � ����� �������.\
					\n{FFFFFF}������ ���� ��� � ��������, � ����� ���� ��������� �� � �����. ����� �� ��.\
					\n\n{008000}[�������]:{FFFFFF} ������� ���� � ����� ��������\
					\n{4169E1}[�������]:{FFFFFF} 10 gold coins + 1 exp", "�����", "������\
				");
				ApplyActorAnimation(lesnik[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
			if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 5)
			{
			    SPD(playerid, 73, DSM, "{008000}������",
				"\
					{FFFFFF}׸��! ����� ���������, �� ���� �������� ����� ������ ��� �� ����!\
					\n{FFFFFF}� �����, � ���� ������ ����� ������ �����, ���������, � ���. ������ ��� ����� � ����� ��� ��������!\
					\n\n{008000}[�������]:{FFFFFF} ������ ���� �� ������ �������\
					\n{4169E1}[�������]:{FFFFFF} 10 gold coins + 1 exp", "�����", "������\
				");
				ApplyActorAnimation(lesnik[0], "PED","IDLE_chat", 4.1, 0, 0, 0, 0, 1);
			}
	    }
	    else
	    {
	        SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}������� �������� ��������� ������");
	    }
	}
	if(pickupid == ammo[0])
	{
	    SetPlayerPos(playerid,287.7492,-37.8862,1001.5156);
		SetPlayerFacingAngle(playerid,319.5831);
		SetPlayerInterior(playerid,4);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == ammo[1])
	{
	    SetPlayerPos(playerid,1364.6537,-1279.5354,13.5469);
		SetPlayerFacingAngle(playerid,88.9678);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid, 0);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid == ammo[2])
	{
	    SPD(playerid, 70, DSL, "{FF0000}Ammu-Nation", "{FF0000}1. {FFFFFF}Silence pistol ( 50 �� = 5000 $ )\n{FF0000}2. {FFFFFF}Desert Eagle( 50 �� = 5000 $ )\n{FF0000}3. {FFFFFF}Shotgun( 50 �� = 5000 $ )\n{FF0000}4. {FFFFFF}AK-47( 50 �� = 5000 $ )\n{FF0000}4. {FFFFFF}M4A1( 50 �� = 5000 $ )\n{FF0000}5. {FFFFFF}Country Rifle( 50 �� = 5000 $ )", "������", "������");
	}
	return true;
}
public OnVehicleMod(playerid, vehicleid, componentid)
{
	return true;
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return true;
}
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return true;
}
public OnPlayerSelectedMenuRow(playerid, row)
{
	return true;
}
public OnPlayerExitedMenu(playerid)
{
	return true;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return true;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new carid = GetPlayerVehicleID(playerid);
	if(newkeys == KEY_SUBMISSION)
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        GetVehicleParamsEx(carid, engine, lights, alarm, doors, bonnet, boot, objective);
	        switch(EngineState[carid])
	        {
	            case false:
	            {
	                EngineState[carid] = true;
	                SetVehicleParamsEx(carid, true, lights, alarm, doors, bonnet, boot, objective);
	            }
	            case true:
	            {
	                EngineState[carid] = false;
	                SetVehicleParamsEx(carid, false, lights, alarm, doors, bonnet, boot, objective);
	            }
	        }
	    }
	}
	return true;
}
public OnRconLoginAttempt(ip[], password[], success)
{
	return true;
}
public OnPlayerUpdate(playerid)
{
    new target = GetPlayerTargetPlayer(playerid);
    if(target != INVALID_PLAYER_ID)
	{
	    SCM(playerid, COLOR_GREEN, !"��������");
	}
	return true;
}
public OnPlayerStreamIn(playerid, forplayerid)
{
	return true;
}
public OnPlayerStreamOut(playerid, forplayerid)
{
	return true;
}
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return true;
}
public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return true;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return true;
}
public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if(login_check{playerid} == false)
	{
	    SCM(playerid, COLOR_GREY, !"�� �� ��������������");
	    return false;
	}
	return true;
}
public OnPlayerClickTextDraw(playerid, Text: clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW && number_skin{playerid} > 0)
	{
	    SelectTextDraw(playerid, 0xFF0000FF);
	}
	if(clickedid == td_select_skin[playerid][0])
	{
	    number_skin{playerid} ++;
	    if(player[playerid][psex] == 1)
	    {
	        if(number_skin{playerid} == 11)
	        {
	            number_skin{playerid} = 1;
	        }
	    }
	    else
	    {
	        if(number_skin{playerid} == 11)
	        {
	            number_skin{playerid} = 11;
	        }
	    }
	    switch(number_skin{playerid})
	    {
	        // Man
	        case 1: SetPlayerSkin(playerid, 184);
			case 2: SetPlayerSkin(playerid, 202);
			case 3: SetPlayerSkin(playerid, 2);
			case 4: SetPlayerSkin(playerid, 5);
			case 5: SetPlayerSkin(playerid, 15);
			case 6: SetPlayerSkin(playerid, 24);
			case 7: SetPlayerSkin(playerid, 23);
			case 8: SetPlayerSkin(playerid, 29);
			case 9: SetPlayerSkin(playerid, 60);
			case 10: SetPlayerSkin(playerid, 67);
			// Woman
			case 11: SetPlayerSkin(playerid, 93);
			case 12: SetPlayerSkin(playerid, 192);
			case 13: SetPlayerSkin(playerid, 193);
			case 14: SetPlayerSkin(playerid, 12);
			case 15: SetPlayerSkin(playerid, 152);
	    }
	}
	if(clickedid == td_select_skin[playerid][1])
	{
	    number_skin{playerid} --;
	    if(player[playerid][psex] == 1)
	    {
	        if(number_skin{playerid} == 0)
	        {
	            number_skin{playerid} = 10;
	        }
	    }
	    else
	    {
	        if(number_skin{playerid} == 10)
	        {
	            number_skin{playerid} = 15;
	        }
	    }
	    switch(number_skin{playerid})
	    {
	        // Man
	        case 1: SetPlayerSkin(playerid, 184);
			case 2: SetPlayerSkin(playerid, 202);
			case 3: SetPlayerSkin(playerid, 2);
			case 4: SetPlayerSkin(playerid, 5);
			case 5: SetPlayerSkin(playerid, 15);
			case 6: SetPlayerSkin(playerid, 24);
			case 7: SetPlayerSkin(playerid, 23);
			case 8: SetPlayerSkin(playerid, 29);
			case 9: SetPlayerSkin(playerid, 60);
			case 10: SetPlayerSkin(playerid, 67);
			// Woman
			case 11: SetPlayerSkin(playerid, 93);
			case 12: SetPlayerSkin(playerid, 192);
			case 13: SetPlayerSkin(playerid, 193);
			case 14: SetPlayerSkin(playerid, 12);
			case 15: SetPlayerSkin(playerid, 152);
	    }
	}
	if(clickedid == td_select_skin[playerid][2])
	{
	    new year_server,
			mounth_server,
			day_server;
			
	    for(new i; i != 3; i++) TextDrawHideForPlayer(playerid, td_select_skin[playerid][i]);
	    SCM(playerid, COLOR_WHITE, !"[����������] {32CD32}����������� � �������� ������������!");
	    SCM(playerid, COLOR_WHITE, !"[����������] {32CD32}��� ������ ����������� ������ ��������� ������� ������� � ����");
	    SCM(playerid, COLOR_WHITE, !"[����������] {32CD32}��� ����� �������� �� ����� �����");
	    SCM(playerid, COLOR_WHITE, !"[����������] {32CD32}����� ��������� ����-������, ������ ����� ����� �� ������");
	    SCM(playerid, COLOR_WHITE, !"[����������] {32CD32}���� �������� ������� � /rep - ������ ���� �������� � ������!");
	    SCM(playerid, COLOR_WHITE, !"[����������] {32CD32}����� �������� ����� ������� ��������, ������ �������� {FFFFFF}/donate {32CD32}:)");
	    SCM(playerid, COLOR_WHITE, !"[����������] {32CD32}����������� �������� {FFFFFF}starter pack. {32CD32}�� ��������� ����� � ���� � ���� ������ �������");
	    login_check{playerid} = true;
	    Freeze(playerid, 1);
		number_skin{playerid} = 0;
		CancelSelectTextDraw(playerid);
		SetPlayerVirtualWorld(playerid, 0);
		SpawnPlayer(playerid);
		// Create Account
		player[playerid][plevel] = 1;
		player[playerid][pcash] = 500;
		player[playerid][pskin] = GetPlayerSkin(playerid);
		player[playerid][pmoney] = 0;
		player[playerid][pquest] = 1;
		player[playerid][pquestpoint] = 1;
		//update_timer[playerid] = SetTimerEx("UpdateTime", 1000, false, "i", playerid);
		getdate(year_server, mounth_server, day_server);
		format(player[playerid][pdate_reg], 10+1, "%d/%d/%d", day_server, mounth_server, year_server);
		static
		    fmt_str[] =
		    "\
				INSERT INTO `accounts` (`Name`, `Password`, `Mail`, `Sex`, `Skin`, `Level`, `Date Reg`) \
		 		VALUES ('%s', '%s', '%s', '%d', '%d', '%d', '%s')\
			 ",
			 fmt_str_2[] = "SELECT * FROM `accounts` WHERE `ID` = '%s'";
		new
			string[sizeof(fmt_str)+MAX_PLAYER_NAME*2+99],
			string_2[sizeof(fmt_str_2)+MAX_PLAYER_NAME-1];
		mysql_format(connect_mysql, string, sizeof(string), fmt_str,
		GN(playerid), player[playerid][ppassword], player[playerid][pmail], player[playerid][psex],
		player[playerid][pskin], player[playerid][plevel], player[playerid][pdate_reg]);
		mysql_format(connect_mysql, string_2, sizeof(string_2), fmt_str_2, GN(playerid));
		mysql_function_query(connect_mysql, string, true, "", "");
		mysql_function_query(connect_mysql, string_2, true, "@_GetID", "i",playerid);
	}
	return true;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(hittype == BULLET_HIT_TYPE_OBJECT && hitid == deer[0])
    {
        deerkill[playerid] += 1;
        if(deerkill[playerid] == 5)
        {
            deerkill[playerid] = 0;
	        DestroyObject(deer[0]);
			SetTimerEx("@_meat1", 60000, false, "i", deer[0]);
			GiveMeat(playerid);
		}
    }
    if(hittype == BULLET_HIT_TYPE_OBJECT && hitid == deer[1])
    {
        deerkill[playerid] += 1;
        if(deerkill[playerid] == 5)
        {
            deerkill[playerid] = 0;
	        DestroyObject(deer[1]);
			SetTimerEx("@_meat2", 60000, false, "i", deer[1]);
			GiveMeat(playerid);
		}
    }
    if(hittype == BULLET_HIT_TYPE_OBJECT && hitid == deer[2])
    {
        deerkill[playerid] += 1;
        if(deerkill[playerid] == 5)
        {
            deerkill[playerid] = 0;
	        DestroyObject(deer[2]);
			SetTimerEx("@_meat3", 60000, false, "i", deer[2]);
			GiveMeat(playerid);
		}
    }
    return true;
}
// ============================= [ Forward's ] =================================
@_CheckLogin(playerid);
@_CheckLogin(playerid)
{
	SCM(playerid, COLOR_LRED, "����� �� ����������� �����\n������� (/q)uit, ����� �����");
	tkick(playerid);
	return true;
}
@_FastSpawn(playerid);
@_FastSpawn(playerid)
{
	SetPlayerSpawn(playerid);
	return true;
}
@_OnLogin(playerid);
@_OnLogin(playerid)
{
	new
	    rows,
	    fields;
	cache_get_data(rows, fields);
	if(rows)
	{
	    cache_get_field_content(0, "Password", player[playerid][ppassword], connect_mysql, 32);
	    cache_get_field_content(0, "Mail", player[playerid][ppassword], connect_mysql, 64);
	    cache_get_field_content(0, "Date Reg", player[playerid][pdate_reg], connect_mysql, 10);
	    player[playerid][pid] = cache_get_field_content_int(0, "ID");
	    player[playerid][plevel] = cache_get_field_content_int(0, "Level");
	    player[playerid][pexp] = cache_get_field_content_int(0, "Exp");
	    player[playerid][pskin] = cache_get_field_content_int(0, "Skin");
	    player[playerid][psex] = cache_get_field_content_int(0, "Sex");
	    player[playerid][page] = cache_get_field_content_int(0, "Age");
	    player[playerid][ppass] = cache_get_field_content_int(0, "Pass");
	    player[playerid][pcash] = cache_get_field_content_int(0, "Cash");
	    player[playerid][pmoney] = cache_get_field_content_int(0, "Money");
	    player[playerid][pquest] = cache_get_field_content_int(0, "Quest");
	    player[playerid][pquestpoint] = cache_get_field_content_int(0, "Questpoint");
	    player[playerid][ppquest] = cache_get_field_content_int(0, "Pquest");
	    player[playerid][psquest] = cache_get_field_content_int(0, "Squest");
	    player[playerid][pprava] = cache_get_field_content_int(0, "Prava");
	    player[playerid][pgold] = cache_get_field_content_int(0, "Gold");
	    player[playerid][papple] = cache_get_field_content_int(0, "Apple");
	    player[playerid][pwork] = cache_get_field_content_int(0, "Work");
	    player[playerid][pfskill] = cache_get_field_content_int(0, "Fskill");
	    player[playerid][pcatalina] = cache_get_field_content_int(0, "Catalina");
	    player[playerid][pbcar] = cache_get_field_content_int(0, "Bcar");
	    player[playerid][pbhacker] = cache_get_field_content_int(0, "Bhacker");
	    player[playerid][pstart] = cache_get_field_content_int(0, "Start");
	    player[playerid][pfactskill] = cache_get_field_content_int(0, "Factskill");
	    player[playerid][pmetall] = cache_get_field_content_int(0, "Metall");
	    player[playerid][pcrisp] = cache_get_field_content_int(0, "Crisp");
	    player[playerid][pshawarma] = cache_get_field_content_int(0, "Shawarma");
	    player[playerid][psprunk] = cache_get_field_content_int(0, "Sprunk");
	    player[playerid][pcola] = cache_get_field_content_int(0, "Cola");
	    player[playerid][pbeer] = cache_get_field_content_int(0, "Beer");
	    player[playerid][pcigarette] = cache_get_field_content_int(0, "Cigarette");
	    player[playerid][pzhiga] = cache_get_field_content_int(0, "Zhiga");
	    player[playerid][pphone] = cache_get_field_content_int(0, "Phone");
	    player[playerid][pbook] = cache_get_field_content_int(0, "Book");
	    player[playerid][pmag] = cache_get_field_content_int(0, "Mag");
	    player[playerid][prguitar] = cache_get_field_content_int(0, "Rguitar");
	    player[playerid][pbguitar] = cache_get_field_content_int(0, "Bguitar");
	    player[playerid][pwguitar] = cache_get_field_content_int(0, "Wguitar");
	    player[playerid][pmeat] = cache_get_field_content_int(0, "Meat");
	    player[playerid][pcozha] = cache_get_field_content_int(0, "Cozha");
	    player[playerid][pmprava] = cache_get_field_content_int(0, "Mprava");
	    player[playerid][pgunlic] = cache_get_field_content_int(0, "Gunlic");
	    player[playerid][phuntlic] = cache_get_field_content_int(0, "Huntlic");
	    player[playerid][pfishlic] = cache_get_field_content_int(0, "Fishlic");
	    SetTimerEx("@_FastSpawn", 100, false, "i", playerid);
	    login_check{playerid} = true;
		KillTimer(login_timer[playerid]);
		//update_timer[playerid] = SetTimerEx("UpdateTime", 1000, false, "i", playerid);
	}
	else
	{
	    number_pass{playerid} ++;
	    if(number_pass{playerid} == 3)
	    {
	        SCM(playerid, COLOR_LRED, !"������� (/q)uit, ����� �����");
			tkick(playerid);
			return true;
	    }
	    static const
	    	fmt_str[] = "{FFFFFF}�������� ������. �������� �������: %d";
		new
			string[sizeof(fmt_str)];
		format(string, sizeof(string), fmt_str, 3-number_pass{playerid});
		SCM(playerid, COLOR_LRED, string);
	    AutorizationDialog(playerid);
	}
	return true;
}
@_GetID(playerid);
@_GetID(playerid)
{
	new
	    rows,
	    fields;
	cache_get_data(rows, fields);
	if(rows)
	    player[playerid][pid] = cache_insert_id();
	return true;
}
@_TimeKick(playerid);
@_TimeKick(playerid)
{
	Kick(playerid);
	return true;
}
@_OnPlayerCheck(playerid);
@_OnPlayerCheck(playerid)
{
	new
	    rows, fields;
	cache_get_data(rows, fields);
	if(rows)
	{
	    login_timer[playerid] = SetTimerEx("@_CheckLogin", 60_000, false, "i", playerid);
	    AutorizationDialog(playerid);
	}
	else
	{
	    static const
	        reset_data[pInfo];
		player[playerid] = reset_data;
		RegDialog(playerid);
	}
	return true;
}
@_UpdateServer(playerid);
@_UpdateServer(playerid)
{
	new
	    hour_server_2,
	    minute_server_2,
	    second_server_2;

	gettime(hour_server_2, minute_server_2, second_server_2);
	if(hour_server != hour_server_2)
	{
	    PayDay();
	}
	SetTimer("@_UpdateServer", 1000, false);
	return true;
}
@_UpdateTime(playerid);
@_UpdateTime(playerid)
{
	if(player[playerid][pcash] != GetPlayerMoney(playerid))
	{
	    ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, player[playerid][pcash]);
	}
	update_timer[playerid] = SetTimerEx("UpdateTime", 1000, false, "i", playerid);
	return true;
}
@_UnivPub(playerid);
@_UnivPub(playerid)
{
	switch(random(2))
	{
	    case 0:
	    {
			SetPVarInt(playerid, "Fact", 1);
			ApplyAnimation(playerid, "OTB", "BETSLP_LOOP", 0.0, 0, 0, 0, 0, 0);
			RemovePlayerAttachedObject(playerid, 1), RemovePlayerAttachedObject(playerid, 2);
			SCM(playerid, COLOR_LRED, !"[����������] {FFFFFF}�� ������� ����������� ������. �������� ���������.");
			TogglePlayerControllable(playerid, 1);
			GameTextForPlayer(playerid, "~r~Fail", 500, 1);
	    }
	    case 1,2:
	    {
			SetPVarInt(playerid, "Fact", 3);
			ApplyAnimation(playerid, "OTB", "BETSLP_LOOP", 0.0, 0, 0, 0, 0, 0);
			RemovePlayerAttachedObject(playerid, 1), RemovePlayerAttachedObject(playerid, 2);
			TogglePlayerControllable(playerid, 1);
			GameTextForPlayer(playerid, "~g~Success", 500, 1);
			SetPlayerAttachedObject(playerid, 1, 1575, 1, -0.073000, 0.358000, -0.032000, 0.000000, 87.999961, 0.000000, 1.000000, 1.00, 1.000000);
			SetPlayerSpecialAction(playerid, 25);
			SCM(playerid, COLOR_GREEN, !"[����������] {FFFFFF}�������� ������� ������ �� �����");
			SetPlayerCheckpoint(playerid, 2563.7656,-1292.9229,1044.1250, 1.0);
		}
	}
	return true;
}
@_deer1(playerid);
@_deer1(playerid)
{
    SetTimerEx("@_deer12", 5000, false, "i", deer[0]);
	MoveObject(deer[0],2404.8440,-166.6925,25.3822, 3);
	return true;
}
@_deer2(playerid);
@_deer2(playerid)
{
    SetTimerEx("@_deer22", 5000, false, "i", deer[1]);
	MoveObject(deer[1],2659.9731,-44.4151,45.4146, 3);
	return true;
}
@_deer3(playerid);
@_deer3(playerid)
{
    SetTimerEx("@_deer32", 5000, false, "i", deer[2]);
	MoveObject(deer[2],2533.9753,-216.4176,30.4325, 3);
	return true;
}
@_deer12(playerid);
@_deer12(playerid)
{
    SetTimerEx("@_deer13", 5000, false, "i", deer[0]);
	MoveObject(deer[0],2433.9578,-158.8055,30.1244, 3);
	return true;
}
@_deer22(playerid);
@_deer22(playerid)
{
    SetTimerEx("@_deer23", 5000, false, "i", deer[1]);
	MoveObject(deer[1],2676.1541,-26.0621,39.0081, 3);
	return true;
}
@_deer32(playerid);
@_deer32(playerid)
{
    SetTimerEx("@_deer33", 5000, false, "i", deer[2]);
	MoveObject(deer[2],2556.5583,-235.2862,32.5296, 3);
	return true;
}
@_deer13(playerid);
@_deer13(playerid)
{
    SetTimerEx("@_deer14", 5000, false, "i", deer[0]);
	MoveObject(deer[0],2453.8298,-146.0780,32.6519, 3);
	return true;
}
@_deer23(playerid);
@_deer23(playerid)
{
    SetTimerEx("@_deer24", 5000, false, "i", deer[1]);
	MoveObject(deer[1],2685.9382,-54.3554,45.0674, 3);
	return true;
}
@_deer33(playerid);
@_deer33(playerid)
{
    SetTimerEx("@_deer34", 5000, false, "i", deer[2]);
	MoveObject(deer[2],2579.3176,-219.6271,33.9105, 3);
	return true;
}
@_deer14(playerid);
@_deer14(playerid)
{
    SetTimerEx("@_deer15", 5000, false, "i", deer[0]);
	MoveObject(deer[0],2476.9048,-162.4956,34.5637, 3);
	return true;
}
@_deer24(playerid);
@_deer24(playerid)
{
    SetTimerEx("@_deer25", 5000, false, "i", deer[1]);
	MoveObject(deer[1],2690.3906,-78.9300,46.8784, 3);
	return true;
}
@_deer34(playerid);
@_deer34(playerid)
{
    SetTimerEx("@_deer35", 5000, false, "i", deer[2]);
	MoveObject(deer[2],2614.5190,-198.0352,40.7990, 3);
	return true;
}
@_deer15(playerid);
@_deer15(playerid)
{
    SetTimerEx("@_deer16", 5000, false, "i", deer[0]);
	MoveObject(deer[0],2462.0923,-170.0650,30.8119, 3);
	return true;
}
@_deer25(playerid);
@_deer25(playerid)
{
    SetTimerEx("@_deer26", 5000, false, "i", deer[1]);
	MoveObject(deer[1],2685.4128,-104.9765,45.6767, 3);
	return true;
}
@_deer35(playerid);
@_deer35(playerid)
{
    SetTimerEx("@_deer36", 5000, false, "i", deer[2]);
	MoveObject(deer[2],2599.1350,-177.5597,41.9525, 3);
	return true;
}
@_deer16(playerid);
@_deer16(playerid)
{
    SetTimerEx("@_deer17", 5000, false, "i", deer[0]);
	MoveObject(deer[0],2433.4253,-174.9687,26.4282, 3);
	return true;
}
@_deer26(playerid);
@_deer26(playerid)
{
    SetTimerEx("@_deer27", 5000, false, "i", deer[1]);
	MoveObject(deer[1],2677.0068,-137.6527,38.4181, 3);
	return true;
}
@_deer36(playerid);
@_deer36(playerid)
{
    SetTimerEx("@_deer37", 5000, false, "i", deer[2]);
	MoveObject(deer[2],2561.9668,-178.6006,40.0542, 3);
	return true;
}
@_deer17(playerid);
@_deer17(playerid)
{
    SetTimerEx("@_deer18", 5000, false, "i", deer[0]);
	MoveObject(deer[0],2399.1016,-169.2069,24.4134, 3);
	return true;
}
@_deer27(playerid);
@_deer27(playerid)
{
    SetTimerEx("@_deer28", 5000, false, "i", deer[1]);
	MoveObject(deer[1],2668.4128,-165.5421,37.7821, 3);
	return true;
}
@_deer37(playerid);
@_deer37(playerid)
{
    SetTimerEx("@_deer38", 5000, false, "i", deer[2]);
	MoveObject(deer[2],2524.1133,-181.1451,35.7752, 3);
	return true;
}
@_deer18(playerid);
@_deer18(playerid)
{
    MoveObject(deer[0],2368.8831,-148.5168,27.0989,3);
	SetTimerEx("@_deer1", 5000, false, "i", deer[0]);
	return true;
}
@_deer28(playerid);
@_deer28(playerid)
{
	DestroyObject(deer[1]);
    MoveObject(deer[1],2479.4099,-129.7142,34.2922,3);
	SetTimerEx("@_deer02", 60000, false, "i", deer[1]);
	return true;
}
@_deer38(playerid);
@_deer38(playerid)
{
    MoveObject(deer[2],2504.0647,-218.2203,24.6313,3);
	SetTimerEx("@_deer3", 5000, false, "i", deer[2]);
	return true;
}
@_meat1(playerid);
@_meat1(playerid)
{
    deer[0] = CreateObject(19315,2368.8831,-148.5168,27.0989,0.0,0.0,0.0);
	SetTimerEx("@_deer1", 5000, false, "i", deer[0]);
}
@_meat2(playerid);
@_meat2(playerid)
{
	deer[1] = CreateObject(19315,2622.9863,-62.5590,51.8781,0.0,0.0,0.0);
	SetTimerEx("@_deer2", 5000, false, "i", deer[1]);
}
@_meat3(playerid);
@_meat3(playerid)
{
	deer[2] = CreateObject(19315,2504.0647,-218.2203,24.6313,0.0,0.0,0.0);
	SetTimerEx("@_deer3", 5000, false, "i", deer[2]);
}
@_deer02(playerid);
@_deer02(playerid)
{
    deer[1] = CreateObject(19315,2622.9863,-62.5590,51.8781,0.0,0.0,0.0);
	SetTimerEx("@_deer2", 20000, false, "i", deer[1]);
}
// ============================= [ Stock's ] ===================================
stock Lvlup(playerid)
{
    if(player[playerid][pexp] == player[playerid][plevel]*4)
	{
	    player[playerid][pexp] = 0;
	    player[playerid][plevel] ++;
	    SCM(playerid, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
	}
}
stock KillTimers(playerid)
{
	KillTimer(login_timer[playerid]);
	KillTimer(update_timer[playerid]);
}
stock AutorizationDialog(playerid)
{
    static const
	    fmt_str[] =
		"\
			{BEBEBE}��� ������� {4169E1}%s ���������������\n\
			{BEBEBE}������� ���� ������:\n\
		";
	new
		string[sizeof(fmt_str)+MAX_PLAYER_NAME-1];
	format(string, sizeof(string), fmt_str, GN(playerid));
	SPD(playerid, 4, DSP, "�����������", string, "�����", "�����");
	return true;
}
stock SetPlayerSpawn(playerid)
{
	SetPlayerColor(playerid, 0xFFFFFF00);
	SetPlayerScore(playerid, player[playerid][plevel]);
	SetPlayerSkin(playerid,player[playerid][pskin]);
	SetPlayerPos(playerid, 184.4892,-113.0285,1.5391);
	SetPlayerFacingAngle(playerid, 269.1123);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetCameraBehindPlayer(playerid);
	//SpawnPlayer(playerid);
}
stock PlayerTextDraws(playerid)
{
	td_select_skin[playerid][0] = TextDrawCreate(534.582580, 303.333221, "LD_BEAT:right");
	TextDrawLetterSize(td_select_skin[playerid][0], 0.000000, 0.000000);
	TextDrawTextSize(td_select_skin[playerid][0], 67.935607, 37.916625);
	TextDrawAlignment(td_select_skin[playerid][0], 2);
	TextDrawColor(td_select_skin[playerid][0], -5963521);
	TextDrawSetShadow(td_select_skin[playerid][0], 0);
	TextDrawSetOutline(td_select_skin[playerid][0], 0);
	TextDrawBackgroundColor(td_select_skin[playerid][0], -5963521);
	TextDrawFont(td_select_skin[playerid][0], 4);
	TextDrawSetSelectable(td_select_skin[playerid][0], true);
	
	td_select_skin[playerid][1] = TextDrawCreate(30.985092, 303.333221, "LD_BEAT:left");
	TextDrawLetterSize(td_select_skin[playerid][1], 0.000000, 0.000000);
	TextDrawTextSize(td_select_skin[playerid][1], 67.935607, 37.916625);
	TextDrawAlignment(td_select_skin[playerid][1], 2);
	TextDrawColor(td_select_skin[playerid][1], -5963521);
	TextDrawSetShadow(td_select_skin[playerid][1], 0);
	TextDrawSetOutline(td_select_skin[playerid][1], 0);
	TextDrawBackgroundColor(td_select_skin[playerid][1], -5963521);
	TextDrawFont(td_select_skin[playerid][1], 4);
	TextDrawSetSelectable(td_select_skin[playerid][1], true);
	
	td_select_skin[playerid][2] = TextDrawCreate(310.266571, 313.249938, "SELECT");
	TextDrawLetterSize(td_select_skin[playerid][2], 0.449999, 1.600000);
	TextDrawTextSize(td_select_skin[playerid][2], 10.935607, 55.916625);
	TextDrawAlignment(td_select_skin[playerid][2], 2);
	TextDrawColor(td_select_skin[playerid][2], -5963521);
	TextDrawSetShadow(td_select_skin[playerid][2], 0);
	TextDrawSetOutline(td_select_skin[playerid][2], 1);
	TextDrawBackgroundColor(td_select_skin[playerid][2], 255);
	TextDrawFont(td_select_skin[playerid][2], 2);
	TextDrawSetProportional(td_select_skin[playerid][2], 2);
	TextDrawSetSelectable(td_select_skin[playerid][2], true);
}
stock Clear(playerid)
{
	number_skin{playerid} = 0;
	login_check{playerid} = false;
	number_pass{playerid} = false;
}
stock SexDialog(playerid)
{
	SPD(playerid, 3, DSM, "���", "�������� ��� ���������:", "�������", "�������");
}
stock MailDialog(playerid)
{
	SPD(playerid, 2, DSI, "����������� �����",
	"\
		{BEBEBE}������� ���� ����� ����������� �����\n\
		����� ����������� ����� ��������� ��� �������������� ��������", "�����", "�����\
	");
}
stock CheckRussianText(string[], size = sizeof(string))
{
	for(new i; i < size; i++)
	switch(string[i])
	{
	    case '�'..'�', '�'..'�': return true;
	}
	return false;
}
stock RegDialog(playerid)
{
    static const
	    fmt_str[] =
		"\
			{BEBEBE}����������� ������ ���������\n\
			{BEBEBE}��� �������: {4169E1}%s\n\n\
			{BEBEBE}���������� ������ �� ��������:\n\
			{BEBEBE}������ ������ ��������� �� 6 �� 32 ��������\
		";
	new
		string[sizeof(fmt_str)+MAX_PLAYER_NAME-1];
	format(string, sizeof(string), fmt_str, GN(playerid));
	SPD(playerid, 1, DSI, "�����������", string, "�����", "�����");
	return true;
}
stock ShowStats(playerid, id)
{
    static const
	    fmt_str[] =
		"\
			{FFFFFF}ID ��������:\t\t{4169E1}%d\
			\n{FFFFFF}��� ���������:\t{4169E1}%s\
			\n{FFFFFF}�������:\t\t{4169E1}%d\
			\n{FFFFFF}����:\t\t{4169E1}%d/%d\
			\n{FFFFFF}������:\t\t{4169E1}%d\
			\n{FFFFFF}������ � �����:\t{4169E1}%d\
			\n{FFFFFF}���:\t\t\t{4169E1}%s\
			\n{FFFFFF}���� �����������:\t{4169E1}%s\
		";
	new
		string[sizeof(fmt_str)+MAX_PLAYER_NAME+24]; //(-(���-�� %s/%d) �������� �� 2 � -1)+���� ����� id+���� ���+���� ����� ���� ��������� ����������
	format(string, sizeof(string), fmt_str, player[id][pid],GN(id),player[id][plevel],player[id][pexp],player[id][plevel]*4,player[id][pcash],
	player[id][pmoney], sex_info[player[id][psex]], player[id][pdate_reg]);
	SPD(playerid, 6, DSM, "���������� ���������", string, "�������", "�����");
}
stock PayDay()
{
    gettime(hour_server, minute_server, second_server);
	SetWorldTime(hour_server);
	foreach(new i: Player)
	{
		if(login_check{i} == false)
		    return true;

		SCM(i, COLOR_ORANGE, !"      [ Pay Day ]      ");
		player[i][pexp] ++;
		if(player[i][pexp] == player[i][plevel]*4)
		{
		    player[i][pexp] = 0;
		    player[i][plevel] ++;
		    SCM(i, COLOR_GREEN, !"�����������! ��� ������� ������� �������");
		}
	}
	return true;
}
stock SavePlayer(playerid, const field_name[], const set[], const type[])
{
	new string[128+1];
	if(!strcmp(type, "d", true))
	{
	    mysql_format(connect_mysql, string, sizeof(string), "UPDATE `accounts` SET `%s` = '%d' WHERE `Name` = '%s'", field_name, set, GN(playerid));
	}
	else if(!strcmp(type, "s", true))
	{
	    mysql_format(connect_mysql, string, sizeof(string), "UPDATE `accounts` SET `%s` = '%s' WHERE `Name` = '%s'", field_name, set, GN(playerid));
	}
	mysql_function_query(connect_mysql, string, false, "", "");
}
stock SavePlayerAll(playerid)
{
    static 
	    fmt_str[] = "UPDATE `accounts` SET `Cash` = '%d',\
		`Exp` = '%d', `Money` = '%d', `Quest` = '%d', `Questpoint` = '%d', `Squest` = '%d', `Level` = '%d', `Age` = '%d', `Pass` = '%d', `Pquest` = '%d', `Prava` = '%d',`Gold` = '%d', `Apple` = '%d', `Work` = '%d', `Fskill` = '%d', `Catalina` = '%d', `Bcar` = '%d', `Bhacker` = '%d', `Start` = '%d', `Factskill` = '%d', `Metall` = '%d', `Crisp` = '%d', `Shawarma` = '%d', `Sprunk` = '%d', `Cola` = '%d', `Beer` = '%d', `Cigarette` = '%d', `Zhiga` = '%d', `Phone` = '%d', `Book` = '%d', `Mag` = '%d', `Rguitar` = '%d', `Bguitar` = '%d', `Wguitar` = '%d', `Meat` = '%d', `Cozha` = '%d', `Mprava` = '%d', `Gunlic` = '%d', `Huntlic` = '%d', `Fishlic` = '%d' WHERE `Name` = '%s'";
	new
		string[sizeof(fmt_str)+MAX_PLAYER_NAME+300];
	mysql_format(connect_mysql, string, sizeof(string), fmt_str, player[playerid][pcash],player[playerid][pexp],player[playerid][pmoney],player[playerid][pquest],player[playerid][pquestpoint],player[playerid][psquest],player[playerid][plevel],player[playerid][page],player[playerid][ppass],player[playerid][ppquest],player[playerid][pprava],player[playerid][pgold],player[playerid][papple],player[playerid][pwork],player[playerid][pfskill],player[playerid][pcatalina],player[playerid][pbcar],player[playerid][pbhacker],player[playerid][pstart], player[playerid][pfactskill],player[playerid][pmetall],player[playerid][pcrisp],player[playerid][pshawarma],player[playerid][psprunk],player[playerid][pcola],player[playerid][pbeer],player[playerid][pcigarette],player[playerid][pzhiga],player[playerid][pphone],player[playerid][pbook],player[playerid][pmag],player[playerid][prguitar],player[playerid][pbguitar],player[playerid][pwguitar],player[playerid][pmeat],player[playerid][pcozha],
	player[playerid][pmprava],player[playerid][pgunlic],player[playerid][phuntlic],player[playerid][pfishlic],GN(playerid));
	mysql_function_query(connect_mysql, string, false, "", "");
}
stock GiveMeat(playerid)
{
    if(player[playerid][pmeat] <= 200)
    {
	    player[playerid][pmeat] += 50;
	    player[playerid][pcozha] += 1;
	    SCM(playerid, COLOR_YELLOW, !"[�����] {FFFFFF}�� ��������� ����� � ������ ������ 50 ��");
	    if(player[playerid][pquest] == 2 && player[playerid][pquestpoint] == 3)
	    {
	        player[playerid][ppquest] += 1;
	        if(player[playerid][ppquest] == 10)
	        {
	            player[playerid][ppquest] = 0;
	            player[playerid][pquestpoint] = 4;
	            player[playerid][pgold] += 10;
	            player[playerid][pexp] += 1;
	            Lvlup(playerid);
	            SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}������� ��������. ��������� � �������, ����� �������� ���������");
	            SCM(playerid, COLOR_YELLOW, !"[�������] {FFFFFF}���������: 10 gold coins � 1 exp");
	        }
	    }
	}
	else
	{
		SCM(playerid, COLOR_GREEN, !"[�����] {FFFFFF}�� �� ������ ������ � ����� ������ 100 �� ����");
		SCM(playerid, COLOR_LGREEN, !"[���������] {FFFFFF}�������� ������ � �������� ����������");
	}
}
// ============================= [ Command's ] =================================
cmd:menu(playerid)
{
	SPD(playerid, 5, DSL, "���� ������",
	"\
		1. ���������� ���������", "�������", "������\
	");
	return true;
}
alias:menu("mm", "mn");
cmd:payday(playerid)
{
	PayDay();
	return true;
}
cmd:veh(playerid, params[])
{
	new string[100];
	if(sscanf(params, "iii", params[0], params[1], params[2])) return SCM(playerid, COLOR_WHITE, "������� /veh [id ����������] [id 1 �����] [id 2 �����]");
	if(params[0] < 400 || params[0] > 611) return SCM(playerid, COLOR_LRED, "[������] {FFFFFF}id ������������� �������� �� ����� ���� ������ 400 � ������ 611");
	if(params[1] < 0 || params[1] > 255) return SCM(playerid, COLOR_LRED, "[������] {FFFFFF}id ����� �� ����� ���� ������ 0 � ������ 255");
	if(params[2] < 0 || params[2] > 255) return SCM(playerid, COLOR_LRED, "[������] {FFFFFF}id ����� �� ����� ���� ������ 0 � ������ 255");
	format(string, sizeof(string), "������������ �������� %d ������� �������", params[0]);
	SCM(playerid, COLOR_YELLOW, string);
	new Float: x;
	new Float: y;
	new Float: z;
	GetPlayerPos(playerid, x, y, z);
	CreateVehicle(params[0], x+3, y+1, z, 0.0, params[1], params[2], 999999);
	return true;
}
cmd:delcar(playerid)
{
	new carid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_LRED, "[������] {FFFFFF}�� ������ ���������� � ������������ ��������");
	DestroyVehicle(carid);
	SCM(playerid, COLOR_YELLOW, "������������ �������� ������� �������");
	EngineState[carid] = false;
	return true;
}
