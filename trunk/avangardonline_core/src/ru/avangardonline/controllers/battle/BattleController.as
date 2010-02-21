////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2009 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package ru.avangardonline.controllers.battle {

	import by.blooddy.core.commands.Command;
	import by.blooddy.core.controllers.DisplayObjectController;
	import by.blooddy.core.controllers.IBaseController;
	import by.blooddy.core.utils.time.RelativeTime;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	import ru.avangardonline.data.battle.world.BattleWorldData;
	import ru.avangardonline.data.battle.world.BattleWorldElementCollectionData;
	import ru.avangardonline.data.battle.world.BattleWorldFieldData;
	import ru.avangardonline.data.character.CharacterData;
	import ru.avangardonline.display.gfx.battle.world.BattleWorldView;
	import ru.avangardonline.display.gfx.battle.world.BattleWorldViewFactory;

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 */
	public class BattleController extends DisplayObjectController {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function BattleController(controller:IBaseController, time:RelativeTime, container:DisplayObjectContainer) {
			super( controller, container );
			this._time = time;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _y:Number = 0;

		/**
		 * @private
		 */
		private var _data:BattleWorldData;

		/**
		 * @private
		 */
		private var _view:BattleWorldView;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  time
		//----------------------------------

		/**
		 * @private
		 */
		private var _time:RelativeTime;

		public function get time():RelativeTime {
			return this._time;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		protected override function construct():void {
			var controller:IBaseController = super.baseController;
			controller.addCommandListener( 'enterBattle',		this.enterBattle );
			controller.addCommandListener( 'exitBattle',		this.exitBattle );
			controller.addCommandListener( 'addCharacter',		this.addCharacter );
			controller.addCommandListener( 'removeCharacter',	this.removeCharacter );
			controller.addCommandListener( 'forWorldElement',	this.forWorldElement );
			controller.addCommandListener( 'syncElements',		this.syncElements );
			controller.call( 'enterBattle' );
		}

		/**
		 * @private
		 */
		protected override function destruct():void {
			var controller:IBaseController = super.baseController;
			controller.removeCommandListener( 'enterBattle',		this.enterBattle );
			controller.removeCommandListener( 'exitBattle',			this.exitBattle );
			controller.removeCommandListener( 'addCharacter',		this.addCharacter );
			controller.removeCommandListener( 'removeCharacter',	this.removeCharacter );
			controller.removeCommandListener( 'forWorldElement',	this.forWorldElement );
			controller.removeCommandListener( 'syncElements',		this.syncElements );
			if ( this._data ) {
				this.exitBattle();
				controller.call( 'exitBattle' );
			}
		}

		/**
		 * @private
		 */
		private function update3D(event:Event=null):void {
			var x:int = - this._view.mouseX;
			var y:int = ( this._view.mouseY > 0 ? - this._view.mouseY * 2 : 0 );
			var projection:PerspectiveProjection = new PerspectiveProjection();
			projection.fieldOfView = 80;
			projection.projectionCenter = new Point( x, y );
			this._view.transform.perspectiveProjection = projection;
		}

		//--------------------------------------------------------------------------
		//
		//  Command handlers
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function enterBattle(data:BattleWorldFieldData):void {

			this._data = new BattleWorldData( this._time );
			super.dataBase.addChild( this._data );

			this._data.field.copyFrom( data );

			this._view = new BattleWorldView( this._data, new BattleWorldViewFactory() );

			this._view.x = 353;
			this._view.y = 320;

			var projection:PerspectiveProjection = new PerspectiveProjection();
			projection.fieldOfView = 60;
			projection.projectionCenter = new Point( 0, -580 );
			this._view.transform.perspectiveProjection = projection;

			super.container.addChild( this._view );

		}

		/**
		 * @private
		 */
		private function exitBattle():void {
			super.container.removeChild( this._view );
			this._view = null;
			super.dataBase.removeChild( this._data );
			this._data = null;
		}

		/**
		 * @private
		 */
		private function syncElements(collection:BattleWorldElementCollectionData):void {
			this._data.elements.copyFrom( collection );
		}

		/**
		 * @private
		 */
		private function addCharacter(data:CharacterData):void {
			var character:CharacterData = this._data.elements.getElement( data.id ) as CharacterData;
			if ( character ) {
				trace( 'ASYNC: addCharacter' );
				character.copyFrom( data );
			} else {
				this._data.elements.addChild( data.clone() );
			}
		}

		/**
		 * @private
		 */
		private function removeCharacter(id:uint):void {
			var character:CharacterData = this._data.elements.getElement( id ) as CharacterData;
			if ( !character ) throw new ArgumentError();
			this._data.elements.removeChild( character );
		}

		/**
		 * @private
		 */
		private function forWorldElement(id:uint, command:Command):void {
			command.call( this._data.elements.getElement( id ) );
		}

	}

}