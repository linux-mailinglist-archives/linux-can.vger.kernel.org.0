Return-Path: <linux-can+bounces-8062-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HRUQLBPXTGqlqgEAu9opvQ
	(envelope-from <linux-can+bounces-8062-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:38:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8B71A7AD
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:38:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M9vqWuPM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8062-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8062-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6703100C1B
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789783E51DB;
	Tue,  7 Jul 2026 10:29:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068603E172C
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 10:29:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420175; cv=none; b=MB74kLzFk3fZl+1O3oZd7p7k7ch/V9yZ9yoFZ779HBzfZ3f3YVrcB1FN2fruNJ5gPxgc+TfxMu2h3oZlZ80cpL5mHBJ60lC/UVPw/66spfCu1lsd6ZKH3sZ+XxDnkdZdxYCfi8D13t5GXKIAzTaBT7bPQendNK3MXCm0XqgUOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420175; c=relaxed/simple;
	bh=+ss9SnMQlBZL1xcKQfTIV9ZBFzVzggqjtikkJ2tOyz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AErHfqZM+I7s2jDZ2rm3jtqu9GJGS0nmSZkKw/57p5TjhdJvig+UofN9kDuQQdBP6DnxrN2tH1EuzDPVn5fDthb4Q3FT9CeFktGK57fIyfUBSKFEsMrhzS3B3C6fIXEJ2Bri2RgsMVcxxNBht07yQXf4XcxqWDXzGI2d57pXyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9vqWuPM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E091F00A3A;
	Tue,  7 Jul 2026 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420172;
	bh=fkvunUHwRemd1f2zrHarU7hjkDK1zRUeyJPbjCJ538s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9vqWuPMM+a4m/zdbo6I+2eKgnBqJT7UTKFk2cCnSXh6yWrUIz/kERgZqnwtuFoph
	 WKM9iHy/Cgq5Aq0LPLNd29tlsic/nLlo4Bt+g86BcVuf2czkz/kTVXA5LPHFK6xT95
	 gy6jcKy2lUj6j8onEo9g1N3BJyYvLulyKmvTbMBhgPk4P4RcO+JH6QZ3XhEQo1Fxv8
	 aNEhK0tMhjAAhP/vZ4l5DhpLkDIkPaQPn8W83pr2RYfFxHnBqS+yHuqMRPgx5b+Qwj
	 BMeqvwq3W6GDN9u7P9E/DLR0xN4f74rwE/rqFWX0KpmnGdg9OxaI+WNoiheXqAtSe8
	 AfUczlHGDIqKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260707-bcm_fixes-v3-2-84600ca6d889@hartkopp.net>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-2-84600ca6d889@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:29:31 +0000
Message-Id: <20260707102931.A5E091F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8062-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 1DD8B71A7AD

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected and non-RCU-safe list manipulations on `bo->tx_ops` an=
d `bo->rx_ops` cause data races with lockless procfs readers.
- [High] Concurrent update of `op->frames` causes a data race with softirq =
CAN TX processing, sending corrupted frames.
- [Medium] Concurrent update of `op->frames` causes a data race with softir=
q CAN RX processing.
--

--- Patch [2]: [PATCH v3 2/7] can: bcm: fix lockless bound/ifindex race and=
 silent RX_SETUP failure ---
commit 8b8711c2150aeadcb80c48a64d2a2f7206bc9502
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition where bcm_sendmsg() could read an
inconsistent bo->bound and bo->ifindex state during concurrent socket
operations. It addresses this by moving the ifindex read and bound validati=
on
inside lock_sock(). The patch also fixes bcm_rx_setup() to correctly return
-ENODEV instead of silently succeeding when a device disappears concurrentl=
y.

Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x=
_pV3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
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

[Severity: Medium]
This isn't a bug introduced by this patch, but does the concurrent update of
op->frames cause a data race with softirq CAN RX processing?

In bcm_rx_setup(), when updating an existing RX filter, the code copies from
userspace without excluding the softirq path:

bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    ...
}

Since memcpy_from_msg() can sleep and the CAN RX softirq runs concurrently,
bcm_rx_cmp_to_index() might execute mid-update. It locklessly reads op->fra=
mes
and op->last_frames to match multiplexed CAN frames:

bcm_rx_cmp_to_index() {
    ...
    if ((get_u64(cf, i) & get_u64(rxdata, i)) !=3D (get_u64(cf, i) & get_u6=
4(lcf, i))) {
    ...
}

Can this lead to torn reads where the BCM spuriously triggers or fails to
trigger filter updates based on corrupted matching data?

[ ... ]
> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
[ ... ]
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:

[Severity: High]
This is a pre-existing issue, but do these list insertions lack RCU write
barriers?

bcm_proc_show() iterates bo->tx_ops and bo->rx_ops locklessly using
rcu_read_lock(). However, bcm_tx_setup() and bcm_rx_setup() insert new
elements using list_add() instead of list_add_rcu(), which lacks the
smp_store_release() write barrier required to safely publish initialized
bcm_op structs to concurrent RCU readers.

Additionally, bcm_proc_show() appears to use the non-RCU list_for_each_entr=
y()
macro for bo->tx_ops, omitting the required read barrier. Could an unprivil=
eged
local user reading /proc/net/can-bcm/* concurrently trigger a panic?

[Severity: High]
This is another pre-existing issue, but does a similar concurrent update of
op->frames cause a data race with softirq CAN TX processing?

In bcm_tx_setup(), when updating an existing TX operation, memcpy_from_msg()
overwrites the payload in op->frames without acquiring op->bcm_tx_lock or
excluding the softirq:

bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Concurrently, the hrtimer callback bcm_tx_timeout_handler() can fire and in=
voke
bcm_can_tx(). bcm_can_tx() retrieves the frame pointer under the lock, but
accesses the underlying frame data locklessly outside the lock:

bcm_can_tx() {
    ...
    skb_put_data(skb, cf, op->cfsiz);
    ...
}

Could this allow the softirq to transmit a partially updated or torn CAN fr=
ame
onto the physical CAN bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v3-0-84600ca6d889@hartkopp.net?part=3D2

