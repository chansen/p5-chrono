MODULE = Chrono   PACKAGE = Chrono::Date

PROTOTYPES: DISABLE

chrono_date_t
new(klass, ...)
    SV *klass
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
    IV year = 1, month = 1, day = 1;
    I32 i;
    STRLEN len;
    const char *str;
  CODE:
    if (((items - 1) % 2) != 0)
        croak("Odd number of elements in call to constructor when named parameters were expected");

    for (i = 1; i < items; i += 2) {
        str = SvPV_const(ST(i), len);
        switch (chrono_param(str, len)) {
            case CHRONO_PARAM_YEAR:  year  = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_MONTH: month = SvIV(ST(i+1)); break;
            case CHRONO_PARAM_DAY:   day   = SvIV(ST(i+1)); break;
            default: croak("Unknown constructor parameter: '%s'", str);
        }
    }
    RETVAL = chrono_date_from_ymd(year, month, day);
  OUTPUT:
    RETVAL

chrono_date_t
from_string(klass, string)
    SV *klass
    SV *string
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
    const char * str;
    STRLEN len;
  CODE:
    str = SvPV_const(string, len);
    RETVAL = chrono_date_from_string(str, len);
  OUTPUT:
    RETVAL

chrono_date_t
from_yd(klass, year, day)
    SV *klass
    IV year
    IV day
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
  CODE:
    RETVAL = chrono_date_from_yd(year, day);
  OUTPUT:
    RETVAL

chrono_date_t
from_ymd(klass, year, month, day)
    SV *klass
    IV year
    IV month
    IV day
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
  CODE:
    RETVAL = chrono_date_from_ymd(year, month, day);
  OUTPUT:
    RETVAL

chrono_date_t
from_yqd(klass, year, quarter, day)
    SV *klass
    IV year
    IV quarter
    IV day
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
  CODE:
    RETVAL = chrono_date_from_yqd(year, quarter, day);
  OUTPUT:
    RETVAL

chrono_date_t
from_ywd(klass, year, week, day)
    SV *klass
    IV year
    IV week
    IV day
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
  CODE:
    RETVAL = chrono_date_from_ywd(year, week, day);
  OUTPUT:
    RETVAL

chrono_date_t
from_rdn(klass, rdn)
    SV *klass
    IV rdn
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
  CODE:
    RETVAL = chrono_date_from_rdn(rdn);
  OUTPUT:
    RETVAL

chrono_date_t
from_cjdn(klass, cjdn)
    SV *klass
    IV cjdn
  PREINIT:
    dSTASH_CONSTRUCTOR_DATE(klass);
  CODE:
    RETVAL = chrono_date_from_cjdn(cjdn);
  OUTPUT:
    RETVAL

void
year(self)
    const chrono_date_t self
  ALIAS:
    Chrono::Date::year           = 0
    Chrono::Date::quarter        = 1
    Chrono::Date::month          = 2
    Chrono::Date::week           = 3
    Chrono::Date::day_of_year    = 4
    Chrono::Date::day_of_quarter = 5
    Chrono::Date::day_of_month   = 6
    Chrono::Date::day_of_week    = 7
    Chrono::Date::rdn            = 8
    Chrono::Date::cjdn           = 9
  PREINIT:
    IV v = 0;
  CODE:
    switch (ix) {
        case 0: v = chrono_date_year(self);            break;
        case 1: v = chrono_date_quarter(self);         break;
        case 2: v = chrono_date_month(self);           break;
        case 3: v = chrono_date_week(self);            break;
        case 4: v = chrono_date_day_of_year(self);     break;
        case 5: v = chrono_date_day_of_quarter(self);  break;
        case 6: v = chrono_date_day_of_month(self);    break;
        case 7: v = chrono_date_day_of_week(self);     break;
        case 8: v = chrono_date_rdn(self);             break;
        case 9: v = chrono_date_cjdn(self);            break;
    }
    XSRETURN_IV(v);

chrono_datetime_t
at_time(self, time)
    const chrono_date_t self
    const chrono_time_t time
  PREINIT:
    dSTASH_DATETIME;
  CODE:
    RETVAL = chrono_datetime_from_date_time(self, time);
  OUTPUT:
    RETVAL

