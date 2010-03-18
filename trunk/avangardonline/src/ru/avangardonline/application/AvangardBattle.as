////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2009 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package ru.avangardonline.application {

	import by.blooddy.core.display.resource.MainResourceSprite;
	import by.blooddy.core.utils.ActivityListener;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import ru.avangardonline.controllers.GameController;

	[SWF( width="706", height="358", frameRate="21", backgroundColor="#333333" )]

	[Frame( factoryClass="ru.avangardonline.application.factory.AvangardFactory" )]

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 10
	 * @langversion				3.0
	 * @created					04.08.2009 21:16:09
	 */
	public final class AvangardBattle extends MainResourceSprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function AvangardBattle() {
			super();
			super.addEventListener( Event.ADDED_TO_STAGE, this.handler_addedToStage, false, int.MAX_VALUE, true );
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _activityListener:ActivityListener;

		/**
		 * @private
		 */
		private var _controller:GameController;

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function handler_addedToStage(event:Event):void {

			super.stage.scaleMode = StageScaleMode.NO_SCALE;
			super.stage.align = StageAlign.TOP_LEFT;

			this._controller = new GameController( this );

//			this._activityListener = new ActivityListener();
//			this._activityListener.width = 120;
//			this._activityListener.height = 80;
//			this._activityListener.x = 5;
//			this._activityListener.y = 5;
//
//			super.stage.addChild( this._activityListener );

		}

	}

}