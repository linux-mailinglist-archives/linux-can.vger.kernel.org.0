Return-Path: <linux-can+bounces-590-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792478BE21D
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2024 14:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F76428AF05
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150815B995;
	Tue,  7 May 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n9bogbrm"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC25815252E
	for <linux-can@vger.kernel.org>; Tue,  7 May 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085003; cv=none; b=LU+BQRvp0gLSqieGOcbqlGZsGoEHhxNa4aQcz7nTebJs4Wuu+pv5+3j9JoYMT7eIeWy/rOQvAltpOXepobRSMEYGN57LJ6eDgTWXOGPUP3GvP+WQnE3ikl89GnsggVKGeUeX9O/Q9WNkJppPMmv+Bvt5g8Uah4mOmgmyXx58MiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085003; c=relaxed/simple;
	bh=l28PYPIUP5pamSqFdXVR1E14tHTfrnPtfiv6kx0dHQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyrbkgwVmk8DeSHBFI7qrrMWtb9LpGUGdyqZCTo3w1yQI4nUb4vHSsTSESCGToW63I7qUivwkVMribvLuhnGjKaVB3ONrXDgIckXdEF5O5DmBsH4sQPj6qY4WTnOfqChphcNIn9/5LOJuf7uUsUyGSE8pHSJRZMbAHX3fsXTyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n9bogbrm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5206a5854adso2398570e87.0
        for <linux-can@vger.kernel.org>; Tue, 07 May 2024 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715084999; x=1715689799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=arB+W3iA2EBH3AUYw3mwo4IpWG1zYxIJ8kXXDziIrK0=;
        b=n9bogbrm7cIvpV6+SC8uZuTMc+xr4esRND3IVw5SRdJRKzDZ2IOaasj20joYF2TrkP
         DuntfH8g+5YPR9vpix6seOyC0H1UzkREMpBYCaCEXWGrN1CmPxTzkVfgBfaL22BGJDV+
         G10aT6JcxcnemfXhIazutqK5IcUDMgaszrQRm/MsO7MS9otd9FjOI7uyw7DC4L98S6Uv
         yZcC/IPf5pDdb2UyxMmtFxeuvIdfSiepTyaUe6yt393TT5aghfsHB7EhueBgiKbILLoP
         jnmuhVdYvrTUva4UTzOV0n+RcgI+YewFH0XWqTqfFkpFNcjX28IBWtDDfJm73tjfhS+3
         8uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715084999; x=1715689799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arB+W3iA2EBH3AUYw3mwo4IpWG1zYxIJ8kXXDziIrK0=;
        b=HFVqIDlecLGqrYekwVOfyToHmrx6wxLjh1Wbyi8ktLfUA3hnB2FZ52V8VeO5De8jBZ
         ARWJdHFBfrGlFnAq4s/duj8zo38Qrai8tj2juuofof1WEgjHxixULXisO+Jx/6b8IVaM
         NbPEXAuRx+hoxl0kEhQhyhb2jrBIVRvzkEZ3OpUu+9MaUr/5ou59Efo8TuvOuQUQCrY7
         nMdj+TVs/v6gEmGwnJG0bEdN+ynFjF44BY3Q8L6XHFUxnpcs6ubg41Wej2DtJZmWNkbd
         ZS+bHuwDmU9n9p1lXTd6MWeT3QM7Pu4aw4+JO8solIaKF0RWSHeOjnGp65rk2jKDYoUe
         mEOg==
X-Forwarded-Encrypted: i=1; AJvYcCVJP4BGHTEJrUfVsmMhoNdwS81K6rZtQiJT/yybk+ncTHjOl+IYIznpWG4UGnkNCfTP4jkssFNEmNDBrlJNTU0JHooeqZvnA2pL
X-Gm-Message-State: AOJu0Yw0B6peqKWfD7nJF6CB5cu2HC5S6EnMF0oQZHLhi6CFE04XgBDc
	dEHFviTcXQEMNYCNoQnKdptOP1R3GX5T8vHV07jGxeM1ERI0FVaF259rh3McOfY=
X-Google-Smtp-Source: AGHT+IFhtCBP1BwfAdRHXnYNcMKb7JXk3TUTt9H2kGw8YwgafY7mzKcV4ivafwlPJGz9C8qrUeZ+kA==
X-Received: by 2002:a05:6512:3f16:b0:51d:2c37:6c15 with SMTP id y22-20020a0565123f1600b0051d2c376c15mr10785702lfa.8.1715084998415;
        Tue, 07 May 2024 05:29:58 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b0041bab13cd74sm19518280wms.17.2024.05.07.05.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:29:57 -0700 (PDT)
