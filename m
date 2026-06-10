Return-Path: <linux-can+bounces-7813-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q7U8BqJ0KWp8XAMAu9opvQ
	(envelope-from <linux-can+bounces-7813-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 16:28:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1466A372
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 16:28:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="KEZNJm/H";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7813-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7813-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DA2F304F2FE
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F2334692;
	Wed, 10 Jun 2026 14:27:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B833D4F8;
	Wed, 10 Jun 2026 14:27:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101647; cv=none; b=RwQi6yCWkNw118Ja3SoFuRFLkZ8TEZxODXN2749Smecs9IX98ovApA618FvNg92pkcRCOpvW89I4gWOYSfyAexAuQYRJOWXqF451ssMvgosWUmSOwsh6i4i5XKwldCnsXdtPmiWx2gT7pPIkzny9fdhXJXGzyMuK3XRz807U1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101647; c=relaxed/simple;
	bh=5kuBP7fMBbqE/iet64062XGawrA4JhbZ5hy8hly7DuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m2NI1GN2fOCH3Af0Rx0f4ID+/hmcMczD+Hu9FxJpWTMf0DU5fTmrfuh4v2IMEFVHy2JziWbr/kRig6HxxftVbjxij9gWiWL7FxhVP/51GWA4GbhtF5vU8VJQiI5cMpYOmtyYFLwjS8aZEqlk3G8qC7Pen/w9HAb8jFwQQMK7D5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEZNJm/H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031C31F0089A;
	Wed, 10 Jun 2026 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101645;
	bh=I4K33T+MFgkZ1eCFBa4fDJZ3fDYXQ+2gTF11A6ENEgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEZNJm/HUC25JcxV99QcToXilHwCL6tW3GoQls/NYnc4Vy/AKb8FxwmTMkQinVa+D
	 038LXHRj5EYLngzavVNqSn5hJcHGtQwCsrnG3xeD/gQSvvFmr42w9SSF1SUHB2Z9pj
	 2mddxrkQijJePnvDmV19ZPIGLN194nxakx85oTu0PSno9caVwtFlRwprdMGrL6tcFI
	 RgEZiI8J7EX2sQhcmxxbXjxZgeCEqfQXpDQtBBtVRfWP15tYzOELCybNN3i2msVszI
	 aXYi28eQjlXiKRJvPi6rwfsfTHbBSKlFkb5Il6oIr0r7ZYKxhvWilvUfZHzX5wnKNq
	 gYVkFJn8xUlnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, Frank.Li@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, imx@lists.linux.dev
In-Reply-To: <20260609142139.1563360-6-gerg@linux-m68k.org>
References: <20260609142139.1563360-6-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:27:24 +0000
Message-Id: <20260610142725.031C31F0089A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-7813-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:Frank.Li@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:imx@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0D1466A372

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The transition to asm-generic readX()/writeX() changes the endiann=
ess of ColdFire internal IO accesses, breaking unpatched ColdFire drivers.

Pre-existing issues:
- [High] Undefined behavior when shifting 1 by 32 or more using `BIT(ch)` i=
n `mcf_edma_tx_handler`.
- [High] The error interrupt handler incorrectly skips handling high channe=
ls and returns `IRQ_NONE` after servicing low channels.
--

commit 25193db3eba89f780b6dc534f2f72e16f3429571
Author: Greg Ungerer <gerg@linux-m68k.org>

m68k: coldfire: fix non-standard readX()/writeX() functions

Remove the local ColdFire definitions of readb()/readw()/readl() and
writeb()/writew()/writel() and use the asm-generic versions of them.

> diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
> index 4f0f34b06e37c..2f12f4ed0da54 100644
> --- a/arch/m68k/include/asm/io_no.h
> +++ b/arch/m68k/include/asm/io_no.h

[ ... ]

> -#define writel writel
> -static inline void writel(u32 value, volatile void __iomem *addr)
> -{
> -	if (cf_internalio(addr))
> -		__raw_writel(value, addr);
> -	else
> -		__raw_writel(swab32(value), addr);
> -}

[Severity: High]
Does replacing the local readX()/writeX() with the asm-generic versions
change the endianness of unpatched ColdFire drivers?

The old ColdFire implementation detected internal IO memory using
cf_internalio() and bypassed byte-swapping to provide native big-endian
access. The asm-generic accessors always assume little-endian devices and
perform byte-swapping.

Will unpatched drivers relying on readX()/writeX() for internal IO
(such as spi-coldfire-qspi.c, sdhci-esdhc-mcf.c, or fec_main.c) now read
and write byte-swapped values and malfunction?

[ ... ]

> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 9e1c6400c77be..4ed0ce644e37e 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -21,9 +21,9 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *d=
ev_id)
>  	unsigned int ch;
>  	u64 intmap;
> =20
> -	intmap =3D ioread32(regs->inth);
> +	intmap =3D ioread32be(regs->inth);
>  	intmap <<=3D 32;
> -	intmap |=3D ioread32(regs->intl);
> +	intmap |=3D ioread32be(regs->intl);
>  	if (!intmap)
>  		return IRQ_NONE;

[Severity: High]
This is a pre-existing issue, but does this shift invoke undefined behavior
for higher channels?

Looking at the loop immediately following this in mcf_edma_tx_handler():

	for (ch =3D 0; ch < mcf_edma->n_chans; ch++) {
		if (intmap & BIT(ch)) {
			...

On a 32-bit architecture like m68k, BIT(ch) expands to a 32-bit unsigned
long. Since ch can be up to 64, shifting by 32 or more would be undefined,
potentially causing channels 32-63 to be improperly processed or missing
their interrupts entirely.

Should this use BIT_ULL(ch) when testing against the 64-bit intmap?

[ ... ]

> @@ -43,7 +43,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *=
dev_id)
>  	struct edma_regs *regs =3D &mcf_edma->regs;
>  	unsigned int err, ch;
> =20
> -	err =3D ioread32(regs->errl);
> +	err =3D ioread32be(regs->errl);
>  	if (!err)
>  		return IRQ_NONE;

[Severity: High]
This is a pre-existing issue, but does this early return incorrectly skip
handling high channels?

If regs->errl is zero, it returns IRQ_NONE immediately, ignoring any errors
in regs->errh. This could leave errors in higher channels uncleared.

[ ... ]

> @@ -55,7 +55,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *=
dev_id)
>  		}
>  	}
> =20
> -	err =3D ioread32(regs->errh);
> +	err =3D ioread32be(regs->errh);
>  	if (!err)
>  		return IRQ_NONE;

[Severity: High]
This is a pre-existing issue, but does this return the wrong IRQ status if
low channel errors were already handled?

If errl was non-zero (so some errors were handled) but errh is zero,
returning IRQ_NONE here instead of IRQ_HANDLED might incorrectly signal
to the IRQ subsystem that the interrupt wasn't handled at all.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609142139.1563=
360-6-gerg@linux-m68k.org?part=3D1

