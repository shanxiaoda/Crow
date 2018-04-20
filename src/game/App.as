package game
{
	import game.base.GameLoader;
	import game.base.GameServer;
	import game.base.IGameInit;
	import game.base.LoadUIJSON;
	import game.base.MyEvent;
	import game.base.manager.LayerManager;
	import game.base.manager.OpenDialogManager;
	import game.base.manager.SceneManager;
	import game.mvc.Action;
	import game.mvc.Command;
	import game.mvc.CommandManager;
	import game.mvc.Session;
	
	import laya.display.Stage;
	import laya.events.EventDispatcher;
	import laya.net.HttpRequest;
	import laya.utils.Browser;
	import laya.webgl.WebGL;

	public class App
	{
		public static var eventManager:EventDispatcher = new EventDispatcher();
		public static var gameServer:GameServer = new GameServer();
		public static var dialogManager:OpenDialogManager = new OpenDialogManager();
		public static var gameLoader:GameLoader = new GameLoader();
		public static var commandManager:CommandManager = new CommandManager();
		public static var sceneManager:SceneManager = new SceneManager();
		public static var layerManager:LayerManager = new LayerManager();
		public static var loadUiJson:LoadUIJSON = new LoadUIJSON();
		
		/**
		 * 默认会对action session command全部进行注册 
		 */
		public function App() {
			
		}
		
		/**
		 * @param initClass
		 * 实现类必须实现IGameInit
		 */
		public static function INIT(initClass:Class):void{
			var gameInit:IGameInit = new initClass();
			gameInit.initAction();
			gameInit.initSession();
			App.initInjection();
			gameInit.initCommand();
			gameInit.initDialog();
			gameInit.initDoublePanel();
			gameInit.initScence();
			gameInit.initGameLoader();
			Browser.window.onerror = App.errorFun;
		}
		
		/**
		 * 常规开发设置 
		 */
		public static function DevelopmentSettings():void{
			Config.atlasEnable = false;
			Laya.alertGlobalError = true;
			if( Browser.onPC ){
				Laya.init(Browser.clientWidth,Browser.clientHeight,WebGL);
				//Laya.init(960,640,WebGL);
				Laya.stage.scaleMode = Stage.SCALE_FIXED_AUTO;
				trace( Browser.clientWidth,Browser.clientHeight );
			}else {
				Laya.init(Browser.width , Browser.height ,WebGL);
				Laya.stage.scaleMode = Stage.SCALE_FULL;
				Laya.stage.screenMode = Stage.SCREEN_HORIZONTAL;	
			}
			Laya.stage.alignH = Stage.ALIGN_LEFT;
			Laya.stage.alignV = Stage.ALIGN_TOP;
			Laya.stage.bgColor = "#000000";
		}
		
		public static function errorFun(msg:String, url:String, line:String, column:String, detail:*):void{
			if( errorUrl == null ){
				return;
			}
			var json:Object = {};
			json.msg = msg;
			json.line = line;
			json.column = column;
			json.detail = detail;
			var http:HttpRequest = new HttpRequest();
			http.send(errorUrl, JSON.stringify(json) , "post", 'text');
		}
		
		private static var errorUrl:String = null;
		public static function SetErrorCollectionUrl(errorUrl:String):void{
			App.errorUrl = errorUrl;
		}
		
		private static var CMDMap:Object = {};
		public static function regCMD(command:String,commandClass:Class):void{
			CMDMap[command] = commandClass;
		}
		
		public static function exeCMD(commandClass:Class,data:Object = null):void {
			var cmd:Command = new commandClass() as Command;
			injOne(cmd);
			cmd.execute(data);
			cmd = null;
			commandClass = null;
		}
		
		public static function sendCMD(cmd:String,data:Object = null):void {
			exeCMD(CMDMap[cmd],data);
		}
		
		private static var actionMap:Object = {};
		public static function regAction(actionId:int,actionClass:Class):void {
			var action:Action = new actionClass();
			action.setActionId(actionId);
			actionMap[actionId] = action;
			regInjection( getInjectionName(action) , action );
		}
		
		public static function getAction(actionId:int):Action {
			return actionMap[actionId];
		}
		
		public static function regSession(sessionClass:Class):void {
			var session:Session = new sessionClass();
			regInjection( getInjectionName(session) , session );
		}
		
		/** @return 得到第一个字母小写的字符串  */
		public static function getInjectionName(instance:*):String{
			var str:String = getInstanceClassName(instance);
			return str.charAt(0).toLocaleLowerCase() + str.substr(1);
		}
		
		/**
		 * @param instance 得到类名
		 */
		public static function getInstanceClassName(instance:*):String{
			return instance["__proto__"]["__class"]["name"];
		}
		
		public static function getSession(key:String):Session{
			return injMap[key];
		}
		
		private static var injMap:Object = {};

		/**
		 * @param str
		 * @param obj
		 * 注册注入类
		 */
		public static function regInjection(str:String,obj:Object):void{
			injMap[str] = obj;
		}
		
		/** Action Session Command 都注册完毕后调用此方法 初始化注入 */
		public static function initInjection():void{
			for (var attribute:* in injMap) {
				injOne(injMap[attribute]);
			}
		}
		
		/** 给obj对象的所有属性注入  */
		public static function injOne(obj:Object):void {
			for (var str:String in obj) {
				if( obj[str] == null && injMap[str] ){
					obj[str] = injMap[str];
				}
			}
		}
	}
}