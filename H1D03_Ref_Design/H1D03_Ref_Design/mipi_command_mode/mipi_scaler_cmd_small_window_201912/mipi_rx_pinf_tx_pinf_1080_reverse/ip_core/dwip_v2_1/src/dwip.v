//================================================================================
// Copyright (c) 2015 Capital-micro, Inc.(Beijing)  All rights reserved.
//
// Capital-micro, Inc.(Beijing) Confidential.
//
// No part of this code may be reproduced, distributed, transmitted,
// transcribed, stored in a retrieval system, or translated into any
// human or computer language, in any form or by any means, electronic,
// mechanical, magnetic, manual, or otherwise, without the express
// written permission of Capital-micro, Inc.
//
//================================================================================
// Module Description: 
// This is the core of debugware IP 
//================================================================================
// Revision History :
//     V2.0   2015-05-28  FPGA IP Grp, first created
//     V2.1   2015-09-08  FPGA IP Grp, support C1 device
//================================================================================


`pragma protect begin_protected
`pragma protect version=1
`pragma protect data_block
npevmf!mb`dpsf)!!!!sfg`dml-!!!!udl-!!!!uej-!!!!vqebuf-!!!!tijgu-!!!!tubuvt`tfm-!!!!dusm`tfm-!!!!nfn`tfm-!!!!pggtfu`tfm-!!!!tfm-!!!!sftfu-!!!!sftfu`sbees-!!!!nfn`sfbe-!!!!usjh`pvu-!!!!ebub`jo-!!!!uep*<qbsbnfufs!EBUB`XJEUI!!!>!:1<!!!qbsbnfufs!TBNQMF`EFQUI!>!3159<!!qbsbnfufs!BEES`XJEUI!!!>!22<qbsbnfufs!EFWJDF`OBNF!!>!4(c111<!!joqvu!sfg`dml<joqvu!udl<joqvu!uej<joqvu!vqebuf<joqvu!tijgu<joqvu!tubuvt`tfm<joqvu!dusm`tfm<joqvu!nfn`tfm<joqvu!pggtfu`tfm<joqvu!tfm<joqvu!sftfu<joqvu!sftfu`sbees<joqvu!nfn`sfbe<joqvu!\EBUB`XJEUI.2;1^!ebub`jo<pvuqvu!usjh`pvu<pvuqvu!uep<xjsf!usjh`pvu<xjsf!\3+EBUB`XJEUI!,4!;1^!dusm<!xjsf!\BEES`XJEUI,2;1^!tubuvt<xjsf!\EBUB`XJEUI.2;1^!nfn<xjsf!\BEES`XJEUI.2;1^!pggtfu<xjsf!dusm`uep-!tubuvt`uep-!nfn`uep-!pggtfu`uep<bttjho!uep!>!)dusm`uep!'!dusm`tfm*!}!)tubuvt`uep!'!tubuvt`tfm*!}!)nfn`uep!'!nfn`tfm*!}!)pggtfu`uep!'!pggtfu`tfm*<sfh!sftfu`s<bmxbzt!A)qptfehf!sfg`dml*!cfhjo
sftfu`s!=>!sftfu<foekubh`sfh`xs!!!!!!!$)!
!!!!/MFOHUI!)3+EBUB`XJEUI,5*!

*!!!!!v`dusm!)!!!!!!!!/fo!)dusm`tfm'tfm*-!!!!!!!!/udl!)udl*-!!!!!!!!/vqebuf!)vqebuf*-!!!!!!!!/tijgu!)tijgu*-!!!!!!!!/uej!)uej*-!!!!!!!!/uep!)dusm`uep*-!!!!!!!!/epvu!)dusm**<kubh`sfh`xs!!!!!!!$)!!!!!!!!!/MFOHUI!)BEES`XJEUI*!

*!!!!!v`pggtfu!)!!!!!!!!/fo!)pggtfu`tfm'tfm*-!!!!!!!!/udl!)udl*-!!!!!!!!/vqebuf!)vqebuf*-!!!!!!!!/tijgu!)tijgu*-!!!!!!!!/uej!)uej*-!!!!!!!!/uep!)pggtfu`uep*-!!!!!!!!/epvu!)pggtfu**<kubh`sfh`se!!!!!!!$)!
!!!!/MFOHUI!)BEES`XJEUI,3*!

*!!!!!v`tubuvt!)!!!!!!!!/fo!)tubuvt`tfm'tfm*-!!!!!!!!/udl!)udl*-!!!!!!!!/vqebuf!)vqebuf*-!!!!!!!!/tijgu!)tijgu*-!!!!!!!!/uep!)tubuvt`uep*-!!!!!!!!/ejo!)tubuvt*-!!!!!!!!/epvu!)**<kubh`sfh`se!!!!!!!$)!
!!!!/MFOHUI!)EBUB`XJEUI*!

*!!!!!v`nfn!)!!!!!!!!/fo!)nfn`tfm'tfm*-!!!!!!!!/udl!)udl*-!!!!!!!!/vqebuf!)vqebuf*-!!!!!!!!/tijgu!)tijgu*-!!!!!!!!/uep!)nfn`uep*-!!!!!!!!/ejo!)nfn*-!!!!!!!!/epvu!)**<hfofsbuf!jg)EFWJDF`OBNF!>>!4(c211*cfhjousjhhfs`d2!$)!!!!!!!!/EBUB`XJEUI)EBUB`XJEUI*

*v`usjhhfs!)!!!!!!!!/sfg`dml!!!!!)sfg`dml*-!!!!!!!!/sftfu!!!!!!!)sftfu`s*-

/dusm!!!!!!!!)dusm\4;1^*-!!!!!!!!!/usjhhfs`tfu!)dusm\3+EBUB`XJEUI,4;5^*-!!!!!!!!/ebub`jo!!!!!)ebub`jo*-!!!!!!!!/usjh`pvu!!!!)usjh`pvu**<foefmtf!cfhjousjhhfs!$)!!!!!!!!/EBUB`XJEUI)EBUB`XJEUI*

*v`usjhhfs!)!!!!!!!!/sfg`dml!!!!!)sfg`dml*-!!!!!!!!/sftfu!!!!!!!)sftfu`s*-

/dusm!!!!!!!!)dusm\4;1^*-!!!!!!!!!/usjhhfs`tfu!)dusm\3+EBUB`XJEUI,4;5^*-!!!!!!!!/ebub`jo!!!!!)ebub`jo*-!!!!!!!!/usjh`pvu!!!!)usjh`pvu**<foefoehfofsbuftupsbhf!!!!!!!$)!!!!!!!!/EBUB`XJEUI)EBUB`XJEUI*-

/TBNQMF`EFQUI)TBNQMF`EFQUI*-

/BEES`XJEUI)BEES`XJEUI*-

/EFWJDF`OBNF)EFWJDF`OBNF*

*!!!!v`tupsbhf!)!!!!!!!!/sftfu!)sftfu`s*-!!!!!!!!/sfg`dml!)sfg`dml*-!!!!!!!!/usjhhfs!)usjh`pvu*-!!!!!!!!/ebub`jo!)ebub`jo*-!!!!!!!!/dusm`su!)dusm\1^*-!!!!!!!!/nfn`sfbe!)nfn`sfbe*-!!!!!!!!/nfn`dml!)udl*-!!!!!!!!/nfn`pvu!)nfn*-!!!!!!!!/tubuvt!)tubuvt*-!!!!!!!!/pggtfu!)pggtfu*-!!!!!!!!/sftfu`sbees!)sftfu`sbees*-!!!!!!!!/tfm!)tfm*-

/nfn`tfm)nfn`tfm**<foenpevmfnpevmf!mb`nbobhfs!)!!!!!!!!!!!!!!!!!!!udl2-!uej2-!uep2-!tfm2-!





!udl3-!uej3-!uep3-!tfm3-!!!!!!!!!!!!!!!!!!!!vqebuf-!vqebuf`dml-!tijgu-!sftfu-!





!tubuvt-!dusm-!nfn-!pggtfu-!!!!!!!!!!!!!!!!!!!mb`tfm-!mb`sftfu-!mb`udl-!mb`vqebuf-!mb`tijgu-!mb`uej-!mb`uep





!*<qbsbnfufs!OVN`PG`MB!>!2<joqvu!udl2-!uej2-!tfm2-!udl3-!uej3-!tfm3-!vqebuf-!vqebuf`dml-!tijgu-!sftfu<!joqvu!\OVN`PG`MB.2;1^!mb`uep<pvuqvu!uep2-!uep3-!tubuvt-!dusm-!nfn-!pggtfu-!mb`sftfu-!mb`udl-!mb`vqebuf-!mb`tijgu-!mb`uej<pvuqvu!\OVN`PG`MB.2;1^!mb`tfm<xjsf!\OVN`PG`MB,9.2;1^!epvu<xjsf!\3;1^!pqdpef<!!!!kubh`sfh`xs!
!!!$)!
!!!!/MFOHUI!)OVN`PG`MB,9*!

*!
!!!
!!!v`dne!)!!!!!!!!/fo)tfm2*-!!!!!!!!/udl)udl2*-!!!!!!!!/vqebuf)vqebuf`dml*-!!!!!!!!/tijgu)tijgu*-!!!!!!!!/uej)uej2*-!!!!!!!!/uep)uep2*-!!!!!!!!/epvu)epvu*!!!!*<!!!!efgqbsbn!v`dne/MFOHUI>!OVN`PG`MB,9<!!!!bttjho!pqdpef!>!epvu\OVN`PG`MB,8;!OVN`PG`MB,6^<!!!!bttjho!pggtfu!>!epvu\OVN`PG`MB,4^'tfm3<!!!!bttjho!tubuvt!>!epvu\OVN`PG`MB,3^'tfm3<!!!!bttjho!dusm!>!epvu\OVN`PG`MB,2^'tfm3<!!!!bttjho!nfn!>!epvu\OVN`PG`MB^<!!!!bttjho!mb`sftfu!>!0+vqebuf'+0)'pqdpef*<!!!!!!!bttjho!mb`tfm!>!epvu\OVN`PG`MB.2;1^<!!!!bttjho!mb`udl!>!udl3<
!!!!bttjho!mb`vqebuf!>!vqebuf`dml<!!!!bttjho!mb`tijgu!>!tijgu<!!!!bttjho!mb`uej!>!uej3<!!!!bttjho!uep3!>!})mb`tfm'mb`uep*<foenpevmfnpevmf!tupsbhf)!!!!sftfu-!!!!sfg`dml-!!!!usjhhfs-!!!!ebub`jo-!!!!nfn`sfbe-!!!!nfn`dml-!!!!nfn`pvu-!!!!tubuvt-!!!!pggtfu-!!!!sftfu`sbees-!!!!tfm-!!!!nfn`tfm-!!!!dusm`su*<qbsbnfufs!EBUB`XJEUI!!!>!:2<!!!qbsbnfufs!TBNQMF`EFQUI!>!3159<!!qbsbnfufs!BEES`XJEUI!!!>!22<qbsbnfufs!EFWJDF`OBNF!!>!4(c111<!joqvu!sftfu<joqvu!sfg`dml<joqvu!usjhhfs<joqvu!\EBUB`XJEUI.2;1^!ebub`jo<joqvu!nfn`sfbe<joqvu!nfn`dml<pvuqvu!\EBUB`XJEUI.2;1^!nfn`pvu<pvuqvu!\BEES`XJEUI,2;1^!tubuvt<joqvu!\BEES`XJEUI.2;1^!pggtfu<joqvu!sftfu`sbees<joqvu!tfm<joqvu!nfn`tfm<joqvu!dusm`su<xjsf!\BEES`XJEUI.2;1^!xbees<xjsf!\BEES`XJEUI.2;1^!sbees<xjsf!xfo<nfn`dusm!!!!!!!$)!
!!!!/BEES`XJEUI!)BEES`XJEUI*


*!!!!!!v`nfn`dusm`1!)!!!!!!!!/sftfu!)sftfu*-!!!!!!!!/usjhhfs!)usjhhfs*-!!!!!!!!/xdml!)sfg`dml*-!!!!!!!!/sdml!)nfn`sfbe*-!!!!!!!!/xbees!)xbees*-!!!!!!!!/sbees!)sbees*-!!!!!!!!/xfo!)xfo*-!!!!!!!!/tubuvt!)tubuvt*-!!!!!!!!/pggtfu!)pggtfu*-!!!!!!!!/sftfu`sbees!)sftfu`sbees*-!!!!!!!!/tfm!)tfm*-
/nfn`tfm)nfn`tfm*-
/su`tfm)dusm`su**<hfofsbuf!jg)EFWJDF`OBNF!>>!4(c111*cfhjo
efcvh`nfnpsz`n6

!!$)


/EBUB`XJEUI)EBUB`XJEUI*-


/TBNQMF`EFQUI)TBNQMF`EFQUI*-


/BEES`XJEUI)BEES`XJEUI*


*

!v`nfnpsz!)


/dmlx!)sfg`dml*-


/dfx!!)xfo*-


/bx!!!)xbees*-


/ex!!!)ebub`jo*-


/dmls!)nfn`dml*-


/dfs!!)2(c2*-


/bs!!!)sbees*-


/rs!!!)nfn`pvu*
*<foefmtf!jg)EFWJDF`OBNF!>>!4(c112*cfhjo
efcvh`nfnpsz`n8


!!$)



/EBUB`XJEUI)EBUB`XJEUI*-



/TBNQMF`EFQUI)TBNQMF`EFQUI*-



/BEES`XJEUI)BEES`XJEUI*



*


!v`nfnpsz!)



