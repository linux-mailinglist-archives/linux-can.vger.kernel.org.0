Return-Path: <linux-can+bounces-7882-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ur3NFXLdNGpkiwYAu9opvQ
	(envelope-from <linux-can+bounces-7882-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 08:10:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B06A40B6
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 08:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=N3tQ6v8P;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7882-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7882-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE88303957F
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFC346FDA;
	Fri, 19 Jun 2026 06:10:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FC32ED32
	for <linux-can@vger.kernel.org>; Fri, 19 Jun 2026 06:10:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849454; cv=pass; b=fvAsiGbQpm2G7xKTopTXVpNjdBhSZ8bQlASocmSOJc0Q5X43em3vXV2vihX/awiQcgULjxjc81eZaEn3YkIqjR5uGOTXUxVfgtFGs/0jrygWRq32fkVUyx01L9fkYL55JRCFIX+yh0xPeCmaR+Iy0Hc9xVAaBSARTQI9GeZ7PYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849454; c=relaxed/simple;
	bh=dk2S5WBPELrkoYZjdzCA40IFW7G6nPxmUcJbi0UDXs0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9SvgTvzHrtbOV3QUp+hirl77seXCbml/6pjqSFgemz2QUADyTMNYxUcj9zLG99tSeCrtrXsyG4BRBp8YAp0+H05rf0JPwFzlHvSwaVX8RT/zb9IphCwuoxtqNje1/tk99KeEAdHEeh0ab3TIIzG9PjEPD1/3a4KQ/K7gdfMOqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=N3tQ6v8P; arc=pass smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c07c246ad7bso176012666b.2
        for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 23:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781849449; cv=none;
        d=google.com; s=arc-20240605;
        b=QS/HC8pqeAej25l1X+PFUZbcqsIp5t/ovyACEyapq55JEdtMX6suSbG6S2a4UnvoSh
         EJaJ8tTMhtRDW0JDBi6EAmR/GQfzhs8rVxBH6vLrYLF1r78NG17XQ2OS2/48GzNXRbK2
         k+GVllZ5E8DiurYVexgekIAiZzDy6R7cJLzwTNgVtF6KFJNnRmdvOsEgj9hqH/m8xkcL
         2rLAopwjuU6yw19CfF2+cXCuL7ZdFrnjqQOViQWu/2GpGewhWtV6/2/AN91sNMUn1IlU
         l52V2DyJJZ3ZxgryWH9htJRVWtKyc0VTShF16QLfHKMTwZ58IJf6oQ0i/qEn2Pkw3PYw
         D3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=v9MezgOvVYdDVhHOvhxfflYG59sVc/14+1QAhEmgyMo=;
        fh=VRtJcPc+3vx01iY8HUSz6jJPA9dlhaKnFllgCBTcXlE=;
        b=Lxn+NdrnEErmELIMgHc/4+Xp72TeyiCoFBvR5cFYfbISBFKgFLhOjkhWiuhXwfPERl
         guHYcThabbkS0/K3UU2hwRVV6dSiwFAh4JHO0LEEuDzDNiJ+BnqvElwVmSvZfrKFKFg4
         pkmlIgOk1e/wU5n8kHrDDs1zqdMtsDhpOSFyxaYjczakhC/OWOiYD7M7ETcDhdUWE37P
         Ua5P7w9NtRamBe/lMGVnTP/Z36YGYqPCf9v638/wdOr7fLHsIQcq9GfFOvj19V6sWDn6
         fw+o4DK9+Z8T7VVJqpoj0SoM0hKl1K+Eum25sSoPBaGp/f0xbesvUFjP0ep+9qxa56/I
         zz6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781849449; x=1782454249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9MezgOvVYdDVhHOvhxfflYG59sVc/14+1QAhEmgyMo=;
        b=N3tQ6v8PbgCStpniarHrDDQl+HumUo/UUhlorRLNrqP++nxsxRrCoafAwdKSofbW1Z
         KENqmrO+qBg9Vf2Z0ITG2AxOxli2dweLdDl3E7EDn1FSefSXi+18V8ZLXUberbDmZFgg
         4IaFu6O5cARBjxTkNE/kFnmiwjuzq4JtZMsvTgPfjFZfI9yr1wnt2cdrGop0YnQEvz/G
         w0cj2RxT7qLSSIOLjcinfRByVXQG5MP/9Xn0JtYho7N9adcmi+JmT6oIggXMCJkZZgbg
         2McU48ai+RfQ1fIWC0H/ephSX3Lpo9ZaItUuvY0UIIfpnb53QRLlbiK6wDjJzaCEjSwl
         7h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781849449; x=1782454249;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9MezgOvVYdDVhHOvhxfflYG59sVc/14+1QAhEmgyMo=;
        b=h5KmvEwTcmOACVqvQCdgVaT4sQV9vKTyGPKlnYsV7Jei3ILYFnZ4jIWqG700eBqmej
         zwuwPCRJHVHM7twIRTGbSWsyCbCGXEcJ22Iz0PFGUopfTkO7J54WqR6rUyz5MgRgbbKO
         MBt1U+2kg6+WYJ4LWGodStK6B046gUlDRx3aY31uSHusTksBW3lXpa031bjEY4fRFXk0
         0KFSaeUI8FsQnxzLryrzdpmrWzCgpWGpq0tEDAtYzpeCYhmwgrndw3QRnHMCauf2Vq+Y
         ZyneohbqzXuTBgvU7WdW0eTK5Ur4+m2YNAaQiFwaX6VslgukeyYuGhuKi9m1HYdBSXlw
         XTLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1Tj4Q+xQowPdO5xIFXoSE7PjZNICwG1Il0r7YQ04W1XRV9tuI/LSHcj0dbjFdefabMFhPvFhHSH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCwyAHJe5uEYm3z1wCeyIDMte62Vpwli+8tXTg+n7u36REO/f
	RkO4PpFrP9fR4asxZeQdwiPfFZvY5hdZQOfTGlpipviTek4dDfQxXEcWyw1fR4P9cqKziOQZRZz
	RwVH+zkVr+ZSfq1Xn1B6tK9liCos80YS7tmMbnDHmEw==
X-Gm-Gg: AfdE7cmW6HCPkbEP2+ZCWRis2fqYAjsb0PF3fnrVVQ4/OGVIpqapwd+oh3BDXUoq2HG
	tjLdrDzqwjQghr7zJvPJtkAMRi+CMwf9l8/6MkQsT1xkUMwCzV7mzfY1d6tHielUpXwDelJCo4o
	RtsqeCy8Dhaesc0zmemJYbVZe/W33mD2YPw33u46ZOPzcFh2U3pXnnwxw1gWrwYlGflrdTf2wio
	DXVistMhjmHFKAZhpxOS/KVljhGly6LP6pSPHTHA9PVxYmKz/oxJ+pO/F8Bq11YsMTyZWeWru20
	jmdSyJUHAmx/VEQU9sX/33PYnw==
X-Received: by 2002:a17:907:3e98:b0:bf1:a59e:653f with SMTP id
 a640c23a62f3a-c097c9c486cmr103959766b.28.1781849449146; Thu, 18 Jun 2026
 23:10:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 23:10:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 23:10:48 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260609142139.1563360-6-gerg@linux-m68k.org> <20260610142725.031C31F0089A@smtp.kernel.org>
 <937086f1-5158-41e9-9194-b6d1feaee17f@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <937086f1-5158-41e9-9194-b6d1feaee17f@linux-m68k.org>
Date: Thu, 18 Jun 2026 23:10:48 -0700
X-Gm-Features: AVVi8CeRdz8EjQv7N6iu4inU7GEg0JeeUbGrB_UMI7cQpI9RGlKWq-bZNMislQ0
Message-ID: <CALSJ-wAO-HpN+9E4cNrfQ0ELF6akddMv7DBXE2W2tKxRWvEZtQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: sashiko-reviews@lists.linux.dev, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, Frank.Li@kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, imx@lists.linux.dev, 
	Angelo Dureghello <adureghello@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7882-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:Frank.Li@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:imx@lists.linux.dev,m:adureghello@baylibre.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B89B06A40B6

Hi,
On Thu, Jun 11, 2026 at 11:35:02PM +1000, Greg Ungerer wrote:
> Hi Sashiko-bot,
>
> On 11/6/26 00:27, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >
> > New issues:
> > - [High] The transition to asm-generic readX()/writeX() changes the endianness of ColdFire internal IO accesses, breaking unpatched ColdFire drivers.
> >
> > Pre-existing issues:
> > - [High] Undefined behavior when shifting 1 by 32 or more using `BIT(ch)` in `mcf_edma_tx_handler`.
> > - [High] The error interrupt handler incorrectly skips handling high channels and returns `IRQ_NONE` after servicing low channels.
> > --
> >
> > commit 25193db3eba89f780b6dc534f2f72e16f3429571
> > Author: Greg Ungerer <gerg@linux-m68k.org>
> >
> > m68k: coldfire: fix non-standard readX()/writeX() functions
> >
> > Remove the local ColdFire definitions of readb()/readw()/readl() and
> > writeb()/writew()/writel() and use the asm-generic versions of them.
> >
> > > diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
> > > index 4f0f34b06e37c..2f12f4ed0da54 100644
> > > --- a/arch/m68k/include/asm/io_no.h
> > > +++ b/arch/m68k/include/asm/io_no.h
> >
> > [ ... ]
> >
> > > -#define writel writel
> > > -static inline void writel(u32 value, volatile void __iomem *addr)
> > > -{
> > > -	if (cf_internalio(addr))
> > > -		__raw_writel(value, addr);
> > > -	else
> > > -		__raw_writel(swab32(value), addr);
> > > -}
> >
> > [Severity: High]
> > Does replacing the local readX()/writeX() with the asm-generic versions
> > change the endianness of unpatched ColdFire drivers?
> >
> > The old ColdFire implementation detected internal IO memory using
> > cf_internalio() and bypassed byte-swapping to provide native big-endian
> > access. The asm-generic accessors always assume little-endian devices and
> > perform byte-swapping.
> >
> > Will unpatched drivers relying on readX()/writeX() for internal IO
> > (such as spi-coldfire-qspi.c, sdhci-esdhc-mcf.c, or fec_main.c) now read
> > and write byte-swapped values and malfunction?
>
> This is of course a real problem, and much effort has been expended to
> find and fix affected drivers. Specifically here:
>
>     patch 1 in this series fixes fec_main.c
>     patch 3 in this series fixes sdhci-esdhc-mcf.c
>     patch 4 (this patch) fixes spi-coldfire-qspi.c with the endian change to spi-fsl-dspi.c
>
> Not mentioned here, but patch 2 in this series fixes the smc91x driver.
>
> It is not believed at this time that any other drivers are affected.
>
>
> > [ ... ]
> >
> > > diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> > > index 9e1c6400c77be..4ed0ce644e37e 100644
> > > --- a/drivers/dma/mcf-edma-main.c
> > > +++ b/drivers/dma/mcf-edma-main.c
> > > @@ -21,9 +21,9 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
> > >   	unsigned int ch;
> > >   	u64 intmap;
> > > -	intmap = ioread32(regs->inth);
> > > +	intmap = ioread32be(regs->inth);
> > >   	intmap <<= 32;
> > > -	intmap |= ioread32(regs->intl);
> > > +	intmap |= ioread32be(regs->intl);
> > >   	if (!intmap)
> > >   		return IRQ_NONE;
> >
> > [Severity: High]
> > This is a pre-existing issue, but does this shift invoke undefined behavior
> > for higher channels?
> >
> > Looking at the loop immediately following this in mcf_edma_tx_handler():
> >
> > 	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
> > 		if (intmap & BIT(ch)) {
> > 			...
> >
> > On a 32-bit architecture like m68k, BIT(ch) expands to a 32-bit unsigned
> > long. Since ch can be up to 64, shifting by 32 or more would be undefined,
> > potentially causing channels 32-63 to be improperly processed or missing
> > their interrupts entirely.
> >
> > Should this use BIT_ULL(ch) when testing against the 64-bit intmap?
> >
> > [ ... ]
> >
> > > @@ -43,7 +43,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
> > >   	struct edma_regs *regs = &mcf_edma->regs;
> > >   	unsigned int err, ch;
> > > -	err = ioread32(regs->errl);
> > > +	err = ioread32be(regs->errl);
> > >   	if (!err)
> > >   		return IRQ_NONE;
> >
> > [Severity: High]
> > This is a pre-existing issue, but does this early return incorrectly skip
> > handling high channels?
> >
> > If regs->errl is zero, it returns IRQ_NONE immediately, ignoring any errors
> > in regs->errh. This could leave errors in higher channels uncleared.
> >
> > [ ... ]
> >
> > > @@ -55,7 +55,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
> > >   		}
> > >   	}
> > > -	err = ioread32(regs->errh);
> > > +	err = ioread32be(regs->errh);
> > >   	if (!err)
> > >   		return IRQ_NONE;
> >
> > [Severity: High]
> > This is a pre-existing issue, but does this return the wrong IRQ status if
> > low channel errors were already handled?
> >
> > If errl was non-zero (so some errors were handled) but errh is zero,
> > returning IRQ_NONE here instead of IRQ_HANDLED might incorrectly signal
> > to the IRQ subsystem that the interrupt wasn't handled at all.
>
> At casual inspection these may well be real problems. I will have to defer
> to the driver author and current maintainers for them to fix. The changes
> to fix ColdFire readl()/writel() have no effect on these, and are really
> outside of the scope of this series.
>
> Thanks for the review!
>

will fix this. Thanks.

> Regards
> Greg
>
>
>
Regards,
angelo
>

