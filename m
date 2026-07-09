Return-Path: <linux-can+bounces-8183-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YyMFKl1fT2qjfQIAu9opvQ
	(envelope-from <linux-can+bounces-8183-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:44:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A972E6E1
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:44:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="HhN2/4Qp";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8183-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8183-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B61304BD95
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC43EFFDC;
	Thu,  9 Jul 2026 08:36:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8B3F0ABB
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:36:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586204; cv=none; b=ciq7tAR3lppu1YbyFVpn/4B9xVEPgsBlP7/N+hGpLAGiZA4KOrgXicziPump3h5mOeqT59824isyWxqqQvkC1oxlzmyXrBQRp7u4w2EHsbc24CkB864ZJi3Sp3uTGaoYOt+KBNdgTtD3XmxTxS5z8nB0T7xEzJ4WBmPTNW2wG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586204; c=relaxed/simple;
	bh=sDfrnPA6x5ElnQ4oEo/DulL0qX7EijBmskKsc8E7UmU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ca6RnVmfvworokLmkiMqFQpGhua+idcrUxmtl9v6AfGY6ruJBKKRtDyTjpX/W3IeFLt1XygeTYxzjuib9J87n7L/f1+rIn8Nly5Xenj832vT6CWwJRmuGQCkEBwhdzcmu4zUpVdTi5vZmY2fQj9bKWygo9DdWhnkcXUO1DhdruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhN2/4Qp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B91F000E9;
	Thu,  9 Jul 2026 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586202;
	bh=PT2Zn9YOi118eTbCwdAerRdJ5ZQg/MIbtKLWFlEwfEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HhN2/4QpPCQsmQ/Pm0vAIytGi3X78RKlB4mG+rZCz9vOhRrqRYQp97fiXql50LgHX
	 W9Auzh98Yui1BKQ8/VIhLF8FHK5vqcx0A1LkdKCQLgjs19rEtZa1uov37rhE4FfNao
	 6PrmdLDzlhR+wIer9qjN1rGASXSI8nZjCpdaJfE3Extz2B6az8PEBmvNb29iJTt1nr
	 bjv+82Mzwrs1Q2CkPBxgbik9ixLeLlaEKpDLfvi7KNclZxG3BFiEk9jhr4b4dk9MwG
	 P4fcjIyk4z19g2NtIIq9K46QXIfETdPO+KXawvWdoKqx8n5WIs2UE1sdX7Iu+OHrQ9
	 tFmHd4hl1k4DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/10] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v9-2-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
 <20260709-bcm_fixes-v9-2-6eebb78ccfb2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:36:41 +0000
Message-Id: <20260709083642.4F5B91F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8183-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,hartkopp.net:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 8C7A972E6E1

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe lockless list traversal and missing memory barriers for tx_=
ops and rx_ops lists.
- [High] Unbounded allocation of bcm_op structures allows local users to ex=
haust kernel memory.
- [Medium] bcm_rx_setup() silently fails to resume frame delivery for an up=
dated RX operation if the target network device was previously unregistered.
- [Medium] Data race on bo->ifindex and bo->bound during NETDEV_DOWN handli=
ng risks torn reads and spurious errors.
--

--- Patch [2]: [PATCH v9 02/10] can: bcm: fix lockless bound/ifindex race a=
nd silent RX_SETUP failure ---
commit 48dc89358d05a6bfc0097f061749b853a77c5328
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: bcm: fix lockless bound/ifindex race and silent RX_SETUP fail=
ure

This commit fixes a data race between lockless reads of bo->bound and
bo->ifindex in bcm_sendmsg() and locked updates in bcm_notify() and other
paths. It also addresses a silent failure in bcm_rx_setup() when the
requested target device concurrently disappears.

Link: Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4r=
EbsP9x_pV3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
> =20
>  				op->rx_reg_dev =3D dev;
>  				dev_put(dev);
> +			} else {
> +				/* the requested device is gone - do not
> +				 * silently succeed without registering
> +				 */
> +				err =3D -ENODEV;
>  			}