Date: Tue, 7 May 2024 14:29:57 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: m_can: don't enable transceiver when probing
Message-ID: <rgjyty2tbqngttoicyxhntmiplihcd2xxjsqsi6r7pqrxrnumc@upt2nelsumv3>
References: <20240501124204.3545056-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501124204.3545056-1-martin@geanix.com>

Hi Martin,

On Wed, May 01, 2024 at 02:42:03PM +0200, Martin Hundebøll wrote:
> The m_can driver sets and clears the CCCR.INIT bit during probe (both
> when testing the NON-ISO bit, and when configuring the chip). After
> clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
> affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
> the m_can node is only used for monitoring the bus, as one cannot setup
> listen-only mode before the device is probed.
> 
> Rework the probe flow, so that the CCCR.INIT bit is only cleared when
> upping the device. First, the tcan4x5x driver is changed to stay in
> standby mode during/after probe. This in turn requires changes when
> setting bits in the CCCR register, as its CSR and CSA bits are always
> high in standby mode.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Changes since v1:
>  * Implement Markus review comments:
>    - Rename m_can_cccr_wait_bits() to m_can_cccr_update_bits()
>    - Explicitly set CCCR_INIT bit in m_can_dev_setup()
>    - Revert to 5 timeouts/tries to 10
>    - Use m_can_config_{en|dis}able() in m_can_niso_supported()
>    - Revert move of call to m_can_enable_all_interrupts()
>    - Return -EBUSY on failure to enter normal mode
>    - Use tcan4x5x_clear_interrupts() in tcan4x5x_can_probe()

Thanks for addressing these.

In general this looks good:
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

A few small things commented below, mostly nit-picks.
@Marc: Up to you if you want to merge it or not. I hope the review was
early enough for your PR :)
I don't have time to test it this week, but I can do that next week.

> 
>  drivers/net/can/m_can/m_can.c         | 131 +++++++++++++++-----------
>  drivers/net/can/m_can/tcan4x5x-core.c |  13 ++-
>  2 files changed, 85 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 14b231c4d7ec..7974aaa5d8cc 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -379,38 +379,60 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
>  	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
>  }
>  
> -static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
> +static bool m_can_cccr_update_bits(struct m_can_classdev *cdev, u32 mask, u32 val)

I personally prefer functions that return error values, in this case
-ETIMEDOUT, as it more clearly indicates what error occured.

>  {
> -	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
> -	u32 timeout = 10;
> -	u32 val = 0;
> -
> -	/* Clear the Clock stop request if it was set */
> -	if (cccr & CCCR_CSR)
> -		cccr &= ~CCCR_CSR;
> -
> -	if (enable) {
> -		/* enable m_can configuration */
> -		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
> -		udelay(5);
> -		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
> -		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
> -	} else {
> -		m_can_write(cdev, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
> -	}
> +	u32 val_before = m_can_read(cdev, M_CAN_CCCR);
> +	u32 val_after = (val_before & ~mask) | val;
> +	size_t tries = 10;
> +
> +	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT))
> +		dev_warn(cdev->dev,
> +			 "trying to configure device when in normal mode. Expect failures\n");
> +
> +	/* The chip should be in standby mode when changing the CCCR register,
> +	 * and some chips set the CSR and CSA bits when in standby. Furthermore,
> +	 * the CSR and CSA bits should be written as zeros, even when they read
> +	 * ones.
> +	 */
> +	val_after &= ~(CCCR_CSR | CCCR_CSA);

By the way is this a fix that should be fixed for earlier driver/kernel
versions as well? Or is it just required as part of this series?

