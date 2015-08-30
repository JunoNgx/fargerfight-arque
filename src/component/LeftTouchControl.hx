package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Color;
import luxe.Vector;
import luxe.Input;

import component.BaseTouchControl;

import C;

class LeftTouchControl extends BaseTouchControl {

	override public function onmousedown(e: MouseEvent) {
		if (e.x > Main.w/2) { // ignoring touches on the right side
			return;
		} else super.onmousedown(e);
	}

}