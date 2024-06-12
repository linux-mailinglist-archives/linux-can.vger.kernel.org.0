Return-Path: <linux-can+bounces-722-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F283890520F
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C422B21779
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3216F28C;
	Wed, 12 Jun 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FvOR20by"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B669A152DF1
	for <linux-can@vger.kernel.org>; Wed, 12 Jun 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194027; cv=none; b=FFc/ICJvVkxL+4T0sfcJgINaFQIZqnUd/G643BkHpuVlEi13pYO1PIRC50jPXMKRCcAAXCsyyw5TeT9QN8zGuxy7DfwmwXrihVSOmWBnk34LWyMe8k7MSYkVWLlSN05hFY9T5OqAGQwOubqGY8Ryt04jR/rwzxsbmVBrZso8eHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194027; c=relaxed/simple;
	bh=yuNCkqg+bhRnGVv+DvxSAT1eCd/H0+vxYQ7GDQJSXFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsTfo/F/HHq7DoVSa6BBiQm1GhMp/d03Bb3HeI6PEnw17MZicnSmBnDWbhZ+S8JHHp/7B8H6+iOpdRFj74UwpfTIw82PexupUfvnIPwcCYeBnEtCqTfSKytMSAdjODldVaItPcAeoGchqauAqBfJC046XIQC0alIHlHDrWjjYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FvOR20by; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f1bc63981so515736f8f.1
        for <linux-can@vger.kernel.org>; Wed, 12 Jun 2024 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718194022; x=1718798822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8vKx3/hNDHyA43F+DjeoVfzLI5kfY7tnBOw5NnwZfEE=;
        b=FvOR20byKkSp1yEjnuder/cdmMMJomjp0x61tIsibw151W9Ma2b4nDwOYrMg8xBP6s
         hQNojJ3bq3nKB5xENbOfWfkUjGpXFgfg3lu8nhXmco8InjinfA71czehJ4bzFtQCTHzA
         6R6iGnqeMnz5SAmnSDeAcQIUA5xLxRhR9i3/i5gZUJgiWWyo/Z6cBhiRMnybHd7/Fxcc
         exuckJ4KbUmXTD1rRzP536YuRF7KuheBCBnz/6R9uUTs2mZb5yknga3RAmaDn19YfhDi
         HPZRF/5fl9PLYLn1TUmQL6W2WAMIeVAeICWtj3BSdJekHgrCL7gS4WjIS6z0+4FAQHUD
         iLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718194022; x=1718798822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vKx3/hNDHyA43F+DjeoVfzLI5kfY7tnBOw5NnwZfEE=;
        b=NKgJBQsOHLsLqRlqnH8iIpkPeBNUwp5J54+9LtHfEPIuKb3vhSZ27XdDeRnalspRb+
         GD8HXU7GeHYKQM5c2i/8Fc4H8pnR3N6Goilc/DHy0uIdThGAJ5IkNOGEMhxjUCyV+UvN
         YBNvIzOAAUkFA1Pj84IoYbYcjxwXRqiiHQ8RUXftqZEWg6NSfiRIz2nhoZNP2hsh9S22
         iwrPF83MNFp09Mzib2v5H8wYturWGCZpQYJgHi2SdrISw6O1a7coISkX2uIT8Oma3ZuG
         0iXupW+MMPfcAwwOO+pE6HyHMylzN9KAStEeJacmZbUgDmMM/wiMhve3DNk4cuFJlBfR
         HkFA==
X-Forwarded-Encrypted: i=1; AJvYcCWT2IDdLVgXc9NfIMf9QOFj2jVA1DBFYXDqe2qkkvFAToAUqOJSj4g1euog3llq44JhwGgV4uQDFIYonjITXzB1WiYh3waDJOI2
X-Gm-Message-State: AOJu0Yy2AvZKRoxdtRs/dUTGfH8ziytz3UJHtxcMolY9zCqYfIhHjQnp
	0iw5nQrTtrdm0twFIeoYiaPa1qQk97E8vj/FkYNjQIs/v01krCog2rVzv7voOnQ=
