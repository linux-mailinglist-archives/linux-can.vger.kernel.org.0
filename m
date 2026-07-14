Return-Path: <linux-can+bounces-8415-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id asItAE0mVmpi0AAAu9opvQ
	(envelope-from <linux-can+bounces-8415-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:06:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57367754449
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:06:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="m/7GtgZO";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8415-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8415-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 309EC31DF1DD
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016ED380FE7;
	Tue, 14 Jul 2026 11:49:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D01F5821
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:49:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029743; cv=none; b=YNnjvBTdXpdQ6ZGUWS1RM7aOuQcXtc4O+5+lxuCvUhQ8Pvf0ehLpY2lj0p60dUcsWmGTV+lFRnyrbQQUXidyGXL9iF3B/gQtc03uUiKMpKpgZk+jWZyCMOhSMLVftKTsF3/zWwOlexNG+4VHDmRag772go+aGRqeEPFNiNb86nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029743; c=relaxed/simple;
	bh=Hkg2Sd8ypbtw/xd+z5mSjVmR7kHV6fogT0jHi9H3u7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ebXP1BJ/1uq4Z/xUsJ/f9AabKPk6zLMdIc0pXL6bSP4DdRcD5P8JXvAWS2Mdkr1TjPo0DMG0vHu7BFvynwnjcV+gRTPIguDAqk7dQcy510xIJVOG/dU/KkeIs4tancC60QcpIeOJ5CF09WkCeqwKf0CQtXFHz6C/xBRszkdARq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/7GtgZO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9341F000E9;
	Tue, 14 Jul 2026 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029742;
	bh=LvPQoE0xfAgWCKP9BCe7eS2EW2VlmWVyyqj8e4E7o7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/7GtgZOlwgf7Lt3piOGiODziOArv+TyekIqXxwWHVIklHgvvsUMWUy9TIN3dNZhV
	 CNi9lIkroqpIZkPB86SGFl42ok3coI+LfXtu/ktaJN0qdCboKDZpJVNxGgrmfnjnxD
	 /K8qSGTNW/FWLjPzDquOlOEpLtOsFRDzQrVLOGTIF/AXZX87owVx9JYl7sO7FB+6oU
	 qLjFvTggunvHNNQ2kYCTgfZFaLH+zv/YW0HrwNHgwLaHASEOBiIp3w/2mRrw+TZyWT
	 53ZkqYJKd95mzr8iSBRErOecAoCZQR8K2CSHoFdsKfLmjPkdbgXwT8sh7bIq7lm7Zs
	 eOMRPOPxPwUcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/11] can: bcm: extend bcm_tx_lock usage for data
 and timer updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260714-bcm_fixes-v14-6-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
 <20260714-bcm_fixes-v14-6-867a4be60a61@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:49:01 +0000
Message-Id: <20260714114902.0D9341F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8415-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:email,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 57367754449

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting TOCTOU race in `bcm_can_tx` causes CAN frame sequence =
corruption and skipped frames when an operation is updated concurrently.
--

--- Patch [6]: [PATCH v14 06/11] can: bcm: extend bcm_tx_lock usage for dat=
a and timer updates ---
commit 2415d37e8cc6682239aca2edf2ea4608c5e64f24
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: extend bcm_tx_lock usage for data and timer updates

This commit stages new CAN frame content into a dynamically allocated
buffer to validate before acquiring the lock, and updates timer variables
under lock to fix a torn 64-bit ktime_t read on 32-bit platforms.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 940cd9df1cca3..d5ca5ca472f1f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1052,36 +1094,38 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					err =3D -EINVAL;
>  			}
> =20
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
>  		op->flags =3D msg_head->flags;
> =20
> -		/* only lock for unlikely count/nframes/currframe changes */
>  		if (op->nframes !=3D msg_head->nframes ||
> -		    op->flags & TX_RESET_MULTI_IDX ||
> -		    op->flags & SETTIMER) {
> -
> -			spin_lock_bh(&op->bcm_tx_lock);
> =20
> -			if (op->nframes !=3D msg_head->nframes ||
> -			    op->flags & TX_RESET_MULTI_IDX) {
> -				/* potentially update changed nframes */
> -				op->nframes =3D msg_head->nframes;
> -				/* restart multiple frame transmission */
> -				op->currframe =3D 0;
> -			}
> +		    op->flags & TX_RESET_MULTI_IDX) {
> +			/* potentially update changed nframes */
> +			op->nframes =3D msg_head->nframes;
> +			/* restart multiple frame transmission */
> +			op->currframe =3D 0;
> +		}

[Severity: High]
This is a pre-existing issue, but does bcm_can_tx in net/can/bcm.c have a=20
race condition with TX_RESET_MULTI_IDX that corrupts the sequence state?

When bcm_can_tx is called by the timer, it reads op->currframe under
op->bcm_tx_lock, drops the lock to send the frame, and reacquires the lock
to update the sequence state:

CPU1 (Timer context in bcm_can_tx)
    spin_lock_bh(&op->bcm_tx_lock);
    // reads currframe
    spin_unlock_bh(&op->bcm_tx_lock);
   =20
    can_send(skb, 1);

If a concurrent sendmsg triggers bcm_tx_setup while the lock is dropped:

CPU2 (User context in bcm_tx_setup)
    spin_lock_bh(&op->bcm_tx_lock);
    if (op->flags & TX_RESET_MULTI_IDX)
        op->currframe =3D 0;
    if (op->flags & SETTIMER)
        op->count =3D msg_head->count;
    spin_unlock_bh(&op->bcm_tx_lock);

Then CPU1 resumes and unconditionally increments the state:

CPU1 (Resuming in bcm_can_tx)
    spin_lock_bh(&op->bcm_tx_lock);
    op->currframe++;=20
    if (op->count > 0)
        op->count--;
    spin_unlock_bh(&op->bcm_tx_lock);

Could this unconditional increment change the newly reset currframe from 0
to 1, causing frame 0 of the new sequence to be skipped? Also, wouldn't
this incorrectly decrement the new op->count limit?

> =20
> -			if (op->flags & SETTIMER)
> -				op->count =3D msg_head->count;
> +		if (op->flags & SETTIMER)
> +			op->count =3D msg_head->count;
> =20
> -			spin_unlock_bh(&op->bcm_tx_lock);
> -		}
> +		spin_unlock_bh(&op->bcm_tx_lock);
> =20
> -		kfree(new_frames);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v14-0-867a4be60a61@hartkopp.net?part=3D6

