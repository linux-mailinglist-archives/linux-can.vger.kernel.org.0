Return-Path: <linux-can+bounces-7885-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YLHSOXIZNWr6mwYAu9opvQ
	(envelope-from <linux-can+bounces-7885-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 12:26:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508D6A536B
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 12:26:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=DVuV13ZJ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7885-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7885-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3218030B6D84
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84DC3655F1;
	Fri, 19 Jun 2026 10:24:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74E372EC1
	for <linux-can@vger.kernel.org>; Fri, 19 Jun 2026 10:24:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864698; cv=pass; b=rYvY4VocXF9K+M6Xi+vofLGR72z8LPdYUh51xdwZOspOMmBxju85dpqTUj2LCM3F2NRFjSLLf82KmMGC9SID6EeCP1fWS6sN+8oaES5UM7BBW2sIBun6GBTKTBjexjp7eDv2dVaijbzrDo7xR9iRbK9aCVVQxPyVaQ5B8hbX+f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864698; c=relaxed/simple;
	bh=ni/12ceZsW/f1/rf10e0NeNiqZaIvmVbzOgM9UdT9bo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3WUj6QEKwJkjbn+4G/wW3NRUGOazToqsim+g2Sw2+y7ONNjABJm98J3BhXUJ9WJmfPPHkc4tnEPOZhFPoNfZpZHgO8paDs4LrdEEepvsrxzzgaolfDkYnCGbHtUAYHHuE5hKM5duoi5mxzbFbom4Puw5Onq/kh8cABP7ZUvvSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DVuV13ZJ; arc=pass smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso202966b.0
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2026 03:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781864687; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4mbyHfSL4865rELMKGIhciyx5K9DZMKQsp5wRoO7jEJNzaOerdrw0stwFb8vAGO9d
         F6ca61lRPLPSOvK/x9unr174Q107IgoCJHCTFbNv6lJtbTD4mzmgGuH3cpbuphDN+wlx
         wKmZ8XA/jA9V7MZ22n9+79Ijfb4aTnXy0anvRiQiXF31p5u5lBWR+c7kfGst5G+gR0nr
         pZ+08IGfQpgY5NLIe1+RwjZLk2b58odvu5RwrKS7bDk+B3gOaadl7bNVIkz5B2Euag7P
         FffOlP/lUjWNjNQoTiANUeod1omtF0hNW2QPZ7Du7vCNk2OBgPEuQbmfeBvMuxKoY8PU
         3+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        fh=Mq9VussQ2Nu2erV9wNiGQjkECz86J/bVrqso0e60uZA=;
        b=c+EeYWVyZi2hJ+Y3Cu5wOjddCEFnSVPA+nRRIeY2LuHaMpLPpwbm+SMV8TTnhG9vkU
         io0+rVgHIi2ZaINdTQLL1iqmzLe8/K4QQvzzLo+TCky6ey1PHXb0KJcc0xUrodaQyOcP
         0wDKlqtalG3nzFwPS52tzR6vRJxmW2jn762waFxggyA5eveFSPTcr5+9nVU1ck5xq2pt
         WC6ZSSFVt12QgfCKWfp82vj5PIb5sMJO0u886byiH1A2GqN2fYxtVQMG8OmQqPhx7ik4
         5+jVkbveW3AQICOD/6NVdobc+RL4ENWxGMVX0ZMWbRNpiEHDNxG5CmLYy/U44NcufbKZ
         stBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781864687; x=1782469487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        b=DVuV13ZJQA4cwjxq5qn5w+4fYtykWO7KQnr5FcmRgeOerrN4yQWr68pqhbw8W92+4m
         Irc1EwZS1CTi412HTYPErXss2meyHGeXjEZwu9JsfE/tpu8zqpqTipylsssCP1K9k85r
         HMY9Cg7VUp+jVhhoUJtRsl/zBf7vQWSxVNjJe/ROl34txpn1e964Yz1N/DEvFa/MSzN8
         uR8/gNdi/kQNZNC8o+/0PjmC9IEr+9wQQHDGPfggJlo3dVLjC1z3d2DUIhq9bM9Gv9di
         edYIOqTRtvSuNlu8LQRBfSwqeRnU7gwabLMW1l6jvP+YNmsB4gXCK6E51eqKZCwgdpaW
         kOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781864687; x=1782469487;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqKnecBtz91u9GFBS0SkA37VjcFvmopZ2JwgbXFMYUM=;
        b=lxuV8rU2STmcuzZZsqswsQQlGIStwzwIkzmkUfkPWTkJVmqsaJt4sT83CHa8iXGqDG
         8coTcMmP/UTaqfQjbHxhVd+mCGvungDizgqv1z6KCv3ZbdL7CSE0fWKAOxrEUJgPmaR7
         HuCJcn4e1zQHK9D0+hnz14FHqi61g6pMNZNNrFclpEaw58g2hqKgqENZdeUZwK1rhTr2
         HNIFk1huwLqNcos7dgDvrd9zQWOAud7BwN0f+8oy+JxZGj1p4LxZROGPM2ucuub8hF6k
         w+p66yfnDxV8YpoXtQ9CHxYuFQzlKX/O//FLSjzKnvcgfSahMtGMUB6hs4vIjHQwDQvX
         wx1g==
X-Forwarded-Encrypted: i=1; AFNElJ/D6dtXfemKAgyXnuN9q5h3YBn1jNHMDCeukxr3W4cwz2+MZdtElbtKNyU9pR0UILXHfST/q0NRoxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvoil9kcA9migmSPc8A7PAG0BJ1ghUzYsSwumIS1L5GefdvcO
	VG3UlsM16dn7yiFIC2BrtkpTmAKG8J7orDh712IPM6LJdYQnSFKsOjQOYED6ZWlHMOI/W0HGd44
	W3fdzuXPzqIfSTTYZgjRKLyf6bl1VNpAjE1QKy7xcoA==
X-Gm-Gg: AfdE7ckEbz4aNCiQoMfH6xlQBFD22YcSg3wUeGhpOQrNGDr/o6g0+eAT1Hp2CUhIP9g
	L+HdE/zJYKljGbbttshydpzL2vqhtb1U+41+9qi7TYm7v8jvqRMkzTwdUC7mnUYUWtoiakFotm7
	dTpHFMweDsp2HFtkiFGq3OQgTj2n4SZXdXoUrcqWjwS6q1e2YsZzeRyKKecKUfm+Fs5gXov2xaY
	dylpgPTayonY93LBZddufS0dHLtUtXZyfdpW1op74++lte0xNsdq+ycaaEekdEMjqf5+wCsZBYE
	piLEl5on2koaIIc30c7uI8AOhQ==
X-Received: by 2002:a17:907:a786:b0:bfe:ed74:526 with SMTP id
 a640c23a62f3a-c09901bd9ddmr153293866b.53.1781864687277; Fri, 19 Jun 2026
 03:24:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 03:24:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 03:24:46 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260609142139.1563360-1-gerg@linux-m68k.org> <20260609142139.1563360-5-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260609142139.1563360-5-gerg@linux-m68k.org>
Date: Fri, 19 Jun 2026 03:24:46 -0700
X-Gm-Features: AVVi8Cf5uu_-jErGjE81PbtvCv_YT7XlmD0BhPjrXgKYB7qRKbzp8TAf4rZ-9HE
Message-ID: <CALSJ-wBLOaQ69+Hy5sgYoBr=fx654sfcfw7du1O1p89B=1gF0A@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel()
 on ColdFire
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com, 
	imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net, 
	adureghello@baylibre.com, ulfh@kernel.org, linux-mmc@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7885-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:dkim,baylibre.com:email,baylibre.com:from_mime,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux-m68k.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5508D6A536B

Hi Greg,

the driver behaves as before, and it is not using "edma",
but his internal dma interface, no new issues are introduced.

Over testing btw i noticed a possible issue, totally unrelated
with your changes. Will fix it eventually.

Tested-by: Angelo Dureghello <adureghello@baylibre.com>
Acked-by: Angelo Dureghello <adureghello@baylibre.com>

On Wed, Jun 10, 2026 at 12:13:00AM +1000, Greg Ungerer wrote:
> The implementation of the readX() and writeX() family of IO access
> functions is non-standard on ColdFire platforms. They check the supplied
> IO address and will return either big or little endian results based on
> that check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
> cleaned up and fixed.
>
> Change the use of the readX() and writeX() access functions in this driver
> to use the recently defined specific ColdFire internal SoC hardware IO
> access functions mcf_read8()/mcf_read16()/mcf_read32() and
> mcf_write8()/mcf_write16()/mcf_write32().
>
> There is no functional change to the driver. Though it does have the
> effect of making the IO access slightly more efficient, since there is
> no longer a need to do the address check at every register access.
>
> Acked-by: Angelo Dureghello <adureghello@baylibre.com>
> Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
> v2: moved from RFC to PATCH
>
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 375fce5639d7..6853521e8b2c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *host,
>  	if (reg == SDHCI_HOST_CONTROL)
>  		val |= ESDHC_PROCTL_D3CD;
>
> -	writel((readl(base) & ~mask) | val, base);
> +	mcf_write32((mcf_read32(base) & ~mask) | val, base);
>  }
>
>  /*
> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
>  		u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
> -		u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> +		u8 tmp = mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + 1);
>
>  		tmp &= ~0x03;
>  		tmp |= dma_bits;
> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
>  		 */
>  		host_ctrl |= val;
>  		host_ctrl |= (dma_bits << 8);
> -		writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +		mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>
>  		return;
>  	}
>
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
>  		 * As for the fsl driver,
>  		 * we have to set the mode in a single write here.
>  		 */
> -		writel(val << 16 | mcf_data->aside,
> +		mcf_write32(val << 16 | mcf_data->aside,
>  		       host->ioaddr + SDHCI_TRANSFER_MODE);
>  		return;
>  	}
>
> -	writel((readl(base) & mask) | (val << shift), base);
> +	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
>  {
> -	writel(val, host->ioaddr + reg);
> +	mcf_write32(val, host->ioaddr + reg);
>  }
>
>  static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  {
>  	if (reg == SDHCI_HOST_CONTROL) {
>  		u8 __iomem *base = host->ioaddr + (reg & ~3);
> -		u16 val = readw(base + 2);
> +		u16 val = mcf_read16(base + 2);
>  		u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
>  		u8 host_ctrl = val & 0xff;
>
> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  		return host_ctrl;
>  	}
>
> -	return readb(host->ioaddr + (reg ^ 0x3));
> +	return mcf_read8(host->ioaddr + (reg ^ 0x3));
>  }
>
>  static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
>  	if (reg == SDHCI_HOST_VERSION)
>  		reg -= 2;
>
> -	return readw(host->ioaddr + (reg ^ 0x2));
> +	return mcf_read16(host->ioaddr + (reg ^ 0x2));
>  }
>
>  static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>  {
>  	u32 val;
>
> -	val = readl(host->ioaddr + reg);
> +	val = mcf_read32(host->ioaddr + reg);
>
>  	/*
>  	 * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
>  	 * fvco = fsys * outdvi1 + 1
>  	 * fshdc = fvco / outdiv3 + 1
>  	 */
> -	temp = readl(pll_dr);
> +	temp = mcf_read32(pll_dr);
>  	fsys = pltfm_host->clock;
>  	fvco = fsys * ((temp & 0x1f) + 1);
>  	fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
> --
> 2.54.0
>

