package game.base.entity
{
	public class DialogResData {
		public var time:int;
		public var classArr:Array = [];
		
		public function addClass(panelClass:Class):void{
			for (var i:int = 0; i < classArr.length; i++) {
				if( classArr[i] == panelClass ) {
					return;
				}
			}
			classArr.push(panelClass);
		}
	}
}