[Severity: High]
This is a pre-existing issue, but does the current iteration logic for
bo->tx_ops and bo->rx_ops in bcm_proc_show() risk wild memory accesses or
infinite loops?

bcm_proc_show() iterates over the operations holding only rcu_read_lock():

net/can/bcm.c:bcm_proc_show() {
    ...
    list_for_each_entry_rcu(op, &bo->rx_ops, list) { ... }
    ...
    list_for_each_entry(op, &bo->tx_ops, list) { ... }
}

Meanwhile, bcm_rx_setup() and bcm_tx_setup() insert new elements without
an RCU write memory barrier:

net/can/bcm.c:bcm_rx_setup() {
    ...
    /* add this bcm_op to the list of the rx_ops */
    list_add(&op->list, &bo->rx_ops);
}

Could this allow a local user reading /proc/net/can-bcm to crash the
system while operations are concurrently registered?

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for local
users to exhaust kernel memory by creating a large number of BCM operations?

In bcm_rx_setup() and bcm_tx_setup(), new operation structures and their
associated frame arrays are allocated unboundedly:

net/can/bcm.c:bcm_rx_setup() {
    ...
    op =3D kzalloc(OPSIZ, GFP_KERNEL);
    ...
    op->frames =3D kmalloc_array(msg_head->nframes, op->cfsiz, GFP_KERNEL);
}

Since these allocations do not appear to enforce any per-socket limit
or charge the socket's memory quota (sk_rmem_alloc/sk_wmem_alloc), could an
unprivileged user repeatedly call sendmsg() with unique can_ids to trigger
an out-of-memory panic?

[Severity: Medium]
This is a pre-existing issue, but does bcm_rx_setup() silently fail to
resume frame delivery for updated RX operations if the target interface was
cycled?

When an interface is removed, bcm_notify() handles NETDEV_UNREGISTER by
unregistering the filter and setting op->rx_reg_dev =3D NULL, but leaves the
op in the active bo->rx_ops list:

net/can/bcm.c:bcm_rx_unreg() {
    ...
    /* mark as removed subscription */
    op->rx_reg_dev =3D NULL;
}

If an RX_SETUP request subsequently attempts to update this existing
filter, bcm_rx_setup() skips re-registration:

net/can/bcm.c:bcm_rx_setup() {
    ...
    /* Only an update -> do not call can_rx_register() */
    do_rx_register =3D 0;
}

Should this logic check if the operation is currently unregistered before
clearing do_rx_register?

[ ... ]

> @@ -1535,7 +1564,12 @@ static void bcm_notify(struct bcm_sock *bo, unsign=
ed long msg,
>  				bo->bcm_proc_read =3D NULL;
>  			}
>  #endif
> -			bo->bound   =3D 0;
> +			/* Paired with the lockless fast-path check in
> +			 * bcm_sendmsg(); bo->ifindex itself is only ever
> +			 * accessed under lock_sock() so it needs no
> +			 * annotation.
> +			 */
> +			WRITE_ONCE(bo->bound, 0);
>  			bo->ifindex =3D 0;
>  			notify_enodev =3D 1;
>  		}

[Severity: Medium]
This isn't a bug introduced by this patch, but does the handling of
NETDEV_DOWN in bcm_notify() have a data race on bo->ifindex and bo->bound?

While the target patch adds WRITE_ONCE() for bo->bound during device
removal, NETDEV_DOWN appears to read these fields locklessly:

net/can/bcm.c:bcm_notify() {
    ...
    case NETDEV_DOWN:
        if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
}

If a socket is connecting to a new device while an unrelated device goes
down, could the lack of barriers allow bcm_notify() to observe a new
bo->bound=3D1 but the old bo->ifindex, leading to a spurious ENETDOWN error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v9-0-6eebb78ccfb2@hartkopp.net?part=3D2

