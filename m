Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82BF7B34D0
	for <lists+linux-can@lfdr.de>; Fri, 29 Sep 2023 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjI2OZ2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Sep 2023 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2OZ1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Sep 2023 10:25:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03816F9
        for <linux-can@vger.kernel.org>; Fri, 29 Sep 2023 07:25:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405524e6740so123892565e9.1
        for <linux-can@vger.kernel.org>; Fri, 29 Sep 2023 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695997523; x=1696602323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=70BgeORXRcHN4t44Wm9pypeMiOOIGww3NCCQMcEB3hs=;
        b=WpTt4YWjTpDLzoN/n9viZF00E6HhM1tYjWsNTACrEuz+C3YwudBkiVnk8f3ecmCjrZ
         lhZgL53TJ6XMAqzKPf2fOzVLW2rifGtkD2MtIgT5DExqZIe0t7xk+8zb1vN/qUrPv8Kd
         QF06GzE2x1WH6SYtDO6wzH9oql6vKiCfE/wGoiqDxYmS8v/eVBHsuHAloUTQoNGQhrQW
         72NFhpiD65SmXlbNt0OVLO4nS3HbMu5W4M4pax3yZEtQlL7RyLTJyowgN4Oywk0arXW+
         5QT/55Z6JF8jZgZp5hvGiOCwzTYt5LN5FvNW/+8dgPCn0xTK2myEj3Nb17reZRtFNclZ
         HU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997523; x=1696602323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70BgeORXRcHN4t44Wm9pypeMiOOIGww3NCCQMcEB3hs=;
        b=MnuCTUACLfED5fRJ8XhS9GU8Jbk+q8gQvXbru2PM/wv7sBFfrVQCfhrZ/gP/uMkXdu
         DDLeU+R7Ukpu+1y9d/97ZDLV8f5BemaJn+ld9Pbrq1csoV+t6tSZ2jhA13tg6kQbajKq
         aWtlaUaaIsTBo7FCw4b85WQksjdJYVr4OBxS+7wqO+WsgQUewqEZ0Pe/2+rNFmXVhLki
         7/Y020uhsVKWcS93opGiLYeOeEmSWlUghkEdNU7AS4SZoWMhD7Maj85vJjYJLy2ZkVqE
         thsMVasjHDwxtnl4yU6SWGZ1YxX1KrCV859j6cNyCNI/iuqGzoYWrzETsBA0UrYL/3OY
         KZMA==
X-Gm-Message-State: AOJu0YyBRbXFgUl24KPOGpIFj/JzS/72Ww286Lx8xoXyqTNzsgzKC59H
        RcQAI56YnkoijhqYq6PoE3GoSQ==
X-Google-Smtp-Source: AGHT+IGjkbYq1IWdbUbbSyKI/psGsifis7BxTvoQxWRUF5P0oEHmYMl5pwlKwjQwoKGGuKCNtLLIyw==
X-Received: by 2002:a5d:5151:0:b0:31f:eb88:e3c8 with SMTP id u17-20020a5d5151000000b0031feb88e3c8mr3987039wrt.32.1695997523358;
        Fri, 29 Sep 2023 07:25:23 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d688c000000b0031779a6b451sm21496472wru.83.2023.09.29.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:25:22 -0700 (PDT)
Date:   Fri, 29 Sep 2023 16:25:21 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dong Aisheng <b29396@freescale.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 1/2] can: m_can: allow keeping the transceiver running
 in suspend
Message-ID: <20230929142521.b537mve22iyerda6@blmsp>
References: <20230919122841.3803289-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919122841.3803289-1-martin@geanix.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Martin,

On Tue, Sep 19, 2023 at 02:28:32PM +0200, Martin Hundebøll wrote:
> Add a flag to the suspend class function that leaves the chip in a
> running state with rx interrupt enabled, so that m_can device driver can
> configure and use the interrupt as a wakeup source.

As far as I know the wakeup-source property is static, so maybe it would
be possible to store a property in m_can_classdev instead of using a
function parameter?

Looking into m_can_classdev there is already a pm_clock_support field.
Maybe you can put one right next to it for wakeup source?

Best,
Markus

> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Changes since v1:
>  * Fixed comment formatting
>  * Updated m_can_class_{suspend,resume} calls in m_can_pci.c too
>  * Skipped calling m_can_start() when resuming a wake-source device
> 
>  drivers/net/can/m_can/m_can.c          | 26 +++++++++++++++++++-------
>  drivers/net/can/m_can/m_can.h          |  4 ++--
>  drivers/net/can/m_can/m_can_pci.c      |  4 ++--
>  drivers/net/can/m_can/m_can_platform.c |  4 ++--
>  4 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16ecc11c7f62..ec345f6fd6b0 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2113,7 +2113,7 @@ void m_can_class_unregister(struct m_can_classdev *cdev)
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_unregister);
>  
> -int m_can_class_suspend(struct device *dev)
> +int m_can_class_suspend(struct device *dev, bool is_wake_source)
>  {
>  	struct m_can_classdev *cdev = dev_get_drvdata(dev);
>  	struct net_device *ndev = cdev->net;
> @@ -2121,7 +2121,15 @@ int m_can_class_suspend(struct device *dev)
>  	if (netif_running(ndev)) {
>  		netif_stop_queue(ndev);
>  		netif_device_detach(ndev);
> -		m_can_stop(ndev);
> +
> +		/* leave the chip running with rx interrupt enabled if it used
> +		 * as a wake-up source.
> +		 */
> +		if (is_wake_source)
> +			m_can_write(cdev, M_CAN_IE, IR_RF0N);
> +		else
> +			m_can_stop(ndev);
> +
>  		m_can_clk_stop(cdev);
>  	}
>  
> @@ -2133,7 +2141,7 @@ int m_can_class_suspend(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_suspend);
>  
> -int m_can_class_resume(struct device *dev)
> +int m_can_class_resume(struct device *dev, bool is_wake_source)
>  {
>  	struct m_can_classdev *cdev = dev_get_drvdata(dev);
>  	struct net_device *ndev = cdev->net;
> @@ -2148,11 +2156,15 @@ int m_can_class_resume(struct device *dev)
>  		ret = m_can_clk_start(cdev);
>  		if (ret)
>  			return ret;
> -		ret  = m_can_start(ndev);
> -		if (ret) {
> -			m_can_clk_stop(cdev);
>  
> -			return ret;
> +		if (is_wake_source) {
> +			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
> +		} else {
> +			ret  = m_can_start(ndev);
> +			if (ret) {
> +				m_can_clk_stop(cdev);
> +				return ret;
> +			}
>  		}
>  
>  		netif_device_attach(ndev);
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 520e14277dff..5d86bcf66e83 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -105,6 +105,6 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev);
>  int m_can_init_ram(struct m_can_classdev *priv);
>  int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
>  
> -int m_can_class_suspend(struct device *dev);
> -int m_can_class_resume(struct device *dev);
> +int m_can_class_suspend(struct device *dev, bool is_wake_source);
> +int m_can_class_resume(struct device *dev, bool is_wake_source);
>  #endif	/* _CAN_M_H_ */
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> index f2219aa2824b..7ffbe06d96d0 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -169,12 +169,12 @@ static void m_can_pci_remove(struct pci_dev *pci)
>  
>  static __maybe_unused int m_can_pci_suspend(struct device *dev)
>  {
> -	return m_can_class_suspend(dev);
> +	return m_can_class_suspend(dev, false);
>  }
>  
>  static __maybe_unused int m_can_pci_resume(struct device *dev)
>  {
> -	return m_can_class_resume(dev);
> +	return m_can_class_resume(dev, false);
>  }
>  
>  static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index cdb28d6a092c..e49bef50d52c 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -169,12 +169,12 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  
>  static __maybe_unused int m_can_suspend(struct device *dev)
>  {
> -	return m_can_class_suspend(dev);
> +	return m_can_class_suspend(dev, false);
>  }
>  
>  static __maybe_unused int m_can_resume(struct device *dev)
>  {
> -	return m_can_class_resume(dev);
> +	return m_can_class_resume(dev, false);
>  }
>  
>  static void m_can_plat_remove(struct platform_device *pdev)
> -- 
> 2.42.0
> 
