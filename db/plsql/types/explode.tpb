create or replace type body explode is

 /**
  * Constructor
  *
  * @return self
  */
  constructor function explode return self as result is
  begin
    return;
  end;

 /**
  * Constructor
  * @param p_Str string
  *
  * @return self
  */
  constructor function explode(p_Str in varchar2) return self as result is
  begin
    self.str       := p_Str;
    self.delimiter := '[:space:]';
    return;
  end;

 /**
  * Constructor
  * @param p_Str string
  *
  * @return self
  */
  constructor function explode(p_Str in clob) return self as result is
  begin
    self.str       := p_Str;
    self.delimiter := '[:space:]';
    return;
  end;

 /**
  * Constructor
  * @param p_Str       string
  * @param p_Delimiter string delimiter
  *
  * @return self
  */
  constructor function explode(p_Str       in varchar2,
                               p_Delimiter in varchar2) return self as result is
  begin
    self.str       := p_Str;
    self.delimiter := p_Delimiter;
    return;
  end;

 /**
  * Constructor
  * @param p_Str       string
  * @param p_Delimiter string delimiter
  *
  * @return self
  */
  constructor function explode(p_Str       in clob,
                               p_Delimiter in varchar2) return self as result is
  begin
    self.str       := p_Str;
    self.delimiter := p_Delimiter;
    return;
  end;

 /**
  * Set string delimiter
  * @param p_Delimiter string delimiter
  *
  * @return explode
  */
  member function sep(p_Delimiter in varchar2) return explode is
    l_Explode explode;
  begin
    l_Explode           := self;
    l_Explode.delimiter := p_Delimiter;
    return l_Explode;
  end;

 /**
  * Return a broken string as an array of strings
  *
  * @return str_array
  */
  member function tab return str_array
    pipelined is

    l_Value varchar2(4000);
    l_Str clob;
  begin
    if self.str is null
    then
      pipe row('');
    else
      l_Str := self.str;

      loop
        if regexp_instr(l_Str, '[' || self.delimiter || ']+', 1, 1) + 1 = 1
        then
          pipe row(l_Str);
          exit;
        else
          --NoFormat Start
          IF regexp_instr(l_Str, '[' || self.delimiter || ']+', 1, 1) - 1 = 0
          THEN
            l_Value := '';
          ELSE
            l_Value := substr(l_Str, 1, regexp_instr(l_Str, '[' || self.delimiter || ']+', 1, 1) - 1);
          END IF;

          l_Str := substr(l_Str, regexp_instr(l_Str, '[' || self.delimiter || ']+', 1, 1) + 1);
          --NoFormat End

          pipe row(l_Value);
        end if;
      end loop;

    end if;

    return;
  end;

 /**
  * Return a broken string as sys_refcursor
  *
  * @return sys_refcursor
  */
  member function ref return sys_refcursor is
    l_RefCursor sys_refcursor;
  begin

    open l_RefCursor for
      select t.column_value val from table(self.tab()) t;

    return l_RefCursor;
  end;

 /**
  * Return element by number
  *
  * @return string
  */
  member function num(p_Num in number) return varchar2 is
    type varchar_tt is table of varchar2(4000) index by pls_integer;

    l_Num   number;
    l_Array varchar_tt;
  begin
    select t.column_value val bulk collect into l_Array from table(self.tab()) t;

    if (p_Num < 0)
    then
      l_Num := l_Array.count - abs(p_Num) + 1;
    else
      l_Num := p_Num;
    end if;

    return l_Array(l_Num);
  exception
    when no_data_found then
      return null;
  end;

 /**
  * Return last element
  *
  * @return string
  */
  member function last return varchar2 is
  begin
    return self.num(-1);
  end;

end;
/
