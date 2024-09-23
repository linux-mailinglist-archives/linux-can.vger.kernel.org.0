Return-Path: <linux-can+bounces-1532-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51097E985
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 12:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828E81C21767
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8AEEB5;
	Mon, 23 Sep 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iCGVjlWF"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BC197A6A
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086060; cv=none; b=T+8XnMippAiHeMr9HMMueNnKzaskLrQnpa0E5pf5v28IA/iBOeS37v77lz2BG4j+WbQpiCUWK8FDWRMOcEwHu1DKgmnGUsWmDszoNKj7jEvAd4TNqVhJu5GOCaEE51nrvtIc+bCfUgB0Y9YoruZmTJOYEqiihA456SEgUIEZeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086060; c=relaxed/simple;
	bh=QsMsDmyiALAm+LrdRvzojuyqNJiiSNMEO/DCrSy/Uf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMOWTi3pdEj81dgKYHFRXj05PLXZ6qbwOAiJcOnB+6UilBTYRICWrTqz2BAzxLkDAl6EeO2o1Ct63L6uXGKYCwAMZwXVL5HPLcNyKHF0X4FzVmsqESr2JOtqw2P8aoGL/9qvaLEIjzeotv0n5h8mmI3jXlRTqlrGiVH8M8ACkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iCGVjlWF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37a33e55d01so3089688f8f.3
        for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727086056; x=1727690856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8OS6LmHmUAzTZatG8DjSyLyLvnQ2975LqfhjuOdjIQ=;
        b=iCGVjlWFuQJFSXQKbvfqIRnBorOkY+9qwV7Jns+a+1r4FpKqm6bqkxu7U3oKLJecN6
         CiIlSHPt23JcBnTWTxoJSHL8MGZTRAVA3zTBm0FrdO31HAQwpilcOMfmuycvgAFQ4N9d
         0Sc6SrwAMagMJ9WKtU5wa5n3CDiK6iQPeGJ4lCteUrOCsi0sww0VtLZ/s8Jwmu67oZKN
         oItB+jjqAQJqKJjegReK/axQrfP6vct9A2cc9DcXhRNk7vk2wsEdcaOOEgwtP9gVNIz3
         isctILvc57pPXQWJ73n/lC8qVz4B4/OpYaTOA1wHSL3ZHpjDPgPoR0Hv3oNiF907ZFLI
         Kr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727086056; x=1727690856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8OS6LmHmUAzTZatG8DjSyLyLvnQ2975LqfhjuOdjIQ=;
        b=btgrxUn90v8ak1PqaHVgrbm/I2GXKD6tgUeXL9a3ngzBOeZXqq+0xpqxuwuvt8NPJ4
         L0n73xJr52/lk7NuDMyJuO2Q/W3CrjfWm6ItcL1xiiaGT/AewBmAg0YRUEE8jj8AbOU+
         +taoyL2ZxN4+WSPsmlVyXNOm4DojA172Nej20SRN9X+sdouIqTpe3SkNzdWP/E7GMX/v
         NvpvdkixYFgj2KW26ioIcAF4TQhftp1awcOApRlezR3fwsg8tbsC2DkH1PXfI5lxs7x5
         87/PgNnyF8EabQoAKrRT4pgcYfkaLVYW5dJWu4UEYb4qdLAq2XxC4+hz7f3PCgD5oAKO
         R7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGrqjsdaJDfaOmQWa9UV+6DCM8UCi4sm6tjrS3NSO6Y3uQCigXZNlDRM9LXFviJd2JINAm0j0phxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pvGEqWhZxt+i5vxXTbSFZl+VfrI0edE/lhWpYehEQZ67uHH4
	ss2YMn8Sk7lxUyxwZDh6frsIXMPcb9a3prvZ0hFo+gnwqmrmx6ISvPlu0pHcggs=
