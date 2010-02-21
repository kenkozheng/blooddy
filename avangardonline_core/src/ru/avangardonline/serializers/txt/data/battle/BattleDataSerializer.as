////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2009 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package ru.avangardonline.serializers.txt.data.battle {

	import by.blooddy.game.serializers.txt.ISerializer;
	
	import flash.errors.IllegalOperationError;
	
	import ru.avangardonline.data.battle.BattleData;
	import ru.avangardonline.data.battle.actions.BattleActionData;
	import ru.avangardonline.data.battle.turns.BattleTurnData;
	import ru.avangardonline.serializers.txt.data.battle.result.BattleResultDataSerializer;
	import ru.avangardonline.serializers.txt.data.battle.world.BattleWorldElementCollectionDataSerializer;
	import ru.avangardonline.serializers.txt.data.battle.world.BattleWorldFieldDataSerializer;
	
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
			if ( _serializer ) throw new IllegalOperationError();
		}

		//--------------------------------------------------------------------------
		//
		//  Implements methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		public function deserialize(source:String, target:*=null):* {
			var data:BattleData = target as BattleData;
			if ( !data ) throw new ArgumentError();

			var tmp:Array = source.split( /\n?#/ );

			if ( tmp.length < 4 ) throw new ArgumentError();

			// первчиноя валидация
			if ( tmp[ 0 ].length != 0 ) throw new ArgumentError();
			// мир
			if ( tmp[ 1 ].charAt( 0 ) != 'O' ) throw new ArgumentError();
			BattleWorldFieldDataSerializer.deserialize( tmp[ 1 ].substr( 1 ), data.world.field );

			// персонажи
			if ( tmp[ 2 ].charAt( 0 ) != 'I' ) throw new ArgumentError();
			BattleWorldElementCollectionDataSerializer.deserialize( tmp[ 2 ].substr( 1 ), data.world.elements );

			tmp.splice( 0, 3 );

			// ходы
			var i:int;
			var l:int = tmp.length;
			var turn:BattleTurnData;
			var action:BattleActionData;
			for ( i=0; i<l; i++ ) {
				if ( tmp[ i ].charAt( 0 ) != 'A' ) break;
				turn = data.getTurn( i );
				if ( !turn ) {
					turn = new BattleTurnData( i );
					data.addChild( turn );
				}
				BattleTurnDataSerializer.deserialize( tmp[ i ].substr( 1 ), turn );
				// перебераем экшены и прописываем из значения
				for each ( action in turn.getActions() ) {
					action.startTime = BattleTurnData.TURN_DELAY * i + 200 * Math.random();
					if ( action.isResult() ) {
						action.startTime += BattleTurnData.TURN_LENGTH - 400 * Math.random();
					}
				}
			}
			// посмотри что там есть
			if ( i < l && tmp[ i ].charAt( 0 ) == 'R' ) {
				BattleResultDataSerializer.deserialize( tmp[ i ].substr( 1 ), data.result );
			}
			l = i;
			// удаляем лишние ходы
			for ( i = data.numTurns; i > l; i-- ) {
				data.removeChild( data.getTurn( i ) );
			}
			return data;
		}

	}

}