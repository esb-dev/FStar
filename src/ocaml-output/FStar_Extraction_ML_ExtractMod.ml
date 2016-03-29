
open Prims
# 26 "FStar.Extraction.ML.ExtractMod.fst"
let fail_exp : FStar_Ident.lident  ->  FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.exp = (fun lid t -> (let _145_16 = (let _145_15 = (FStar_Absyn_Util.fvar None FStar_Absyn_Const.failwith_lid FStar_Absyn_Syntax.dummyRange)
in (let _145_14 = (let _145_13 = (FStar_Absyn_Syntax.targ t)
in (let _145_12 = (let _145_11 = (let _145_10 = (let _145_9 = (let _145_8 = (let _145_7 = (let _145_6 = (let _145_5 = (FStar_Absyn_Print.sli lid)
in (Prims.strcat "Not yet implemented:" _145_5))
in (FStar_Bytes.string_as_unicode_bytes _145_6))
in (_145_7, FStar_Absyn_Syntax.dummyRange))
in FStar_Const.Const_string (_145_8))
in (FStar_Absyn_Syntax.mk_Exp_constant _145_9 None FStar_Absyn_Syntax.dummyRange))
in (FStar_All.pipe_left FStar_Absyn_Syntax.varg _145_10))
in (_145_11)::[])
in (_145_13)::_145_12))
in (_145_15, _145_14)))
in (FStar_Absyn_Syntax.mk_Exp_app _145_16 None FStar_Absyn_Syntax.dummyRange)))

# 31 "FStar.Extraction.ML.ExtractMod.fst"
let mangle_projector_lid : FStar_Ident.lident  ->  FStar_Ident.lident = (fun x -> (
# 34 "FStar.Extraction.ML.ExtractMod.fst"
let projecteeName = x.FStar_Ident.ident
in (
# 35 "FStar.Extraction.ML.ExtractMod.fst"
let _66_11 = (FStar_Util.prefix x.FStar_Ident.ns)
in (match (_66_11) with
| (prefix, constrName) -> begin
(
# 36 "FStar.Extraction.ML.ExtractMod.fst"
let mangledName = (FStar_Absyn_Syntax.id_of_text (Prims.strcat (Prims.strcat (Prims.strcat "___" constrName.FStar_Ident.idText) "___") projecteeName.FStar_Ident.idText))
in (FStar_Ident.lid_of_ids (FStar_List.append prefix ((mangledName)::[]))))
end))))