chrono_date_t
with_year(self, value)
    const chrono_date_t self
    IV value
  ALIAS:
    Chrono::Date::with_year             = 0
    Chrono::Date::with_quarter          = 1
    Chrono::Date::with_month            = 2
    Chrono::Date::with_week             = 3
    Chrono::Date::with_day_of_year      = 4
    Chrono::Date::with_day_of_quarter   = 5
    Chrono::Date::with_day_of_month     = 6
    Chrono::Date::with_day_of_week      = 7
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_date_with_year(self, value);            break;
        case 1: RETVAL = chrono_date_with_quarter(self, value);         break;
        case 2: RETVAL = chrono_date_with_month(self, value);           break;
        case 3: RETVAL = chrono_date_with_week(self, value);            break;
        case 4: RETVAL = chrono_date_with_day_of_year(self, value);     break;
        case 5: RETVAL = chrono_date_with_day_of_quarter(self, value);  break;
        case 6: RETVAL = chrono_date_with_day_of_month(self, value);    break;
        case 7: RETVAL = chrono_date_with_day_of_week(self, value);     break;
    }
  OUTPUT:
    RETVAL

chrono_date_t
at_end_of_year(self)
    const chrono_date_t self
  ALIAS:
    Chrono::Date::at_end_of_year    = 0
    Chrono::Date::at_end_of_quarter = 1
    Chrono::Date::at_end_of_month   = 2
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_date_at_end_of_year(self);      break;
        case 1: RETVAL = chrono_date_at_end_of_quarter(self);   break;
        case 2: RETVAL = chrono_date_at_end_of_month(self);     break;
    }
  OUTPUT:
    RETVAL

void
delta_years(self, other)
    const chrono_date_t self
    const chrono_date_t other
  ALIAS:
    Chrono::Date::delta_years    = 0
    Chrono::Date::delta_quarters = 1
    Chrono::Date::delta_months   = 2
    Chrono::Date::delta_weeks    = 3
    Chrono::Date::delta_days     = 4
  PREINIT:
    IV v = 0;
  CODE:
    switch (ix) {
        case 0: v = chrono_date_delta_years(self, other);      break;
        case 1: v = chrono_date_delta_quarters(self, other);   break;
        case 2: v = chrono_date_delta_months(self, other);     break;
        case 3: v = chrono_date_delta_weeks(self, other);      break;
        case 4: v = chrono_date_delta_days(self, other);       break;
    }
    XSRETURN_IV(v);

chrono_date_t
add_years(self, value)
    const chrono_date_t self
    IV value
  ALIAS:
    Chrono::Date::add_years    = 0
    Chrono::Date::add_quarters = 1
    Chrono::Date::add_months   = 2
    Chrono::Date::add_weeks    = 3
    Chrono::Date::add_days     = 4
  PREINIT:
    dSTASH_INVOCANT;
  CODE:
    RETVAL = 0;
    switch (ix) {
        case 0: RETVAL = chrono_date_add_years(self, value);    break;
        case 1: RETVAL = chrono_date_add_quarters(self, value); break;
        case 2: RETVAL = chrono_date_add_months(self, value);   break;
        case 3: RETVAL = chrono_date_add_weeks(self, value);    break;
        case 4: RETVAL = chrono_date_add_days(self, value);     break;
    }
  OUTPUT:
    RETVAL

void
is_before(self, other)
    const chrono_date_t self
    const chrono_date_t other
  ALIAS:
    Chrono::Date::is_before = 0
    Chrono::Date::is_after  = 1
    Chrono::Date::is_equal  = 2
  PREINIT:
    bool v = FALSE;
  CODE:
    switch (ix) {
        case 0: v = chrono_date_compare(self, other) < 0;  break;
        case 1: v = chrono_date_compare(self, other) > 0;  break;
        case 2: v = chrono_date_compare(self, other) == 0; break;
    }
    XSRETURN_BOOL(v);

IV
compare(self, other)
    const chrono_date_t self
    const chrono_date_t other
  CODE:
    RETVAL = chrono_date_compare(self, other);
  OUTPUT:
    RETVAL

void
to_string(self)
    const chrono_date_t self
  PPCODE:
    ST(0) = chrono_date_to_string(self);
    XSRETURN(1);

