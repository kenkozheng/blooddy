////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2010 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.code {

	import by.blooddy.code.utils.Char;
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					13.03.2010 18:56:37
	 */
	public class AbstractScanner implements IScanner {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function AbstractScanner() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _source:String;
		
		/**
		 * @private
		 */
		protected var _prevPosition:uint;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _tokenText:String;
		
		public final function get tokenText():String {
			return this._tokenText;
		}

		/**
		 * @private
		 */
		protected var _position:uint;
		
		public final function get position():uint {
			return this._position;
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		public function writeSource(source:String):void {
			this._prevPosition = 0;
			this._position = 0;
			this._tokenText = null;
			this._source = source;
		}
		
		public function readToken():uint {
			throw new IllegalOperationError();
		}

		public function retreat():void {
			this._position = this._prevPosition;
			this._tokenText = null;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected final function readCharCode():uint {
			return this._source.charCodeAt( this._position++ );
		}
		
		/**
		 * @private
		 */
		protected final function readChar():String {
			return this._source.charAt( this._position++ );
		}
		
		/**
		 * @private
		 */
		protected final function makeToken(kind:uint, text:String):uint {
			this._tokenText = text;
			return kind;
		}
		
		/**
		 * @private
		 */
		protected final function readIdentifier():String {
			var pos:uint = this._position;
			var c:uint = this.readCharCode();
			if ( 
				( c < Char.a || c > Char.z ) &&
				( c < Char.A || c > Char.Z ) &&
				c != Char.DOLLAR &&
				c != Char.UNDER_SCORE &&
				c <= 0x7f
			) {
				this._position--;
				return null;
			}
			do {
				c = this.readCharCode();
			} while (
				( c >= Char.a && c <= Char.z ) ||
				( c >= Char.A && c <= Char.Z ) ||
				( c >= Char.ZERO && c <= Char.NINE ) ||
				c == Char.DOLLAR ||
				c == Char.UNDER_SCORE ||
				c > 0x7f
			);
			this._position--;
			return this._source.substring( pos, this._position );
		}
		
		/**
		 * @private
		 */
		protected final function readString():String {
			var pos:uint = this._position;
			var to:uint = this.readCharCode();
			if ( to != Char.SINGLE_QUOTE && to != Char.DOUBLE_QUOTE ) return null;
			var p:uint = pos + 1;
			var result:String = '';
			var c:uint, t:String;
			while ( ( c = this.readCharCode() ) != to ) {
				switch ( c ) {
					case Char.BACK_SLASH:
						result += this._source.substring( p, this._position - 1 );
						switch ( c = this.readCharCode() ) {
							case Char.n:	result += '\n';	break;
							case Char.r:	result += '\r';	break;
							case Char.t:	result += '\t';	break;
							case Char.v:	result += '\v';	break;
							case Char.f:	result += '\f';	break;
							case Char.b:	result += '\b';	break;
							case Char.x:
								t = this.readFixedHex( 2 );
								if ( t )	result += String.fromCharCode( parseInt( t, 16 ) );
								else		result += 'x';
								break;
							case Char.u:
								t = this.readFixedHex( 4 );
								if ( t )	result += String.fromCharCode( parseInt( t, 16 ) );
								else		result += 'u';
								break;
							default:
								result += this.readChar();
								break;
						}
						p = this._position;
						break;
					case Char.EOS:
					case Char.CARRIAGE_RETURN:
					case Char.NEWLINE:
						this._position = pos; // откатываемся
						return null;
				}
			}
			return result + this._source.substring( p, this._position - 1 );
		}
		
		/**
		 * @private
		 */
		protected final function readNumber():String {
			var pos:uint = this._position;
			var c:uint = this.readCharCode();
			var t:String;
			var s:String;
			if ( c == Char.DASH ) {
				s = '-';
				c = this.readCharCode();
			} else {
				s = '';
			}
			if ( c == Char.ZERO ) {

				switch ( this.readCharCode() ) {
					case Char.x:	// hex
					case Char.X:
						t = this.readHex();
						if ( t != null ) return s + parseInt( t, 16 );
						break;
					case Char.DOT:	// float
						t = this.readDec();
						if ( t != null ) return s + '.' + t + ( this.readExp() || '' );
						break;
					default:		// oct
						this._position--;
						t = this.readOct();
						if ( t != null ) return s + parseInt( t, 8 );
						else return '0';
				}

			} else if ( c == Char.DOT ) {

				t = this.readDec();
				if ( t != null ) return s + '.' + t + ( this.readExp() || '' );

			} else {

				this._position--;
				t = this.readDec();

				if ( t != null ) {
					s += t;
					if ( this.readCharCode() == Char.DOT ) {
						t = this.readDec();
						if ( t != null ) s += '.' + t;
					} else {
						this._position--;
					}
					return s + ( this.readExp() || '' );
				}

			}
			this._position = pos;
			return null;
		}
		
		/**
		 * @private
		 */
		private function readOct():String {
			var pos:uint = this._position;
			var c:uint;
			do {
				c = this.readCharCode();
			} while (
				c >= Char.ZERO && c <= Char.SEVEN
			);
			this._position--;
			if ( this._position == pos ) return null;
			return this._source.substring( pos, this._position );
		}
		
		/**
		 * @private
		 */
		private function readDec():String {
			var pos:uint = this._position;
			var c:uint;
			do {
				c = this.readCharCode();
			} while (
				c >= Char.ZERO && c <= Char.NINE
			);
			this._position--;
			if ( this._position == pos ) return null;
			return this._source.substring( pos, this._position );
		}

		/**
		 * @private
		 */
		private function readExp():String {
			var c:uint = this.readCharCode();
			if ( c == Char.e || c == Char.E ) {
				var prefix:String;
				if ( this.readCharCode() == Char.DASH ) {
					prefix = '-';
				} else {
					prefix = '';
					this._position--;
				}
				var t:String = this.readDec();
				if ( t != null ) return 'e' + prefix + t;
			}
			this._position--;
			return null;
		}

		/**
		 * @private
		 */
		private function readHex():String {
			var pos:uint = this._position;
			var c:uint;
			do {
				c = this.readCharCode();
			} while (
				( c >= Char.ZERO && c <= Char.NINE ) ||
				( c >= Char.a && c <= Char.f ) ||
				( c >= Char.A && c <= Char.F )
			);
			this._position--;
			if ( this._position == pos ) return null;
			return this._source.substring( pos, this._position );
		}
		
		/**
		 * @private
		 */
		private function readFixedHex(length:uint=0):String {
			var c:uint;
			for ( var i:uint = 0; i<length; i++ ) {
				c = this.readCharCode();
				if (
					( c < Char.ZERO || c > Char.NINE ) &&
					( c < Char.a || c > Char.f ) &&
					( c < Char.A || c > Char.F )
				) {
					this._position -= i;
					return null;
				}
			}
			return this._source.substring( this._position - length, this._position );
		}
		
		/**
		 * @private
		 */
		protected final function readTo(...to):String {
			var pos:uint = this._position;
			var c:uint;
			do {
				c = this.readCharCode();
				switch ( c ) {
					case Char.CARRIAGE_RETURN:
					case Char.NEWLINE:
						break;
				}
				if ( to.indexOf( c ) >= 0 ) {
					this._position--;
					return this._source.substring( pos, this._position );
				}
			} while ( c != Char.EOS );
			this._position = pos;
			return null;
		}
		
		/**
		 * @private
		 */
		protected final function readLine():String {
			var pos:uint = this._position;
			var c:uint;
			do {
				c = this.readCharCode();
			} while ( c != Char.NEWLINE && c != Char.CARRIAGE_RETURN && c != Char.EOS );
			this._position--;
			return this._source.substring( pos, this._position );
		}
		
		/**
		 * @private
		 */
		protected final function readBlockComment():String {
			var pos:uint = this._position;
			if (
				this.readCharCode() != Char.SLASH ||
				this.readCharCode() != Char.ASTERISK
			) {
				this._position = pos;
				return null;
			}
			do {
				switch ( this.readCharCode() ) {
					case Char.ASTERISK:
						if ( this.readCharCode() == Char.SLASH ) {
							return this._source.substring( pos + 2, this._position - 2 );
						} else {
							this._position--;
						}
						break;
					case Char.CARRIAGE_RETURN:
					case Char.NEWLINE:
						break;
					case Char.EOS:
						this._position = pos;
						return null;
				}
			} while ( true );
			this._position = pos;
			return null;
		}
		
	}
	
}