# 37 "FStar.Extraction.ML.ExtractMod.fst"
let rec extract_sig : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.sigelt  ->  (FStar_Extraction_ML_Env.env * FStar_Extraction_ML_Syntax.mlmodule1 Prims.list) = (fun g se -> (
# 40 "FStar.Extraction.ML.ExtractMod.fst"
let _66_16 = (FStar_Extraction_ML_Env.debug g (fun u -> (let _145_25 = (let _145_24 = (FStar_Absyn_Print.sigelt_to_string se)
in (FStar_Util.format1 "now extracting :  %s \n" _145_24))
in (FStar_Util.print_string _145_25))))
in (match (se) with
| (FStar_Absyn_Syntax.Sig_datacon (_)) | (FStar_Absyn_Syntax.Sig_bundle (_)) | (FStar_Absyn_Syntax.Sig_tycon (_)) | (FStar_Absyn_Syntax.Sig_typ_abbrev (_)) -> begin
(
# 46 "FStar.Extraction.ML.ExtractMod.fst"
let _66_32 = (FStar_Extraction_ML_ExtractTyp.extractSigElt g se)
in (match (_66_32) with
| (c, tds) -> begin
(c, tds)
end))
end
| FStar_Absyn_Syntax.Sig_let (lbs, r, _66_36, quals) -> begin
(
# 50 "FStar.Extraction.ML.ExtractMod.fst"
let elet = (FStar_Absyn_Syntax.mk_Exp_let (lbs, FStar_Absyn_Const.exp_false_bool) None r)
in (
# 51 "FStar.Extraction.ML.ExtractMod.fst"
let _66_46 = (FStar_Extraction_ML_ExtractExp.synth_exp g elet)
in (match (_66_46) with
| (ml_let, _66_43, _66_45) -> begin
(match (ml_let.FStar_Extraction_ML_Syntax.expr) with
| FStar_Extraction_ML_Syntax.MLE_Let (ml_lbs, _66_49) -> begin
(
# 54 "FStar.Extraction.ML.ExtractMod.fst"
let _66_81 = (FStar_List.fold_left2 (fun _66_54 ml_lb _66_62 -> (match ((_66_54, _66_62)) with
| ((env, ml_lbs), {FStar_Absyn_Syntax.lbname = lbname; FStar_Absyn_Syntax.lbtyp = t; FStar_Absyn_Syntax.lbeff = _66_59; FStar_Absyn_Syntax.lbdef = _66_57}) -> begin
(
# 56 "FStar.Extraction.ML.ExtractMod.fst"
let _66_78 = if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _66_1 -> (match (_66_1) with
| FStar_Absyn_Syntax.Projector (_66_65) -> begin
true
end
| _66_68 -> begin
false
end)))) then begin
(
# 58 "FStar.Extraction.ML.ExtractMod.fst"
let mname = (let _145_31 = (let _145_30 = (FStar_Util.right lbname)
in (mangle_projector_lid _145_30))
in (FStar_All.pipe_right _145_31 FStar_Extraction_ML_Syntax.mlpath_of_lident))
in (
# 59 "FStar.Extraction.ML.ExtractMod.fst"
let env = (let _145_34 = (let _145_32 = (FStar_Util.right lbname)
in (FStar_All.pipe_left FStar_Absyn_Util.fv _145_32))
in (let _145_33 = (FStar_Util.must ml_lb.FStar_Extraction_ML_Syntax.mllb_tysc)
in (FStar_Extraction_ML_Env.extend_fv' env _145_34 mname _145_33 ml_lb.FStar_Extraction_ML_Syntax.mllb_add_unit false)))
in (
# 60 "FStar.Extraction.ML.ExtractMod.fst"
let ml_lb = (
# 60 "FStar.Extraction.ML.ExtractMod.fst"
let _66_71 = ml_lb
in {FStar_Extraction_ML_Syntax.mllb_name = _66_71.FStar_Extraction_ML_Syntax.mllb_name; FStar_Extraction_ML_Syntax.mllb_tysc = _66_71.FStar_Extraction_ML_Syntax.mllb_tysc; FStar_Extraction_ML_Syntax.mllb_add_unit = _66_71.FStar_Extraction_ML_Syntax.mllb_add_unit; FStar_Extraction_ML_Syntax.mllb_def = _66_71.FStar_Extraction_ML_Syntax.mllb_def; FStar_Extraction_ML_Syntax.print_typ = false})
in (env, (
# 61 "FStar.Extraction.ML.ExtractMod.fst"
let _66_74 = ml_lb
in {FStar_Extraction_ML_Syntax.mllb_name = ((Prims.snd mname), 0); FStar_Extraction_ML_Syntax.mllb_tysc = _66_74.FStar_Extraction_ML_Syntax.mllb_tysc; FStar_Extraction_ML_Syntax.mllb_add_unit = _66_74.FStar_Extraction_ML_Syntax.mllb_add_unit; FStar_Extraction_ML_Syntax.mllb_def = _66_74.FStar_Extraction_ML_Syntax.mllb_def; FStar_Extraction_ML_Syntax.print_typ = _66_74.FStar_Extraction_ML_Syntax.print_typ})))))
end else begin
(let _145_37 = (let _145_36 = (let _145_35 = (FStar_Util.must ml_lb.FStar_Extraction_ML_Syntax.mllb_tysc)
in (FStar_Extraction_ML_Env.extend_lb env lbname t _145_35 ml_lb.FStar_Extraction_ML_Syntax.mllb_add_unit false))
in (FStar_All.pipe_left Prims.fst _145_36))
in (_145_37, ml_lb))
end
in (match (_66_78) with
| (g, ml_lb) -> begin
(g, (ml_lb)::ml_lbs)
end))
end)) (g, []) (Prims.snd ml_lbs) (Prims.snd lbs))
in (match (_66_81) with
| (g, ml_lbs') -> begin
(let _145_40 = (let _145_39 = (let _145_38 = (FStar_Extraction_ML_Util.mlloc_of_range r)
in FStar_Extraction_ML_Syntax.MLM_Loc (_145_38))
in (_145_39)::(FStar_Extraction_ML_Syntax.MLM_Let (((Prims.fst ml_lbs), (FStar_List.rev ml_lbs'))))::[])
in (g, _145_40))
end))
end
| _66_83 -> begin
(FStar_All.failwith "impossible")
end)
end)))
end
| FStar_Absyn_Syntax.Sig_val_decl (lid, t, quals, r) -> begin
if (FStar_All.pipe_right quals (FStar_List.contains FStar_Absyn_Syntax.Assumption)) then begin
(
# 74 "FStar.Extraction.ML.ExtractMod.fst"
let impl = (match ((FStar_Absyn_Util.function_formals t)) with
| Some (bs, c) -> begin
(let _145_42 = (let _145_41 = (fail_exp lid (FStar_Absyn_Util.comp_result c))
in (bs, _145_41))
in (FStar_Absyn_Syntax.mk_Exp_abs _145_42 None FStar_Absyn_Syntax.dummyRange))
end
| _66_95 -> begin
(fail_exp lid t)
end)
in (
# 77 "FStar.Extraction.ML.ExtractMod.fst"
let se = FStar_Absyn_Syntax.Sig_let (((false, ({FStar_Absyn_Syntax.lbname = FStar_Util.Inr (lid); FStar_Absyn_Syntax.lbtyp = t; FStar_Absyn_Syntax.lbeff = FStar_Absyn_Const.effect_ML_lid; FStar_Absyn_Syntax.lbdef = impl})::[]), r, [], quals))
in (
# 78 "FStar.Extraction.ML.ExtractMod.fst"
let _66_100 = (extract_sig g se)
in (match (_66_100) with
| (g, mlm) -> begin
(
# 79 "FStar.Extraction.ML.ExtractMod.fst"
let is_record = (FStar_Util.for_some (fun _66_2 -> (match (_66_2) with
| FStar_Absyn_Syntax.RecordType (_66_103) -> begin
true
end
| _66_106 -> begin
false
end)) quals)
in (match ((FStar_Util.find_map quals (fun _66_3 -> (match (_66_3) with
| FStar_Absyn_Syntax.Discriminator (l) -> begin
Some (l)
end
| _66_112 -> begin
None
end)))) with
| Some (l) when (not (is_record)) -> begin
(let _145_49 = (let _145_48 = (let _145_45 = (FStar_Extraction_ML_Util.mlloc_of_range r)
in FStar_Extraction_ML_Syntax.MLM_Loc (_145_45))
in (let _145_47 = (let _145_46 = (FStar_Extraction_ML_ExtractExp.ind_discriminator_body g lid l)
in (_145_46)::[])
in (_145_48)::_145_47))
in (g, _145_49))
end
| _66_116 -> begin
(match ((FStar_Util.find_map quals (fun _66_4 -> (match (_66_4) with
| FStar_Absyn_Syntax.Projector (l, _66_120) -> begin
Some (l)
end
| _66_124 -> begin
None
end)))) with
| Some (_66_126) -> begin
(g, [])
end
| _66_129 -> begin
(g, mlm)
end)
end))
end))))
end else begin
(g, [])
end
end
| FStar_Absyn_Syntax.Sig_main (e, r) -> begin
(
# 90 "FStar.Extraction.ML.ExtractMod.fst"
let _66_139 = (FStar_Extraction_ML_ExtractExp.synth_exp g e)
in (match (_66_139) with
| (ml_main, _66_136, _66_138) -> begin
(let _145_53 = (let _145_52 = (let _145_51 = (FStar_Extraction_ML_Util.mlloc_of_range r)
in FStar_Extraction_ML_Syntax.MLM_Loc (_145_51))
in (_145_52)::(FStar_Extraction_ML_Syntax.MLM_Top (ml_main))::[])
in (g, _145_53))
end))
end
| (FStar_Absyn_Syntax.Sig_kind_abbrev (_)) | (FStar_Absyn_Syntax.Sig_assume (_)) | (FStar_Absyn_Syntax.Sig_new_effect (_)) | (FStar_Absyn_Syntax.Sig_sub_effect (_)) | (FStar_Absyn_Syntax.Sig_effect_abbrev (_)) | (FStar_Absyn_Syntax.Sig_pragma (_)) -> begin
(g, [])
end)))

# 101 "FStar.Extraction.ML.ExtractMod.fst"
let extract_iface : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.modul  ->  FStar_Extraction_ML_Env.env = (fun g m -> (let _145_58 = (FStar_Util.fold_map extract_sig g m.FStar_Absyn_Syntax.declarations)
in (FStar_All.pipe_right _145_58 Prims.fst)))

# 103 "FStar.Extraction.ML.ExtractMod.fst"
let rec extract : FStar_Extraction_ML_Env.env  ->  FStar_Absyn_Syntax.modul  ->  (FStar_Extraction_ML_Env.env * FStar_Extraction_ML_Syntax.mllib Prims.list) = (fun g m -> (
# 106 "FStar.Extraction.ML.ExtractMod.fst"
let _66_162 = (FStar_Absyn_Util.reset_gensym ())
in (
# 107 "FStar.Extraction.ML.ExtractMod.fst"
let name = (FStar_Extraction_ML_Syntax.mlpath_of_lident m.FStar_Absyn_Syntax.name)
in (
# 108 "FStar.Extraction.ML.ExtractMod.fst"
let g = (
# 108 "FStar.Extraction.ML.ExtractMod.fst"
let _66_165 = g
in {FStar_Extraction_ML_Env.tcenv = _66_165.FStar_Extraction_ML_Env.tcenv; FStar_Extraction_ML_Env.gamma = _66_165.FStar_Extraction_ML_Env.gamma; FStar_Extraction_ML_Env.tydefs = _66_165.FStar_Extraction_ML_Env.tydefs; FStar_Extraction_ML_Env.currentModule = name})
in if (((m.FStar_Absyn_Syntax.name.FStar_Ident.str = "Prims") || m.FStar_Absyn_Syntax.is_interface) || (let _145_63 = (FStar_ST.read FStar_Options.no_extract)
in (FStar_List.contains m.FStar_Absyn_Syntax.name.FStar_Ident.str _145_63))) then begin
(
# 112 "FStar.Extraction.ML.ExtractMod.fst"
let g = (extract_iface g m)
in (g, []))
end else begin
(
# 114 "FStar.Extraction.ML.ExtractMod.fst"
let _66_171 = (FStar_Util.fold_map extract_sig g m.FStar_Absyn_Syntax.declarations)
in (match (_66_171) with
| (g, sigs) -> begin
(
# 115 "FStar.Extraction.ML.ExtractMod.fst"
let mlm = (FStar_List.flatten sigs)
in (let _145_68 = (let _145_67 = (let _145_66 = (let _145_65 = (let _145_64 = (FStar_Extraction_ML_Util.flatten_mlpath name)
in (_145_64, Some (([], mlm)), FStar_Extraction_ML_Syntax.MLLib ([])))
in (_145_65)::[])
in FStar_Extraction_ML_Syntax.MLLib (_145_66))
in (_145_67)::[])
in (g, _145_68)))
end))
end))))




