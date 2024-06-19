package com.softskillz.util;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.pattern.color.ANSIConstants;
import ch.qos.logback.core.pattern.color.ForegroundCompositeConverterBase;

public class MyCustomHighlighting extends ForegroundCompositeConverterBase<ILoggingEvent> {

    @Override
    protected String getForegroundColorCode(ILoggingEvent event) {
        Level level = event.getLevel();
        switch (level.toInt()) {
        case Level.ERROR_INT:
            return ANSIConstants.BOLD + ANSIConstants.RED_FG; // same as default color scheme
        case Level.WARN_INT:
            return ANSIConstants.BOLD + ANSIConstants.YELLOW_FG;// same as default color scheme
        case Level.INFO_INT:
            return ANSIConstants.BOLD + ANSIConstants.GREEN_FG; // use CYAN instead of BLUE
        case Level.DEBUG_INT:
            return ANSIConstants.BOLD + ANSIConstants.WHITE_FG; 

        default:
            return ANSIConstants.DEFAULT_FG;
        }
    }

}