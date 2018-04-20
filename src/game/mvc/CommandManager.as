package game.mvc
{
	import game.App;

	public class CommandManager
	{
		private var orderCMDClassArr:Array = [];
		
		public function CommandManager(){
			
		}
		
		/**
		 * 按照顺序执行cmd 同一时刻只允许有一组
		 * @param orderCMDClassArr
		 *  数组里面是类 每个类必须继承 OrderCommand command执行完后调用nextstep方法
		 */
		public function exeOrderCMD(orderCMDClassArr:Array):void{
			orderCMDClassArr = orderCMDClassArr;
			App.eventManager.on(OrderCommand.ORDER_CMD_NEXT,this,executeOver);
			executeOne();
		}
		
		private function executeOver():void {
			if( orderCMDClassArr.length != 0 ){
				this.executeOne();
			}else{
				App.eventManager.off(OrderCommand.ORDER_CMD_NEXT,this,executeOver);
			}
		}
		
		private function executeOne():void{
			var cmd:Class = orderCMDClassArr.shift();
			App.exeCMD(cmd);
		}
	}
}