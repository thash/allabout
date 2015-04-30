# 比較演算子「<」の使い方
p 1 < 2 # => true


pry> $ Integer#<

From: compar.c (C Method):
Owner: Comparable
Visibility: public
Number of lines: 8

static VALUE
cmp_lt(VALUE x, VALUE y)
{
    VALUE c = rb_funcall(x, cmp, 1, y);

    if (rb_cmpint(c, x, y) < 0) return Qtrue;
    return Qfalse;
}


# 定義元(Owner)はComparableモジュールのようなので、?でドキュメントを参照
pry> ? Comparable#<

From: compar.c (C Method):
Owner: Comparable
Visibility: public
Signature: <(arg1)
Number of lines: 2

Compares two objects based on the receiver\'s <=>
method, returning true if it returns -1.


# Numericの比較メソッド<=>にたどり着く
[13] pry(main)> $ Numeric#<=>

From: numeric.c (C Method):
Owner: Numeric
Visibility: public
Number of lines: 6

static VALUE
num_cmp(VALUE x, VALUE y)
{
    if (x == y) return INT2FIX(0);
    return Qnil;
}
