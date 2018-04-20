package game.mvc
{
	import game.App;

	public class OrderCommand extends Command
	{
		public static const ORDER_CMD_NEXT:String = "ORDER_CMD_NEXT";
		
		public function OrderCommand() {
			super();
		}
		
		public function nextStep():void{
			App.eventManager.event(ORDER_CMD_NEXT);
		}
	}
}