X-Google-Smtp-Source: AGHT+IGH6k1JLZysJokdZSUimpuHYOXbPaIWWOwnxtcyHYccscLPpevP70WI6JG6/Yz8WETvftOzcA==
X-Received: by 2002:a5d:6889:0:b0:374:c15a:8556 with SMTP id ffacd0b85a97d-37a431be67amr5696522f8f.50.1727086055387;
        Mon, 23 Sep 2024 03:07:35 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78002a4sm24275961f8f.78.2024.09.23.03.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:07:34 -0700 (PDT)
Date: Mon, 23 Sep 2024 12:07:33 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <coaa4yade2fwwfuk6xt6rqdxatuejft2wpuvuzw3dwpskjft7f@miabhan3ddgi>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <lfxoixj52ip25ys5ndhsn4jhoruucpavstwvwzygsvkmld2vxw@d7yiwmz3jb4y>
 <cc14312b391c17443a04129ae7871ae6aba43c20.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc14312b391c17443a04129ae7871ae6aba43c20.camel@ew.tq-group.com>

On Mon, Sep 23, 2024 at 11:32:49AM GMT, Matthias Schiffer wrote:
> On Mon, 2024-09-23 at 10:03 +0200, Markus Schneider-Pargmann wrote:
> > Hi Matthias,
> > 
> > On Thu, Sep 19, 2024 at 01:27:28PM GMT, Matthias Schiffer wrote:
> > > The interrupt line of PCI devices is interpreted as edge-triggered,
> > > however the interrupt signal of the m_can controller integrated in Intel
> > 
> > I have a similar patch though for a different setup (I didn't send it
> > yet). I have a tcan chip wired to a pin that is only capable of edge
> > interrupts.
> 
> Should I also change the Fixes tag to something else then?

No, my use-case wasn't explicitly supported before, so I don't consider
it to be a fix but a new feature supporting edge triggered tcan.

