Return-Path: <linux-can+bounces-1148-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC37948C15
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1851F24588
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3B1BD50E;
	Tue,  6 Aug 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VD/nbBdQ"
X-Original-To: linux-can@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F418161900;
	Tue,  6 Aug 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936070; cv=none; b=o58QiRx4YQXRYhiPRl1nwUgue7QFAjGbMccl3t6thJS0PAXY2j/PLuE6YACe2Eaypu+IbYy+kBERUubelFRC+QA4h4Ge2QyOspghtuVJHC27U00CpPKwEwecjgSmMdHZ+PxO/hAOOPE+SoykGZ/YiZZYRriWNZhoearXRKA65B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936070; c=relaxed/simple;
	bh=NPhKhZrTbAaAjdp1bLFccjczUsYB1SO9GSM5WLed9Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWPye+AaowldHBv+DOeFEDIU7pCkFyAgr15cBn2alMCue2zM3o+CS1it2GLRWQQPok1NR/phgIYe5Zqd1OtHlykC3xPgG1eoKqeCC4JulGOJp4pCvRyyFysbQetDuiXqg13zb6HUpQAyGCP6x/tdn4BJ0fsNALKHu7nvL4/hyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VD/nbBdQ; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bGNEs8fQxkc2vbGNEsmFEH; Tue, 06 Aug 2024 11:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722936059;
	bh=yIL4qMESP/8bWPqe1Dv9LYdym5Eafp0+I7Mg9bcvDOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VD/nbBdQBK/PTwUK9Sy/wj8gRgZJYhitNSAoroyXC9OfhWQc608FGqam5GZHV7lXG
	 T5lJDBU+aRr/l+8JZIQf6clgDPwxYtqTYyCodDNw7q1iJ0w4yCTrtvVDxxJm8ZW/XS
	 fCcVpZlpWw61bx4Adm3AmSvEz8IQtd/AnOMJzBIvUwjvhkSgzcRjFYqtxz9DrLGA5q
	 iuDnqs1bDYl8Eio1ip3q9CsjgxrXObbg8f/cFXmYDUWls3rzzKat/o7aQjZC8WMHA1
	 RVrgHNcpV1y6sG7bt6nV8kiiGspLQJm0DnPh7nNhTMVBufNDeoZHxyxCLED1nsaECP
	 DotGwZhyKheOg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 06 Aug 2024 11:20:59 +0200
X-ME-IP: 90.11.132.44
Message-ID: <3879d3ed-6816-463a-87c1-a9e9076eea24@wanadoo.fr>
Date: Tue, 6 Aug 2024 11:20:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: mcp251xfd: Enable transceiver using gpio
To: Anup Kulkarni <quic_anupkulk@quicinc.com>, mkl@pengutronix.de,
 manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com,
 mailhol.vincent@wanadoo.fr, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com
References: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/08/2024 à 11:03, Anup Kulkarni a écrit :
> Ensure the CAN transceiver is active during mcp251xfd_open() and
> inactive during mcp251xfd_close() by utilizing
> mcp251xfd_transceiver_mode(). Adjust GPIO_0 to switch between
> NORMAL and STANDBY modes of transceiver.
> 
> Signed-off-by: Anup Kulkarni <quic_anupkulk@quicinc.com>
> ---
>   .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 32 +++++++++++++++++++
>   drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  7 ++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 3e7526274e34..3b56dc1721a5 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -153,6 +153,25 @@ static inline int mcp251xfd_vdd_disable(const struct mcp251xfd_priv *priv)
>   	return regulator_disable(priv->reg_vdd);
>   }
>   
> +static int
> +mcp251xfd_transceiver_mode(const struct mcp251xfd_priv *priv,
> +			   const enum mcp251xfd_xceiver_mode mode)
> +{
> +	int val, pmode, latch;
> +
> +	if (mode == MCP251XFD_XCVR_NORMAL_MODE) {
> +		pmode = MCP251XFD_REG_IOCON_PM0;
> +		latch = 0;
> +	} else if (mode == MCP251XFD_XCVR_STBY_MODE) {
> +		pmode = MCP251XFD_REG_IOCON_PM0;
> +		latch = MCP251XFD_REG_IOCON_LAT0;
> +	} else {
> +		return -EINVAL;
> +	}
> +	val = (pmode | latch) << priv->transceiver_pin;
> +	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
> +}
> +
>   static inline int
>   mcp251xfd_transceiver_enable(const struct mcp251xfd_priv *priv)
>   {
> @@ -1620,6 +1639,10 @@ static int mcp251xfd_open(struct net_device *ndev)
>   	if (err)
>   		goto out_transceiver_disable;
>   
> +	err = mcp251xfd_transceiver_mode(priv, MCP251XFD_XCVR_NORMAL_MODE);
> +	if (err)
> +		goto out_transceiver_disable;
> +
>   	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>   	can_rx_offload_enable(&priv->offload);
>   
> @@ -1668,6 +1691,7 @@ static int mcp251xfd_open(struct net_device *ndev)
>   
>   static int mcp251xfd_stop(struct net_device *ndev)
>   {
> +	int err;
>   	struct mcp251xfd_priv *priv = netdev_priv(ndev);
>   
>   	netif_stop_queue(ndev);
> @@ -1678,6 +1702,9 @@ static int mcp251xfd_stop(struct net_device *ndev)
>   	free_irq(ndev->irq, priv);
>   	destroy_workqueue(priv->wq);
>   	can_rx_offload_disable(&priv->offload);
> +	err = mcp251xfd_transceiver_mode(priv, MCP251XFD_XCVR_STBY_MODE);
> +	if (err)
> +		return err;
>   	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
>   	mcp251xfd_transceiver_disable(priv);
>   	mcp251xfd_ring_free(priv);
> @@ -2051,6 +2078,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
>   					     "Failed to get clock-frequency!\n");
>   	}
>   
> +	err = device_property_read_u32(&spi->dev, "gpio-transceiver-pin", &priv->transceiver_pin);
> +		if (err)

Hi,

looks like indentation is 1 tab too far.

CJ

> +			return dev_err_probe(&spi->dev, err,
> +					     "Failed to get gpio transceiver pin!\n");
> +
>   	/* Sanity check */
>   	if (freq < MCP251XFD_SYSCLOCK_HZ_MIN ||
>   	    freq > MCP251XFD_SYSCLOCK_HZ_MAX) {
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> index dcbbd2b2fae8..14b086814bdb 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -614,6 +614,12 @@ enum mcp251xfd_flags {
>   	__MCP251XFD_FLAGS_SIZE__
>   };
>   
> +enum mcp251xfd_xceiver_mode {
> +	MCP251XFD_XCVR_NORMAL_MODE,
> +	MCP251XFD_XCVR_STBY_MODE,
> +	MCP251XFD_XCVR_MODE_NONE
> +};
> +
>   struct mcp251xfd_priv {
>   	struct can_priv can;
>   	struct can_rx_offload offload;
> @@ -670,6 +676,7 @@ struct mcp251xfd_priv {
>   
>   	struct mcp251xfd_devtype_data devtype_data;
>   	struct can_berr_counter bec;
> +	u32 transceiver_pin;
>   };
>   
>   #define MCP251XFD_IS(_model) \


