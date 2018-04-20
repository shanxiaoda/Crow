package game.base
{
	public class Map
	{
		public static function putClass(obj:Object, key:Object,valueClass:Class):*
		{
			if( obj[key] == null ){
				obj[key] = new valueClass();
			}
			return obj[key];
		}
		
		public static function putValue(obj:Object,key:Object,value:*):*
		{
			if( obj[key] == null ){
				obj[key] = value;
			}
			return obj[key];
		}
		
		public function remove(key1:Object):void{
			this[key1] = null;
			delete this[key1];
		}
	}
}