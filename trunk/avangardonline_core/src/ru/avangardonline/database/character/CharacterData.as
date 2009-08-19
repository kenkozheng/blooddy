////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2009 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package ru.avangardonline.database.character {

	import by.blooddy.core.database.Data;
	
	import ru.avangardonline.database.battle.world.BattleWorldElementData;

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 9
	 * @langversion				3.0
	 * @created					05.08.2009 22:12:56
	 */
	public class CharacterData extends BattleWorldElementData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function CharacterData(id:uint) {
			super( id );
		}

		//--------------------------------------------------------------------------
		//
		//  Proeprties
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  group
		//----------------------------------

		/**
		 * @private
		 */
		private var _group:uint = 0;

		public function get group():uint {
			return this._group;
		}

		/**
		 * @private
		 */
		public function set group(value:uint):void {
			if ( this._group != value ) return;
			this._group = value;
		}

		//--------------------------------------------------------------------------
		//
		//  Overriden methods
		//
		//--------------------------------------------------------------------------

		public override function clone():Data {
			var result:CharacterData = new CharacterData( super.id );
			result.copyFrom( this );
			return result;
		}

		public override function copyFrom(data:Data):void {
			var target:CharacterData = data as CharacterData;
			if ( !target ) throw new ArgumentError();
			this.group = target._group;
		}

	}

}