Return-Path: <linux-can+bounces-8037-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ipHXNmC8TGrBowEAu9opvQ
	(envelope-from <linux-can+bounces-8037-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:44:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C211C719479
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:44:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B4Zs0E2X;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8037-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8037-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A2DD30015AF
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A6320CD9;
	Tue,  7 Jul 2026 08:37:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293F222D7A9
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:37:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413435; cv=none; b=UQyGDjSszHKPrhTZJ2IPzT6xWQS4wOXwf3ljnZF/mQEiYgRhQXyUvloPWWvFllZYTT7g+Ab2KXgp7p+lfdtej8H604cMEjsE02qbVirZM0oLbh7s2dFTsZui3sBVhSEEo3VH7e6yO5Pi6WZbTLTWUkD2q1VeVi0VoqYs6Pfnz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413435; c=relaxed/simple;
	bh=3AhsJCTycbD2pZpBs8wjfwaJVm3VD++H9iYkttSQm+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fExLKGbV2bABsyLDLxH83zsLfTDQSJXlYMrqnx9vyOCfOzK9dV6kU3l7ywUZL763N1wv3xW+VqV/vSrp+dzr76qDv2sL3kLGB0edjeSNHS8mr2tikb8XUsMsl6G3fERCrjPz0UaAFpXC/9hXEO1s0PzZ+hC4cnoNLKhpLyF6uhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Zs0E2X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8561F000E9;
	Tue,  7 Jul 2026 08:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783413433;
	bh=FlHiWiD6R9IelqhKbJIYMDd9a3RvOhhf9p3iUlcNZ44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4Zs0E2XkLQoYByL9kCI121MXjYMeD53tNdx27SxxQjsOXFlih/XbWQXLslzQqov1
	 ZUP5vO6JhUR7eWWhDCli4pLk1Y05yMmRe+QSe4OuuwGx4cPKOtvkPUgyXP95TDZFQe
	 XtglhqvW5QM4LlvWoPKVsxdCYL0pIKt3ZQVpLJJDnQdnAopvJrkOaJhP84BTvA9xwv
	 DTEBqRtPofwCT6yxW3mfKLWMP2sit+eGZfyYiLNMSWNZnf8JvCGjnD3AEHDPMFfmRq
	 MxuTRaP2HL+tsT2pIVgkdFvbTd34gXKU/J+OdW7Y2BC4k9VQiGuw3UG6OehWP41QFm
	 w5HfkHwtrEnDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260707-bcm_fixes-v2-4-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-4-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:37:13 +0000
Message-Id: <20260707083713.8A8561F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8037-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C211C719479

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of bcm_rx_handler() leads to unprotected data=
 races and potential 64-bit torn writes on op->rx_stamp and op->rx_ifindex,=
 causing metadata corruption.
--

--- Patch [4]: [PATCH v2 4/6] can: bcm: fix CAN frame rx/tx statistics ---
commit c40daefa12b560d84d208b978162b5b62f34aade
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit fixes a KCSAN-detected data race in bcm_rx_handler() when multi=
ple
CAN frames are processed concurrently. It transitions the statistics counte=
rs
to atomic long operations and consolidates overflow checking into a new
bcm_update_stats() function.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -742,7 +752,7 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but can concurrent execution of bcm_rx_handle=
r()
lead to unprotected data races on op->rx_stamp and op->rx_ifindex here?

If an application creates a BCM socket listening on all interfaces (ifindex=
=3D0),
and multiple CAN frames arrive concurrently from different interfaces match=
ing
the same bcm_op, bcm_rx_handler() can be invoked concurrently on multiple C=
PUs.

CPU A and CPU B could both write op->rx_stamp and op->rx_ifindex outside of
any lock. If CPU A then acquires the lock and reads these values later in
bcm_send_to_user():

net/can/bcm.c:bcm_send_to_user() {
    ...
		/* restore rx timestamp */
		skb->tstamp =3D op->rx_stamp;
    ...
	addr->can_ifindex =3D op->rx_ifindex;
    ...
}

Could CPU A pick up CPU B's ifindex or a torn timestamp? This might lead to
CAN frames being delivered to userspace with mismatched interface indices or
corrupted 64-bit timestamps on 32-bit systems, potentially breaking
time-sensitive control loops.

>  	/* update statistics */
> -	op->frames_abs++;
> +	bcm_update_stats(op);
> =20
>  	/* snapshot the flag under lock: op->flags/op->frames may be updated
>  	 * concurrently by bcm_rx_setup(). Do not call bcm_can_tx() while

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D4

