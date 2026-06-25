Return-Path: <linux-can+bounces-7899-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id az43H+JRPWoL1QgAu9opvQ
	(envelope-from <linux-can+bounces-7899-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 18:05:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933B6C74AD
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 18:05:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gJiZ9CRQ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7899-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7899-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0424309B871
	for <lists+linux-can@lfdr.de>; Thu, 25 Jun 2026 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA33E63A4;
	Thu, 25 Jun 2026 16:03:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD537C0FB
	for <linux-can@vger.kernel.org>; Thu, 25 Jun 2026 16:03:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403436; cv=none; b=RUZnMXrYBo4yAHmlTen8wuBSaIpFbBtTHrDGBQiCStvXLehE3UsnXn6/kUPXfBGNLgvvuRht8wp2uBSqy1fQCGsyuFfLuhlcY2n7MW4vtLKwCRpfM99XYL26sG+wyWyW5PDxCywsOZixdhKRK5+JVNomVcfkhq+285O2GBvKRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403436; c=relaxed/simple;
	bh=tCMuj8DHu49R2IVDlXUjYHBM7OM66HS7CvZXulw0690=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dfrDaMu5b5RnnDlz4aBxUSIWQx++bsoNueAIUPWyMD0wmFo0hDhlFv7UNerwlyPmPTBLV9qr5zvomSdMyJhq+f90G1VgBH4ZINbLhOizb8dvuSrKYGvNMlFIyJ22U9TOICzWZB2FR77Rte+nNHHX0ooQh6hZCPa/304VPM+Lbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJiZ9CRQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7947D1F00A3A;
	Thu, 25 Jun 2026 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782403430;
	bh=AQwkTbFiHZrywJEmkCnZkD01L7XZHl7sU1BPuwp1rcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJiZ9CRQbmf1q/X0gx/YEN4UU+6eJ/4tKOtUqIUeLEMfNdTsnNXYNsxUHLbkJcjYK
	 +eNHmbT3n0ZV4ECfZrDt0VqPWuPoo6w1z4tuoicC6m56HOPogLE7HF/7BzDXKf5KtC
	 NvpRaeL4uUKxm2nztmM4xuAFFh32Eg+WQTaJXGO2qtGskLT5/p83iUh6A0fIZio3Q4
	 QyCITCuMJ5p5Wih2xS0uqtI2Ogc9Y5NpUwpeMuZ1f5Mz0i9IgCLFOB4+0igMU8dF1h
	 jDes3E/UBOB6/wUZZHl+PlSc1z9Rd89MrHO6VuU01ILGLDXh/aPcCKs1dPifUPgYWD
	 R4DBV+GSVXG7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: rcar_canfd: Change the initializing flow for
 clocks and resets
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 16:03:49 +0000
Message-Id: <20260625160350.7947D1F00A3A@smtp.kernel.org>
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
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7899-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:bijudasau@gmail.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1933B6C74AD

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double-cleanup and unclocked register access on initialization fai=
lure in `rcar_canfd_probe()`.
- [High] Premature registration of global interrupt handlers causes NULL po=
inter dereference and unclocked register access.
- [High] Dangling pointer in the global state array leads to a double free =
on channel probe failure.
- [High] Mismatch between `devm_request_irq` and manual memory freeing caus=
es use-after-free.
--

commit 6b6a83169ac0a7297a4dc2c78e16dd98f4f2ed0f
Author: Tu Nguyen <tu.nguyen.xg@renesas.com>

can: rcar_canfd: Change the initializing flow for clocks and resets

This patch updates the initialization order for clocks and resets in the
rcar_canfd driver to match the hardware manual for RZ/G2L and RZ/G3E.
It ensures clocks are enabled before deasserting resets, and updates the
teardown path to mirror the new sequence.

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index eaf8cac780387..fcc37b73ed436 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
[ ... ]
> @@ -2090,10 +2090,10 @@ static void rcar_canfd_global_deinit(struct rcar_=
canfd_global *gpriv, bool full)
>  		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
>  	}
> =20
> -	clk_disable_unprepare(gpriv->clk_ram);
> -	clk_disable_unprepare(gpriv->clkp);
>  	reset_control_assert(gpriv->rstc2);
>  	reset_control_assert(gpriv->rstc1);
> +	clk_disable_unprepare(gpriv->clk_ram);
> +	clk_disable_unprepare(gpriv->clkp);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing=20
potential double-cleanup and unclocked register access on initialization=20
failure.

In rcar_canfd_probe(), if rcar_canfd_global_init() encounters an error,=20
it disables the clocks and asserts the resets before returning. However,=20
the probe function then jumps to the fail_mode label and unconditionally=20
calls rcar_canfd_global_deinit().=20

The deinit function calls rcar_canfd_disable_global_interrupts(), which=20
writes to the hardware registers. Since the peripheral clock has already=20
been disabled by the failed init, does this write trigger a synchronous=20
external abort or bus fault?

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with=20
interrupt registration order.

In rcar_canfd_probe(), global interrupts are requested via=20
devm_request_irq() before rcar_canfd_global_init() enables the clocks and=20
before the per-channel structures in gpriv->ch[] are allocated.=20

If the interrupt is shared and fires immediately, the handler=20
rcar_canfd_global_err_interrupt() will invoke rcar_canfd_handle_global_err(=
).
This function dereferences priv =3D gpriv->ch[ch], which is currently NULL.
Could this lead to a NULL pointer dereference, as well as an unclocked=20
hardware read?

[Severity: High]
This is a pre-existing issue, but there appears to be a dangling pointer=20
risk on channel probe failure.

In rcar_canfd_channel_probe(), the channel pointer is saved globally via=20
gpriv->ch[priv->channel] =3D priv. If register_candev() fails shortly after=
,=20
the error path uses free_candev(ndev) to release the memory but leaves the=
=20
pointer in the global array.=20

During teardown, rcar_canfd_probe() calls rcar_canfd_channel_remove() for=20
all channels in the mask. Since the dangling pointer still evaluates to tru=
e,=20
will this result in a use-after-free and double free of the memory?

[Severity: High]
This isn't a bug introduced by this patch, but there might be a=20
use-after-free vulnerability with the device-managed IRQs.

In rcar_canfd_channel_probe(), the per-channel interrupt is requested=20
using devm_request_irq() with priv as the callback data. However,=20
rcar_canfd_channel_remove() manually frees the channel structure using=20
free_candev(priv->ndev).=20

Because the devm-managed IRQ is not unregistered until the driver probe or=
=20
remove function completely returns, could an interrupt firing in this=20
teardown window access the freed priv structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625135216.1304=
50-1-biju.das.jz@bp.renesas.com?part=3D1

