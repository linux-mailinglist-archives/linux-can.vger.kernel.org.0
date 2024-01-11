Return-Path: <linux-can+bounces-122-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995EF82AE83
	for <lists+linux-can@lfdr.de>; Thu, 11 Jan 2024 13:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5D51C20A1D
	for <lists+linux-can@lfdr.de>; Thu, 11 Jan 2024 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86F15AC1;
	Thu, 11 Jan 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGEcKeEv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KooY5bOk"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAC15AC0
	for <linux-can@vger.kernel.org>; Thu, 11 Jan 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Jan 2024 13:14:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704975244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4yg9TrYsRIMPvqhNuQuEqDe3ZDGBlws/scU8ENbxbc=;
	b=VGEcKeEvo19bv0i9M1tWTSlMnf2BhlCdAeqTmVpM/0yuIS2TxEruyQPxdRgs4m1VlrMQBH
	bnD6xgxif/aCmsWffC4xQ7ALCUM3eJJWN7CYz9uDoQJlHNxfrHYYx4YGTaEdHmHnnaJ9qB
	ePNcOi5BUiTHJX8cUPM3dvJ1s+DUfpTMa2UekpXjhGu/rqDYc6PRdYw3wsCJq6+Xic0vc0
	jS3hIMVYJmB/L8a7vUVJ0IlL/mNXyvXt5QMpiVfUPjC6tIIbU1gRlrbdroix03+0oGm4Gf
	M7GJJDKhsTwMrC3ZM3przgXeVZGElepacXPWfa8vgl9U3R/0bjwAuNJI8t12Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704975244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4yg9TrYsRIMPvqhNuQuEqDe3ZDGBlws/scU8ENbxbc=;
	b=KooY5bOkgmWowcTOLrd2uqUCAQgcZ8bpjzQqrWsQWpOJvjFTrkK8PB9+rpjVVszBlwnKQM
	W4oTfzxFrn2zKYBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
Message-ID: <20240111121402.xc9rmYfG@linutronix.de>
References: <20231221123703.8170-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231221123703.8170-1-socketcan@hartkopp.net>

On 2023-12-21 13:37:03 [+0100], Oliver Hartkopp wrote:
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -128,11 +128,13 @@ struct cgw_job {
>  	struct hlist_node list;
>  	struct rcu_head rcu;
>  	u32 handled_frames;
>  	u32 dropped_frames;
>  	u32 deleted_frames;
> -	struct cf_mod mod;
> +	struct cf_mod *mod;
> +	struct cf_mod mod1;
> +	struct cf_mod mod2;

I wouldn't put here mod1/2. That cf_mod struct has 736 bytes in my
allmod build so it gains some weight. It also introduces a run-time
problem, more on that later.
Also *mod requires __rcu annotation.=20

> @@ -504,11 +506,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, voi=
d *data)
>  	/* clone the given skb, which has not been done in can_rcv()
>  	 *
>  	 * When there is at least one modification function activated,
>  	 * we need to copy the skb as we want to modify skb->data.
>  	 */
> -	if (gwj->mod.modfunc[0])
> +	if (gwj->mod->modfunc[0])

Almost. You need
	struct cf_mod *mod;
	=E2=80=A6

	rcu_read_lock();
	mod =3D rcu_dereference(gwj->mod);
	if (mod->modfunc[0])
	=E2=80=A6

	rcu_read_unlock();
	/* no longer touching mod but I am leaving can_can_gw_rcv()
	 * anyway */

>  		nskb =3D skb_copy(skb, GFP_ATOMIC);
>  	else
>  		nskb =3D skb_clone(skb, GFP_ATOMIC);
> =20
>  	if (!nskb) {
> @@ -1085,21 +1087,25 @@ static int cgw_create_job(struct sk_buff *skb,  s=
truct nlmsghdr *nlh,
>  	if (mod.uid) {
>  		ASSERT_RTNL();
> =20
>  		/* check for updating an existing job with identical uid */
>  		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
> -			if (gwj->mod.uid !=3D mod.uid)
> +			if (gwj->mod->uid !=3D mod.uid)
>  				continue;
> =20
>  			/* interfaces & filters must be identical */
>  			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
>  				return -EINVAL;
> =20
>  			/* update modifications with disabled softirq & quit */
> -			local_bh_disable();
> -			memcpy(&gwj->mod, &mod, sizeof(mod));
> -			local_bh_enable();
> +			if (gwj->mod =3D=3D &gwj->mod1) {
> +				memcpy(&gwj->mod2, &mod, sizeof(mod));
> +				rcu_replace_pointer(gwj->mod, &gwj->mod2, true);
> +			} else {
> +				memcpy(&gwj->mod1, &mod, sizeof(mod));
> +				rcu_replace_pointer(gwj->mod, &gwj->mod1, true);
> +			}

Why are you afraid of doing
	mod =3D kmalloc(sizeof(*mod), GFP_KERNEL);

before invoking cgw_parse_attr()?

Let me try to sell this to you:
- Your stack usage shrinks by 736 bytes (as per previous estimation)
- If this is a new one, you attach the pointer to the struct cgw_job so
  it is not lost.
- If this is an update, you avoid memcpy() and use rcu_replace_pointer()
  as it is intended.

The construct of yours has the problem that it does not wait until the
RCU grace period completes. Meaning on first update mod1 is used, you
switch over to mod2. On the second update mod2 is used and you switch
back to mod1. There is no guarantee that all current users of mod ->
mod1 are gone by the time you switch from mod2 back to mod1. This
of course requires two updates (one after the other).

If you allocate the struct on entry (assuming the salesmen me was
successful) you could use=20

	old_mod =3D rcu_replace_pointer(gwj->mod, new_mod, lockdep_rtnl_is_held());

to grab the about to be replaced cf_mod and once the replacement is
over and at the end, kfree_rcu() on it or
	kfree_rcu_mightsleep(old_mod);

to safe a RCU head.

>  			return 0;
>  		}
>  	}
> =20
>  	/* ifindex =3D=3D 0 is not allowed for job creation */
> @@ -1219,16 +1226,16 @@ static int cgw_remove_job(struct sk_buff *skb, st=
ruct nlmsghdr *nlh,
> =20
>  		if (gwj->limit_hops !=3D limhops)
>  			continue;
> =20
>  		/* we have a match when uid is enabled and identical */
> -		if (gwj->mod.uid || mod.uid) {
> -			if (gwj->mod.uid !=3D mod.uid)
> +		if (gwj->mod->uid || mod.uid) {
> +			if (gwj->mod->uid !=3D mod.uid)
>  				continue;

Also here you must use rcu_dereference() for gwj->mod. Since all
add/remove jobs happen under the RTNL lock you could use
	rcu_dereference_protected(, lockdep_rtnl_is_held());

Sebastian

