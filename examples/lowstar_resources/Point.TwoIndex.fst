(*
   Copyright 2008-2019 Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)
module Point.TwoIndex

open FStar.HyperStack.ST
module B = LowStar.Buffer
module HS = FStar.HyperStack
module HST = FStar.HyperStack.ST
module Seq = FStar.Seq

open LowStar.Resource
open LowStar.RST.TwoIndex
open LowStar.RST.Pointer.TwoIndex

open LowStar.BufferOps

abstract
noeq
type point = {
    x: B.pointer int;
    y: B.pointer int
  }

type point_view_t = {
    x_view: int;
    y_view: int
  }

abstract
let point_view (p:point) : view point_view_t = 
  let fp = Ghost.hide (B.loc_union (B.loc_addr_of_buffer p.x) (B.loc_addr_of_buffer p.y)) in
  let inv h = 
    B.live h p.x /\ B.live h p.y /\ B.freeable p.x /\ B.freeable p.y /\ 
    B.loc_disjoint (B.loc_addr_of_buffer p.x) (B.loc_addr_of_buffer p.y) 
  in
  let sel (h:imem inv) = 
    { 
      x_view = Seq.index (B.as_seq h p.x) 0; 
      y_view = Seq.index (B.as_seq h p.y) 0
    } 
  in
  reveal_view ();
  {
    fp = fp;
    inv = inv;
    sel = sel
  }

let point_resource (p:point) = 
  as_resource (point_view p)

let sel_x (p:point) (h:imem (inv (point_resource p))) : GTot int = 
  (sel (point_view p) h).x_view
  
let sel_y (p:point) (h:imem (inv (point_resource p))) : GTot int = 
  (sel (point_view p) h).y_view

let mk_point (x y:B.pointer int) : point = 
  {
    x = x;
    y = y
  }

let unpack (p:point)
  : RST (B.pointer int & B.pointer int) 
        (point_resource p)
        (fun (x,y) -> ptr_resource x <*> ptr_resource y)
        (fun _ -> True)
        (fun h0 (x,y) h1 -> 
          sel_x p h0 = sel (ptr_view x) h1 /\ 
          sel_y p h0 = sel (ptr_view y) h1) = 
  reveal_star ();
  reveal_ptr ();
  reveal_rst_inv ();
  reveal_modifies ();
  (p.x,p.y)

let pack (x y:B.pointer int)
  : RST point
        (ptr_resource x <*> ptr_resource y)
        (fun p -> point_resource p)
        (fun _ -> True)
        (fun h0 p h1 -> 
          sel_x p h1 = sel (ptr_view x) h0 /\ 
          sel_y p h1 = sel (ptr_view y) h0) = 
  reveal_star ();
  reveal_ptr ();
  reveal_rst_inv ();
  reveal_modifies ();
  mk_point x y

let get_x (p:point)
  : RST int (point_resource p)
            (fun _ -> point_resource p)
            (fun _ -> True)
            (fun h0 x h1 -> 
               sel_x p h1 = x /\
               sel_x p h1 = sel_x p h0 /\
               sel_y p h1 = sel_y p h0) = 
  reveal_star ();
  reveal_ptr ();
  reveal_rst_inv ();
  reveal_modifies ();
  rst_frame #(ptr_resource p.x <*> ptr_resource p.y) #_ #_
            #(fun _ -> ptr_resource p.x <*> ptr_resource p.y)
            (ptr_resource p.y) 
            (fun _ -> ptr_read p.x)

let get_y (p:point)
  : RST int (point_resource p)
            (fun _ -> point_resource p)
            (fun _ -> True)
            (fun h0 y h1 -> 
               sel_x p h1 = sel_x p h0 /\
               sel_y p h1 = sel_y p h0 /\
               sel_y p h1 = y) = 
  reveal_star ();
  reveal_ptr ();
  reveal_rst_inv ();
  reveal_modifies ();
  rst_frame #(ptr_resource p.x <*> ptr_resource p.y) #_ #_
            #(fun _ -> ptr_resource p.x <*> ptr_resource p.y)
            (ptr_resource p.x) 
            (fun _ -> ptr_read p.y)

let set_x (p:point) (x:int)
  : RST unit (point_resource p)
             (fun _ -> point_resource p)
             (fun _ -> True)
             (fun h0 _ h1 -> 
                sel_x p h1 = x /\
                sel_y p h1 = sel_y p h0) = 
  reveal_star ();
  reveal_ptr ();
  reveal_rst_inv ();
  reveal_modifies ();
  rst_frame #(ptr_resource p.x <*> ptr_resource p.y) #_ #_
            #(fun _ -> ptr_resource p.x <*> ptr_resource p.y)
            (ptr_resource p.y) 
            (fun _ -> ptr_write p.x x)

let set_y (p:point) (y:int)
  : RST unit (point_resource p)
             (fun _ -> point_resource p)
             (fun _ -> True)
             (fun h0 _ h1 -> 
                sel_x p h1 = sel_x p h0 /\
                sel_y p h1 = y) = 
  reveal_star ();
  reveal_ptr ();
  reveal_rst_inv ();
  reveal_modifies ();
  rst_frame #(ptr_resource p.x <*> ptr_resource p.y) #_ #_
            #(fun _ -> ptr_resource p.x <*> ptr_resource p.y)
            (ptr_resource p.x) 
            (fun _ -> ptr_write p.y y)

let move_up (p:point)
  : RST unit (point_resource p)
             (fun _ -> point_resource p)
             (fun _ -> True)
             (fun h0 _ h1 -> 
               sel_x p h1 = sel_x p h0 /\ 
               sel_y p h1 = sel_y p h0 + 1) = 
  let y = get_y p in
  set_y p (y + 1)

let move_down (p:point)
  : RST unit (point_resource p)
             (fun _ -> point_resource p)
             (fun _ -> True)
             (fun h0 _ h1 -> 
               sel_x p h1 = sel_x p h0 /\ 
               sel_y p h1 = sel_y p h0 - 1) = 
  let y = get_y p in
  set_y p (y - 1)

let move_right (p:point)
  : RST unit (point_resource p)
             (fun _ -> point_resource p)
             (fun _ -> True)
             (fun h0 _ h1 -> 
               sel_x p h1 = sel_x p h0 + 1 /\ 
               sel_y p h1 = sel_y p h0) = 
  let x = get_x p in
  set_x p (x + 1)

let move_left (p:point)
  : RST unit (point_resource p)
             (fun _ -> point_resource p)
             (fun _ -> True)
             (fun h0 _ h1 -> 
               sel_x p h1 = sel_x p h0 - 1 /\ 
               sel_y p h1 = sel_y p h0) = 
  let x = get_x p in
  set_x p (x - 1)