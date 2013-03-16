MODULE = Chrono   PACKAGE = Chrono::Time

PROTOTYPES: DISABLE

chrono_time_t
new(klass, ...)
    SV *klass
  PREINIT:
    dSTASH_CONSTRUCTOR_TIME(klass);
    IV h = 0, m = 0, s = 0, us = 0;
    I32 i;
    STRLEN len;
    const char *str;
  CODE:
    if (((items - 1) % 2) != 0)
        croak("Odd number of elements in call to constructor when named parameters were expected");

    for (i = 1; i < items; i += 2) {
        str = SvPV_const(ST(i), len);
        switch (chrono_param(str, len)) {
            case CHRONO_PARAM_HOUR:        h  = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_MINUTE:      m  = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_SECOND:      s  = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_MICROSECOND: us = SvIV(ST(i+1)); break;
            default: croak("Unknown constructor parameter: '%s'", str);
        }
    }
    RETVAL = chrono_time_from_hmsu(h, m, s, us);
  OUTPUT:
    RETVAL

chrono_time_t
from_hms(klass, hour, minute, second, microsecond=0)
    SV *klass
    IV hour
    IV minute
    IV second
    IV microsecond
  PREINIT:
    dSTASH_CONSTRUCTOR_TIME(klass);
  CODE:
    RETVAL = chrono_time_from_hmsu(hour, minute, second, microsecond);
  OUTPUT:
    RETVAL

chrono_time_t
midnight(klass)
    SV *klass
  ALIAS:
    Chrono::Time::midnight = 0
    Chrono::Time::noon     = 12
  PREINIT:
    dSTASH_CONSTRUCTOR_TIME(klass);
  CODE:
    RETVAL = chrono_time_from_hmsu(ix, 0, 0, 0);
  OUTPUT:
    RETVAL

void
hour(self)
    const chrono_time_t self
  ALIAS:
    Chrono::Time::hour          = 0
    Chrono::Time::minute        = 1
    Chrono::Time::second        = 2
    Chrono::Time::millisecond   = 3
    Chrono::Time::microsecond   = 4
  PREINIT:
    IV v = 0;
  CODE:
    switch (ix) {
        case 0: v = chrono_time_hour(self);            break;
        case 1: v = chrono_time_minute(self);          break;
        case 2: v = chrono_time_second(self);          break;
        case 3: v = chrono_time_millisecond(self);     break;
        case 4: v = chrono_time_microsecond(self);     break;
    }
    XSRETURN_IV(v);

chrono_datetime_t
at_date(self, date)
    const chrono_time_t self
    const chrono_date_t date
  PREINIT:
    dSTASH_DATETIME;
  CODE:
    RETVAL = chrono_datetime_from_date_time(date, self);
  OUTPUT:
    RETVAL

chrono_time_t
with_hour(self, value)
    const chrono_time_t self
    IV value
  ALIAS:
    Chrono::Time::with_hour        = 0
    Chrono::Time::with_minute      = 1
    Chrono::Time::with_second      = 2
    Chrono::Time::with_millisecond = 3
    Chrono::Time::with_microsecond = 4
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_time_with_hour(self, value);        break;
        case 1: RETVAL = chrono_time_with_minute(self, value);      break;
        case 2: RETVAL = chrono_time_with_second(self, value);      break;
        case 3: RETVAL = chrono_time_with_millisecond(self, value); break;
        case 4: RETVAL = chrono_time_with_microsecond(self, value); break;
    }
  OUTPUT:
    RETVAL

void
delta_hours(self, other)
    const chrono_time_t self
    const chrono_time_t other
  ALIAS:
    Chrono::Time::delta_hours        = 0
    Chrono::Time::delta_minutes      = 1
    Chrono::Time::delta_seconds      = 2
    Chrono::Time::delta_milliseconds = 3
    Chrono::Time::delta_microseconds = 4
  PREINIT:
    int64_t v = 0;
  PPCODE:
    switch (ix) {
        case 0: v = chrono_time_delta_hours(self, other);           break;
        case 1: v = chrono_time_delta_minutes(self, other);         break;
        case 2: v = chrono_time_delta_seconds(self, other);         break;
        case 3: v = chrono_time_delta_milliseconds(self, other);    break;
        case 4: v = chrono_time_delta_microseconds(self, other);    break;
    }
    XSRETURN_I64V(v);

chrono_time_t
plus_hours(self, value)
    const chrono_time_t self
    IV value
  ALIAS:
    Chrono::Time::plus_hours         = 0
    Chrono::Time::plus_minutes       = 1
    Chrono::Time::plus_seconds       = 2
    Chrono::Time::plus_milliseconds  = 3
    Chrono::Time::plus_microseconds  = 4
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_time_add_hours(self, value);        break;
        case 1: RETVAL = chrono_time_add_minutes(self, value);      break;
        case 2: RETVAL = chrono_time_add_seconds(self, value);      break;
        case 3: RETVAL = chrono_time_add_milliseconds(self, value); break;
        case 4: RETVAL = chrono_time_add_microseconds(self, value); break;
    }
  OUTPUT:
    RETVAL

void
is_before(self, other)
    const chrono_time_t self
    const chrono_time_t other
  ALIAS:
    Chrono::Time::is_before = 0
    Chrono::Time::is_after  = 1
    Chrono::Time::is_equal  = 2
  PREINIT:
    bool v = FALSE;
  CODE:
    switch (ix) {
        case 0: v = chrono_time_compare(self, other) < 0;  break;
        case 1: v = chrono_time_compare(self, other) > 0;  break;
        case 2: v = chrono_time_compare(self, other) == 0; break;
    }
    XSRETURN_BOOL(v);

IV
compare(self, other)
    const chrono_time_t self
    const chrono_time_t other
  CODE:
    RETVAL = chrono_time_compare(self, other);
  OUTPUT:
    RETVAL

void
to_string(self, precision=6)
    const chrono_time_t self
    IV precision
  PPCODE:
    ST(0) = chrono_time_to_string(self, precision);
    XSRETURN(1);

