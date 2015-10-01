package component.touchcontrol;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Input;

import component.touchcontrol.Base;

import C;

class Left extends Base {

	override public function onmousedown(e: MouseEvent) {
		if (e.x > Main.w/2) { // ignoring touches on the right side
			return;
		} else super.onmousedown(e); // if on left side (as desired), call the inherited super() method
	}

}