package component.touchcontrol;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Input;

import component.touchcontrol.Base;

import C;

class Right extends Base {

#if mobile

	override public function ontouchdown(e: TouchEvent) {
		if (e.x < 0.5) { // ignoring touches on the right side
			return;
		} else super.ontouchdown(e); // if on left side (as desired), call the inherited super() method
	}

#else

	override public function onmousedown(e: MouseEvent) {
		if (e.x < Main.w/2) {
			return;
		} else super.onmousedown(e);
	}

#end

}