/dmlx!)sfg`dml*-



/dfx!!)xfo*-



/bx!!!)xbees*-



/ex!!!)ebub`jo*-



/dmls!)nfn`dml*-



/dfs!!)2(c2*-



/bs!!!)sbees*-



/rs!!!)nfn`pvu*

*<foefmtf!jg)EFWJDF`OBNF!>>!4(c121!}}!EFWJDF`OBNF!>>!4(c122*cfhjo
efcvh`nfnpsz`is



!!$)




/EBUB`XJEUI)EBUB`XJEUI*-




/TBNQMF`EFQUI)TBNQMF`EFQUI*-




/BEES`XJEUI)BEES`XJEUI*




*



!v`nfnpsz!)




/dmlx!)sfg`dml*-




/dfx!!)xfo*-




/bx!!!)xbees*-




/ex!!!)ebub`jo*-




/dmls!)nfn`dml*-




/dfs!!)2(c2*-




/bs!!!)sbees*-




/rs!!!)nfn`pvu*


*<foefmtf!jg)EFWJDF`OBNF!>>!4(c211*cfhjo
efcvh`nfnpsz`d2



!!$)




/EBUB`XJEUI)EBUB`XJEUI*-




/TBNQMF`EFQUI)TBNQMF`EFQUI*-




/BEES`XJEUI)BEES`XJEUI*




*



!v`nfnpsz!)




/dmlx!)sfg`dml*-




/dfx!!)xfo*-




/bx!!!)xbees*-




/ex!!!)ebub`jo*-




/dmls!)nfn`dml*-




/dfs!!)2(c2*-




/bs!!!)sbees*-




/rs!!!)nfn`pvu*


*<foefoehfofsbuffoenpevmfnpevmf!nfn`dusm!)sftfu-!!!!!!!!!!!!!!!!!!usjhhfs-!



!xdml-!



!sdml-!



!xbees-!



!sbees-!



!xfo-!



!tubuvt-!



!pggtfu-!



!sftfu`sbees-!



!tfm-



!nfn`tfm-



!su`tfm



*<




!!qbsbnfufs!BEES`XJEUI!>!22<joqvu!sftfu-!usjhhfs-!xdml-!sdml-!tfm<joqvu!sftfu`sbees<joqvu!nfn`tfm<joqvu!su`tfm<joqvu!\BEES`XJEUI.2;1^!pggtfu<pvuqvu!\BEES`XJEUI.2;1^!xbees<pvuqvu!\BEES`XJEUI.2;1^!sbees<pvuqvu!\BEES`XJEUI,3.2;1^!tubuvt<pvuqvu!xfo<sfh!\BEES`XJEUI.2;1^!xbees<sfh!\BEES`XJEUI.2;1^!sbees<sfh!\BEES`XJEUI.2;1^!efqui`dpvou<sfh!\BEES`XJEUI.2;1^!ufnq<sfh!usjhhfs`e<sfh!dpvu<sfh!pwfsgmpx<sfh!epof<sfh!xfo<sfh!dbquvsf<!!!!bttjho!tubuvt\BEES`XJEUI,2^!>!pwfsgmpx<!!!!bttjho!tubuvt\BEES`XJEUI^!>!epof<!!!!bttjho!tubuvt\BEES`XJEUI.2;1^!>!xbees<!!!!!!!!bmxbzt!A)qptfehf!xdml*!!!!cfhjo!!!!!!!!jg!)sftfu*!cfhjo!!!!!!!!!!!!xfo!=>!2(c2<!!!!!!!!foe!fmtf!jg!)epof*!cfhjo!!!!!!!!!!!!xfo!=>!2(c1<!!!!!!!!foe!fmtf!cfhjo!!!!!!!!!!!!xfo!=>!xfo<!!!!!!!!foe!!!!foe!!!!!!!!bmxbzt!A)qptfehf!xdml*!!!!cfhjo!!!!!!!!jg!)sftfu*!cfhjo!!!!!!!!!!!!xbees!=>!1<!!!!!!!!!!!!dpvu!=>!2(c1<!!!!!!!!foe!fmtf!jg!)"epof*!cfhjo!!!!!!!!!!!!|dpvu-!xbees~!=>!xbees!,!2<!!!!!!!!foe!fmtf!cfhjo!!!!!!!!!!!!xbees!=>!xbees<!!!!!!!!foe!!!!foe!!!!!!!!bmxbzt!A)qptfehf!xdml*!!!!cfhjo!!!!!!!!jg!)sftfu*!cfhjo!!!!!!!!!!!!pwfsgmpx!=>!2(c1<!!!!!!!!foe!fmtf!jg!)dpvu*!cfhjo!!!!!!!!!!!!pwfsgmpx!=>!2(c2<!!!!!!!!foe!fmtf!cfhjo!!!!!!!!!!!!pwfsgmpx!=>!pwfsgmpx<!!!!!!!!foe!!!!foe!!!!!!!!bmxbzt!A)qptfehf!xdml*!!!!cfhjo!!!!!!!!jg!)sftfu*!cfhjo!!!!!!!!!!!!dbquvsf!=>!2(c1<!!!!!!!!foe!fmtf!jg!)"epof*!cfhjo!!!!!!!!!!!!jg!)usjhhfs')usjhhfs`e**!cfhjo!!!!!!!!!!!!!!!!dbquvsf!=>!2(c2<!!!!!!!!!!!!foe!fmtf!cfhjo!!!!!!!!!!!!!!!dbquvsf!=>!dbquvsf<!!!!!!!!!!!!foe!!!!!!!!foe!fmtf!cfhjo!!!!!!!!!!!!dbquvsf!=>!dbquvsf<!!!!!!!!foe!!!!foe!!!!bmxbzt!A)qptfehf!xdml*!!!!cfhjo!!!!!!!!jg!)sftfu*!cfhjo!!!!!!!!!!!!usjhhfs`e!=>!2(c2<!!!!!!!!foe!fmtf!cfhjo!!!!!!!!!!!!usjhhfs`e!=>!usjhhfs<!!!!!!!!foe!!!!foe!!!!!!!!bmxbzt!A)qptfehf!xdml*!!!!cfhjo!!!!!!!!jg!)sftfu*!cfhjo!!!!!!!!!!!!efqui`dpvou!=>!2!<!!!!!!!!foe!fmtf!jg!)dbquvsf*!cfhjo!!!!!!!!!!!!jg!)"epof*!cfhjo!!!!!!!!!!!!!!!!efqui`dpvou!=>!efqui`dpvou!,!2<!!!!!!!!!!!!foe!!!!!!!!foe!fmtf!cfhjo!!!!!!!!!!!!efqui`dpvou!=>!efqui`dpvou<!!!!!!!!foe!!!!foe


bmxbzt!A)qptfehf!xdml*
cfhjo

jg!)sftfu*!cfhjo


epof!=>!2(c1<

foe!fmtf!cfhjo


jg!)"epof*!cfhjo


!!!jg)su`tfm*


!!!|epof-!ufnq~!=>!efqui`dpvou!,!pggtfu!,!2<


!!!fmtf



|epof-!ufnq~!=>!efqui`dpvou!,!pggtfu!,!6<


foe

foe
foe


!!!!
bmxbzt!A)qptfehf!sdml!ps!qptfehf!sftfu`sbees*!!!!cfhjo!!!!!!!!jg!)sftfu`sbees*!cfhjo!!!!!!!!!!!!sbees!=>!1<!!!!!!!!foe!fmtf!jg)tfm!'!nfn`tfm*!cfhjo!!!!!!!!!!!!sbees!=>!sbees!,!2<!!!!!!!!foe!!!!foefoenpevmfnpevmf!ubq)!!!!udl2-!!!!uej2-!!!!uep2-!!!!tfm2-!!!!udl3-!!!!uej3-!!!!uep3-!!!!tfm3-!!!!vqebuf-!!!!tijgu-!!!!sftfu*<qbsbnfufs!EFWJDF`OBNF!>!4(c111<!pvuqvu!udl2<pvuqvu!uej2<joqvu!uep2<pvuqvu!tfm2<pvuqvu!udl3<pvuqvu!uej3<joqvu!uep3<pvuqvu!tfm3<pvuqvu!vqebuf<pvuqvu!tijgu<pvuqvu!sftfu<xjsf!uej<bttjho!uej2!>!uej<bttjho!uej3!>!uej<xjsf!esdl<xjsf!hsdl<HCVG!v`hcvg`udl!)
/jo)esdl*-
/pvu)hsdl*
*<bttjho!udl2!>!hsdl<bttjho!udl3!>!hsdl<xjsf!\2;1^!tfm<bttjho!tfm2!>!tfm\1^<bttjho!tfm3!>!tfm\2^<xjsf!uep<bttjho!uep!>!tfm2!@!uep2;uep3<hfofsbufjg)EFWJDF`OBNF!>>!4(c111*cfhjoEFCVH`JOG!v`efcvh`jog!)!!!!!!!!/dbquvsf!)*-!!!!!!!!/esdl!)esdl*-!!!!!!!!/sftfu!)sftfu*-!!!!!!!!/tfm!)tfm*-!!!!!!!!/tijgu!)tijgu*-!!!!!!!!/uej!)uej*-!!!!!!!!/uep!)uep*-!!!!!!!!/vqebuf!)vqebuf**<foefmtf!jg)EFWJDF`OBNF!>>!4(c112*cfhjoN8B`KUBH!v`kubh!)!!!!!!!!/kubh`gq`esdl!)esdl*-!!!!!!!!/kubh`gq`sftfu!)sftfu*-!!!!!!!!/kubh`gq`tfm!)tfm*-!!!!!!!!/kubh`gq`dbquvsf!)*-!!!!!!!!/kubh`gq`tijgu!)tijgu*-!!!!!!!!/kubh`gq`vqebuf!)vqebuf*-!!!!!!!!/kubh`gq`uej!)uej*-!!!!!!!!/kubh`gq`uep!)uep**<foefmtf!jg!)EFWJDF`OBNF!>>!4(c121!}}!EFWJDF`OBNF!>>!4(c122*cfhjoM4`KUBH!v`kubh!)!!!!!!!!/kubh`gq`esdl!)esdl*-!!!!!!!!/kubh`gq`sftfu!)sftfu*-!!!!!!!!/kubh`gq`tfm!)tfm*-!!!!!!!!/kubh`gq`dbquvsf!)*-!!!!!!!!/kubh`gq`tijgu!)tijgu*-!!!!!!!!/kubh`gq`vqebuf!)vqebuf*-!!!!!!!!/kubh`gq`uej!)uej*-!!!!!!!!/kubh`gq`uep!)uep**<foefmtf!jg!)EFWJDF`OBNF!>>!4(c211*cfhjoKUBH`ECXW2!v`kubh!)!!!!!!!!/kubh`gq`esdl!)esdl*-!!!!!!!!/kubh`gq`sftfu!)sftfu*-!!!!!!!!/kubh`gq`tfm!)tfm*-!!!!!!!!/kubh`gq`dbquvsf!)*-!!!!!!!!/kubh`gq`tijgu!)tijgu*-!!!!!!!!/kubh`gq`vqebuf!)vqebuf*-!!!!!!!!/kubh`gq`uej!)uej*-!!!!!!!!/kubh`gq`uep!)uep**<foefoehfofsbuf!foenpevmfnpevmf!usjhhfs)!!!!sfg`dml-!!!!sftfu-!!!!ebub`jo-!!!!usjhhfs`tfu-
dusm-!!!!usjh`pvu*<qbsbnfufs!EBUB`XJEUI!!!>!:7<!!!!!!!!!!!!!!!!qbsbnfufs!SFNBJOEFS`1!!>!EBUB`XJEUI!&!8<qbsbnfufs!MVU5`OVN`1!!!>!)EBUB`XJEUI!.!SFNBJOEFS`1*!0!8<qbsbnfufs!SFNBJOEFS`2!!>!)MVU5`OVN`1!,!))SFNBJOEFS`1!>>!1*!@!1!;!2**!&!8<qbsbnfufs!MVU5`OVN`2!!!>!))MVU5`OVN`1!=!8*!}}!))MVU5`OVN`1!>>!8*!''!)SFNBJOEFS`1!>>!1***!@!1!;!2<joqvu!sfg`dml<joqvu!sftfu<joqvu!\EBUB`XJEUI.2;1^!ebub`jo<joqvu!\3+EBUB`XJEUI.2;1^!usjhhfs`tfu<joqvu!\4;1^!dusm<!pvuqvu!usjh`pvu<xjsf!!\EBUB`XJEUI.2;1^!dpnqbsf`sftvmu`1-!dpnqbsf`sftvmu`ofr`1<xjsf!!!tfm`fr-!tfm`ofr-!tfm`sjtf-!tfm`gbmm-!tfm`su<!xjsf!!\EBUB`XJEUI!.2;1^!dpnqbsf`ebub<sfh!!!\EBUB`XJEUI.2;1^!dpnqbsf`sftvmu`1`t-!dpnqbsf`sftvmu`ofr`1`t<sfh!!!\MVU5`OVN`1;1^!!!dpnqbsf`sftvmu`2`t-!dpnqbsf`sftvmu`ofr`2`t<sfh!!!\MVU5`OVN`2;1^!!!dpnqbsf`sftvmu`3`t-!dpnqbsf`sftvmu`ofr`3`t<sfh!!!!!!!!!!!!!!!!!!!!dpnqbsf`sftvmu-!dpnqbsf`sftvmu`ofr<sfh!!!!!!!!!!!!!!!!!!!!dpnqbsf`sjtf`s-!dpnqbsf`sjtf-!dpnqbsf`gbmm`s-!dpnqbsf`gbmm<sfh!!!\EBUB`XJEUI.2;1^!ebub`jo`s!<!sfh!!!!!!!!!!!!!!!!!!!!ebub`jo`s`e<sfh!!!\2;1^!!!!!!!!!!!!ebub`gps`fehf`s-!ebub`gps`fehf`g<sfh!!!\EBUB`XJEUI!.2;!1^dpnqbsf`ebub`s-dpnqbsf`ebub`g<sfh!!!dpnqbsf`ebub`jou`s-!dpnqbsf`ebub`jou`g-dpnqbsf`ebub`jou`s`e-dpnqbsf`ebub`jou`g`e<sfh!!!usjh`pvu<!bttjho!tfm`fr!!!>!dusm!>>!5(c1121<!bttjho!tfm`ofr!!>!dusm!>>!5(c1111<!bttjho!tfm`sjtf!>!dusm!>>!5(c1211<!bttjho!tfm`gbmm!>!dusm!>>!5(c2111<!bttjho!tfm`su!!!>!dusm\1^<hfowbs!usjhhfs`j<hfofsbuf!gps!)usjhhfs`j!>!1<!usjhhfs`j!=!EBUB`XJEUI<!usjhhfs`j!>!usjhhfs`j!,2*!cfhjo!!!!!bttjho!dpnqbsf`sftvmu`ofr`1\usjhhfs`j^!>!usjhhfs`tfu\3+usjhhfs`j^!@!2(c1!;!)ebub`jo\usjhhfs`j^!">!usjhhfs`tfu\3+usjhhfs`j,2^*<
!bttjho!dpnqbsf`sftvmu`1\usjhhfs`j^!!!!!>!usjhhfs`tfu\3+usjhhfs`j^!@!2(c2!;!)ebub`jo\usjhhfs`j^!>>!usjhhfs`tfu\3+usjhhfs`j,2^*<
!bttjho!dpnqbsf`ebub\usjhhfs`j^!!!!!!!!!>!ebub`jo\usjhhfs`j^!'!usjhhfs`tfu\3+usjhhfs`j^<foefoehfofsbufbmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`ebub`s!=>!2<fmtf!!!!dpnqbsf`ebub`s!=>!dpnqbsf`ebub<!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*cfhjo!!!dpnqbsf`ebub`jou`s!!!!=>!2<!!!dpnqbsf`ebub`jou`s`e!!=>!2<!!!foefmtf!cfhjo!!!dpnqbsf`ebub`jou`s!!!=>!}dpnqbsf`ebub`s<!!!dpnqbsf`ebub`jou`s`e!=>!!dpnqbsf`ebub`jou`s<!!!foe!!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!ebub`gps`fehf`s!=>!3(c11<fmtf!!!!ebub`gps`fehf`s!=>!|dpnqbsf`ebub`jou`s`e-dpnqbsf`ebub`jou`s~<!!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`sjtf!=>!1<!fmtf!jg)ebub`gps`fehf`s!>>!3(c12*!!!dpnqbsf`sjtf!=>!2<!fmtf!!!dpnqbsf`sjtf!=>!1<!!!foe!bmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`ebub`g!=>!1<fmtf!!!!dpnqbsf`ebub`g!=>!dpnqbsf`ebub<foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*cfhjo!!!dpnqbsf`ebub`jou`g!!!!=>!1<!!!dpnqbsf`ebub`jou`g`e!!=>!1<!!!foefmtf!cfhjo!!!dpnqbsf`ebub`jou`g!!!=>!}dpnqbsf`ebub`g<!!!dpnqbsf`ebub`jou`g`e!=>!!dpnqbsf`ebub`jou`g<!!!foe!!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!ebub`gps`fehf`g!=>!3(c11<fmtf!!!!ebub`gps`fehf`g!=>!|dpnqbsf`ebub`jou`g`e-dpnqbsf`ebub`jou`g~<!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`gbmm!=>!1<!fmtf!jg)ebub`gps`fehf`g!>>!3(c21*!!!dpnqbsf`gbmm!=>!2<fmtf!!!dpnqbsf`gbmm!=>!1<!!!!!foe!hfofsbuf!bmxbzt!A)qptfehf!sfg`dml*!cfhjo;s`1`tjg)sftfu*cfhjo!!!dpnqbsf`sftvmu`ofr`1`t!=>!1<!!!dpnqbsf`sftvmu`1`t!!!!!=>!1<!!!foefmtf!cfhjo!!!dpnqbsf`sftvmu`ofr`1`t!=>!dpnqbsf`sftvmu`ofr`1<!!!!!dpnqbsf`sftvmu`1`t!!!!!=>!dpnqbsf`sftvmu`1<!!!foefoe!foehfofsbufhfowbs!mvu5`dou`1<hfofsbufjg)MVU5`OVN`1!">!1*!cfhjo;s`2`t`1!!!gps!)mvu5`dou`1!>!1<mvu5`dou`1!=!MVU5`OVN`1<mvu5`dou`1!>!mvu5`dou`1,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\mvu5`dou`1^!=>!1<