> 
> > 
> > > Elkhart Lake CPUs appears to be generated level-triggered.
> > > 
> > > Consider the following sequence of events:
> > > 
> > > - IR register is read, interrupt X is set
> > > - A new interrupt Y is triggered in the m_can controller
> > > - IR register is written to acknowledge interrupt X. Y remains set in IR
> > > 
> > > As at no point in this sequence no interrupt flag is set in IR, the
> > > m_can interrupt line will never become deasserted, and no edge will ever
> > > be observed to trigger another run of the ISR. This was observed to
> > > result in the TX queue of the EHL m_can to get stuck under high load,
> > > because frames were queued to the hardware in m_can_start_xmit(), but
> > > m_can_finish_tx() was never run to account for their successful
> > > transmission.
> > > 
> > > To fix the issue, repeatedly read and acknowledge interrupts at the
> > > start of the ISR until no interrupt flags are set, so the next incoming
> > > interrupt will also result in an edge on the interrupt line.
> > > 
> > > Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart Lake")
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > > 
> > > v2: introduce flag is_edge_triggered, so we can avoid the loop on !m_can_pci
> > > 
> > >  drivers/net/can/m_can/m_can.c     | 21 ++++++++++++++++-----
> > >  drivers/net/can/m_can/m_can.h     |  1 +
> > >  drivers/net/can/m_can/m_can_pci.c |  1 +
> > >  3 files changed, 18 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > > index 47481afb9add3..2e182c3c98fed 100644
> > > --- a/drivers/net/can/m_can/m_can.c
> > > +++ b/drivers/net/can/m_can/m_can.c
> > > @@ -1207,20 +1207,31 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
> > >  static int m_can_interrupt_handler(struct m_can_classdev *cdev)
> > >  {
> > >  	struct net_device *dev = cdev->net;
> > > -	u32 ir;
> > > +	u32 ir = 0, ir_read;
> > >  	int ret;
> > >  
> > >  	if (pm_runtime_suspended(cdev->dev))
> > >  		return IRQ_NONE;
> > >  
> > > -	ir = m_can_read(cdev, M_CAN_IR);
> > > +	/* For m_can_pci, the interrupt line is interpreted as edge-triggered,
> > > +	 * but the m_can controller generates them as level-triggered. We must
> > > +	 * observe that IR is 0 at least once to be sure that the next
> > > +	 * interrupt will generate an edge.
> > > +	 */
> > 
> > Could you please remove this hardware specific comment? As mentioned
> > above this will be independent of any specific hardware.
> 
> Ok.
> 
> 
> > 
> > > +	while ((ir_read = m_can_read(cdev, M_CAN_IR)) != 0) {
> > > +		ir |= ir_read;
> > > +
> > > +		/* ACK all irqs */
> > > +		m_can_write(cdev, M_CAN_IR, ir);
> > > +
> > > +		if (!cdev->is_edge_triggered)
> > > +			break;
> > > +	}
> > > +
> > >  	m_can_coalescing_update(cdev, ir);
> > >  	if (!ir)
> > >  		return IRQ_NONE;
> > >  
> > > -	/* ACK all irqs */
> > > -	m_can_write(cdev, M_CAN_IR, ir);
> > > -
> > >  	if (cdev->ops->clear_interrupts)
> > >  		cdev->ops->clear_interrupts(cdev);
> > >  
> > > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> > > index 92b2bd8628e6b..8c17eb94d2f98 100644
> > > --- a/drivers/net/can/m_can/m_can.h
> > > +++ b/drivers/net/can/m_can/m_can.h
> > > @@ -99,6 +99,7 @@ struct m_can_classdev {
> > >  	int pm_clock_support;
> > >  	int pm_wake_source;
> > >  	int is_peripheral;
> > > +	bool is_edge_triggered;
> > 
> > To avoid confusion could you rename it to irq_edge_triggered or
> > something similar, to make clear that it is not about the chip but the
> > way the interrupt line is connected?
> 
> Will do.
> 
> > 
> > Also I am not sure it is possible, but could you use
> > irq_get_trigger_type() to see if it is a level or edge based interrupt?
> > Then we wouldn't need this additional parameter at all and could just
> > detect it in m_can.c.
> 
> Unfortunately that doesn't seem to work. irq_get_trigger_type() only returns a meaningful value
> after the IRQ has been requested. I thought about requesting the IRQ with IRQF_NO_AUTOEN and then
> filling in the irq_edge_triggered field before enabling the IRQ, but IRQF_NO_AUTOEN is incompatible
> with IRQF_SHARED.

The mentioned function works for me on ARM and DT even before
irq_request_threaded_irq() was called.

Also I am probably missing something here. Afer requesting the irq, the
interrupts are not enabled yet right? So can't you just request it and
check the triggertype immediately afterwards?

> 
> Of course there are ways around this - checking irq_get_trigger_type() from the ISR itself, or
> adding more locking, but neither seems quite worthwhile to me. Would you agree with this?
> 
> Maybe there is some other way to find out the trigger type that would be set when the IRQ is
> requested? I don't know what that would be however - so I'd just keep setting the flag statically
> for m_can_pci and leave a dynamic solution for future improvement.

No if it doesn't work easily the parameter is probably the best option.

Best
Markus

> 
> Matthias
> 
> 
> 
> > 
> > Best
> > Markus
> > 
> > >  
> > >  	// Cached M_CAN_IE register content
> > >  	u32 active_interrupts;
> > > diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> > > index d72fe771dfc7a..f98527981402a 100644
> > > --- a/drivers/net/can/m_can/m_can_pci.c
> > > +++ b/drivers/net/can/m_can/m_can_pci.c
> > > @@ -127,6 +127,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
> > >  	mcan_class->pm_clock_support = 1;
> > >  	mcan_class->pm_wake_source = 0;
> > >  	mcan_class->can.clock.freq = id->driver_data;
> > > +	mcan_class->is_edge_triggered = true;
> > >  	mcan_class->ops = &m_can_pci_ops;
> > >  
> > >  	pci_set_drvdata(pci, mcan_class);
> > > -- 
> > > TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> > > Amtsgericht München, HRB 105018
> > > Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> > > https://www.tq-group.com/
> > > 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/

