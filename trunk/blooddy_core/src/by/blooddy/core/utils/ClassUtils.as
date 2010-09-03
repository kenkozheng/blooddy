////////////////////////////////////////////////////////////////////////////////
//
//  © 2007 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.core.utils {

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	/**
	 * Утилиты для работы с классами.
	 * 
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 9
	 * @langversion				3.0
	 *
	 * @keyword					сlassutils, class, utils
	 */
	public final class ClassUtils {
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function parseClassQName(name:String):QName {
			var i:int = name.lastIndexOf( '::' );
			if ( i < 0 ) {
				return new QName( '', name );
			} else {
				return new QName( name.substr( 0, i ), name.substr( i + 2 ) );
			}
		}
		
		public static function parseClassName(name:String):String {
			var i:int = name.lastIndexOf( '::' );
			if ( i > 0 ) name = name.substr( i + 2 );
			return name;
		}

		public static function getClassQName(o:Object):QName {
			return parseClassQName( getQualifiedClassName( o ) );
		}
		
		/**
		 * @param	value			Объект, имя класса, которого нужно узнать.
		 *
		 * @return					Имя класса.
		 *
		 * @keyword 				classutils.getclassname, getclassname, classname, class
		 *
		 * @see						flash.utils.getQualifiedClassName()
		 */
		public static function getClassName(o:Object):String {
			return parseClassName( getQualifiedClassName( o ) );
		}
		
		/**
		 * @param	value			Объект, имя класса, которого нужно узнать.
		 *
		 * @return					Имя класса.
		 *
		 * @keyword 				classutils.getsuperclassname, getsuperclassname, supercclassname, classname, class
		 *
		 * @see						flash.utils.getQualifiedSuperclassName()
		 */
		public static function getSuperclassName(o:Object):String {
			return parseClassName( getQualifiedSuperclassName( o ) );
		}

		public static function getClass(o:Object):Class {
			try {
				return getDefinitionByName( getQualifiedClassName( o ) ) as Class;
			} catch ( e:Error ) {
			}
			return null;
		}

		public static function getSuperclass(o:Object):Class {
			var name:String = getQualifiedSuperclassName( o );
			if ( name ) {
				try {
					return getDefinitionByName( name ) as Class;
				} catch ( e:Error ) {
				}
			}
			return null;
		}

	}

}