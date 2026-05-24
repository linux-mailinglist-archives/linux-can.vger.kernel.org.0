Return-Path: <linux-can+bounces-7691-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UsVQDdxqE2pIAgcAu9opvQ
	(envelope-from <linux-can+bounces-7691-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 23:17:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4165C452D
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 23:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC2233008A66
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE95332913;
	Sun, 24 May 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F1bMJPdt"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E1309DCF
	for <linux-can@vger.kernel.org>; Sun, 24 May 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779657432; cv=pass; b=r5Qsmq+sGOSik9u1kxzIuZn/mXBvuMisrymRTEAPCvYGhPUkHFycblpOFLH7ULps4AnSDu0Q0iCtzFsdvhI89FeSIMvr/C6DrApBae8p/uwx6AgQhIv+1nZ5QdO1qB1SasVheMJa2WWAbuo5SeCSPpaMH9I2ZJ/vsmt2TFHwqcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779657432; c=relaxed/simple;
	bh=qfr3PV+aenV2JpxF3FEwOoVdituPWH2TqiuNbdw2APY=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+bvcbkpk8145OZWyTP/2Nl9thK8Y1VKG+z/ru/PsUScTIhXBQQ3xfv+HyiGjgR56QduEE++hFIzLgcf+3tuxkI3zwfRUcLkFizAWfF8OqFMQRXjOu4HyqTAGtuNq68iyK1F963aDk5q//iliQuBNmVi7ar+dcK4FAUOFdjz20A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F1bMJPdt; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso18179154a12.2
        for <linux-can@vger.kernel.org>; Sun, 24 May 2026 14:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779657428; cv=none;
        d=google.com; s=arc-20240605;
        b=M9uybf6ufzOoGJeYSuv0rBQrOs76gDv2CAEL45Tt5iaiVQ6dp6AjCc4i7/CQPAkdv3
         RJlF52LnWaMCc6dqsUPYBbjrNCTuTfuItnNd5aADzSkX7dOVX9juowDtGb0yUvLY8acP
         0QSS/qRHdQsfWJ7AK7EqrlWY1f17uuYGX8tdpWAuj+gLxo5bwdQJszTJiizMqQKRKfXh
         K+n0hFnAq4SXdvaWW7QIO25d4lQNsHtqKWFMfMrAmes4XQ8y3NLrgGIGXBHJm6pZZhEX
         lmvyg7McjSG8jjLJnOTuQ7XxRG9lVCDXhACQWo0G3QOz3utOUl77E3IlSVTaeYX/heGp
         pkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        fh=1UNhcgYqWV1OG7p2jbHjtr0xVIuAUZ4uX9gcR/2vx+A=;
        b=Fg9/y1pRlBF4Xdm3Q03pXwbxG8iUr1Xm6yLzg2n6RGNathLkOJsS9lvRnAzK+LkAaO
         2jwxQtpiT2qLZY9coJkfEbqDGlcfrU+3K4aSU+UxlKhzkagFn9aIABAve3bum+cdqa8b
         R18naGaXnuruYIudVnpTNtxAVVqpQ2IoALUMGws9YnV3y8jbV0LTCU3TDeGAMbb2pLFn
         aSm4mkMlE3nI0b5lB493pLORdI111U0/h/02wBuHsMRnEDgBEjO2NpJiQhdMg5nYb+6A
         9M/iso69NMb7+uiBvNO6YYDIx+PuKpzg8iB/YHoWWPBxRrEPhJQmJMiyU+3vANe9OpIw
         eLMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779657428; x=1780262228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        b=F1bMJPdtZgkqyu65CsjIi2ZYg5QbFD7Y7uGdQ7uE6/w5Oe26j1eOnTsAdgHkCUL2e2
         ZCFd9WPpLhoWkrzVQylPo/yBj7h9eahiygtA5PLTStex4JFHWzGURgWQEmVJYVahTdTF
         tVrSTVhjG97cnaIFgfEdJ1PovFmar8znQH9RPzTWpD49DqB0m/PoYMcNs1v8jlBuaLEw
         S9g8r5d07Lj6Kl13piXqv+IVAEd+YRGmqCaW/VA+KxhPj1HNzhtXomG79r3EypvTljRJ
         3/oCNDItTkc2AffGkN7wSsX9UtmfWVb+t47+t31q3pEXAeF3iyf/Z5ILFVSwxC1vO5hh
         vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779657428; x=1780262228;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        b=jDor3rhAeuOVSRCMwyTHs6U3RzcCRkiGF5gh/VjC+NOJrlWdGQDzUZ3lPFWJ3svP/B
         iszC4j3IM2mebSjv5+5YvXaATj5uGnh75z7X6of71+WhqmPDq6WnnV4LbmUJ7R2+Iw19
         jgK/647BmMG2KkVhWs9zfokj91JJdmTo29jBrI6P7+NaH06hXb3YwpVoRnd/dnbPY/e5
         U3o7/eEZpg4sqJtuyTlwv7X69ORqACmeC8aeQeAzU1kBVDwzWIijk2MR5CYc2Y6EB2DQ
         jtzmaiQ1mNtCB6aei9eQ7/Xvdev9BSjgnPaGgS4OXy6yGlmATobDU98XoT1GqNW9rAYQ
         FnqA==
X-Forwarded-Encrypted: i=1; AFNElJ+HAsQeD4fAg+rZzfjTIz79SJM/rfbHzThqEfuq6hMdtH3Oc1NeJr6PIMsF8Y1Q2nstd8ezwAHBcDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYxkbHIiVbr9qpyCB8iqb9HZkJpZvONKLtEC2xIXhLzKw3boU
	Uc6LIjiyWIC2cswt3S8OMbnWjID9mJv0jxzIX/cw4X2ua2nLOrtwuEdfvzop5NhRjQnuo+CuiwL
	pcXnrg6D1kT1snSR8XjnaLkbnA/36xDO2U0dUnIOUWg==
X-Gm-Gg: Acq92OEDz8kKh9/Y8DVKgWgGVzqTzI2kfsA5JvQcauD8B8XuLPVyJz2YV7UUwl4B0dK
	Aj09K9F+UQk6iXoZJYqgLkReLat1s3DDrj82ZLpE2C63/gE2R/8T7SY3CbOa/fX32Er5mEERPpH
	SRpmMYRqHLxvuzuyfoA60hgTToSbw6OYoBCOWCvunFnGKkCrTj15l2wXg+g4fv1xbihtq6BHVE2
	Q/pWo3dbxKM2W2VDh/aP93hA2LeEl70TGYrJ+9d/xFzO0hLg/V6Jn4l7TC8yo3CkbILPuet1w6M
	OxtwJxjjDvtX3KZVUCA6eLFd68bqLkW7TR6/
X-Received: by 2002:a17:907:7290:b0:bd2:4aa6:1a9d with SMTP id
 a640c23a62f3a-bdd2360237fmr744344866b.16.1779657428216; Sun, 24 May 2026
 14:17:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 14:17:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 14:17:07 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Date: Sun, 24 May 2026 14:17:07 -0700
X-Gm-Features: AVHnY4JHtsLYNvdawYYzb7h3_2sEIhQJt9TYhOw6--5OCNVF-hms1fU3-Y2rI9c
Message-ID: <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Greg Ungerer <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7691-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6E4165C452D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi All,

On Sun, May 17, 2026 at 03:41:31PM -0700, Angelo Dureghello wrote:
> Hi,
>
> On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> > Hi Arnd,
> >
> > On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > > >
> > > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > > >
>
> About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
> i probably lost some dma config option.
>

so i worked on this open issue above:

- moved to master and rebased,
- crated a wip/edma branch,
- bisected and found the offending commit, before this, mcf-edma driver
  and connected spi-fsl-dspi (using edma) was both working correctly.

7a360df941a4bd60847208de59f1ac8b166265a2 is the first bad commit
commit 7a360df941a4bd60847208de59f1ac8b166265a2 (HEAD)
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Oct 12 09:52:27 2023 +0200

    m68k: don't provide arch_dma_alloc for nommu/coldfire

    Coldfire cores configured with a data cache can't provide coherent
    DMA allocations at all.

    Instead of returning non-coherent kernel memory in this case,
    return NULL and fail the allocation.

    The only driver that used to rely on the previous behavior (fec) has
    been switched to use non-coherent allocations for this case recently.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
    Tested-by: Greg Ungerer <gerg@linux-m68k.org>

 arch/m68k/Kconfig      |  1 -
 arch/m68k/kernel/dma.c | 23 -----------------------
 2 files changed, 24 deletions(-)

So i can try next week a patch for edma looking what has been done
in fec, and since i am probably the only with mcf54415, will test it
here.

> > > > DSPI is using edma, i will try to understand where the issue is asap.
> > > >
> > > > About how it works:
> > > > - for accesses to edma module (IP) mmio registers, must be native
> > > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> > >
> > > The twist here is that with the way that readl() is defined on
> > > coldfire as a non-swapping operation, and the generic
> > > definition assuming the opposite in
> > >
> > > static inline u32 ioread32be(const void __iomem *addr)
> > > {
> > >         return swab32(readl(addr));
> > > }
> > >
> > > the function called ioread32be() actually tries to access
> > > the registers as little-endian. I can see two possible ways
> > > we got here, but don't know which one is currect:
> > >
> > > a) the device actually has little-endian registers (like it
> > >    does on i.MX, but unlike all other coldfire devices), and
> > >    you just never noticed because using ioread32be() worked
> > >    as you expected.
> > >
> > > b) you tested the driver using an ioread32be() definition that
> > >    did not have a byteswap and it correctly accessed big-endian
> > >    registers at the time, but the version in mainline today does
> > >    not.
> >
> > Ok. The ioread32be now works properly since i had applied Greg patches.
> > I generated an error in _probe on edma channel 2, reading status reg.
> > looks consistent:
> >
> > 	iowrite16(2121, regs->erqh);
> > 	iowrite8(0x77, regs->serq);
> > 	iowrite8(0x12, regs->ssrt);
> > 	
> > 	u32 status = ioread32be(regs->es);
> > 	printk("%s() status: %04x\n", __func__, status);
> >
> > [    0.140000] mcf_edma_probe() entering
> > [    0.140000] mcf_edma_probe(): allocating data
> > [    0.140000] mcf_edma_probe() status: 800012f8
> >
> > If i am not loosing myself in this r/w labyrinth, the path should be:
> >
> > 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> > 2) So the ioread32be swaps the standard LE read giving BE.
> >
> > Am i correct ?
> >
> >
> > >
> > > > - for accessing the "tcd" memory structure, that must be, from what i
> > > > remember, anyway in little endian, independently from the cpu core
> > > > endiannes, this is the reason that big_endian flag is needed, it is
> > > > used for tcd area accesses, so the IP module was built.
> > > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> > >
> > > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > > that is used for normal register access, so from what I can tell,
> > > they always use the same endianess here.
> > >
> >
> > If edma_readl was using
> >
> >         if (edma->big_endian)
> >                 val = ioread32be(addr);
> >
> > and never changed, without Greg patch, it was likely returning little
> > endian for coldfire and correct LE for other arch ? :)
> >
> > I remember something about tcd area was coded LE, but will investigate
> > better, now i am over midnight.
> >
> > Regards,
> > angelo
> >
> > >       Arnd
>
> Regards,
> angelo

Regards,
angelo

