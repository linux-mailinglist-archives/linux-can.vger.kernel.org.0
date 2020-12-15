Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE62DADCD
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 14:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLONME (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 08:12:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:33672 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgLONME (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 08:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608037750;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=kAAETrSI1hAHN3Muw7EVP1h72PNHju9uvBtM97VLeu4=;
        b=tXiUNMmoqtxsrFyD/bxQ9wqSx9hBWk7ivmq0dlTRqcCzKuHwElJO36MBWRx+hsZK/o
        9l/7CQb7jIy8fYFncifegLsTYysoG2McEikiMC0rNVylkdiKC27TN4AtSezCP0afUW62
        YS6pnJIYFr2SR1KHJjzSnQS1hMe9jk6l2nqH0F1brzUQg0zw0yxM0bn+zGYY6Gzk9KwM
        I13nd6P6Wm1SaI4iQPjID71q393avvgy2D+aDSWEAW8ytF/FBOTDvdmtFs1w3cPkZD/N
        mHazU+4RJCEXUwZyzpXuT5/2FEa8ZjQP9MCXGaTHhXcfyjVRjVi99+6QTX9QTYz+3PD3
        UCdQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.8.3 DYNA|AUTH)
        with ESMTPSA id d0af4dwBFD984Nj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 15 Dec 2020 14:09:08 +0100 (CET)
Subject: Re: [PATCH 2/2] can: dev: can_skb_get_dll_len(): introduce function
 to get data length of frame in data link layer
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
References: <20201215125549.540918-1-mkl@pengutronix.de>
 <20201215125549.540918-2-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f2961bfa-5217-b3d5-c5c5-7a6adb41f00d@hartkopp.net>
Date:   Tue, 15 Dec 2020 14:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215125549.540918-2-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15.12.20 13:55, Marc Kleine-Budde wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> This patch adds the function can_skb_get_dll_len() which returns the length of
> a CAN frame on the data link layer, including Start-of-frame, Identifier,
> various other bits, the CRC, the End-of-frame, the Inter frame spacing and the
> actual data.
> 
> Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> Not-Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Not-Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/dev.c   | 166 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/can/dev.h |   3 +
>   2 files changed, 169 insertions(+)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index fa81e3067b3b..e11e3d95453b 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -81,6 +81,172 @@ u8 can_len2dll_len(u8 len)
>   }
>   EXPORT_SYMBOL_GPL(can_len2dll_len);
>   
> +/* Size of a Classical CAN Standard Frame
> + *
> + * Name of Field			Bits
> + * ---------------------------------------------------------
> + * Start-of-frame			1
> + * Identifier				11
> + * Remote transmission request (RTR)	1
> + * Identifier extension bit (IDE)	1
> + * Reserved bit (r0)			1
> + * Data length code (DLC)		4
> + * Data field				0...64
> + * CRC					15
> + * CRC delimiter			1
> + * ACK slot				1
> + * ACK delimiter			1
> + * End-of-frame (EOF)			7
> + * Inter frame spacing			3
> + *
> + * rounded up and ignoring bitsuffing

bitsTuffing :-)

and in all the other copy/paste locations too

> + */
> +#define CAN_DLL_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
> +
> +/* Size of a Classical CAN Extended Frame
> + *
> + * Name of Field			Bits
> + * ---------------------------------------------------------
> + * Start-of-frame			1
> + * Identifier A				11
> + * Substitute remote request (SRR)	1
> + * Identifier extension bit (IDE)	1
> + * Identifier B				18
> + * Remote transmission request (RTR)	1
> + * Reserved bits (r1, r0)		2
> + * Data length code (DLC)		4
> + * Data field				0...64
> + * CRC					15
> + * CRC delimiter			1
> + * ACK slot				1
> + * ACK delimiter			1
> + * End-of-frame (EOF)			7
> + * Inter frame spacing			3
> + *
> + * rounded up and ignoring bitsuffing
> + */
> +#define CAN_DLL_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
> +
> +/* Size of a CAN-FD Standard Frame
> + *
> + * Name of Field			Bits
> + * ---------------------------------------------------------
> + * Start-of-frame			1
> + * Identifier				11
> + * Reserved bit (r1)			1
> + * Identifier extension bit (IDE)	1
> + * Flexible data rate format (FDF)	1
> + * Reserved bit (r0)			1
> + * Bit Rate Switch (BRS)		1
> + * Error Status Indicator (ESI)		1
> + * Data length code (DLC)		4
> + * Data field				0...512
> + * Stuff Bit Count (SBC)		4/5 0...16/20...64
> + * CRC					17/21 0...16/20...64
> + * CRC delimiter (CD)			1
> + * ACK slot (AS)			1
> + * ACK delimiter (AD)			1
> + * End-of-frame (EOF)			7
> + * Inter frame spacing			3
> + *
> + * assuming CRC21, rounded up and ignoring bitsuffing
> + */
> +#define CANFD_DLL_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
> +
> +/* Size of a CAN-FD Extended Frame
> + *
> + * Name of Field			Bits
> + * ---------------------------------------------------------
> + * Start-of-frame			1
> + * Identifier A				11
> + * Substitute remote request (SRR)	1
> + * Identifier extension bit (IDE)	1
> + * Identifier B				18
> + * Reserved bit (r1)			1
> + * Flexible data rate format (FDF)	1
> + * Reserved bit (r0)			1
> + * Bit Rate Switch (BRS)		1
> + * Error Status Indicator (ESI)		1
> + * Data length code (DLC)		4
> + * Data field				0...512
> + * Stuff Bit Count (SBC)		4/5 0...16/20...64
> + * CRC					17/21 0...16/20...64
> + * CRC delimiter (CD)			1
> + * ACK slot (AS)			1
> + * ACK delimiter (AD)			1
> + * End-of-frame (EOF)			7
> + * Inter frame spacing			3
> + *
> + * assuming CRC21, rounded up and ignoring bitsuffing
> + */
> +#define CANFD_DLL_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
> +
> +/* Maximum size of a Classical CAN frame
> + * (rounded up and ignoring bitsuffing)
> + */
> +#define CAN_DLL_LEN_MAX (CAN_DLL_OVERHEAD_EFF + CAN_MAX_DLEN)
> +
> +/* Maximum size of a CAN-FD frame (rough estimation because
> + * ES58X_SFF_BYTES() and ES58X_EFF_BYTES() macros are using the
> + * constant values for Classical CAN, not CAN-FD).
> + */
> +#define CANFD_DLL_LEN_MAX (CANFD_DLL_OVERHEAD_EFF + CANFD_MAX_DLEN)
> +

