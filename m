Return-Path: <linux-can+bounces-7651-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOEcMB48CmrtxwQAu9opvQ
	(envelope-from <linux-can+bounces-7651-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 18 May 2026 00:07:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269BF56421C
	for <lists+linux-can@lfdr.de>; Mon, 18 May 2026 00:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4A830293E7
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 22:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA03314C3;
	Sun, 17 May 2026 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LXAwF2Pr"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B41233134
	for <linux-can@vger.kernel.org>; Sun, 17 May 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779055474; cv=pass; b=fQKWficpyi/IYz44dlhVm4P7tU4vtPgrtthtcMeCw+s7LnYVp8Nqux/CU3obEY4+rceP+4vj5ojJcBFpsfrBQCmY6bmxGMfjZEYjEtzSvSLw+QTDkHERXLBVMwNStdAs884cUVNRwvYCKZMzmpc+GFjmEIbQVfLZyaBU5gsJfVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779055474; c=relaxed/simple;
	bh=gZHJrfIdPYrab0HpvH9DcCEOEOFnzCPNy8/jE8lgWog=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoC2e0APHVFt+NQ0XEYGdZwG95W0IsJHzgVsmwHKYrA4qVOMMGDRYKaiIBlqFGDYWzAHZT8G07Kcb8dbI8dlF8p5BrmbL4Py5p7s3kBsiNhg11mqP2uWYQ+yCfh01I2cx86pyFri47fANcobXCnnXK6NdD7sPlOoVNkeNSwVe9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=LXAwF2Pr; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bcc2b199c17so212732566b.3
        for <linux-can@vger.kernel.org>; Sun, 17 May 2026 15:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779055465; cv=none;
        d=google.com; s=arc-20240605;
        b=QA4+a/BVn4iPwslzY7OW3rGGwwHumOhnzNeZvIqzs39iZJH/rooHIlzAcvnDFGb3iL
         61im3Z0J8x/vBQp5AjSa7Vk5xj9hSrdM6b4ZRKbuJrNb7soJvD1Cjf07/qSwy3NmRZ1m
         ZDS/uF8NIVdWivDo78yYV/lFukIehX+0SgmajQ8IWpjWtMgFvcZdVIWJdxbHJHKb5JmB
         25GhQO70p88tpKbqX2hSqfg9G6c0fLmpAB4AzuqI+NnIv17wwfPJ7okrmrNjhJ36CuOK
         WTaJCmPRYX4rtq9NhCc/NTLTBKC53cILPfX/ahv1SeV8hdQGHbx2WZmxHBp3m/AQIJ5U
         MPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        fh=uo3jFT4VHLPv8cyw+yOrU7f7KvghcsvbolTi1rxHvns=;
        b=a2HFgeSVIYx/VquzW2JSHsk7fIksNrBaknnMUHhsfwGXVadPEEgl4oq1Byw5o6bD7x
         6Nq2XN9j/HC0HFGSS2MEn4FblkfzWGrWC/LwO9da17EpP7yOAMzzSJpoZDi7JPugyati
         wKqJziRdms9tr6o6uAiYjh18Ht9/alx6AyjLVxGyJRhkCdokll0HnImBQqVBaMOW/ko7
         yGC52wGS86+7M1k3/V5kfn0DHkQMRAsdeAxwS8lGxjKNrKwqOns1SMvbJJQnYnvYdVE7
         C7IcH57n6YzvR10XoaiTbDn2cNWYB7RQatBXIf0iPKYJL76AHWeIQbZKVdroJbVba53f
         95ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779055465; x=1779660265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        b=LXAwF2PrT5A9q9fuByASsT3Wn/hhfhryTp/ed5JOL1JhYOtxs9V+nCy97YzXUfp4kz
         VT6nlWpF8Sd90IQWMWpP8IVAu/vhMQ26OSOjaC0Ugc8TnDq0/SBbJNiABkL26hw3DB8N
         OHMkEEQupPKPoeZmdRjOa/a0mvtC3FwpJCyhKo9ADBIqdbpQQfjwNKLqt9kdxima/dRd
         HZFqr+5fAgH/K2Z678tylyWv3L74Q2/vWpc63Bf+vgdjaeruHqNsz7J6z2TIauN9AVQ+
         hfDrcihuGzHPLRwa3YYfY9utzd3YOCXFlAo3qCShBVqPyYvX+sS6sRzni7ejQ1BcRYuO
         fktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779055465; x=1779660265;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        b=YYjfRiMMpHNXtOkHmRPWKtQkoSylQTv/m81bVlAUnSWFlINxCTuBH5DsqZ9KYoE+w7
         ND5u4ns82JaC/cNLLzd5IGg7igiS+EhcS1Bz0MrndhQEr3x8XQ3zb+103mx3QvxgQ8Pg
         cFbrd8iLfFHecnOd7TQnpVxwyXm+X9lpduIEsNKtP33PIMOYNL2QjPUgK8ZtCi7vqN5d
         I5ysKEIk/Y0TVBfB5bYe13e0Mz1o+0dURjFX0HAPPQGMp5DZLMAhFDBqtSBJJmr4eM1A
         K+/dit8tQOcF3eHTXrLlYFDt4QtELSsi/5yP+SqocEzDUgmwJsFF8b89+GEP4Oqlf22G
         QGMA==
X-Forwarded-Encrypted: i=1; AFNElJ821EaW+WcZvFwGsxMCYXpSLyFprOMf0vIoXOK3fj9MH25G8cb7yNNiWAPf8rvmKMpqMxIfFYfhOBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIA0I+ryyroBNvLZzU12DyUeVRe2vGxvHGNWpDxhBVZ6nWJMMv
	WzGP6+KGzJwWcZggO2U9fC0ENGqYUlunLVDOoaVMg9uIOtsI2UJNDAAwrJNa3k3V8sOkp9A0eRW
	l5YFZgnevrgEST3VvzKXmCYpHXJy1wVAP9Ackdgm6Gg==
X-Gm-Gg: Acq92OFVzd/ocLcNmYlnzUv7LYGfY/pfQfxsQ4uoTpEn7GASBxw6f8SNrtwMRgfIhtU
	ep0NVqXff/7hv3fToxl12b87nL1YcynZo52dVF8TtuUewoUvwg1KWZMcCvmYsccIGyBpI1RTh2y
	hmnHzJ9K/G1j0PF6/SFec1JObyKcw17aUfyPGCfQOX5VM65vsSjtdVHRtfu6kLrpO6Q747V/eR+
	KO+RJq3jYifdL34ZQ6h3p2RPFtSsvfEgxD91q5M4WyrGU5ELH3up0JyQdJvI9nlvdcqY/v2kuQB
	Njg8qucQH27CT+VJlx0vR8QixjZUwWhXZYlD
X-Received: by 2002:a17:907:3cc7:b0:bd5:18e8:1ad8 with SMTP id
 a640c23a62f3a-bd518e82334mr600884066b.4.1779055464251; Sun, 17 May 2026
 15:04:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:04:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:04:23 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com> <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
Date: Sun, 17 May 2026 15:04:23 -0700
X-Gm-Features: AVHnY4IqhiV2sSnDG3bDc8vtXUEslTxnP4xgh859XRbJ5eiok2HZwd1skAiBlBc
Message-ID: <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Arnd Bergmann <arnd@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@kernel.org>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 269BF56421C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7651-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,baylibre-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Arnd,

On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> >> On 7/5/26 05:12, Arnd Bergmann wrote:
> >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> >
> > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > [    2.290000] spi_master spi0: noqueue transfer failed
> > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> >
> > DSPI is using edma, i will try to understand where the issue is asap.
> >
> > About how it works:
> > - for accesses to edma module (IP) mmio registers, must be native
> > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
>
> The twist here is that with the way that readl() is defined on
> coldfire as a non-swapping operation, and the generic
> definition assuming the opposite in
>
> static inline u32 ioread32be(const void __iomem *addr)
> {
>         return swab32(readl(addr));
> }
>
> the function called ioread32be() actually tries to access
> the registers as little-endian. I can see two possible ways
> we got here, but don't know which one is currect:
>
> a) the device actually has little-endian registers (like it
>    does on i.MX, but unlike all other coldfire devices), and
>    you just never noticed because using ioread32be() worked
>    as you expected.
>
> b) you tested the driver using an ioread32be() definition that
>    did not have a byteswap and it correctly accessed big-endian
>    registers at the time, but the version in mainline today does
>    not.

