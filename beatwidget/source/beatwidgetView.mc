import Toybox.Graphics;
import Toybox.Time;
import Toybox.System;
import Toybox.WatchUi;

class beatwidgetGlanceView extends WatchUi.GlanceView {
    hidden var myText;
    hidden var myLabel;

    function initialize() {
        GlanceView.initialize();
    }

    function onShow() {
        myText = new WatchUi.Text({
            :font=>Graphics.FONT_GLANCE_NUMBER
        });

        myLabel = new WatchUi.Text({
            :text=>"BEAT",
            :font=>Graphics.FONT_GLANCE
        });
    }

    function onUpdate(dc) {
        var clockTime = Time.now();
        var oneHour = new Time.Duration(Time.Gregorian.SECONDS_PER_HOUR);
        clockTime = clockTime.add(oneHour);
        var beatTime = (clockTime.value() % Time.Gregorian.SECONDS_PER_DAY) / 86.4;
        var timeString = Lang.format("\n.$1$", [beatTime.format("%d")]);
        myText.setText(timeString);
        dc.clear();
        myText.draw(dc);
        myLabel.draw(dc);
    }
}

class beatwidgetView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = Time.now();
        var oneHour = new Time.Duration(Time.Gregorian.SECONDS_PER_HOUR);
        clockTime = clockTime.add(oneHour);
        var beatTime = (clockTime.value() % Time.Gregorian.SECONDS_PER_DAY) / 86.4;
        var timeString = Lang.format(".$1$", [beatTime.format("%d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
