Return-Path: <linux-can+bounces-8418-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ipxWF/QkVmrPzwAAu9opvQ
	(envelope-from <linux-can+bounces-8418-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:00:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF299754336
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:00:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e5uSOp09;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8418-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8418-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5B6305AD95
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D935A952;
	Tue, 14 Jul 2026 11:57:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683311EF39E
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:57:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030262; cv=none; b=AXl6+nKw7XwS0t6Zp8P+oUsRSqDS0+mJUtcG67ofSLRRBH312zTmm6yKRQuiFA27CV4x00Ui9Ara+Eg/KARo9/komuC3VyPcCNQaLJqZHK/mNU/cLDEXqxECqrMwWrdSL8m/3P/9RORJ3Mcl2xMr7RFWaMZ9y+bqXcs9cLadBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030262; c=relaxed/simple;
	bh=foqJkoujsC1BpuBFlea3/6nPSRu3pa2esCGSPzvPpwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVAb+ORbIAtHXdDEBFsuaXdMd21I8AXKjWBcuoQ3yt93vNkgSoPTLlS+H20CXB2Cizqskw7x3d+zSUBOJiycy6RtU2aSErG7VpCHly5mwp6+oUIUIU/EgspYty8/CNqk2Ipwos9o2k2bFQA5X4weIB3bUqSupo9ABuJYog6Tz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5uSOp09; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92C91F000E9;
	Tue, 14 Jul 2026 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030261;
	bh=2N/3fT55VW69rEEuAo2cAJBUNtIQ9X0BDGXp/aAqI98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5uSOp09BXZ9GvwukII8Q+o0RR3O9gk+kTYu44HHI3DWTEx1CQLGal9A8+Lw2nxrR
	 dRlpDLsRIEtOEdu4CCzd0u9uw+qWqQtiBGlLaQiYGMatdMONJamKW+bOuJGDImJulF
	 2kQb4iOsvdQeYxYg3OzpFMpOaJ3ooMuys8PJUCNJNyir3aGutSl/xXZYHWhy9lQely
	 W2ZXjCmkVRuJRAZDEr1VbId6fPtR1FAQCOsj8wJsgYjTPeyYbbTLL5TCieJssaSJT5
	 YvU0ckz5LE5sMWQFH52bV32Fu+g89f51thcVqcUOqClUPUWm04q2oZr7L96GZlZo6D
	 t7uxP5YgM9HWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/11] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260714-bcm_fixes-v14-1-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
 <20260714-bcm_fixes-v14-1-867a4be60a61@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:57:40 +0000
Message-Id: <20260714115740.A92C91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8418-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF299754336

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `/proc/net/can-bcm` read path contains data races when iterati=
ng over `bo->rx_ops` and `bo->tx_ops`, leading to a potential kernel panic =
(DoS).
--

--- Patch [1]: [PATCH v14 01/11] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit f579f72c791d4b1c3e9b36c8937eb96317894b65
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit resolves a use-after-free in the CAN BCM module by deferring
the timer cancellation and memory deallocation of bcm_op to a dedicated
workqueue. It introduces flag checks and takes a reference on the socket
to ensure it outlives the deferred work.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20
>  		/* initialize uninitialized (kzalloc) structure */

[Severity: High]
This isn't a bug introduced by this patch, but does the current code lack
proper RCU publish semantics when inserting new BCM operations?

While looking at bcm_tx_setup(), the new operation seems to be published
using list_add():

    list_add(&op->list, &bo->tx_ops);

Similarly, bcm_rx_setup() appears to use list_add():

    list_add(&op->list, &bo->rx_ops);

If bcm_proc_show() iterates over these lists while holding only
rcu_read_lock(), could this lead to uninitialized memory accesses or a
kernel panic (DoS)?

For example, bcm_proc_show() traverses tx_ops using a non-RCU iterator:

    list_for_each_entry(op, &bo->tx_ops, list) {

Since list_add() lacks the smp_store_release() memory barrier provided by
list_add_rcu(), and the traversal in bcm_proc_show() lacks READ_ONCE() and
rcu_dereference() protections, could this expose the traversal to concurrent
list mutations?

An unprivileged user could potentially trigger this by continuously reading
/proc/net/can-bcm/<inode> while another thread repeatedly invokes sendmsg()
with TX_SETUP/RX_SETUP and TX_DELETE/RX_DELETE opcodes to modify the lists.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v14-0-867a4be60a61@hartkopp.net?part=3D1

