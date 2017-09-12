create or replace type explode as object
(
 /**
  * @purpose Split a string by string
  * @author Reznichenko SV, email: gressY06@gmail.com
  */

  str       clob,
  delimiter varchar2(4000),

 /**
  * Constructor
  *
  * @return self
  */
  constructor function explode return self as result,

 /**
  * Constructor
  * @param p_Str string
  *
  * @return self
  */
  constructor function explode(p_Str in varchar2) return self as result,

 /**
  * Constructor
  * @param p_Str string
  *
  * @return self
  */
  constructor function explode(p_Str in clob) return self as result,

 /**
  * Constructor
  * @param p_Str       string
  * @param p_Delimiter string delimiter
  *
  * @return self
  */
  constructor function explode(p_Str       in varchar2,
                               p_Delimiter in varchar2) return self as result,

 /**
  * Constructor
  * @param p_Str       string
  * @param p_Delimiter string delimiter
  *
  * @return self
  */
  constructor function explode(p_Str       in clob,
                               p_Delimiter in varchar2) return self as result,

 /**
  * Set string delimiter
  * @param p_Delimiter string delimiter
  *
  * @return explode
  */
  member function sep(p_Delimiter in varchar2) return explode,

 /**
  * Return a broken string as an array of strings
  *
  * @return str_array
  */
  member function tab return str_array
    pipelined,

 /**
  * Return a broken string as sys_refcursor
  *
  * @return sys_refcursor
  */
  member function ref return sys_refcursor,

 /**
  * Return element by number
  *
  * @return string
  */
  member function num(p_Num in number) return varchar2,

 /**
  * Return last element
  *
  * @return string
  */
  member function last return varchar2
)
/
