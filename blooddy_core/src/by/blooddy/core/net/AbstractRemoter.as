////////////////////////////////////////////////////////////////////////////////
//
//  © 2007 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.core.net {

	import by.blooddy.core.events.net.CommandEvent;
	import by.blooddy.core.events.net.StackErrorEvent;
	import by.blooddy.core.logging.CommandLog;
	import by.blooddy.core.logging.ILogging;
	import by.blooddy.core.logging.InfoLog;
	import by.blooddy.core.logging.Logger;
	import by.blooddy.core.utils.Command;
	
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	//--------------------------------------
	//  Events
	//--------------------------------------

	/**
	 * какая-то ошибка при исполнении.
	 */
	[Event(name="error", type="by.blooddy.core.events.net.StackErrorEvent")]	

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 9
	 * @langversion				3.0
	 *
	 * @keyword					iconnection, connection
	 */
	public class AbstractRemoter extends EventDispatcher implements IRemoter, ILogging {

		//--------------------------------------------------------------------------
		//
		//  Private class methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function getName(value:Object):String {
			return getQualifiedClassName( value ).replace( '::', '.' );
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructior
		 */
		public function AbstractRemoter() {
			super();
			this._client = this;
			this._clientName = getName( this );
		}

		//--------------------------------------------------------------------------
		//
		//  Implements properties: INetConnection
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  client
		//----------------------------------

		/**
		 * @private
		 */
		private var _client:Object;

		/**
		 * @private
		 */
		private var _clientName:String;

		/**
		 * @inheritDoc
		 */
		public function get client():Object {
			return this._client;
		}

		/**
		 * @private
		 */
		public function set client(value:Object):void {
			if ( this._client === value ) return;
			this._client = value || this;
			this._clientName = getName( this._client );
		}

		//----------------------------------
		//  logger
		//----------------------------------

		/**
		 * @private
		 */
		private const _logger:Logger = new Logger();

		/**
		 * @inheritDoc
		 */
		public function get logger():Logger {
			return this._logger;
		}

		//----------------------------------
		//  logging
		//----------------------------------

		/**
		 * @private
		 */
		private var _logging:Boolean = true;

		/**
		 * @inheritDoc
		 */
		public function get logging():Boolean {
			return this._logging;
			
		}

		/**
		 * @private
		 */
		public function set logging(value:Boolean):void {
			if ( this._logging == value ) return;
			this._logging = value;
		}

		//--------------------------------------------------------------------------
		//
		//  Implements methods: IConnection
		//
		//--------------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		public function call(commandName:String, ...parameters):* {
			return this.$invokeCallOutputCommand( new Command( commandName, parameters ) );
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  output
		//----------------------------------

		protected function $invokeCallOutputCommand(command:Command):* {
			if ( this._logging && !( command is NetCommand ) || !( command as NetCommand ).system ) {
				this._logger.addLog( new CommandLog( command ) );
				trace( 'OUT: ', command );
			}
			return this.$callOutputCommand( command );
		}

		protected function $callOutputCommand(command:Command):* {
			return this.$invokeCallInputCommand( command, false );
		}

		//----------------------------------
		//  input
		//----------------------------------

		protected function $invokeCallInputCommand(command:Command, async:Boolean=true):* {
			if ( !command ) throw new ArgumentError();

			if ( this._logging && !( command is NetCommand ) || !( command as NetCommand ).system ) {
				this._logger.addLog( new CommandLog( command ) );
				trace( 'IN: ', command );
			}

			if ( async ) {

				try { // отлавливаем ошибки выполнения
	
					return this.$callInputCommand( command );
	
				} catch ( e:Error ) {
	
					// нету. диспатчим ошибку
					var error:String = 'Error: ' + this._clientName + '::' + command.name + '(' + command.toString() + '): ' + e.toString() + ' ' + e.getStackTrace();
	
					if ( this._logging ) {
						this._logger.addLog( new InfoLog( error, InfoLog.ERROR ) );
					}
					trace( error );
					super.dispatchEvent( new StackErrorEvent( StackErrorEvent.ERROR, false, false, e.toString(), e.getStackTrace() ) );
	
				}
			
			} else {

				return this.$callInputCommand( command );

			}

		}

		protected function $callInputCommand(command:Command):* {
			if ( !command ) throw new ArgumentError(); // TODO: описать ошибку
			try {
				// пытаемся выполнить что-нить
				if ( command.name in this._client ) {
					return command.call( this._client );
				}
			} finally {
				// проверим нету ли хендлера на нашу комманду
				if ( super.hasEventListener( 'command_' + command.name ) ) {
					super.dispatchEvent( new CommandEvent( 'command_' + command.name, false, false, command ) );
				}
			}
		}

	}

}