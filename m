Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77917DCBAF
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 12:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjJaLYA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbjJaLXy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 07:23:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A097A6;
        Tue, 31 Oct 2023 04:23:52 -0700 (PDT)
Date:   Tue, 31 Oct 2023 12:23:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698751430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gfiiLy0semaEmxT1rqyy3HQgthxxpseD/3W/ir6dKLc=;
        b=PVp2+dHvttrIyC/Oc10UTcNDO2FmorXX+VeENMpNHm8LA0ugRNBrBJtTIb40aVMLPTCU9Z
        NwNYCnJzK+sHFye9oS7S6S+a4xV5Pe8KPpN4KLgqyz7QpZeApyZ2jIgbqSSei6z29umDwg
        chHA2N1xdF2VMWsbEhZfyjaDlfKyttZzZUaVJlszwfumabQkkpfXOEerOTi0L0yppEdmAN
        OnzNfUC9MJ5oKLDqwI4wj4sSV8Cwt23ryhnYz9RHSlxzgFNMOpa/QAKse5VgbiysFxkLML
        gNZkSQzd1sZx6IE5BCQeZhI6WH+1Aq1fhirheyhJNAPdN3uwdrFd0QKW51zAKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698751430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gfiiLy0semaEmxT1rqyy3HQgthxxpseD/3W/ir6dKLc=;
        b=tcCBunYR/V8FJAAq3CM6h/gnRzUM3WYd/fAEHwhWPn07YRHwjeDiLq1jA1pCU+ByqLAIsF
        qSPmKEcc7KA9kXDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] Questionable RCU/BH usage in cgw_create_job().
Message-ID: <20231031112349.y0aLoBrz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I stumbled over this piece in cgw_create_job():
|      /* update modifications with disabled softirq & quit */
|      local_bh_disable();
|      memcpy(&gwj->mod, &mod, sizeof(mod));
|      local_bh_enable();
|      return 0;

unfortunately the comment did not provide much enlightenment for me.
Let's look. That memcpy() overwrites struct cf_mod within struct cgw_job
which is under RCU protection. memcpy() and RCU hardly works as a combo.
But why the local_bh_disable()?

Let's look further. The user of this data structure is can_can_gw_rcv().
There is something like:
|                 /* check for checksum updates */
|                 if (gwj->mod.csumfunc.crc8)
|                         (*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8=
);

With optimisation enabled (as in -O2 or so) the compiler will fetch
mod.csumfunc.crc8, do the comparison and if non-NULL use the previously
fetched value and jump there. So one could argue that it is not really
affected by the memcpy() suddenly setting it to NULL. However, adding
any kind of a function in between, say=20
|                 /* check for checksum updates */
|                 if (gwj->mod.csumfunc.crc8) {
|+                        trace_event_crc8_sth(cf)
|                         (*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8=
);
|                 }

will force the compiler to reload mod.csumfunc.crc8. And here is the
possible NULL pointer if overwritten by update in cgw_create_job().

One reload that already happens is the one of mod.modfunc. First at the
top we have:
|         if (gwj->mod.modfunc[0])
|                 nskb =3D skb_copy(skb, GFP_ATOMIC);
|         else
|                 nskb =3D skb_clone(skb, GFP_ATOMIC);

Here mod.modfunc[0] is NULL and skb_clone() is invoked. Later if
mod.modfunc has been set to non-NULL value this piece
|         while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
|                 (*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);

reloads mod.modfunc and may modify the skb assuming that skb_copy() has
been used earlier.

Looking at this makes me think that the local_bh_disable() has been
added to the memcpy() just to ensure that can_can_gw_rcv() won't run
because it is invoked in a BH disabled context. Clever little trick that
is. But this trick is limited to UP environments=E2=80=A6

Am I missing something?

If not, my suggestion would be replacing the bh-off, memcpy part with:
|		old_mod =3D rcu_replace_pointer(gwj->mod, new_mod, true);
|		kfree_rcu_mightsleep(old_mod);

and doing the needed pointer replacement with for struct cgw_job::mod
and RCU annotation.

Sebastian
