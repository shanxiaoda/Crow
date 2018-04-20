package game.base.manager
{
	import game.App;
	import game.base.GameLoader;
	import game.base.Map;
	import game.base.MyEvent;
	import game.base.entity.OpenPanelData;
	import game.base.entity.PanelData;
	import game.mvc.Mediator;
	
	import laya.display.Sprite;
	import laya.net.Loader;
	import laya.ui.Dialog;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class OpenDialogManager
	{
		public var manager:DialogResManager = new DialogResManager();
		
		private var isLoading:Boolean = false;
		
		public function OpenDialogManager() {
			
		}
		
		private static var dialogMap:Object = {};
		public function regDialog(dialogStr:String, panelClass:Class, resName:String, mediatorClass:Class = null):void{
			var panelObject:PanelData = new PanelData();
			panelObject.panelKey = dialogStr;
			panelObject.panelClass = panelClass;
			panelObject.mediatorClass = mediatorClass;
			panelObject.resName = resName;
			dialogMap[dialogStr] = panelObject;
		}
		
		private static var doubleDialogMap:Object = {};
		private function regDoubleDialog(panel1:String,panel2:String):void{
			Map.putClass(doubleDialogMap,panel1,Array).push(panel2);
			Map.putClass(doubleDialogMap,panel2,Array).push(panel1);
		}
		
		/**
		 *  
		 * @param dialogClass
		 * @param autoClose
		 * @param popup
		 * @param nextFrameShow
		 * 这种是弹出简单的提示窗口那种 没有mediator
		 */
		public function showMiniDialog(dialogClass:Class, autoClose:Boolean = false, popup:Boolean= false, nextFrameShow:Boolean= false):Sprite {
			for (var i:int = 0; i < Dialog.manager.numChildren; i++) {
				var dialog:Dialog = Dialog.manager.getChildAt(i) as Dialog;
				if( dialog is dialogClass ){
					if( autoClose ){
						dialog.close();
					}
					return dialog;
				}
			}
			var dialog1:Dialog = new dialogClass();
			if( nextFrameShow ){
				Laya.timer.callLater(this,nextShow,[dialog1,popup]);
			}else{
				nextShow(dialog1,popup);
			}
			return dialog1;
		}
		
		private function nextShow(dialog:Dialog,popup:Boolean):void{
			if( popup ){
				dialog.popup();
			}else{
				dialog.show();
			}
		}
		
		/**
		 * 根据字符串打开面板 这应该是最常用的
		 * @param panelStr 
		 * @param data
		 */
		public function openDialogByStr(panelStr:String,data:Object = null):void{
			var panelObject:PanelData = dialogMap[panelStr];
			var openPanelData:OpenPanelData = new OpenPanelData(panelStr,data);
			this.open(panelObject,openPanelData);
		}
		
		private function open(obj:PanelData,data:OpenPanelData):void {
			var dialog:Dialog = Dialog.manager.getChildByName(obj.panelKey) as Dialog;
			if( dialog ) {
				if( data.autoCLose  ){
					dialog.close();
				}
				return;
			}
			if( isLoading && obj.resName ){
				return;
			}
			isLoading = true;
			var resUrl:String = getResUrl(obj.resName);
			if( obj.resName == null || Loader.getRes( resUrl ) ){
				loadOver(obj,data);
			}else{
				Laya.loader.load( resUrl , Handler.create(this,loadOver,[obj,data]) );
				App.eventManager.event(MyEvent.LOAD_PANEL_RES_START);
			}
		}
		
		public static function getResUrl( fileName:String ):String{
			return App.gameLoader.getUrl(GameLoader.ATLAS,fileName + ".atlas") as String;
		}
		
		private function loadOver(obj:PanelData,openPanelData:OpenPanelData):void {
			App.eventManager.event(MyEvent.LOAD_PANEL_RES_OVER);
			manager.open(obj.resName,obj.panelClass);
			var data:Object = openPanelData.data;
			isLoading = false;
			var panel:Dialog = new obj.panelClass();
			panel.name = obj.panelKey;
			panel.tag = data;
			if( obj.mediatorClass ){
				var panelMediator:Mediator = new obj.mediatorClass(panel,data) as Mediator;
			}
			var arr:Array = doubleDialogMap[obj.panelKey];
			if( arr == null ){
				this.exeOpen(panel,openPanelData);
				return;
			}
			for (var i:int = 0; i < arr.length; i++) {
				var dialog:Dialog = Dialog.manager.getChildByName(arr[i]) as Dialog;
				if( dialog ){
					var wid:int = ( dialog.width + panel.width ) / 2;
					var stageWid:int = Laya.stage.width / 2;
					var dialogX:int = stageWid - wid;
					var dialogY:int = ( Laya.stage.height - dialog.height ) / 2;
					panel.popupEffect = null;
					this.exeOpen(panel,openPanelData);
					panel.x = dialogX + dialog.width;
					Tween.to(dialog,{x:dialogX,y:dialogY},100);
					return;
				}
			}
			this.exeOpen(panel,openPanelData);
		}
		
		private function exeOpen(dialog:Dialog,openPanelData:OpenPanelData):void{
			dialog.popupEffect = null;
			dialog.closeEffect = null;
			if( openPanelData && openPanelData.haveBlackMask ){
				dialog.popup();
			}else{
				dialog.show();
			}
			//MySound.playSound("OpenUI",MySound.UI);
		}
	}
}