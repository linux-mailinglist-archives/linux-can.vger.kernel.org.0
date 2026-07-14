Return-Path: <linux-can+bounces-8413-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vKKsJGIiVmrxzgAAu9opvQ
	(envelope-from <linux-can+bounces-8413-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:49:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB77541A1
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:49:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fw0snYTh;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8413-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8413-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BCA93037981
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48EC3AB5B7;
	Tue, 14 Jul 2026 11:45:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE613B6C18
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:45:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029503; cv=none; b=fHoL9+G4F3Bg1VBatqu5A5lL9/cRdbpDZvHsfY3jaJ/NXjKFmuJEG/9YS8hIYEZPkXtTK9jZPDpRgbtljxvuSdcrXbIe7E5Bz2hTud2xomMpTMMIrVR6HCgr2Rwot4bOuvifYArJRqamuKOlUiSn/RysNoSubgbcISvhOJZh+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029503; c=relaxed/simple;
	bh=GPh5bY9C+fY63c//cdoHv9Z10sPus/3GzEfGjKt5p+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KW7eLZArCLbcBsuHo2lGiNSY+kspZocjYknuhV4NSaid1746YyOBxhJg4V3sO8zNj0oCH0emlh120HftkpmNaw05i4qjczWsIqVStIgpOd4Z5S9seUSyMAFEpqbCc80Zn1tu6xYS677ihJh3tC1FHPVMyOcFVwXJ26oiiMz1WLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw0snYTh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA7E1F01560;
	Tue, 14 Jul 2026 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029501;
	bh=xmrH7P8LfGrouwP3GF9vTaQZe5ht0ydslcJAx3tQvaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fw0snYThlafChVVY0/1hiJkRUsJWXcpOY5jyXrLZPF5CZfwWC6+Us9AoixGGNPGA1
	 rcfkVCpC5hxJqdUs+rn1CAlZ1LCMWN/2p55a1ieHp+jaamh6JSXdMhMsrPOXC5OqTx
	 68954/1Ps6JNRSwiB4KVNcNRCUlY+QG+2I/Xz2ViuDDDUcufmFO+knKopTO/kKu4RE
	 z+Qfas11dzUHiTBYeRQfU2u6Kcv292A+5vIAmkA5HCHbrR6Kc8Du8KIEhpkVi7dU9S
	 xg0RYmrktEaGBGXhbUrK0COBJdjgCQ2LDbV0KExtrLBExWD4YF+4zddvjpQbGVzC5K
	 8G/9MidcD15kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/11] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260714-bcm_fixes-v14-4-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
 <20260714-bcm_fixes-v14-4-867a4be60a61@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:45:00 +0000
Message-Id: <20260714114500.EFA7E1F01560@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8413-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33DB77541A1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent updates to `op->rx_stamp` and `op->rx_ifindex` outside =
of `bcm_rx_update_lock` lead to torn writes and mismatched metadata being d=
elivered to user space.
--

--- Patch [4]: [PATCH v14 04/11] can: bcm: fix CAN frame rx/tx statistics -=
--
commit 1507f4edb289e7819b879095be4c4c84a3b1f750
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit addresses KCSAN-detected data races in bcm_rx_handler() by
using atomic operations for rx/tx statistics. It also restructures the
critical sections under bcm_rx_update_lock to prevent frames_filtered from
ever incorrectly exceeding frames_abs during concurrent updates.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..38c3f690c1cd0 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -748,24 +767,30 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;
> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> -	 */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: High]
This is a pre-existing issue, but since this patch focuses on fixing
concurrent data races in bcm_rx_handler(), should these metadata fields
be moved inside the bcm_rx_update_lock as well?

If two CAN frames matching the same ANYDEV filter arrive concurrently on
different interfaces, could CPU2 overwrite op->rx_ifindex before CPU1
acquires the lock?

If CPU1 subsequently reads op->rx_ifindex inside bcm_send_to_user(), would
it attach CPU2's interface index to CPU1's CAN frame, delivering mismatched
metadata to user space?

Additionally, on 32-bit systems, could concurrent unprotected writes to the
64-bit ktime_t op->rx_stamp result in torn writes and corrupted timestamps?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v14-0-867a4be60a61@hartkopp.net?part=3D4

