Return-Path: <linux-can+bounces-8040-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMl8DE/BTGrapAEAu9opvQ
	(envelope-from <linux-can+bounces-8040-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 11:05:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7A47197E5
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 11:05:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PsoarzHj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8040-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8040-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496573028F32
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D50242D9D;
	Tue,  7 Jul 2026 08:58:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD533BBCB
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:58:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414723; cv=none; b=JLr6oUHLiro9eI7lqaPpXYbtY/4JSDYfCJ7CduwFOTp64A9koIJLJBIin+wiUSO1Ng+DspHS4NEhrYszsw/2Syel4ziooED1OZz6K4/sizQRKHzzNnM22mCkLVoOKRcpQhklXj1klR8/7H6hHK4TotnDZzQh6iO+NtYdmo2kaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414723; c=relaxed/simple;
	bh=Gsj31ORWrI3q8v/u0qpQYS04m3fUONDq9dFvXTWn67w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwPaus2Cnv30T7mQyGK5NyRselZxzVrlMNTOMYM1pIF9X28gxCJ2YwF94JerESe1hravTXDNHxHW+rYCRWXiCAXakGlfesmLHfToc25T/WhjSVWqGNxcqnj96f5lNAjNY7Kx06K2KUzb797qopkQJkfp3trmaz3XJP1vXSf/614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsoarzHj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA661F000E9;
	Tue,  7 Jul 2026 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414722;
	bh=mvzPdsdgfasehkMCaehqvKSlMf8hv5sF7hFGCiYrJVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsoarzHjzDj5C1R1bSIv3bf6jeuruXdZZAvhPus2v74q1pBvHgc7XojzG8yBJ1Vpi
	 EUmooK4Kd8ANSSM4IiKmB1jzlY+xeBvvrs8q+2idXZ2x2PlsvegVCTglrgBOJ5zM2r
	 njlkdajXp3fCZoe+dfk6A0z/6V2P40EzIijsvp/pB2gFj6/pzUEZez757DJ44D1NAh
	 xyGiZrpR/+P9XABEFJdR/ss71SdTbtx/R0JkQjCC5Qzfm27bvAPX3RH0KT5MsrMNou
	 1aJEzaL2n9X2MNqdOJ5J7Mn1Mol1fKtG7XhNPuxzIWk5m9iIlmimn1X0JWxfuVxKDL
	 kTK8fvjGjpdtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260707-bcm_fixes-v2-6-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-6-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:58:41 +0000
Message-Id: <20260707085841.DFA661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8040-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B7A47197E5

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Reading `cf->len` after a failed `memcpy_from_msg()` accesses un=
initialized heap memory and can incorrectly overwrite the returned error co=
de.

Pre-existing issues:
- [High] The patch fails to fix the data race on `op->frames` because `bcm_=
can_tx()` still copies frame data locklessly, allowing the transmission of =
torn CAN frames.
--

--- Patch [6]: [PATCH v2 6/6] can: bcm: extend bcm_tx_lock usage for data a=
nd timer updates ---
commit 9fb191cdc2eb3086cb7c75f76d0a1d693042a43b
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: extend bcm_tx_lock usage for data and timer updates

This commit stages new CAN frame content into an allocated buffer to valida=
te
it before updating the existing bcm_op under a lock. It also moves time
value updates under the same lock to avoid torn reads.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3609178a1367d..fdde25b5aa1d7 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1021,10 +1038,18 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  		if (msg_head->nframes > op->nframes)
>  			return -E2BIG;
> =20
> -		/* update CAN frames content */
> +		/* get new CAN frames content into a staging buffer before
> +		 * locking: validate and normalize the frames there so that
> +		 * bcm_can_tx() / bcm_tx_timeout_handler() never observe a
> +		 * partially updated or unvalidated frame in op->frames
> +		 */
> +		new_frames =3D kmalloc(msg_head->nframes * op->cfsiz, GFP_KERNEL);
> +		if (!new_frames)
> +			return -ENOMEM;
> +
>  		for (i =3D 0; i < msg_head->nframes; i++) {
> =20
> -			cf =3D op->frames + op->cfsiz * i;
> +			cf =3D new_frames + op->cfsiz * i;
>  			err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
> =20
>  			if (op->flags & CAN_FD_FRAME) {
> @@ -1035,36 +1060,38 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					err =3D -EINVAL;
>  			}

[Severity: Medium]
If memcpy_from_msg() fails (e.g. returning -EFAULT), will this read cf->len
from uninitialized heap memory before the error check?

Since new_frames is allocated via kmalloc(), reading cf->len might read
garbage. If the garbage value happens to be > 64, it could incorrectly
overwrite the -EFAULT in err with -EINVAL.

> -			if (err < 0)
> +			if (err < 0) {
> +				kfree(new_frames);
>  				return err;
> +			}
> =20
>  			if (msg_head->flags & TX_CP_CAN_ID) {
>  				/* copy can_id into frame */
>  				cf->can_id =3D msg_head->can_id;
>  			}
>  		}
> +
> +		spin_lock_bh(&op->bcm_tx_lock);
> +
> +		/* update CAN frames content */
> +		memcpy(op->frames, new_frames, msg_head->nframes * op->cfsiz);
> +

[Severity: High]
This is a pre-existing issue, but does this still leave a data race where
bcm_can_tx() can read partially updated frames?

The commit message states that bcm_can_tx() can no longer observe a
partially updated frame. However, looking at bcm_can_tx(), it calculates
the cf pointer under the lock but then reads the frame data locklessly:

net/can/bcm.c:bcm_can_tx() {
    if (!cf) {
        spin_lock_bh(&op->bcm_tx_lock);
        cf =3D op->frames + op->cfsiz * op->currframe;
        spin_unlock_bh(&op->bcm_tx_lock);
    }
    ...
    skb_put_data(skb, cf, op->cfsiz);
}

Doesn't skb_put_data() read from cf locklessly, potentially racing with
the memcpy() here in bcm_tx_setup() and copying a torn frame?

>  		op->flags =3D msg_head->flags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D6

