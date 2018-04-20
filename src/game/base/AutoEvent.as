package game.base
{
	import laya.display.Sprite;
	import laya.events.Event;
	import game.App;

	public class AutoEvent
	{
		private var arr:Array = [];
		public function AutoEvent(sprite:Sprite) {
			sprite.on(Event.DISPLAY,this,disFun);
			sprite.on(Event.UNDISPLAY,this,undisFun);
		}
		
		private function undisFun():void {
			for (var i:int = 0; i < arr.length; i+=3) {
				App.eventManager.off(arr[i],arr[i+1],arr[i+2]);
			}
		}
		
		private function disFun():void {
			for (var i:int = 0; i < arr.length; i+=3) {
				App.eventManager.on(arr[i],arr[i+1],arr[i+2]);
			}
		}
		
		public function add(type:String,caller:*,listener:Function):void{
			arr.push(type,caller,listener);
		}
	}
}