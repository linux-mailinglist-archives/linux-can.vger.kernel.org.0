Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3C29221C
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 07:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJSFXM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 01:23:12 -0400
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:57601
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgJSFXM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 01:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:cc:references:to:subject:from;
        bh=VNJuIIukJPG/49UGwSbIZ/Wg/08FK0tOCaoz10NMwSg=;
        b=iI7hLop3gqAg6QRnXM1lED8evcEcv3hKM0jBRxVifM4ElnP3iNd/WEwGcBxnOVavibYCv9sEHe/6+
         v2fuUpZddv/azsj+FH97KJWjXYJvZh1uNsSO7oDwGC9I0g8n6VxNLaTlL2LIA9LetVw4/bgBf6m0yT
         7ehIEkP0nQOlvLrRdSEH9KN7RMD3PmM5eULO6U/KNW2EGdWD51xeFIk5fkU4ECwY95+CGuVWV3BlbE
         yQhKoM+NWniX0K0G1GTZzXatlrS2fY2A5sDt4JyLzwMWnLxwuecka6IFbAUMqYtzKaqPQaSREEs5iJ
         RMETHvtnnVdcMEFcYwYCeHKqblhseUg==
X-HalOne-Cookie: 5d7eadc935a9d094cfedef4ae2d2eb4ec1221f94
X-HalOne-ID: 2ae02fe5-11cb-11eb-a2b4-d0431ea8bb10
Received: from [192.168.0.157] (unknown [5.103.118.41])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2ae02fe5-11cb-11eb-a2b4-d0431ea8bb10;
        Mon, 19 Oct 2020 05:23:06 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] can: mcp251xfd: add support for internal PLL
To:     linux-can@vger.kernel.org
References: <20201016205211.1141590-1-mkl@pengutronix.de>
 <20201016205211.1141590-4-mkl@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Message-ID: <18c8ed1b-7b0b-a9f7-9583-13a4d65490fd@csselectronics.com>
Date:   Mon, 19 Oct 2020 07:23:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016205211.1141590-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>

