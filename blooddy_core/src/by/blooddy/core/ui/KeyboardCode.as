////////////////////////////////////////////////////////////////////////////////
//
//  © 2004—2008 TimeZero LLC.
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.core.ui {
	import flash.ui.Keyboard;
	

	/**
	 * @author					etc
	 * @version					1.0
	 * @playerversion			Flash 9
	 * @langversion				3.0
	 */	
	public class KeyboardCode {
		public static const A:uint = 65;
		public static const ALTERNATE:uint = 18;
		public static const B:uint = 66;
		public static const BACKQUOTE:uint = 192;
		public static const BACKSLASH:uint = 220;
		public static const BACKSPACE:uint = 8;
		public static const C:uint = 67;
		public static const CAPS_LOCK:uint = 20;
		public static const COMMA:uint = 188;
		public static const COMMAND:uint = 15;
		public static const CONTROL:uint = 17;
		public static const D:uint = 68;
		public static const DELETE:uint = 46;
		public static const DOWN:uint = 40;
		public static const E:uint = 69;
		public static const END:uint = 35;
		public static const ENTER:uint = 13;
		public static const EQUAL:uint = 187;
		public static const ESCAPE:uint = 27;
		public static const F:uint = 70;
		public static const F1:uint = 112;
		public static const F10:uint = 121;
		public static const F11:uint = 122;
		public static const F12:uint = 123;
		public static const F13:uint = 124;
		public static const F14:uint = 125;
		public static const F15:uint = 126;
		public static const F2:uint = 113;
		public static const F3:uint = 114;
		public static const F4:uint = 115;
		public static const F5:uint = 116;
		public static const F6:uint = 117;
		public static const F7:uint = 118;
		public static const F8:uint = 119;
		public static const F9:uint = 120;
		public static const G:uint = 71;
		public static const H:uint = 72;
		public static const HOME:uint = 36;
		public static const I:uint = 73;
		public static const INSERT:uint = 45;
		public static const J:uint = 74;
		public static const K:uint = 75;
		public static const KEYNAME_BEGIN:String = "?";
		public static const KEYNAME_BREAK:String = "?";
		public static const KEYNAME_CLEARDISPLAY:String = "?";
		public static const KEYNAME_CLEARLINE:String = "?";
		public static const KEYNAME_DELETE:String = "?";
		public static const KEYNAME_DELETECHAR:String = "?";
		public static const KEYNAME_DELETELINE:String = "?";
		public static const KEYNAME_DOWNARROW:String = "?";
		public static const KEYNAME_END:String = "?";
		public static const KEYNAME_EXECUTE:String = "?";
		public static const KEYNAME_F1:String = "?";
		public static const KEYNAME_F10:String = "?";
		public static const KEYNAME_F11:String = "?";
		public static const KEYNAME_F12:String = "?";
		public static const KEYNAME_F13:String = "?";
		public static const KEYNAME_F14:String = "?";
		public static const KEYNAME_F15:String = "?";
		public static const KEYNAME_F16:String = "?";
		public static const KEYNAME_F17:String = "?";
		public static const KEYNAME_F18:String = "?";
		public static const KEYNAME_F19:String = "?";
		public static const KEYNAME_F2:String = "?";
		public static const KEYNAME_F20:String = "?";
		public static const KEYNAME_F21:String = "?";
		public static const KEYNAME_F22:String = "?";
		public static const KEYNAME_F23:String = "?";
		public static const KEYNAME_F24:String = "?";
		public static const KEYNAME_F25:String = "?";
		public static const KEYNAME_F26:String = "?";
		public static const KEYNAME_F27:String = "?";
		public static const KEYNAME_F28:String = "?";
		public static const KEYNAME_F29:String = "?";
		public static const KEYNAME_F3:String = "?";
		public static const KEYNAME_F30:String = "?";
		public static const KEYNAME_F31:String = "?";
		public static const KEYNAME_F32:String = "?";
		public static const KEYNAME_F33:String = "?";
		public static const KEYNAME_F34:String = "?";
		public static const KEYNAME_F35:String = "?";
		public static const KEYNAME_F4:String = "?";
		public static const KEYNAME_F5:String = "?";
		public static const KEYNAME_F6:String = "?";
		public static const KEYNAME_F7:String = "?";
		public static const KEYNAME_F8:String = "?";
		public static const KEYNAME_F9:String = "?";
		public static const KEYNAME_FIND:String = "?";
		public static const KEYNAME_HELP:String = "?";
		public static const KEYNAME_HOME:String = "?";
		public static const KEYNAME_INSERT:String = "?";
		public static const KEYNAME_INSERTCHAR:String = "?";
		public static const KEYNAME_INSERTLINE:String = "?";
		public static const KEYNAME_LEFTARROW:String = "?";
		public static const KEYNAME_MENU:String = "?";
		public static const KEYNAME_MODESWITCH:String = "?";
		public static const KEYNAME_NEXT:String = "?";
		public static const KEYNAME_PAGEDOWN:String = "?";
		public static const KEYNAME_PAGEUP:String = "?";
		public static const KEYNAME_PAUSE:String = "?";
		public static const KEYNAME_PREV:String = "?";
		public static const KEYNAME_PRINT:String = "?";
		public static const KEYNAME_PRINTSCREEN:String = "?";
		public static const KEYNAME_REDO:String = "?";
		public static const KEYNAME_RESET:String = "?";
		public static const KEYNAME_RIGHTARROW:String = "?";
		public static const KEYNAME_SCROLLLOCK:String = "?";
		public static const KEYNAME_SELECT:String = "?";
		public static const KEYNAME_STOP:String = "?";
		public static const KEYNAME_SYSREQ:String = "?";
		public static const KEYNAME_SYSTEM:String = "?";
		public static const KEYNAME_UNDO:String = "?";
		public static const KEYNAME_UPARROW:String = "?";
		public static const KEYNAME_USER:String = "?";
		public static const L:uint = 76;
		public static const LEFT:uint = 37;
		public static const LEFTBRACKET:uint = 219;
		public static const M:uint = 77;
		public static const MINUS:uint = 189;
		public static const N:uint = 78;
		public static const NUMBER_0:uint = 48;
		public static const NUMBER_1:uint = 49;
		public static const NUMBER_2:uint = 50;
		public static const NUMBER_3:uint = 51;
		public static const NUMBER_4:uint = 52;
		public static const NUMBER_5:uint = 53;
		public static const NUMBER_6:uint = 54;
		public static const NUMBER_7:uint = 55;
		public static const NUMBER_8:uint = 56;
		public static const NUMBER_9:uint = 57;
		public static const NUMPAD:uint = 21;
		public static const NUMPAD_0:uint = 96;
		public static const NUMPAD_1:uint = 97;
		public static const NUMPAD_2:uint = 98;
		public static const NUMPAD_3:uint = 99;
		public static const NUMPAD_4:uint = 100;
		public static const NUMPAD_5:uint = 101;
		public static const NUMPAD_6:uint = 102;
		public static const NUMPAD_7:uint = 103;
		public static const NUMPAD_8:uint = 104;
		public static const NUMPAD_9:uint = 105;
		public static const NUMPAD_ADD:uint = 107;
		public static const NUMPAD_DECIMAL:uint = 110;
		public static const NUMPAD_DIVIDE:uint = 111;
		public static const NUMPAD_ENTER:uint = 108;
		public static const NUMPAD_MULTIPLY:uint = 106;
		public static const NUMPAD_SUBTRACT:uint = 109;
		public static const O:uint = 79;
		public static const P:uint = 80;
		public static const PAGE_DOWN:uint = 34;
		public static const PAGE_UP:uint = 33;
		public static const PERIOD:uint = 190;
		public static const Q:uint = 81;
		public static const QUOTE:uint = 222;
		public static const R:uint = 82;
		public static const RIGHT:uint = 39;
		public static const RIGHTBRACKET:uint = 221;
		public static const S:uint = 83;
		public static const SEMICOLON:uint = 186;
		public static const SHIFT:uint = 16;
		public static const SLASH:uint = 191;
		public static const SPACE:uint = 32;
		public static const STRING_BEGIN:String = "?";
		public static const STRING_BREAK:String = "?";
		public static const STRING_CLEARDISPLAY:String = "?";
		public static const STRING_CLEARLINE:String = "?";
		public static const STRING_DELETE:String = "?";
		public static const STRING_DELETECHAR:String = "?";
		public static const STRING_DELETELINE:String = "?";
		public static const STRING_DOWNARROW:String = "?";
		public static const STRING_END:String = "?";
		public static const STRING_EXECUTE:String = "?";
		public static const STRING_F1:String = "?";
		public static const STRING_F10:String = "?";
		public static const STRING_F11:String = "?";
		public static const STRING_F12:String = "?";
		public static const STRING_F13:String = "?";
		public static const STRING_F14:String = "?";
		public static const STRING_F15:String = "?";
		public static const STRING_F16:String = "?";
		public static const STRING_F17:String = "?";
		public static const STRING_F18:String = "?";
		public static const STRING_F19:String = "?";
		public static const STRING_F2:String = "?";
		public static const STRING_F20:String = "?";
		public static const STRING_F21:String = "?";
		public static const STRING_F22:String = "?";
		public static const STRING_F23:String = "?";
		public static const STRING_F24:String = "?";
		public static const STRING_F25:String = "?";
		public static const STRING_F26:String = "?";
		public static const STRING_F27:String = "?";
		public static const STRING_F28:String = "?";
		public static const STRING_F29:String = "?";
		public static const STRING_F3:String = "?";
		public static const STRING_F30:String = "?";
		public static const STRING_F31:String = "?";
		public static const STRING_F32:String = "?";
		public static const STRING_F33:String = "?";
		public static const STRING_F34:String = "?";
		public static const STRING_F35:String = "?";
		public static const STRING_F4:String = "?";
		public static const STRING_F5:String = "?";
		public static const STRING_F6:String = "?";
		public static const STRING_F7:String = "?";
		public static const STRING_F8:String = "?";
		public static const STRING_F9:String = "?";
		public static const STRING_FIND:String = "?";
		public static const STRING_HELP:String = "?";
		public static const STRING_HOME:String = "?";
		public static const STRING_INSERT:String = "?";
		public static const STRING_INSERTCHAR:String = "?";
		public static const STRING_INSERTLINE:String = "?";
		public static const STRING_LEFTARROW:String = "?";
		public static const STRING_MENU:String = "?";
		public static const STRING_MODESWITCH:String = "?";
		public static const STRING_NEXT:String = "?";
		public static const STRING_PAGEDOWN:String = "?";
		public static const STRING_PAGEUP:String = "?";
		public static const STRING_PAUSE:String = "?";
		public static const STRING_PREV:String = "?";
		public static const STRING_PRINT:String = "?";
		public static const STRING_PRINTSCREEN:String = "?";
		public static const STRING_REDO:String = "?";
		public static const STRING_RESET:String = "?";
		public static const STRING_RIGHTARROW:String = "?";
		public static const STRING_SCROLLLOCK:String = "?";
		public static const STRING_SELECT:String = "?";
		public static const STRING_STOP:String = "?";
		public static const STRING_SYSREQ:String = "?";
		public static const STRING_SYSTEM:String = "?";
		public static const STRING_UNDO:String = "?";
		public static const STRING_UPARROW:String = "?";
		public static const STRING_USER:String = "?";
		public static const T:uint = 84;
		public static const TAB:uint = 9;
		public static const TILDE:uint = 192;
		public static const U:uint = 85;
		public static const UP:uint = 38;
		public static const V:uint = 86;
		public static const W:uint = 87;
		public static const X:uint = 88;
		public static const Y:uint = 89;
		public static const Z:uint = 90;
	}
}