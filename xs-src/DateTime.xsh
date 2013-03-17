MODULE = Chrono   PACKAGE = Chrono::DateTime

PROTOTYPES: DISABLE

chrono_datetime_t
new(klass, ...)
    SV *klass
  PREINIT:
    dSTASH_CONSTRUCTOR_DATETIME(klass);
    IV year = 1, month  = 1, day    = 1;
    IV hour = 0, minute = 0, second = 0, microsecond = 0;
    I32 i;
    STRLEN len;
    const char *str;
    chrono_date_t date;
    chrono_time_t time;
  CODE:
    if (((items - 1) % 2) != 0)
        croak("Odd number of elements in call to constructor when named parameters were expected");

    for (i = 1; i < items; i += 2) {
        str = SvPV_const(ST(i), len);
        switch (chrono_param(str, len)) {
            case CHRONO_PARAM_YEAR:        year        = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_MONTH:       month       = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_DAY:         day         = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_HOUR:        hour        = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_MINUTE:      minute      = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_SECOND:      second      = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_MICROSECOND: microsecond = SvIV(ST(i+1)); break;
            default: croak("Unknown constructor parameter: '%s'", str);
        }
    }
    date = chrono_date_from_ymd(year, month, day);
    time = chrono_time_from_hmsu(hour, minute, second, microsecond);
    RETVAL = chrono_datetime_from_date_time(date, time);
  OUTPUT:
    RETVAL

chrono_datetime_t
from_date(klass, date, time=0)
    SV *klass
    chrono_date_t date
    chrono_time_t time
  PREINIT:
    dSTASH_CONSTRUCTOR_DATETIME(klass);
  CODE:
    RETVAL = chrono_datetime_from_date_time(date, time);
  OUTPUT:
    RETVAL

chrono_datetime_t
from_epoch(klass, seconds, microsecond=0)
    SV *klass
    I64V seconds
    I64V microsecond
  PREINIT:
    dSTASH_CONSTRUCTOR_DATETIME(klass);
  CODE:
    RETVAL = chrono_datetime_from_epoch(seconds, microsecond);
  OUTPUT:
    RETVAL

void
epoch(self)
    const chrono_datetime_t self
  ALIAS:
    Chrono::DateTime::epoch               = 0
    Chrono::DateTime::utc_rd_as_seconds   = 1
    Chrono::DateTime::local_rd_as_seconds = 2
  PREINIT:
    int64_t v = 0;
  PPCODE:
    switch (ix) {
        case 0: v = chrono_datetime_epoch(self);            break;
        case 1: v = chrono_datetime_rdn_as_seconds(self);   break;
        case 2: v = chrono_datetime_rdn_as_seconds(self);   break;
    }
    XSRETURN_I64V(v);

chrono_date_t
date(self)
    const chrono_datetime_t self
  PREINIT:
    dSTASH_DATE;
  CODE:
    RETVAL = chrono_datetime_date(self);
  OUTPUT:
    RETVAL

chrono_time_t
time(self)
    const chrono_datetime_t self
  PREINIT:
    dSTASH_TIME;
  CODE:
    RETVAL = chrono_datetime_time(self);
  OUTPUT:
    RETVAL

void
utc_rd_values(self)
    const chrono_datetime_t self
  ALIAS:
    Chrono::DateTime::utc_rd_values   = 0
    Chrono::DateTime::local_rd_values = 1
  PREINIT:
    const chrono_time_t t = chrono_datetime_time(self);
    const chrono_date_t d = chrono_datetime_date(self);
  PPCODE:
    PERL_UNUSED_VAR(ix);
    EXTEND(SP, 3);
    mPUSHi(chrono_date_rdn(d));
    mPUSHi(chrono_time_second_of_day(t));
    mPUSHi(chrono_time_microsecond(t) * 1000);
    XSRETURN(3);

void
year(self)
    const chrono_datetime_t self
  ALIAS:
    Chrono::DateTime::year           = 0
    Chrono::DateTime::quarter        = 1
    Chrono::DateTime::month          = 2
    Chrono::DateTime::week           = 3
    Chrono::DateTime::day_of_year    = 4
    Chrono::DateTime::day_of_quarter = 5
    Chrono::DateTime::day_of_month   = 6
    Chrono::DateTime::day_of_week    = 7
    Chrono::DateTime::rdn            = 8
    Chrono::DateTime::cjdn           = 9
  PREINIT:
    const chrono_date_t d = chrono_datetime_date(self);
    IV v = 0;
  PPCODE:
    switch (ix) {
        case 0: v = chrono_date_year(d);             break;
        case 1: v = chrono_date_quarter(d);          break;
        case 2: v = chrono_date_month(d);            break;
        case 3: v = chrono_date_week(d);             break;
        case 4: v = chrono_date_day_of_year(d);      break;
        case 5: v = chrono_date_day_of_quarter(d);   break;
        case 6: v = chrono_date_day_of_month(d);     break;
        case 7: v = chrono_date_day_of_week(d);      break;
        case 8: v = chrono_date_rdn(d);              break;
        case 9: v = chrono_date_cjdn(d);             break;
    }
    XSRETURN_IV(v);

