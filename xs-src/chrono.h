#ifndef __CHRONO_H__
#define __CHRONO_H__
#include "dt.h"

#ifndef _MSC_VER
#  include <stdint.h>
#else
#  if _MSC_VER >= 1600
#   include <stdint.h>
#  else
    typedef __int32             int32_t;
    typedef __int64             int64_t;
    typedef unsigned __int32    uint32_t;
    typedef unsigned __int64    uint64_t;
#  endif
#  ifndef INT64_C
#   define INT64_C(x) x##i64
#  endif
#endif

typedef dt_t     chrono_date_t;
typedef int64_t  chrono_time_t;
typedef uint64_t chrono_datetime_t;
typedef int64_t  chrono_duration_t;

typedef enum {
    CHRONO_PARAM_UNKNOWN=0,
    CHRONO_PARAM_YEAR,
    CHRONO_PARAM_MONTH,
    CHRONO_PARAM_DAY,
    CHRONO_PARAM_HOUR,
    CHRONO_PARAM_MINUTE,
    CHRONO_PARAM_SECOND,
    CHRONO_PARAM_MICROSECOND,
} chrono_param_t;

#define USECS_PER_WEEK          INT64_C(604800000000)
#define USECS_PER_DAY           INT64_C(86400000000)
#define USECS_PER_HOUR          INT64_C(3600000000)
#define USECS_PER_MINUTE        INT64_C(60000000)
#define USECS_PER_SECOND        INT64_C(1000000)
#define USECS_PER_MILLISECOND   INT64_C(1000)

#define MAX_DELTA_YEARS         INT64_C(10000)
#define MAX_DELTA_QUARTERS      INT64_C(40000)
#define MAX_DELTA_MONTHS        INT64_C(120000)
#define MAX_DELTA_WEEKS         INT64_C(521775)
#define MAX_DELTA_DAYS          INT64_C(3652425)
#define MAX_DELTA_HOURS         INT64_C(87658200)
#define MAX_DELTA_MINUTES       INT64_C(5259492000)
#define MAX_DELTA_SECONDS       INT64_C(315569520000)
#define MAX_DELTA_MILLISECONDS  INT64_C(315569520000000)
#define MAX_DELTA_MICROSECONDS  INT64_C(315569520000000000)

#define MIN_YEAR                1
#define MAX_YEAR                9999

#define MIN_DATE                1                               /* 0001-01-01 */
#define MAX_DATE                3652059                         /* 9999-12-31 */

#define MIN_TIME                INT64_C(0)                      /* 00:00:00.000000 */
#define MAX_TIME                INT64_C(86399999999)            /* 23:59:59.999999 */

#define MIN_DATETIME            INT64_C(86400000000)
#define MAX_DATETIME            INT64_C(315537983999999999)

#define MIN_DURATION            INT64_C(-315569520000000000)
#define MAX_DURATION            INT64_C(315569520000000000)

#define MIN_RDN                 MIN_DATE
#define MAX_RDN                 MAX_DATE

#define MIN_CJDN                1721426
#define MAX_CJDN                5373484

#define UNIX_EPOCH              INT64_C(62135683200)            /* 1970-01-01T00:00:00 */
#define CJDN_EPOCH              1721425

#define MIN_EPOCH_DAY           -719162
#define MAX_EPOCH_DAY           2932896

#define MIN_EPOCH_SECONDS       INT64_C(-62135596800)           /* 0001-01-01T00:00:00 */
#define MAX_EPOCH_SECONDS       INT64_C(253402300799)           /* 9999-12-31T23:59:59 */

#define VALID_RDN(d) \
    (d >= MIN_RDN && d <= MAX_RDN)

#define VALID_CJDN(d) \
    (d >= MIN_CJDN && d <= MAX_CJDN)

#define VALID_EPOCH_DAY(s) \
    (s >= MIN_EPOCH_DAY && s <= MAX_EPOCH_DAY)

#define VALID_EPOCH_SECONDS(s) \
    (s >= MIN_EPOCH_SECONDS && s <= MAX_EPOCH_SECONDS)

#define VALID_DATE(d) \
    (d >= MIN_DATE && d <= MAX_DATE)

#define VALID_TIME(t) \
    (t >= MIN_TIME && t <= MAX_TIME)

#define VALID_DATETIME(d) \
    (d >= MIN_DATETIME && d <= MAX_DATETIME)

#define VALID_DURATION(d) \
    (d >= MIN_DURATION && d <= MAX_DURATION)

#define VALID_YEAR(y) \
    (y >= MIN_YEAR && y <= MAX_YEAR)

#define VALID_YEARS_DELTA(m) \
    (m >= -MAX_DELTA_YEARS && m <= MAX_DELTA_YEARS)

#define VALID_QUARTERS_DELTA(m) \
    (m >= -MAX_DELTA_QUARTERS && m <= MAX_DELTA_QUARTERS)

#define VALID_MONTHS_DELTA(m) \
    (m >= -MAX_DELTA_MONTHS && m <= MAX_DELTA_MONTHS)

#define VALID_WEEKS_DELTA(m) \
    (m >= -MAX_DELTA_WEEKS && m <= MAX_DELTA_WEEKS)

#define VALID_DAYS_DELTA(m) \
    (m >= -MAX_DELTA_DAYS && m <= MAX_DELTA_DAYS)

#define VALID_HOURS_DELTA(m) \
    (m >= -MAX_DELTA_HOURS && m <= MAX_DELTA_HOURS)

#define VALID_MINUTES_DELTA(m) \
    (m >= -MAX_DELTA_MINUTES && m <= MAX_DELTA_MINUTES)