On 16-10-2020 22:52, Marc Kleine-Budde wrote:
> The PLL is enabled if the configured clock is less than or equal to 10 times
> the max clock frequency.
>
> The device will operate with two different SPI speeds. A slow speed determined
> by the clock without the PLL enabled, and a fast speed derived from the
> frequency with the PLL enabled.
>
> Link: https://lore.kernel.org/r/20201015124401.2766-3-mas@csselectronics.com
> Co-developed-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
> Not-Singed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 73 +++++++++++++++----
>   drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  3 +
>   2 files changed, 63 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index b8304b7096d1..2be643c6e243 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -479,8 +479,12 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
>   	if (err)
>   		return err;
>   
> -	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait)
> +	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait) {
> +		if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP)
> +			priv->spi->max_speed_hz = priv->spi_max_speed_hz_slow;
> +
>   		return 0;
> +	}
>   
>   	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_CON, con,
>   				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
> @@ -655,7 +659,7 @@ static int mcp251xfd_chip_softreset(const struct mcp251xfd_priv *priv)
>   
>   static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
>   {
> -	u32 osc;
> +	u32 osc, osc_reference, osc_mask;
>   	int err;
>   
>   	/* Activate Low Power Mode on Oscillator Disable. This only
> @@ -665,7 +669,34 @@ static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
>   	osc = MCP251XFD_REG_OSC_LPMEN |
>   		FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
>   			   MCP251XFD_REG_OSC_CLKODIV_10);
> -	return regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
> +	osc_reference = MCP251XFD_REG_OSC_OSCRDY;
> +	osc_mask = MCP251XFD_REG_OSC_OSCRDY | MCP251XFD_REG_OSC_PLLRDY;
> +
> +	if (priv->pll_enable) {
> +		osc |= MCP251XFD_REG_OSC_PLLEN;
> +		osc_reference |= MCP251XFD_REG_OSC_PLLRDY;
> +	}
> +
> +	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
> +	if (err)
> +		return err;
> +
> +	/* Wait for "Oscillator + PLL Ready" bit */
> +	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_OSC, osc,
> +				       (osc & osc_mask) == osc_reference,
> +				       MCP251XFD_OSC_STAB_SLEEP_US,
> +				       MCP251XFD_OSC_STAB_TIMEOUT_US);
> +
> +	if (err == -ETIMEDOUT) {
> +		netdev_err(priv->ndev,
> +			   "Timeout waiting for Oscillator + PLL Ready (osc=0x%08x, osc_reference=0x%08x)\n",
> +			   osc, osc_reference);
> +		return -ETIMEDOUT;
> +	}
> +
> +	priv->spi->max_speed_hz = priv->spi_max_speed_hz_fast;
> +
> +	return 0;
>   }
>   
>   static int mcp251xfd_chip_timestamp_init(const struct mcp251xfd_priv *priv)
> @@ -2604,11 +2635,12 @@ mcp251xfd_register_done(const struct mcp251xfd_priv *priv)
>   		return err;
>   
>   	netdev_info(priv->ndev,
> -		    "%s rev%lu.%lu (%cRX_INT %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD c:%u.%02uMHz m:%u.%02uMHz r:%u.%02uMHz e:%u.%02uMHz) successfully initialized.\n",
> +		    "%s rev%lu.%lu (%cRX_INT %cPLL %cMAB_NO_WARN %cCRC_REG %cCRC_RX %cCRC_TX %cECC %cHD c:%u.%02uMHz m:%u.%02uMHz rs:%u.%02uMHz rf:%u.%02uMHz ef:%u.%02uMHz) successfully initialized.\n",
>   		    mcp251xfd_get_model_str(priv),
>   		    FIELD_GET(MCP251XFD_REG_DEVID_ID_MASK, dev_id),
>   		    FIELD_GET(MCP251XFD_REG_DEVID_REV_MASK, dev_id),
>   		    priv->rx_int ? '+' : '-',
> +		    priv->pll_enable ? '+' : '-',
>   		    MCP251XFD_QUIRK_ACTIVE(MAB_NO_WARN),
>   		    MCP251XFD_QUIRK_ACTIVE(CRC_REG),
>   		    MCP251XFD_QUIRK_ACTIVE(CRC_RX),
> @@ -2619,8 +2651,10 @@ mcp251xfd_register_done(const struct mcp251xfd_priv *priv)
>   		    priv->can.clock.freq % 1000000 / 1000 / 10,
>   		    priv->spi_max_speed_hz_orig / 1000000,
>   		    priv->spi_max_speed_hz_orig % 1000000 / 1000 / 10,
> -		    priv->spi->max_speed_hz / 1000000,
> -		    priv->spi->max_speed_hz % 1000000 / 1000 / 10,
> +		    priv->spi_max_speed_hz_slow / 1000000,
> +		    priv->spi_max_speed_hz_slow % 1000000 / 1000 / 10,
> +		    priv->spi_max_speed_hz_fast / 1000000,
> +		    priv->spi_max_speed_hz_fast % 1000000 / 1000 / 10,
>   		    effective_speed_hz / 1000000,
>   		    effective_speed_hz % 1000000 / 1000 / 10);
>   
> @@ -2650,6 +2684,10 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
>   	if (err)
>   		goto out_chip_set_mode_sleep;
>   
> +	err = mcp251xfd_chip_clock_init(priv);
> +	if (err)
> +		goto out_chip_set_mode_sleep;
> +
>   	err = mcp251xfd_register_chip_detect(priv);
>   	if (err)
>   		goto out_chip_set_mode_sleep;
> @@ -2743,6 +2781,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
>   	struct gpio_desc *rx_int;
>   	struct regulator *reg_vdd, *reg_xceiver;
>   	struct clk *clk;
> +	bool pll_enable = false;
>   	u32 freq;
>   	int err;
>   
> @@ -2785,12 +2824,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
>   		return -ERANGE;
>   	}
>   
> -	if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER) {
> -		dev_err(&spi->dev,
> -			"Oscillator frequency (%u Hz) is too low and PLL is not supported.\n",
> -			freq);
> -		return -ERANGE;
> -	}
> +	if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER)
> +		pll_enable = true;
>   
>   	ndev = alloc_candev(sizeof(struct mcp251xfd_priv),
>   			    MCP251XFD_TX_OBJ_NUM_MAX);
> @@ -2806,6 +2841,8 @@ static int mcp251xfd_probe(struct spi_device *spi)
>   	priv = netdev_priv(ndev);
>   	spi_set_drvdata(spi, priv);
>   	priv->can.clock.freq = freq;
> +	if (pll_enable)
> +		priv->can.clock.freq *= MCP251XFD_OSC_PLL_MULTIPLIER;
>   	priv->can.do_set_mode = mcp251xfd_set_mode;
>   	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
>   	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
> @@ -2817,6 +2854,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
>   	priv->spi = spi;
>   	priv->rx_int = rx_int;
>   	priv->clk = clk;
> +	priv->pll_enable = pll_enable;
>   	priv->reg_vdd = reg_vdd;
>   	priv->reg_xceiver = reg_xceiver;
>   
> @@ -2856,7 +2894,16 @@ static int mcp251xfd_probe(struct spi_device *spi)
>   	 *
>   	 */
>   	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
> -	spi->max_speed_hz = min(spi->max_speed_hz, freq / 2 / 1000 * 850);
> +	priv->spi_max_speed_hz_slow = min(spi->max_speed_hz,
> +					  freq / 2 / 1000 * 850);
> +	if (priv->pll_enable)
> +		priv->spi_max_speed_hz_fast = min(spi->max_speed_hz,
> +						  freq *
> +						  MCP251XFD_OSC_PLL_MULTIPLIER /
> +						  2 / 1000 * 850);
> +	else
> +		priv->spi_max_speed_hz_fast = priv->spi_max_speed_hz_slow;
> +	spi->max_speed_hz = priv->spi_max_speed_hz_slow;
>   	spi->bits_per_word = 8;
>   	spi->rt = true;
>   	err = spi_setup(spi);
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> index fa1246e39980..813a791234de 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -579,6 +579,8 @@ struct mcp251xfd_priv {
>   
>   	struct spi_device *spi;
>   	u32 spi_max_speed_hz_orig;
> +	u32 spi_max_speed_hz_fast;
> +	u32 spi_max_speed_hz_slow;
>   
>   	struct mcp251xfd_tef_ring tef;
>   	struct mcp251xfd_tx_ring tx[1];
> @@ -591,6 +593,7 @@ struct mcp251xfd_priv {
>   
>   	struct gpio_desc *rx_int;
>   	struct clk *clk;
> +	bool pll_enable;
>   	struct regulator *reg_vdd;
>   	struct regulator *reg_xceiver;
>   