X-Google-Smtp-Source: AGHT+IGShNAiFIEugcE02ggkoWswwPNkTy5HsdH8XBQrrJk7yzGU5eAZ9K8o4y4X0KmqSBUymG2dSA==
X-Received: by 2002:a5d:4703:0:b0:360:6f19:3344 with SMTP id ffacd0b85a97d-3606f193666mr894102f8f.11.1718194021713;
        Wed, 12 Jun 2024 05:07:01 -0700 (PDT)
Received: from blmsp ([2001:4090:a244:8727:db7b:da2c:624f:dbed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm24996965e9.37.2024.06.12.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:07:01 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:07:00 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] can: m_can: don't enable transceiver when probing
Message-ID: <buwuyinkbrqwfrn44vuq3slhsstk2epgjhransiw3nxt723mlv@cvghmocts6p3>
References: <20240607105210.155435-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607105210.155435-1-martin@geanix.com>

Hi Martin,

On Fri, Jun 07, 2024 at 12:52:08PM GMT, Martin Hundebøll wrote:
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

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Markus Schneider-Pargmann <msp@baylibre.com>

I tested on a beaglebone black with tcan attached in loopback mode.
Everything seemed to work fine in my small test.

Best
Markus

> ---
> 
> Changes since v3:
>  * Return 'niso' instead of 'err' in case of failure to detect niso
>    support in m_can_dev_setup()
>  * Fix typo: redunant -> redundant
> 
> Changes since v2:
>  * Return and propagate error(s) from m_can_cccr_update_bits()
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
> 
>  drivers/net/can/m_can/m_can.c         | 169 ++++++++++++++++----------
>  drivers/net/can/m_can/tcan4x5x-core.c |  13 +-
>  2 files changed, 116 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 14b231c4d7ec..7f63f866083e 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -379,38 +379,72 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
>  	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
>  }
>  
> -static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
> +static int m_can_cccr_update_bits(struct m_can_classdev *cdev, u32 mask, u32 val)
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
> +	u32 val_before = m_can_read(cdev, M_CAN_CCCR);
> +	u32 val_after = (val_before & ~mask) | val;
> +	size_t tries = 10;
> +
> +	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT)) {
> +		dev_err(cdev->dev,
> +			"refusing to configure device when in normal mode\n");
> +		return -EBUSY;
>  	}
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
> +	/* The chip should be in standby mode when changing the CCCR register,
> +	 * and some chips set the CSR and CSA bits when in standby. Furthermore,
> +	 * the CSR and CSA bits should be written as zeros, even when they read
> +	 * ones.
> +	 */
> +	val_after &= ~(CCCR_CSR | CCCR_CSA);
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
> +
> +		if (val_read == val_after)
> +			return 0;
> +
> +		usleep_range(1, 5);
>  	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int m_can_config_enable(struct m_can_classdev *cdev)
> +{
> +	int err;
> +
> +	/* CCCR_INIT must be set in order to set CCCR_CCE, but access to
> +	 * configuration registers should only be enabled when in standby mode,
> +	 * where CCCR_INIT is always set.
> +	 */
> +	err = m_can_cccr_update_bits(cdev, CCCR_CCE, CCCR_CCE);
> +	if (err)
> +		netdev_err(cdev->net, "failed to enable configuration mode\n");
> +
> +	return err;
> +}
> +
> +static int m_can_config_disable(struct m_can_classdev *cdev)
> +{
> +	int err;
> +
> +	/* Only clear CCCR_CCE, since CCCR_INIT cannot be cleared while in
> +	 * standby mode
> +	 */
> +	err = m_can_cccr_update_bits(cdev, CCCR_CCE, 0);
> +	if (err)
> +		netdev_err(cdev->net, "failed to disable configuration registers\n");
> +
> +	return err;
>  }
>  
>  static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
> @@ -1403,7 +1437,9 @@ static int m_can_chip_config(struct net_device *dev)
>  	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
>  			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
>  
> -	m_can_config_endisable(cdev, true);
> +	err = m_can_config_enable(cdev);
> +	if (err)
> +		return err;
>  
>  	/* RX Buffer/FIFO Element Size 64 bytes data field */
>  	m_can_write(cdev, M_CAN_RXESC,
> @@ -1521,7 +1557,9 @@ static int m_can_chip_config(struct net_device *dev)
>  		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
>  		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
>  
> -	m_can_config_endisable(cdev, false);
> +	err = m_can_config_disable(cdev);
> +	if (err)
> +		return err;
>  
>  	if (cdev->ops->init)
>  		cdev->ops->init(cdev);
> @@ -1550,7 +1588,11 @@ static int m_can_start(struct net_device *dev)
>  		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
>  						 m_can_read(cdev, M_CAN_TXFQS));
>  
> -	return 0;
> +	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, 0);
> +	if (ret)
> +		netdev_err(dev, "failed to enter normal mode\n");
> +
> +	return ret;
>  }
>  
>  static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
> @@ -1599,43 +1641,37 @@ static int m_can_check_core_release(struct m_can_classdev *cdev)
>  }
>  
>  /* Selectable Non ISO support only in version 3.2.x
> - * This function checks if the bit is writable.
> + * Return 1 if the bit is writable, 0 if it is not, or negative on error.
>   */
> -static bool m_can_niso_supported(struct m_can_classdev *cdev)
> +static int m_can_niso_supported(struct m_can_classdev *cdev)
>  {
> -	u32 cccr_reg, cccr_poll = 0;
> -	int niso_timeout = -ETIMEDOUT;
> -	int i;
> +	int ret, niso;
>  
> -	m_can_config_endisable(cdev, true);
> -	cccr_reg = m_can_read(cdev, M_CAN_CCCR);
> -	cccr_reg |= CCCR_NISO;
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	ret = m_can_config_enable(cdev);
> +	if (ret)
> +		return ret;
>  
> -	for (i = 0; i <= 10; i++) {
> -		cccr_poll = m_can_read(cdev, M_CAN_CCCR);
> -		if (cccr_poll == cccr_reg) {
> -			niso_timeout = 0;
> -			break;
> -		}
> +	/* First try to set the NISO bit. */
> +	niso = m_can_cccr_update_bits(cdev, CCCR_NISO, CCCR_NISO);
>  
> -		usleep_range(1, 5);
> +	/* Then clear the it again. */
> +	ret = m_can_cccr_update_bits(cdev, CCCR_NISO, 0);
> +	if (ret) {
> +		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
> +		return ret;
>  	}
>  
> -	/* Clear NISO */
> -	cccr_reg &= ~(CCCR_NISO);
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	ret = m_can_config_disable(cdev);
> +	if (ret)
> +		return ret;
>  
> -	m_can_config_endisable(cdev, false);
> -
> -	/* return false if time out (-ETIMEDOUT), else return true */
> -	return !niso_timeout;
> +	return niso == 0;
>  }
>  
>  static int m_can_dev_setup(struct m_can_classdev *cdev)
>  {
>  	struct net_device *dev = cdev->net;
> -	int m_can_version, err;
> +	int m_can_version, err, niso;
>  
>  	m_can_version = m_can_check_core_release(cdev);
>  	/* return if unsupported version */
> @@ -1684,9 +1720,11 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
>  		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
>  
> -		cdev->can.ctrlmode_supported |=
> -			(m_can_niso_supported(cdev) ?
> -			 CAN_CTRLMODE_FD_NON_ISO : 0);
> +		niso = m_can_niso_supported(cdev);
> +		if (niso < 0)
> +			return niso;
> +		if (niso)
> +			cdev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
>  		break;
>  	default:
>  		dev_err(cdev->dev, "Unsupported version number: %2d",
> @@ -1694,21 +1732,26 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> -	if (cdev->ops->init)
> -		cdev->ops->init(cdev);
> -
> -	return 0;
> +	/* Forcing standby mode should be redundant, as the chip should be in
> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */
> +	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
>  }
>  
>  static void m_can_stop(struct net_device *dev)
>  {
>  	struct m_can_classdev *cdev = netdev_priv(dev);
> +	int ret;
>  
>  	/* disable all interrupts */
>  	m_can_disable_all_interrupts(cdev);
>  
>  	/* Set init mode to disengage from the network */
> -	m_can_config_endisable(cdev, true);
> +	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	if (ret)
> +		netdev_err(dev, "failed to enter standby mode: %pe\n",
> +			   ERR_PTR(ret));
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