!dpnqbsf`sftvmu`2`t\mvu5`dou`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\mvu5`dou`1^!=>!dpnqbsf`sftvmu`ofr`1`t\mvu5`dou`1+8,7;mvu5`dou`1+8^!">!8(i1<!!

!dpnqbsf`sftvmu`2`t\mvu5`dou`1^!=>!)dpnqbsf`sftvmu`1`t\mvu5`dou`1+8,7;mvu5`dou`1+8^!>>!8(i8g*<!

!foe!!!!!!foe!!!foefoefoehfofsbufhfofsbufjg)SFNBJOEFS`1!>>!1*!cfhjo;s`2`t`1`2!!!jg)MVU5`OVN`1!">!1*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU5`OVN`1^!=>!1<

!dpnqbsf`sftvmu`2`t\MVU5`OVN`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU5`OVN`1^!=>!1<!!

!dpnqbsf`sftvmu`2`t\MVU5`OVN`1^!!!!!=>!1<!!

!foe!!!!!!foe!!!foe!!foefoehfofsbufhfofsbufjg)SFNBJOEFS`1!">1!*!cfhjo;s`2`t`2!!!jg)MVU5`OVN`1!>>!1*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU5`OVN`1^!=>!1<

!dpnqbsf`sftvmu`2`t\MVU5`OVN`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU5`OVN`1^!=>!dpnqbsf`sftvmu`ofr`1`t\SFNBJOEFS`1!.!2;1^!">!|SFNBJOEFS`1|2(c1~~<!!!!!!!!!!dpnqbsf`sftvmu`2`t\MVU5`OVN`1^!=>!)dpnqbsf`sftvmu`1`t\SFNBJOEFS`1!.!2;1^!>>!|SFNBJOEFS`1|2(c2~~*<!!!!!!!!!!foe

!!!!!!!foe!!!foe!fmtf!cfhjo;s`2`t`3!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU5`OVN`1^!=>!1<

!dpnqbsf`sftvmu`2`t\MVU5`OVN`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU5`OVN`1^!=>!dpnqbsf`sftvmu`ofr`1`t\MVU5`OVN`1+8,SFNBJOEFS`1.2;MVU5`OVN`1+8^!">!|SFNBJOEFS`1|2(c1~~<!!

!dpnqbsf`sftvmu`2`t\MVU5`OVN`1^!=>!)dpnqbsf`sftvmu`1`t\MVU5`OVN`1+8,SFNBJOEFS`1.2;MVU5`OVN`1+8^!>>!|SFNBJOEFS`1|2(c2~~*<!

!foe!!!!!!foe!!!foefoefoehfofsbufhfowbs!mvu5`dou`2<hfofsbufjg)MVU5`OVN`2!">!1*!cfhjo;s`3`t`1!jg)SFNBJOEFS`2!>>!1*cfhjo!!!!!gps!)mvu5`dou`2!>!1<mvu5`dou`2!=>!MVU5`OVN`2<mvu5`dou`2!>!mvu5`dou`2,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu5`dou`2^!=>!1<

!dpnqbsf`sftvmu`3`t\mvu5`dou`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu5`dou`2^!=>!dpnqbsf`sftvmu`ofr`2`t\mvu5`dou`2+8,7;mvu5`dou`2+8^!">!8(i1<!!!!!!!!!!dpnqbsf`sftvmu`3`t\mvu5`dou`2^!=>!)dpnqbsf`sftvmu`2`t\mvu5`dou`2+8,7;mvu5`dou`2+8^!>>!8(i8g*<!!!!!!!!!!!foe

!!!!!!!foe!!!foe!!foe!fmtf!cfhjo!!!gps!)mvu5`dou`2!>!1<mvu5`dou`2!=!MVU5`OVN`2<mvu5`dou`2!>!mvu5`dou`2,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu5`dou`2^!=>!1<

!dpnqbsf`sftvmu`3`t\mvu5`dou`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu5`dou`2^!=>!dpnqbsf`sftvmu`ofr`2`t\mvu5`dou`2+8,7;mvu5`dou`2+8^!">!8(i1<!!!!!!!!!!dpnqbsf`sftvmu`3`t\mvu5`dou`2^!=>!)dpnqbsf`sftvmu`2`t\mvu5`dou`2+8,7;mvu5`dou`2+8^!>>!8(i8g*<!!!!!!!!!!foe

!!!!!!!foe!!!foe!foefoefoehfofsbufhfofsbufjg)SFNBJOEFS`2!">1!*!cfhjo;s`3`t`2!!!jg)MVU5`OVN`2!>>!1*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU5`OVN`2^!=>!1<

!dpnqbsf`sftvmu`3`t\MVU5`OVN`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU5`OVN`2^!=>!dpnqbsf`sftvmu`ofr`2`t\SFNBJOEFS`2!.!2;1^!">!|SFNBJOEFS`2|2(c1~~<!!!!!!!!!dpnqbsf`sftvmu`3`t\MVU5`OVN`2^!=>!)dpnqbsf`sftvmu`2`t\SFNBJOEFS`2!.!2;1^!>>!|SFNBJOEFS`2|2(c2~~*<!!!!!!!!!foe

!!!!!!!foe!!!foe!fmtf!cfhjo;s`3`t`3!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU5`OVN`2^!=>!1<

!dpnqbsf`sftvmu`3`t\MVU5`OVN`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU5`OVN`2^!=>!dpnqbsf`sftvmu`ofr`2`t\MVU5`OVN`2+8,SFNBJOEFS`2.2;MVU5`OVN`2+8^!">!|SFNBJOEFS`2|2(c1~~<!!!!!!!!!!dpnqbsf`sftvmu`3`t\MVU5`OVN`2^!=>!)dpnqbsf`sftvmu`2`t\MVU5`OVN`2+8,SFNBJOEFS`2.2;MVU5`OVN`2+8^!>>!|SFNBJOEFS`2|2(c2~~*<!!!!!!!!!foe

!!!!!!!foe!!!foefoefoehfofsbufhfowbs!mvu5`dou`3<hfofsbufjg)SFNBJOEFS`2!>>1!*!cfhjo;s`3`t`4!!!jg)MVU5`OVN`2!>>!1*!cfhjo!!!gps!)mvu5`dou`3!>!1<mvu5`dou`3!=>!MVU5`OVN`2<mvu5`dou`3!>!mvu5`dou`3,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU5`OVN`2^!=>!1<

