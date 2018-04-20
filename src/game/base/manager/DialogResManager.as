package game.base.manager
{
	import laya.display.Node;
	import laya.ui.Dialog;
	import laya.utils.Browser;
	import game.base.entity.DialogResData;
	import game.base.Map;

	public class DialogResManager
	{
		/** 几分钟不用 这个面板的资源就释放掉  */
		public static const DISPOSE_TIME:int = 10 * 60 * 1000;
		
		/** 每一分钟检测一次面板状态  */
		public static const CHECK_TIME:int = 60 * 1000;
		
		private var resMap:Map = new Map();
		
		public function DialogResManager() {
			Laya.timer.loop(CHECK_TIME,this,this.check);
		}
		
		public function open(resName:String,class1:Class):void{
			if( resName == null ) return;
			var data:DialogResData = Map.putClass(resMap,resName,DialogResData);
			data.time = -1;
			data.addClass(class1);
		}
		
		public function check():void{
			var now:Number = Browser.now();
			for (var resName:String in resMap) {
				var data:DialogResData = resMap[resName];
				if( data.time == -1 ){
					this.checkIsOpen(data);
				}else if( (now - data.time) > DISPOSE_TIME ){
					Laya.loader.clearRes( OpenDialogManager.getResUrl(resName) ,true );
					resMap.remove(resName);
				}
			}
		}
		
		public function checkIsOpen(data:DialogResData):void{
			for (var i:int = 0; i < data.classArr.length; i++) {
				var class1:Class = data.classArr[i] as Class;
				if( this.haveDialog(class1) ){
					return;
				}
			}
			data.time = Browser.now();
		}
		
		public function haveDialog(class1:Class):Boolean{
			for (var i:int = 0; i < Dialog.manager.numChildren; i++) {
				var node:Node = Dialog.manager.getChildAt(i);
				if( node is class1 ){
					return true;
				}
			}
			return false;
		}
	}
}