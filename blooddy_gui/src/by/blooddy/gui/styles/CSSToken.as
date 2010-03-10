////////////////////////////////////////////////////////////////////////////////
//
//  © 2010 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.gui.styles {
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					Mar 10, 2010 12:23:35 PM
	 */
	public final class CSSToken {
		
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		
		public static const EOF:uint =							  0;
		public static const IMPORT:uint =			EOF			+ 1;
		public static const COLON:uint =			IMPORT		+ 1;
		public static const LEFT_BRACE:uint =		COLON		+ 1;
		public static const RIGHT_BRACE:uint =		LEFT_BRACE	+ 1;
		public static const HASH:uint =				RIGHT_BRACE	+ 1;
		public static const DOT:uint =				HASH		+ 1;
		public static const COMMA:uint =			DOT			+ 1;
		public static const SEMI_COLON:uint =		COMMA		+ 1;
		public static const IDENTIFIER:uint =		SEMI_COLON	+ 1;
		public static const STRING_LITERAL:uint =	IDENTIFIER	+ 1;
		
	}
	
}