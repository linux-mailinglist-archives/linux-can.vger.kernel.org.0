Return-Path: <linux-can+bounces-8004-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nQGgBdINS2psLQEAu9opvQ
	(envelope-from <linux-can+bounces-8004-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 04:07:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB370C058
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 04:07:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CzypvMY6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8004-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8004-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78632303F179
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 02:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC6371049;
	Mon,  6 Jul 2026 02:03:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E637BE7D
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 02:03:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303406; cv=none; b=uS/RjauksGVSnjzlRb88nqZw1f8TuiLnThlfriG/Axds6fpZyBvf9Vt/BfWhTtxDR574wNCkcERmbFoGaiezP6l/cVRpOGP6JZzW3X9HQYQt0hM9Ki6L9IvFGCihkMlkqSR4ZiC6Bho1iNHim3ZGC9ajvTP7ImUtz2UNG3k5QaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303406; c=relaxed/simple;
	bh=b6rRuQpLaHH5hvgAP3hzMsPhGKv1cnyiTgi1iLZxKmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPnh4vJqoOMpIRMrCz9BCbyQlIF+dfCtaTP+siwYwtf+UxIdwWvKpki+5EE4/Qh+kBjPhNayl2AxhQ4/akrZaQxP6+L4EuIyBKzHFhQSO83zAjCvh9gwH8KQSpZL175f/hMGgPjyzbZJS2AXOkC9T7f9yihA23kf5z+7p23Pnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzypvMY6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0DA1F000E9;
	Mon,  6 Jul 2026 02:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303405;
	bh=oMnRV6hah1q5gFtTTO8m5XJfWdQVKOC5oCfcQ6WwTZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzypvMY6aQUin6ITTNglglhMxO5hvVhPt2AL2I4GRW0PLNOriGw9gbvP4dihSCj3u
	 lpJbisKVYVmImemuPIGd65tCeVmuNRhrsG7G2LMkjGy6GTcpPrGI8NlOgyIWoaT778
	 fQFQ7iQNdkq+6WunPi7RvuEdAgG6zHtEsIytgtFUDzC43LbCurlSjJWLrAjWpKgwqe
	 BiI3PWE4Wy2yNzfP8qrdQx3hNg7ce9JCTwezEdITjKjFHsILjL23nhBS0UMDMMuFZS
	 FpKFBBz/wFd7Ta9nAaQH2d2Gj69pPft6gs4KiMlwHzCnEeO2C4d2+kya9Z5gofn1xu
	 CLqg4EYbHOAvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] can: usb: etas_es58x: Fix RX buffer leak on URB
 resubmit failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260706014601.415445-1-lgs201920130244@gmail.com>
References: <20260706014601.415445-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:03:22 +0000
Message-Id: <20260706020323.8C0DA1F000E9@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-8004-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
X-Rspamd-Queue-Id: 17FB370C058

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The TX URB is accessed after it is freed when es58x_submit_urb() f=
ails, leading to a double free and Use-After-Free.
- [High] usb_free_coherent() is called from an URB completion handler (atom=
ic context), violating IRQ context safety rules.
--

commit fe545bd17f0a8dbd30c2399351f0a4beb7cf3f76
Author: Guangshuo Li <lgs201920130244@gmail.com>

can: usb: etas_es58x: Fix RX buffer leak on URB resubmit failure

es58x_read_bulk_callback() resubmits the RX URB after processing a
received packet. If the resubmit succeeds, the URB remains anchored and
will be handled by the normal RX path or by teardown.

> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/ca=
n/usb/etas_es58x/es58x_core.c
> index b259f61098083..e1724ae79c5a1 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -1476,7 +1476,6 @@ static void es58x_read_bulk_callback(struct urb *ur=
b)
>  		dev_err_ratelimited(dev,
>  				    "Failed resubmitting read bulk urb: %pe\n",
>  				    ERR_PTR(ret));
> -	return;
> =20
>   free_urb:
>  	usb_free_coherent(urb->dev, urb->transfer_buffer_length,

[Severity: High]
This is a pre-existing issue, but does removing this return statement expan=
d a=20
bug where usb_free_coherent() is called from an URB completion handler?

es58x_read_bulk_callback() executes in atomic context. usb_free_coherent()
wraps dma_free_coherent() which may sleep on some architectures when unmapp=
ing
memory.=20

Can this cause a "BUG: scheduling while atomic" panic during RX resubmit
failure?

[Severity: High]
This isn't a bug introduced by this patch, but does the transmit error path=
 have=20
a double free when es58x_submit_urb() fails?

If usb_submit_urb() fails during packet transmission:

drivers/net/can/usb/etas_es58x/es58x_core.c:es58x_submit_urb() {
	...
	usb_unanchor_urb(urb);
	...
	usb_free_urb(urb);
}

The pointer is only set to NULL on success, leaving it dangling on failure:

drivers/net/can/usb/etas_es58x/es58x_core.c:es58x_xmit_commit() {
	...
	ret =3D es58x_submit_urb(priv->es58x_dev, priv->tx_urb, netdev);
	if (ret =3D=3D 0)
		priv->tx_urb =3D NULL;
}

Then es58x_start_xmit() jumps to xmit_failure and calls=20
es58x_flush_pending_tx_msg(), which uses the dangling pointer:

drivers/net/can/usb/etas_es58x/es58x_core.c:es58x_flush_pending_tx_msg() {
	...
	usb_anchor_urb(priv->tx_urb, &priv->es58x_dev->tx_urbs_idle);
	...
	usb_free_urb(priv->tx_urb);
}

Can this lead to a use-after-free and memory corruption?

>  			  urb->transfer_buffer, urb->transfer_dma);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014601.4154=
45-1-lgs201920130244@gmail.com?part=3D1

