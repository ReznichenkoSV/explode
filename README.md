# explode

Split a string by string

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=ReznichenkoSV_explode&metric=alert_status)](https://sonarcloud.io/dashboard?id=ReznichenkoSV_explode)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=ReznichenkoSV_explode&metric=code_smells)](https://sonarcloud.io/dashboard?id=ReznichenkoSV_explode)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=ReznichenkoSV_explode&metric=bugs)](https://sonarcloud.io/dashboard?id=ReznichenkoSV_explode)

## Example 1

```sql
select value(v) val from table(explode('1:@@@@@@@@@@@@@@@::3:$:%:%:^:^^:^:@').sep(':').tab()) v;
```

```
VAL
--------------------------------------------------------------------------------
1
@@@@@@@@@@@@@@@

3
$
%
%
^
^^
^
@

11 rows selected.
```

## Example 2

```sql
select explode('1:@@@@@@@@@@@@@@@:3:$:%:%:^:^^:^:@').sep(':').ref() ref from dual;
```

```
REF
--------------------
CURSOR STATEMENT : 1

CURSOR STATEMENT : 1

VAL
--------------------------------------------------------------------------------
1
@@@@@@@@@@@@@@@
3
$
%
%
^
^^
^
@

10 rows selected.
```

## Example 3

```sql
select explode('1:@@@@@@@@@@@@@@@:3:$:%:%:^:^^:^:Last element').sep(':').last() val from dual;
```

```
VAL
--------------------------------------------------------------------------------
Last element
```

## Example 4 

```sql
select explode('First:@@@@@@@@@@@@@@@:3:$:%:%:^:^^:^:Last').sep(':').num(1) val from dual;
```

```
VAL
--------------------------------------------------------------------------------
First
```