!dpnqbsf`sftvmu`3`t\MVU5`OVN`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU5`OVN`2^!=>!dpnqbsf`sftvmu`ofr`2`t\mvu5`dou`3+8,7;mvu5`dou`3+8^!">!8(i1<!!!!!!!!!dpnqbsf`sftvmu`3`t\MVU5`OVN`2^!=>!)dpnqbsf`sftvmu`2`t\mvu5`dou`3+8,7;mvu5`dou`3+8^!>>!8(i8g*<!!!!!!!!!foe

!!!!!!!foe
foe!!!foe!foefoehfofsbufhfofsbufjg)MVU5`OVN`2!>>!1*!cfhjo;s`t`1!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!jg)sftfu*cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!1<
!!dpnqbsf`sftvmu!!!!!=>!1<!!!!!!foe!!!fmtf!cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!dpnqbsf`sftvmu`ofr`3`t\1^<
!!dpnqbsf`sftvmu!!!!!=>!dpnqbsf`sftvmu`3`t\1^<
!!foe!!!foefoe!fmtf!cfhjo;s`t`2!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!jg)sftfu*cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!1<
!!dpnqbsf`sftvmu!!!!!=>!1<
!!foe!!!fmtf!cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!dpnqbsf`sftvmu`ofr`3`t\2^!}!dpnqbsf`sftvmu`ofr`3`t\1^<!!!!!!dpnqbsf`sftvmu!=>!dpnqbsf`sftvmu`3`t\2^!'!dpnqbsf`sftvmu`3`t\1^<!!!!!!foe
!!!!!foefoefoehfofsbuf!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!jg)sftfu*!!!!!!usjh`pvu!=>!1<!!!fmtf!jg)tfm`su*!!!!!!usjh`pvu!=>!2<!!!!fmtf!jg))tfm`ofr!'!dpnqbsf`sftvmu`ofr*!}})tfm`fr!'!dpnqbsf`sftvmu*!}})tfm`sjtf!'!dpnqbsf`sjtf*!}}!)tfm`gbmm!'!dpnqbsf`gbmm**!!!!!!usjh`pvu!=>!2<!!!!!fmtf!!!!!!usjh`pvu!=>!usjh`pvu<!!!!foefoenpevmfnpevmf!usjhhfs`d2)!!!!sfg`dml-!!!!sftfu-!!!!ebub`jo-!!!!usjhhfs`tfu-
dusm-!!!!usjh`pvu*<qbsbnfufs!EBUB`XJEUI!!!>!271<!!!!!!!!!!!!!!!!qbsbnfufs!SFNBJOEFS`1!!>!EBUB`XJEUI!&!22<qbsbnfufs!MVU7`OVN`1!!!>!)EBUB`XJEUI!.!SFNBJOEFS`1*!0!22<qbsbnfufs!SFNBJOEFS`2!!>!)MVU7`OVN`1!,!))SFNBJOEFS`1!>>!1*!@!1!;!2**!&!22<qbsbnfufs!MVU7`OVN`2!!!>!))MVU7`OVN`1!=!22*!}}!))MVU7`OVN`1!>>!22*!''!)SFNBJOEFS`1!>>!1***!@!1!;!2<joqvu!sfg`dml<joqvu!sftfu<joqvu!\EBUB`XJEUI.2;1^!ebub`jo<joqvu!\3+EBUB`XJEUI.2;1^!usjhhfs`tfu<joqvu!\4;1^!dusm<!pvuqvu!usjh`pvu<xjsf!!\EBUB`XJEUI.2;1^!dpnqbsf`sftvmu`1-!dpnqbsf`sftvmu`ofr`1<xjsf!!!tfm`fr-!tfm`ofr-!tfm`sjtf-!tfm`gbmm-!tfm`su<!xjsf!!\EBUB`XJEUI!.2;1^!dpnqbsf`ebub<sfh!!!\EBUB`XJEUI.2;1^!dpnqbsf`sftvmu`1`t-!dpnqbsf`sftvmu`ofr`1`t<sfh!!!\MVU7`OVN`1;1^!!!dpnqbsf`sftvmu`2`t-!dpnqbsf`sftvmu`ofr`2`t<sfh!!!\MVU7`OVN`2;1^!!!dpnqbsf`sftvmu`3`t-!dpnqbsf`sftvmu`ofr`3`t<sfh!!!!!!!!!!!!!!!!!!!!dpnqbsf`sftvmu-!dpnqbsf`sftvmu`ofr<sfh!!!!!!!!!!!!!!!!!!!!dpnqbsf`sjtf`s-!dpnqbsf`sjtf-!dpnqbsf`gbmm`s-!dpnqbsf`gbmm<sfh!!!\EBUB`XJEUI.2;1^!ebub`jo`s!<!sfh!!!!!!!!!!!!!!!!!!!!ebub`jo`s`e<sfh!!!\2;1^!!!!!!!!!!!!ebub`gps`fehf`s-!ebub`gps`fehf`g<sfh!!!\EBUB`XJEUI!.2;!1^dpnqbsf`ebub`s-dpnqbsf`ebub`g<sfh!!!dpnqbsf`ebub`jou`s-!dpnqbsf`ebub`jou`g-dpnqbsf`ebub`jou`s`e-dpnqbsf`ebub`jou`g`e<sfh!!!usjh`pvu<!bttjho!tfm`fr!!!>!dusm!>>!5(c1121<!bttjho!tfm`ofr!!>!dusm!>>!5(c1111<!bttjho!tfm`sjtf!>!dusm!>>!5(c1211<!bttjho!tfm`gbmm!>!dusm!>>!5(c2111<!bttjho!tfm`su!!!>!dusm\1^<hfowbs!usjhhfs`j<hfofsbuf!gps!)usjhhfs`j!>!1<!usjhhfs`j!=!EBUB`XJEUI<!usjhhfs`j!>!usjhhfs`j!,2*!cfhjo!!!!!bttjho!dpnqbsf`sftvmu`ofr`1\usjhhfs`j^!>!usjhhfs`tfu\3+usjhhfs`j^!@!2(c1!;!)ebub`jo\usjhhfs`j^!">!usjhhfs`tfu\3+usjhhfs`j,2^*<
!bttjho!dpnqbsf`sftvmu`1\usjhhfs`j^!!!!!>!usjhhfs`tfu\3+usjhhfs`j^!@!2(c2!;!)ebub`jo\usjhhfs`j^!>>!usjhhfs`tfu\3+usjhhfs`j,2^*<
!bttjho!dpnqbsf`ebub\usjhhfs`j^!!!!!!!!!>!ebub`jo\usjhhfs`j^!'!usjhhfs`tfu\3+usjhhfs`j^<foefoehfofsbufbmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`ebub`s!=>!2<fmtf!!!!dpnqbsf`ebub`s!=>!dpnqbsf`ebub<!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*cfhjo!!!dpnqbsf`ebub`jou`s!!!!=>!2<!!!dpnqbsf`ebub`jou`s`e!!=>!2<!!!foefmtf!cfhjo!!!dpnqbsf`ebub`jou`s!!!=>!}dpnqbsf`ebub`s<!!!dpnqbsf`ebub`jou`s`e!=>!!dpnqbsf`ebub`jou`s<!!!foe!!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!ebub`gps`fehf`s!=>!3(c11<fmtf!!!!ebub`gps`fehf`s!=>!|dpnqbsf`ebub`jou`s`e-dpnqbsf`ebub`jou`s~<!!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`sjtf!=>!1<!fmtf!jg)ebub`gps`fehf`s!>>!3(c12*!!!dpnqbsf`sjtf!=>!2<!fmtf!!!dpnqbsf`sjtf!=>!1<!!!foe!bmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`ebub`g!=>!1<fmtf!!!!dpnqbsf`ebub`g!=>!dpnqbsf`ebub<foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*cfhjo!!!dpnqbsf`ebub`jou`g!!!!=>!1<!!!dpnqbsf`ebub`jou`g`e!!=>!1<!!!foefmtf!cfhjo!!!dpnqbsf`ebub`jou`g!!!=>!}dpnqbsf`ebub`g<!!!dpnqbsf`ebub`jou`g`e!=>!!dpnqbsf`ebub`jou`g<!!!foe!!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!ebub`gps`fehf`g!=>!3(c11<fmtf!!!!ebub`gps`fehf`g!=>!|dpnqbsf`ebub`jou`g`e-dpnqbsf`ebub`jou`g~<!!foebmxbzt!A)qptfehf!sfg`dml*!cfhjojg)sftfu*!!!dpnqbsf`gbmm!=>!1<!fmtf!jg)ebub`gps`fehf`g!>>!3(c21*!!!dpnqbsf`gbmm!=>!2<fmtf!!!dpnqbsf`gbmm!=>!1<!!!!!foe!hfofsbuf!bmxbzt!A)qptfehf!sfg`dml*!cfhjo;s`1`tjg)sftfu*cfhjo!!!dpnqbsf`sftvmu`ofr`1`t!=>!1<!!!dpnqbsf`sftvmu`1`t!!!!!=>!1<!!!foefmtf!cfhjo!!!dpnqbsf`sftvmu`ofr`1`t!=>!dpnqbsf`sftvmu`ofr`1<!!!!!dpnqbsf`sftvmu`1`t!!!!!=>!dpnqbsf`sftvmu`1<!!!foefoe!foehfofsbufhfowbs!mvu7`dou`1<hfofsbufjg)MVU7`OVN`1!">!1*!cfhjo;s`2`t`1!!!gps!)mvu7`dou`1!>!1<mvu7`dou`1!=!MVU7`OVN`1<mvu7`dou`1!>!mvu7`dou`1,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\mvu7`dou`1^!=>!1<

!dpnqbsf`sftvmu`2`t\mvu7`dou`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\mvu7`dou`1^!=>!dpnqbsf`sftvmu`ofr`1`t\mvu7`dou`1+22,21;mvu7`dou`1+22^!">!22(i1<!!

!dpnqbsf`sftvmu`2`t\mvu7`dou`1^!=>!)dpnqbsf`sftvmu`1`t\mvu7`dou`1+22,21;mvu7`dou`1+22^!>>!22(i8gg*<!

!foe!!!!!!foe!!!foefoefoehfofsbufhfofsbufjg)SFNBJOEFS`1!>>!1*!cfhjo;s`2`t`1`2!!!jg)MVU7`OVN`1!">!1*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU7`OVN`1^!=>!1<

!dpnqbsf`sftvmu`2`t\MVU7`OVN`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU7`OVN`1^!=>!1<!!

!dpnqbsf`sftvmu`2`t\MVU7`OVN`1^!!!!!=>!1<!!

!foe!!!!!!foe!!!foe!!foefoehfofsbufhfofsbufjg)SFNBJOEFS`1!">1!*!cfhjo;s`2`t`2!!!jg)MVU7`OVN`1!>>!1*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU7`OVN`1^!=>!1<

!dpnqbsf`sftvmu`2`t\MVU7`OVN`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU7`OVN`1^!=>!dpnqbsf`sftvmu`ofr`1`t\SFNBJOEFS`1!.!2;1^!">!|SFNBJOEFS`1|2(c1~~<!!!!!!!!!!dpnqbsf`sftvmu`2`t\MVU7`OVN`1^!=>!)dpnqbsf`sftvmu`1`t\SFNBJOEFS`1!.!2;1^!>>!|SFNBJOEFS`1|2(c2~~*<!!!!!!!!!!foe

!!!!!!!foe!!!foe!fmtf!cfhjo;s`2`t`3!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU7`OVN`1^!=>!1<

!dpnqbsf`sftvmu`2`t\MVU7`OVN`1^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`2`t\MVU7`OVN`1^!=>!dpnqbsf`sftvmu`ofr`1`t\MVU7`OVN`1+22,SFNBJOEFS`1.2;MVU7`OVN`1+22^!">!|SFNBJOEFS`1|2(c1~~<!!

!dpnqbsf`sftvmu`2`t\MVU7`OVN`1^!=>!)dpnqbsf`sftvmu`1`t\MVU7`OVN`1+22,SFNBJOEFS`1.2;MVU7`OVN`1+22^!>>!|SFNBJOEFS`1|2(c2~~*<!

!foe!!!!!!foe!!!foefoefoehfofsbufhfowbs!mvu7`dou`2<hfofsbufjg)MVU7`OVN`2!">!1*!cfhjo;s`3`t`1!jg)SFNBJOEFS`2!>>!1*cfhjo!!!!!gps!)mvu7`dou`2!>!1<mvu7`dou`2!=>!MVU7`OVN`2<mvu7`dou`2!>!mvu7`dou`2,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu7`dou`2^!=>!1<

!dpnqbsf`sftvmu`3`t\mvu7`dou`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu7`dou`2^!=>!dpnqbsf`sftvmu`ofr`2`t\mvu7`dou`2+22,21;mvu7`dou`2+22^!">!22(i1<!!!!!!!!!!dpnqbsf`sftvmu`3`t\mvu7`dou`2^!=>!)dpnqbsf`sftvmu`2`t\mvu7`dou`2+22,21;mvu7`dou`2+22^!>>!22(i8gg*<!!!!!!!!!!!foe

!!!!!!!foe!!!foe!!foe!fmtf!cfhjo!!!gps!)mvu7`dou`2!>!1<mvu7`dou`2!=!MVU7`OVN`2<mvu7`dou`2!>!mvu7`dou`2,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu7`dou`2^!=>!1<

!dpnqbsf`sftvmu`3`t\mvu7`dou`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\mvu7`dou`2^!=>!dpnqbsf`sftvmu`ofr`2`t\mvu7`dou`2+22,21;mvu7`dou`2+22^!">!22(i1<!!!!!!!!!!dpnqbsf`sftvmu`3`t\mvu7`dou`2^!=>!)dpnqbsf`sftvmu`2`t\mvu7`dou`2+22,21;mvu7`dou`2+22^!>>!22(i8gg*<!!!!!!!!!!foe

!!!!!!!foe!!!foe!foefoefoehfofsbufhfofsbufjg)SFNBJOEFS`2!">1!*!cfhjo;s`3`t`2!!!jg)MVU7`OVN`2!>>!1*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU7`OVN`2^!=>!1<

!dpnqbsf`sftvmu`3`t\MVU7`OVN`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU7`OVN`2^!=>!dpnqbsf`sftvmu`ofr`2`t\SFNBJOEFS`2!.!2;1^!">!|SFNBJOEFS`2|2(c1~~<!!!!!!!!!dpnqbsf`sftvmu`3`t\MVU7`OVN`2^!=>!)dpnqbsf`sftvmu`2`t\SFNBJOEFS`2!.!2;1^!>>!|SFNBJOEFS`2|2(c2~~*<!!!!!!!!!foe

!!!!!!!foe!!!foe!fmtf!cfhjo;s`3`t`3!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU7`OVN`2^!=>!1<

!dpnqbsf`sftvmu`3`t\MVU7`OVN`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU7`OVN`2^!=>!dpnqbsf`sftvmu`ofr`2`t\MVU7`OVN`2+22,SFNBJOEFS`2.2;MVU7`OVN`2+22^!">!|SFNBJOEFS`2|2(c1~~<!!!!!!!!!!dpnqbsf`sftvmu`3`t\MVU7`OVN`2^!=>!)dpnqbsf`sftvmu`2`t\MVU7`OVN`2+22,SFNBJOEFS`2.2;MVU7`OVN`2+22^!>>!|SFNBJOEFS`2|2(c2~~*<!!!!!!!!!foe

!!!!!!!foe!!!foefoefoehfofsbufhfowbs!mvu5`dou`3<hfofsbufjg)SFNBJOEFS`2!>>1!*!cfhjo;s`3`t`4!!!jg)MVU7`OVN`2!>>!1*!cfhjo!!!gps!)mvu5`dou`3!>!1<mvu5`dou`3!=>!MVU7`OVN`2<mvu5`dou`3!>!mvu5`dou`3,2*!cfhjo!!!!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!!!!jg)sftfu*cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU7`OVN`2^!=>!1<

