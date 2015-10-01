package component;

import luxe.Component;
import luxe.options.ComponentOptions;

import luxe.Input;

import component.BaseTouchControl;

import C;

class RightTouchControl extends BaseTouchControl {

	override public function onmousedown(e: MouseEvent) {
		if (e.x < Main.w/2) { // ignoring touches on the left side
			return;
		} else super.onmousedown(e);
	}

}