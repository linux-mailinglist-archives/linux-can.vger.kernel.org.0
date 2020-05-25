Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9181E0E98
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2020 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390511AbgEYMln (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 May 2020 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390488AbgEYMln (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 May 2020 08:41:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA7C061A0E
        for <linux-can@vger.kernel.org>; Mon, 25 May 2020 05:41:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jdCQC-0003QO-Tc; Mon, 25 May 2020 14:41:36 +0200
Received: from [IPv6:2a03:f580:87bc:d400:d406:10d7:6286:51e5] (unknown [IPv6:2a03:f580:87bc:d400:d406:10d7:6286:51e5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 732AB505B77;
        Mon, 25 May 2020 12:41:33 +0000 (UTC)
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
To:     Mark Brown <broonie@kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
 <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
 <20200525113106.GB4544@sirena.org.uk>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXz
Message-ID: <a337c8ea-66e2-13c2-f625-fbe93e367d44@pengutronix.de>
Date:   Mon, 25 May 2020 14:41:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525113106.GB4544@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/25/20 1:31 PM, Mark Brown wrote:
>>> Should I be submitting this patch with logic that only does
>>> half-duplex if the spi controller doesn't support it (if
>>> (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)) or is it
>>> acceptable to simply make the driver half-duplex like this for all
>>> cases?
> 
>> Please make half duplex transfers depending on SPI_CONTROLLER_HALF_DUPLEX as
>> most drivers have a considerable overhead at the end of a transfer.
> 
>> Most of them wait for a transfer complete interrupt. Which might take longer
>> than the actual SPI transfer. Splitting one full duplex read-register transfer
>> (which is a write followed by a read) into two half duplex transfers would kill
>> performance on full duplex capable controllers.
> 
> This isn't something that every individual driver should be doing, such
> rewriting should happen in the core so that everything sees the benefit.

The core could merge several half duplex transfers (until there's as cs_change)
into a single full duplex transfer.

I think it's not easy to detect and reliable to split a full duplex transfer
into half duplex ones. How can you tell, if the controller is supposed to tx 0x0
or actually receive.

I think spi_write_then_read() can be extended to generate one full duplex
transfer instead on two half duplex ones it does a memcpy() anyways.

To get a feeling for the use cases, this is what I do in the regmap read
function of a (not yet mainlined) CAN SPI driver.

> static int
> mcp25xxfd_regmap_nocrc_read(void *context,
> 			    const void *reg, size_t reg_len,
> 			    void *val_buf, size_t val_len)
> {
> 	struct spi_device *spi = context;
> 	struct mcp25xxfd_priv *priv = spi_get_drvdata(spi);
> 	struct mcp25xxfd_map_buf_nocrc *buf_rx = priv->map_buf_nocrc_rx;
> 	struct mcp25xxfd_map_buf_nocrc *buf_tx = priv->map_buf_nocrc_tx;
> 	struct spi_transfer xfer[2] = { };
> 	struct spi_message msg;
> 	int err;
> 
> 	spi_message_init(&msg);
> 	spi_message_add_tail(&xfer[0], &msg);
> 
> 	if (priv->devtype_data.quirks & MCP25XXFD_QUIRK_HALF_DUPLEX) {
> 		xfer[0].tx_buf = reg;
> 		xfer[0].len = sizeof(buf_tx->cmd);
> 
> 		xfer[1].rx_buf = val_buf;
> 		xfer[1].len = val_len;
> 		spi_message_add_tail(&xfer[1], &msg);
> 	} else {
> 		xfer[0].tx_buf = buf_tx;
> 		xfer[0].rx_buf = buf_rx;
> 		xfer[0].len = sizeof(buf_tx->cmd) + val_len;
> 		memcpy(&buf_tx->cmd, reg, sizeof(buf_tx->cmd));
> 	};
> 
> 	err = spi_sync(spi, &msg);
> 	if (err)
> 		return err;
> 
> 	if (!(priv->devtype_data.quirks & MCP25XXFD_QUIRK_HALF_DUPLEX))
> 		memcpy(val_buf, buf_rx->data, val_len);
> 
> 	return 0;
> }

The tradeoff here is two transfers vs. the the memcpy(). As CAN frames are quite
small the memcpy() is usually faster. Even on the rpi, where the driver is
optimized for small transfers.

regards
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
