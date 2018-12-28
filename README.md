this is easy and lightweight mvc framework
suitable for rapid development h5 game
for example:

App.DevelopmentSettings(1280,720,Stage.SCREEN_HORIZONTAL);
App.MyInit(MyGameInit);

and MyGameInit is implementation interface IGameInit
like this:

public interface IGameInit {
		function initDialog():void;
		function initSession():void;
		function initAction():void;
		function initCommand():void;
		function initDoublePanel():void;
		function initScence():void;
		function initGameLoader():void;
		function initConfig():void;
		function initPng():void;
}
and you will do like this:

package
{
	public class MyGameInit implements IGameInit
	{
		public function MyGameInit() {
		
		}
		
		public function initDialog():void {
			App.dialogManager.regDialog(Mypanel.DIALOG_TASK,RenwuPanel,"task",TaskMediator);
			App.dialogManager.regDialog(Mypanel.DIALOG_ZHAO_MU,ZhaomuPanel,"zhaomu",ZhaoMuMediator);
			App.dialogManager.regDialog(Mypanel.DIALOG_SHOP,ShopPanel,"shangdian", ShopMediator);
			App.dialogManager.regDialog(Mypanel.DIALOG_STRATAGEM,StratagemPanel,"jice",StratagemMediator);
			App.dialogManager.regDialog(Mypanel.DIALOG_BAG,BagPanel,"beibao",null);
			App.dialogManager.regDialog(Mypanel.CITY_BUILD_CREATE,CityBuildCreate,"town",CityBuildCreateMediator);
			App.dialogManager.regDialog(Mypanel.CITY_BUILD_LVUP,CityBuildLvup,"town",CityBuildLvUpMediator);
			App.dialogManager.regDialog(Mypanel.CITY_BUDUI,CityBudui,null,CityBuduiMediator);
			App.dialogManager.regDialog(Mypanel.CITY_BUDUI_DIAOBING,Diaobing,null,DiaobingMediator);
			App.dialogManager.regDialog(Mypanel.REMOVE_BUILD,CityBuildRemove,null,CityBuildRemoveMediator);
			App.dialogManager.regDialog(Mypanel.CHUZHENG,ChuZheng,"chuzheng",ChuzhengMediator);
			App.dialogManager.regDialog(Mypanel.WUJIANG,WuJiangPanel,"wujiang",WuJiangMediator);
			App.dialogManager.regDialog(Mypanel.WUJIANGSHUOMING,HeroInfoTab,"wujiang",WuJiangXinXiMediator);
			App.dialogManager.regDialog(Mypanel.SELECT_WUJIANG,SelectChuzheng,"chuzheng",SelectChuzhengMediator);
			App.dialogManager.regDialog(Mypanel.XINGJUN_LIST,XingjunList,null,XingjunListMediator);
			App.dialogManager.regDialog(Mypanel.YUNSHU_BINGLI,Yunshu,null,YunshuMediator);
			App.dialogManager.regDialog(Mypanel.GAME_OVER,GameOver,"jiesuan",GameOverMediator);
			App.dialogManager.regDialog(Mypanel.QINGBAO,Qingbao,null,QingbaoMediator);
			App.dialogManager.regDialog(Mypanel.WORLDMAP,WorldMap,"ditu",WorldMapMediator);
			App.dialogManager.regDialog(Mypanel.WAIJIAO,WaiJiaoPanel,"waijiao",WaiJiaoMediator);
			App.dialogManager.regDialog(Mypanel.ZHANBAO,ZhanbaoList,"zhanbaolb",ZhanbaoMediator);
			App.dialogManager.regDialog(Mypanel.JIANBAO,ZhanBaoInfo,"jiesuan",ZhanbaoInfoMediator);
			App.dialogManager.regDialog(Mypanel.CHENGCHI,CityPanel,null,CityPanelMediator);//"chengchi"
			App.dialogManager.regDialog(Mypanel.BINGLIJJ,Binglijijie,null,CityMediator);
			App.dialogManager.regDialog(Mypanel.MYMESSAGE,MessagePanel,"gerenxinxi",MessageMediator);
			App.dialogManager.regDialog(Mypanel.MJLPANEL,MjlPanel,null,MjlMediator);
			App.dialogManager.regDialog(Mypanel.YAOQING_ZUDUI,YaoqingZudui,null,YaoqingZuduiMediator);
			App.dialogManager.regDialog(Mypanel.MJLSHUOMING,MjlXinxiPanel,null,MjlXinxiMediator);
			App.dialogManager.regDialog(Mypanel.HAOYOU,Haoyou,"haoyou",HaoyouMediator);
			App.dialogManager.regDialog(Mypanel.ADDHAOYOU,AddHaoyou,null,AddHaoyouMediator);
			App.dialogManager.regDialog(Mypanel.TASK,TaskDialog,null,TaskMediator);
			App.dialogManager.regDialog(Mypanel.BEIZHU,Beizhu,null,BeizhuMediator);
			App.dialogManager.regDialog(Mypanel.ZHENGRONGXUANZE,ZhenrongXuanze,null,ZhenrongXuanzeMediator);
			App.dialogManager.regDialog(Mypanel.SELECTZHENGRONG,SelectZhenrong,null,SelectZhenrongMediator);
			App.dialogManager.regDialog(Mypanel.FENXIANG,FenxiangPanel,null,FenxiangMediator);
			App.dialogManager.regDialog(Mypanel.SHOUCANG,ShoucangPanel,null,ShoucangMediator);
			App.dialogManager.regDialog(Mypanel.SHOUCANG_INFO,ShoucangZhanbaoInfo,"jiesuan",ShoucangZhanbaoInfoMediator);
			App.dialogManager.regDialog(Mypanel.TONGJI,TongjiPanel,null,TongjiMediator);
			App.dialogManager.regDialog(Mypanel.MAILBATTLE,MailBattlePanel,"zhanbaolb",MailBattleMediator);
			App.dialogManager.regDialog(Mypanel.RECHARGEPANEL,RechargePanel,"chongzhi",RechargeMediator);
			App.dialogManager.regDialog(Mypanel.HUODONG,HuodongPanel,"huodong",HuodongMediator);
			App.dialogManager.regDialog(Mypanel.RANKLIST,RankList,null,RankMediator);
			App.dialogManager.regDialog(Mypanel.SETTING,SettingPanel,null,SettingMediator);
			App.dialogManager.regDialog(Mypanel.XIANGOU,XianGouPanel,null,XianGouMediator);
			App.dialogManager.regDialog(Mypanel.CDKEY,CDkeyPanel,null,CDkeyMediator);
			App.dialogManager.regDialog(Mypanel.DIANZAN,Dianzan,null,DianzanMediator);
			App.dialogManager.regDialog(Mypanel.DIANZAN2,DianzanView,null,Dianzan2Mediator);
			App.dialogManager.regDialog(Mypanel.VIPPANEL,VipPanel,null,VipMediator);
			App.dialogManager.regDialog(Mypanel.SHOUCHONG,ShouChongPanel,"shouchong",ShouChongMediator);
			App.dialogManager.regDialog(Mypanel.CHECK_OTHER_PLAYER,CheckOtherHero,"wujiang");
			App.dialogManager.regDialog(Mypanel.Mail_Battle_Jie_Suan,MailBattleJieSuan,"jiesuan");
			App.dialogManager.regDialog(Mypanel.Shop_Buy_Silver,TipsBuySilver,null);
			App.dialogManager.regDialog(Mypanel.DROPGIFT,DropGiftPanel,null,DropGiftMediator);
			App.dialogManager.regDialog(Mypanel.UNIONPANEL,UnionPanel,"lianmeng",UnionMediator);
			App.dialogManager.regDialog(Mypanel.NEWUNIONPANEL,NewUnionPanel,"lianmeng",NewUnionMediator);
			App.dialogManager.regDialog(Mypanel.TZHUANX,TZSXZPanel,null,TZSXZMediator);
			App.dialogManager.regDialog(Mypanel.DUOBAOJILU,DuoBaoJiLuPanel,null,DuoBaoJiLuMediator);
			App.dialogManager.regDialog(Mypanel.MEIRIPANEL,HuoyueDayView,"huodong",HuoyueDayMediator);
		}
		
		/**
		 * 注册Session
		 */		
		public function initSession():void {
			App.regSession(MainPlayerSession);
			App.regSession(ZhaoMuSession);//招募
			App.regSession(ShopSession);//商店
			App.regSession(StratagemSession);//计策
			App.regSession(WuJiangSession);//武将
			App.regSession(BagSession);//背包
			App.regSession(MapCitySession);
			App.regSession(WujiangXinxiSession);//武将详细信息界面		
			App.regSession(BattleSession);//战场
			App.regSession(HeroTeamSession);
			App.regSession(PlayerInfoSession);//玩家基本信息
			App.regSession(FriendSession);
			App.regSession(MailSession);
			App.regSession(TalkSession);//聊天session
			App.regSession(TaskSession);
			App.regSession(MailBattleSession);
			App.regSession(ShouFenSession);
			App.regSession(RechargeSession);
			App.regSession(SignInSession);
			App.regSession(HeartSession);
			App.regSession(RankSession);
			App.regSession(SettingSession);
			App.regSession(ActivitySession);
			App.regSession(LoginSession);
			App.regSession(SevenrenwuSession);//七天任务
			App.regSession(HuoyueSession);//每周活跃
			App.regSession(HuoyueDaySession);//每日活跃
			App.regSession(DropGiftSession);//胜利掉落物品
			App.regSession(DuoBaoSession);//幸运夺宝
			App.regSession(OpenFunctionSession);
			App.regSession(SensitiveSession);
			App.regSession(SoundSession);
			App.regSession(CreateRoleSession);
			App.regSession(VictoryBoxSession);
			App.regSession(DianZanSession);
			App.regSession(LoadSession);
			App.regSession(BtnSoundSession);
			App.regSession(RedPoingSession);
			App.regSession(DotSesion);
			App.regSession(VideoSession);
			App.regSession(GuideSession);
			App.regSession(UnionSession);
			App.regSession(SdkSession);
		}
		
		/**
		 *注册Action 
		 */		
		public function initAction():void {
			App.regAction(ActionId.ERRORTIPS,ErrorTipsAction);
			App.regAction(ActionId.InitServerTime, InitServerTimeAction);
			App.regAction(ActionId.ZHAOMU,ZhaoMuAction);//招募
			App.regAction(ActionId.LOGIN,LoginAction);
			App.regAction(ActionId.HEART,HeartAction);
			App.regAction(ActionId.SHOP,ShopAction);//商店
			App.regAction(ActionId.STRATAGEM,StratagemAction);//计策
			App.regAction(ActionId.WUJIANG,WuJiangAction);//商店
			App.regAction(ActionId.MAPCITY,MapCityAction);
			App.regAction(ActionId.HERO_TEAM,HeroTeamAction);
			App.regAction(ActionId.BAG, BagAction);//背包
			App.regAction(ActionId.FLUSHPLAYERNUM, FlushPlayerNumAction);//刷新玩家数据
			App.regAction(ActionId.TALK, TalkAction);
			App.regAction(ActionId.ARMS,ArmsAction);
			App.regAction(ActionId.PlayerInfo, PlayerInfoAction);
			App.regAction(ActionId.FRIEND, FriendAction);
			App.regAction(ActionId.MAIL,MailAction);
			App.regAction(ActionId.TASK,TaskAction);
			App.regAction(ActionId.SHOUFEN,ShouFenAction);
			App.regAction(ActionId.RECHARGE,RechargeAction);//充值
			App.regAction(ActionId.SIGNIN,SignInAction);
			App.regAction(ActionId.GUIDE,GuideAction);
			App.regAction(ActionId.RANK,RankAction);
			App.regAction(ActionId.SETTING,SettingAction);
			App.regAction(ActionId.SevenTask,SevenTaskAction);//七日任务
			App.regAction(ActionId.HUOYUEDAY,HuoyueDayAction);//每日任务			
			App.regAction(ActionId.JIJINLEIJI,ActivityAction);
			App.regAction(ActionId.CHANGE_SERVER,ChangeServerAction);
			App.regAction(ActionId.NewPlayerTASK,NewPlayerTaskAction);
			App.regAction(ActionId.GPlayerTASK,GPlayerTaskAction);
			App.regAction(ActionId.VICTORY_BOX,VictoryBoxAction);
			App.regAction(ActionId.PAOMA, PaoMaAction);
			App.regAction(ActionId.KickingOffTheLine,KickPlayerAction);
			App.regAction(ActionId.DUOBAO,DuoBaoAction);
			App.regAction(ActionId.MD5API, Md5Action);//申请md5
			App.regAction(ActionId.UNION, UnionAction);
			App.regAction(ActionId.Banned,BannedAction);
		}
		
		public function initCommand():void {
			
		}
		
		public function initDoublePanel():void {
			
		}
		
		public static const MAIN_SCENE:String = "MAIN_SCENE";
		public static const CREATE_SCENE:String = "CREATE_SCENE";
		public static const BATTLE_FIELD:String = "BATTLE_FIELD";
		public static const LOGIN_SCENE:String = "LOGIN_SCENE";
		
		
		
		public function initScence():void {
			App.sceneManager.regScene(MAIN_SCENE,MainScene,null,new Handler(MainScene,MainScene.loadResFun));
			
			var loginArr:Array = [];
			loginArr.push( SceneData.getResData("res/atlas/uiAction/load_dong.atlas",GameLoaderManager.ROOT) );
			loginArr.push(RES("go.atlas"));
			App.sceneManager.regScene(LOGIN_SCENE,LoginScene,LoginSceneMediator,loginArr,false,false,LoginScene.GROUP);
			App.sceneManager.regScene(CREATE_SCENE,CreateRoleScene,null,[RES("createRole.atlas")],false,false,CreateRoleScene.GROUP);
			App.sceneManager.regScene(BATTLE_FIELD,BattleFileScene,BattleFieldMediator,new Handler(BattleSession,BattleSession.loadResFun) ,true,true );
		}
		
		public static function RES(res:String):Object{
			return SceneData.getResData(res,GameLoaderManager.ATLAS);
		}
		
		public static const ROOT:String = "";
		public static const BATTLE_RES:String = "BATTLE";
		public static const HERO:String = "HERO";
		public static const CLIP:String = "CLIP";
		public static const ITEM:String = "ITEM";
		public static const SKILL_EFFECT:String = "SKILL_EFFECT";
		public static const BATTLE_CLIP:String = "BATTLE_CLIP";
		public static const BUFFER:String = "BUFFER";
		public static const SKILL:String = "SKILL";
		public static const ZHAN_HUO:String = "ZHAN_HUO";
		public static const BATTLE_ANI:String = "BATTLE_ANI";
		public static const SOUND:String = "SOUND";
		
		public function initGameLoader():void{
			App.loaderManager.regPath(ROOT,"");
			App.loaderManager.regPath(GameLoaderManager.ATLAS,"res/atlas/comp/");
			App.loaderManager.regPath(GameLoaderManager.PNG,"res/png/");
			App.loaderManager.regPath(HERO,"res/wujiang/");
			App.loaderManager.regPath(ITEM,"res/item");
			App.loaderManager.regPath(CLIP,"res/clip/");
			App.loaderManager.regPath(SKILL_EFFECT,"res/skill/");
			App.loaderManager.regPath(BATTLE_CLIP,"res/atlas/ani2/");
			App.loaderManager.regPath(BATTLE_RES,App.configJson["zhanbao"]);//http://192.168.5.152/battle/
			App.loaderManager.regPath(BUFFER,"res/atlas/skill/buff/");
			App.loaderManager.regPath(SKILL,"res/atlas/skill/skill/");
			App.loaderManager.regPath(ZHAN_HUO,"res/atlas/skill/");
			App.loaderManager.regPath(BATTLE_ANI,"ANI/soldiersAni2/");
			App.loaderManager.regPath(SOUND,"res/sound/");
		}
		
		public static const sys_hero:String = "sys_hero.txt";
		public static const sys_city:String = "sys_city.txt";
		public static const sys_strategy:String = "sys_strategy.txt";
		public static const sys_timetake:String = "sys_timetake.txt";
		public static const sys_item:String = "sys_item.txt";
		public static const sys_skill:String = "sys_skill.txt"; 
		public static const sys_strength:String = "sys_strength.txt";
		public static const sys_equip:String = "sys_equip.txt";
		public static const sys_building:String = "sys_building.txt";
		public static const sys_shop:String = "sys_shop.txt";
		public static const sys_attr_name:String = "sys_attr_name.txt";
		public static const sys_title_player:String = "sys_title_player.txt";
		public static const sys_skill_effect:String = "sys_skill_effect.txt";
		public static const sys_estimate:String = "sys_estimate.txt";
		public static const sys_level_hero:String = "sys_level_hero.txt";
		public static const sys_hero_progress:String = "sys_hero_progress.txt";
		public static const sys_talent:String = "sys_talent.txt";
		public static const sys_lan:String = "sys_lan.txt";
		public static const sys_skill_mix:String = "sys_skill_mix.txt";
		public static const sys_force:String = "sys_force.txt";
		public static const sys_level_lord:String = "sys_level_lord.txt";
		public static const sys_drop:String = "sys_drop.txt";
		public static const sys_title_record:String = "sys_title_record.txt";
		public static const sys_math:String = "sys_match.txt";
		public static const sys_hero_queue:String = "sys_hero_queue.txt";
		public static const sys_buff:String = "sys_buff.txt";
		public static const sys_skill_wake:String = "sys_skill_wake.txt";
		public static const sys_task:String = "sys_task.txt";
		public static const sys_tips:String = "sys_tips.txt";
		public static const sys_Mail:String = "sys_mail.txt";
		public static const sys_hero_vice:String = "sys_hero_vice.txt";
		public static const sys_guide:String = "sys_guide.txt";
		public static const sys_activity:String = "sys_activity.txt";
		public static const sys_recharge_fytx:String = "sys_recharge_fytx.txt";
		public static const sys_activity_condition:String = "sys_activity_condition.txt";
		public static const sys_name:String = "sys_name.txt";
		public static const sys_lordbody:String = "sys_lordbody.txt";
		public static const sys_member:String = "sys_member.txt";
		public static const sys_unlock:String = "sys_unlock.txt";
		public static const pingbiziku:String = "pingbiziku.txt";
		public static const sys_recruit_hero:String="sys_recruit_hero.txt";
		public static const sys_sound:String="sys_sound.txt";
		public static const lang:String = "lang.txt";
		public static const sys_society_levelup:String = "sys_society_levelup.txt";
		public static const sys_hero_reset:String = "sys_hero_reset.txt";
		public static const sys_draw:String = "sys_draw.txt";
		public static const sys_draw_award:String = "sys_draw_award.txt";
		public static const sys_society_basic:String = "sys_society_basic.txt";
		public static const sys_society_cost:String = "sys_society_cost.txt";
		public static const sys_society_shop:String = "sys_society_shop.txt";
		/**
		 *	两种形式注册配置文件
		 *  1.App.configManager.regConfig(sys_hero,SysHero,"heroId");
			2.App.configManager.regConfig(sys_hero,SysHero,function(data:SysHero):Object {
				return data.heroId;
			});
		 */
		public function initConfig():void{
			App.configManager.regConfig(sys_tips,SysTips,"tipsId");
			App.configManager.regConfig(sys_hero,SysHero,"heroId");
			App.configManager.regConfig(sys_city,SysCity,"cityId");
			App.configManager.regConfig(sys_strategy,SysStrategy,"strId");
			App.configManager.regConfig(sys_timetake,SysTimeTake,"timeType");
			App.configManager.regConfig(sys_skill,SysSkill,"skillId");
			App.configManager.regConfig(sys_item,SysItem,"itemId");
			App.configManager.regConfig(sys_building,SysBuilding,function(data:SysBuilding):Object {
				return data.buildType + "_" + data.buildLevel;
			});
			App.configManager.regConfig(sys_strength, SysStrength, function(data:SysStrength):Object {
				return data.strengthColor + "_" + data.strengthLv;
			});
			App.configManager.regConfig(sys_equip, SysEquip, "equipId");
			App.configManager.regConfig(sys_attr_name,SysAttrName,"attrId");
			App.configManager.regConfig(sys_title_player, SysTitlePlayer, "titleId");
			App.configManager.regConfig(sys_skill_effect,SysSkillEffect,"effectId");
			App.configManager.regConfig(sys_estimate,SysEstimate,"estimate");
			App.configManager.regConfig(sys_shop,SysShop,"shopItemId");
			App.configManager.regConfig(sys_level_hero,SysLevelHero,"heroLevel");
			App.configManager.regConfig(sys_hero_progress,SysHeroProgress,function(data:SysHeroProgress):Object{
				return data.heroColor + "_" + data.heroStar;
			});
			App.configManager.regConfig(sys_talent,SysTalent,"talentId");
			App.configManager.regConfig(sys_lan,SysLan,"key");
			App.configManager.regConfig(sys_skill_mix,SysSkillMix,"mixSkillId");
			App.configManager.regConfig(sys_force,SysForce,"forceId");
			App.configManager.regConfig(sys_level_lord, SysLevelLord, "lordLevel");
			App.configManager.regConfig(sys_drop, SysDrop, "dropId");
			App.configManager.regConfig(sys_title_record, SysTitleRecord, "recordType");
			App.configManager.regConfig(sys_math, SysMath, "titleId");
			App.configManager.regConfig(sys_hero_queue,SysHeroQueue,"queueId");
			App.configManager.regConfig(sys_buff,SysBuff,"buffId");
			App.configManager.regConfig(sys_skill_wake,SkillWake,"wakeSkillId");
			App.configManager.regConfig(sys_task,SysTask,"taskId");
			App.configManager.regConfig(sys_Mail,SysMail,"mailID");
			App.configManager.regConfig(sys_hero_vice,SysVice,"viceHeroStar");
			App.configManager.regConfig(sys_draw, SysDraw, "drawId");
			App.configManager.regConfig(sys_draw_award, SysDrawAward, "drawAwardId");

			App.configManager.regConfig(sys_guide, SysGuide, function(data:SysGuide):Object{
				return data.guideId + "_" + data.guideStep + "_" + data.compensateStep;
			});

			App.configManager.regConfig(sys_activity,SysActivity,"activityId");
			App.configManager.regConfig(sys_recharge_fytx,SysRecharge,"rechargeId");
			App.configManager.regConfig(sys_activity_condition,SysActivityCondition,"activityType");
			App.configManager.regConfig(sys_name,SysName,"adjective");
			App.configManager.regConfig(sys_recruit_hero,SysRecruitData,"recruitHero");
			App.configManager.regConfig(sys_lordbody, SysLordbody, "lordBodyId");
			App.configManager.regConfig(sys_member,SysMember,"memberId");
			App.configManager.regConfig(sys_unlock,SysUnlock,"unlockId");
			App.configManager.regAnalysisFun(pingbiziku,function(str:String):Object{
				GameUtils.PINGBI=str;
			});
			App.configManager.regConfig(sys_sound,SysSound,"soundId");
			App.configManager.regConfig(sys_society_levelup,SysUnion,"allianceLv");
			App.configManager.regAnalysisFun(lang,Language.init);
			App.configManager.regConfig(sys_hero_reset ,SysHeroReset,"resetTime");
			App.configManager.regConfig(sys_society_basic ,Syssociety,"societyId");
			App.configManager.regConfig(sys_society_cost ,SysCost,"costId");
			App.configManager.regConfig(sys_society_shop ,SysUnionShop,"id");
		}
		
		public static const BATTLE_ANGER_DARK:String = "comp/zhandou/btn_nengliang.png";
		public static const BATTLE_ANGER_LIGHT:String = "comp/zhandou/h1.png";
		public static const FONT_BAOJI:int = 2;
		public static const FONT_SHANBI:int = 3;
		public static const FONT_SHIPO:int = 4;
		public static const FONT_RED:int = 5;
		public static const FONT_YELLOW:int = 6;
		public static const FONT_GREEN:int = 7;
		public static const FONT_TURN:int = 8;
		public static const FONT_CARD_FIGHT:int = 9;
		
		public static const BATTLE_JIAN:String = "comp/zhandou/jian.png";
		public static const BATTLE_SPEED:String = "comp/zhandou/z_";
		
		public function initPng():void{
			App.pngManager.regPng(FONT_BAOJI ,"comp/zhandou/baoji.png");
			App.pngManager.regPng(FONT_SHANBI ,"comp/zhandou/shanbi.png");
			App.pngManager.regPng(FONT_SHIPO ,"comp/zhandou/shipo.png");
			App.pngManager.regPng(FONT_RED ,"comp/zhandou/r");
			App.pngManager.regPng(FONT_YELLOW ,"comp/zhandou/y");
			App.pngManager.regPng(FONT_GREEN ,"comp/zhandou/g");
			App.pngManager.regPng(FONT_TURN ,"comp/zhandou/shu_");
			App.pngManager.regPng(FONT_CARD_FIGHT,"comp/G/k_");
		}
		
		public static function isFaceBook():Boolean{
			return App.configJson["platformId"] == "1003";
		}
		
		public static function isFlySDK():Boolean{
			return App.configJson["platformId"] == "1002";
		}
		
		public static function isWeb():Boolean{
			return App.configJson["platformId"] == "1001";
		}
		
		public static function isQunHei():Boolean{
			return App.configJson["platformId"] == "1004";
		}
		
		public static function isXuYang():Boolean{
			return App.configJson["platformId"] == "1005";
		}
		
		public static function is360():Boolean{
			return App.configJson["platformId"] == "1006";
		}
		
		public static function getVer():String{
			return getConfig("ver"); 
		}
		
		public static function getConfig(str:String):String{
			var pid:String = App.configJson["platformId"];
			return App.configJson[pid][str];
		}
	}
}