#define VALID_SECONDS_DELTA(m) \
    (m >= -MAX_DELTA_SECONDS && m <= MAX_DELTA_SECONDS)

#define VALID_MILLISECONDS_DELTA(m) \
    (m >= -MAX_DELTA_MILLISECONDS && m <= MAX_DELTA_MILLISECONDS)

#define VALID_MICROSECONDS_DELTA(m) \
    (m >= -MAX_DELTA_MICROSECONDS && m <= MAX_DELTA_MICROSECONDS)

static chrono_param_t
chrono_param(const char *s, const STRLEN len) {
    switch (len) {
        case 3:
            if (memEQ(s, "day", 3))
                return CHRONO_PARAM_DAY;
            break;
        case 4:
            if (memEQ(s, "year", 4))
                return CHRONO_PARAM_YEAR;
            if (memEQ(s, "hour", 4))
                return CHRONO_PARAM_HOUR;
            break;
        case 5:
            if (memEQ(s, "month", 5))
                return CHRONO_PARAM_MONTH;
            break;
        case 6:
            if (memEQ(s, "minute", 6))
                return CHRONO_PARAM_MINUTE;
            if (memEQ(s, "second", 6))
                return CHRONO_PARAM_SECOND;
            break;
        case 11:
            if (memEQ(s, "microsecond", 11))
                return CHRONO_PARAM_MICROSECOND;
            break;
    }
    return CHRONO_PARAM_UNKNOWN;
}

static chrono_param_t
chrono_duration_param(const char *s, STRLEN len) {
    if (len < 4 || s[len - 1] != 's')
        return CHRONO_PARAM_UNKNOWN;
    else
        return chrono_param(s, len - 1);
}


#define CHR(n, d) (char)('0' + ((n) / (d)) % 10)

static char *
chrono_format_number(char *d, const UV n, const size_t len) {
    switch (len) {
        case 6: d[len - 6] = CHR(n, 100000);
        case 5: d[len - 5] = CHR(n, 10000);
        case 4: d[len - 4] = CHR(n, 1000);
        case 3: d[len - 3] = CHR(n, 100);
        case 2: d[len - 2] = CHR(n, 10);
        case 1: d[len - 1] = CHR(n, 1);
            d += len;
            break;
    }
    return d;
}

static char *
chrono_format_microsecond(char *d, const UV n, const size_t len) {
    switch (len) {
        case 6: d[5] = CHR(n, 1);
        case 5: d[4] = CHR(n, 10);
        case 4: d[3] = CHR(n, 100);
        case 3: d[2] = CHR(n, 1000);
        case 2: d[1] = CHR(n, 10000);
        case 1: d[0] = CHR(n, 100000);
            d += len;
            break;
    }
    return d;
}

#undef CHR

size_t
chrono_i64toa(int64_t v, char *d, size_t len) {
    char buf[30], *p, *e;
    size_t n;

    p = e = buf + sizeof(buf);
    if (v < 0) {
        do {
            *--p = '0' - (v % 10);
        } while (v /= 10);

        *--p = '-';
    }
    else {
        do {
            *--p = '0' + (v % 10);
        } while (v /= 10);
    }

    n = e - p;
    if (n > len)
        return 0;
    memcpy(d, p, n);
    return n;
}

/* Chrono::Date */

