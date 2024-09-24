Return-Path: <linux-can+bounces-1549-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A777A983CAA
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 08:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C9F1F2238F
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D785FEE4;
	Tue, 24 Sep 2024 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xWqndHAx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97953370
	for <linux-can@vger.kernel.org>; Tue, 24 Sep 2024 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158095; cv=none; b=hkUuJJw+ezkIMLtQKc5SWb2V6kBcQO1tmYRNCEnolQbGA2AJQJtZ2KfkInessBPFBK50v1LDrKBWMNKlfr3oIqKqOLy5uVyfbXwcwqDtFHAJWvBctpOF0SpBRHafpIKf79wuLD4EVfRiIMc0iXmD24d+tf/hCrdFsKcFM239spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158095; c=relaxed/simple;
	bh=gDW51VJPoXNQgg+K5Mw5ZlfbpYrIZ9JbXKBia32d0+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo27RzhesaIrr1+ZiYDrCLlOVp+srEuGeTxgMXNXnKMIlqiumvQlod5mQuNiu5sOyjYgg6Q49JAW5ZLIrS74jdLCq0F5DeKfHs7ce6zeAG0X/vjBAmq3tyRPyDUFUkCQtKid6jKnj8cfSWgEP0DHVL4DauS5sIUoAP6QLDy9mFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xWqndHAx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so41152205e9.1
        for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727158090; x=1727762890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VzFo2I1E2rP8+5n9kj14nz0J+HvkgPte4rz85u/uQJE=;
        b=xWqndHAx8cFJs29wfaen/8ExQ9+b5ESrh4k2mn9n8/mj7SgsmO2wO9YqysmWNVK4b1
         g1kJbvfMHFvEFwn3dCzQQH2xIkR0oAZ6M0hCqFdR3ZqmoKCV6T5L9J630yp1nJYEjBG7
         O9y/GZoZ9kAoxtX/ZsTW7Shv5ogOVLSHVJkPV6TXlTSp0LWlh0UBHyn8jXMEhaLf89R+
         jAwsMGEEQIsyJFs/fLMY6P4UN0nzsMT/Kg5yaA1Y0GQuPfp8K4CdsHONhqeXz2ommxAR
         CJKI+i6fYMrW9wmAPC/tFzBhQJLNxpPdb70SeONVMO7x3P/QTQjsAWcxwQOQYcLAfdyr
         2eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158090; x=1727762890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzFo2I1E2rP8+5n9kj14nz0J+HvkgPte4rz85u/uQJE=;
        b=a+Sv0LtkjxWAwFJFpaB2OCm5oNbYXyV0KHUjyY2wLGWUqgXDMMcLSKb/4yOi8RuJ50
         QW0vUtIxy04FVAii0UYLr5w2aY7qm6WI33t7GzCL8yCb1LSWNzSSRPnXDofTWN3NODaj
         RhSa1ulGuRYSuroSISbz591fDHJwZRopdZnaCLcYD+GQ5PoLQXSi6vBnRVhCFENdXNnC
         E5GYZRCZfCDJDpUHbDMkAGwk8kdLDGEiHm9C+VzxhCWVh67i9YyLu0UGOa4hxz7yH6Md
         snh6w33pVW4gQFGR9Gfk1ROAQmLLuUWtunOn3KwoGmUCnRdTvl3R78mP9NQ3tqRUn5XG
         RDXw==
X-Forwarded-Encrypted: i=1; AJvYcCUgcmPVfANgJvdQfuLIJWC9LyzB+OR8c2SY/YRBi/xacK3NMKSKwyaFgIkTjU1Uz49X9OEEwnheHXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAq43SNeIG6p30Mja8slkmSStW2wUgdiJKFB4+jjzgrNstHrfA
	rjVWdnikW9L+az0D1Q4VgJK6TOxVvqWY4MyGxDVzT69lJ4qitCDuvzU0JymbjN8=
X-Google-Smtp-Source: AGHT+IFIjkRUSoZ0ykhdCmCTbZ7FojC7Aoo7miCt4ja9O8VZx4rPyeNb8Il00ud5ZJI/VjGVgBeTJQ==
X-Received: by 2002:a5d:54c3:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-37a4234d339mr6917282f8f.45.1727158089812;
        Mon, 23 Sep 2024 23:08:09 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f976esm662656f8f.69.2024.09.23.23.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:08:09 -0700 (PDT)
Date: Tue, 24 Sep 2024 08:08:08 +0200
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
Subject: Re: [PATCH v3 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <6qk7fmbbvi5m3evyriyq4txswuzckbg4lmdbdkyidiedxhzye5@av3gw7vweimu>
References: <ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
 <4715d1cfed61d74d08dcc6a27085f43092da9412.1727092909.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4715d1cfed61d74d08dcc6a27085f43092da9412.1727092909.git.matthias.schiffer@ew.tq-group.com>

On Mon, Sep 23, 2024 at 05:32:16PM GMT, Matthias Schiffer wrote:
> The interrupt line of PCI devices is interpreted as edge-triggered,
> however the interrupt signal of the m_can controller integrated in Intel
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

Just a few comment nitpicks below. Otherwise:

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
> 
> v2: introduce flag is_edge_triggered, so we can avoid the loop on !m_can_pci
> v3:
> - rename flag to irq_edge_triggered
> - update comment to describe the issue more generically as one of systems with
>   edge-triggered interrupt line. m_can_pci is mentioned as an example, as it
>   is the only m_can variant that currently sets the irq_edge_triggered flag.
> 
>  drivers/net/can/m_can/m_can.c     | 22 +++++++++++++++++-----
>  drivers/net/can/m_can/m_can.h     |  1 +
>  drivers/net/can/m_can/m_can_pci.c |  1 +
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index c85ac1b15f723..24e348f677714 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1207,20 +1207,32 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
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
> +	/* The m_can controller signals its interrupt status as a level, but
> +	 * depending in the integration the CPU may interpret the signal as
                 ^ on?

> +	 * edge-triggered (for example with m_can_pci).
> +	 * We must observe that IR is 0 at least once to be sure that the next

As the loop has a break for non edge-triggered chips, I think you should
include that in the comment, like 'For these edge-triggered
integrations, we must observe...' or something similar.

Best
Markus

> +	 * interrupt will generate an edge.
> +	 */
> +	while ((ir_read = m_can_read(cdev, M_CAN_IR)) != 0) {
> +		ir |= ir_read;
> +
> +		/* ACK all irqs */
> +		m_can_write(cdev, M_CAN_IR, ir);
> +
> +		if (!cdev->irq_edge_triggered)
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
> index 92b2bd8628e6b..ef39e8e527ab6 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -99,6 +99,7 @@ struct m_can_classdev {
>  	int pm_clock_support;
>  	int pm_wake_source;
>  	int is_peripheral;
> +	bool irq_edge_triggered;
>  
>  	// Cached M_CAN_IE register content
>  	u32 active_interrupts;
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> index d72fe771dfc7a..9ad7419f88f83 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -127,6 +127,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	mcan_class->pm_clock_support = 1;
>  	mcan_class->pm_wake_source = 0;
>  	mcan_class->can.clock.freq = id->driver_data;
> +	mcan_class->irq_edge_triggered = true;
>  	mcan_class->ops = &m_can_pci_ops;
>  
>  	pci_set_drvdata(pci, mcan_class);
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/

