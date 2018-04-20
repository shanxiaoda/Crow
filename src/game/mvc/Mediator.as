package game.mvc
{
	import laya.display.Sprite;
	import laya.ui.Dialog;
	import game.App;
	import game.base.AutoEvent;

	public class Mediator
	{
		public var sprite:Dialog;
		public var autoEvent:AutoEvent;
		
		public function Mediator(sprite:Sprite) {
			this.sprite = sprite as Dialog;
			App.injOne(this);
			autoEvent = new AutoEvent(sprite);
		}
	}
}