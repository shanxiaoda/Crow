package game.base
{
	import laya.net.URL;
	import laya.utils.Browser;
	import laya.utils.Handler;

	public class GameLoader
	{
		public static const ATLAS:String = "ATLAS";
		public static const PNG:String = "PNG";
		
		public static var isHttps:Boolean = false;
		private var typeMap:Object = {};
		
		public function GameLoader() {
			isHttps = (Browser.window.location.protocol == "https:");
		}
		
		public function setCDN(cdnRoot:String):void{
			URL.basePath = cdnRoot;
		}
		
		public function regPath(resType:String,path:String):void{
			typeMap[resType] = path;
		}
		
		public function load( resType:String,url:*, complete:Handler = null, progress:Handler = null, type:String = null, priority:int = 1, cache:Boolean = true, group:String = null, ignoreCache:Boolean = false):void{
			Laya.loader.load( this.getUrl(resType,url) ,complete,progress,type,priority,cache,group,ignoreCache);
		}
		
		/**
		 * @param resType
		 * @param url
		 * @return 
		 * 传字符串或者数组
		 */
		public function getUrl(resType:String,url:*):Object{
			var path:String = typeMap[resType]; 
			if ( url is Array ){
				var arr:Array = url as Array;
				for (var i:int = 0; i < arr.length; i++) {
					arr[i] = path + arr[i]; 
				}
				return url;
			}else{
				return path + url;
			}
		}
	}
}