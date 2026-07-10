Return-Path: <linux-can+bounces-8306-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6vR1NsAoUWrXAAMAu9opvQ
	(envelope-from <linux-can+bounces-8306-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 19:15:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F19473CF8B
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 19:15:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=olkOuiQn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8306-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8306-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2EA130BA2B3
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1743B3FA;
	Fri, 10 Jul 2026 17:02:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCF43B3CE
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 17:02:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702963; cv=none; b=sKaYtukcDBiHqMY0BjTmkza5e6xWmA840VHatE3eBtObvHHJ8XC6cY4F3k7RATAsy4t/8cvlmXFSsTE5MUx57+PkDpDn24hmTQGOo84n8rVrYHkqw6ijVOzDou1wItUymcvi4FM9lY2P25JBvBrGeasCGokzQDQWmyioVa9kNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702963; c=relaxed/simple;
	bh=dDAFoM9UBxg7+NpyjCNSJpYJC5J6JNb6f4go4902hMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TEFQBlII0FKof64zWajZq8bv0UQFzCpuZq69zfE4CDcddr5kwV1pg13ylGd0sN3VFmu6Y+Tk9NVPTpSINw7JsV2o0hbyjxd1ixRatLFICCBRw73jPyO4fDBeDmJLEKgxm57mf2TyOGIByQjZ6+BY7OYgmgy5ZrgV12GzpIpHGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olkOuiQn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FAD1F00A3A;
	Fri, 10 Jul 2026 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702961;
	bh=H8L6R3rWdLsQ4GbYxp0/cF5SuQnKeZUDKK7G9kRT+bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olkOuiQnt81MmaXPYFFDzD+dxJ8BbF7INnrPKslhALxfF5SWQJdE5Qj27jH6eMihF
	 BFQPtchllQg9Nu+ho098RIGOyzhTtgDO8tfJ4yhhrq1X1S4V5Vnt5+6a2GoGtqjZP/
	 HEJ1LPBcurDmDcVyXzAtPHjUitTzUQ5tXFrEd15Ry1nR93gmD0EdJ6hhcUn3eB+9f4
	 GCOulW29Qe4ObPKrkf7fW837lMgENRmaeL6TKJwyUAQMSGhM6hmodRLJaADOGRMuwF
	 VsflS3EMn3jaV/tWuEDzuwD6X7U0NcUwzJDTexsq/RdI2QdxpHjWhNGivpx41nq0G7
	 VOFUTJzs4jFBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] can: isotp: fix race between RX timer and
 consecutive frame reception
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260710-isotp-fixes-v5-3-15174d82d6f1@hartkopp.net>
References: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
 <20260710-isotp-fixes-v5-3-15174d82d6f1@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:02:40 +0000
Message-Id: <20260710170241.60FAD1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8306-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 3F19473CF8B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing state validation after hrtimer_cancel in the TX path allow=
s resurrection of aborted transmissions and state machine corruption.
--

--- Patch [3]: [PATCH v5 3/4] can: isotp: fix race between RX timer and con=
secutive frame reception ---
commit 8ee7739c2adf82e961ff6ad45d8c572723ba74e7
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix race between RX timer and consecutive frame reception

When receiving a Consecutive Frame (CF), hrtimer_cancel() is called to stop
the RX timer. The patch verifies that the state is still ISOTP_WAIT_DATA af=
ter
canceling the hrtimer to avoid state machine corruption.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index e7597ca3e140b..c0edbd35516cc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -577,6 +577,14 @@ static int isotp_rcv_cf(struct sock *sk, struct canf=
d_frame *cf, int ae,
> =20
>  	hrtimer_cancel(&so->rxtimer);
> =20
> +	/* isotp_rx_timer_handler() may have raced us for so->rx.state
> +	 * while hrtimer_cancel() above waited for it to finish, already
> +	 * reporting ETIMEDOUT and resetting the reception; don't process
> +	 * this CF into a reassembly that has already been given up on.
> +	 */
> +	if (so->rx.state !=3D ISOTP_WAIT_DATA)
> +		return 1;
> +

[Severity: High]
This is a pre-existing issue, but does a similar race condition exist in the
TX paths?

Looking at isotp_rcv_fc(), we call hrtimer_cancel() on the txtimer without
validating the TX state afterwards:

net/can/isotp.c:isotp_rcv_fc() {
    ...
    hrtimer_cancel(&so->txtimer);

    if ((cf->len < ae + FC_CONTENT_SZ) ||
    ...
}

Similarly in isotp_rcv_echo():

net/can/isotp.c:isotp_rcv_echo() {
    ...
    /* cancel local echo timeout */
    hrtimer_cancel(&so->txtimer);

    /* local echo skb with consecutive frame has been consumed */
    so->cfecho =3D 0;
    ...
}

If a flow control or echo CAN frame is received at the exact same time the
TX timer expires, could isotp_rcv_fc() or isotp_rcv_echo() block in
hrtimer_cancel() waiting for isotp_tx_timer_handler() to finish?

If the timer handler sets so->tx.state =3D ISOTP_IDLE and fails the socket,
could the receiver functions then blindly resume the transmission,
potentially resurrecting an aborted transfer and corrupting the state
machine?

Furthermore, since the state would briefly be ISOTP_IDLE, might a concurrent
sendmsg() succeed, resulting in two threads concurrently modifying the TX
buffer and state?

>  	/* CFs are never longer than the FF */
>  	if (cf->len > so->rx.ll_dl)
>  		return 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v5-0-15174d82d6f1@hartkopp.net?part=3D3

