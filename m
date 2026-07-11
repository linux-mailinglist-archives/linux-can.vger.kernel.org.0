Return-Path: <linux-can+bounces-8326-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6iAjB3c0UmpwNAMAu9opvQ
	(envelope-from <linux-can+bounces-8326-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:17:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E27417C3
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:17:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dePNGWmx;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8326-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8326-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC66300D96F
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F3B34E766;
	Sat, 11 Jul 2026 12:17:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF21E5B63
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:17:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772275; cv=none; b=mk6B+vWKX3+GU16GDI+EwemVn+36xiF0t0Up7baH9+vupqwmrceJDk6gQZdsYH4IJ6qaQz4pRhDxWSysT1yzdfPAXXBT87U8OUT4U771YsJUfcIEvAnL/TDI2rp3neq9UXPljSNkk04AYvJftWsKFZOUClnM0bUe5GHGfejA+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772275; c=relaxed/simple;
	bh=ZH7GQRSEyEkGJvGjk3R+WeH1h6i7SwBlPWWBtsAsB0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cJUxtbRP+qrhZ6yBk/ddb67WAh+mWoELi5l5J4pG1HAk3Gl8dbjH21se283lRNdQDA6jtOIoXD9CQxP47kpXVw+iEpSL3LmZfRURsaioZkPefa9WRaahxBlKw6TPDqL08Gk4FeURwMZZa7QnBrtUGS9cZTngYOhUSRCOX4tyqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dePNGWmx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D091F000E9;
	Sat, 11 Jul 2026 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783772274;
	bh=Ze51f2jJGxSfBE9hthKPRWYQPXt99M4s30uLnVz3/5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dePNGWmx38w8c6rddrNzCB85OlzqNdrnN4mW2hAUMGx30Nnj7zlH0UVcHSYIyUKrh
	 JLFLubtV7D88nvflN/TOMeRrQVXAOkWn4tHqSsyiRU5qCjmAE6aODQ9Nms4L+6EKWg
	 2x0DdV44q456lSOEppdxgQQi95r44/KDJPHwvKmisqmFb61Y8iLDSkyNfTNU83n0wY
	 h6y02pMVhD9k+qbRExApImr5rFe9dQ2qV/jcwsYCtGUhWozgTHBgLjDi9Zhr0VB8+z
	 4KZ1+uWuV1b/7YrKE8He8qmxQ1PIndgqbP5suXVM0MhUz1XiPm3NbMyewXEAjHtTth
	 xtuJRhwB2r8Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] can: isotp: fix state machine corruption on
 signal interruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260711-isotp-fixes-v7-5-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
 <20260711-isotp-fixes-v7-5-f03af24d8397@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 12:17:53 +0000
Message-Id: <20260711121754.07D091F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8326-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:email,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 504E27417C3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional timer cancellation in abort paths and lockless softi=
rq handlers can inadvertently cancel a concurrent transmission's timers, ca=
using a permanent stall.
--

--- Patch [5]: [PATCH v7 5/5] can: isotp: fix state machine corruption on s=
ignal interruption ---
commit 0650cd1b992a580e80131b223aa61fb92013fdb6
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix state machine corruption on signal interruption

If a thread blocked in isotp_sendmsg() waiting for a previous transfer
to finish is interrupted by a signal, jumping to the cleanup labels
incorrectly cancels active timers and forces 'so->tx.state' back to
ISOTP_IDLE. This commit returns the error directly instead of jumping
to err_event_drop.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index fdb2109d7c27e..c9cd78df3a6e7 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1019,7 +1019,7 @@ static int isotp_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  		/* wait for complete transmission of current pdu */
>  		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_I=
DLE);
>  		if (err)
> -			goto err_event_drop;
> +			return err;
>  	}
> =20
>  	/* new transfer: bump generation and drop any echo tag left behind

[Severity: High]
This isn't a bug introduced by this patch, but does the same problem exist
later in isotp_sendmsg() when wait_tx_done is true?

net/can/isotp.c:isotp_sendmsg() {
...
	if (wait_tx_done) {
		/* wait for complete transmission of current pdu */
		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_IDLE=
);
		if (err)
			goto err_event_drop;

		err =3D sock_error(sk);
...
}

If a signal interrupts this second wait_event_interruptible() loop, it jumps
to err_event_drop, which unconditionally cancels timers before verifying
tx_gen ownership.

Additionally, is there a similar race window in the softirq handlers?
In isotp_rcv_fc() and isotp_rcv_echo(), the timer is unconditionally
cancelled after a lockless state check:

net/can/isotp.c:isotp_rcv_fc() {
...
	if (so->tx.state !=3D ISOTP_WAIT_FC &&
	    so->tx.state !=3D ISOTP_WAIT_FIRST_FC)
		return 0;

	hrtimer_cancel(&so->txtimer);
...
}

If the softirq checks the state but is preempted or delayed before calling
hrtimer_cancel(), could a concurrent new transfer start and have its timer
wrongfully cancelled, causing a permanent stall of the socket?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-isotp-fixe=
s-v7-0-f03af24d8397@hartkopp.net?part=3D5