> +
> +	while (tries--) {
> +		u32 val_read;
> +
> +		/* Write the desired value in each try, as setting some bits in
> +		 * the CCCR register require other bits to be set first. E.g.
> +		 * setting the NISO bit requires setting the CCE bit first.
> +		 */
> +		m_can_write(cdev, M_CAN_CCCR, val_after);
> +
> +		val_read = m_can_read(cdev, M_CAN_CCCR) & ~(CCCR_CSR | CCCR_CSA);
>  
> -	/* there's a delay for module initialization */
> -	if (enable)
> -		val = CCCR_INIT | CCCR_CCE;
> -
> -	while ((m_can_read(cdev, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
> -		if (timeout == 0) {
> -			netdev_warn(cdev->net, "Failed to init module\n");
> -			return;
> -		}
> -		timeout--;
> -		udelay(1);
> +		if (val_read == val_after)
> +			return true;
> +
> +		usleep_range(1, 5);
>  	}
> +
> +	return false;
> +}
> +
> +static void m_can_config_enable(struct m_can_classdev *cdev)
> +{
> +	/* CCCR_INIT must be set in order to set CCCR_CCE, but access to
> +	 * configuration registers should only be enabled when in standby mode,
> +	 * where CCCR_INIT is always set.
> +	 */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_CCE, CCCR_CCE))

Another personal preference is the use of this style of error checking
for functions that actually do things:
  err = m_can_cccr_update_bits();
  if (err)

> +		netdev_err(cdev->net, "failed to enable configuration mode\n");

If we detect an error here, should it be propagated and fail probing? I
know it wasn't checked before, so not really necessary to do it now.

Best
Markus

> +}
> +
> +static void m_can_config_disable(struct m_can_classdev *cdev)
> +{
> +	/* Only clear CCCR_CCE, since CCCR_INIT cannot be cleared while in
> +	 * standby mode
> +	 */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_CCE, 0))
> +		netdev_err(cdev->net, "failed to disable configuration registers\n");
>  }
>  
>  static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
> @@ -1403,7 +1425,7 @@ static int m_can_chip_config(struct net_device *dev)
>  	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
>  			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
>  
> -	m_can_config_endisable(cdev, true);
> +	m_can_config_enable(cdev);
>  
>  	/* RX Buffer/FIFO Element Size 64 bytes data field */
>  	m_can_write(cdev, M_CAN_RXESC,
> @@ -1521,7 +1543,7 @@ static int m_can_chip_config(struct net_device *dev)
>  		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
>  		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
>  
> -	m_can_config_endisable(cdev, false);
> +	m_can_config_disable(cdev);
>  
>  	if (cdev->ops->init)
>  		cdev->ops->init(cdev);
> @@ -1550,6 +1572,11 @@ static int m_can_start(struct net_device *dev)
>  		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
>  						 m_can_read(cdev, M_CAN_TXFQS));
>  
> +	if (!m_can_cccr_update_bits(cdev, CCCR_INIT, 0)) {
> +		netdev_err(dev, "failed to enter normal mode\n");
> +		return -EBUSY;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1603,33 +1630,20 @@ static int m_can_check_core_release(struct m_can_classdev *cdev)
>   */
>  static bool m_can_niso_supported(struct m_can_classdev *cdev)
>  {
> -	u32 cccr_reg, cccr_poll = 0;
> -	int niso_timeout = -ETIMEDOUT;
> -	int i;
> +	bool niso_supported;
>  
> -	m_can_config_endisable(cdev, true);
> -	cccr_reg = m_can_read(cdev, M_CAN_CCCR);
> -	cccr_reg |= CCCR_NISO;
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	m_can_config_enable(cdev);
>  
> -	for (i = 0; i <= 10; i++) {
> -		cccr_poll = m_can_read(cdev, M_CAN_CCCR);
> -		if (cccr_poll == cccr_reg) {
> -			niso_timeout = 0;
> -			break;
> -		}
> +	/* First try to set the NISO bit. */
> +	niso_supported = m_can_cccr_update_bits(cdev, CCCR_NISO, CCCR_NISO);
>  
> -		usleep_range(1, 5);
> -	}
> +	/* Then clear the it again. */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_NISO, 0))
> +		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
>  
> -	/* Clear NISO */
> -	cccr_reg &= ~(CCCR_NISO);
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	m_can_config_disable(cdev);
>  
> -	m_can_config_endisable(cdev, false);
> -
> -	/* return false if time out (-ETIMEDOUT), else return true */
> -	return !niso_timeout;
> +	return niso_supported;
>  }
>  
>  static int m_can_dev_setup(struct m_can_classdev *cdev)
> @@ -1694,8 +1708,12 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> -	if (cdev->ops->init)
> -		cdev->ops->init(cdev);
> +	/* Forcing standby mode should be redunant, as the chip should be in
> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT))
> +		return -EBUSY;
>  
>  	return 0;
>  }
> @@ -1708,7 +1726,8 @@ static void m_can_stop(struct net_device *dev)
>  	m_can_disable_all_interrupts(cdev);
>  
>  	/* Set init mode to disengage from the network */
> -	m_can_config_endisable(cdev, true);
> +	if (!m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT))
> +		netdev_err(dev, "failed to enter standby mode\n");
>  
>  	/* set the state as STOPPED */
>  	cdev->can.state = CAN_STATE_STOPPED;
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index a42600dac70d..d723206ac7c9 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -453,10 +453,17 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  		goto out_power;
>  	}
>  
> -	ret = tcan4x5x_init(mcan_class);
> +	tcan4x5x_check_wake(priv);
> +
> +	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
>  	if (ret) {
> -		dev_err(&spi->dev, "tcan initialization failed %pe\n",
> -			ERR_PTR(ret));
> +		dev_err(&spi->dev, "Disabling interrupts failed %pe\n", ERR_PTR(ret));
> +		goto out_power;
> +	}
> +
> +	ret = tcan4x5x_clear_interrupts(mcan_class);
> +	if (ret) {
> +		dev_err(&spi->dev, "Clearing interrupts failed %pe\n", ERR_PTR(ret));
>  		goto out_power;
>  	}
>  
> -- 
> 2.44.0
> 

