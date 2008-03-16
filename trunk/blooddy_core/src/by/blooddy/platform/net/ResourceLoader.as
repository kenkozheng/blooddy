////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2007 group company TimeZero.
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.platform.net {

	import by.blooddy.platform.errors.ErrorsManager;

	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import flash.net.URLRequest;

	import flash.system.LoaderContext;

	import by.blooddy.platform.managers.IResourceBundle;

	/**
	 * Загружает свф и воспринимает его как ресурсы.
	 * Если загружается не свф, то обижаемся на него и просим убираться во свояси.
	 * 
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 9
	 * @langversion				3.0
	 * 
	 * @keyword					resourceloader, resource, loader
	 */
	public class ResourceLoader extends Loader implements IResourceBundle {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		public function ResourceLoader(request:URLRequest=null, loaderContext:LoaderContext=null) {
			super(request, loaderContext);
		}

		//--------------------------------------------------------------------------
		//
		//  Implements properties: IResourceBundle
		//
		//--------------------------------------------------------------------------

	    [Bindable("open")]
		/**
		 * @inheritDoc
		 */
		public function get name():String {
			return super.url;
		}

		//--------------------------------------------------------------------------
		//
		//  Implements methods: IResourceBundle
		//
		//--------------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		public function getObject(name:String):* {
			if (this.loaderInfo.applicationDomain.hasDefinition(name)) {
				return this.loaderInfo.applicationDomain.getDefinition(name);
			} else if (this.content.hasOwnProperty(name)) {
				return this.content[name];
			} else {
				return null;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		[ArrayElementType("String")]
		/**
		 * Получает список определений во флэшке.
		 * 
		 * @return					Массив определений.
		 */
		public function getDefinitionList():Array {
			/**
			 * TODO: дописать функу.
			 */
			return null;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		protected override function handler_init(event:Event):void {
			if ( this.loaderInfo.contentType != MIME.FLASH ) {
				try {
					this.close();
					this.unload();
				} catch (e:Error) {
				}
				super.handler_ioError( new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, ( new Error(2124, ErrorsManager.getErrorMessage(2124)+"URL: "+this.loaderInfo.url) ).toString()) );
			} else {
				super.handler_init(event);
			}
		}

	}

}