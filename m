Return-Path: <linux-can+bounces-7692-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPznGttuE2oCBAcAu9opvQ
	(envelope-from <linux-can+bounces-7692-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 23:34:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C75C4602
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 041783002F49
	for <lists+linux-can@lfdr.de>; Sun, 24 May 2026 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E63F332EC8;
	Sun, 24 May 2026 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dI9Wx9Il"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DE3382E8
	for <linux-can@vger.kernel.org>; Sun, 24 May 2026 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658451; cv=pass; b=uTFG+vXHIo4QCNfaOnGLqq4h+Va5tdrgiyMzZWdrpjb+GP6oqdvayD/PCAEpREcem3i0+6GNrntDgN9mdgTzXZzKlWWipwSrjQWIt8Ty9Opnl4zU6FGohoy0Hcmp4x5E19Lmqc3kWVPr9c1vEjUFfvXc2kuoFuGI1bE/7XIJYqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658451; c=relaxed/simple;
	bh=scbTGzWKrkbb2tr2ByuUctuCpzVcmORNYkqkGCRtn9g=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKM60BV6+Bbz1U0Hig6HdpTRPHICqcl/G8MDJtmoQvv7BNN1sICLX6iaPq5jdJY4JH+TQIJmlSHnOFz8y7/+h7QFt+vGsCNT9qWIVJNXn6gq/vtrDDBlZyg+VMG/Y0i9Y6CkOiBBaoIBooSGk02xoMLr5EdT5OWcpdZBXUeuD7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dI9Wx9Il; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd9a71b565aso988535566b.0
        for <linux-can@vger.kernel.org>; Sun, 24 May 2026 14:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779658444; cv=none;
        d=google.com; s=arc-20240605;
        b=QtrOLpBKwVgWNxuQuaCKSSfuG4khxyvX4VokdfGMXNkD3m9NVj0Hsmf953kC1nk9I7
         P0YRJj9ZmmA5jD3pEEB21Zy3XFPb7mFh2P7ruvNlSbnGRG3xDgJgWsPuPi9YuifUPQaz
         u7JxOGXcSv3EGj/TS+LvoqI+wKyf3qVtp5E4Ki35MWII0sOqB/eZDoStpzkjaINFpbUU
         BCnIN21S5Xz/GDZ3cObEzqMeR5yAal9UaGYhvGdPgkP4c/Z8Hauhpv3pAlPe2NOEONB4
         rQetwhqnKKiGWGDkD7FvknPyvt+pQxHJIeJ6MvTuaXHbZ95/1kTiW+hZePf5dDScoax4
         sG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=4v82pm3nplUGvi0gYlaKk5FJ7bsCM62ozlNkSbZa6Zs=;
        fh=iQZvxHYDz2txmfedm1TMm7uQrcL3htit0rzLrHL88as=;
        b=Ta8SQNOiRyi2h+MkfcxD9e7s9Q9kcFF3UR08r6oYxIgctyhvxCZ8nwvwz39YYsstr2
         TgCfsDYhoPgwwnZWrtMk+7oBhXdXdu9xuxq998pHi8vkEWh4KX+l6PswzW4bw1NsBj0m
         FSAd9ywLuJcmFLxff3bjF6no1vj6WXN4PyFDbXNkmyeVsEhDy+S4G5184FNgp7M+vDNC
         WwG7Nn7ewmk5+BNPul/Oozt8HPrmXqhkqhPR0h/nUdKSRFB9BQsKRFlRS6RxDoJ4oWHM
         H3EBh1xopXCyHUDRc97LLe8qWKMXXRS4YsUwPgndloy9RCylKTKVj9MyEcRt17lNdjB6
         5w0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779658444; x=1780263244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4v82pm3nplUGvi0gYlaKk5FJ7bsCM62ozlNkSbZa6Zs=;
        b=dI9Wx9IlulTxnU50+ZCYg+ivBJ1CYKYps37HKVNJlAPnF/3s0QcWVS6qRlYQLRZztF
         Qfaqqlhn81vKV7JwfXqgyFaq3v5TGk3AtpGsk0zfVRWmEWagwV8v7wxK6auGypZ4zCYo
         HsrCYFAiImlqmDryLWoGq86hmmiPPAo54Ow1TrdjHoH6QNQDd6puhS9wKwPAdsEs1Hqo
         0V/hfUr+fBBWFr9bIcQ6SDoye43O1UXvzbjlSc94ZrfLmYZi/RM+fymy//YKn3AG/EZ0
         vCiBWKL/XTBaXL05OTbFMEs1z6su13MD3epDofxSLJZCmurdfhdDxhNwy9rL5QidxmZ3
         0AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779658444; x=1780263244;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4v82pm3nplUGvi0gYlaKk5FJ7bsCM62ozlNkSbZa6Zs=;
        b=GC+X2zIMfn3lkPR2sR9HBewK+80IgxkV0VaY/EWPE5bukLsD3xvO6WnuztH+yrhpQo
         nbwNWaF6BVq3yNZCyfxqb1s0Phv1VPDT4jmLrVdq+vPYPLVvomc+PCe27ifAEBIzabRT
         QaDi1+ZJq5yIomNSwzfkzdUlH7QQB6E7+FnpnuY4jkCvLMqSI6cCr7gYHvbSBqZePIyQ
         Ko7IOr+SOxCqNCOX+5eeuZ2wMF5vEQMogJkA+O4COWtPbpwayplf8sqWGHVqnGKTeHZS
         ASleNCiNxFVni1NbFF06P0Bugvwaplgc5XFV69UyAKBhJG4nsA+1JuSiYEliIbxa2Omi
         xlJA==
X-Forwarded-Encrypted: i=1; AFNElJ+c6TIz1CDmQ0khnwSKNd5NN2JfGdpY4LSBtg7DAhGg1G1b5yH7kx4U4jvYNGevUSSRuqanMqQP/EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QUC/Oa39rJO6UB81lXSzLX9XdRxo9FTQJpZfoEJxhtfwttkD
	nP2A+V1KJYBPi/2r3Q0Leq5YjUE2TfEBC67U+3PshQpOu6f6SGgP+nDHoY7y57F0clYPztKpKQg
	EkBZfucUfPwS4+SI/hFmn2qqiwNwwOV3RzkEcEtigTA==
X-Gm-Gg: Acq92OHqGSBL7SVS+wa6vmCXBQdHoJf4aO5mXlesQ0UCpvyL30uGcGXX3+AQ7Jodl4K
	xUnLUw1tbyX8pY/V+C40dWwu17u3DkM0bZiyznSqr/2ubS7VzqTASWwBd6Zd9TuUMYkBWyf3NNW
	PCg5q0kr3SeSSyhjn62DZtXDDIp7D3fDLCSXyJhJYIRk9NX4oj9p6ZAFIdkYAtg+zyq5ttSfz3I
	tmFWu/vJp42I74Yh2U5QRp7r63cNg8Jv8Idq9JsV94AHjxzTgA1tbt+mwHD7CGCvYBqfpkHNH0q
	ED9CtoGFGPGai00PyThgv3QfDZZYCcrwkGMvL936Pudx6rA=
X-Received: by 2002:a17:907:75f8:b0:bc6:1c2:ee46 with SMTP id
 a640c23a62f3a-bdd22e30ca3mr532419766b.11.1779658443593; Sun, 24 May 2026
 14:34:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 16:34:03 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 16:34:03 -0500
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com> <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
Date: Sun, 24 May 2026 16:34:03 -0500
X-Gm-Features: AVHnY4KPts6giB7v-VLhDVFgaj3UBt2D1rd6Lp0dLsbZHZD9ROK0A3o-BziA5dQ
Message-ID: <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Greg Ungerer <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7692-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,baylibre.com:dkim,lst.de:email]
X-Rspamd-Queue-Id: 6E8C75C4602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 02:17:07PM -0700, Angelo Dureghello wrote:
> Hi All,
>
> On Sun, May 17, 2026 at 03:41:31PM -0700, Angelo Dureghello wrote:
> > Hi,
> >
> > On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> > > Hi Arnd,
> > >
> > > On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > > > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > > > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > > > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > > > >
> > > > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > > > >
> >
> > About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
> > i probably lost some dma config option.
> >
>
> so i worked on this open issue above:
>
> - moved to master and rebased,
> - crated a wip/edma branch,
> - bisected and found the offending commit, before this, mcf-edma driver
>   and connected spi-fsl-dspi (using edma) was both working correctly.
>
> 7a360df941a4bd60847208de59f1ac8b166265a2 is the first bad commit
> commit 7a360df941a4bd60847208de59f1ac8b166265a2 (HEAD)
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Oct 12 09:52:27 2023 +0200
>
>     m68k: don't provide arch_dma_alloc for nommu/coldfire
>
>     Coldfire cores configured with a data cache can't provide coherent
>     DMA allocations at all.
>
>     Instead of returning non-coherent kernel memory in this case,
>     return NULL and fail the allocation.
>
>     The only driver that used to rely on the previous behavior (fec) has
>     been switched to use non-coherent allocations for this case recently.
>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
>     Tested-by: Greg Ungerer <gerg@linux-m68k.org>
>
>  arch/m68k/Kconfig      |  1 -
>  arch/m68k/kernel/dma.c | 23 -----------------------
>  2 files changed, 24 deletions(-)
>
> So i can try next week a patch for edma looking what has been done
> in fec, and since i am probably the only with mcf54415, will test it
> here.
>

