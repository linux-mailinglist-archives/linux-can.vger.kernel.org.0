Return-Path: <linux-can+bounces-8257-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6AtO3MHUGqQsAIAu9opvQ
	(envelope-from <linux-can+bounces-8257-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:41:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F067357E2
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:41:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B2hE2X1L;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8257-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8257-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84362303A114
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9883CC7FB;
	Thu,  9 Jul 2026 20:35:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F53BB101
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:35:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629352; cv=none; b=mGH2zkRod3mtneaVlbnEH6kY5venVctcNA/qH2zduLca5Ry5ZJFXWYY6IaXiB34vGnzj7irklZgaQjIWCddJuiSI/hS7C22PwKcH5tTZhNWGMDoHLUjyPbfw2qnL3Q8QzNgY+AAGlcBuN4JuPcyzWCuva7OWYB9SAY/4eR1P0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629352; c=relaxed/simple;
	bh=ar6lHWqPRy5SxT2IjSZ5Iqdk1C7YYIQkt9cezq62+ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWEMmciofWq6Sv8ou46qW9mQMXOf3tZzWlBxRIqSIWQIPWydOyJjJD9YMNT8dxogXnpiGf7mf15q0HvGlZjPceiLB9yWz9wDAw9esoyQYPBUxmoHeOxftkJ83F7b3qRf7AX6RkvlJONR6I+FXf9tirf0rMCQBZUpuq+BdzJGRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2hE2X1L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1331F000E9;
	Thu,  9 Jul 2026 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629351;
	bh=KcmmsTDfv3D6VwfU1NsR0rJ++VkLMbwyIpfvQsxBQ0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2hE2X1L7O+hMnchcfxg7Y33fooAkKJCH/HLKhoo5PuMmNZ4UO6+nuKUY9EEgjPra
	 GvhqMJR1fOqgCJC/GB+saZbjYqLl8A6Std36kk1zRZ80xMePAHGJ0zbHoHVCvOtILj
	 VdUU2z+6PBo3RX0SrQYACeaBFUCbjEUWViH/Ann6/XdIUi/RjcBPeWWDzJ9WVO4Li1
	 Chmqh6VQYjIxDvZZrUq5gdAnTJWmmhKR5/D3RPpQwI/gwjRrOf5Jfeuoy5PPtYjPFb
	 HUvMTINRzlhDF3kPxirOBaY2QsuFNUolkvQaD7RGWTpXTdq1ldC9u5A3vF/1aqsAVx
	 HOXyA7pDjLb9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/11] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v12-4-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-4-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:35:50 +0000
Message-Id: <20260709203551.1A1331F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8257-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,hartkopp.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 48F067357E2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsynchronized modification of rx_stamp and rx_ifindex allows conc=
urrent frames to corrupt each other's metadata.
--

--- Patch [4]: [PATCH v12 04/11] can: bcm: fix CAN frame rx/tx statistics -=
--
commit f0713957841f9a5510dbab52a7bc1b9ca16a367e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit addresses a KCSAN-detected data race in bcm_rx_handler() by
converting rx/tx statistics to atomic operations. It also simplifies
overflow handling and resolves a race condition where frames_filtered
could become larger than frames_abs.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -748,24 +767,30 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but does this unsynchronized modification
allow concurrent frames to corrupt each other's metadata?

When a wildcard (ANYDEV) CAN BCM receive operation is configured,
multiple interfaces might receive matching packets simultaneously. Because
op->rx_stamp and op->rx_ifindex are updated outside of
bcm_rx_update_lock, could different CPUs concurrently overwrite these
fields?

If so, this might result in userspace receiving packets with mismatched
timestamps and source interface indices, potentially causing logic errors
in routing or packet processing.

> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> -	 */
> +	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D4

