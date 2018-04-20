package game.base.manager
{
	import game.App;
	
	import laya.display.Sprite;

	public class SceneManager
	{
		private var sceneMap:Object = {};
		private var currentSceneName:String = null;
		
		public function SceneManager() {
			
		}
		
		public function regScene(sceneName:String,sceneClass:Class):void{
			sceneMap[sceneName] = sceneClass;
		}
		
		public function setScene( sceneName:String ):void {
			if( currentSceneName == sceneName ){
				return;
			}
			var sceneClass:Class = sceneMap[sceneName];
			if( sceneClass == null ){
				return;
			}
			this.currentSceneName = sceneName;
			var sceneLayer:Sprite = App.layerManager.sceneLayer;
			sceneLayer.removeChildren();
			sceneLayer.addChild( new sceneClass() );
		}
	}
}