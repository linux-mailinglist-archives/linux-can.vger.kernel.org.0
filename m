Return-Path: <linux-can+bounces-19-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69817EAD94
	for <lists+linux-can@lfdr.de>; Tue, 14 Nov 2023 11:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D211C209FB
	for <lists+linux-can@lfdr.de>; Tue, 14 Nov 2023 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99D18631;
	Tue, 14 Nov 2023 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KGrmMB+x"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4818620
	for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 10:07:27 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6B199
	for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 02:07:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40838915cecso44042875e9.2
        for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 02:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699956443; x=1700561243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QR7rJ0Q5Vply3G1eukhHgIEevqGVK5XTr0L9lQZuxIA=;
        b=KGrmMB+xWhVQ//BfS+GV6G9zqFcLoxibkeENi+yquXluEZNZdcflnwwSkytWrplf8U
         Y+sCB+YkkR7/X4jSYJZAYkbdv4HijhpsEX81rjX8dT8IPINeOe45uc2UiuQPwz5no4MM
         q5VyI4ODqzRDgq+rbpFFqGEpERv20nzo04amFQtXHMM2U4PrDUn61ILjOfkCbkIsdSrX
         CIUBXJ0q7nTf5iOvp/8+El5m04YykQ/+KIE7FIvJe1cEMOymMD5fbY8Aj7aeJYMinzCo
         Wfk5LaGFnWi19IdvE5zGRMH7598o4wbEjzo8miFe+uFpGAOPRvTXr6HUFWw9JAzecJsP
         XPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699956443; x=1700561243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR7rJ0Q5Vply3G1eukhHgIEevqGVK5XTr0L9lQZuxIA=;
        b=FCXTi4UP3TPmnG/xUqaEjAyspzOhgSr06wLhAw31m2NRFQk3Gl+HV2+gMJMGuaLfds
         RRnqczV/xdoPiMTMorZWwNxZdqVigYQ4O5na+h4h1vXDyxvj9kyEdCCMNxEN3qq9LFBV
         8p5fj4A08z48u+upIWLIpLcZUehGeKVJvAKisj4R5gZWp1Kzyd1/Gcr4znDOLDLdzwCb
         cwy84Q5IsMv2bvvYCplmxPKUkdhqUCWfYu1sRx2n+xPnHBumuWfwPcjjvL+OCxsC8A+y
         yt1ZVQsQPA5uGrSMkGSABimmVYtw+z45ta+evx6QNA8QmbbS4dHnPqsIAAUKr1V2r8LY
         p31A==
X-Gm-Message-State: AOJu0Yx/4ACK4+JSooW/WAb8zRNtQ71VsYS1uqmgJsgUwI2y7+Ard3Mb
	Yvb0nb9UHQZS1Krj+dueNj7Ukw==
X-Google-Smtp-Source: AGHT+IESkVZkNKLyliEMie2GhdTpTo5Nn7MD0tmyx/eQCUA8PBCEuhfQTTzm8KnLsnDI8haNdcftcw==
X-Received: by 2002:a05:600c:450d:b0:409:5a92:4718 with SMTP id t13-20020a05600c450d00b004095a924718mr6843841wmo.36.1699956442973;
        Tue, 14 Nov 2023 02:07:22 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:4988:9c5:5b9:1020])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b0040648217f4fsm16463521wmc.39.2023.11.14.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:07:22 -0800 (PST)
Date: Tue, 14 Nov 2023 11:07:21 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] can: m_can: allow keeping the transceiver running
 in suspend
Message-ID: <20231114100721.noigib5rxmmopiu7@blmsp>
References: <20231113131452.214961-1-martin@geanix.com>
 <20231113131452.214961-2-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113131452.214961-2-martin@geanix.com>

Hi Martin,

On Mon, Nov 13, 2023 at 02:14:50PM +0100, Martin Hundebøll wrote:
> Add a flag to the device class structure that leaves the chip in a
> running state with rx interrupt enabled, so that an m_can device driver
> can configure and use the interrupt as a wakeup source.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Change in v3:
>  * Replaced the added function parameter with a property in
>    struct m_can_classdev.
> 
> Changes in v2:
>  * Fixed comment formatting
>  * Updated m_can_class_{suspend,resume} calls in m_can_pci.c too
>  * Skipped calling m_can_start() when resuming a wake-source device
> 
>  drivers/net/can/m_can/m_can.c          | 22 +++++++++++++++++-----
>  drivers/net/can/m_can/m_can.h          |  1 +
>  drivers/net/can/m_can/m_can_pci.c      |  1 +
>  drivers/net/can/m_can/m_can_platform.c |  1 +
>  drivers/net/can/m_can/tcan4x5x-core.c  |  1 +
>  5 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index b351597f594b..55df50580480 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2392,7 +2392,15 @@ int m_can_class_suspend(struct device *dev)
>  	if (netif_running(ndev)) {
>  		netif_stop_queue(ndev);
>  		netif_device_detach(ndev);
> -		m_can_stop(ndev);
> +
> +		/* leave the chip running with rx interrupt enabled if it is
> +		 * used as a wake-up source.
> +		 */
> +		if (cdev->pm_wake_source)
> +			m_can_write(cdev, M_CAN_IE, IR_RF0N);
> +		else
> +			m_can_stop(ndev);
> +
>  		m_can_clk_stop(cdev);
>  	}
>  
> @@ -2419,11 +2427,15 @@ int m_can_class_resume(struct device *dev)
>  		ret = m_can_clk_start(cdev);
>  		if (ret)
>  			return ret;
> -		ret  = m_can_start(ndev);
> -		if (ret) {
> -			m_can_clk_stop(cdev);
>  
> -			return ret;
> +		if (cdev->pm_wake_source) {
> +			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
> +		} else {
> +			ret  = m_can_start(ndev);

There is one space too much here.

> +			if (ret) {
> +				m_can_clk_stop(cdev);
> +				return ret;
> +			}
>  		}
>  
>  		netif_device_attach(ndev);
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 2986c4ce0b2f..3a9edc292593 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -97,6 +97,7 @@ struct m_can_classdev {
>  	u32 irqstatus;
>  
>  	int pm_clock_support;
> +	int pm_wake_source;

Can you avoid this new variable by using device_can_wakeup() and/or
device_may_wakeup() to check if the device is capable to wake up and if
wakeup is actually enabled?

Best,
Markus

>  	int is_peripheral;
>  
>  	// Cached M_CAN_IE register content
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> index f2219aa2824b..45400de4163d 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -125,6 +125,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	mcan_class->dev = &pci->dev;
>  	mcan_class->net->irq = pci_irq_vector(pci, 0);
>  	mcan_class->pm_clock_support = 1;
> +	mcan_class->pm_wake_source = 0;
>  	mcan_class->can.clock.freq = id->driver_data;
>  	mcan_class->ops = &m_can_pci_ops;
>  
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index ab1b8211a61c..df0367124b4c 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -139,6 +139,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  
>  	mcan_class->net->irq = irq;
>  	mcan_class->pm_clock_support = 1;
> +	mcan_class->pm_wake_source = 0;
>  	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
>  	mcan_class->dev = &pdev->dev;
>  	mcan_class->transceiver = transceiver;
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index 8a4143809d33..870ab4aef610 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -411,6 +411,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  	priv->spi = spi;
>  
>  	mcan_class->pm_clock_support = 0;
> +	mcan_class->pm_wake_source = 0;
>  	mcan_class->can.clock.freq = freq;
>  	mcan_class->dev = &spi->dev;
>  	mcan_class->ops = &tcan4x5x_ops;
> -- 
> 2.42.0
> 

