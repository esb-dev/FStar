
open Prims
# 27 "FStar.Tc.Recheck.fst"
let oktype : FStar_Absyn_Syntax.knd Prims.option = Some (FStar_Absyn_Syntax.ktype)

# 29 "FStar.Tc.Recheck.fst"
let t_unit : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.unit_lid FStar_Absyn_Syntax.ktype)))

# 30 "FStar.Tc.Recheck.fst"
let t_bool : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.bool_lid FStar_Absyn_Syntax.ktype)))

# 31 "FStar.Tc.Recheck.fst"
let t_uint8 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.uint8_lid FStar_Absyn_Syntax.ktype)))

# 32 "FStar.Tc.Recheck.fst"
let t_int : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int_lid FStar_Absyn_Syntax.ktype)))

# 33 "FStar.Tc.Recheck.fst"
let t_int32 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int32_lid FStar_Absyn_Syntax.ktype)))

# 34 "FStar.Tc.Recheck.fst"
let t_int64 : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.int64_lid FStar_Absyn_Syntax.ktype)))

# 35 "FStar.Tc.Recheck.fst"
let t_string : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.string_lid FStar_Absyn_Syntax.ktype)))

# 36 "FStar.Tc.Recheck.fst"
let t_float : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.float_lid FStar_Absyn_Syntax.ktype)))

# 37 "FStar.Tc.Recheck.fst"
let t_char : FStar_Absyn_Syntax.typ = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn FStar_Absyn_Syntax.dummyRange oktype) (FStar_Absyn_Syntax.mk_Typ_const (FStar_Absyn_Util.withsort FStar_Absyn_Const.char_lid FStar_Absyn_Syntax.ktype)))

# 38 "FStar.Tc.Recheck.fst"
let typing_const : FStar_Range.range  ->  FStar_Const.sconst  ->  FStar_Absyn_Syntax.typ = (fun r s -> (match (s) with
| FStar_Const.Const_unit -> begin
t_unit
end
| FStar_Const.Const_bool (_31_5) -> begin
t_bool
end
| FStar_Const.Const_int (_31_8) -> begin
t_int
end
| FStar_Const.Const_int32 (_31_11) -> begin
t_int32
end
| FStar_Const.Const_int64 (_31_14) -> begin
t_int64
end
| FStar_Const.Const_string (_31_17) -> begin
t_string
end
| FStar_Const.Const_float (_31_20) -> begin
t_float
end
| FStar_Const.Const_char (_31_23) -> begin
t_char
end
| FStar_Const.Const_uint8 (_31_26) -> begin
t_uint8
end
| _31_29 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error (("Unsupported constant", r))))
end))

# 50 "FStar.Tc.Recheck.fst"
let rec recompute_kind : (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax = (fun t -> (
# 54 "FStar.Tc.Recheck.fst"
let recompute = (fun t -> (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_delayed (_31_34) -> begin
(let _110_30 = (FStar_Absyn_Util.compress_typ t)
in (recompute_kind _110_30))
end
| FStar_Absyn_Syntax.Typ_btvar (a) -> begin
a.FStar_Absyn_Syntax.sort
end
| FStar_Absyn_Syntax.Typ_const (tc) -> begin
(match (tc.FStar_Absyn_Syntax.sort.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Kind_unknown -> begin
(let _110_32 = (let _110_31 = (FStar_Absyn_Print.typ_to_string t)
in (FStar_Util.format1 "UNKNOWN KIND FOR %s" _110_31))
in (FStar_All.failwith _110_32))
end
| _31_42 -> begin
tc.FStar_Absyn_Syntax.sort
end)
end
| (FStar_Absyn_Syntax.Typ_fun (_)) | (FStar_Absyn_Syntax.Typ_refine (_)) -> begin
FStar_Absyn_Syntax.ktype
end
| (FStar_Absyn_Syntax.Typ_ascribed (_, k)) | (FStar_Absyn_Syntax.Typ_uvar (_, k)) -> begin
k
end
| (FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_labeled (_))) | (FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_slack_formula (_))) | (FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_pattern (_))) -> begin
FStar_Absyn_Syntax.ktype
end
| FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_named (t, _31_72)) -> begin
(recompute_kind t)
end
| FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_refresh_label (t, _31_78, _31_80)) -> begin
(recompute_kind t)
end
| FStar_Absyn_Syntax.Typ_lam (binders, body) -> begin
(let _110_34 = (let _110_33 = (recompute_kind body)
in (binders, _110_33))
in (FStar_Absyn_Syntax.mk_Kind_arrow _110_34 t.FStar_Absyn_Syntax.pos))
end
| FStar_Absyn_Syntax.Typ_app (t1, args) -> begin
(match (t1.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_const (tc) when ((((FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.forall_lid) || (FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.exists_lid)) || (FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.allTyp_lid)) || (FStar_Absyn_Syntax.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.exTyp_lid)) -> begin
FStar_Absyn_Syntax.ktype
end
| _31_95 -> begin
(
# 79 "FStar.Tc.Recheck.fst"
let k1 = (recompute_kind t1)
in (
# 80 "FStar.Tc.Recheck.fst"
let _31_99 = (FStar_Absyn_Util.kind_formals k1)
in (match (_31_99) with
| (bs, k) -> begin
(
# 81 "FStar.Tc.Recheck.fst"
let rec aux = (fun subst bs args -> (match ((bs, args)) with
| ([], []) -> begin
(FStar_Absyn_Util.subst_kind subst k)
end
| (_31_108, []) -> begin
(let _110_41 = (FStar_Absyn_Syntax.mk_Kind_arrow (bs, k) t.FStar_Absyn_Syntax.pos)
in (FStar_All.pipe_right _110_41 (FStar_Absyn_Util.subst_kind subst)))
end
| (b::bs, a::args) -> begin
(
# 85 "FStar.Tc.Recheck.fst"
let subst = (let _110_42 = (FStar_Absyn_Util.subst_formal b a)
in (_110_42)::subst)
in (aux subst bs args))
end
| _31_120 -> begin
(let _110_48 = (let _110_47 = (FStar_Range.string_of_range t.FStar_Absyn_Syntax.pos)
in (let _110_46 = (FStar_Absyn_Print.kind_to_string k1)
in (let _110_45 = (FStar_Absyn_Print.tag_of_typ t)
in (let _110_44 = (FStar_Absyn_Print.kind_to_string k)
in (let _110_43 = (FStar_All.pipe_right (FStar_List.length args) FStar_Util.string_of_int)
in (FStar_Util.format5 "(%s) HEAD KIND is %s\nToo many arguments in type %s; result kind is %s\nwith %s remaining args\n" _110_47 _110_46 _110_45 _110_44 _110_43))))))
in (FStar_All.failwith _110_48))
end))
in (aux [] bs args))
end)))
end)
end
| FStar_Absyn_Syntax.Typ_unknown -> begin
FStar_Absyn_Syntax.kun
end))
in (match ((FStar_ST.read t.FStar_Absyn_Syntax.tk)) with
| Some (k) -> begin
k
end
| None -> begin
(
# 95 "FStar.Tc.Recheck.fst"
let k = (recompute t)
in (
# 95 "FStar.Tc.Recheck.fst"
let _31_126 = (FStar_ST.op_Colon_Equals t.FStar_Absyn_Syntax.tk (Some (k)))
in k))
end)))

