Return-Path: <linux-can+bounces-8385-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0NHCOs4PVmq3ygAAu9opvQ
	(envelope-from <linux-can+bounces-8385-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:30:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 626DE7536A1
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:30:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DYS+I22N;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8385-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8385-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC3023013790
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05D736F419;
	Tue, 14 Jul 2026 10:27:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F503364038
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:27:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024849; cv=none; b=AvbObWfP2bWCP5iuhxVdPcz84RqAK5iGWsn+4W2W+PJgn/0lmsiXvhcu015iJyTPexg7mBtIFykiUnKVpDgZ2n5/7uFyY15F1QPr4pcNuEAgPl/EvgNHicSNsNpb1LHUPjVgp4J2QDFYlNOjwR3AnVNB/XX/uSHoy3B46qekQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024849; c=relaxed/simple;
	bh=cQQWTkmTydgaFPPZA5JF3IGd62Qnjg3l2ldYtjVwWZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ioCMPzhfjLgRXvG/QdX6tFw3KufepUtXX6nz4Z6uI13HlL/lt9HSTibqHeHDeutT9ztmZTMpAUtvLx9msjqAMzv2FnbGqMFT2OTmvNVZj3kebqDBK0o3qWQWAWvVDedyIvi7t0ITpiOKsuKw3fFhg0AYYjhimsCt7FAzMZyG7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYS+I22N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C41F000E9;
	Tue, 14 Jul 2026 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784024848;
	bh=yx7mSBlWCQ5mAYDC5D4PT8rQVt6w+T18u1rvGnz42P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DYS+I22N6qvGYv6j4zt8EAG7ImynqbgH4Jpc1I6GcfEMYFtkLgIQ/RrKs+9onkFAh
	 Gy1NG1k4ET6MzM/5gPRiiFbAKq0/W3CAmhYkx1DA4JkiLrR6byl4ULt0mF4qM34etF
	 +6IMU8Em3K84PmJCq+v5XTlLb4kkJKLkGG9Vj6Oi1VnexaE+zEzM+BIH/d3WAqccfW
	 WlFrHirtPBRPIlk/Yvel9quA6PQf+X9zIPaTJ+kZzeaTEYlLp6uY3sNztz2J+Z/zHH
	 AJu/uu5Kspd1iJgy8rrFBjbZmeVR55wgxIlWkmgOxHgH5rfMKiqZT2wJUfyqmPpNZj
	 PxSXwe+jKoINA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/11] can: bcm: add locking when updating filter
 and timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260714-bcm_fixes-v13-3-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-3-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:27:27 +0000
Message-Id: <20260714102728.3A1C41F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8385-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 626DE7536A1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Dropping bcm_rx_update_lock in bcm_rx_handler creates a TOCTOU r=
ace that can erroneously process a received frame as a filter and restart t=
imers for an RX_RTR_FRAME operation.
--

--- Patch [3]: [PATCH v13 03/11] can: bcm: add locking when updating filter=
 and timer values ---
commit 72b0ae7b8598826552a4ceb6840f50d02ba50085
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values
   =20
This commit adds a new bcm_rx_update_lock to protect timer and filter
updates from concurrent access in bcm_rx_setup() and various RX handlers.
It also fixes a race by normalizing the RTR flag on the staged buffer
before registering the frames.

Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@g=
oogle.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..af4bb4182bc29 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -729,9 +751,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  	/* update statistics */
>  	op->frames_abs++;
> =20
> -	if (op->flags & RX_RTR_FRAME) {
> +	/* snapshot the flag under lock: op->flags/op->frames may be updated
> +	 * concurrently by bcm_rx_setup().
> +	 */
> +	spin_lock_bh(&op->bcm_rx_update_lock);
> +	rtr_frame =3D op->flags & RX_RTR_FRAME;
> +	if (rtr_frame)
> +		memcpy(&rtrframe, op->frames, op->cfsiz);
> +	spin_unlock_bh(&op->bcm_rx_update_lock);
> +
> +	if (rtr_frame) {
>  		/* send reply for RTR-request (placed in op->frames[0]) */
> -		bcm_can_tx(op);
> +		bcm_can_tx(op, &rtrframe);
>  		return;
>  	}
> =20
> @@ -743,6 +774,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
>  			traffic_flags |=3D RX_OWN;
>  	}
> =20
> +	spin_lock_bh(&op->bcm_rx_update_lock);
> +

[Severity: Medium]
Could this lock split cause a race condition if a concurrent bcm_rx_setup()
updates the operation to an RX_RTR_FRAME?

If bcm_rx_handler() initially sees rtr_frame =3D=3D false and drops the loc=
k:

CPU1 (bcm_rx_handler)
    spin_lock_bh(&op->bcm_rx_update_lock);
    rtr_frame =3D op->flags & RX_RTR_FRAME; // false
    spin_unlock_bh(&op->bcm_rx_update_lock);

CPU2 (bcm_rx_setup)
    spin_lock_bh(&op->bcm_rx_update_lock);
    op->flags |=3D RX_RTR_FRAME;
    // updates op->frames but does not clear op->kt_ival1
    spin_unlock_bh(&op->bcm_rx_update_lock);

CPU1 (bcm_rx_handler)
    spin_lock_bh(&op->bcm_rx_update_lock);
    // Proceeds down the non-RTR path with op->flags now having RX_RTR_FRAM=
E set
    ...
    bcm_rx_starttimer(op);

When bcm_rx_handler() reacquires the lock and proceeds along the non-RTR pa=
th,
it will incorrectly compare the received frame against the new RTR reply fr=
ame,
potentially sending a spurious RX_CHANGED.

Furthermore, since op->kt_ival1 is not cleared when switching to RTR mode, =
could
this erroneously start a timer for an RTR operation and result in a spurious
RX_TIMEOUT?

>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,
> @@ -778,6 +811,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
> =20
>  rx_starttimer:
>  	bcm_rx_starttimer(op);
> +
> +	spin_unlock_bh(&op->bcm_rx_update_lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D3