Ok. The ioread32be now works properly since i had applied Greg patches.
I generated an error in _probe on edma channel 2, reading status reg.
looks consistent:

	iowrite16(2121, regs->erqh);
	iowrite8(0x77, regs->serq);
	iowrite8(0x12, regs->ssrt);
	
	u32 status = ioread32be(regs->es);
	printk("%s() status: %04x\n", __func__, status);

[    0.140000] mcf_edma_probe() entering
[    0.140000] mcf_edma_probe(): allocating data
[    0.140000] mcf_edma_probe() status: 800012f8

If i am not loosing myself in this r/w labyrinth, the path should be:

1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
2) So the ioread32be swaps the standard LE read giving BE.

Am i correct ?


>
> > - for accessing the "tcd" memory structure, that must be, from what i
> > remember, anyway in little endian, independently from the cpu core
> > endiannes, this is the reason that big_endian flag is needed, it is
> > used for tcd area accesses, so the IP module was built.
> > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
>
> edma_read_tcdreg() calls into edma_readl(), which is the same function
> that is used for normal register access, so from what I can tell,
> they always use the same endianess here.
>

If edma_readl was using

        if (edma->big_endian)
                val = ioread32be(addr);

and never changed, without Greg patch, it was likely returning little
endian for coldfire and correct LE for other arch ? :)

I remember something about tcd area was coded LE, but will investigate
better, now i am over midnight.

Regards,
angelo

>       Arnd

