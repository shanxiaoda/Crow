package  game.base{
	import laya.utils.Byte;
	import laya.utils.ClassUtils;
	
	public class ByteArray extends Byte {
		public static const BIG_ENDIAN : String = "bigEndian";
		public static const LITTLE_ENDIAN : String = "littleEndian";
		private var _length:int = 0;
		private var _objectEncoding_:int;
		private var _position_:int = 0;
		private var _allocated_:int = 8;		
		private var _data_:*;//arrayBuffer
		private var _littleEndian_:Boolean = false;
		public var _byteView_:*;
		
		public function ByteArray():void {
			__JS__("this.___resizeBuffers(this._allocated_)");
		}
		
		
		override public function clear ():void {
			_strTable = [];
			_objTable = [];
			_traitsTable = [];
			_position_ = 0;
			length = 0;
		}
		
		override public  function ensureWrite (lengthToEnsure:int):void {
			if (this._length < lengthToEnsure) length = lengthToEnsure;
		}
		
		public function readBoolean ():Boolean {
			
			return (this.readByte () != 0);			
		}		
		
		override public function readByte ():int {
			
			return _data_.getInt8 (this._position_++);			
		}
		
		
		public function readBytes (bytes:ByteArray, offset:int = 0, length:int = 0):void 
		{
			if (offset < 0 || length < 0) {
				throw "Read error - Out of bounds";
			}
			
			if (length == 0) length = this._length-this._position_;
			
			bytes.ensureWrite (offset + length);
			
			bytes._byteView_.set (_byteView_.subarray(this._position_, this._position_ + length), offset);
			bytes.position = offset;
			
			this._position_ += length;
			if (bytes.position + length > bytes.length) bytes.length = bytes.position + length;
		}
		
		
		public function readDouble ():Number 
		{
			var double:Number = _data_.getFloat64 (this._position_, _littleEndian_);
			this._position_ += 8;
			return double;
		}
		
		
		public function readFloat ():Number {
			
			var float:Number = _data_.getFloat32 (this._position_, _littleEndian_);
			this._position_ += 4;
			return float;
		}
		
		private function readFullBytes (bytes:*, pos:int, len:int):void 
		{
			ensureWrite (len);
			for(var i:int = pos;i < pos + len;i++){
				_data_.setInt8 (this._position_++, bytes.get(i));
			}
		}
		
		public function readInt():int 
		{
			var tInt:int = _data_.getInt32 (this._position_, _littleEndian_);
			this._position_ += 4;
			return tInt;
		}
		
		
		public function readShort ():int 
		{
			var short:int = _data_.getInt16 (this._position_, _littleEndian_);
			this._position_ += 2;			
			return short;
		}
		
		
		public function readUnsignedByte ():int 
		{
			return _data_.getUint8 (this._position_++);
		}
		
		public function readUnsignedInt ():int 
		{
			var uInt:int = _data_.getUint32 (this._position_, _littleEndian_);
			this._position_ += 4;
			return int(uInt);//add by ch.ji 解决读取整数时读到负整数的问题
		}
		
		
		public function readUnsignedShort ():int 
		{
			var uShort:int = _data_.getUint16 (this._position_, _littleEndian_);
			this._position_ += 2;
			return uShort;
		}
		
		public function readLong():Number 
		{
			return readInt() * 10000000 + readInt();
		}
		
		public function readUTF ():String 
		{
			return readUTFBytes (readUnsignedShort ());
		}		
		
		public function readUnicode (length:int):String
		{
			var value:String = "";
			var max:int = this._position_ + length;
			var c1:int,c2:int;
			while (this._position_ < max) {
				c2 = _byteView_[this._position_++];
				c1 = _byteView_[this._position_++];
				value+=String.fromCharCode(c1<<8 | c2);
			}
			return value;
		}
		
		public function readMultiByte (length:int, charSet:String):String 
		{
			if(charSet=="UNICODE" || charSet=="unicode")
			{
				return readUnicode(length);
			}
			return readUTFBytes (length);
		}
		
		override public function readUTFBytes (len:int = -1):String 
		{
			var value:String = "";
			var max:int = this._position_ + len;
			var c:int, c2:int, c3:int;
			// utf8-encode
			while (this._position_ < max) {
				
				c = _data_.getUint8 (this._position_++);
				
				if (c < 0x80) {
					//if(c==0) flash的原生
				   if (c !=0)
				   {
				   	value +=String.fromCharCode (c);
				   }
					
					
				} else if (c < 0xE0) {
					
					value += String.fromCharCode (((c & 0x3F) << 6) | (_data_.getUint8 (this._position_++) & 0x7F));
					
				} else if (c < 0xF0) {
					
					c2 = _data_.getUint8 (this._position_++);
					value += String.fromCharCode (((c & 0x1F) << 12) | ((c2 & 0x7F) << 6) | (_data_.getUint8 (this._position_++) & 0x7F));
					
				} else {
					
					c2 = _data_.getUint8 (this._position_++);
					c3 = _data_.getUint8 (this._position_++);
					value += String.fromCharCode (((c & 0x0F) << 18) | ((c2 & 0x7F) << 12) | ((c3 << 6) & 0x7F) | (_data_.getUint8 (this._position_++) & 0x7F));
				}
			}	
			return value;
		}
		
		
		public function toString ():String 
		{
			var cachePosition:int = _position_;
			_position_ = 0;
			var value:String = readUTFBytes (length);
			_position_ = cachePosition;
			return value;
		}
		
		public function writeBoolean (value:Boolean):void
		{
			writeByte (value ? 1 : 0);
		}
		
		override public function writeByte(value:int):void 
		{
			ensureWrite (this._position_ + 1);
			_data_.setInt8 (this._position_, value);
			this._position_ += 1;
		}
		
		public function writeBytes (bytes:ByteArray, offset:uint = 0, length:uint = 0):void 
		{
			if (offset < 0 || length < 0) throw "writeBytes error - Out of bounds";
			if( length == 0 ) length = bytes.length-offset;
			ensureWrite (this._position_ + length);
			__JS__("this._byteView_.set(bytes._byteView_.subarray (offset, offset + length), this._position_)");
			this._position_ += length;
		}
		
		override public function writeArrayBuffer(arraybuffer:*, offset:uint = 0,length:uint = 0):void
		{
			if (offset < 0 || length < 0) throw "writeArrayBuffer error - Out of bounds";
			if( length == 0 ) length = arraybuffer.byteLength-offset;
			ensureWrite (this._position_ + length);
			var uint8array:* = __JS__("new Uint8Array(arraybuffer)");
			__JS__("this._byteView_.set(uint8array.subarray (offset, offset + length), this._position_)");
			this._position_ += length;
		}		
		
		public function writeDouble (x:Number):void 
		{
			ensureWrite (this._position_ + 8);
			_data_.setFloat64 (this._position_, x, _littleEndian_);
			this._position_ += 8;
		}
		
		
		public function writeFloat (x:Number):void 
		{
			ensureWrite (this._position_ + 4);
			_data_.setFloat32 (this._position_, x, _littleEndian_);
			this._position_ += 4;
		}
		
		
		public function writeInt (value:int):void
		{
			__JS__("this.ensureWrite (this._position_ + 4)");
			__JS__("this._data_.setInt32 (this._position_, value, this._littleEndian_)");
			this._position_ += 4;
		}
		
		
		public function writeShort (value:int):void
		{
			ensureWrite (this._position_ + 2);
			_data_.setInt16 (this._position_, value, _littleEndian_);
			this._position_ += 2;
		}
		
		
		public function writeUnsignedInt (value:int):void 
		{
			ensureWrite (this._position_ + 4);
			_data_.setUint32 (this._position_, value, _littleEndian_);
			this._position_ += 4;
		}
		
		
		public function writeUnsignedShort (value:int):void 
		{
			ensureWrite (this._position_ + 2);
			_data_.setUint16 (this._position_, value, _littleEndian_);
			this._position_ += 2;
		}
		
		
		public function writeUTF (value:String):void 
		{
			value = value + "";
			writeUnsignedShort (_getUTFBytesCount(value));writeUTFBytes (value);
		}
		
		public function writeUnicode(value:String):void		
		{
			value = value + "";
			ensureWrite (this._position_ + value.length*2);
			var c:int;
			for(var i:int=0,sz:int=value.length;i<sz;i++)
			{
				c=value.charCodeAt(i);
				_byteView_[this._position_++]=c&0xff;
				_byteView_[this._position_++]=c>>8;
			}
		}
		
		public function writeMultiByte(value:String,charSet:String):void
		{
			value = value + "";
			if(charSet=="UNICODE" || charSet=="unicode")
			{
				return writeUnicode(value);
			}
			writeUTFBytes(value);
		}
		
		override public function writeUTFBytes (value:String):void 
		{
			// utf8-decode
			value = value + "";
			ensureWrite(this._position_ + value.length*4);
			for (var i:int = 0, sz:int=value.length; i < sz; i++) {
				var c:int = value.charCodeAt(i);
				
				if (c <= 0x7F) {
					writeByte (c);
				} else if (c <= 0x7FF) {
					//这里要优化,胡高，writeShort,后面也是
					writeByte (0xC0 | (c >> 6));
					writeByte (0x80 | (c & 63));
					
				} else if (c <= 0xFFFF) {
					
					writeByte(0xE0 | (c >> 12));
					writeByte(0x80 | ((c >> 6) & 63));
					writeByte(0x80 | (c & 63));
					
				} else {
					
					writeByte(0xF0 | (c >> 18));
					writeByte(0x80 | ((c >> 12) & 63));
					writeByte(0x80 | ((c >> 6) & 63));
					writeByte(0x80 | (c & 63));
				}
			}
			this.length = this._position_;
		}
		
		private function __fromBytes (inBytes:*):void 
		{
			_byteView_ = __JS__("new Uint8Array(inBytes.getData ())");
			length = _byteView_.length;
			_allocated_ = length;
		}
		
		public function __get (pos:int):int 
		{
			return _data_.getUint8(pos);
		}
		
		private function _getUTFBytesCount (value:String):int 
		{
			var count:int = 0;
			// utf8-decode
			value = value + "";
			for (var i:int = 0,sz:int=value.length;i < sz;i++) {
				
				var c:int = value.charCodeAt(i);
				
				if (c <= 0x7F) {
					
					count += 1;
					
				} else if (c <= 0x7FF) {
					
					count += 2;
					
				} else if (c <= 0xFFFF) {
					
					count += 3;
					
				} else {
					count += 4;
				}
			}
			return count;
		}
		
		public function _byteAt_(index:int):int
		{
			return _byteView_[index];
		}
		
		public function _byteSet_(index:int,value:*):void
		{
			ensureWrite (index+ 1);
			_byteView_[index]=value;
			//this._position_+= 1;
		}
		
		public function uncompress(algorithm:String = "zlib"):void
		{
			__JS__("var inflate = new Zlib.Inflate(this._byteView_)");
			__JS__("this._byteView_ = inflate.decompress()");
			__JS__("this._data_ = new DataView(this._byteView_ .buffer);");
			_allocated_=_length=_byteView_.byteLength;
			_position_=0;
		}
		
		public function compress(algorithm:String = "zlib"):void
		{
			__JS__("var deflate = new Zlib.Deflate(this._byteView_)");
			__JS__("this._byteView_ = deflate.compress()");	
			__JS__("this._data_ = new DataView(this._byteView_.buffer);");
			_position_=_allocated_=_length=_byteView_.byteLength;	
		}
		
		private function ___resizeBuffers(len:int):void 
		{
			try
			{
				var newByteView:* = __JS__("new Uint8Array(len)");
				if (_byteView_!= null)
				{
					if (_byteView_.length <= len) newByteView.set (_byteView_);
					else newByteView.set (_byteView_.subarray (0, len));
				}
				this._byteView_ = newByteView;
				this._data_ = __JS__("new DataView(newByteView.buffer)");
			}
			catch (err:*)
			{
				throw "___resizeBuffer err:" + len;
			}
			
		}
		
		
		override public function __getBuffer ():ArrayBuffer
		{
			this._data_.buffer.byteLength = this.length;
			return _data_.buffer;
		}
		
		public function __set (pos:int, v:int):void 
		{
			_data_.setUint8 (pos, v);
		}
		
		public static function __ofBuffer (buffer:*):ByteArray
		{
			var bytes:* =__JS__("new ByteArray ()");
			bytes.length = bytes.allocated = buffer.byteLength;
			bytes.data = __JS__("new DataView(buffer)");
			bytes.byteView = __JS__("new Uint8Array(buffer)");
			return bytes;
		}
		
		public function setUint8Array(data:*):void
		{
			this._byteView_ = data;
			this._data_ = __JS__("new DataView(data.buffer)");
			_length=data.byteLength;
			_position_=0;
		}
		
		// Getters & Setters
		
		override public function get bytesAvailable ():int 
		{ 
			return length - _position_;
		}
		
		
		override public function get endian ():String 
		{
			return _littleEndian_ ? LITTLE_ENDIAN : BIG_ENDIAN;
		}
		
		
		override public function set endian(endianStr:String):void 
		{
			_littleEndian_ = (endianStr == LITTLE_ENDIAN);
		}
		
		override public function set length (value:int):void 
		{
			/*if (_allocated_ < value)
				___resizeBuffer (_allocated_ = Math.floor (Math.max (value, _allocated_ * 2)));
			else if (_allocated_ > value)*/
				___resizeBuffers (_allocated_ = value);
			_length = value;
		}
		
		override public function get length():int
		{
			return _length;
		}
		
		public function get position():int
		{
			return _position_;
		}
		
		public function set position(pos:int):void
		{
			if (pos < _length)
				_position_ = pos < 0?0:pos;
			else{
				_position_ = pos;
				length = pos;
			}
		}
		
		//-------------------------------------------------------------------------------------
		public static const UNDEFINED_TYPE:int  = 0;
		public static const NULL_TYPE:int       = 1;
		public static const FALSE_TYPE:int      = 2;
		public static const TRUE_TYPE:int       = 3;
		public static const INTEGER_TYPE:int    = 4;
		public static const DOUBLE_TYPE:int     = 5;
		public static const STRING_TYPE:int     = 6;
		public static const XML_TYPE:int        = 7;
		public static const DATE_TYPE:int       = 8;
		public static const ARRAY_TYPE:int      = 9;
		public static const OBJECT_TYPE:int     = 10;
		public static const AVMPLUSXML_TYPE:int = 11;
		public static const BYTEARRAY_TYPE:int  = 12;
		
		public static const EMPTY_STRING:String = "";
		
		private var _strTable:Array;// = [];
		private var _objTable:Array;// = [];
		private var _traitsTable:Array;//=[];
		/**
		 * Internal use only.
		 * @exclude
		 */
		public static const UINT29_MASK:int = 0x1FFFFFFF; // 2^29 - 1
		
		/**
		 * The maximum value for an <code>int</code> that will avoid promotion to an
		 * ActionScript Number when sent via AMF 3 is 2<sup>28</sup> - 1, or <code>0x0FFFFFFF</code>.
		 */
		public static const INT28_MAX_VALUE:int = 0x0FFFFFFF; // 2^28 - 1
		
		/**
		 * The minimum value for an <code>int</code> that will avoid promotion to an
		 * ActionScript Number when sent via AMF 3 is -2<sup>28</sup> or <code>0xF0000000</code>.
		 */
		public static const INT28_MIN_VALUE:int = -268435456; // -2^28 in 2^29 scheme
		
		/** 从字节数组中读取一个以 AMF 序列化格式进行编码的对象 **/
		
		public function readObject():*
		{
			_strTable = [];
			_objTable = [];
			_traitsTable=[];
			return readObject2();
		}
		
		private function readObject2():*
		{
			//读取前8位  作为数据类型
			var type:int = readByte();
			return readObjectValue(type);
		}
		
		private function readObjectValue(type:int):*
		{
			var value:Object;
			switch (type)
			{
				case NULL_TYPE:
					break;
				case STRING_TYPE:
					value = __readString();
					break;
				case INTEGER_TYPE:
					value = readInterger();
					break;
				case FALSE_TYPE:
					value = false;
					break;
				case TRUE_TYPE:
					value = true;
					break;
				case OBJECT_TYPE:
					value = readScriptObject();
					break;
				case ARRAY_TYPE:
					value = readArray();
					break;
				case DOUBLE_TYPE:
					value = readDouble();
					break;
				case BYTEARRAY_TYPE:
					value = readByteArray();
					break;
				default:
					// Unknown object type tag {type}
					//trace("Unknown object type tag!!!" + type);
			}
			
			return value;
		}
		public function readByteArray():ByteArray
		{
			var ref:int = readUInt29();
			
			if ((ref & 1) == 0)
			{
				return getObjRef(ref >> 1) as ByteArray;
			}
			else
			{
				var len:int = (ref >> 1);
				
				var ba:ByteArray=new ByteArray();
				_objTable.push(ba);
				readBytes(ba,0,len);		
				return ba;
			}
		}
		
		public function readInterger():int
		{
			var i:int = readUInt29();
			// Symmetric with writing an integer to fix sign bits for negative values...
			i = (i << 3) >> 3;
			return parseInt(i + "");
		}
		
		private function getStrRef(ref:int):String
		{
			return _strTable[ref];
		}
		
		private function getObjRef(ref:int):Object
		{
			return _objTable[ref];
		}
		
		private function __readString():String
		{
			var ref:int = readUInt29();
			
			if ((ref & 1) == 0)
			{
				return getStrRef(ref >> 1);
			}
			
			var len:int = (ref >> 1);
			
			// writeString() special cases the empty string
			// to avoid creating a reference.
			if (0 == len)
			{
				return EMPTY_STRING;
			}
			
			var str:String = readUTFBytes(len);
			_strTable.push(str);
			return str;
		}
		private function readTraits(ref:int):*
		{
			var ti:*;
			if ((ref & 3) == 1)
			{
				ti= getTraitReference(ref >> 2);
				return ti.propoties?ti:{obj:{}};
			}
			else
			{
				var externalizable:Boolean = ((ref & 4) == 4);
				var isDynamic:Boolean = ((ref & 8) == 8);
				var count:int = (ref >> 4); /* uint29 */
				var className:String = __readString();
				ti = {};
				ti.className = className;
				ti.propoties =[];
				ti.dynamic = isDynamic;
				ti.externalizable = externalizable;
				//ti.obj={};
				if(count>0)
				{
					for(var i:int=0;i<count;i++)
					{
						var  propName:String = __readString();
						ti.propoties.push(propName);
					}		
				}
				_traitsTable.push(ti);
				//todo LIST
				return ti;
			}
			
		}
		
		protected function readScriptObject():Object
		{
			var ref:int = readUInt29();
			if ((ref & 1) == 0)
			{
				return getObjRef(ref >> 1);
			}
			else
			{
				var objref:Object=readTraits(ref);
				var className:String = objref.className;
				var externalizable:Boolean = objref.externalizable;
				var obj:* ;
				var propName:String;
				var pros:String=objref.propoties;
				if(className&&className!="")
				{
//					var rst:*=getClassByAlias(className);
					var rst:*=ClassUtils.getRegClass(className);
					if(rst)
					{
						obj=new rst();
					}else
					{
						obj={};
					}
					
				}else
				{
					obj={};
				}
				
				_objTable.push(obj);
				if(pros)
				{
					for(var d:int=0;d<pros.length;d++)
					{
						obj[pros[d]]=readObject2();
//						//trace("read p:"+pros[d]+" v:"+obj[pros[d]]);
					}
				}
				if(objref.dynamic)
				{
					for (; ;)
					{
						propName = __readString();
						if (propName == null || propName.length == 0) break;
						obj[propName] = readObject2();
					}
				}
				
				return obj;
			}
			
		}
		protected function readArray():Object
		{
			var ref:int = readUInt29();
			
			if ((ref & 1) == 0)
			{
				return getObjRef(ref >> 1);
			}
			var obj:Object = null;
			var count:int = (ref >> 1);
			
			var propName:String;
			for (; ;)
			{
				propName = __readString();
				if (propName == null || propName.length == 0) break;
				if (obj == null)
				{
					obj = {};
					_objTable.push(obj);
				}
				obj[propName] = readObject2();
			}
			
			if (obj == null)
			{
				obj = [];
				_objTable.push(obj);
				var i:int = 0;
				for (i = 0; i < count; i++)
				{
					obj.push(readObject2());
				}
			} else {
				for (i = 0; i < count; i++)
				{
					obj[i.toString()] = readObject2();
				}
			}
			
			//_objTable.push(obj);
			return obj;
		}
		
		
		/**
		 * AMF 3 represents smaller integers with fewer bytes using the most
		 * significant bit of each byte. The worst case uses 32-bits
		 * to represent a 29-bit number, which is what we would have
		 * done with no compression.
		 * <pre>
		 * 0x00000000 - 0x0000007F : 0xxxxxxx
		 * 0x00000080 - 0x00003FFF : 1xxxxxxx 0xxxxxxx
		 * 0x00004000 - 0x001FFFFF : 1xxxxxxx 1xxxxxxx 0xxxxxxx
		 * 0x00200000 - 0x3FFFFFFF : 1xxxxxxx 1xxxxxxx 1xxxxxxx xxxxxxxx
		 * 0x40000000 - 0xFFFFFFFF : throw range exception
		 * </pre>
		 *
		 * @return A int capable of holding an unsigned 29 bit integer.
		 * @throws IOException
		 * @exclude
		 */
		protected function readUInt29():int
		{
			var value:int;
			
			// Each byte must be treated as unsigned
			var b:int = readByte() & 0xFF;
			
			if (b < 128)
			{
				return b;
			}
			
			value = (b & 0x7F) << 7;
			b = readByte() & 0xFF;
			
			if (b < 128)
			{
				return (value | b);
			}
			
			value = (value | (b & 0x7F)) << 7;
			b = readByte() & 0xFF;
			
			if (b < 128)
			{
				return (value | b);
			}
			
			value = (value | (b & 0x7F)) << 8;
			b = readByte() & 0xFF;
			
			return (value | b);
		}
		
		//============================================================================================
		
		public function writeObject(o:*):void
		{
			_strTable = [];
			_objTable = [];
			_traitsTable=[];
			writeObject2(o);
		}
		
		public function writeObject2(o:*):void
		{
			if(o == null)
			{
				writeAMFNull();
				return;
			}
			var type:String = typeof(o);
			if("string"===type)
			{
				writeAMFString(o);
			}
			else if("boolean"===type)
			{
				writeAMFBoolean(o);
			}
			else if("number"===type)
			{
				if(String(o).indexOf(".")!=-1)
				{
					writeAMFDouble(o);
				}
				else
				{
					writeAMFInt(o);
				}
			}
			else if("object"===type)
			{
				if(o is Array)
				{
					writeArray(o);
				}
				else if(o is ByteArray)
				{
					writeAMFByteArray(o);
				}
				else
				{
					writeCustomObject(o);
				}
			}
		}
		protected function   writeAMFNull():void
		{
			writeByte(NULL_TYPE);
		}
		protected function writeAMFString(s:String):void
		{
			writeByte(STRING_TYPE);
			writeStringWithoutType(s);
		}
		
		protected function writeStringWithoutType(s:String):void
		{
			if (s.length == 0)
			{
				// don't create a reference for the empty string,
				// as it's represented by the one byte value 1
				// len = 0, ((len << 1) | 1).
				writeUInt29(1);
				return;
			}
			
			var ref:int=_strTable.indexOf(s);
			if(ref>=0)
			{
				writeUInt29(ref << 1);
			}else
			{
				var utflen:int = _getUTFBytesCount(s);
				writeUInt29((utflen << 1) | 1);
				writeUTFBytes(s);
				_strTable.push(s);
			}
			
		}
		
		protected function writeAMFInt(i:int):void
		{
			if (i >= INT28_MIN_VALUE && i <= INT28_MAX_VALUE)
			{
				// We have to be careful when the MSB is set, as (value >> 3) will sign extend.
				// We know there are only 29-bits of precision, so truncate. This requires
				// similar care when reading an integer.
				//i = ((i >> 3) & UINT29_MASK);
				i = i & UINT29_MASK; // Mask is 2^29 - 1
				writeByte(INTEGER_TYPE);
				writeUInt29(i);
			} else {
//				 Promote large int to a double
				writeAMFDouble(i);
			}
		}
		protected function writeAMFDouble(d:Number) :void
		{
			writeByte(DOUBLE_TYPE);
			writeDouble(d);
		}
		protected function writeAMFBoolean(b:Boolean):void
		{
			if (b)
				writeByte(TRUE_TYPE);
			else
				writeByte(FALSE_TYPE);
		}
		
		protected function writeCustomObject(o:Object):void
		{
			
			//写入类型8位字节
			writeByte(OBJECT_TYPE);
			
			//写标示引用或实体对象
			var refNum:int = _objTable.indexOf(o);
			if(refNum!=-1)
			{
				writeUInt29(refNum << 1);
			}
			else
			{
				_objTable.push(o);
				
				var traitsInfo:* = new Object();
				traitsInfo.className = getAliasByObj(o);
				traitsInfo.dynamic = false;
				traitsInfo.externalizable = false;
				traitsInfo.properties = [];
				
				for(var prop:String in o)
				{
					if(o[prop] is Function) continue;
					traitsInfo.properties.push(prop);
					traitsInfo.properties.sort();
				}
				
				var tRef:int=getTraitsInfoRef(_traitsTable,traitsInfo);
				var count:int=traitsInfo.properties.length;
				var i:int;
				if(tRef>=0)
				{
					writeUInt29((tRef << 2) | 1);
				}else
				{
					
					_traitsTable.push(traitsInfo);
					writeUInt29(3 | (traitsInfo.externalizable ? 4 : 0) | (traitsInfo.dynamic ? 8 : 0) | (count << 4));
					writeStringWithoutType(traitsInfo.className);
					
					for(i=0;i<count;i++)
					{
						writeStringWithoutType(traitsInfo.properties[i]);
					}
					
				}
				
				for(i=0;i<count;i++)
				{
				
					writeObject2(o[traitsInfo.properties[i]]);
//					//trace("write p:"+traitsInfo.properties[i]+" v:"+o[traitsInfo.properties[i]]);
				}
				
			}
			
		}
		
		public static function getTraitsInfoRef(arr:Array,ti:Object):int
		{
			var i:int,len:int=arr.length;
			for(i=0;i<len;i++)
			{
				if (equalsTraitsInfo(ti,arr[i])) return i;
			}
			return -1;
		}
		
		public static function equalsTraitsInfo(ti1:Object,ti2:Object):Boolean
		{
			if (ti1 == ti2)
			{
				return true;
			}
			if (!ti1.className===ti2.className)
			{
				return false;
			}
			
			if(ti1.properties.length != ti2.properties.length)
			{
				return false;
			}
			var len:int = ti1.properties.length;
			var prop:String;
			ti1.properties.sort();ti2.properties.sort();
			for(var i:int = 0;i<len;i++)
			{
				if(ti1.properties[i] != ti2.properties[i])
				{
					return false;
				}
			}
			return true;
		}
		
		/**
		 * 获取实例的注册别名
		 * @param obj
		 * @return 
		 */
		private function getAliasByObj(obj:*):String
		{
//			var tClassName:String=getQualifiedClassName(obj);
			var tClassName:String=ClassUtils.getRegClass(obj);
			if(tClassName==null || tClassName=="") return "";
//			var tClass:Class=getDefinitionByName(tClassName) as Class;
			var tClass:Class=ClassUtils.getClass(tClassName) as Class;
			if(tClass==null) return "";
			var tkey:String;
//			for(tkey in classDic)
//			{
//				if(classDic[tkey]==tClass)
//				{
//					return tkey;
//				}
//			}
			return "";
		}
		
		protected function writeArray(value:Array):void
		{
			writeByte(ARRAY_TYPE);
			var len:int = value.length;
			var ref:int = _objTable.indexOf(value);
			if(ref>-1)
			{
				writeUInt29(len<<1);
			}
			else
			{
				writeUInt29((len << 1) | 1);
				writeStringWithoutType(EMPTY_STRING);
				for (var i:int = 0; i < len; i++)
				{
					writeObject2(value[i]);
				}
				_objTable.push(value);
			}
		}
		protected function writeAMFByteArray(ba:ByteArray) :void
		{
			writeByte(BYTEARRAY_TYPE);
			var ref:int=_objTable.indexOf(ba);
			if(ref>=0)
			{
				writeUInt29(ref << 1);
			}else
			{
				var len:int=ba.length;
				// Write out an invalid reference, storing the length in the unused 28-bits.
				writeUInt29((len << 1) | 1);
				writeBytes(ba,0,len);
			}	
		}
		protected function writeMapAsECMAArray(o:Object):void
		{
			writeByte(ARRAY_TYPE);
			writeUInt29((0 << 1) | 1);
			var count:int,key:String;
			for (key in o)
			{
				count++;
				writeStringWithoutType(key);
				writeObject2(o[key]);
			}		
			writeStringWithoutType(EMPTY_STRING);
		}
		
		protected function writeUInt29(ref:int):void
		{
			// Represent smaller integers with fewer bytes using the most
			// significant bit of each byte. The worst case uses 32-bits
			// to represent a 29-bit number, which is what we would have
			// done with no compression.
			
			// 0x00000000 - 0x0000007F : 0xxxxxxx
			// 0x00000080 - 0x00003FFF : 1xxxxxxx 0xxxxxxx
			// 0x00004000 - 0x001FFFFF : 1xxxxxxx 1xxxxxxx 0xxxxxxx
			// 0x00200000 - 0x3FFFFFFF : 1xxxxxxx 1xxxxxxx 1xxxxxxx xxxxxxxx
			// 0x40000000 - 0xFFFFFFFF : throw range exception
			if (ref < 0x80)
			{
				// 0x00000000 - 0x0000007F : 0xxxxxxx
				writeByte(ref);
			} else if (ref < 0x4000) {
				// 0x00000080 - 0x00003FFF : 1xxxxxxx 0xxxxxxx
				writeByte(((ref >> 7) & 0x7F) | 0x80);
				writeByte(ref & 0x7F);
			} else if (ref < 0x200000) {
				// 0x00004000 - 0x001FFFFF : 1xxxxxxx 1xxxxxxx 0xxxxxxx
				writeByte(((ref >> 14) & 0x7F) | 0x80);
				writeByte(((ref >> 7) & 0x7F) | 0x80);
				writeByte(ref & 0x7F);
			} else if (ref < 0x40000000) {
				// 0x00200000 - 0x3FFFFFFF : 1xxxxxxx 1xxxxxxx 1xxxxxxx xxxxxxxx
				writeByte(((ref >> 22) & 0x7F) | 0x80);
				writeByte(((ref >> 15) & 0x7F) | 0x80);
				writeByte(((ref >> 8) & 0x7F) | 0x80);
				writeByte(ref & 0xFF);
			} else {
				// 0x40000000 - 0xFFFFFFFF : throw range exception
				//trace("Integer out of range: " + ref);
			}
		}
		/**
		 * @exclude
		 */
		protected function getTraitReference(ref:int):*
		{
			
			return _traitsTable[ref];
		}
	}
}	
