Return-Path: <linux-can+bounces-7834-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9pdGDTxK2rIIAQAu9opvQ
	(envelope-from <linux-can+bounces-7834-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:44:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01B6790DD
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:44:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DY+e1qLK;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7834-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7834-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB7931EE558
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE337D104;
	Fri, 12 Jun 2026 11:40:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28E3C585B
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264432; cv=none; b=HwoAH4RWzWWR4pVETPDHxH/ljgofpPUDD3tlwwo7CjPcAciVKUCivGHDbgORTMvMKdefwudHsgIJ1sTH0pKvdAAviYf3hmoZhkJCRl7xGg9TaXHT1KBLBlpCh5nRtWcAO+ix7Q8CinaB2KTeEkA6L6XfLlIncJXyHQucjz1mIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264432; c=relaxed/simple;
	bh=lrFZKVa5E+8XleD9JKa39ua8eAg8dSZSC40RHFyCAf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vm0Ma2ZwB+DrsQIfsP85yhAEbawy8LS5qToVz0ovYpNLh0PKkPiJgsuocH4Pa49ILpiNTrrvMuZejcXZjw54EJ+s+NpI96fIyIj3yi7tNNHgJ25lx/xd2r4bIii2pdeulSZsmzM+ZmgAcxMV08pkRC6rplqcr1KSxOvZ4UvmiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY+e1qLK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A22F1F00A3A;
	Fri, 12 Jun 2026 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781264431;
	bh=Fu31d+aX454Q2NR9sYs54lKa33UjnO3F9iwkmHEN0bM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DY+e1qLKmQBV/arTE/w3kTwnp/SI6oLkeLpaGHoaxVvnRgLGnjGw2NPc2123R7paD
	 S+XfMILFAs6jYHrH7gGesqJARPyPSiPuScaHAP9lV2oXjd34COReVdOSGpKBO1Asql
	 B/uk63xv6WlZCIaWxsZeiJroAg6Fg+pCQAa5G0ox96xHdrAZm3Z1EC5+TCcpTqc8Pc
	 zzOMrsM90R6WbmqmiB5n6tLilt0pDBCRXgoiqPX03zmpRJt1Ml/rJKAhYOw6XiUS72
	 BT/XWmw7xwkjf+j5PG/0+RfT98B255rRLhYj4Z3jcro5wVxTOXHv1+rNIaIBGlSiFZ
	 c6NlbocSomPOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260612-bcm_fixes-v1-3-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-3-ca2fa07ee70f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:40:30 +0000
Message-Id: <20260612114031.0A22F1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-7834-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,hartkopp.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url];
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB01B6790DD

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses race conditions in the RX path but misses iden=
tical missing lock vulnerabilities and partial state corruption bugs in the=
 TX path (`bcm_tx_setup` and `bcm_can_tx`).
- [High] Data race in `bcm_rx_setup` when clearing `CAN_RTR_FLAG` for `RX_R=
TR_FRAME` operations, which can lead to torn reads and CAN packet storms.
- [High] `bcm_rx_handler` reads `op->flags` without lock protection, trigge=
ring a data race with `bcm_rx_setup` and potential data corruption.
--

commit 7bf24ff9623b82ba96d63789d48e3d741157ffeb
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit fixes a KCSAN-detected race condition where timer values
could be overwritten simultaneously in bcm_rx_setup(). It protects the
timer and filter data updates with a new spin_lock_bh().

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 9475758a6749f..fc5158132b554 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -129,6 +129,7 @@ struct bcm_op {
>  	struct sock *sk;
>  	struct net_device *rx_reg_dev;
>  	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
> +	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
>  };

[Severity: High]
This is a pre-existing issue, but while we are adding bcm_rx_update_lock
to protect RX filter and timer updates, does the TX path need similar
protection?

In bcm_tx_setup(), when updating an existing operation, memcpy_from_msg()
copies user data directly into op->frames without locking, and 64-bit timer
values like op->kt_ival1 are updated locklessly.

Concurrently, if bcm_tx_timeout_handler() fires, it can read these torn
timer values. Also, bcm_can_tx() reads the frame payload from cf locklessly
via skb_put_data(), which races with memcpy_from_msg().

Furthermore, if bcm_tx_setup() encounters a validation error
(e.g., cf->len > 64) after memcpy_from_msg(), it returns -EINVAL without
rolling back. The active timer will continue firing, reading the malicious
length and allocating a normal-sized skb, potentially leading to an
out-of-bounds read in the CAN driver.

[ ... ]

> @@ -743,6 +755,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
>  			traffic_flags |=3D RX_OWN;
>  	}
> =20
> +	spin_lock_bh(&op->bcm_rx_update_lock);
> +
>  	if (op->flags & RX_FILTER_ID) {

[Severity: High]
This is a pre-existing issue, but does bcm_rx_handler() read op->flags
without lock protection just before this new lock is acquired?

If a user updates an existing operation to toggle RX_RTR_FRAME, bcm_rx_setu=
p()
updates op->flags and op->frames under the bcm_rx_update_lock.

However, earlier in bcm_rx_handler(), it checks op->flags locklessly:

	if (op->flags & RX_RTR_FRAME) {
		/* send reply for RTR-request (placed in op->frames[0]) */
		bcm_can_tx(op);
		return;
	}

Could bcm_rx_handler() observe the newly written op->flags and immediately
call bcm_can_tx(), which will then read a stale or partially written
op->frames[0] to transmit? This seems to defeat the atomicity provided by
the newly introduced lock.

[ ... ]

> @@ -1277,10 +1315,13 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  		if (op->flags & SETTIMER) {
> =20
>  			/* set timer value */
> +			spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: High]
This is a pre-existing issue, but is there a data race when clearing
CAN_RTR_FLAG for RX_RTR_FRAME operations?

In bcm_rx_setup(), just above this block, it handles RX_RTR_FRAME:

	if (op->flags & RX_RTR_FRAME) {
		struct canfd_frame *frame0 =3D op->frames;
		...
		if ((op->flags & TX_CP_CAN_ID) ||
		    (frame0->can_id =3D=3D op->can_id))
			frame0->can_id =3D op->can_id & ~CAN_RTR_FLAG;
	} else {
		if (op->flags & SETTIMER) {

The frame0->can_id modification happens after bcm_rx_update_lock is already
unlocked.

Concurrently, bcm_rx_handler() checks op->flags & RX_RTR_FRAME and calls
bcm_can_tx(), which reads op->frames to send a reply. Could bcm_can_tx()
transmit the frame with CAN_RTR_FLAG still set before it is cleared here,
potentially triggering an infinite loopback storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-bcm_fixes-=
v1-0-ca2fa07ee70f@hartkopp.net?part=3D3

