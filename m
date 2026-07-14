Return-Path: <linux-can+bounces-8440-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O4pBJZxtVmps5QAAu9opvQ
	(envelope-from <linux-can+bounces-8440-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:10:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D337573A2
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YoSOYofp;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8440-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8440-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E58730451D7
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005239CCEE;
	Tue, 14 Jul 2026 17:10:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBC39CCE0
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 17:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049048; cv=none; b=Ff74Sd2esorJ/DZJEeBMNCCCh5EV16gZpZ58AV66xi11cNJTcQVtoKyDV0jZpg81FVhizJ4hSnIKNH9Sa/bHcdYmadVJHFWSVqunRjMCmd2wRlvPY1v9r0Rk7IeXIujTicnfFxRl5izViDF6DkChod56WcSraBm7E5k7hakQ5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049048; c=relaxed/simple;
	bh=OEai9ocO1k+5lU0BixrruHR2RnoeoT+a8NeoqmyRATk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7Qz/hVH9scFhf0CTWXO+16LEAlysP7OQuqVHg5VyJQU1QvPioPzuRhPx9na0+1BtnwMIxTmebRi39SDL+JwGGK7iESOhc7fCX8AAhzZG+KHkvCRICR0YvnoJNoEj9WJhdPQbceEIbWMLE3S6GHXIm4jVaT8F3fcNA56grx1s3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoSOYofp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6DB1F00A3A;
	Tue, 14 Jul 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049047;
	bh=kQ45QYLVZsdAoBtojcvf1h2Gr9qxXFP359Xh3SJ33hQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YoSOYofpI7jYevK7rdR2S4pOKb8/6nLYAA2Tp7MWaV3kG2YCkgNC9FJ3BXLSlNXjn
	 pRmgzLN4zR2nzqWiIAeo18gJLad/wXxIP8bnyUSJA4vR3VYTV8Mm2Utmn2eHNdJh+K
	 xEKXi7QmaPsnP9T95QFFKiSMUVEn1V+FG4xgYfr5z/G9H4UzLVnUlvjtUWSJYJGcMV
	 59lLXqqCG/fAwRn9nML9y2tDw2QF12NvI4DCzaU3wKgkF2y0smRMIpQ9kGzWtpTbam
	 n4XHaixRxivH0ViLFcd9oGrmZeXYgfhz9jwg15vdiwA1jJG0NPB8SYCd/1Q+qo0rH8
	 Y1uhPQpxPw2Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v15-2-562f7e3e42da@hartkopp.net>
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-2-562f7e3e42da@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:10:46 +0000
Message-Id: <20260714171047.1A6DB1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8440-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,hartkopp.net:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03D337573A2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU synchronization primitives when publishing to or trave=
rsing the rx_ops and tx_ops lists, leading to potential data corruption or =
kernel oops for concurrent procfs readers.
--

--- Patch [2]: [PATCH v15 02/11] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit ebe4ed63d28eb9026b5f264dfe90ce6952b3275f
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a lockless bound/ifindex race by moving the ifindex read
and bound re-check into the locked section. It also ensures bcm_rx_setup()
returns -ENODEV when the target device concurrently disappears.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
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
> =20
>  		} else

[Severity: High]
This is a pre-existing issue, but is it possible for a concurrent procfs
reader to observe uninitialized list nodes due to missing memory barriers?

In net/can/bcm.c:bcm_tx_setup(), list_add() is used instead of
list_add_rcu() when adding to tx_ops:

    /* add this bcm_op to the list of the tx_ops */
    list_add(&op->list, &bo->tx_ops);

Similarly, in net/can/bcm.c:bcm_rx_setup(), list_add() is used instead of
list_add_rcu() when adding to rx_ops. This misses the memory barriers needed
to ensure node initialization is visible to concurrent RCU readers.

Additionally, in net/can/bcm.c:bcm_proc_show(), list_for_each_entry() is
used instead of list_for_each_entry_rcu() to traverse tx_ops inside an RCU
critical section:

    list_for_each_entry(op, &bo->tx_ops, list) {

This misses READ_ONCE() and data dependency barriers.

Could an unprivileged userspace program repeatedly adding or removing TX/RX
operations using bcm_sendmsg() (while holding lock_sock()) cause a
concurrent thread reading the corresponding /proc/net/can-bcm/<inode> file
(holding only rcu_read_lock()) to encounter an information leak or a kernel
oops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v15-0-562f7e3e42da@hartkopp.net?part=3D2