Looking into this better, looks like the above commit was meant for the
majority on non-mmu ColdFire. I think mcf5441x and some other with mmu
enabled can flag pages as "page cache disabled".

So i would re-enabled that code only for such mmu families.

Please let me know if i am correct.
Thanks.

> > > > > DSPI is using edma, i will try to understand where the issue is asap.
> > > > >
> > > > > About how it works:
> > > > > - for accesses to edma module (IP) mmio registers, must be native
> > > > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> > > >
> > > > The twist here is that with the way that readl() is defined on
> > > > coldfire as a non-swapping operation, and the generic
> > > > definition assuming the opposite in
> > > >
> > > > static inline u32 ioread32be(const void __iomem *addr)
> > > > {
> > > >         return swab32(readl(addr));
> > > > }
> > > >
> > > > the function called ioread32be() actually tries to access
> > > > the registers as little-endian. I can see two possible ways
> > > > we got here, but don't know which one is currect:
> > > >
> > > > a) the device actually has little-endian registers (like it
> > > >    does on i.MX, but unlike all other coldfire devices), and
> > > >    you just never noticed because using ioread32be() worked
> > > >    as you expected.
> > > >
> > > > b) you tested the driver using an ioread32be() definition that
> > > >    did not have a byteswap and it correctly accessed big-endian
> > > >    registers at the time, but the version in mainline today does
> > > >    not.
> > >
> > > Ok. The ioread32be now works properly since i had applied Greg patches.
> > > I generated an error in _probe on edma channel 2, reading status reg.
> > > looks consistent:
> > >
> > > 	iowrite16(2121, regs->erqh);
> > > 	iowrite8(0x77, regs->serq);
> > > 	iowrite8(0x12, regs->ssrt);
> > > 	
> > > 	u32 status = ioread32be(regs->es);
> > > 	printk("%s() status: %04x\n", __func__, status);
> > >
> > > [    0.140000] mcf_edma_probe() entering
> > > [    0.140000] mcf_edma_probe(): allocating data
> > > [    0.140000] mcf_edma_probe() status: 800012f8
> > >
> > > If i am not loosing myself in this r/w labyrinth, the path should be:
> > >
> > > 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> > > 2) So the ioread32be swaps the standard LE read giving BE.
> > >
> > > Am i correct ?
> > >
> > >
> > > >
> > > > > - for accessing the "tcd" memory structure, that must be, from what i
> > > > > remember, anyway in little endian, independently from the cpu core
> > > > > endiannes, this is the reason that big_endian flag is needed, it is
> > > > > used for tcd area accesses, so the IP module was built.
> > > > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> > > >
> > > > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > > > that is used for normal register access, so from what I can tell,
> > > > they always use the same endianess here.
> > > >
> > >
> > > If edma_readl was using
> > >
> > >         if (edma->big_endian)
> > >                 val = ioread32be(addr);
> > >
> > > and never changed, without Greg patch, it was likely returning little
> > > endian for coldfire and correct LE for other arch ? :)
> > >
> > > I remember something about tcd area was coded LE, but will investigate
> > > better, now i am over midnight.
> > >
> > > Regards,
> > > angelo
> > >
> > > >       Arnd
> >
> > Regards,
> > angelo
>
> Regards,
> angelo

Regards,
angelo