# 95 "FStar.Tc.Recheck.fst"
let rec recompute_typ : FStar_Absyn_Syntax.exp  ->  FStar_Absyn_Syntax.typ = (fun e -> (
# 98 "FStar.Tc.Recheck.fst"
let recompute = (fun e -> (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_delayed (_31_132) -> begin
(let _110_53 = (FStar_Absyn_Util.compress_exp e)
in (recompute_typ _110_53))
end
| FStar_Absyn_Syntax.Exp_bvar (x) -> begin
x.FStar_Absyn_Syntax.sort
end
| FStar_Absyn_Syntax.Exp_fvar (f, _31_138) -> begin
f.FStar_Absyn_Syntax.sort
end
| FStar_Absyn_Syntax.Exp_constant (s) -> begin
(typing_const e.FStar_Absyn_Syntax.pos s)
end
| FStar_Absyn_Syntax.Exp_abs (bs, body) -> begin
(let _110_56 = (let _110_55 = (let _110_54 = (recompute_typ body)
in (FStar_Absyn_Syntax.mk_Total _110_54))
in (bs, _110_55))
in (FStar_Absyn_Syntax.mk_Typ_fun _110_56 None e.FStar_Absyn_Syntax.pos))
end
| FStar_Absyn_Syntax.Exp_app (head, args) -> begin
(
# 105 "FStar.Tc.Recheck.fst"
let t1 = (recompute_typ head)
in (match ((FStar_Absyn_Util.function_formals t1)) with
| None -> begin
FStar_Absyn_Syntax.tun
end
| Some (bs, c) -> begin
(
# 109 "FStar.Tc.Recheck.fst"
let rec aux = (fun subst bs args -> (match ((bs, args)) with
| ([], []) -> begin
(FStar_Absyn_Util.subst_typ subst (FStar_Absyn_Util.comp_result c))
end
| (_31_165, []) -> begin
(let _110_63 = (FStar_Absyn_Syntax.mk_Typ_fun (bs, c) None e.FStar_Absyn_Syntax.pos)
in (FStar_All.pipe_right _110_63 (FStar_Absyn_Util.subst_typ subst)))
end
| (b::bs, a::args) -> begin
(
# 113 "FStar.Tc.Recheck.fst"
let subst = (let _110_64 = (FStar_Absyn_Util.subst_formal b a)
in (_110_64)::subst)
in (aux subst bs args))
end
| _31_177 -> begin
(FStar_All.failwith "Too many arguments")
end))
in (aux [] bs args))
end))
end
| FStar_Absyn_Syntax.Exp_match (_31_179) -> begin
(FStar_All.failwith "Expect match nodes to be annotated already")
end
| FStar_Absyn_Syntax.Exp_ascribed (_31_182, t, _31_185) -> begin
t
end
| FStar_Absyn_Syntax.Exp_let (_31_189, e) -> begin
(recompute_typ e)
end
| FStar_Absyn_Syntax.Exp_uvar (_31_194, t) -> begin
t
end
| FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared (e, _31_200)) -> begin
(recompute_typ e)
end))
in (match ((FStar_ST.read e.FStar_Absyn_Syntax.tk)) with
| Some (t) -> begin
t
end
| None -> begin
(
# 127 "FStar.Tc.Recheck.fst"
let t = (recompute e)
in (
# 127 "FStar.Tc.Recheck.fst"
let _31_208 = (FStar_ST.op_Colon_Equals e.FStar_Absyn_Syntax.tk (Some (t)))
in t))
end)))




