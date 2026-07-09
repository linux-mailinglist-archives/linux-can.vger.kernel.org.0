Return-Path: <linux-can+bounces-8258-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 85gROXUHUGqRsAIAu9opvQ
	(envelope-from <linux-can+bounces-8258-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:41:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0837357E7
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:41:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l794a0u7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8258-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8258-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F18D303A916
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA63CE489;
	Thu,  9 Jul 2026 20:35:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FB3A16AB
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:35:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629353; cv=none; b=rD8wrgV8uG5+LUqCyYjkcv8bUdlWht10gNkh8ef4MUqFE55f/+5DTbyD+rpvzGuoVgN4PrALwaW/1NQfiNmW+/5HFpv/MnhhY+eoqAIVT5Zt3UB/yzhANF8uPCzfHqSZNYI/emYmd1BF3fwgE9Ry311OJqZzZGco+EDL3hFqVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629353; c=relaxed/simple;
	bh=zuIPec6vhmCPjkRF/gNkYS79LZSaJzDQY2vc5S20jaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RahbpSrxqZ5dLps4y0cUETZNmy8MRhK934pVHiylLVEDi0Ag6xaKPCYx5jT9MYa914NDQUnVt97ayhgF4Ea5/PCQlpP6HaAhJDEYcev2j8L3FoRVm8ITMlZ5jayBMut8erSKe2u2Y3jc/AGujisQUwCIJn5pgHqFweK5c+fe1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l794a0u7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02F31F00A3A;
	Thu,  9 Jul 2026 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629352;
	bh=G8C5Jq8cVFxvUvTOcoYu/f0/c5wO7+iaS4qFcnU3iHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l794a0u7Bmf+YH6eeZD5c4HkZXOMJ2kxPGrAMfdnKQP7hvwpppoVBM6259WXYBwzg
	 HwK0ontEGGxxRKbVlW3e+M3ViNBTlY50a6Yqpcxv0h7+NdN1Z8XcCld1dTy9SkNx0A
	 jznMYaeS6KLTqS0E8uSPDhKogA/MFNRCvUgWY170o6C1/5XGGb4gYleixICJNEO0JQ
	 fBOVz8C7gtzxmHfrdbnwvpWiVwwN1DWRz0md5/3X2UjaLDt9KZO2DK120EeC3fyqUd
	 l1ksaouttDJWUDvKKcEE6HTBLueM9eKANx9NbGO+sOVMGun98oc+f9oTv/X32zLUd4
	 FqUhVb0OjS9uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/11] can: bcm: add missing device refcount for CAN
 filter removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v12-8-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-8-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:35:51 +0000
Message-Id: <20260709203551.F02F31F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8258-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,hartkopp.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A0837357E7

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Updating a BCM RX operation whose device was concurrently unregist=
ered fails to re-register the CAN filter.
- [High] Lockless writes to op->rx_stamp and op->rx_ifindex in bcm_rx_handl=
er can cause corrupted timestamps and mismatched metadata.
--

--- Patch [8]: [PATCH v12 08/11] can: bcm: add missing device refcount for =
CAN filter removal ---
commit 58881d5a5a65fccadb46fbccf91d34e84d09b49e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing device refcount for CAN filter removal

This commit addresses a memory leak issue and concurrent device
unregistration by taking a tracked netdevice reference during filter
registration.

Link: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartk=
opp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3cc3deb98a984..5660165cdf0eb 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -778,8 +778,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
> =20
>  	/* disable timeout */
>  	hrtimer_cancel(&op->timer);
> =20
>  	/* save rx timestamp */
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;
> =20
>  	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: High]
This isn't a bug introduced by this patch, but can these lockless writes to
op->rx_stamp and op->rx_ifindex cause corrupted timestamps and mismatched
metadata?

If a CAN socket bound to all interfaces (ifindex =3D=3D 0) receives packets
simultaneously from multiple interfaces in softirq context, could concurrent
execution of bcm_rx_handler() on different CPUs race to write these fields
outside of bcm_rx_update_lock?

On 32-bit systems, could this cause torn 64-bit ktime_t writes and wildly
corrupted timestamps?

Additionally, could one CPU overwrite the ifindex while another is passing =
it
to userspace, causing packets to be delivered with the wrong source interfa=
ce
index?

[ ... ]

> @@ -1341,8 +1341,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* free temporary frames / kfree(NULL) is safe */
>  		kfree(new_frames);
> =20
>  		/* Only an update -> do not call can_rx_register() */
>  		do_rx_register =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditionally fo=
rce
do_rx_register to 0 for an existing operation?

If a CAN interface is unregistered, triggering bcm_notify() which unregiste=
rs
the filter but leaves the bcm_op alive, and the application then issues an
RX_SETUP update on the same ifindex, won't skipping can_rx_register() here
leave the updated filter permanently detached from the CAN core?

Could this silently drop all CAN frames while returning a success return co=
de to
the user application?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D8