Would it make sense to move these definitions and/or the below code into 
a separate can_dll.h file?

we have separated the code to calculate these kind of things in 
canframelen.[ch] in the can-utils too.

Regards,
Oliver

> +/**
> + * can_skb_get_dll_len() - Calculate the CAN Data Link Layer length in
> + * bytes of a given skb.
> + * @skb: socket buffer of a CAN message.
> + *
> + * Do a rough calculation: bit stuffing is ignored and length in bits
> + * is rounded up to a length in bytes.
> + *
> + * Rationale: this function is to be used for the BQL functions
> + * (netdev_sent_queue() and netdev_completed_queue()) which expect a
> + * value in bytes. Just using skb->len is insufficient because it will
> + * return the constant value of CAN(FD)_MTU. Doing the bit stuffing
> + * calculation would be too expensive in term of computing resources
> + * for no noticeable gain.
> + *
> + * Remarks:
> + * a.) The payload of CAN FD frames with BRS flag are sent at a
> + * different bitrate. Currently, the can-utils canbusload tool does
> + * not support CAN-FD yet and so we could not run any benchmark to
> + * measure the impact. There might be possible improvement here.
> + * b.) The macro CAN_DLL_OVERHEAD_EFF and CAN_DLL_OVERHEAD_SFF are
> + * for classical CAN. Need to do the addition for CAN-FD (the value
> + * are expected to be close enough so the impact should be minimal or
> + * none).
> + *
> + * Return: length in bytes.
> + */
> +unsigned int can_skb_get_dll_len(const struct sk_buff *skb)
> +{
> +	const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
> +	u8 len;
> +
> +	if (can_is_canfd_skb(skb))
> +		len = can_len2dll_len(cf->len);
> +	else if (cf->can_id & CAN_RTR_FLAG)
> +		len = 0;
> +	else
> +		len = cf->len;
> +
> +	if (can_is_canfd_skb(skb)) {
> +		if (cf->can_id & CAN_EFF_FLAG)
> +			len += CANFD_DLL_OVERHEAD_EFF;
> +		else
> +			len += CANFD_DLL_OVERHEAD_SFF;
> +	} else {
> +		if (cf->can_id & CAN_EFF_FLAG)
> +			len += CAN_DLL_OVERHEAD_EFF;
> +		else
> +			len += CAN_DLL_OVERHEAD_SFF;
> +	}
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(can_skb_get_dll_len);
> +
>   #ifdef CONFIG_CAN_CALC_BITTIMING
>   #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
>   
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 27c359a00203..affdee8f64c4 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -195,6 +195,9 @@ u8 can_len2dlc(u8 len);
>   /* map the sanitized data length to an appropriate data link layer length */
>   u8 can_len2dll_len(u8 len);
>   
> +/* get data link layer length of CAN/CAN-FD frame */
> +unsigned int can_skb_get_dll_len(const struct sk_buff *skb);
> +
>   struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>   				    unsigned int txqs, unsigned int rxqs);
>   #define alloc_candev(sizeof_priv, echo_skb_max) \
> 
