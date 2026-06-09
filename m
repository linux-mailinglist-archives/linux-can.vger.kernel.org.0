Return-Path: <linux-can+bounces-7790-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KAwTMOZgKGrXCwMAu9opvQ
	(envelope-from <linux-can+bounces-7790-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:52:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8B76636D0
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 20:52:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iwmEVUDz;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7790-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7790-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EF7B3016769
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C4331EC9;
	Tue,  9 Jun 2026 18:51:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96E3EB10F
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:51:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031101; cv=none; b=NU3vpKezul5DqPG0CRCz7pLyBkVtUQ6lZcRVxXDfGO+jKZ10+W1kGCIXb0pSdRRixBYf7AoH281BsZLHEx1Jw03IrGMfQyJBHVW7fwtXj4cEdMFZAE6vi6Qw1TnclnhEraBrJvztpp+sMhB3vr0/QLriO+5W7szFmzWQK2g2LZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031101; c=relaxed/simple;
	bh=dGLIHAPYNXvt7ViDk1IAvHi8uKqioO7LJgheeOQx4Lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhjzdqzdvVW57ct5CpMZOtQ3cgqy4MMKL3iPoLoZ1CSIO5IV40S7QYpFlDmUeH3XHagkqgbbEJZ3AzZ/UhTVY3N1lTj2UOx/eDmht+pUjx/uxkmpyvlzTYLieIuOWzqORakBFLXri+Z9zBE2Nc+bDAB2KbNgmsVtL7v52L918SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwmEVUDz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76CE1F00893;
	Tue,  9 Jun 2026 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031099;
	bh=neEcZ1HiNbVAOnKx4RHlPaY0OidOPm3B/p7GRBlHz7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwmEVUDzwgg4SfW9C1d4qF9JSBX5qWnj1AOnFgdtz1ZHVrbhQxvWxbjUs4d63kU1A
	 gLO9O8pX0/It05pGsdHpz4xmSqWGcTFfT/MkUzPSEmp7y/SAKCOKNmtpVmb2fRIZ6v
	 99GlM0hSt4Q8kjHiAj1a6xWcZ9D+txycgdcMvKYW41Al+hDwmN6gfnP/1xXfxXN8jR
	 fufrd2hSQpWumVixYee1V7twKMy6/3P0o5tQU9295CPHeuGgL8/js8ueImGhAn9Cbd
	 Wi2GelitNgBmzj3rAICqPPTgBrFjAqiB4n5Ygh9s6oDQJe3IuBDp4fdFo5gXrE43kE
	 4B2yxhpVwFsgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next] can: bcm: mark intentional lockless read of
 bo->bound for KCSAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260601181915.71862-1-socketcan@hartkopp.net>
References: <20260601181915.71862-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:51:38 +0000
Message-Id: <20260609185138.E76CE1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7790-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C8B76636D0

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless TOCTOU race in bcm_sendmsg() leads to unintended Global C=
AN Filter Leak.
--

commit 7f7ce41fd35425d40c8342127156c8195ff2363e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: mark intentional lockless read of bo->bound for KCSAN

The commit marks the lockless read of bo->bound in bcm_sendmsg() and the
corresponding write in bcm_notify() with READ_ONCE() and WRITE_ONCE() to
resolve KCSAN warnings. It asserts this lockless read is functionally safe
and will safely drop downstream operations.

Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x=
_pV3At4g=3Dh1kVEtyhA@mail.gmail.com/

> Once the lock is acquired, any subsequent attempts to configure BCM
> jobs (like RX_SETUP) will safely fail because bcm_notify() has
> already cleared bo->ifindex to 0. While a user-defined ifindex of 0
> is normally a valid feature to listen on "all" CAN interfaces,
> bcm_notify() only triggers for specific real CAN devices. In this
> unregister context, the combination of bound=3D0 and ifindex=3D0 effectiv=
ely
> invalidates the socket binding. This prevents the registration of
> stale CAN filters and drops downstream operations safely without any
> memory corruption or stale state exploitation.

[Severity: High]
Is this description accurate regarding safely failing and preventing the
registration of stale CAN filters?

This is a pre-existing issue, but if bcm_notify() unregisters the device
concurrently, couldn't a race occur where bcm_sendmsg() caches ifindex =3D=
=3D 0
while still observing bo->bound =3D=3D 1?

Since bo->ifindex is a plain read at the top of bcm_sendmsg(), the compiler
can defer it until after the volatile read of bo->bound and the potentially
sleeping memcpy_from_msg().

If this happens, bcm_sendmsg() could observe bo->bound =3D=3D 1, but cache
bo->ifindex =3D=3D 0.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fd9fa072881e2..6c93c57212b49 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1379,7 +1379,8 @@ static int bcm_sendmsg(struct socket *sock, struct =
msghdr *msg, size_t size)
>  	int cfsiz;
>  	int ret; /* read bytes or error codes as return value */
> =20
> -	if (!bo->bound)
> +	/* Lockless fast-path check for bound socket */
> +	if (!READ_ONCE(bo->bound))
>  		return -ENOTCONN;
> =20
>  	/* check for valid message length from userspace */

[Severity: High]
This isn't a bug introduced by this patch, but doesn't bcm_sendmsg() then
pass the cached ifindex =3D=3D 0 to bcm_rx_setup() under the socket lock?

net/can/bcm.c:bcm_sendmsg() {
    ...
    lock_sock(sk);

    switch (msg_head.opcode) {
    ...
    case RX_SETUP:
        ret =3D bcm_rx_setup(&msg_head, msg, ifindex, sk);
        break;
    ...
}

Does bcm_rx_setup() ever re-validate bo->bound while holding the lock?

If it doesn't, wouldn't bcm_rx_setup() interpret ifindex =3D=3D 0 as an exp=
licit
request to listen on all CAN interfaces?

net/can/bcm.c:bcm_rx_setup() {
    ...
    } else
        err =3D can_rx_register(sock_net(sk), NULL, op->can_id,
                              REGMASK(op->can_id),
                              bcm_rx_handler, op, "bcm", sk);
    ...
}

Could this actively register a global filter on an unbound socket, leaking
traffic from all CAN buses into a process that was only authorized to
monitor a specific, now-deleted interface?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601181915.7186=
2-1-socketcan@hartkopp.net?part=3D1