!dpnqbsf`sftvmu`3`t\MVU7`OVN`2^!!!!!=>!1<

!foe!!!!!!fmtf!cfhjo!!!!!!!!!dpnqbsf`sftvmu`ofr`3`t\MVU7`OVN`2^!=>!dpnqbsf`sftvmu`ofr`2`t\mvu5`dou`3+22,21;mvu5`dou`3+22^!">!22(i1<!!!!!!!!!dpnqbsf`sftvmu`3`t\MVU7`OVN`2^!=>!)dpnqbsf`sftvmu`2`t\mvu5`dou`3+22,21;mvu5`dou`3+22^!>>!22(i8gg*<!!!!!!!!!foe

!!!!!!!foe
foe!!!foe!foefoehfofsbufhfofsbufjg)MVU7`OVN`2!>>!1*!cfhjo;s`t`1!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!jg)sftfu*cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!1<
!!dpnqbsf`sftvmu!!!!!=>!1<!!!!!!foe!!!fmtf!cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!dpnqbsf`sftvmu`ofr`3`t\1^<
!!dpnqbsf`sftvmu!!!!!=>!dpnqbsf`sftvmu`3`t\1^<
!!foe!!!foefoe!fmtf!cfhjo;s`t`2!!!bmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!jg)sftfu*cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!1<
!!dpnqbsf`sftvmu!!!!!=>!1<
!!foe!!!fmtf!cfhjo!!!!!!dpnqbsf`sftvmu`ofr!=>!dpnqbsf`sftvmu`ofr`3`t\2^!}!dpnqbsf`sftvmu`ofr`3`t\1^<!!!!!!dpnqbsf`sftvmu!=>!dpnqbsf`sftvmu`3`t\2^!'!dpnqbsf`sftvmu`3`t\1^<!!!!!!foe
!!!!!foefoefoehfofsbufbmxbzt!A)qptfehf!sfg`dml*!cfhjo!!!jg)sftfu*!!!!!!usjh`pvu!=>!1<!!!fmtf!jg)tfm`su*!!!!!!usjh`pvu!=>!2<!!!!fmtf!jg))tfm`ofr!'!dpnqbsf`sftvmu`ofr*!}})tfm`fr!'!dpnqbsf`sftvmu*!}})tfm`sjtf!'!dpnqbsf`sjtf*!}}!)tfm`gbmm!'!dpnqbsf`gbmm**!!!!!!usjh`pvu!=>!2<!!!!!fmtf!!!!!!usjh`pvu!=>!usjh`pvu<!!!!foefoenpevmfnpevmf!kubh`sfh`se!)!!!!!!!fo-!!!!!!!!udl-!!!!!!!!vqebuf-!!!!!!!!tijgu-!!!!!!!!uep-!!!!!!!!ejo-!!!!!!!!epvu!!!!!!!*<qbsbnfufs!MFOHUI>22<joqvu!!fo<!joqvu!!udl<!joqvu!!vqebuf<!joqvu!!tijgu<joqvu!!\MFOHUI.2;1^!ejo<pvuqvu!\MFOHUI.2;1^!epvu<pvuqvu!uep<sfh!\MFOHUI.2;1^!ebub`sfh2<sfh!\MFOHUI.2;1^!ebub`sfh3<bmxbzt!A)qptfehf!udl*cfhjojg!)fo*!cfhjo!!!jg!)tijgu*!cfhjo!!!!!!!ebub`sfh2!=>!|ebub`sfh2\MFOHUI.3;1^-!2(c1~<!!!foe!fmtf!cfhjo!!!!!!!ebub`sfh3!=>!ebub`sfh2<!!!!!!!ebub`sfh2!=>!ejo<!!!foefoefoebttjho!epvu!>!ebub`sfh3<bttjho!uep!!>!ebub`sfh2\MFOHUI.2^<foenpevmfnpevmf!kubh`sfh`xs!)!!!fo-!!!!udl-!!!!vqebuf-!!!!tijgu-!!!!uej-!!!!uep-!!!!epvu!!!*<qbsbnfufs!MFOHUI>22<joqvu!!fo<!joqvu!!udl<!joqvu!!vqebuf<!joqvu!!tijgu<joqvu!!uej<pvuqvu!uep<pvuqvu!\MFOHUI.2;1^!epvu<sfh!\MFOHUI.2;1^!ebub`sfh2<sfh!\MFOHUI.2;1^!ebub`sfh3<sfh!!!!!!!!!!!!!!vqebuf`t<bmxbzt!A)qptfehf!udl*cfhjo!!!jg!)fo*!cfhjo!!!!!!jg!)tijgu*!cfhjo!!!!!!!!!!ebub`sfh2!=>!|ebub`sfh2\MFOHUI.3;1^-!uej~<!!!!!!foe!!!foe!fmtf!cfhjo!!!!!!ebub`sfh2!=>!ebub`sfh2<!!!foefoebmxbzt!A)qptfehf!vqebuf*cfhjo!!!ebub`sfh3!=>!ebub`sfh2<foebttjho!epvu!>!ebub`sfh3<bttjho!uep!!>!ebub`sfh2\MFOHUI.2^<foenpevmfnpevmf!efcvh`nfnpsz`is)!!!!dmlx-!!!!dfx-!!!!bx-!!!!ex-!!!!dmls-!!!!dfs-!!!!bs-!!!!rs*<qbsbnfufs!EBUB`XJEUI!!!>!:2<!!!qbsbnfufs!TBNQMF`EFQUI!>!3159<!!qbsbnfufs!BEES`XJEUI!!!>!22<!!qbsbnfufs!EBUB`XJEUI`SFNBJOEFS!>!EBUB`XJEUI!&!:<qbsbnfufs!EBUB`XJEUI`EJWJTJPO!!>!)EBUB`XJEUI.EBUB`XJEUI`SFNBJOEFS*!0!:<qbsbnfufs!FNC`SPX`OVN!!>!)EBUB`XJEUI`SFNBJOEFS!>>!1*!@!EBUB`XJEUI`EJWJTJPO!;)EBUB`XJEUI`EJWJTJPO!,!2*<!!!qbsbnfufs!FNC`DPM`OVN!!>!TBNQMF`EFQUI!0!623<!!!joqvu!!dmlx<joqvu!!dfx<joqvu!!\BEES`XJEUI.2;1^!bx<joqvu!!\EBUB`XJEUI.2;1^!ex<joqvu!!dmls<joqvu!!dfs<joqvu!!\BEES`XJEUI.2;1^!bs<pvuqvu!\EBUB`XJEUI.2;1^!rs<xjsf!!!\FNC`DPM`OVN+FNC`SPX`OVN+:.2;1^!rs`ufnq<xjsf!!!\FNC`DPM`OVN.2;1^!fnc`dfx<hfofsbufjg)BEES`XJEUI!=>!:*!cfhjo!!!!bttjho!fnc`dfx\1^!>!dfx<foe!fmtf!cfhjo!!!bttjho!fnc`dfx\1^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!1**!@!2!;!1<foefoehfofsbufhfowbs!dfx`j<hfofsbufjg)BEES`XJEUI!?!:*!cfhjo!!!gps)dfx`j!>!2<!dfx`j!=!FNC`DPM`OVN<!dfx`j!>!dfx`j!,!2*!cfhjo!!!!!!!!!bttjho!fnc`dfx\dfx`j^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!dfx`j**!@!2!;!1<!!!foefoefoehfofsbufhfowbs!fnc`spx`j<hfowbs!fnc`dpm`j<hfofsbuf!jg)EBUB`XJEUI`EJWJTJPO!">!1*!cfhjo!!!jg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN!.!2<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`is!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!!!!!!!foe!!!!!!foe!fmtf!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`is!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!foe!!!foe!!!foefoehfofsbufhfowbs!fnc`dpm`k<hfofsbufjg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!gps)fnc`dpm`k!>!1<!fnc`dpm`k!=!FNC`DPM`OVN<!fnc`dpm`k!>!fnc`dpm`k!,!2*!cfhjo!!!!!!!!!!fnc`efcvhxbsf`is!fnc`spx`ijhi)!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`k^*-!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!/ex)||):.EBUB`XJEUI`SFNBJOEFS*|2(c1~~-ex\EBUB`XJEUI`EJWJTJPO+:,EBUB`XJEUI`SFNBJOEFS.2;EBUB`XJEUI`EJWJTJPO+:^~*-!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:,9;fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:^*!!!!!!!!!!*<
!foe

!foefoehfofsbufhfofsbufjg)FNC`DPM`OVN!>>!2*!cfhjo!!!bttjho!rs!>!rs`ufnq\FNC`SPX`OVN+:.2;1^<foe!fmtf!jg)FNC`DPM`OVN!>>!3*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!5*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!9*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!27*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^<foefoehfofsbuffoenpevmfnpevmf!fnc`efcvhxbsf`is)!!!!dmlx-!!!!dfx-!!!!bx-!!!!ex-!!!!dmls-!!!!dfs-!!!!bs-!!!!rs*<joqvu!dmlx<joqvu!dfx<joqvu!\9;1^!bx<joqvu!\9;1^!ex<joqvu!dmls<joqvu!dfs<joqvu!\9;1^!bs<pvuqvu!\9;1^!rs<xjsf!\28;1^!rs1<bttjho!rs!>!|rs1\9;1^~<M4`FNC6L!$)!!!!!!!!/npefb`tfm!)5(c2111*-!!!!!!!!/npefc`tfm!)5(c2111*-!!!!!!!!/qpsub`xs`npef!)3(c12*-!!!!!!!!/qpsuc`xs`npef!)3(c12*-!!!!!!!!/qpsub`sfh`pvu!)2(c1*-!!!!!!!!/qpsuc`sfh`pvu!)2(c1*-!!!!!!!!/sftfu`wbmvf`b!):(c111111111*-!!!!!!!!/sftfu`wbmvf`c!):(c111111111*-!!!!!!!!/qpsub`ebub`xjeui!):*-!!!!!!!!/qpsuc`ebub`xjeui!):*-!!!!!!!!/pqfsbujpo`npef!)#tjnqmf`evbm`qpsu#*-!!!!!!!!/joju`gjmf!)##*-!!!!!!!!/qpsub`qsph!)9(c22221111*-!!!!!!!!/qpsuc`qsph!)9(c11112222*-!!!!!!!!/qpsub`df!)2(c2*-!!!!!!!!/qpsub`xf!)2(c1*-!!!!!!!!/qpsuc`df!)2(c2*-!!!!!!!!/qpsuc`xf!)2(c2**v`fnc6l`1!)!!!!!!!!/dmlb!)dmls*-!!!!!!!!/dmlc!)dmlx*-!!!!!!!!/stuob!)2(c2*-!!!!!!!!/stuoc!)2(c2*-!!!!!!!!/dfb!)dfs*-!!!!!!!!/dfc!)dfx*-!!!!!!!!/xfb!)*-!!!!!!!!/xfc!)dfx*-!!!!!!!!/bb!)|bs\9;1^-!4(c1~*-!!!!!!!!/bc!)|bx\9;1^-!4(c1~*-!!!!!!!!/eb!)*-!!!!!!!!/ec!)|ex\9^-!ex\9;1^-!ex\8;1^~*-!!!!!!!!/r!)rs1**<foenpevmfnpevmf!efcvh`nfnpsz`n6)!!!!dmlx-!!!!dfx-!!!!bx-!!!!ex-!!!!dmls-!!!!dfs-!!!!bs-!!!!rs*<qbsbnfufs!EBUB`XJEUI!!!>!:2<!!!qbsbnfufs!TBNQMF`EFQUI!>!3159<!!qbsbnfufs!BEES`XJEUI!!!>!22<!!qbsbnfufs!EBUB`XJEUI`SFNBJOEFS!>!EBUB`XJEUI!&!:<qbsbnfufs!EBUB`XJEUI`EJWJTJPO!!>!)EBUB`XJEUI.EBUB`XJEUI`SFNBJOEFS*!0!:<qbsbnfufs!FNC`SPX`OVN!!>!)EBUB`XJEUI`SFNBJOEFS!>>!1*!@!EBUB`XJEUI`EJWJTJPO!;)EBUB`XJEUI`EJWJTJPO!,!2*<!!!qbsbnfufs!FNC`DPM`OVN!!>!TBNQMF`EFQUI!0!623<!!!joqvu!!dmlx<joqvu!!dfx<joqvu!!\BEES`XJEUI.2;1^!bx<joqvu!!\EBUB`XJEUI.2;1^!ex<joqvu!!dmls<joqvu!!dfs<joqvu!!\BEES`XJEUI.2;1^!bs<pvuqvu!\EBUB`XJEUI.2;1^!rs<xjsf!!!\FNC`DPM`OVN+FNC`SPX`OVN+:.2;1^!rs`ufnq<xjsf!!!\FNC`DPM`OVN.2;1^!fnc`dfx<hfofsbufjg)BEES`XJEUI!=>!:*!cfhjo!!!!bttjho!fnc`dfx\1^!>!dfx<foe!fmtf!cfhjo!!!bttjho!fnc`dfx\1^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!1**!@!2!;!1<foefoehfofsbufhfowbs!dfx`j<hfofsbufjg)BEES`XJEUI!?!:*!cfhjo!!!gps)dfx`j!>!2<!dfx`j!=!FNC`DPM`OVN<!dfx`j!>!dfx`j!,!2*!cfhjo!!!!!!!!!bttjho!fnc`dfx\dfx`j^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!dfx`j**!@!2!;!1<!!!foefoefoehfofsbufhfowbs!fnc`spx`j<hfowbs!fnc`dpm`j<hfofsbuf!jg)EBUB`XJEUI`EJWJTJPO!">!1*!cfhjo!!!jg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN!.!2<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`n6!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!!!!!!!foe!!!foe!fmtf!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`n6!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!!!!!!!foe!!!foe!!!foefoehfofsbufhfowbs!fnc`dpm`k<hfofsbufjg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!gps)fnc`dpm`k!>!1<!fnc`dpm`k!=!FNC`DPM`OVN<!fnc`dpm`k!>!fnc`dpm`k!,!2*!cfhjo!!!!!!!!!!fnc`efcvhxbsf`n6!fnc`spx`ijhi)!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`k^*-!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!/ex)||):.EBUB`XJEUI`SFNBJOEFS*|2(c1~~-ex\EBUB`XJEUI`EJWJTJPO+:,EBUB`XJEUI`SFNBJOEFS.2;EBUB`XJEUI`EJWJTJPO+:^~*-!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:,9;fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:^*!!!!!!!!!!*<
!foe