void
hour(self)
    const chrono_datetime_t self
  ALIAS:
    Chrono::DateTime::hour        = 0
    Chrono::DateTime::minute      = 1
    Chrono::DateTime::second      = 2
    Chrono::DateTime::millisecond = 3
    Chrono::DateTime::microsecond = 4
  PREINIT:
    const chrono_time_t t = chrono_datetime_time(self);
    IV v = 0;
  PPCODE:
    switch (ix) {
        case 0: v = chrono_time_hour(t);        break;
        case 1: v = chrono_time_minute(t);      break;
        case 2: v = chrono_time_second(t);      break;
        case 3: v = chrono_time_millisecond(t); break;
        case 4: v = chrono_time_microsecond(t); break;
    }
    XSRETURN_IV(v);

NV
cjd(self)
    const chrono_datetime_t self
  CODE:
    RETVAL = chrono_datetime_cjd(self);
  OUTPUT:
    RETVAL

chrono_datetime_t
with_date(self, date)
    const chrono_datetime_t self
    const chrono_date_t date
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = chrono_datetime_with_date(self, date);
  OUTPUT:
    RETVAL

chrono_datetime_t
with_time(self, time)
    const chrono_datetime_t self
    const chrono_time_t time
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = chrono_datetime_with_time(self, time);
  OUTPUT:
    RETVAL

chrono_datetime_t
with_year(self, value)
    const chrono_datetime_t self
    IV value
  ALIAS:
    Chrono::DateTime::with_year           = 0
    Chrono::DateTime::with_quarter        = 1
    Chrono::DateTime::with_month          = 2
    Chrono::DateTime::with_week           = 3
    Chrono::DateTime::with_day_of_year    = 4
    Chrono::DateTime::with_day_of_quarter = 5
    Chrono::DateTime::with_day_of_month   = 6
    Chrono::DateTime::with_day_of_week    = 7
  PREINIT:
    dSTASH_INVOCANT;
    chrono_date_t d = chrono_datetime_date(self);
  CODE:
    switch (ix) {
        case 0: d = chrono_date_with_year(d, value);            break;
        case 1: d = chrono_date_with_quarter(d, value);         break;
        case 2: d = chrono_date_with_month(d, value);           break;
        case 3: d = chrono_date_with_week(d, value);            break;
        case 4: d = chrono_date_with_day_of_year(d, value);     break;
        case 5: d = chrono_date_with_day_of_quarter(d, value);  break;
        case 6: d = chrono_date_with_day_of_month(d, value);    break;
        case 7: d = chrono_date_with_day_of_week(d, value);     break;
    }
    RETVAL = chrono_datetime_with_date(self, d);
  OUTPUT:
    RETVAL

chrono_datetime_t
with_hour(self, value)
    const chrono_datetime_t self
    IV value
  ALIAS:
    Chrono::DateTime::with_hour        = 0
    Chrono::DateTime::with_minute      = 1
    Chrono::DateTime::with_second      = 2
    Chrono::DateTime::with_millisecond = 3
    Chrono::DateTime::with_microsecond = 4
  PREINIT:
    dSTASH_INVOCANT;
    chrono_time_t t = chrono_datetime_time(self);
  CODE:
    switch (ix) {
        case 0: t = chrono_time_with_hour(t, value);        break;
        case 1: t = chrono_time_with_minute(t, value);      break;
        case 2: t = chrono_time_with_second(t, value);      break;
        case 3: t = chrono_time_with_millisecond(t, value); break;
        case 4: t = chrono_time_with_microsecond(t, value); break;
    }
    RETVAL = chrono_datetime_with_time(self, t);
  OUTPUT:
    RETVAL

void
delta_years(self, other)
    const chrono_datetime_t self
    const chrono_datetime_t other
  ALIAS:
    Chrono::DateTime::delta_years    = 0
    Chrono::DateTime::delta_quarters = 1
    Chrono::DateTime::delta_months   = 2
    Chrono::DateTime::delta_weeks    = 3
    Chrono::DateTime::delta_days     = 4
  PREINIT:
    const chrono_date_t sd = chrono_datetime_date(self);
    const chrono_date_t od = chrono_datetime_date(other);
    IV v = 0;
  PPCODE:
    switch (ix) {
        case 0: v = chrono_date_delta_years(sd, od);    break;
        case 1: v = chrono_date_delta_quarters(sd, od); break;
        case 2: v = chrono_date_delta_months(sd, od);   break;
        case 3: v = chrono_date_delta_weeks(sd, od);    break;
        case 4: v = chrono_date_delta_days(sd, od);     break;
    }
    XSRETURN_IV(v);