static chrono_date_t
THX_chrono_date_from_string(pTHX_ const char *str, STRLEN len) {
    chrono_date_t res;

    if (len != dt_parse_string(str, len, &res))
        croak("Cannot parse given string: '%s'", str);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_from_rdn(pTHX_ IV rdn) {
    if (!VALID_DATE(rdn))
        croak("Parameter 'rdn' is out of the range of valid values");
    return dt_from_rdn(rdn);
}

static chrono_date_t
THX_chrono_date_from_cjdn(pTHX_ IV cjdn) {
    if (!VALID_CJDN(cjdn))
        croak("Parameter 'cjdn' is out of the range of valid values");
    return dt_from_cjdn(cjdn);
}

static chrono_date_t
THX_chrono_date_from_yd(pTHX_ IV y, IV d) {
    if (y < 1 || y > 9999)
        croak("Parameter 'year' is out of the range [1, 9999]");
    if (d < 1 || (d > 365 && d > dt_days_in_year(y)))
        croak("Parameter 'day' is out of the range [1, %d]", dt_days_in_year(y));
    return dt_from_yd(y, d);
}

static chrono_date_t
THX_chrono_date_from_ymd(pTHX_ IV y, IV m, IV d) {
    if (y < 1 || y > 9999)
        croak("Parameter 'year' is out of the range [1, 9999]");
    if (m < 1 || m > 12)
        croak("Parameter 'month' is out of the range [1, 12]");
    if (d < 1 || (d > 28 && d > dt_days_in_month(y, m)))
        croak("Parameter 'day' is out of the range [1, %d]", dt_days_in_month(y, m));
    return dt_from_ymd(y, m, d);
}

static chrono_date_t
THX_chrono_date_from_yqd(pTHX_ IV y, IV q, IV d) {
    if (y < 1 || y > 9999)
        croak("Parameter 'year' is out of the range [1, 9999]");
    if (q < 1 || q > 4)
        croak("Parameter 'quarter' is out of the range [1, 4]");
    if (d < 1 || (d > 90 && d > dt_days_in_quarter(y, q)))
        croak("Parameter 'day' is out of the range [1, %d]", dt_days_in_quarter(y, q));
    return dt_from_yqd(y, q, d);
}

static chrono_date_t
THX_chrono_date_from_ywd(pTHX_ IV y, IV w, IV d) {
    chrono_date_t res;

    if (y < 1 || y > 9999)
        croak("Parameter 'year' is out of the range [1, 9999]");
    if (w < 1 || (w > 52 && w > dt_weeks_in_year(y)))
        croak("Parameter 'week' is out of the range [1, %d]", dt_weeks_in_year(y));
    if (d < 1 || d > 7)
        croak("Parameter 'day' is out of the range [1, 7]");
    res = dt_from_ywd(y, w, d);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_with_year(pTHX_ chrono_date_t date, IV y) {
    int d, diy;

    if (y < 1 || y > 9999)
        croak("Parameter 'year' is out of the range [1, 9999]");
    d = dt_day_of_year(date);
    if (d > 365 && d > (diy = dt_days_in_year(y)))
        d = diy;
    return dt_from_yd(y, d);
}

static chrono_date_t
THX_chrono_date_with_quarter(pTHX_ chrono_date_t date, IV q) {
    int y, d, diq;

    if (q < 1 || q > 4)
        croak("Parameter 'quarter' is out of the range [1, 4]");
    dt_to_yqd(date, &y, NULL, &d);
    if (d > 90 && d > (diq = dt_days_in_quarter(y, q)))
        d = diq;
    return dt_from_yqd(y, q, d);
}

static chrono_date_t
THX_chrono_date_with_month(pTHX_ chrono_date_t date, IV m) {
    int y, d, dim;

    if (m < 1 || m > 12)
        croak("Parameter 'month' is out of the range [1, 12]");
    dt_to_ymd(date, &y, NULL, &d);
    if (d > 28 && d > (dim = dt_days_in_month(y, m)))
        d = dim;
    return dt_from_ymd(y, m, d);
}

static chrono_date_t
THX_chrono_date_with_week(pTHX_ chrono_date_t date, IV w) {
    chrono_date_t res;
    int y, d;

    dt_to_ywd(date, &y, NULL, &d);
    if (w < 1 || (w > 52 && w > dt_weeks_in_year(y)))
        croak("Parameter 'week' is out of the range [1, %d]", dt_weeks_in_year(y));
    res = dt_from_ywd(y, w, d);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_with_day_of_year(pTHX_ chrono_date_t date, IV d) {
    int y;

    y = dt_year(date);
    if (d < 1 || (d > 365 && d > dt_days_in_year(y)))
        croak("Parameter 'day' is out of the range [1, %d]", dt_days_in_year(y));
    return dt_from_yd(y, d);
}

static chrono_date_t
THX_chrono_date_with_day_of_quarter(pTHX_ chrono_date_t date, IV d) {
    int y, q;

    dt_to_yqd(date, &y, &q, NULL);
    if (d < 1 || (d > 90 && d > dt_days_in_quarter(y, q)))
        croak("Parameter 'day' is out of the range [1, %d]", dt_days_in_quarter(y, q));
    return dt_from_yqd(y, q, d);
}

static chrono_date_t
THX_chrono_date_with_day_of_month(pTHX_ chrono_date_t date, IV d) {
    int y, m;

    dt_to_ymd(date, &y, &m, NULL);
    if (d < 1 || (d > 28 && d > dt_days_in_month(y, m)))
        croak("Parameter 'day' is out of the range [1, %d]", dt_days_in_month(y, m));
    return dt_from_ymd(y, m, d);
}

static chrono_date_t
THX_chrono_date_with_day_of_week(pTHX_ chrono_date_t date, IV d) {
    chrono_date_t res;

    if (d < 1 || d > 7)
        croak("Parameter 'day' is out of the range [1, 7]");
    res = date + (d - dt_day_of_week(date));
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_at_end_of_year(pTHX_ chrono_date_t date, IV offset) {
    chrono_date_t res;

    if (!VALID_YEARS_DELTA(offset))
        croak("Parameter 'offset' is out of the range of valid values");
    res = dt_last_day_of_year(date, offset);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_at_end_of_quarter(pTHX_ chrono_date_t date, IV offset) {
    chrono_date_t res;

    if (!VALID_QUARTERS_DELTA(offset))
        croak("Parameter 'offset' is out of the range of valid values");
    res = dt_last_day_of_quarter(date, offset);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_at_end_of_month(pTHX_ chrono_date_t date, IV offset) {
    chrono_date_t res;

    if (!VALID_MONTHS_DELTA(offset))
        croak("Parameter 'offset' is out of the range of valid values");
    res = dt_last_day_of_month(date, offset);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static IV
chrono_date_delta_days(chrono_date_t d1, chrono_date_t d2) {
    return (IV)(d1 - d2);
}

static IV
chrono_date_delta_weeks(chrono_date_t d1, chrono_date_t d2) {
    return (IV)((d1 - d2) / 7);
}

static chrono_date_t
THX_chrono_date_add_years(pTHX_ chrono_date_t d, IV years) {
    chrono_date_t res;

    if (!VALID_YEARS_DELTA(years))
        croak("Parameter 'years' is out of the range of valid values");
    res = dt_add_years(d, years, DT_LIMIT);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_add_quarters(pTHX_ chrono_date_t d, IV quarters) {
    chrono_date_t res;

    if (!VALID_QUARTERS_DELTA(quarters))
        croak("Parameter 'quarters' is out of the range of valid values");
    res = dt_add_quarters(d, quarters, DT_LIMIT);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_add_months(pTHX_ chrono_date_t d, IV months) {
    chrono_date_t res;

    if (!VALID_MONTHS_DELTA(months))
        croak("Parameter 'months' is out of the range of valid values");
    res = dt_add_months(d, months, DT_LIMIT);
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_add_weeks(pTHX_ chrono_date_t d, IV weeks) {
    chrono_date_t res;

    if (!VALID_WEEKS_DELTA(weeks))
        croak("Parameter 'weeks' is out of the range of valid values");
    res = d + weeks * 7;
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static chrono_date_t
THX_chrono_date_add_days(pTHX_ chrono_date_t d, IV days) {
    chrono_date_t res;

    if (!VALID_WEEKS_DELTA(days))
        croak("Parameter 'days' is out of the range of valid values");
    res = d + days;
    if (!VALID_DATE(res))
        croak("Date is out of supported range");
    return res;
}

static int
chrono_date_compare(chrono_date_t d1, chrono_date_t d2) {
    if (d1 > d2) return 1;
    if (d1 < d2) return -1;
    return 0;
}

static SV *
THX_chrono_date_format_ymd(pTHX_ chrono_date_t date, SV *dsv) {
    int y, m, d;
    char *p;

    (void)SvUPGRADE(dsv, SVt_PV);
    (void)SvGROW(dsv, SvCUR(dsv) + 10 + 1);
    p = SvPVX(dsv) + SvCUR(dsv);

    dt_to_ymd(date, &y, &m, &d);
    p = chrono_format_number(p, (UV)y, 4);
    *p++ = '-';
    p = chrono_format_number(p, (UV)m, 2);
    *p++ = '-';
    p = chrono_format_number(p, (UV)d, 2);
    *p = 0;

    SvCUR_set(dsv, p - SvPVX(dsv));
    SvPOK_only(dsv);
    return dsv;
}

static SV *
THX_chrono_date_to_string(pTHX_ chrono_date_t d) {
    SV *dsv;
    dsv = sv_newmortal();
    return THX_chrono_date_format_ymd(aTHX_ d, dsv);
}

static IV
chrono_date_length_of_year(chrono_date_t d) {
    return dt_days_in_year(dt_year(d));
}

static IV
chrono_date_length_of_quarter(chrono_date_t d) {
    int y, q;
    dt_to_yqd(d, &y, &q, NULL);
    return dt_days_in_quarter(y, q);
}

static IV
chrono_date_length_of_month(chrono_date_t d) {
    int y, m;
    dt_to_ymd(d, &y, &m, NULL);
    return dt_days_in_month(y, m);
}

static IV
chrono_date_is_leap_year(chrono_date_t d) {
    return dt_leap_year(dt_year(d));
}

static void
chrono_date_swap(chrono_date_t *d1, chrono_date_t *d2) {
    const chrono_date_t tmp = *d1;
    *d1 = *d2;
    *d2 = tmp;
}

/* Chrono::Time */

static chrono_time_t
THX_chrono_time_from_hmsu(pTHX_ IV h, IV m, IV s, IV u) {
    if (h < 0 || h > 23)
        croak("Parameter 'hour' is out of the range [0, 23]");
    if (m < 0 || m > 59)
        croak("Parameter 'minute' is out of the range [0, 59]");
    if (s < 0 || s > 59)
        croak("Parameter 'second' is out of the range [0, 59]");
    if (u < 0 || u > 999999)
        croak("Parameter 'microsecond' is out of the range [0, 999999]");
    return (chrono_time_t)(h * 3600 + m * 60 + s) * USECS_PER_SECOND + u;
}

static IV
chrono_time_hour(chrono_time_t t) {
    return (t / USECS_PER_HOUR) % 24;
}

static IV
chrono_time_minute(chrono_time_t t) {
    return (t / USECS_PER_MINUTE) % 60;
}

static IV
chrono_time_second(chrono_time_t t) {
    return (t / USECS_PER_SECOND) % 60;
}

static IV
chrono_time_second_of_day(chrono_time_t t) {
    return (t / USECS_PER_SECOND);
}

static IV
chrono_time_millisecond(chrono_time_t t) {
    return (t / USECS_PER_MILLISECOND) % 1000;
}

static IV
chrono_time_microsecond(chrono_time_t t) {
    return (t % USECS_PER_SECOND);
}

static int64_t
chrono_time_delta_hours(chrono_time_t t1, chrono_time_t t2) {
    return (t1 - t2) / USECS_PER_HOUR;
}

static int64_t
chrono_time_delta_minutes(chrono_time_t t1, chrono_time_t t2) {
    return (t1 - t2) / USECS_PER_MINUTE;
}

static int64_t
chrono_time_delta_seconds(chrono_time_t t1, chrono_time_t t2) {
    return (t1 - t2) / USECS_PER_SECOND;
}

static int64_t
chrono_time_delta_milliseconds(chrono_time_t t1, chrono_time_t t2) {
    return (t1 - t2) / USECS_PER_MILLISECOND;
}

static int64_t
chrono_time_delta_microseconds(chrono_time_t t1, chrono_time_t t2) {
    return t1 - t2;
}

static chrono_time_t
THX_chrono_time_with_hour(pTHX_ chrono_time_t t, IV h) {
    if (h < 0 || h > 23)
        croak("Parameter 'hour' is out of the range [1, 23]");
    return t + (h - chrono_time_hour(t)) * USECS_PER_HOUR;
}

static chrono_time_t
THX_chrono_time_with_minute(pTHX_ chrono_time_t t, IV m) {
    if (m < 0 || m > 59)
        croak("Parameter 'minute' is out of the range [0, 59]");
    return t + (m - chrono_time_minute(t)) * USECS_PER_MINUTE;
}

static chrono_time_t
THX_chrono_time_with_second(pTHX_ chrono_time_t t, IV s) {
    if (s < 0 || s > 59)
        croak("Parameter 'second' is out of the range [0, 59]");
    return t + (s - chrono_time_second(t)) * USECS_PER_SECOND;
}

static chrono_time_t
THX_chrono_time_with_millisecond(pTHX_ chrono_time_t t, IV m) {
    if (m < 0 || m > 999)
        croak("Parameter 'millisecond' is out of the range [0, 999]");
    return t + (m - chrono_time_millisecond(t)) * USECS_PER_MILLISECOND;
}

static chrono_time_t
THX_chrono_time_with_microsecond(pTHX_ chrono_time_t t, IV m) {
    if (m < 0 || m > 999999)
        croak("Parameter 'microsecond' is out of the range [0, 999999]");
    return t + (m - chrono_time_microsecond(t));
}

static chrono_time_t
chrono_time_add_microseconds(chrono_time_t t, int64_t us);

static chrono_time_t
chrono_time_add_hours(chrono_time_t t, int64_t h) {
    return chrono_time_add_microseconds(t, (h % 24) * USECS_PER_HOUR);
}

static chrono_time_t
chrono_time_add_minutes(chrono_time_t t, int64_t m) {
    return chrono_time_add_microseconds(t, (m % 3600) * USECS_PER_MINUTE);
}

static chrono_time_t
chrono_time_add_seconds(chrono_time_t t, int64_t s) {
    return chrono_time_add_microseconds(t, (s % 86400) * USECS_PER_SECOND);
}

static chrono_time_t
chrono_time_add_milliseconds(chrono_time_t t, int64_t ms) {
    return chrono_time_add_microseconds(t, (ms % 86400000) * USECS_PER_MILLISECOND);
}

static chrono_time_t
chrono_time_add_microseconds(chrono_time_t t, int64_t us) {
    t = (t + (us % USECS_PER_DAY)) % USECS_PER_DAY;
    if (t < 0)
        t += USECS_PER_DAY;
    return t;
}

static int
chrono_time_compare(chrono_time_t t1, chrono_time_t t2) {
    if (t1 > t2) return 1;
    if (t1 < t2) return -1;
    return 0;
}

static SV *
THX_chrono_time_format_hmsu(pTHX_ chrono_time_t t, SV *dsv, IV precision) {
    char *p;

    (void)SvUPGRADE(dsv, SVt_PV);
    (void)SvGROW(dsv, SvCUR(dsv) + 15 + 1);
    p = SvPVX(dsv) + SvCUR(dsv);

    p = chrono_format_number(p, (UV)chrono_time_hour(t), 2);
    *p++ = ':';
    p = chrono_format_number(p, (UV)chrono_time_minute(t), 2);
    *p++ = ':';
    p = chrono_format_number(p, (UV)chrono_time_second(t), 2);
    if (precision > 0) {
        *p++ = '.';
        p = chrono_format_microsecond(p, (UV)chrono_time_microsecond(t), (size_t)precision);
    }
    SvCUR_set(dsv, p - SvPVX(dsv));
    SvPOK_only(dsv);
    return dsv;
}

static SV *
THX_chrono_time_to_string(pTHX_ chrono_time_t t, IV precision) {
    SV *dsv;

    if (precision < 0 || precision > 6)
        croak("Parameter 'precision' is out of the range [0, 6]");
    dsv = sv_newmortal();
    return THX_chrono_time_format_hmsu(aTHX_ t, dsv, precision);
}

static void
chrono_time_swap(chrono_time_t *t1, chrono_time_t *t2) {
    const chrono_time_t tmp = *t1;
    *t1 = *t2;
    *t2 = tmp;
}

/* Chrono::DateTime */

static chrono_datetime_t
chrono_datetime_from_date_time(chrono_date_t d, chrono_time_t t) {
    return (chrono_datetime_t)(d * USECS_PER_DAY) + t;
}

static chrono_datetime_t
THX_chrono_datetime_from_epoch(pTHX_ int64_t sec, int64_t us) {
    if (!VALID_EPOCH_SECONDS(sec))
        croak("Parameter 'seconds' is out of the range of valid values");
    if (us < 0 || us > 999999)
        croak("Parameter 'microsecond' is out of the range [0, 999999]");
    return (chrono_datetime_t)(UNIX_EPOCH + sec) * USECS_PER_SECOND + us;
}

static int64_t
chrono_datetime_epoch(chrono_datetime_t dt) {
    return (dt / USECS_PER_SECOND) - UNIX_EPOCH;
}

static NV
chrono_datetime_cjd(chrono_datetime_t dt) {
    int64_t d = (dt / USECS_PER_DAY) + CJDN_EPOCH;
    int64_t u = dt % USECS_PER_DAY;
    return (NV)d + (NV)u * (1E-6/60/60/24);
}

static int64_t
chrono_datetime_rdn_as_seconds(chrono_datetime_t dt) {
    return (dt / USECS_PER_SECOND);
}

static chrono_date_t
chrono_datetime_date(chrono_datetime_t dt) {
    return (chrono_date_t)(dt / USECS_PER_DAY);
}

static chrono_time_t
chrono_datetime_time(chrono_datetime_t dt) {
    return (chrono_time_t)(dt % USECS_PER_DAY);
}

static chrono_datetime_t
chrono_datetime_with_date(chrono_datetime_t dt, chrono_date_t d) {
    return chrono_datetime_from_date_time(d, chrono_datetime_time(dt));
}

static chrono_datetime_t
chrono_datetime_with_time(chrono_datetime_t dt, chrono_time_t t) {
    return chrono_datetime_from_date_time(chrono_datetime_date(dt), t);
}

static chrono_datetime_t
THX_chrono_datetime_add_duration(pTHX_ chrono_datetime_t dt, chrono_duration_t d) {
    dt = (chrono_datetime_t)(dt + d);
    if (!VALID_DATETIME(dt))
        croak("DateTime out of supported range");
    return dt;
}

static chrono_datetime_t
THX_chrono_datetime_subtract_duration(pTHX_ chrono_datetime_t dt, chrono_duration_t d) {
    dt = (chrono_datetime_t)(dt - d);
    if (!VALID_DATETIME(dt))
        croak("DateTime out of supported range");
    return dt;
}

static chrono_duration_t
chrono_datetime_subtract_datetime(chrono_datetime_t dt1, chrono_datetime_t dt2) {
    return (chrono_duration_t)(dt1 - dt2);
}

static int
chrono_datetime_compare(chrono_datetime_t dt1, chrono_datetime_t dt2) {
    if (dt1 > dt2) return 1;
    if (dt1 < dt2) return -1;
    return 0;
}

static SV *
THX_chrono_datetime_format_ymdhmsu(pTHX_ chrono_datetime_t dt, SV *dsv, IV precision) {
    chrono_date_t date = chrono_datetime_date(dt);
    chrono_time_t time = chrono_datetime_time(dt);

    THX_chrono_date_format_ymd(aTHX_ date, dsv);
    sv_catpvn_nomg(dsv, "T", 1);
    THX_chrono_time_format_hmsu(aTHX_ time, dsv, precision);
    return dsv;
}

static SV *
THX_chrono_datetime_to_string(pTHX_ chrono_datetime_t dt, IV precision) {
    SV *dsv;

    if (precision < 0 || precision > 6)
        croak("Parameter 'precision' is out of the range [0, 6]");
    dsv = sv_newmortal();
    return THX_chrono_datetime_format_ymdhmsu(aTHX_ dt, dsv, precision);
}

static void
chrono_datetime_swap(chrono_datetime_t *d1, chrono_datetime_t *d2) {
    const chrono_datetime_t tmp = *d1;
    *d1 = *d2;
    *d2 = tmp;
}

/* Chrono::Duration */

static chrono_duration_t
THX_chrono_duration_from_dhmsu(pTHX_ int64_t d, int64_t h, int64_t m, int64_t s, int64_t us) {
    chrono_duration_t res;

    if (!VALID_DAYS_DELTA(d))
        croak("Parameter 'days' is out of the range of valid values");
    if (!VALID_HOURS_DELTA(h))
        croak("Parameter 'hours' is out of the range of valid values");
    if (!VALID_MINUTES_DELTA(m))
        croak("Parameter 'minutes' is out of the range of valid values");
    if (!VALID_SECONDS_DELTA(s))
        croak("Parameter 'seconds' is out of the range of valid values");
    if (!VALID_MICROSECONDS_DELTA(us))
        croak("Parameter 'microseconds' is out of the range of valid values");

    res = (d * 86400 + h * 3600 + m * 60 + s) * USECS_PER_SECOND + us;
    if (!VALID_DURATION(res))
        croak("Duration out of the supported range");
    return res;
}

static chrono_duration_t
THX_chrono_duration_from_days(pTHX_ int64_t d) {
    if (!VALID_DAYS_DELTA(d))
        croak("Parameter 'days' is out of the range of valid values");
    return (chrono_duration_t)(d * USECS_PER_DAY);
}

static chrono_duration_t
THX_chrono_duration_from_hours(pTHX_ int64_t h) {
    if (!VALID_HOURS_DELTA(h))
        croak("Parameter 'hours' is out of the range of valid values");
    return (chrono_duration_t)(h * USECS_PER_HOUR);
}

static chrono_duration_t
THX_chrono_duration_from_minutes(pTHX_ int64_t m) {
    if (!VALID_MINUTES_DELTA(m))
        croak("Parameter 'minutes' is out of the range of valid values");
    return (chrono_duration_t)(m * USECS_PER_MINUTE);
}

static chrono_duration_t
THX_chrono_duration_from_seconds(pTHX_ int64_t s) {
    if (!VALID_SECONDS_DELTA(s))
        croak("Parameter 'seconds' is out of the range of valid values");
    return (chrono_duration_t)(s * USECS_PER_SECOND);
}

static chrono_duration_t
THX_chrono_duration_from_milliseconds(pTHX_ int64_t ms) {
    if (!VALID_MILLISECONDS_DELTA(ms))
        croak("Parameter 'milliseconds' is out of the range of valid values");
    return (chrono_duration_t)(ms * USECS_PER_MILLISECOND);
}

static chrono_duration_t
THX_chrono_duration_from_microseconds(pTHX_ int64_t us) {
    if (!VALID_MICROSECONDS_DELTA(us))
        croak("Parameter 'microseconds' is out of the range of valid values");
    return (chrono_duration_t)us;
}

static chrono_duration_t
THX_chrono_duration_add_microseconds(pTHX_ chrono_duration_t d, int64_t us) {
    chrono_duration_t res;
    if (!VALID_MICROSECONDS_DELTA(us))
        croak("Parameter 'microseconds' is out of the range of valid values");
    res = (chrono_duration_t)(d + us);
    if (!VALID_DURATION(res))
        croak("Duration out of the supported range");
    return res;
}

static chrono_duration_t
THX_chrono_duration_add_duration(pTHX_ chrono_duration_t d1, chrono_duration_t d2) {
    chrono_duration_t res = d1 + d2;
    if (!VALID_DURATION(res))
        croak("Duration out of the supported range");
    return res;
}

static chrono_duration_t
THX_chrono_duration_subtract_duration(pTHX_ chrono_duration_t d1, chrono_duration_t d2) {
    chrono_duration_t res = d1 - d2;
    if (!VALID_DURATION(res))
        croak("Duration out of the supported range");
    return res;
}

static chrono_duration_t
chrono_duration_abs(chrono_duration_t d) {
    if (d < 0)
        d = -d;
    return d;
}

static chrono_duration_t
chrono_duration_negate(chrono_duration_t d) {
    return -d;
}

static int64_t
chrono_duration_days(chrono_duration_t d) {
    return (int64_t)(d / USECS_PER_DAY);
}

static int64_t
chrono_duration_hours(chrono_duration_t d) {
    return (int64_t)(d / USECS_PER_HOUR);
}

static int64_t
chrono_duration_minutes(chrono_duration_t d) {
    return (int64_t)(d / USECS_PER_MINUTE);
}

static int64_t
chrono_duration_seconds(chrono_duration_t d) {
    return (int64_t)(d / USECS_PER_SECOND);
}

static IV
chrono_duration_millisecond(chrono_duration_t d) {
    return (d / USECS_PER_MILLISECOND) % 1000;
}

static int64_t
chrono_duration_milliseconds(chrono_duration_t d) {
    return (int64_t)(d / USECS_PER_MILLISECOND);
}

static IV
chrono_duration_microsecond(chrono_duration_t d) {
    return (d % USECS_PER_SECOND);
}

static int64_t
chrono_duration_microseconds(chrono_duration_t d) {
    return (int64_t)d;
}

static NV
chrono_duration_total_days(chrono_duration_t d) {
    int64_t s = d / USECS_PER_DAY;
    int64_t u = d % USECS_PER_DAY;
    return (NV)s + (NV)u * (1E-6/60/60/24);
}

static NV
chrono_duration_total_hours(chrono_duration_t d) {
    int64_t s = d / USECS_PER_HOUR;
    int64_t u = d % USECS_PER_HOUR;
    return (NV)s + (NV)u * (1E-6/60/60);
}

static NV
chrono_duration_total_minutes(chrono_duration_t d) {
    int64_t s = d / USECS_PER_MINUTE;
    int64_t u = d % USECS_PER_MINUTE;
    return (NV)s + (NV)u * (1E-6/60);
}

static NV
chrono_duration_total_seconds(chrono_duration_t d) {
    int64_t s = d / USECS_PER_SECOND;
    int64_t u = d % USECS_PER_SECOND;
    return (NV)s + (NV)u * (1E-6);
}

static NV
chrono_duration_total_milliseconds(chrono_duration_t d) {
    int64_t s = d / USECS_PER_MILLISECOND;
    int64_t u = d % USECS_PER_MILLISECOND;
    return (NV)s + (NV)u * (1E-3);
}

static bool
chrono_duration_is_zero(chrono_duration_t d) {
    return (d == 0);
}

static bool
chrono_duration_is_negative(chrono_duration_t d) {
    return (d < 0);
}

static bool
chrono_duration_is_positive(chrono_duration_t d) {
    return (d > 0);
}

static int
chrono_duration_compare(chrono_duration_t d1, chrono_duration_t d2) {
    if (d1 > d2) return 1;
    if (d1 < d2) return -1;
    return 0;
}

static SV *
THX_chrono_duration_format(pTHX_ chrono_time_t d, SV *dsv, IV precision) {
    char *p;

    (void)SvUPGRADE(dsv, SVt_PV);
    (void)SvGROW(dsv, SvCUR(dsv) + 2 + 20 + 1 + 6 + 1);
    p = SvPVX(dsv) + SvCUR(dsv);
    *p++ = 'P';
    *p++ = 'T';
    p += chrono_i64toa(chrono_duration_seconds(d), p, SvLEN(dsv) - 2);
    *p++ = 'S';
    if (precision > 0) {
        *p++ = '.';
        p = chrono_format_microsecond(p, chrono_duration_microsecond(d), precision);
    }
    SvCUR_set(dsv, p - SvPVX(dsv));
    SvPOK_only(dsv);
    return dsv;
}

static SV *
THX_chrono_duration_to_string(pTHX_ chrono_duration_t d, IV precision) {
    SV *dsv;

    if (precision < 0 || precision > 6)
        croak("Parameter 'precision' is out of the range [0, 6]");
    dsv = sv_newmortal();
    return THX_chrono_duration_format(aTHX_ d, dsv, precision);
}


static void
chrono_duration_swap(chrono_duration_t *d1, chrono_duration_t *d2) {
    const chrono_duration_t tmp = *d1;
    *d1 = *d2;
    *d2 = tmp;
}

#define chrono_date_from_string(str, len) \
    THX_chrono_date_from_string(aTHX_ str, len)

#define chrono_date_from_rdn(n) \
    THX_chrono_date_from_rdn(aTHX_ n)

#define chrono_date_from_cjdn(n) \
    THX_chrono_date_from_cjdn(aTHX_ n)

#define chrono_date_from_yd(y, d) \
    THX_chrono_date_from_yd(aTHX_ y, d)

#define chrono_date_from_ymd(y, m, d) \
    THX_chrono_date_from_ymd(aTHX_ y, m, d)

#define chrono_date_from_yqd(y, q, d) \
    THX_chrono_date_from_yqd(aTHX_ y, q, d)

#define chrono_date_from_ywd(y, w, d) \
    THX_chrono_date_from_ywd(aTHX_ y, w, d)

#define chrono_date_with_year(date, y) \
    THX_chrono_date_with_year(aTHX_ date, y)

#define chrono_date_with_quarter(date, q) \
    THX_chrono_date_with_quarter(aTHX_ date, q)

#define chrono_date_with_month(date, m) \
    THX_chrono_date_with_month(aTHX_ date, m)

#define chrono_date_with_week(date, w) \
    THX_chrono_date_with_week(aTHX_ date, w)

#define chrono_date_with_day_of_year(date, d) \
    THX_chrono_date_with_day_of_year(aTHX_ date, d)

#define chrono_date_with_day_of_quarter(date, d) \
    THX_chrono_date_with_day_of_quarter(aTHX_ date, d)

#define chrono_date_with_day_of_month(date, d) \
    THX_chrono_date_with_day_of_month(aTHX_ date, d)

#define chrono_date_with_day_of_week(date, d) \
    THX_chrono_date_with_day_of_week(aTHX_ date, d)

#define chrono_date_at_end_of_year(date, offset) \
    THX_chrono_date_at_end_of_year(aTHX_ date, offset)

#define chrono_date_at_end_of_quarter(date, offset) \
    THX_chrono_date_at_end_of_quarter(aTHX_ date, offset)

#define chrono_date_at_end_of_month(date, offset) \
    THX_chrono_date_at_end_of_month(aTHX_ date, offset)

#define chrono_date_add_years(date, y) \
    THX_chrono_date_add_years(aTHX_ date, y)

#define chrono_date_add_quarters(date, q) \
    THX_chrono_date_add_quarters(aTHX_ date, q)

#define chrono_date_add_months(date, m) \
    THX_chrono_date_add_months(aTHX_ date, m)

#define chrono_date_add_weeks(date, w) \
    THX_chrono_date_add_weeks(aTHX_ date, w)

#define chrono_date_add_days(date, d) \
    THX_chrono_date_add_days(aTHX_ date, d)

#define chrono_date_year(d)                 dt_year(d)
#define chrono_date_quarter(d)              dt_quarter(d)
#define chrono_date_month(d)                dt_month(d)
#define chrono_date_week(d)                 dt_week(d)
#define chrono_date_day_of_year(d)          dt_day_of_year(d)
#define chrono_date_day_of_quarter(d)       dt_day_of_quarter(d)
#define chrono_date_day_of_month(d)         dt_day(d)
#define chrono_date_day_of_week(d)          dt_day_of_week(d)
#define chrono_date_rdn(d)                  dt_rdn(d)
#define chrono_date_cjdn(d)                 dt_cjdn(d)
#define chrono_date_delta_years(d1, d2)     dt_delta_years(d2, d1, TRUE)      /* reversed! */
#define chrono_date_delta_quarters(d1, d2)  dt_delta_quarters(d2, d1, TRUE)   /* reversed! */
#define chrono_date_delta_months(d1, d2)    dt_delta_months(d2, d1, TRUE)     /* reversed! */

#define chrono_date_to_string(d) \
    THX_chrono_date_to_string(aTHX_ d)

#define chrono_time_from_hmsu(h, m, s, u) \
    THX_chrono_time_from_hmsu(aTHX_ h, m, s, u)

#define chrono_time_with_hour(t, h) \
    THX_chrono_time_with_hour(aTHX_ t, h)

#define chrono_time_with_minute(t, m) \
    THX_chrono_time_with_minute(aTHX_ t, m)

#define chrono_time_with_second(t, s) \
    THX_chrono_time_with_second(aTHX_ t, s)

#define chrono_time_with_millisecond(t, m) \
    THX_chrono_time_with_millisecond(aTHX_ t, m)

#define chrono_time_with_microsecond(t, m) \
    THX_chrono_time_with_microsecond(aTHX_ t, m)

#define chrono_time_to_string(t, p) \
    THX_chrono_time_to_string(aTHX_ t, p)

#define chrono_datetime_from_epoch(s, u) \
    THX_chrono_datetime_from_epoch(aTHX_ s, u)

#define chrono_datetime_add_duration(dt, d) \
    THX_chrono_datetime_add_duration(aTHX_ dt, d)

#define chrono_datetime_subtract_duration(dt, d) \
    THX_chrono_datetime_subtract_duration(aTHX_ dt, d)

#define chrono_datetime_to_string(dt, p) \
    THX_chrono_datetime_to_string(aTHX_ dt, p)

#define chrono_duration_from_dhmsu(d, h, m, s, u) \
    THX_chrono_duration_from_dhmsu(aTHX_ d, h, m, s, u)

#define chrono_duration_from_days(d) \
    THX_chrono_duration_from_days(aTHX_ d)

#define chrono_duration_from_hours(h) \
    THX_chrono_duration_from_hours(aTHX_ h)

#define chrono_duration_from_minutes(m) \
    THX_chrono_duration_from_minutes(aTHX_ m)

#define chrono_duration_from_seconds(s) \
    THX_chrono_duration_from_seconds(aTHX_ s)

#define chrono_duration_from_milliseconds(ms) \
    THX_chrono_duration_from_milliseconds(aTHX_ ms)

#define chrono_duration_from_microseconds(us) \
    THX_chrono_duration_from_microseconds(aTHX_ us)

#define chrono_duration_add_duration(d1, d2) \
    THX_chrono_duration_add_duration(aTHX_ d1, d2)

#define chrono_duration_subtract_duration(d1, d2) \
    THX_chrono_duration_subtract_duration(aTHX_ d1, d2)

#define chrono_duration_to_string(dt, p) \
    THX_chrono_duration_to_string(aTHX_ dt, p)

#endif

