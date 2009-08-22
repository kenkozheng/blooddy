////////////////////////////////////////////////////////////////////////////////
//
//  (C) 2009 BlooDHounD
//
////////////////////////////////////////////////////////////////////////////////

package by.blooddy.core.utils {

	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import flash.text.TextField;

	/**
	 * @author					BlooDHounD
	 * @version					1.0
	 * @playerversion			Flash 9
	 * @langversion				3.0
	 */
	public final class DisplayObjectUtils {

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static const _EMPTY_ARRAY:Array = new Array();

		/**
		 * @private
		 */
		private static const _EMPTY_MATRIX:Matrix = new Matrix();

		/**
		 * @private
		 */
		private static const _EMPTY_COLOR_TRANSFORM:ColorTransform = new ColorTransform();

		/**
		 * @private
		 */
		private static const _EMPTY_SOUNT_TRANSFORM:SoundTransform = new SoundTransform();

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function reset(obj:DisplayObject):void {
			obj.alpha = 1;
			obj.blendMode = BlendMode.NORMAL;
			obj.cacheAsBitmap = false;
			if ( obj.filters.length > 0 ) obj.filters = _EMPTY_ARRAY;
			obj.mask = null;
			obj.name = '';
			obj.scale9Grid = null;
			obj.scrollRect = null;
			// transform
			with ( obj.transform ) {
				colorTransform = _EMPTY_COLOR_TRANSFORM;
				matrix = _EMPTY_MATRIX;
				matrix3D = null;
				perspectiveProjection = null;
			}
			obj.visible = true;
			if ( obj is InteractiveObject ) {
				var inter:InteractiveObject = obj as InteractiveObject;
				inter.contextMenu = null;
				inter.doubleClickEnabled = false;
				inter.focusRect = null;
				inter.mouseEnabled = true;
				inter.tabEnabled = false;
				inter.tabIndex = -1;
				if ( inter is DisplayObjectContainer ) {
					var cont:DisplayObjectContainer = inter as DisplayObjectContainer;
					cont.mouseChildren = true;
					cont.tabChildren = true;
					if ( cont is Sprite ) {
						var s:Sprite = cont as Sprite;
						s.buttonMode = false;
						s.hitArea = null;
						s.soundTransform = _EMPTY_SOUNT_TRANSFORM;
						s.useHandCursor = true;
						if ( s is MovieClip ) {
							var mc:MovieClip = s as MovieClip;
							mc.gotoAndPlay( 1 );
							mc.trackAsMenu = false;
						}
					}
				} else if ( inter is SimpleButton ) {
					var btn:SimpleButton = inter as SimpleButton;
					btn.enabled = true;
					btn.soundTransform = _EMPTY_SOUNT_TRANSFORM;
					btn.trackAsMenu = false;
					btn.useHandCursor = true;
				}
			}
		}

		public static function toString(obj:DisplayObject):String {
			var arr:Array = new Array();
			do {
				if ( obj.name )	arr.unshift( obj.name );
				else			arr.unshift( obj.toString() );
			} while( obj = obj.parent );
			return arr.join( '.' );
		}
		
		public static function getDropTarget(container:DisplayObjectContainer, point:Point, objects:Array = null):DisplayObject {
			if (!objects) {
				objects = container.getObjectsUnderPoint(point);
				getDropTarget_filter( objects );
			}
			
			var o:DisplayObject;
			var doc:DisplayObjectContainer;
			var i:uint;
			
			while (objects.length) {
				o = objects.pop() as DisplayObject;
				if (!(o is DisplayObjectContainer)) return o;
				doc = o as DisplayObjectContainer;
				
				if (doc !== container) {
					for (i = 0;i < objects.length;i++) {
						if (!doc.contains(objects[i])) objects.splice(i--, 1);
					}
					
					return DisplayObjectUtils.getDropTarget(doc, point, objects);
				}
			}
			
			return container;
		}

		//--------------------------------------------------------------------------
		//
		//  Private class methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function getDropTarget_filter(objects:Array):void {
			var currentTarget:InteractiveObject;
			var currentParent:DisplayObject;
			var i:int = objects.length;
		
			while (i--) {
				currentParent = objects[i];
		
				while (currentParent) {
					if (currentTarget && (currentParent is SimpleButton || currentParent is TextField)) {
						currentTarget = null;
					} else if (currentTarget && !(currentParent as DisplayObjectContainer).mouseChildren) {
						currentTarget = null;
					}
					
					if (!currentTarget && currentParent is InteractiveObject && (currentParent as InteractiveObject).mouseEnabled) {
						currentTarget = (currentParent as InteractiveObject);
					}
					
					currentParent = currentParent.parent;
				}
				
//				trace('not filtered:', i, objects[i].name,  objects[i]);
				objects[i] = currentTarget;
//				trace('filtered:', i, currentTarget.name, currentTarget);
				currentTarget = null;
			}
			
		}
		
	}

}