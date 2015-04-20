using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class TixFaceView extends Ui.WatchFace {

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
//        View.onUpdate(dc);

        // Get and show the current time
        var clockTime = Sys.getClockTime();
        
		// Clear the screen
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.fillRectangle(0,0,dc.getWidth(), dc.getHeight());
        //tix.draw(dc);

		drawTix(dc, updateTix(clockTime));
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
    
    //Based on each digit, grab associated .bmp file (randomly) on a timed interval.
	function updateTix(clockTime) {
		
		//Determine how many dots are lit for each field.
		var numHr0 = clockTime.hour >= 10 ? clockTime.hour >= 20 ? 2 : 1 : 0;
		var numHr1 = clockTime.hour < 10 ? clockTime.hour : clockTime.hour - numHr0 * 10;

		
		var numMin0 = clockTime.min >= 10 ? clockTime.min >= 20 ? clockTime.min >= 30 ? clockTime.min >= 40 ? clockTime.min >= 50 ? 5 : 4 : 3 : 2 : 1 : 0;
		var numMin1 = clockTime.min < 10 ? clockTime.min : clockTime.min - numMin0 * 10;

		var hr0Bitfield = 0;
		var hr1Bitfield = 0;
		var min0Bitfield = 0;
		var min1Bitfield = 0;
		var i;
		var rand;


		//Loop hour0
		for( i = 0; i < numHr0; i++){
			//Random, key it, and draw it.
			rand = Math.rand() % 3;
			while(hr0Bitfield & (1 << rand)){
				rand = Math.rand() % 3;
			}
			hr0Bitfield |= (1 << rand);
	    }

		//Loop hour1
		for( i = 0; i < numHr1; i++){
			rand = Math.rand() % 9;
			while(hr1Bitfield & (1 << rand)){
				rand = Math.rand() % 9;
			}
     		hr1Bitfield |= (1 << rand);
		}
		
		//Loop min0
		for( i = 0; i < numMin0; i++){
			rand = Math.rand() % 6;
			while(min0Bitfield & (1 << rand)){
				rand = Math.rand() % 6;
			}
			min0Bitfield |= (1 << rand);
		}
		
		//Loop min1
		for( i = 0; i < numMin1; i++){
			rand = Math.rand() % 9;
			while(min1Bitfield & (1 << rand)){
				rand = Math.rand() % 9;
			}
			min1Bitfield |= (1 << rand);
		}
		
		//Return array of randomized blocks to illuminate.
		return [hr0Bitfield, hr1Bitfield, min0Bitfield, min1Bitfield];
	}
	
	function drawTix(dc, arrbf) {
		
		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
		// Hour 0 Top
		if( arrbf[0] & (1 << 0)){
			dc.fillRectangle(7, 54, 15, 15);
		}
		// Hour 0 Middle
		if( arrbf[0] & (1 << 1)){
			dc.fillRectangle(7, 74, 15, 15);
		}
		// Hour 0 Bottom
		if( arrbf[0] & (1 << 2)){ 
			dc.fillRectangle(7, 94, 15, 15);
		}
		
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
		// Hour 1-1 Top
		if( arrbf[1] & (1 << 0)){ 
			dc.fillRectangle(32, 54, 15, 15);
		}
		// Hour 1-2 Top
		if( arrbf[1] & (1 << 1)){
			dc.fillRectangle(52, 54, 15, 15);
		}
		// Hour 1-3 Top
		if( arrbf[1] & (1 << 2)){ 
			dc.fillRectangle(72, 54, 15, 15);
		}
		// Hour 1-1 Middle
		if( arrbf[1] & (1 << 3)){ 
			dc.fillRectangle(32, 74, 15, 15);
		}
		// Hour 1-2 Middle
		if( arrbf[1] & (1 << 4)){
			dc.fillRectangle(52, 74, 15, 15);
		}
		// Hour 1-3 Middle
		if( arrbf[1] & (1 << 5)){
			dc.fillRectangle(72, 74, 15, 15);
		}
		// Hour 1-1 Bottom
		if( arrbf[1] & (1 << 6)){
			dc.fillRectangle(32, 94, 15, 15);
		}
		// Hour 1-2 Bottom
		if( arrbf[1] & (1 << 7)){
			dc.fillRectangle(52, 94, 15, 15);
		}
		// Hour 1-3 Bottom
		if( arrbf[1] & (1 << 8)){
			dc.fillRectangle(72, 94, 15, 15);
		}
		
		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
		// Minute 0-1 Top
		if( arrbf[2] & (1 << 0)){
			dc.fillRectangle(97, 54, 15, 15);
		}
		// Minute 0-2 Top
		if( arrbf[2] & (1 << 1)){
			dc.fillRectangle(117, 54, 15, 15);
		}
		// Minute 0-1 Middle
		if( arrbf[2] & (1 << 2)){
			dc.fillRectangle(97, 74, 15, 15);
		}
		// Minute 0-2 Middle
		if( arrbf[2] & (1 << 3)){
			dc.fillRectangle(117, 74, 15, 15);
		}
		// Minute 0-1 Bottom
		if( arrbf[2] & (1 << 4)){
			dc.fillRectangle(97, 94, 15, 15);
		}
		// Minute 0-2 Bottom
		if( arrbf[2] & (1 << 5)){
			dc.fillRectangle(117, 94, 15, 15);
		
		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
		// Minute 1-1 Top
		if( arrbf[3] & (1 << 0)){
			dc.fillRectangle(142, 54, 15, 15);
		}
		// Minute 1-2 Top
		if( arrbf[3] & (1 << 1)){ 
			dc.fillRectangle(162, 54, 15, 15);
		}
		// Minute 1-3 Top
		if( arrbf[3] & (1 << 2)){ 
			dc.fillRectangle(182, 54, 15, 15);
		}
		// Minute 1-1 Middle
		if( arrbf[3] & (1 << 3)){
			dc.fillRectangle(142, 74, 15, 15);
		}
		// Minute 1-2 Middle
		if( arrbf[3] & (1 << 4)){ 
			dc.fillRectangle(162, 74, 15, 15);
		}
		// Minute 1-3 Middle
		if( arrbf[3] & (1 << 5)){ 
			dc.fillRectangle(182, 74, 15, 15);
		}
		// Minute 1-1 Bottom
		if( arrbf[3] & (1 << 6)){
			dc.fillRectangle(142, 94, 15, 15);
		}
		// Minute 1-2 Bottom
		if( arrbf[3] & (1 << 7)){ 
			dc.fillRectangle(162, 94, 15, 15);
		}
		// Minute 1-3 Bottom
		if( arrbf[3] & (1 << 8)){ 
			dc.fillRectangle(182, 94, 15, 15);
		}
	}
}}