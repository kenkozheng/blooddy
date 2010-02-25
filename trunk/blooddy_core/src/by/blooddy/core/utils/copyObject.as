package by.blooddy.core.utils {

	import flash.utils.Dictionary;

	public function copyObject(source:Object, target:Object=null):Object {
		return $copyObject( new Dictionary(), source, target );
	}

}

import flash.utils.Dictionary;
import flash.utils.ByteArray;
import by.blooddy.core.utils.ObjectInfo;

internal function $copyObject(hash:Dictionary, source:Object, target:Object=null):Object {
	if ( !( source is Object ) ) {
		if ( target is Object ) throw new ArgumentError();
		target = source;
	} else if (
		source is Number ||
		source is String ||
		source is Boolean
	) {
		if ( target != null )  throw new ArgumentError();
		target = source;
	} else if ( source in hash ) {
		target = hash[ source ];
	} else if ( source is ByteArray ) {
		var bytesSource:ByteArray = source as ByteArray;
		var bytesTarget:ByteArray;
		if ( target ) {
			if ( !( target is ByteArray ) ) throw new ArgumentError();
			bytesTarget = target as ByteArray;
		} else {
			target = bytesTarget = new ByteArray()
		}
		hash[ source ] = target; // ADD
		var p:uint = bytesSource.position;
		bytesSource.position = 0;
		bytesTarget.clear();
		bytesSource.readBytes( bytesTarget );
		bytesTarget.position =
		bytesSource.position = p;
	} else if (
		source is XML ||
		source is XMLList
	) {
		if ( target ) throw new ArgumentError();
		target = source.copy();
		hash[ source ] = target; // ADD
	} else {
		var info:ObjectInfo = ObjectInfo.getInfo( source );
		if ( !target ) {
			if ( source is Array )	target = new Array();
			else					target = new Object();
		}
		hash[ source ] = target; // ADD
		var members:Array = info.getMembers( ObjectInfo.MEMBER_PROPERTIES );
		var key:*, value:*;
		const props:Dictionary = new Dictionary();
		for each ( var member:ObjectInfo in members ) {
			key = member.name;
			props[ key ] = true;
			try {
				value = $copyObject( hash, source[ key ] );
				target[ key ] = value;
			} catch ( e:Error ) {
			}
		}
		for ( key in source ) {
			if ( !( key in props ) ) {
				try {
					value = $copyObject( hash, source[ key ] );
					target[ key ] = value;
				} catch ( e:Error ) {
				}
			}
		}
		if ( source is Error ) {
			target.stack = ( source as Error ).getStackTrace();
		}
	}
	return target;
}