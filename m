Return-Path: <linux-can+bounces-7825-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UbU9Gq65Kmo/vwMAu9opvQ
	(envelope-from <linux-can+bounces-7825-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 11 Jun 2026 15:35:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCE36725E4
	for <lists+linux-can@lfdr.de>; Thu, 11 Jun 2026 15:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7825-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7825-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AAB3307F490
	for <lists+linux-can@lfdr.de>; Thu, 11 Jun 2026 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6330C158;
	Thu, 11 Jun 2026 13:35:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A630BF6D;
	Thu, 11 Jun 2026 13:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184908; cv=none; b=XeyfJa6WLU+VjYgRAKT0cmpol0wYe8mpmOzZ+q7OR072oq2NiON0Z+62qJkfpw/pOA7+bFD+MKXJYNLb6r/u/iNFILUcHuqD8vLcSJR6d4vrC27i30a+ECpYNf+Pi8yG/gUyB1ttYJ1nqaqq0tSLoyaPqlR8V7YcTWkvNf18uZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184908; c=relaxed/simple;
	bh=FYwxNJ0xHvKX+gcSgo8bX/DOL+pH5bvSGrjcXnMehGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQzWyK9XrRVl65OcwOfLz+gGbYcJ63ApchYcBA4KlvvA04P/MJViCCOmoybJJL6WSnCL5UCX6VH7OxBXQP1KyTOW/zj5hO229cGtzixHpS+cbug7kbRbqQwSvWGDsWDE27Qol+AdkwgWcKpT7+b1M0VQuzlK1KUHYoncu04M8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12831F00893;
	Thu, 11 Jun 2026 13:35:04 +0000 (UTC)
Message-ID: <937086f1-5158-41e9-9194-b6d1feaee17f@linux-m68k.org>
Date: Thu, 11 Jun 2026 23:35:02 +1000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: sashiko-reviews@lists.linux.dev
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Frank.Li@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>, imx@lists.linux.dev,
 Angelo Dureghello <adureghello@baylibre.com>
References: <20260609142139.1563360-6-gerg@linux-m68k.org>
 <20260610142725.031C31F0089A@smtp.kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260610142725.031C31F0089A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7825-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:Frank.Li@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:imx@lists.linux.dev,m:adureghello@baylibre.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gerg@linux-m68k.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@linux-m68k.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-m68k.org:email,linux-m68k.org:mid,linux-m68k.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DCE36725E4

Hi Sashiko-bot,

On 11/6/26 00:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The transition to asm-generic readX()/writeX() changes the endianness of ColdFire internal IO accesses, breaking unpatched ColdFire drivers.
> 
> Pre-existing issues:
> - [High] Undefined behavior when shifting 1 by 32 or more using `BIT(ch)` in `mcf_edma_tx_handler`.
> - [High] The error interrupt handler incorrectly skips handling high channels and returns `IRQ_NONE` after servicing low channels.
> --
> 
> commit 25193db3eba89f780b6dc534f2f72e16f3429571
> Author: Greg Ungerer <gerg@linux-m68k.org>
> 
> m68k: coldfire: fix non-standard readX()/writeX() functions
> 
> Remove the local ColdFire definitions of readb()/readw()/readl() and
> writeb()/writew()/writel() and use the asm-generic versions of them.
> 
>> diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
>> index 4f0f34b06e37c..2f12f4ed0da54 100644
>> --- a/arch/m68k/include/asm/io_no.h
>> +++ b/arch/m68k/include/asm/io_no.h
> 
> [ ... ]
> 
>> -#define writel writel
>> -static inline void writel(u32 value, volatile void __iomem *addr)
>> -{
>> -	if (cf_internalio(addr))
>> -		__raw_writel(value, addr);
>> -	else
>> -		__raw_writel(swab32(value), addr);
>> -}
> 
> [Severity: High]
> Does replacing the local readX()/writeX() with the asm-generic versions
> change the endianness of unpatched ColdFire drivers?
> 
> The old ColdFire implementation detected internal IO memory using
> cf_internalio() and bypassed byte-swapping to provide native big-endian
> access. The asm-generic accessors always assume little-endian devices and
> perform byte-swapping.
> 
> Will unpatched drivers relying on readX()/writeX() for internal IO
> (such as spi-coldfire-qspi.c, sdhci-esdhc-mcf.c, or fec_main.c) now read
> and write byte-swapped values and malfunction?

This is of course a real problem, and much effort has been expended to
find and fix affected drivers. Specifically here:

     patch 1 in this series fixes fec_main.c
     patch 3 in this series fixes sdhci-esdhc-mcf.c
     patch 4 (this patch) fixes spi-coldfire-qspi.c with the endian change to spi-fsl-dspi.c

Not mentioned here, but patch 2 in this series fixes the smc91x driver.

It is not believed at this time that any other drivers are affected.


> [ ... ]
> 
>> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
>> index 9e1c6400c77be..4ed0ce644e37e 100644
>> --- a/drivers/dma/mcf-edma-main.c
>> +++ b/drivers/dma/mcf-edma-main.c
>> @@ -21,9 +21,9 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
>>   	unsigned int ch;
>>   	u64 intmap;
>>   
>> -	intmap = ioread32(regs->inth);
>> +	intmap = ioread32be(regs->inth);
>>   	intmap <<= 32;
>> -	intmap |= ioread32(regs->intl);
>> +	intmap |= ioread32be(regs->intl);
>>   	if (!intmap)
>>   		return IRQ_NONE;
> 
> [Severity: High]
> This is a pre-existing issue, but does this shift invoke undefined behavior
> for higher channels?
> 
> Looking at the loop immediately following this in mcf_edma_tx_handler():
> 
> 	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
> 		if (intmap & BIT(ch)) {
> 			...
> 
> On a 32-bit architecture like m68k, BIT(ch) expands to a 32-bit unsigned
> long. Since ch can be up to 64, shifting by 32 or more would be undefined,
> potentially causing channels 32-63 to be improperly processed or missing
> their interrupts entirely.
> 
> Should this use BIT_ULL(ch) when testing against the 64-bit intmap?
> 
> [ ... ]
> 
>> @@ -43,7 +43,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>>   	struct edma_regs *regs = &mcf_edma->regs;
>>   	unsigned int err, ch;
>>   
>> -	err = ioread32(regs->errl);
>> +	err = ioread32be(regs->errl);
>>   	if (!err)
>>   		return IRQ_NONE;
> 
> [Severity: High]
> This is a pre-existing issue, but does this early return incorrectly skip
> handling high channels?
> 
> If regs->errl is zero, it returns IRQ_NONE immediately, ignoring any errors
> in regs->errh. This could leave errors in higher channels uncleared.
> 
> [ ... ]
> 
>> @@ -55,7 +55,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>>   		}
>>   	}
>>   
>> -	err = ioread32(regs->errh);
>> +	err = ioread32be(regs->errh);
>>   	if (!err)
>>   		return IRQ_NONE;
> 
> [Severity: High]
> This is a pre-existing issue, but does this return the wrong IRQ status if
> low channel errors were already handled?
> 
> If errl was non-zero (so some errors were handled) but errh is zero,
> returning IRQ_NONE here instead of IRQ_HANDLED might incorrectly signal
> to the IRQ subsystem that the interrupt wasn't handled at all.

At casual inspection these may well be real problems. I will have to defer
to the driver author and current maintainers for them to fix. The changes
to fix ColdFire readl()/writel() have no effect on these, and are really
outside of the scope of this series.

Thanks for the review!

Regards
Greg





