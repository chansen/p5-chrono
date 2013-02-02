MODULE = Chrono   PACKAGE = Chrono::Duration

PROTOTYPES: DISABLE

chrono_duration_t
zero(klass, ...)
    SV *klass
  PREINIT:
    dSTASH_CONSTRUCTOR_DURATION(klass);
  CODE:
    RETVAL = 0;
  OUTPUT:
    RETVAL

chrono_duration_t
new(klass, ...)
    SV *klass
  PREINIT:
    dSTASH_CONSTRUCTOR_DURATION(klass);
    int64_t d = 0, h = 0, m = 0, s = 0, us = 0;
    I32 i;
    STRLEN len;
    const char *str;
  CODE:
    if (((items - 1) % 2) != 0)
        croak("Odd number of elements in call to constructor when named parameters were expected");

    for (i = 1; i < items; i += 2) {
        str = SvPV_const(ST(i), len);
        switch (chrono_duration_param(str, len)) {
            case CHRONO_PARAM_DAY:         d  = SvI64V(ST(i+1)); break;
            case CHRONO_PARAM_HOUR:        h  = SvI64V(ST(i+1)); break;
            case CHRONO_PARAM_MINUTE:      m  = SvI64V(ST(i+1)); break;
            case CHRONO_PARAM_SECOND:      s  = SvI64V(ST(i+1)); break;
            case CHRONO_PARAM_MICROSECOND: us = SvI64V(ST(i+1)); break;
            default: croak("Unknown constructor parameter: '%s'", str);
        }
    }
    RETVAL = chrono_duration_from_dhmsu(d, h, m, s, us);
  OUTPUT:
    RETVAL

chrono_duration_t
from_days(klass, value)
    SV *klass
    I64V value
  ALIAS:
    Chrono::Duration::from_days         = 0
    Chrono::Duration::from_hours        = 1
    Chrono::Duration::from_minutes      = 2
    Chrono::Duration::from_seconds      = 3
    Chrono::Duration::from_milliseconds = 4
    Chrono::Duration::from_microseconds = 5
  PREINIT:
    dSTASH_CONSTRUCTOR_DURATION(klass);
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_duration_from_days(value);          break;
        case 1: RETVAL = chrono_duration_from_hours(value);         break;
        case 2: RETVAL = chrono_duration_from_minutes(value);       break;
        case 3: RETVAL = chrono_duration_from_seconds(value);       break;
        case 4: RETVAL = chrono_duration_from_milliseconds(value);  break;
        case 5: RETVAL = chrono_duration_from_microseconds(value);  break;
    }
  OUTPUT:
    RETVAL

void
days(self)
    const chrono_duration_t self
  ALIAS:
    Chrono::Duration::days         = 0
    Chrono::Duration::hours        = 1
    Chrono::Duration::minutes      = 2
    Chrono::Duration::seconds      = 3
    Chrono::Duration::milliseconds = 4
    Chrono::Duration::microseconds = 5
  PREINIT:
    int64_t v = 0;
  CODE:
    switch (ix) {
        case 0: v = chrono_duration_days(self);            break;
        case 1: v = chrono_duration_hours(self);           break;
        case 2: v = chrono_duration_minutes(self);         break;
        case 3: v = chrono_duration_seconds(self);         break;
        case 4: v = chrono_duration_milliseconds(self);    break;
        case 5: v = chrono_duration_microseconds(self);    break;
    }
    XSRETURN_I64V(v);

void
total_days(self)
    const chrono_duration_t self
  ALIAS:
    Chrono::Duration::total_days         = 0
    Chrono::Duration::total_hours        = 1
    Chrono::Duration::total_minutes      = 2
    Chrono::Duration::total_seconds      = 3
    Chrono::Duration::total_milliseconds = 4
  PREINIT:
    NV v = 0;
  CODE:
    switch (ix) {
        case 0: v = chrono_duration_total_days(self);          break;
        case 1: v = chrono_duration_total_hours(self);         break;
        case 2: v = chrono_duration_total_minutes(self);       break;
        case 3: v = chrono_duration_total_seconds(self);       break;
        case 4: v = chrono_duration_total_milliseconds(self);  break;
    }
    XSRETURN_NV(v);

chrono_duration_t
add_days(self, delta)
    const chrono_duration_t self
    I64V delta
  ALIAS:
    Chrono::Duration::add_days         = 0
    Chrono::Duration::add_hours        = 1
    Chrono::Duration::add_minutes      = 2
    Chrono::Duration::add_seconds      = 3
    Chrono::Duration::add_milliseconds = 4
    Chrono::Duration::add_microseconds = 5
  PREINIT:
    dSTASH_INVOCANT;
    chrono_duration_t d = 0;
  CODE:
    if (delta == 0)
        XSRETURN(1);
    switch (ix) {
        case 0: d = chrono_duration_from_days(delta);          break;
        case 1: d = chrono_duration_from_hours(delta);         break;
        case 2: d = chrono_duration_from_minutes(delta);       break;
        case 3: d = chrono_duration_from_seconds(delta);       break;
        case 4: d = chrono_duration_from_milliseconds(delta);  break;
        case 5: d = chrono_duration_from_microseconds(delta);  break;
    }
    RETVAL = chrono_duration_add_duration(self, d);
  OUTPUT:
    RETVAL

chrono_duration_t
add_duration(self, other)
    const chrono_duration_t self
    const chrono_duration_t other
  ALIAS:
    Chrono::Duration::add_duration      = 0
    Chrono::Duration::subtract_duration = 1
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_duration_add_duration(self, other);      break;
        case 1: RETVAL = chrono_duration_subtract_duration(self, other); break;
    }
  OUTPUT:
    RETVAL

chrono_duration_t
abs(self)
    const chrono_duration_t self
  ALIAS:
    Chrono::Duration::abs    = 0
    Chrono::Duration::negate = 1
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: 
            RETVAL = chrono_duration_abs(self);
            if (RETVAL == self)
                XSRETURN(1);
            break;
        case 1: 
            RETVAL = chrono_duration_negate(self);
            break;
    }
  OUTPUT:
    RETVAL

void
is_zero(self)
    const chrono_duration_t self
  ALIAS:
    Chrono::Duration::is_zero       = 0
    Chrono::Duration::is_negative   = 1
    Chrono::Duration::is_positive   = 2
  PREINIT:
    bool v = FALSE;
  CODE:
    switch (ix) {
        case 0: v = chrono_duration_is_zero(self);      break;
        case 1: v = chrono_duration_is_negative(self);  break;
        case 2: v = chrono_duration_is_positive(self);  break;
    }
    XSRETURN_BOOL(v);

IV
compare(self, other)
    const chrono_duration_t self
    const chrono_duration_t other
  CODE:
    RETVAL = chrono_duration_compare(self, other);
  OUTPUT:
    RETVAL

