Return-Path: <linux-can+bounces-1528-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E4C97E71B
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 10:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8114B281647
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9657C8D;
	Mon, 23 Sep 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IYPV7qen"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A529CE7
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078611; cv=none; b=J0wfHAylBFvh6o5fJZN5NUZSedlEs5R4qL7Es5CgG+EnHmG4PDZFT5nL81tIWwTu07NmKIrzPhmiwIxEYKoR8pz0Rdyt7k1Yjbw+wa+6Ykwn4/KMDdpGIYBChkXlF8boaTh8nBz5s+DxA/iOv4SAZ/jMyZay9mCrD48BTKPg9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078611; c=relaxed/simple;
	bh=GwNpRN9Ia//eGhoOvkXyPR3C+/ubtmki7nlMjCEtOBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4j9iSOPy06ofwi2TwNwuy5M1YExuRTj3namPbz4/7G30tbSQ2owROPlT91PlkYbukXDDYCTqCEDwXNGJWYxA2kMGn1cFdoXOLw4bnh6WoKyAX9jcOWaB5/4g/mvrk63Fo0/bv2atVUsCFQkgrKpqAZnJdb4AWGGvSF349+lewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IYPV7qen; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so33998325e9.3
        for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727078606; x=1727683406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AS1YGLESr66CwU5htWDLh9LmbKz8Ti7nxg9OKc42pZc=;
        b=IYPV7qeniAdtYVS0eUvlmr4M9eb5MRRwneqig1lzvQF85S+hs7SfSgPRtDZnAPmdlL
         iCFoRA6p/EGKI5i5cBewb9fJOUzlVi8OwRVgLgmfvUL6VFn9HN9Aw58dWAfZzCPu2+g2
         e6nTXpOmwyL4I2o0CGuDon/7bloN49zQT8CTIpsadlISPt8l2V4J19/2ZbINjoHjVKfQ
         6FRTy+/Cun4id6Cy05qUN/1KebQvYoqMUfYQkIxTKnA3fHouJ+LSo1whVpqT8DSWgl5i
         8/TZF7FylDUSg4/1TpSN/Tsc3qr0dbJguUoXE9yKYRGzEb+zGBjVJ1dQeV7D70lnqkE+
         Rsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727078606; x=1727683406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS1YGLESr66CwU5htWDLh9LmbKz8Ti7nxg9OKc42pZc=;
        b=XmVrWf159paqU1zOMPp+Mjccn1Ofufyft7oZuCtIN357zeaykmgvraTTzm8Zz387+F
         BDwneBaW9GufqiXHntCdLcZHstyTTEqPKVHd82U9+CaAJ1p/iI/3cYUB3BtlW5OjMq+2
         dmgPbiuYEKolr0uCe3/8dm/+0GrfCC8YPwmWLNTJKFnO6Pc+jklWA18cDJv7vN9b8LGI
         mJTyc8NJB3k6relSJDF+ovdghFo+u4IvQea7AaFmYvpKlsJd75Zh9mHXIKpAcosq7T8z
         9q0Bg0TITZVivYdwP9QXNZtjnhwSm5HR0612NZmSKmYjP8Y7IbxBtK3MqmZt6yY5IajZ
         pNuw==
X-Forwarded-Encrypted: i=1; AJvYcCVjBJb0c43wx27/QMdpmDYl8L54LRgusquO+KQm4Yml8hguCDKgDW6REkNKMfmWoBYZI2qFzG+iSV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfQa3ZdZwcT+dzIruLfhLyUf2loMPT/QdTQXVevRdQ5GApbVp
	6FwfpnkU9ew7lwJ0gXNcUgVhp4mZ119PNokfGqg/hkH+kh0Wd5MKlSnU0U+V+nc=
X-Google-Smtp-Source: AGHT+IHTncjAi8IrfRyguWXho+5u/eMFHujSEye/2QshGz1QTBkYZBuoe9Ll5mByz+c1HoBT/ZONOg==
X-Received: by 2002:a05:600c:4ed0:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42e7abeda5amr85057515e9.8.1727078606031;
        Mon, 23 Sep 2024 01:03:26 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e4e1sm119370035e9.10.2024.09.23.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:03:25 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:03:24 +0200
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
Message-ID: <lfxoixj52ip25ys5ndhsn4jhoruucpavstwvwzygsvkmld2vxw@d7yiwmz3jb4y>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>

