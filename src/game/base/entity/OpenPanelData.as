package game.base.entity
{
	public class OpenPanelData
	{
		public var autoCLose:Boolean = true;
		public var panelString:String;
		public var data:Object;
		public var haveBlackMask:Boolean = false;
		
		public function OpenPanelData(panelString:String,data:Object = null,autoClose:Boolean = true,haveBlackMask:Boolean = false) {
			this.panelString = panelString;
			this.data = data;
			this.autoCLose = autoClose;
			this.haveBlackMask = haveBlackMask;
		}
	}
}