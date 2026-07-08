Return-Path: <linux-can+bounces-8127-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QBhLAnMdTmoJDgIAu9opvQ
	(envelope-from <linux-can+bounces-8127-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:50:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C82F723E54
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:50:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="I5ZJB/vV";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8127-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8127-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F329F3028675
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5184B314D16;
	Wed,  8 Jul 2026 09:49:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228032EDD70
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:49:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504175; cv=none; b=QuAgvifbKqAFuF4WjhDKhqgNaCKjgCVvpubQ6G/EB10pNEEyfE3OOu/vbrYdRUZG8ALUdz7DenKV+2Fd97X3T4gPVU9itWJcbQXnOWTQS0umebtcwQ8h8npzupJfqnR8YGA4znHE3AQgrW7feRs5yim6GAMaVjOoymnohAOnzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504175; c=relaxed/simple;
	bh=SzaNlb8jnO46v6Bm+uaNUgz6EhfAWaG2Zbdz7b6VUPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oRLgqGRgkX9Hm9Me4XCfdrnQcsHzNXY7/keiDUZmQFXozCWlatv9PgrGpgybThbwaWz2PdjDXevpBmdL9rNFlj+8pcTqDh3MFFtYXm+6ol09vtXuP4ULFUPQLT5P+MjIz/S/0UFFAYBhwmx8y8afFuGY66gKZS6T3cbHGXnYLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5ZJB/vV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7151C1F000E9;
	Wed,  8 Jul 2026 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783504173;
	bh=dcXpjqCGIgp8q5P5H4o2Xh6TbPeYhJNTalWwi79fIYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5ZJB/vVnnU+VWUc75VyMrl1mxf3gttH6IOVi8PA9Zm2VLUlrhXD22p4Gfo4/49l4
	 cBb0vHut71YKFDrlMtmMrDBF/4IKyOdBUTbx8scv1N9SiU5rYarO8j03gNgadiUR4e
	 J9X8NN4B5yHSBLBInqCa80llJ3QxOp3HQTthQ3bgvyO5YGzHXeGcYH+aXQSiKAOUVC
	 o0pEuDmjDV8UO9vSYl1uQ+pYnpmB97JvgcpDmoi92Hbgjldoomigy+VaiXlhLNSVx8
	 MKXiMf0ugmVuqBrT1UQ+6WezSMl9Km+XZOEWxolW8Jzc0SuNO6guCsKeMm0RPSbEKb
	 HyeXPLZE9R/Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260708-bcm_fixes-v6-9-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-9-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:49:32 +0000
Message-Id: <20260708094933.7151C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8127-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,hartkopp.net:email,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 6C82F723E54

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ignored CAN frames incorrectly overwrite the `rx_stamp` and `rx_if=
index` of pending throttled frames, leading to incorrect metadata delivery =
to userspace.
--

--- Patch [9]: [PATCH v6 9/9] can: bcm: fix data race on rx_stamp/rx_ifinde=
x in bcm_rx_handler() ---
commit 1f01914b41bcf86b5db9980430a19a39e9075e09
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit fixes a data race on op->rx_stamp and op->rx_ifindex by moving
their assignment inside the bcm_rx_update_lock critical section. It also
stops updating them for RTR-request frames.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 4bdca72f9327f..73e3a5fc4342f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -805,6 +800,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
> =20
>  	spin_lock_bh(&op->bcm_rx_update_lock);
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but does unconditionally overwriting these
fields corrupt the metadata for pending throttled frames?

If a user configures a BCM socket with a filter (e.g., multiplex nframes > =
1),
bound to all interfaces (ifindex =3D=3D 0), with a throttle timer:

1. A frame arrives on vcan0, matches a mask, and is throttled.
   op->rx_ifindex becomes vcan0.
2. A subsequent frame arrives on vcan1 but does not match any multiplex mas=
k.

Since bcm_rx_handler() unconditionally updates op->rx_ifindex here before
applying the filters, doesn't it overwrite the metadata with vcan1 even
though the frame is ignored?

When the throttle timer expires, bcm_send_to_user() will use this corrupted
op->rx_ifindex to deliver the throttled frame from vcan0, making it appear =
as
if it came from vcan1.

Also, since the bcm_op struct only has one rx_stamp and rx_ifindex field,
doesn't this mean it structurally lacks the capacity to store independent
metadata per multiplex mask if multiple multiplexed frames are throttled
simultaneously?

> +
>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D9