!foefoehfofsbufhfofsbufjg)FNC`DPM`OVN!>>!2*!cfhjo!!!bttjho!rs!>!rs`ufnq\FNC`SPX`OVN+:.2;1^<foe!fmtf!jg)FNC`DPM`OVN!>>!3*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!5*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!9*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!27*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!43*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!26*!@!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!27*!@!rs`ufnq\28+FNC`SPX`OVN+:.2;27+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!28*!@!rs`ufnq\29+FNC`SPX`OVN+:.2;28+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!29*!@!rs`ufnq\2:+FNC`SPX`OVN+:.2;29+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2:*!@!rs`ufnq\31+FNC`SPX`OVN+:.2;2:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!31*!@!rs`ufnq\32+FNC`SPX`OVN+:.2;31+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!32*!@!rs`ufnq\33+FNC`SPX`OVN+:.2;32+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!33*!@!rs`ufnq\34+FNC`SPX`OVN+:.2;33+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!34*!@!rs`ufnq\35+FNC`SPX`OVN+:.2;34+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!35*!@!rs`ufnq\36+FNC`SPX`OVN+:.2;35+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!36*!@!rs`ufnq\37+FNC`SPX`OVN+:.2;36+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!37*!@!rs`ufnq\38+FNC`SPX`OVN+:.2;37+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!38*!@!rs`ufnq\39+FNC`SPX`OVN+:.2;38+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!39*!@!rs`ufnq\3:+FNC`SPX`OVN+:.2;39+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3:*!@!rs`ufnq\41+FNC`SPX`OVN+:.2;3:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!41*!@!rs`ufnq\42+FNC`SPX`OVN+:.2;41+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\43+FNC`SPX`OVN+:.2;42+FNC`SPX`OVN+:^<foefoehfofsbuffoenpevmfnpevmf!fnc`efcvhxbsf`n6)!!!!dmlx-!!!!dfx-!!!!bx-!!!!ex-!!!!dmls-!!!!dfs-!!!!bs-!!!!rs*<joqvu!dmlx<joqvu!dfx<joqvu!\9;1^!bx<joqvu!\9;1^!ex<joqvu!dmls<joqvu!dfs<joqvu!\9;1^!bs<pvuqvu!\9;1^!rs<xjsf!\28;1^!rs1<bttjho!rs!>!|rs1\9;1^~<FNC6L!$)!!!!!!!!/npefb`tfm!)#623y:#*-!!!!!!!!/npefc`tfm!)#623y:#*-!!!!!!!!/qpsub`xs`uispvhi!)#gbmtf#*-!!!!!!!!/qpsuc`xs`uispvhi!)#gbmtf#*-!!!!!!!!/qpsub`ebub`xjeui!):*-!!!!!!!!/qpsuc`ebub`xjeui!):*-!!!!!!!!/pqfsbujpo`npef!)#tjnqmf`evbm`qpsu#*-!!!!!!!!/joju`gjmf!)##*-!!!!!!!!/qpsub`qsph!)9(c22221111*-!!!!!!!!/qpsuc`qsph!)9(c11112222**v`fnc6l`1!)!!!!!!!!/dmlb!)dmls*-!!!!!!!!/dmlc!)dmlx*-!!!!!!!!/dfb!)dfs*-!!!!!!!!/dfc!)dfx*-!!!!!!!!/xfb!)2(c1*-!!!!!!!!/xfc!)dfx*-!!!!!!!!/bb!)|bs\9;1^-!4(c1~*-!!!!!!!!/bc!)|bx\9;1^-!4(c1~*-!!!!!!!!/eb!)*-!!!!!!!!/ec!)|ex\9^-!ex\9;1^-!ex\8;1^~*-!!!!!!!!/r!)rs1*-!!!!!!!!/xr`jo!)*-!!!!!!!!/xr`pvu!)**<foenpevmfnpevmf!efcvh`nfnpsz`n8!!)!!!!dmlx-!!!!dfx-!!!!bx-!!!!ex-!!!!dmls-!!!!dfs-!!!!bs-!!!!rs*<qbsbnfufs!EBUB`XJEUI!!!>!:2<!!!qbsbnfufs!TBNQMF`EFQUI!>!3159<!!qbsbnfufs!BEES`XJEUI!!!>!22<!!qbsbnfufs!EBUB`XJEUI`SFNBJOEFS!>!EBUB`XJEUI!&!:<qbsbnfufs!EBUB`XJEUI`EJWJTJPO!!>!)EBUB`XJEUI.EBUB`XJEUI`SFNBJOEFS*!0!:<qbsbnfufs!FNC`SPX`OVN!!>!)EBUB`XJEUI`SFNBJOEFS!>>!1*!@!EBUB`XJEUI`EJWJTJPO!;)EBUB`XJEUI`EJWJTJPO!,!2*<!!!qbsbnfufs!FNC`DPM`OVN!!>!TBNQMF`EFQUI!0!623<!!!joqvu!!dmlx<joqvu!!dfx<joqvu!!\BEES`XJEUI.2;1^!bx<joqvu!!\EBUB`XJEUI.2;1^!ex<joqvu!!dmls<joqvu!!dfs<joqvu!!\BEES`XJEUI.2;1^!bs<pvuqvu!\EBUB`XJEUI.2;1^!rs<xjsf!!!\FNC`DPM`OVN+FNC`SPX`OVN+:.2;1^!rs`ufnq<xjsf!!!\FNC`DPM`OVN.2;1^!fnc`dfx<hfofsbufjg)BEES`XJEUI!=>!:*!cfhjo!!!!bttjho!fnc`dfx\1^!>!dfx<foe!fmtf!cfhjo!!!bttjho!fnc`dfx\1^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!1**!@!2!;!1<foefoehfofsbufhfowbs!dfx`j<hfofsbufjg)BEES`XJEUI!?!:*!cfhjo!!!gps)dfx`j!>!2<!dfx`j!=!FNC`DPM`OVN<!dfx`j!>!dfx`j!,!2*!cfhjo!!!!!!!!!bttjho!fnc`dfx\dfx`j^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!dfx`j**!@!2!;!1<!!!foefoefoehfofsbufhfowbs!fnc`spx`j<hfowbs!fnc`dpm`j<hfofsbuf!jg)EBUB`XJEUI`EJWJTJPO!">!1*!cfhjo!!!jg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN!.!2<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`n8!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!!!!!!!foe!!!!!!foe!fmtf!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`n8!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!foe!!!foe!!!foefoehfofsbufhfowbs!fnc`dpm`k<hfofsbufjg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!gps)fnc`dpm`k!>!1<!fnc`dpm`k!=!FNC`DPM`OVN<!fnc`dpm`k!>!fnc`dpm`k!,!2*!cfhjo!!!!!!!!!!fnc`efcvhxbsf`n8!fnc`spx`ijhi)!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`k^*-!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!/ex)||):.EBUB`XJEUI`SFNBJOEFS*|2(c1~~-ex\EBUB`XJEUI`EJWJTJPO+:,EBUB`XJEUI`SFNBJOEFS.2;EBUB`XJEUI`EJWJTJPO+:^~*-!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:,9;fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:^*!!!!!!!!!!*<
!foe

!foefoehfofsbufhfofsbufjg)FNC`DPM`OVN!>>!2*!cfhjo!!!bttjho!rs!>!rs`ufnq\FNC`SPX`OVN+:.2;1^<foe!fmtf!jg)FNC`DPM`OVN!>>!3*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!5*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!9*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!27*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!43*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!26*!@!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!27*!@!rs`ufnq\28+FNC`SPX`OVN+:.2;27+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!28*!@!rs`ufnq\29+FNC`SPX`OVN+:.2;28+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!29*!@!rs`ufnq\2:+FNC`SPX`OVN+:.2;29+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2:*!@!rs`ufnq\31+FNC`SPX`OVN+:.2;2:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!31*!@!rs`ufnq\32+FNC`SPX`OVN+:.2;31+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!32*!@!rs`ufnq\33+FNC`SPX`OVN+:.2;32+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!33*!@!rs`ufnq\34+FNC`SPX`OVN+:.2;33+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!34*!@!rs`ufnq\35+FNC`SPX`OVN+:.2;34+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!35*!@!rs`ufnq\36+FNC`SPX`OVN+:.2;35+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!36*!@!rs`ufnq\37+FNC`SPX`OVN+:.2;36+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!37*!@!rs`ufnq\38+FNC`SPX`OVN+:.2;37+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!38*!@!rs`ufnq\39+FNC`SPX`OVN+:.2;38+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!39*!@!rs`ufnq\3:+FNC`SPX`OVN+:.2;39+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3:*!@!rs`ufnq\41+FNC`SPX`OVN+:.2;3:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!41*!@!rs`ufnq\42+FNC`SPX`OVN+:.2;41+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\43+FNC`SPX`OVN+:.2;42+FNC`SPX`OVN+:^<foefoehfofsbuffoenpevmfnpevmf!fnc`efcvhxbsf`n8)!!!!dmlx-!!!!dfx-!!!!bx-!!!!ex-!!!!dmls-!!!!dfs-!!!!bs-!!!!rs*<joqvu!dmlx<joqvu!dfx<joqvu!\9;1^!bx<joqvu!\9;1^!ex<joqvu!dmls<joqvu!dfs<joqvu!\9;1^!bs<pvuqvu!\9;1^!rs<xjsf!\28;1^!rs1<bttjho!rs!>!|rs1\9;1^~<N8T`FNC6L!$)!!!!!!!!/npefb`tfm!)5(c2111*-!!!!!!!!/npefc`tfm!)5(c2111*-!!!!!!!!/qpsub`xs`npef!)3(c12*-!!!!!!!!/qpsuc`xs`npef!)3(c12*-!!!!!!!!/qpsub`sfh`pvu!)2(c2*-!!!!!!!!/qpsuc`sfh`pvu!)2(c2*-!!!!!!!!/sftfu`wbmvf`b!):(c111111111*-!!!!!!!!/sftfu`wbmvf`c!):(c111111111*-!!!!!!!!/qpsub`ebub`xjeui!):*-!!!!!!!!/qpsuc`ebub`xjeui!):*-!!!!!!!!/pqfsbujpo`npef!)#tjnqmf`evbm`qpsu#*-!!!!!!!!/joju`gjmf!)##*-!!!!!!!!/qpsub`qsph!)9(c22221111*-!!!!!!!!/qpsuc`qsph!)9(c11112222**v`fnc6l`1!)!!!!!!!!/dmlb!)dmls*-!!!!!!!!/dmlc!)dmlx*-!!!!!!!!/stuob!)2(c2*-!!!!!!!!/stuoc!)2(c2*-!!!!!!!!/dfb!)dfs*-!!!!!!!!/dfc!)dfx*-!!!!!!!!/xfb!)2(c1*-!!!!!!!!/xfc!)dfx*-!!!!!!!!/bb!)|bs\9;1^-!4(c1~*-!!!!!!!!/bc!)|bx\9;1^-!4(c1~*-!!!!!!!!/eb!)*-!!!!!!!!/ec!)|ex\9^-!ex\9;1^-!ex\8;1^~*-!!!!!!!!/r!)rs1**<foenpevmfnpevmf!efcvh`nfnpsz`d2!!)!!!!dmlx-!!!!dfx-!!!!bx-!!!!ex-!!!!dmls-!!!!dfs-!!!!bs-!!!!rs*<qbsbnfufs!EBUB`XJEUI!!!>!271<qbsbnfufs!TBNQMF`EFQUI!>!3159<!!qbsbnfufs!BEES`XJEUI!!!>!22<!!qbsbnfufs!EBUB`XJEUI`SFNBJOEFS!>!EBUB`XJEUI!&!:<qbsbnfufs!EBUB`XJEUI`EJWJTJPO!!>!)EBUB`XJEUI.EBUB`XJEUI`SFNBJOEFS*!0!:<qbsbnfufs!FNC`SPX`OVN!!>!)EBUB`XJEUI`SFNBJOEFS!>>!1*!@!EBUB`XJEUI`EJWJTJPO!;)EBUB`XJEUI`EJWJTJPO!,!2*<!!!qbsbnfufs!FNC`DPM`OVN!!>!TBNQMF`EFQUI!0!623<!!!joqvu!!dmlx<joqvu!!dfx<joqvu!!\BEES`XJEUI.2;1^!bx<joqvu!!\EBUB`XJEUI.2;1^!ex<joqvu!!dmls<joqvu!!dfs<joqvu!!\BEES`XJEUI.2;1^!bs<pvuqvu!\EBUB`XJEUI.2;1^!rs<xjsf!!!\FNC`DPM`OVN+FNC`SPX`OVN+:.2;1^!rs`ufnq<xjsf!!!\FNC`DPM`OVN.2;1^!fnc`dfx<hfofsbufjg)BEES`XJEUI!=>!:*!cfhjo!!!!bttjho!fnc`dfx\1^!>!dfx<foe!fmtf!cfhjo!!!bttjho!fnc`dfx\1^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!1**!@!2!;!1<foefoehfofsbufhfowbs!dfx`j<hfofsbufjg)BEES`XJEUI!?!:*!cfhjo!!!gps)dfx`j!>!2<!dfx`j!=!FNC`DPM`OVN<!dfx`j!>!dfx`j!,!2*!cfhjo!!!!!!!!!bttjho!fnc`dfx\dfx`j^!>!)dfx!'!)bx\BEES`XJEUI.2;:^!>>!dfx`j**!@!2!;!1<!!!foefoefoehfofsbufhfowbs!fnc`spx`j<hfowbs!fnc`dpm`j<hfofsbuf!jg)EBUB`XJEUI`EJWJTJPO!">!1*!cfhjo!!!jg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN!.!2<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`d2!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!!!!!!!foe!!!!!!foe!fmtf!cfhjo!!!!!!gps)fnc`spx`j!>!1<!fnc`spx`j!=!FNC`SPX`OVN<!fnc`spx`j!>!fnc`spx`j!,!2*!cfhjo!!!!!!!!!!!!gps)fnc`dpm`j!>!1<!fnc`dpm`j!=!FNC`DPM`OVN<!fnc`dpm`j!>!fnc`dpm`j!,!2*!cfhjo!!!!!!!!!!!!!!!!fnc`efcvhxbsf`d2!fnc`spx`mpx)!!!!!!!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`j^*-!!!!!!!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!!!!!!!/ex)ex\fnc`spx`j+:,9;fnc`spx`j+:^*-!!!!!!!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:,9;fnc`dpm`j+FNC`SPX`OVN+:,fnc`spx`j+:^*!!!!!!!!!!!!!!!!*<!!!!!!!!!foe!!!!!!!foe!!!foe!!!foefoehfofsbufhfowbs!fnc`dpm`k<hfofsbufjg)EBUB`XJEUI`SFNBJOEFS!">1!*!cfhjo!!!!gps)fnc`dpm`k!>!1<!fnc`dpm`k!=!FNC`DPM`OVN<!fnc`dpm`k!>!fnc`dpm`k!,!2*!cfhjo!!!!!!!!!!fnc`efcvhxbsf`d2!fnc`spx`ijhi)!!!!!!!!!!/dmlx)dmlx*-!!!!!!!!!!/dfx)fnc`dfx\fnc`dpm`k^*-!!!!!!!!!!/bx)bx\9;1^*-!!!!!!!!!!/ex)||):.EBUB`XJEUI`SFNBJOEFS*|2(c1~~-ex\EBUB`XJEUI`EJWJTJPO+:,EBUB`XJEUI`SFNBJOEFS.2;EBUB`XJEUI`EJWJTJPO+:^~*-!!!!!!!!!!/dmls)dmls*-!!!!!!!!!!/dfs)2(c2*-!!!!!!!!!!/bs)bs\9;1^*-!!!!!!!!!!/rs)rs`ufnq\fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:,9;fnc`dpm`k+FNC`SPX`OVN+:,EBUB`XJEUI`EJWJTJPO+:^*!!!!!!!!!!*<
!foe

