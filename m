Return-Path: <linux-can+bounces-8199-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JN2vAN59T2pUiAIAu9opvQ
	(envelope-from <linux-can+bounces-8199-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 12:54:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9072FEB6
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 12:54:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X9KCqtjV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8199-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8199-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06C6A3033883
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117B40D569;
	Thu,  9 Jul 2026 10:50:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140140BCCC
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 10:50:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594234; cv=none; b=qPXtpcbMDxgnMwTxBm5RLF7jR5XgqkftA4IO7pB76qyL9Ku0A3/hjIqumlOGz7wvrgWz98SDNCnVtZnIBiydGnxavn6cbiO9IcDfwVxRwQyVTtkaH1KNmBS57nC/WKQTgt8LHt6dKe7CujXTTplMoTcqr+ROHOsePENHUYlWsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594234; c=relaxed/simple;
	bh=PINTDcYQ1LxUhAAqtvW0bo1+aQnGzT9pwjtupaRg6+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y5Aytl6q6NXAaLNk7tcmEMF1BwOfSd5c5oagi4UtzAj4AHqA1Ogy7pFjK0vXX3aybGVUjsaB/dpu9zKIQ4anyQJIhP8wlQgnlFgaIMXQD0UuUNR/DqMclHcxeB5HCuIRA+XyC/CPB3OtpHbWvQofj5wNjBIgcy4RhqzBwu8NuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9KCqtjV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A39C1F000E9;
	Thu,  9 Jul 2026 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783594231;
	bh=kYiGhsugO65apFC9ugOHXRDGyBO1CzoJVid897b04AE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9KCqtjV3K6OkSbcfOuIIw1E0Gref1qY2xfjRwho+wCevsebioPdFqXBXSwpFlMv2
	 0AxaZN+TeGPCe+tHgVKIkNA45LiHRu2EiGgqjc/UhWdXWiivaRA3c6rAN2Pko4MyuA
	 vo5HICkmgmAEIapN6jRuD+uBRH0JTtbgeDVMnxDpCks6NZqs7uxmhonvYdu+tmJOBo
	 aoq1YtGBo9XQH8pQxVErrx8FRqygPZXJ3o0xB/x5U8Q9DBjke/n8o4Fs9gPw9R+hMT
	 SIIkblOsBsVRgk5ONAiQLn4268KNLtjBW/e+2FdxHE/yaxg8QJ27mn72hZ/3f0/KRy
	 nY10H1BOH6EAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/10] can: bcm: fix data race on
 rx_stamp/rx_ifindex in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v10-10-57fff38e34ce@hartkopp.net>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
 <20260709-bcm_fixes-v10-10-57fff38e34ce@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:50:30 +0000
Message-Id: <20260709105031.1A39C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8199-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,hartkopp.net:email,smtp.kernel.org:mid,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 57E9072FEB6

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Spurious RX_TIMEOUT notification and state corruption due to a rac=
e between concurrent bcm_rx_handler execution and op->timer expiration.
- [High] Throttled multiplex frames share a single metadata store, leading =
to incorrect interface index (rx_ifindex) and timestamps being sent to user=
space.
--

--- Patch [10]: [PATCH v10 10/10] can: bcm: fix data race on rx_stamp/rx_if=
index in bcm_rx_handler() ---
commit d4e0952720604b6c20cb44a753876e69fcdf61ec
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

For an rx op subscribed on all interfaces (ifindex =3D=3D 0), the same op
is registered once in the shared per-netns wildcard filter list, so
bcm_rx_handler() can run concurrently on different CPUs for frames
arriving on different net devices.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fbf1cbb7c99fe..10a883b50fc63 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -779,11 +779,6 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  	/* disable timeout */
>  	hrtimer_cancel(&op->timer);

[Severity: High]
This is a pre-existing issue, but could this lockless cancellation cause
spurious RX_TIMEOUT notifications and state corruption?

If a wildcard receive operation receives two frames concurrently on differe=
nt
CPUs:

CPU1 and CPU2 execute bcm_rx_handler() and both call hrtimer_cancel() outsi=
de
the lock. The timer is not yet running, so both return immediately.

CPU1 acquires op->bcm_rx_update_lock, handles its frame, calls
bcm_rx_starttimer() to arm the timer, and releases the lock.

CPU2 acquires op->bcm_rx_update_lock.

The timer expires and bcm_rx_timeout_handler() starts on CPU3, blocking on
the lock.

CPU2 finishes handling its frame, calls bcm_rx_starttimer() to re-arm, and
releases the lock.

CPU3 acquires the lock, clears op->last_frames via memset(), and
unconditionally sends an RX_TIMEOUT, despite CPU2 having just successfully
received a frame?

> -	/* save rx timestamp */
> -	op->rx_stamp =3D skb->tstamp;
> -	/* save originator for recvfrom() */
> -	op->rx_ifindex =3D skb->dev->ifindex;
> -
>  	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[ ... ]

> @@ -815,6 +810,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  			traffic_flags |=3D RX_OWN;
>  	}
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This isn't a bug introduced by this patch, but does sharing a single metada=
ta
store for throttled multiplex frames lead to incorrect interface indexes and
timestamps being sent to userspace?

If an RX_SETUP operation is created on all interfaces with multiplex filter=
ing
and throttling:

A frame matching multiplex index 1 arrives on can0. op->rx_ifindex becomes
can0 and the throttle timer starts.

A frame matching multiplex index 2 arrives on can1. op->rx_ifindex is
unconditionally overwritten with can1 here.

When the throttle timer expires, bcm_rx_thr_flush() sends both buffered
frames to userspace:

    updated +=3D bcm_rx_do_flush(op, i);

Are both frames then delivered with can_ifindex set to can1 by
bcm_send_to_user(), destroying the origin information of the first frame?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v10-0-57fff38e34ce@hartkopp.net?part=3D10

