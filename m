Return-Path: <linux-can+bounces-7652-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNn2LCdECmoKygQAu9opvQ
	(envelope-from <linux-can+bounces-7652-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 18 May 2026 00:41:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC7456432A
	for <lists+linux-can@lfdr.de>; Mon, 18 May 2026 00:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A50E2300955F
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 22:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E53D647B;
	Sun, 17 May 2026 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Vz0cyi63"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C753D6465
	for <linux-can@vger.kernel.org>; Sun, 17 May 2026 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057697; cv=pass; b=exKwDWvmuF7zd21FPgHCZ7EHqdIDbHUS7CDeeWSfz6OrDjlWBJ8n6PzxGVDYtAwq3IRjaTFukZmr1XkxGo7yZEpvL5dhQLFFcqn1/dE+vPUMk3TXiwjAH0Wz2shUe8wsqzE1X7ISKMmTy0wGai8wpRY5dldjnSHOp7dzQ5ZjbWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057697; c=relaxed/simple;
	bh=UDRqVbPZNo1rDKG47pl3Cfg1y+NpJU3+9tCj4VzpKzA=;
	h=References:MIME-Version:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL4t9ChhcmEQvW1uxeZgivDULrlwoT0UF0qsCrcQmtd0Oqlr8xX6VamswNJ5e2m+qaepfs6xqSwoq7MHc18/zXVOPmXM80qy0hEAjTq+8kBcLM4aSpEPvzk58nwEXCv8DTqxEHi+0ssZxv6VAzlNV7ueuWuP2eb2EVhcTMyPsSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Vz0cyi63; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd2087858c4so423263166b.0
        for <linux-can@vger.kernel.org>; Sun, 17 May 2026 15:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779057691; cv=none;
        d=google.com; s=arc-20240605;
        b=G6nyB5YDbrjgxuuq+Sz0nobTJI35IUyUrxCPynqQ7UePW8yLOMCMVUgdzVOwpEr59G
         j86vtq1g39gnfU/PaQ0YbjjmGwr46WeGpjQ0YcIDODKZM0ruKXWwYQKkCVaocAhk7P4H
         poKCYNIzcCTrIM21YDlvTGneFb889a1ERnC72a3noUfEJ3dBG0Oa5OfJ0wzqV0KLC1AI
         X33X7KJnLBDTYTf95hHrmiEktOzpVS3ewzs7QDz82WifHD3KstRfFoju4y5anwWdxLZA
         hyHR2GqUCialDcZ2O8uny3Mj5gkVPVRf6TbROjSxEHdIsFZhSWGNUQ7C+z0S8L1VlpNO
         rxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:dkim-signature;
        bh=6WvnwIRGvHEPeQ8ZKX+R0d/VCeeAw5//At/YqjZNVr0=;
        fh=Ig4BJ4i+TYh3JpPaxkP3TopQHFYRQEJNmPpL9NH4FBQ=;
        b=JfuDeSCR3P7/L3X5rImDa0J1++ynUWSm+cfMMaGX+T7qD9QlfxOWhQKuXenQlmjR36
         mP85UJSCIo87N3RDe0QWLbuxtNMs8qypMK9skNmWoU5keTlYuMR3jUmCiR6Prbwwny0Z
         esUj+p9f4yQy3BW0ENYsuFrfLrueqsW35r6xUv+UGZFw7jQRjsZdztGR5l9Tk68O5oYV
         YRRjVYv5y27KAGTCE/FXLaPHaQ2SnLiGUDL8vFSsUz9OsFY2YTQ6xXz4rpauCmMAP6iT
         sdq78XTewtWxJBpfKt7p0sgGzXHLcGjFat3Ux5znDQLKYsEu35ZMxW37GCdPCa7Mc2kP
         PgLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779057691; x=1779662491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:from:to:cc:subject:date:message-id:reply-to;
        bh=6WvnwIRGvHEPeQ8ZKX+R0d/VCeeAw5//At/YqjZNVr0=;
        b=Vz0cyi63XRcz5HkecXRJyJuvbJRI6/ENx4q+IVG4l5ac2OHd1JGxXp0BATV9GI5BbV
         z+Bu2JxIK5Ox3sSUfU2m4EufvHpc8M2/LAuHAtiolAo8y2uIJo9V+Gq90FMIvy2DoSGT
         poKtai34kv/eu1d1WWR3GpVuOWWKHgDxhyiOVNGNYjV59ARjXtx6N6HLm25I9VLyG7uc
         7SQeVmgSZ6aqx2Z5bxDZI5iJNpez3wSGQS/uOkf1F3husBOw+Fmp/4RG86wJGuW5pyWR
         chOYROLYFRd1cOxU5VphNTar5qkNshgjQAjOXVzYrwFO1LATDYWeW+l09mgM4tcugFoT
         OdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779057691; x=1779662491;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WvnwIRGvHEPeQ8ZKX+R0d/VCeeAw5//At/YqjZNVr0=;
        b=bsz5gfSdw3VNqPyeTTe87tvjPS5EBFkklCEAoY4wWUQEOyafCM/nAX0Kzfig665gnS
         oXbLIxIXCemGar77TqJ+BmXlphc9d/ApFF4b1DRjNG5kkDRPRo88prMpM0CJvxj6ia9q
         WUg2isu7Z9PLoYokZFfYxfkPA5UFKlK0s362PUZvXzrg4+oYYZ68xdsX1wDfSPUEvEH4
         3qjv2wNiPQbTTLUQ+hwmFUlo6qAO3/EsD6R2hHBSOVXy2M9BSqSCl8Gs56RVK8eM3bqD
         mxeEKkU5WELDXpG3OPHMY8NmzuOeiZ8xwc7D7S+zndX+fqy/gnlbi/sY7eUDLnKZUkD4
         Kkpg==
X-Forwarded-Encrypted: i=1; AFNElJ/Gpz4f/P0lTvlFl6un9GyLCghkRzoGycM9lyJlDkrq5hZsvmtLrMDCjikEyygGqnTYVoK0SZUmTUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBco6vwjmBfVm6y/e/IOikHEPERvIfNf2FSNyKT82Q12rpTOz
	MdnOstC2KzbE2a4iXySZSyNJmkSZN4DnhdXYDWFNIg99p6HDqrdXX+zxEuZ+WGjH1BkR2v/y9dQ
	dgY6JtJGZ23SpeB66dhHPlKdW5Ia7S6oVIT3iif0Lvg==
X-Gm-Gg: Acq92OH4ey3uEI7SNEEqfaa79IvZGH/zPYcuzacybia7ykjeNCS9pG21sDOWzD0J/rs
	Fta9x4jCSBhwuEfOJBKIvPLGigMdUz67/6X3BEvd0moRUXco2CKH0gYns3GfLZNfekKDuQI//RX
	WbVSYMZpBs+Y8zdrqGsEmRDFeGEtYxzebCJHRUC8P7O4kB8HGslvpS2lZ3FejbVDhd1An+D+PdW
	ELBvzPVeDKFZo6/BdlGC/QO5SH8iQD6R/J8xnHke/pzGxTKkD8UreGcNqjbdfQaiCcEN5HK+Iy+
	s6eiSXFIowTbIcspPPohV77ha8oOLzmFdJyB
X-Received: by 2002:a17:907:1c8d:b0:bd2:bd2:6ca0 with SMTP id
 a640c23a62f3a-bd5177bd03fmr585833066b.11.1779057691600; Sun, 17 May 2026
 15:41:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:41:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:41:31 -0700
esFrom: angelo@archlinux
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Sun, 17 May 2026 15:41:31 -0700
X-Gm-Features: AVHnY4L86sFPwvstwRi47J91deZeB_tEn5rDsykk8GHRpiEzaTYsrGzZ-WixK9I
Message-ID: <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Greg Ungerer <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1DC7456432A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7652-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Hi,

On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> Hi Arnd,
>
> On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > >
> > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > >

About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
i probably lost some dma config option.

> > > DSPI is using edma, i will try to understand where the issue is asap.
> > >
> > > About how it works:
> > > - for accesses to edma module (IP) mmio registers, must be native
> > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> >
> > The twist here is that with the way that readl() is defined on
> > coldfire as a non-swapping operation, and the generic
> > definition assuming the opposite in
> >
> > static inline u32 ioread32be(const void __iomem *addr)
> > {
> >         return swab32(readl(addr));
> > }
> >
> > the function called ioread32be() actually tries to access
> > the registers as little-endian. I can see two possible ways
> > we got here, but don't know which one is currect:
> >
> > a) the device actually has little-endian registers (like it
> >    does on i.MX, but unlike all other coldfire devices), and
> >    you just never noticed because using ioread32be() worked
> >    as you expected.
> >
> > b) you tested the driver using an ioread32be() definition that
> >    did not have a byteswap and it correctly accessed big-endian
> >    registers at the time, but the version in mainline today does
> >    not.
>
> Ok. The ioread32be now works properly since i had applied Greg patches.
> I generated an error in _probe on edma channel 2, reading status reg.
> looks consistent:
>
> 	iowrite16(2121, regs->erqh);
> 	iowrite8(0x77, regs->serq);
> 	iowrite8(0x12, regs->ssrt);
> 	
> 	u32 status = ioread32be(regs->es);
> 	printk("%s() status: %04x\n", __func__, status);
>
> [    0.140000] mcf_edma_probe() entering
> [    0.140000] mcf_edma_probe(): allocating data
> [    0.140000] mcf_edma_probe() status: 800012f8
>
> If i am not loosing myself in this r/w labyrinth, the path should be:
>
> 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> 2) So the ioread32be swaps the standard LE read giving BE.
>
> Am i correct ?
>
>
> >
> > > - for accessing the "tcd" memory structure, that must be, from what i
> > > remember, anyway in little endian, independently from the cpu core
> > > endiannes, this is the reason that big_endian flag is needed, it is
> > > used for tcd area accesses, so the IP module was built.
> > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> >
> > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > that is used for normal register access, so from what I can tell,
> > they always use the same endianess here.
> >
>
> If edma_readl was using
>
>         if (edma->big_endian)
>                 val = ioread32be(addr);
>
> and never changed, without Greg patch, it was likely returning little
> endian for coldfire and correct LE for other arch ? :)
>
> I remember something about tcd area was coded LE, but will investigate
> better, now i am over midnight.
>
> Regards,
> angelo
>
> >       Arnd

Regards,
angelo