Hi Matthias,

On Thu, Sep 19, 2024 at 01:27:28PM GMT, Matthias Schiffer wrote:
> The interrupt line of PCI devices is interpreted as edge-triggered,
> however the interrupt signal of the m_can controller integrated in Intel

I have a similar patch though for a different setup (I didn't send it
yet). I have a tcan chip wired to a pin that is only capable of edge
interrupts.

> Elkhart Lake CPUs appears to be generated level-triggered.
> 
> Consider the following sequence of events:
> 
> - IR register is read, interrupt X is set
> - A new interrupt Y is triggered in the m_can controller
> - IR register is written to acknowledge interrupt X. Y remains set in IR
> 
> As at no point in this sequence no interrupt flag is set in IR, the
> m_can interrupt line will never become deasserted, and no edge will ever
> be observed to trigger another run of the ISR. This was observed to
> result in the TX queue of the EHL m_can to get stuck under high load,
> because frames were queued to the hardware in m_can_start_xmit(), but
> m_can_finish_tx() was never run to account for their successful
> transmission.
> 
> To fix the issue, repeatedly read and acknowledge interrupts at the
> start of the ISR until no interrupt flags are set, so the next incoming
> interrupt will also result in an edge on the interrupt line.
> 
> Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart Lake")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: introduce flag is_edge_triggered, so we can avoid the loop on !m_can_pci
> 
>  drivers/net/can/m_can/m_can.c     | 21 ++++++++++++++++-----
>  drivers/net/can/m_can/m_can.h     |  1 +
>  drivers/net/can/m_can/m_can_pci.c |  1 +
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 47481afb9add3..2e182c3c98fed 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1207,20 +1207,31 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
>  static int m_can_interrupt_handler(struct m_can_classdev *cdev)
>  {
>  	struct net_device *dev = cdev->net;
> -	u32 ir;
> +	u32 ir = 0, ir_read;
>  	int ret;
>  
>  	if (pm_runtime_suspended(cdev->dev))
>  		return IRQ_NONE;
>  
> -	ir = m_can_read(cdev, M_CAN_IR);
> +	/* For m_can_pci, the interrupt line is interpreted as edge-triggered,
> +	 * but the m_can controller generates them as level-triggered. We must
> +	 * observe that IR is 0 at least once to be sure that the next
> +	 * interrupt will generate an edge.
> +	 */

Could you please remove this hardware specific comment? As mentioned
above this will be independent of any specific hardware.

> +	while ((ir_read = m_can_read(cdev, M_CAN_IR)) != 0) {
> +		ir |= ir_read;
> +
> +		/* ACK all irqs */
> +		m_can_write(cdev, M_CAN_IR, ir);
> +
> +		if (!cdev->is_edge_triggered)
> +			break;
> +	}
> +
>  	m_can_coalescing_update(cdev, ir);
>  	if (!ir)
>  		return IRQ_NONE;
>  
> -	/* ACK all irqs */
> -	m_can_write(cdev, M_CAN_IR, ir);
> -
>  	if (cdev->ops->clear_interrupts)
>  		cdev->ops->clear_interrupts(cdev);
>  
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 92b2bd8628e6b..8c17eb94d2f98 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -99,6 +99,7 @@ struct m_can_classdev {
>  	int pm_clock_support;
>  	int pm_wake_source;
>  	int is_peripheral;
> +	bool is_edge_triggered;

To avoid confusion could you rename it to irq_edge_triggered or
something similar, to make clear that it is not about the chip but the
way the interrupt line is connected?

Also I am not sure it is possible, but could you use
irq_get_trigger_type() to see if it is a level or edge based interrupt?
Then we wouldn't need this additional parameter at all and could just
detect it in m_can.c.

Best
Markus

>  
>  	// Cached M_CAN_IE register content
>  	u32 active_interrupts;
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> index d72fe771dfc7a..f98527981402a 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -127,6 +127,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	mcan_class->pm_clock_support = 1;
>  	mcan_class->pm_wake_source = 0;
>  	mcan_class->can.clock.freq = id->driver_data;
> +	mcan_class->is_edge_triggered = true;
>  	mcan_class->ops = &m_can_pci_ops;
>  
>  	pci_set_drvdata(pci, mcan_class);
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 

