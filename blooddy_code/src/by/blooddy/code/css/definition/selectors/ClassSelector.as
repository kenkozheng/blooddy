////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2010 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.code.css.definition.selectors {
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					14.03.2010 17:30:21
	 */
	public class ClassSelector extends AttributeSelector {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function ClassSelector(styleClass:String, selector:AttributeSelector=null) {
			super( styleClass, selector );
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		public function toString():String {
			return ( this.value ? '.' + this.value : '' ) + ( this.selector || '' );
		}

	}
	
}