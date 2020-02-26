Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E681316F898
	for <lists+linux-can@lfdr.de>; Wed, 26 Feb 2020 08:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBZHhJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Feb 2020 02:37:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58317 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBZHhJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2020 02:37:09 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1j6rFi-0003lK-1n; Wed, 26 Feb 2020 08:37:06 +0100
Received: from [IPv6:2a03:f580:87bc:d400:6ccf:3365:1a9c:55ad] (unknown [IPv6:2a03:f580:87bc:d400:6ccf:3365:1a9c:55ad])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4EDEB4C0EEF;
        Wed, 26 Feb 2020 07:37:04 +0000 (UTC)
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
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
Message-ID: <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
Date:   Wed, 26 Feb 2020 08:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2/25/20 11:25 PM, Tim Harvey wrote:
>> On 2/25/20 7:35 PM, Tim Harvey wrote:
>>> Some SPI host controllers such as the Cavium Thunder do not support
>>> full-duplex SPI. Using half-duplex transfers allows the driver to work
>>> with those host controllers.

Hmmm, at least none of the spi-cavium*.c have HALF_DUPLEX set....

I only find these ones:
> drivers/spi/spi-falcon.c:404:   master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-lp8841-rtc.c:194:       master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-mt7621.c:360:   master->flags = SPI_CONTROLLER_HALF_DUPLEX;
> drivers/spi/spi-mxs.c:576:      master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-omap-uwire.c:490:       master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-pic32-sqi.c:651:        master->flags           = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-pl022.c:1714:                           SSP_MICROWIRE_CHANNEL_HALF_DUPLEX)) {
> drivers/spi/spi-qcom-qspi.c:478:        master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-sprd-adi.c:521: ctlr->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-stm32.c:160:#define STM32H7_SPI_HALF_DUPLEX             3
> drivers/spi/spi-stm32.c:1469:           mode = STM32H7_SPI_HALF_DUPLEX;
> drivers/spi/spi-stm32.c:1472:           mode = STM32H7_SPI_HALF_DUPLEX;
> drivers/spi/spi-ti-qspi.c:758:  master->flags = SPI_MASTER_HALF_DUPLEX;
> drivers/spi/spi-xcomm.c:222:    master->flags = SPI_MASTER_HALF_DUPLEX;

>> There are several transfers left in the driver, where both rx_buf and
>> tx_buf are set. How does your host controller driver know which one to
>> handle?

I'm trying to answer my question:
I think the spi host controller sets SPI_MASTER_HALF_DUPLEX if it only
supports half duplex and the spi framework checks that only either TX or
RX is set during one transfer.

> Your right... there is the mcp251x_hw_rx_frame() call that also uses
> spi_rx_buf after a synchronous transfer (I didn't see any others).
> I'll look at this again.

Have you hardware to test your changes? I think the SPI framework would
return an -EINVAL in that case....though the return value is sometimes
not checked by the driver :/

> In general is it an ok approach to switch the driver to half-duplex
> for this issue without the need of complicating things with a
> module/dt param?

AFAICS the chip doesn't do real full duplex. It either send or receives
data at the same time. With splitting one pseudo full duplex transfer
into two half duplex transfers brings some minor overhead, but I think
that's hardly measurable.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
