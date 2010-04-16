////////////////////////////////////////////////////////////////////////////////
//
//  © 2010 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.gui.display {
	
	import by.blooddy.core.controllers.IBaseController;
	import by.blooddy.core.display.resource.MainResourceSprite;
	import by.blooddy.core.errors.getErrorMessage;
	
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.system.Capabilities;

	// TODO: handler_removed

	//--------------------------------------
	//  Excluded APIs
	//--------------------------------------
	
	[Exclude( kind="method", name="addChild" )]
	[Exclude( kind="method", name="addChildAt" )]
	[Exclude( kind="method", name="removeChild" )]
	[Exclude( kind="method", name="removeChildAt" )]
	[Exclude( kind="method", name="getChildAt" )]
	[Exclude( kind="method", name="getChildIndex" )]
	[Exclude( kind="method", name="getChildByName" )]
	[Exclude( kind="method", name="setChildIndex" )]
	[Exclude( kind="method", name="swapChildren" )]
	[Exclude( kind="method", name="swapChildrenAt" )]
	[Exclude( kind="method", name="contains" )]
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					08.04.2010 14:47:51
	 */
	public class ComponentContainer extends MainResourceSprite {
		
		//--------------------------------------------------------------------------
		//
		//  Namepsaces
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static const $ns_controller:Namespace = NativeComponentController[ '$internal_c' ];

		/**
		 * @private
		 */
		private static const $ns_component:Namespace = Component[ '$internal_c' ];
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ComponentContainer(baseController:IBaseController) {
			super();
			this._baseController = baseController;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _components:Object = new Object();

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var _baseController:IBaseController;
		
		public function get baseController():IBaseController {
			return this._baseController;
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		public function loadComponent(url:String, params:Object=null):void {
			throw new IllegalOperationError();
		}

		public function removeComponent(info:ComponentInfo):ComponentInfo {
			if ( !( info.name in this._components ) || ( this._components[ info.name ] !== info ) ) throw new ArgumentError();
			super.removeChild( info.component );
			delete this._components[ info.name ];
			return info;
		}
		
		public function removeComponentByID(id:String):ComponentInfo {
			return this.removeComponent( this._components[ id ] );
		}

		public function getComponentByID(id:String):ComponentInfo {
			return this._components[ id ];
		}
		
		public function hasComponent(name:String):Boolean {
			return name in this._components;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected function addComponent(info:ComponentInfo):void {
			
			// TODO: перенести
			info.component.$ns_component::init( info, info.name );
			info.controller.$ns_controller::init( info, this._baseController );
			
			if ( info.name in this._components ) {
				if ( this._components[ info.name ] !== info ) {
					throw new ArgumentError();
				}
			} else {
				this._components[ info.name ] = info;
				super.addChild( info.component );
			}
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overriden methods: MovieClip
		//
		//--------------------------------------------------------------------------
		
		[Deprecated( message="метод запрещён", replacement="addComponent" )]
		public override function addChild(child:DisplayObject):DisplayObject {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'addChild' ), 2071 );
			return null;
		}
		
		[Deprecated( message="метод запрещён", replacement="addComponent" )]
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'addChildAt' ), 2071 );
			return null;
		}
		
		[Deprecated( message="метод запрещён", replacement="removeComponent" )]
		public override function removeChild(child:DisplayObject):DisplayObject {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'removeChild' ), 2071 );
			return null;
		}
		
		[Deprecated( message="метод запрещён", replacement="removeComponent" )]
		public override function removeChildAt(index:int):DisplayObject {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'removeChildAt' ), 2071 );
			return null;
		}
		
		[Deprecated( message="метод запрещён" )]
		public override function getChildAt(index:int):DisplayObject {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'getChildAt' ), 2071 );
			return null;
		}
		
		[Deprecated( message="метод запрещён" )]
		public override function getChildIndex(child:DisplayObject):int {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'getChildIndex' ), 2071 );
			return -1;
		}
		
		[Deprecated( message="метод запрещён" )]
		public override function getChildByName(name:String):DisplayObject {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'getChildByName' ), 2071 );
			return null;
		}
		
		[Deprecated( message="метод запрещён" )]
		public override function setChildIndex(child:DisplayObject, index:int):void {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'setChildIndex' ), 2071 );
		}
		
		[Deprecated( message="метод запрещён" )]
		public override function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'swapChildren' ), 2071 );
		}
		
		[Deprecated( message="метод запрещён" )]
		public override function swapChildrenAt(index1:int, index2:int):void {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'swapChildrenAt' ), 2071 );
		}
		
		[Deprecated( message="метод запрещён", replacement="hasComponent" )]
		public override function contains(child:DisplayObject):Boolean {
			if ( !Capabilities.isDebugger ) throw new IllegalOperationError( getErrorMessage( 2071, this, 'contains' ), 2071 );
			return false;
		}
		
	}
	
}