!foefoehfofsbufhfofsbufjg)FNC`DPM`OVN!>>!2*!cfhjo!!!bttjho!rs!>!rs`ufnq\FNC`SPX`OVN+:.2;1^<foe!fmtf!jg)FNC`DPM`OVN!>>!3*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!5*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^<foe!fmtf!jg)FNC`DPM`OVN!>>!9*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!27*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!43*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!26*!@!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!27*!@!rs`ufnq\28+FNC`SPX`OVN+:.2;27+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!28*!@!rs`ufnq\29+FNC`SPX`OVN+:.2;28+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!29*!@!rs`ufnq\2:+FNC`SPX`OVN+:.2;29+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2:*!@!rs`ufnq\31+FNC`SPX`OVN+:.2;2:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!31*!@!rs`ufnq\32+FNC`SPX`OVN+:.2;31+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!32*!@!rs`ufnq\33+FNC`SPX`OVN+:.2;32+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!33*!@!rs`ufnq\34+FNC`SPX`OVN+:.2;33+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!34*!@!rs`ufnq\35+FNC`SPX`OVN+:.2;34+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!35*!@!rs`ufnq\36+FNC`SPX`OVN+:.2;35+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!36*!@!rs`ufnq\37+FNC`SPX`OVN+:.2;36+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!37*!@!rs`ufnq\38+FNC`SPX`OVN+:.2;37+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!38*!@!rs`ufnq\39+FNC`SPX`OVN+:.2;38+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!39*!@!rs`ufnq\3:+FNC`SPX`OVN+:.2;39+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3:*!@!rs`ufnq\41+FNC`SPX`OVN+:.2;3:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!41*!@!rs`ufnq\42+FNC`SPX`OVN+:.2;41+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!rs`ufnq\43+FNC`SPX`OVN+:.2;42+FNC`SPX`OVN+:^<foefmtf!jg)FNC`DPM`OVN!>>!75*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh-!bs`sfh`s<!!!xjsf!\EBUB`XJEUI.2;1^!rs`1-!rs`2-!rs`3-rs`4-rs`5-rs`6<!!!sfh!!\EBUB`XJEUI.2;1^!rs`1`s-!rs`2`s-!rs`3`s-rs`4`s-rs`5`s-rs`6`s<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!bttjho!rs`1!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bttjho!rs`2!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!26*!@!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!27*!@!rs`ufnq\28+FNC`SPX`OVN+:.2;27+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!28*!@!rs`ufnq\29+FNC`SPX`OVN+:.2;28+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!29*!@!rs`ufnq\2:+FNC`SPX`OVN+:.2;29+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2:*!@!rs`ufnq\31+FNC`SPX`OVN+:.2;2:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!31*!@!rs`ufnq\32+FNC`SPX`OVN+:.2;31+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!32*!@!rs`ufnq\33+FNC`SPX`OVN+:.2;32+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!33*!@!rs`ufnq\34+FNC`SPX`OVN+:.2;33+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!34*!@!rs`ufnq\35+FNC`SPX`OVN+:.2;34+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bttjho!rs`3!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!35*!@!rs`ufnq\36+FNC`SPX`OVN+:.2;35+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!36*!@!rs`ufnq\37+FNC`SPX`OVN+:.2;36+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!37*!@!rs`ufnq\38+FNC`SPX`OVN+:.2;37+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!38*!@!rs`ufnq\39+FNC`SPX`OVN+:.2;38+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!39*!@!rs`ufnq\3:+FNC`SPX`OVN+:.2;39+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3:*!@!rs`ufnq\41+FNC`SPX`OVN+:.2;3:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!41*!@!rs`ufnq\42+FNC`SPX`OVN+:.2;41+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!42*!@!rs`ufnq\43+FNC`SPX`OVN+:.2;42+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!43*!@!rs`ufnq\44+FNC`SPX`OVN+:.2;43+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!44*!@!rs`ufnq\45+FNC`SPX`OVN+:.2;44+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!45*!@!rs`ufnq\46+FNC`SPX`OVN+:.2;45+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!46*!@!rs`ufnq\47+FNC`SPX`OVN+:.2;46+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bttjho!rs`4!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!47*!@!rs`ufnq\48+FNC`SPX`OVN+:.2;47+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!48*!@!rs`ufnq\49+FNC`SPX`OVN+:.2;48+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!49*!@!rs`ufnq\4:+FNC`SPX`OVN+:.2;49+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4:*!@!rs`ufnq\51+FNC`SPX`OVN+:.2;4:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!51*!@!rs`ufnq\52+FNC`SPX`OVN+:.2;51+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!52*!@!rs`ufnq\53+FNC`SPX`OVN+:.2;52+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!53*!@!rs`ufnq\54+FNC`SPX`OVN+:.2;53+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!54*!@!rs`ufnq\55+FNC`SPX`OVN+:.2;54+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!55*!@!rs`ufnq\56+FNC`SPX`OVN+:.2;55+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!56*!@!rs`ufnq\57+FNC`SPX`OVN+:.2;56+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!57*!@!rs`ufnq\58+FNC`SPX`OVN+:.2;57+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!58*!@!rs`ufnq\59+FNC`SPX`OVN+:.2;58+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bttjho!rs`5!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!59*!@!rs`ufnq\5:+FNC`SPX`OVN+:.2;59+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5:*!@!rs`ufnq\61+FNC`SPX`OVN+:.2;5:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!61*!@!rs`ufnq\62+FNC`SPX`OVN+:.2;61+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!62*!@!rs`ufnq\63+FNC`SPX`OVN+:.2;62+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!63*!@!rs`ufnq\64+FNC`SPX`OVN+:.2;63+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!64*!@!rs`ufnq\65+FNC`SPX`OVN+:.2;64+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!65*!@!rs`ufnq\66+FNC`SPX`OVN+:.2;65+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!66*!@!rs`ufnq\67+FNC`SPX`OVN+:.2;66+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!67*!@!rs`ufnq\68+FNC`SPX`OVN+:.2;67+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!68*!@!rs`ufnq\69+FNC`SPX`OVN+:.2;68+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!69*!@!rs`ufnq\6:+FNC`SPX`OVN+:.2;69+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6:*!@!rs`ufnq\71+FNC`SPX`OVN+:.2;6:+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bttjho!rs`6!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!71*!@!rs`ufnq\72+FNC`SPX`OVN+:.2;71+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!72*!@!rs`ufnq\73+FNC`SPX`OVN+:.2;72+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!73*!@!rs`ufnq\74+FNC`SPX`OVN+:.2;73+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!74*!@!rs`ufnq\75+FNC`SPX`OVN+:.2;74+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bmxbztA)qptfehf!dmls*cfhjo

rs`1`s!=>!rs`1<
rs`2`s!=>!rs`2<
rs`3`s!=>!rs`3<
rs`4`s!=>!rs`4<
rs`5`s!=>!rs`5<
rs`6`s!=>!rs`6<
bs`sfh`s!=>!bs`sfh<foebttjho!rs!>!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!!1!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!22!*!@!rs`1`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!23!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!34!*!@!rs`2`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!35!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!46!*!@!rs`3`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!47!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!58!*!@!rs`4`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!59!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!6:!*!@!rs`5`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!71!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!74!*!@!rs`6`s!;


!!!1<foefmtf!jg)FNC`DPM`OVN!>>!239*!cfhjo!!!sfh!\BEES`XJEUI.21;1^!bs`sfh-!bs`sfh`s<!!!xjsf!\EBUB`XJEUI.2;1^!rs`1-!rs`2-!rs`3-rs`4-rs`5-rs`6<!!!sfh!!\EBUB`XJEUI.2;1^!rs`1`s-!rs`2`s-!rs`3`s-rs`4`s-rs`5`s-rs`6`s<!!!bmxbztA)qptfehf!dmls*cfhjo!!!!!bs`sfh!=>!bs\BEES`XJEUI.2;:^<!!!foe!!!!bttjho!rs`1!>!)bs`sfh\BEES`XJEUI.21;1^!>>!1*!@!rs`ufnq\FNC`SPX`OVN+:.2;1^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2*!@!rs`ufnq\3+FNC`SPX`OVN+:.2;FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3*!@!rs`ufnq\4+FNC`SPX`OVN+:.2;3+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4*!@!rs`ufnq\5+FNC`SPX`OVN+:.2;4+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5*!@!rs`ufnq\6+FNC`SPX`OVN+:.2;5+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6*!@!rs`ufnq\7+FNC`SPX`OVN+:.2;6+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!7*!@!rs`ufnq\8+FNC`SPX`OVN+:.2;7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8*!@!rs`ufnq\9+FNC`SPX`OVN+:.2;8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9*!@!rs`ufnq\:+FNC`SPX`OVN+:.2;9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:*!@!rs`ufnq\21+FNC`SPX`OVN+:.2;:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21*!@!rs`ufnq\22+FNC`SPX`OVN+:.2;21+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22*!@!rs`ufnq\23+FNC`SPX`OVN+:.2;22+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!23*!@!rs`ufnq\24+FNC`SPX`OVN+:.2;23+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!24*!@!rs`ufnq\25+FNC`SPX`OVN+:.2;24+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!25*!@!rs`ufnq\26+FNC`SPX`OVN+:.2;25+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!26*!@!rs`ufnq\27+FNC`SPX`OVN+:.2;26+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!27*!@!rs`ufnq\28+FNC`SPX`OVN+:.2;27+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!28*!@!rs`ufnq\29+FNC`SPX`OVN+:.2;28+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!29*!@!rs`ufnq\2:+FNC`SPX`OVN+:.2;29+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!2:*!@!rs`ufnq\31+FNC`SPX`OVN+:.2;2:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!31*!@!rs`ufnq\32+FNC`SPX`OVN+:.2;31+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!32*!@!rs`ufnq\33+FNC`SPX`OVN+:.2;32+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!33*!@!rs`ufnq\34+FNC`SPX`OVN+:.2;33+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bttjho!rs`2!>!)bs`sfh\BEES`XJEUI.21;1^!>>!34*!@!rs`ufnq\35+FNC`SPX`OVN+:.2;34+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!35*!@!rs`ufnq\36+FNC`SPX`OVN+:.2;35+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!36*!@!rs`ufnq\37+FNC`SPX`OVN+:.2;36+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!37*!@!rs`ufnq\38+FNC`SPX`OVN+:.2;37+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!38*!@!rs`ufnq\39+FNC`SPX`OVN+:.2;38+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!39*!@!rs`ufnq\3:+FNC`SPX`OVN+:.2;39+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!3:*!@!rs`ufnq\41+FNC`SPX`OVN+:.2;3:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!41*!@!rs`ufnq\42+FNC`SPX`OVN+:.2;41+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!42*!@!rs`ufnq\43+FNC`SPX`OVN+:.2;42+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!43*!@!rs`ufnq\44+FNC`SPX`OVN+:.2;43+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!44*!@!rs`ufnq\45+FNC`SPX`OVN+:.2;44+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!45*!@!rs`ufnq\46+FNC`SPX`OVN+:.2;45+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!46*!@!rs`ufnq\47+FNC`SPX`OVN+:.2;46+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!47*!@!rs`ufnq\48+FNC`SPX`OVN+:.2;47+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!48*!@!rs`ufnq\49+FNC`SPX`OVN+:.2;48+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!49*!@!rs`ufnq\4:+FNC`SPX`OVN+:.2;49+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!4:*!@!rs`ufnq\51+FNC`SPX`OVN+:.2;4:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!51*!@!rs`ufnq\52+FNC`SPX`OVN+:.2;51+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!52*!@!rs`ufnq\53+FNC`SPX`OVN+:.2;52+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!53*!@!rs`ufnq\54+FNC`SPX`OVN+:.2;53+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!54*!@!rs`ufnq\55+FNC`SPX`OVN+:.2;54+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!55*!@!rs`ufnq\56+FNC`SPX`OVN+:.2;55+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!56*!@!rs`ufnq\57+FNC`SPX`OVN+:.2;56+FNC`SPX`OVN+:^!;


