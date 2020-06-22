Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21B203EDB
	for <lists+linux-can@lfdr.de>; Mon, 22 Jun 2020 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgFVSNF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jun 2020 14:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgFVSNF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 14:13:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A35C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 11:13:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jnQwI-0000hO-IM; Mon, 22 Jun 2020 20:13:02 +0200
Received: from [IPv6:2a03:f580:87bc:d400:789c:8c3:eaa5:9d1b] (unknown [IPv6:2a03:f580:87bc:d400:789c:8c3:eaa5:9d1b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7198051F321;
        Mon, 22 Jun 2020 18:13:00 +0000 (UTC)
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
 <20200622165325.GA23113@Mani-XPS-13-9360>
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
Message-ID: <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
Date:   Mon, 22 Jun 2020 20:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622165325.GA23113@Mani-XPS-13-9360>
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

On 6/22/20 6:53 PM, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
>> From: Oleksij Rempel <o.rempel@pengutronix.de>
>>
>> This patch adds the device-tree binding documentation for the Microchip
>> MCP25xxFD SPI CAN controller family.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> You need to CC Rob and devicetree list to get a review for this patch.

Will do for next round.

> 
>> ---
>>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
>> new file mode 100644
>> index 000000000000..4993dd49181c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
>> +
> 
> MCP251{7/8}FD?

Which expansion rules should be use for the title? In sh-like shells it would be
MCP251{7,8}FD.

> 
>> +maintainers:
>> +  - Marc Kleine-Budde <mkl@pengutronix.de>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: microchip,mcp2517fd
>> +        description: for MCP2517FD
>> +      - const: microchip,mcp2518fd
>> +        description: for MCP2518FD
>> +      - const: microchip,mcp25xxfd
>> +        description: to autodetect chip variant
>> +
> 
> Actually what benefit this generic compatible provides? User who is integrating
> this driver should know the exact controller instance he is playing with, isn't
> it?

As the chip variant can be autodetected why not do it? It makes device tree
overlays (e.g. for the rpi much simpler), as you don't have to specify the exact
chip variant.

Testing is much easier, as I don't have to change the overlays if swapping the
CAN hat.

> 
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts-extended:
>> +    maxItems: 1
>> +
> 
> Document this just above 'interrupts' property.

Do you mean I should change the order?
- reg:
- clocks:
- interrupts-extended:

> 
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description: Regulator that powers the CAN controller.
>> +    maxItems: 1
>> +
>> +  xceiver-supply:
>> +    description: Regulator that powers the CAN transceiver.
>> +    maxItems: 1
>> +
>> +  rx-int-gpios:
>> +    description:
>> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
>> +      signals a pending RX interrupt.
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    description:
>> +      Must be half or less of "clocks" frequency.
>> +    maximum: 20000000
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts-extended
>> +  - clocks
>> +
> 
> The controller is capable of generating clocks and also able to control few
> GPIOs. So eventually you need to document those properties in bindings even
> your driver is not supporting all of them atm.

I'd like to add support for clocks and GPIOs as soon as someone needs them. DT
bindings will go along with that. So far I have no customer that needs support
for that, do you?

> If you want you can take a look at the bindings patch I posted earlier:
> 
> dt-bindings: can: Document devicetree bindings for MCP25XXFD

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
