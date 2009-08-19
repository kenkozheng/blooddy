////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2009 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package ru.avangardonline.serializers.txt.database.battle {

	import ru.avangardonline.database.battle.BattleData;
	import ru.avangardonline.database.battle.BattleTurnData;
	import ru.avangardonline.database.battle.actions.BattleActionData;
	import ru.avangardonline.serializers.ISerializer;
	import ru.avangardonline.serializers.txt.database.battle.world.BattleWorldElementCollectionDataSerializer;
	
	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					12.08.2009 23:30:07
	 */
	public class BattleDataSerializer implements ISerializer {

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static const _serializer:BattleDataSerializer = new BattleDataSerializer();

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function deserialize(source:String, target:BattleData=null):BattleData {
			return _serializer.deserialize( source, target ) as BattleData;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function BattleDataSerializer() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Implements methods
		//
		//--------------------------------------------------------------------------

		public function deserialize(source:String, target:*=null):* {
			var data:BattleData = target as BattleData;
			if ( !data ) throw new ArgumentError();

			var tmp:Array = source.split( '#' );

			// первчиноя валидация
			if ( tmp[ 0 ].length != 0 ) throw new ArgumentError();

			// мир
			if ( tmp[ 1 ].charAt( 0 ) != 'O' ) throw new ArgumentError();
			//BattleWorldDataSerializer.deserialize( tmp[ 1 ].substr( 1 ), data.world );

			// персонажи
			if ( tmp[ 2 ].charAt( 0 ) != 'I' ) throw new ArgumentError();
			BattleWorldElementCollectionDataSerializer.deserialize( tmp[ 1 ].substr( 1 ), data.world.elements );

			tmp.splice( 0, 3 );

			// ходы
			var l:uint = tmp.length;
			var turn:BattleTurnData;
			var action:BattleActionData;
			for ( var i:uint = 0; i<l; i++ ) {
				if ( tmp[ i ].charAt( 0 ) != 'A' ) throw new ArgumentError();
				turn = data.getTurn( i );
				if ( !turn ) {
					turn = new BattleTurnData( i );
					data.addChild( turn );
				}
				BattleTurnDataSerializer.deserialize( tmp[ i ].substr( 1 ), turn );
				// перебераем экшены и прописываем из значения
				for each ( action in turn.getActions() ) {
					if ( action.isResult() ) {
						action.startTime = BattleTurnData.TURN_TIME;
					}
				}
			}
			// удаляем лишние ходы
			for ( i = data.numTurns -1; i>=l; i-- ) {
				data.removeChild( data.getTurn( i ) );
			}
			return data;
		}

	}

}