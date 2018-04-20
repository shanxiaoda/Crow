package game.base
{
	import laya.ui.View;
	import laya.utils.Handler;
	import game.App;

	public class LoadUIJSON
	{
		/** 可以加载json 也可以加载zip */
		public function LoadUIJSON() {
			
		}
		
		public function loadUIJSON(path:String):void{
			Laya.loader.load(path,new Handler(App,uijsonFun));
		}
		
		private function uijsonFun(json:JSON):void {
			View.uiMap = json;
			App.eventManager.event(MyEvent.UI_JSON_OVER);
		}
	}
}