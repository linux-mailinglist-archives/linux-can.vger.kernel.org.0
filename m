Return-Path: <linux-can+bounces-7923-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NuLXFZfPQ2rWiwoAu9opvQ
	(envelope-from <linux-can+bounces-7923-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:15:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D76E54BC
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:15:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XHiQRwYS;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7923-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7923-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B762D3112BF8
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3613F788D;
	Tue, 30 Jun 2026 14:06:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8637187B
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 14:06:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828391; cv=none; b=P4AM+I7pciKLv8Xs12eId/GEbbWAgaxSFWWUAhs8OVStzrxgRu8acuumjLIoOC9t3S9m4akbKBKhaj/YuMiNjCewfTOgiAXr8u3AKClwhVzXc0iI7RLSzPAW72AhhqZwjpaSG9Qb8uMjYGtn2D5iamw7K3l7YOMIaaAMVe6RJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828391; c=relaxed/simple;
	bh=9z7h++GiPXAwJrdJKNDyjU4L1ae9M/fTOkcW3k9fRgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyc8MbtneO4ICOjnLejPUWyEXQo07wDlJurZflJdHDMMx0U2xYSsrJMxeAnqb/5qpLDf0eY/tOYT0ZngFiQNCilzyZbr6GHMdJp1gf9/qBqC2vYgkwo8p0TBF+6cu8E7Tbw1M86Ga0BEvMjOJC6uNFEtT+I9PqLtk2QaBK1Pytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHiQRwYS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5065C1F00A3A;
	Tue, 30 Jun 2026 14:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782828389;
	bh=vTxDjnGV0gACVf171wIVgEHNw3wvryUkv4Xe8/+PT08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XHiQRwYSQiGxCVyPIe4OlvO4FfKF3KQI2g121t78fTZ39cGWMHTZLAE6cIlIJZEBN
	 KpV4mCWPmgudRSjFuIzGNY0TvImZoHdEXgTpanXPeDh0rMEXFzCWGzN+EaqobBq/UX
	 7sR5bAJRFO/p2yfoo0wWv5nj/Q/9hX0KhPHAEvVBy1iywil/rFJns56zqlO10ldMa7
	 VS8NxDiUapQuiJjh9dcE1j+Gult7W26g94Rw0y/CGzIM1ykdNkbUTglsp2OXPdzhwn
	 juQ8F6djpPtQt85GoZOUYGcmk0RVmi21eV6wdfBJG5IQCHJ9sB3CknVUm5HIXGBg7Z
	 LAICJjvl2wqKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] can: rcar_canfd: Fix double-cleanup and unclocked
 register access on init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, wsa+renesas@sang-engineering.com, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260630135119.104774-3-biju.das.jz@bp.renesas.com>
References: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
 <20260630135119.104774-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:06:28 +0000
Message-Id: <20260630140629.5065C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7923-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:wsa+renesas@sang-engineering.com,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:bijudasau@gmail.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,renesas.com:email,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 996D76E54BC

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Use-after-free read on the error path of rcar_canfd_channel_probe(=
).
- [High] The CAN network device is registered and exposed to userspace befo=
re its global and shared interrupts are requested, introducing a race condi=
tion.

Pre-existing issues:
- [High] Use-After-Free vulnerability in error and removal paths due to mis=
matched devm-managed interrupt lifetimes and dangling pointers.
- [High] Incorrect clearing of W0C (Write-0-To-Clear) hardware status regis=
ters can silently drop concurrent interrupts.
--

commit a601711f6b0c8a2b4d0262288f6d110cc98b8332
Author: Biju Das <biju.das.jz@bp.renesas.com>

can: rcar_canfd: Fix double-cleanup and unclocked register access on init f=
ailure

In rcar_canfd_probe(), if rcar_canfd_global_init() encounters an error,
it disables the clocks and asserts the resets before returning. However,
the probe function then jumps to the fail_mode label and unconditionally
calls rcar_canfd_global_deinit(), which writes to hardware registers and
causes a synchronous external abort. This commit makes the failure path
jump directly to fail_dev, skipping the redundant global_deinit() call.

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 5aafbab85da67..1f3dc4b354f87 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2257,7 +2257,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
> =20
>  	err =3D rcar_canfd_global_init(gpriv);
>  	if (err)
> -		goto fail_mode;
> +		goto fail_dev;
> =20
>  	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {

[Severity: High]
Could this code expose the network interface to userspace before its interr=
upts
are fully set up?

The loop registers the channels via rcar_canfd_channel_probe(), which calls
register_candev(). However, the shared global interrupts (ch_irq, g_irq) are
not requested via devm_request_irq() until after the channel loop completes.

If a userspace process (e.g., systemd-networkd) brings the interface UP
immediately upon registration, could rcar_canfd_open() start the hardware a=
nd
enable interrupts before the OS has registered the IRQ handlers, leading to
unhandled interrupts?

>  		err =3D rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
>  					       transceivers[ch]);
[ ... ]
> @@ -2275,7 +2275,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
>  fail_channel:
>  	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
>  		rcar_canfd_channel_remove(gpriv, ch);

[Severity: High]
This is a pre-existing issue, but is there a use-after-free vulnerability
here due to mismatched interrupt lifetimes?

When rcar_canfd_channel_remove() frees the network device and its inline
private data priv via free_candev(priv->ndev), the devm_request_irq()
shared interrupt handlers remain active until devres cleanup runs after
probe() or remove() returns.

If a shared interrupt fires during this window, wouldn't the handler
(e.g., rcar_canfd_global_interrupt()) execute and unconditionally
dereference gpriv->ch[ch]->base, accessing the freed priv memory?

> -fail_mode:
> +
>  	rcar_canfd_global_deinit(gpriv, false);
>  fail_dev:
>  	return err;


I also noticed a few other issues in this file:

[Severity: High]
This is a pre-existing issue, but won't the driver incorrectly clear
W0C (Write-0-To-Clear) hardware status registers?

In functions like rcar_canfd_tx_done(), rcar_canfd_rx_poll(), and
rcar_canfd_global_error(), the driver reads the status register into sts
and writes back sts & ~FLAG:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_tx_done() {
    ...
    rcar_canfd_write(priv->base, RCANFD_CFSTS(gpriv, ch, RCANFD_CFFIFO_IDX),
                     sts & ~RCANFD_CFSTS_CFTXIF);
    ...
}

Because this bitwise operation leaves 0s in bit positions that were
originally 0, won't writing 0 inadvertently clear any flag that was
asserted by the hardware after the register was initially read, leading to
silent loss of hardware interrupts and dropped packets?


[Severity: High]
Is there a use-after-free read in the error path of rcar_canfd_channel_prob=
e()?

When device registration fails, the error path calls free_candev(ndev)
which frees the net_device and its inline private data priv:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe() {
    ...
fail:
	free_candev(ndev);
	gpriv->ch[priv->channel] =3D NULL;
	return err;
}

Immediately following the free, the code attempts to nullify the global
pointer array using priv->channel. Since priv has already been freed,
isn't this a use-after-free read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630135119.1047=
74-1-biju.das.jz@bp.renesas.com?part=3D2

