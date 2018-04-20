package game.mvc
{
	import laya.utils.Byte;
	import game.App;
	import game.base.ByteArray;

	public class Sender
	{
		protected var byte:Byte;
		
		public function Sender() {
			byte = App.gameServer.sendByte;
		}
		
		public function putByte(value:int):void {
			byte.writeByte(value);
		}
		
		public function putInt(value:int):void {
			byte.writeInt32(value);
		}
		
		public function putUtf(value:String):void {
			byte.writeUTFString(value);
		}
		
		public function putLong(value:int):void {
			
		}
		
		public function start():void {
			byte.clear();
		}
		
		public function send():void {
			App.gameServer.sendToServer();
		}
		
		public static function getLong(ba:ByteArray):Number {
			return ba.readInt() * 10000000 + ba.readInt();
		}
		
		private var actionId:int;
		
		public function setActionId(actionId:int):void{
			this.actionId = actionId;
		}
		
		public function startByAction():void {
			this.start();
			this.putInt(this.actionId);
		}
	}
}