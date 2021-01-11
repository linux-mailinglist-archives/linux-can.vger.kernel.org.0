Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBD2F0E8F
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 09:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbhAKIxT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 03:53:19 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:28863 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbhAKIxT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 03:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610354961;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=gqhjKLJrXlkN950i+YrVlcfvQQCZuBHAkbbg2zgb0gg=;
        b=WZczLi9qHyGfCQtmDh8p/hyVFMmeeoh6DNgnDzreumlJoI9VZUoDYCVeEy3l1ocSde
        8MYPa7N19QUYKDL/3PRMqw0Aum15iI3JfYGkvcwrYXv4sNdn5KIjHcefLjMs+RevhuA3
        pE2WmyNinPWLJBeJlPWY1Nl6kzuiw+yWucIMzme7aesVj/1M1Tet/BtcmEMcrVAThnqO
        fMum572lYDhSKi6aLVxkXChlhZlIwUPfk+s5UgmrqftduRxPA//ohs0MhZTiBK6437A/
        EoQvBnBiLFEWln+OrUC+BvPdeQaqcIyDEZD6i22O1MxYC/AmqhX1z30XYH4SVBNJ6he0
        PHsw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVMh5kUUF"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0B8nJEtC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 11 Jan 2021 09:49:19 +0100 (CET)
Subject: Re: [net-next 04/13] can: dev: move length related code into seperate
 file
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20210109174013.534145-1-mkl@pengutronix.de>
 <20210109174013.534145-5-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <5ce2f307-3352-c3ea-50b7-97e07401a7b9@hartkopp.net>
Date:   Mon, 11 Jan 2021 09:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109174013.534145-5-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

nice cleanup!

On 09.01.21 18:40, Marc Kleine-Budde wrote:
> This patch moves all CAN frame length related code of the CAN device
> infrastructure into a separate file.
> 


> diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
> new file mode 100644
> index 000000000000..540d40dc0bc2
> --- /dev/null
> +++ b/drivers/net/can/dev/length.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
> + * Copyright (C) 2006 Andrey Volkov, Varma Electronics
> + * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> + */

See comment below ...

> +
> +#include <linux/can/dev.h>
> +
> +/* CAN DLC to real data length conversion helpers */
> +
> +static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
> +			     8, 12, 16, 20, 24, 32, 48, 64};
> +
> +/* get data length from raw data length code (DLC) */
> +u8 can_fd_dlc2len(u8 dlc)
> +{
> +	return dlc2len[dlc & 0x0F];
> +}
> +EXPORT_SYMBOL_GPL(can_fd_dlc2len);
> +
> +static const u8 len2dlc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
> +			     9, 9, 9, 9,			/* 9 - 12 */
> +			     10, 10, 10, 10,			/* 13 - 16 */
> +			     11, 11, 11, 11,			/* 17 - 20 */
> +			     12, 12, 12, 12,			/* 21 - 24 */
> +			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
> +			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
> +			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
> +			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
> +			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
> +
> +/* map the sanitized data length to an appropriate data length code */
> +u8 can_fd_len2dlc(u8 len)
> +{
> +	if (unlikely(len > 64))
> +		return 0xF;
> +
> +	return len2dlc[len];
> +}
> +EXPORT_SYMBOL_GPL(can_fd_len2dlc);
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 054c3bed190b..d75fba1d030a 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -18,6 +18,7 @@
>   #include <linux/can/bittiming.h>
>   #include <linux/can/error.h>
>   #include <linux/can/led.h>
> +#include <linux/can/length.h>
>   #include <linux/can/netlink.h>
>   #include <linux/can/skb.h>
>   #include <linux/netdevice.h>
> @@ -83,15 +84,6 @@ struct can_priv {


(..)

> diff --git a/include/linux/can/length.h b/include/linux/can/length.h
> new file mode 100644
> index 000000000000..fabd93bcde3e
> --- /dev/null
> +++ b/include/linux/can/length.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2006 Andrey Volkov <avolkov@varma-el.com>
> + *               Varma Electronics Oy
> + * Copyright (C) 2008 Wolfgang Grandegger <wg@grandegger.com>

The CAN FD and len8_dlc length stuff was completely contributed by myself.

So if this code is now moved to a separate file the former Copyrights 
should be replaced with

Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>

;-)

Best,
Oliver


> + */
> +
> +#ifndef _CAN_LENGTH_H
> +#define _CAN_LENGTH_H
> +
> +/*
> + * can_cc_dlc2len(value) - convert a given data length code (dlc) of a
> + * Classical CAN frame into a valid data length of max. 8 bytes.
> + *
> + * To be used in the CAN netdriver receive path to ensure conformance with
> + * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
> + */
> +#define can_cc_dlc2len(dlc)	(min_t(u8, (dlc), CAN_MAX_DLEN))
> +
> +/* helper to get the data length code (DLC) for Classical CAN raw DLC access */
> +static inline u8 can_get_cc_dlc(const struct can_frame *cf, const u32 ctrlmode)
> +{
> +	/* return len8_dlc as dlc value only if all conditions apply */
> +	if ((ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC) &&
> +	    (cf->len == CAN_MAX_DLEN) &&
> +	    (cf->len8_dlc > CAN_MAX_DLEN && cf->len8_dlc <= CAN_MAX_RAW_DLC))
> +		return cf->len8_dlc;
> +
> +	/* return the payload length as dlc value */
> +	return cf->len;
> +}
> +
> +/* helper to set len and len8_dlc value for Classical CAN raw DLC access */
> +static inline void can_frame_set_cc_len(struct can_frame *cf, const u8 dlc,
> +					const u32 ctrlmode)
> +{
> +	/* the caller already ensured that dlc is a value from 0 .. 15 */
> +	if (ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC && dlc > CAN_MAX_DLEN)
> +		cf->len8_dlc = dlc;
> +
> +	/* limit the payload length 'len' to CAN_MAX_DLEN */
> +	cf->len = can_cc_dlc2len(dlc);
> +}
> +
> +/* get data length from raw data length code (DLC) */
> +u8 can_fd_dlc2len(u8 dlc);
> +
> +/* map the sanitized data length to an appropriate data length code */
> +u8 can_fd_len2dlc(u8 len);
> +
> +#endif /* !_CAN_LENGTH_H */
> 
