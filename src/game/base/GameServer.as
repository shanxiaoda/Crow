package game.base
{
	import laya.events.Event;
	import laya.net.Socket;
	import laya.utils.Byte;
	import game.App;

	public class GameServer extends Socket
	{
		public var sendByte:Byte = new Byte();
		private var maoByte:Byte = new Byte();
		private var datalen:int = -1;
		private var receiveBa:ByteArray = new ByteArray();
		
		public function GameServer() {
			super(null,0,ByteArray);
			this.endian = Socket.LITTLE_ENDIAN;
			sendByte.endian = this.endian;
			receiveBa.endian = this.endian;
			maoByte.endian = this.endian;
			
			this.on(Event.OPEN,this,openFun);
			this.on(Event.MESSAGE,this,messageFun);
		}
		
		private function openFun():void {
			Laya.timer.loop(40 * 1000,this,heartFun);
		}
		
		private function heartFun():void {
			sendByte.clear();
			sendByte.writeInt32(0);
			this.sendToServer();
		}
		
		private function messageFun(message:*=null):void {
			input.position = 0;
			while(input.bytesAvailable){
				if(datalen<0){
					if(input.bytesAvailable>=5){
						input.readByte();
						datalen = input.readInt();
					}
				}
				else{
					if(input.bytesAvailable>=datalen){
						receiveBa.clear();
						input.readBytes(receiveBa,0,datalen);
						datalen = -1;
						receiveBa.position = 0;
						this.exeAction(receiveBa);
					}else{
						break;
					}
				}
			}
		}
		
		public function sendToServer():void {
			maoByte.writeInt32(sendByte.length);
			this.send(maoByte.buffer);
			this.send(sendByte.buffer);
			this.flush();
			maoByte.clear();
			sendByte.clear();
		}
		
		private function exeAction(ba:ByteArray):void{
			var actionId:int = ba.readInt();
			App.getAction(actionId).execute(ba);
		}
	}
}