!!!1<


!!!


!!!bttjho!rs`3!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!57*!@!rs`ufnq\58+FNC`SPX`OVN+:.2;57+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!58*!@!rs`ufnq\59+FNC`SPX`OVN+:.2;58+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!59*!@!rs`ufnq\5:+FNC`SPX`OVN+:.2;59+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!5:*!@!rs`ufnq\61+FNC`SPX`OVN+:.2;5:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!61*!@!rs`ufnq\62+FNC`SPX`OVN+:.2;61+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!62*!@!rs`ufnq\63+FNC`SPX`OVN+:.2;62+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!63*!@!rs`ufnq\64+FNC`SPX`OVN+:.2;63+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!64*!@!rs`ufnq\65+FNC`SPX`OVN+:.2;64+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!65*!@!rs`ufnq\66+FNC`SPX`OVN+:.2;65+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!66*!@!rs`ufnq\67+FNC`SPX`OVN+:.2;66+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!67*!@!rs`ufnq\68+FNC`SPX`OVN+:.2;67+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!68*!@!rs`ufnq\69+FNC`SPX`OVN+:.2;68+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!69*!@!rs`ufnq\6:+FNC`SPX`OVN+:.2;69+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!6:*!@!rs`ufnq\71+FNC`SPX`OVN+:.2;6:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!71*!@!rs`ufnq\72+FNC`SPX`OVN+:.2;71+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!72*!@!rs`ufnq\73+FNC`SPX`OVN+:.2;72+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!73*!@!rs`ufnq\74+FNC`SPX`OVN+:.2;73+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!74*!@!rs`ufnq\75+FNC`SPX`OVN+:.2;74+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!75*!@!rs`ufnq\76+FNC`SPX`OVN+:.2;75+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!76*!@!rs`ufnq\77+FNC`SPX`OVN+:.2;76+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!77*!@!rs`ufnq\78+FNC`SPX`OVN+:.2;77+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!78*!@!rs`ufnq\79+FNC`SPX`OVN+:.2;78+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!79*!@!rs`ufnq\7:+FNC`SPX`OVN+:.2;79+FNC`SPX`OVN+:^!;


!!!1<!!!!!!!!!!!!!!bttjho!rs`4!>!)bs`sfh\BEES`XJEUI.21;1^!>>!7:*!@!rs`ufnq\81+FNC`SPX`OVN+:.2;7:+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!81*!@!rs`ufnq\82+FNC`SPX`OVN+:.2;81+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!82*!@!rs`ufnq\83+FNC`SPX`OVN+:.2;82+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!83*!@!rs`ufnq\84+FNC`SPX`OVN+:.2;83+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!84*!@!rs`ufnq\85+FNC`SPX`OVN+:.2;84+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!85*!@!rs`ufnq\86+FNC`SPX`OVN+:.2;85+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!86*!@!rs`ufnq\87+FNC`SPX`OVN+:.2;86+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!87*!@!rs`ufnq\88+FNC`SPX`OVN+:.2;87+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!88*!@!rs`ufnq\89+FNC`SPX`OVN+:.2;88+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!89*!@!rs`ufnq\8:+FNC`SPX`OVN+:.2;89+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!8:*!@!rs`ufnq\91+FNC`SPX`OVN+:.2;8:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!91*!@!rs`ufnq\92+FNC`SPX`OVN+:.2;91+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!92*!@!rs`ufnq\93+FNC`SPX`OVN+:.2;92+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!93*!@!rs`ufnq\94+FNC`SPX`OVN+:.2;93+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!94*!@!rs`ufnq\95+FNC`SPX`OVN+:.2;94+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!95*!@!rs`ufnq\96+FNC`SPX`OVN+:.2;95+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!96*!@!rs`ufnq\97+FNC`SPX`OVN+:.2;96+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!97*!@!rs`ufnq\98+FNC`SPX`OVN+:.2;97+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!98*!@!rs`ufnq\99+FNC`SPX`OVN+:.2;98+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!99*!@!rs`ufnq\9:+FNC`SPX`OVN+:.2;99+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!9:*!@!rs`ufnq\:1+FNC`SPX`OVN+:.2;9:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:1*!@!rs`ufnq\:2+FNC`SPX`OVN+:.2;:1+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:2*!@!rs`ufnq\:3+FNC`SPX`OVN+:.2;:2+FNC`SPX`OVN+:^!;


!!!1<


!!bttjho!rs`5!>!)bs`sfh\BEES`XJEUI.21;1^!>>!:3*!@!rs`ufnq\:4+FNC`SPX`OVN+:.2;:3+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:4*!@!rs`ufnq\:5+FNC`SPX`OVN+:.2;:4+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:5*!@!rs`ufnq\:6+FNC`SPX`OVN+:.2;:5+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:6*!@!rs`ufnq\:7+FNC`SPX`OVN+:.2;:6+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:7*!@!rs`ufnq\:8+FNC`SPX`OVN+:.2;:7+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:8*!@!rs`ufnq\:9+FNC`SPX`OVN+:.2;:8+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!:9*!@!rs`ufnq\::+FNC`SPX`OVN+:.2;:9+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!::*!@!rs`ufnq\211+FNC`SPX`OVN+:.2;::+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!211*!@!rs`ufnq\212+FNC`SPX`OVN+:.2;211+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!212*!@!rs`ufnq\213+FNC`SPX`OVN+:.2;212+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!213*!@!rs`ufnq\214+FNC`SPX`OVN+:.2;213+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!214*!@!rs`ufnq\215+FNC`SPX`OVN+:.2;214+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!215*!@!rs`ufnq\216+FNC`SPX`OVN+:.2;215+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!216*!@!rs`ufnq\217+FNC`SPX`OVN+:.2;216+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!217*!@!rs`ufnq\218+FNC`SPX`OVN+:.2;217+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!218*!@!rs`ufnq\219+FNC`SPX`OVN+:.2;218+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!219*!@!rs`ufnq\21:+FNC`SPX`OVN+:.2;219+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!21:*!@!rs`ufnq\221+FNC`SPX`OVN+:.2;21:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!221*!@!rs`ufnq\222+FNC`SPX`OVN+:.2;221+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!222*!@!rs`ufnq\223+FNC`SPX`OVN+:.2;222+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!223*!@!rs`ufnq\224+FNC`SPX`OVN+:.2;223+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!224*!@!rs`ufnq\225+FNC`SPX`OVN+:.2;224+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!225*!@!rs`ufnq\226+FNC`SPX`OVN+:.2;225+FNC`SPX`OVN+:^!;


!!!1<


!!bttjho!rs`6!>!!)bs`sfh\BEES`XJEUI.21;1^!>>!226*!@!rs`ufnq\227+FNC`SPX`OVN+:.2;226+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!227*!@!rs`ufnq\228+FNC`SPX`OVN+:.2;227+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!228*!@!rs`ufnq\229+FNC`SPX`OVN+:.2;228+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!229*!@!rs`ufnq\22:+FNC`SPX`OVN+:.2;229+FNC`SPX`OVN+:^!;!!!!!!!!!!!!!!!)bs`sfh\BEES`XJEUI.21;1^!>>!22:*!@!rs`ufnq\231+FNC`SPX`OVN+:.2;22:+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!231*!@!rs`ufnq\232+FNC`SPX`OVN+:.2;231+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!232*!@!rs`ufnq\233+FNC`SPX`OVN+:.2;232+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!233*!@!rs`ufnq\234+FNC`SPX`OVN+:.2;233+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!234*!@!rs`ufnq\235+FNC`SPX`OVN+:.2;234+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!235*!@!rs`ufnq\236+FNC`SPX`OVN+:.2;235+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!236*!@!rs`ufnq\237+FNC`SPX`OVN+:.2;236+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!237*!@!rs`ufnq\238+FNC`SPX`OVN+:.2;237+FNC`SPX`OVN+:^!;


!!!)bs`sfh\BEES`XJEUI.21;1^!>>!238*!@!rs`ufnq\239+FNC`SPX`OVN+:.2;238+FNC`SPX`OVN+:^!;


!!!1<


!!bmxbztA)qptfehf!dmls*cfhjo

rs`1`s!=>!rs`1<
rs`2`s!=>!rs`2<
rs`3`s!=>!rs`3<
rs`4`s!=>!rs`4<
rs`5`s!=>!rs`5<
rs`6`s!=>!rs`6<
bs`sfh`s!=>!bs`sfh<foebttjho!rs!>!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!!1!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!33!*!@!rs`1`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!34!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!56!*!@!rs`2`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!57!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!79!*!@!rs`3`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!7:!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!:2!*!@!rs`4`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!:3!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!225!*!@!rs`5`s!;!!!!!!!!!!!!!!!)bs`sfh`s\BEES`XJEUI.21;1^!?>!226!''!bs`sfh`s\BEES`XJEUI.21;1^!=>!238!*!@!rs`6`s!;


!!!1<


!!foefoehfofsbuffoenpevmfnpevmf!fnc`efcvhxbsf`d2!)dmls-!dmlx-!dfs-!dfx-!bs-!bx-!ex-!rs*<joqvu!dmls<joqvu!dmlx<joqvu!dfs<joqvu!dfx<joqvu!\9;1^!bs<joqvu!\9;1^!bx<joqvu!\9;1^!ex<pvuqvu!\9;1^!rs<xjsf!wdd`ofu<xjsf!hoe`ofu<xjsf!od2<xjsf!od3<xjsf!od4<xjsf!od5<xjsf!od6<xjsf!od7<xjsf!od8<xjsf!od9<xjsf!od:<xjsf!od21<xjsf!od22<xjsf!od23<xjsf!od24<xjsf!od25<xjsf!od26<xjsf!od27<xjsf!od28<xjsf!od29<bttjho!wdd`ofu!>!2<bttjho!hoe`ofu!>!1<FNC6L!$)

/dmlb`jow!)2(c1*-

/dmlc`jow!)2(c1*-

/joju`gjmf!)#opof#*-

/pvusfh`b!)2(c1*-

/pvusfh`c!)2(c1*-

/sbnnpef!)#teq#*-

/xjeui`b!):*-

/xjeui`c!):*-

/xsjufnpef`b!)#xsjuf`gjstu#*-

/xsjufnpef`c!)#xsjuf`gjstu#*
*
fnc`1!)

/epb!)|od2-!od3-!od4-!od5-!od6-!od7-!od8-!od9-!rs\8^-!rs\7^-!rs\6^-!rs\5^-!rs\4^-!rs\3^-!rs\2^-!rs\1^~*-

/epc!)*-

/epqb!)|od:-!rs\9^~*-

/epqc!)*-

/beesb!)|hoe`ofu-!hoe`ofu-!hoe`ofu-!bs\9^-!bs\8^-!bs\7^-!bs\6^-!bs\5^-!bs\4^-!bs\3^-!bs\2^-!bs\1^~*-

/beesc!)|hoe`ofu-!hoe`ofu-!hoe`ofu-!bx\9^-!bx\8^-!bx\7^-!bx\6^-!bx\5^-!bx\4^-!bx\3^-!bx\2^-!bx\1^~*-

/dmlb!)dmls*-

/dmlc!)dmlx*-

/ejb!)*-

/ejc!)|od21-!od22-!od23-!od24-!od25-!od26-!od27-!od28-!ex\8^-!ex\7^-!ex\6^-!ex\5^-!ex\4^-!ex\3^-!ex\2^-!ex\1^~*-

/ejqb!)*-

/ejqc!)|od29-!ex\9^~*-

/dfb!)dfs*-

/dfc!)dfx*-

/sfhdfb!)wdd`ofu*-

/sfhdfc!)*-

/sfhtsb!)wdd`ofu*-

/sfhtsc!)*-

/xfb!)hoe`ofu*-

/xfc!)wdd`ofu*
*<foenpevmf
`pragma protect end_protected
