////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2010 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.core.meta {
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					06.03.2010 2:22:30
	 */
	public final class MethodInfo extends MemberInfo implements IFunctionInfo {
		
		//--------------------------------------------------------------------------
		//
		//  Namespaces
		//
		//--------------------------------------------------------------------------
		
		use namespace $protected_info;
		
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static const _TYPE:QName = new QName( '', 'Function' );

		/**
		 * @private
		 */
		private static const _LI:QName = new QName( ns_rdf, 'li' );

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function MethodInfo() {
			super();
			this._type = _TYPE;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private const _parameters:Vector.<ParameterInfo> = new Vector.<ParameterInfo>();
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		public function get parent():MethodInfo {
			return this._parent as MethodInfo;
		}
		
		/**
		 * @private
		 */
		private var _returnType:QName;

		public function get returnType():QName {
			return this._returnType;
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		public function getParameters():Vector.<ParameterInfo> {
			return this._parameters.slice();
		}
		
		public override function toXML():XML {
			var xml:XML = super.toXML();
			var x:XML;
			// type
			x = <type>method</type>;
			x.setNamespace( ns_dc );
			xml.appendChild( x );
			// returnType
			x = <returnType />;
			x.setNamespace( ns_as3 );
			x.@ns_rdf::resource = '#' + encodeURI( this._returnType.toString() );
			xml.appendChild( x );
			// parametrs
			var seq:XML = <Seq />;
			var l:uint = this._parameters.length;
			for ( var i:uint = 0; i<l; i++ ) {
				x = this._parameters[ 0 ].toXML();
				x.setName( _LI );
				seq.appendChild( x );
			}
			if ( seq.hasComplexContent() ) {
				seq.setNamespace( ns_rdf );
				x = <parameters />;
				x.setNamespace( ns_as3 );
				x.appendChild( seq );
				xml.appendChild( x );
			}
			return xml;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		$protected_info override function parseXML(xml:XML):void {
			super.parseXML( xml );
			this._returnType = parseType( xml.@returnType.toString() );
			var list:XMLList = xml.parameter;
			var p:ParameterInfo;
			for each ( xml in list ) {
				p = new ParameterInfo();
				p.parseXML( xml );
				this._parameters.push( p );
			}
		}

	}

}