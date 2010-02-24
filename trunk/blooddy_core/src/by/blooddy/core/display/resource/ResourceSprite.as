////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2009 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.core.display.resource {

	import by.blooddy.core.events.display.resource.ResourceErrorEvent;
	import by.blooddy.core.events.display.resource.ResourceEvent;
	import by.blooddy.core.events.net.LoaderEvent;
	import by.blooddy.core.managers.resource.ResourceManagerProxy;
	import by.blooddy.core.net.ILoadable;
	import by.blooddy.core.utils.enterFrameBroadcaster;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	//--------------------------------------
	//  Events
	//--------------------------------------

	/**
	 * @eventType			by.blooddy.core.events.net.LoaderEvent.LOADER_INIT
	 */
	[Event( name="loaderInit", type="by.blooddy.core.events.net.LoaderEvent" )]

	/**
	 * @eventType			by.blooddy.core.events.display.resource.ResourceEvent.ADDED_TO_MANAGER
	 */
	[Event( name="addedToManager", type="by.blooddy.core.events.display.resource.ResourceEvent" )]

	/**
	 * @eventType			by.blooddy.core.events.display.resource.ResourceEvent.REMOVED_FROM_MANAGER
	 */
	[Event( name="removedFromManager", type="by.blooddy.core.events.display.resource.ResourceEvent" )]

	/**
	 * @eventType			by.blooddy.core.events.display.resource.ResourceErrorEvent.RESOURCE_ERROR
	 */
	[Event( name="resourceError", type="by.blooddy.core.events.display.resource.ResourceErrorEvent" )]
	
	/**
	 * Класс у когорого есть ссылка на манагер ресурсов.
	 * 
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 9
	 * @langversion				3.0
	 * 
	 * @keyword					resourcemangerownersprite, resourcemanagerowner, resourcemanager, resource, manager, sprite
	 */
	public class ResourceSprite extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Namepsaces
		//
		//--------------------------------------------------------------------------

		protected namespace rs_protected;

		use namespace rs_protected;
		
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static const _MANAGER:ResourceManagerProxy = new ResourceManagerProxy();

		/**
		 * @private
		 */
		private static const _LOCK_HASH:Dictionary = new Dictionary( true );

		/**
		 * @private
		 */
		private static const _SEPARATOR:String = String.fromCharCode( 0 );
		
		/**
		 * @private
		 */
		private static const _NAME_DISPLAY_OBJECT:String = getQualifiedClassName( DisplayObject );
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function ResourceSprite() {
			super();
			super.addEventListener( Event.ADDED_TO_STAGE,		this.handler_addedToStage,		false, int.MAX_VALUE, true );
			super.addEventListener( Event.REMOVED_FROM_STAGE,	this.handler_removedFromStage,	false, int.MAX_VALUE, true );
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private const _resources:Dictionary = new Dictionary( true );

		/**
		 * @private
		 */
		private var _manager:ResourceManagerProxy;

		/**
		 * @private
		 */
		private var _lockers:Object;
		
		/**
		 * @private
		 */
		private var _addedToStage:Boolean = false;

		/**
		 * @private
		 */
		private var _depth:int = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Overriden peoperties: DisplayObject
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		public override function set filters(value:Array):void {
			if ( !super.filters.length && ( !value || !value.length ) ) return;
			super.filters = value;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		rs_protected function getResourceManager():ResourceManagerProxy {
			var parent:DisplayObjectContainer = super.parent;
			while ( parent ) {
				if ( parent is ResourceSprite ) {
					return ( parent as ResourceSprite )._manager;
				}
				parent = parent.parent;
			}
			return ( super.stage ? _MANAGER : null );
		}
		
		rs_protected function getDepth():int {
			var parent:DisplayObjectContainer = super.parent;
			while ( parent ) {
				if ( parent is ResourceSprite ) {
					return ( parent as ResourceSprite )._depth + 1;
				}
				parent = parent.parent;
			}
			return int.MIN_VALUE;
		}
		
		protected final function hasManager():Boolean {
			return Boolean( this._manager );
		}
		
		protected final function loadResourceBundle(bundleName:String, priority:int=0.0):ILoadable {
			if ( !this._manager ) throw new ArgumentError();
			var loader:ILoadable = this._manager.loadResourceBundle( bundleName, priority );
			// диспатчим событие о том что началась загрузка
			if ( !loader.loaded ) super.dispatchEvent( new LoaderEvent( LoaderEvent.LOADER_INIT, true, false, loader ) );
			return loader;
		}

		protected final function hasResource(bundleName:String, resourceName:String):Boolean {
			if ( !this._manager ) throw new ArgumentError();
			return this._manager.hasResource( bundleName, resourceName );
		}

		protected final function getResource(bundleName:String, resourceName:String):Object {
			if ( !this._manager ) throw new ArgumentError();
			var result:Object = this._manager.getResource( bundleName, resourceName );
			switch ( typeof result ) {
				case 'object':
				case 'function':
					this.saveResource( bundleName, resourceName, result );
			}
			return result;
		}

		protected final function getDisplayObject(bundleName:String, resourceName:String):DisplayObject {
			if ( !this._manager ) throw new ArgumentError();
			var result:DisplayObject = this._manager.getDisplayObject( bundleName, resourceName );
			if ( result ) {
				this.saveResource( bundleName, resourceName, result );
			}
			return result;
		}

		protected final function getSound(bundleName:String, resourceName:String):Sound {
			if ( !this._manager ) throw new ArgumentError();
			var result:Sound = this._manager.getSound( bundleName, resourceName );
			if ( result ) {
				this.saveResource( bundleName, resourceName, result );
			}
			return result;
		}

		protected final function trashResource(resource:Object, time:uint=3*60*1E3):void {
			if ( !this._manager ) throw new ArgumentError();
			var def:ResourceLinker = this._resources[ resource ];
			if ( !def ) throw new ArgumentError( '' );
			def.count--;
			if ( !def.count ) {
				delete this._resources[ resource ];
			}
			this._manager.trashResource( resource );
		}

		protected final function lockResourceBundle(bundleName:String):void {
			if ( !this._manager ) throw new ArgumentError();
			var lockers:Dictionary = this._lockers[ bundleName ];
			if ( !lockers ) {
				this._lockers[ bundleName ] = lockers = new Dictionary( true );
				this._manager.lockResourceBundle( bundleName );
			}
			lockers[ this ] = true;
		}

		protected final function unlockResourceBundle(bundleName:String):void {
			if ( !this._manager ) throw new ArgumentError();
			var lockers:Dictionary = this._lockers[ bundleName ];
			if ( lockers ) {
				delete lockers[ this ];
				for each ( var lock:Boolean in lockers ) break;
				if ( !lock ) {
					delete this._lockers[ bundleName ];
					this._manager.unlockResourceBundle( bundleName );
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function saveResource(bundleName:String, resourceName:String, resource:Object):void {
			var def:ResourceLinker = this._resources[ resource ];
			if ( !def ) {
				this._resources[ resource ] = def = new ResourceLinker( bundleName, resourceName );
			}
			def.count++;
		}

		/**
		 * @private
		 */
		private function removeFromManager():void {
			if ( super.hasEventListener( ResourceEvent.REMOVED_FROM_MANAGER ) ) {
				super.dispatchEvent( new ResourceEvent( ResourceEvent.REMOVED_FROM_MANAGER ) );
			}
			// если у нас остались ресурсы, это ЖОПА!
			var resources:Vector.<ResourceDefinition>;
			for each ( var def:ResourceLinker in this._resources ) {
				if ( !resources ) resources = new Vector.<ResourceDefinition>();
				resources.push( def );
			}
			if ( resources ) {
				super.dispatchEvent( new ResourceErrorEvent( ResourceErrorEvent.RESOURCE_ERROR, false, false, 'Некоторые ресурсы не были возвращены в мэннеджер ресурсов.', resources ) );
			}
			// зануляем resourceManager
			this._manager = null;
			this._lockers = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function handler_addedToStage(event:Event):void {
			if ( this._addedToStage ) {
				event.stopImmediatePropagation();
			} else {

				enterFrameBroadcaster.removeEventListener( Event.FRAME_CONSTRUCTED, this.handler_frameContructed );

				this._addedToStage = true;

				this._depth = this.getDepth();
				var manager:ResourceManagerProxy = this.getResourceManager();
				
				if ( this._manager && this._manager !== manager ) {
					this.removeFromManager();
				}
				
				if ( !this._manager ) {
					this._manager = manager;
					this._lockers = _LOCK_HASH[ manager ];
					if ( !this._lockers ) {
						_LOCK_HASH[ manager ] = this._lockers = new Object();
					}
					if ( super.hasEventListener( ResourceEvent.ADDED_TO_MANAGER ) ) {
						super.dispatchEvent( new ResourceEvent( ResourceEvent.ADDED_TO_MANAGER ) );
					}
				}

			}
		}

		/**
		 * @private
		 */
		private function handler_removedFromStage(event:Event):void {
			this._addedToStage = false;
			enterFrameBroadcaster.addEventListener( Event.FRAME_CONSTRUCTED, this.handler_frameContructed, false, this._depth );
		}

		/**
		 * @private
		 */
		private function handler_frameContructed(event:Event):void {
			enterFrameBroadcaster.removeEventListener( Event.FRAME_CONSTRUCTED, this.handler_frameContructed );
			this.removeFromManager();
		}

	}

}

//==============================================================================
//
//  Inner definitions
//
//==============================================================================

import by.blooddy.core.display.resource.ResourceDefinition;

////////////////////////////////////////////////////////////////////////////////
//
//  Helper class: ResourceLinker
//
////////////////////////////////////////////////////////////////////////////////

internal final class ResourceLinker extends ResourceDefinition {

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 * @private
	 * Constructor
	 */
	public function ResourceLinker(bundleName:String=null, resourceName:String=null) {
		super( bundleName, resourceName );
	}

	//--------------------------------------------------------------------------
	//
	//  Proeprties
	//
	//--------------------------------------------------------------------------

	public var count:uint = 0;

}