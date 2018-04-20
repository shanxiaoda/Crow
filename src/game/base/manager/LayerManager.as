package game.base.manager
{
	import laya.display.Sprite;
	import laya.ui.Dialog;

	public class LayerManager
	{
		public var sceneLayer:Sprite = new Sprite();
		public var tipsLayer:Sprite = new Sprite();
		
		public function LayerManager() {
			this.init();
		}
		
		public function init():void{
			Dialog.manager.zOrder = 0;
			Laya.stage.addChild(sceneLayer);
			Laya.stage.addChild(Dialog.manager);
			Laya.stage.addChild(tipsLayer);
		}
	}
}