void
delta_hours(self, other)
    const chrono_datetime_t self
    const chrono_datetime_t other
  ALIAS:
    Chrono::DateTime::delta_hours        = 0
    Chrono::DateTime::delta_minutes      = 1
    Chrono::DateTime::delta_seconds      = 2
    Chrono::DateTime::delta_milliseconds = 3
  PREINIT:
    const chrono_duration_t d = chrono_datetime_subtract_datetime(other, self);
    int64_t v = 0;
  PPCODE:
    switch (ix) {
        case 0: v = chrono_duration_hours(d);           break;
        case 1: v = chrono_duration_minutes(d);         break;
        case 2: v = chrono_duration_seconds(d);         break;
        case 3: v = chrono_duration_milliseconds(d);    break;
    }
    XSRETURN_I64V(v);

chrono_datetime_t
plus_years(self, delta)
    const chrono_datetime_t self
    IV delta
  ALIAS:
    Chrono::DateTime::plus_years    = 0
    Chrono::DateTime::plus_quarters = 1
    Chrono::DateTime::plus_months   = 2
    Chrono::DateTime::plus_weeks    = 3
    Chrono::DateTime::plus_days     = 4
  PREINIT:
    dSTASH_INVOCANT;
    chrono_date_t d = chrono_datetime_date(self);
  CODE:
    if (delta == 0)
        XSRETURN(1);
    switch (ix) {
        case 0: d = chrono_date_add_years(d, delta);    break;
        case 1: d = chrono_date_add_quarters(d, delta); break;
        case 2: d = chrono_date_add_months(d, delta);   break;
        case 3: d = chrono_date_add_weeks(d, delta);    break;
        case 4: d = chrono_date_add_days(d, delta);     break;
    }
    RETVAL = chrono_datetime_with_date(self, d);
  OUTPUT:
    RETVAL

chrono_datetime_t
plus_hours(self, delta)
    const chrono_datetime_t self
    I64V delta
  ALIAS:
    Chrono::DateTime::plus_hours        = 0
    Chrono::DateTime::plus_minutes      = 1
    Chrono::DateTime::plus_seconds      = 2
    Chrono::DateTime::plus_milliseconds = 3
    Chrono::DateTime::plus_microseconds = 4
  PREINIT:
    dSTASH_INVOCANT;
    chrono_duration_t d = 0;
  CODE:
    if (delta == 0)
        XSRETURN(1);
    switch (ix) {
        case 0: d = chrono_duration_from_hours(delta);          break;
        case 1: d = chrono_duration_from_minutes(delta);        break;
        case 2: d = chrono_duration_from_seconds(delta);        break;
        case 3: d = chrono_duration_from_milliseconds(delta);   break;
        case 4: d = chrono_duration_from_microseconds(delta);   break;
    }
    RETVAL = chrono_datetime_add_duration(self, d);
  OUTPUT:
    RETVAL

chrono_duration_t
minus_datetime(self, other)
    const chrono_datetime_t self
    const chrono_datetime_t other
  PREINIT:
    dSTASH_DURATION;
  CODE:
    RETVAL = chrono_datetime_subtract_datetime(self, other);
  OUTPUT:
    RETVAL

chrono_datetime_t
plus_duration(self, duration)
    const chrono_datetime_t self
    const chrono_duration_t duration
  ALIAS:
    Chrono::DateTime::plus_duration  = 0
    Chrono::DateTime::minus_duration = 1
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_datetime_add_duration(self, duration);      break;
        case 1: RETVAL = chrono_datetime_subtract_duration(self, duration); break;
    }
  OUTPUT:
    RETVAL

void
is_before(self, other)
    const chrono_datetime_t self
    const chrono_datetime_t other
  ALIAS:
    Chrono::DateTime::is_before = 0
    Chrono::DateTime::is_after  = 1
    Chrono::DateTime::is_equal  = 2
  PREINIT:
    bool v = FALSE;
  CODE:
    switch (ix) {
        case 0: v = chrono_datetime_compare(self, other) < 0;  break;
        case 1: v = chrono_datetime_compare(self, other) > 0;  break;
        case 2: v = chrono_datetime_compare(self, other) == 0; break;
    }
    XSRETURN_BOOL(v);

IV
compare(self, other)
    const chrono_datetime_t self
    const chrono_datetime_t other
  CODE:
    RETVAL = chrono_datetime_compare(self, other);
  OUTPUT:
    RETVAL

void
to_string(self, precision=6)
    const chrono_datetime_t self
    IV precision
  PPCODE:
    ST(0) = chrono_datetime_to_string(self, precision);
    XSRETURN(1);

