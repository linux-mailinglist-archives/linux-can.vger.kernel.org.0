Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA90292F88
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgJSUfz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 16:35:55 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:31035 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbgJSUfz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 16:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603139753;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ijsFmsHJtpjDdXFyEH31Z3/VWyTDDhCyETonleIOjLc=;
        b=k1Kdx+/7t2ERPHBwHQp+iyZTuvdW1LhyrYAWmGe0I7pPYLCZURgng5mQgcJ8yayHPV
        /MqhYWBPG9glpO3zOKWTU9fIXsbJwX95BAqsI7//PUAHWRvkUfZi3ec58uQzL5a0mBJx
        Zit4uyGe4LpNKa+AkhkK0ztrxETUnNi69a8q6P3leYKPX76cXc6fPZyG3OIs+ZVXSfrS
        IGGdJqcBD+QghfbAz3NYGVGucy6UHQQS5/RgncQ9mwwVyLDpXkIGK9M0jS2itso2jqkd
        JzVBecChM3BKfEzVv9/75LOu3+VRZKYiy7zxoKUEi7/VKMCGc6HkTHLU4kPA/xgsKniJ
        fVWg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h5k0iD"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9JKZrktf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 19 Oct 2020 22:35:53 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
Date:   Mon, 19 Oct 2020 22:35:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201019190524.1285319-5-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19.10.20 21:05, Marc Kleine-Budde wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> In classical CAN, the length of the data (i.e. CAN payload) is not
> always equal to the DLC! If the frame is a Remote Transmission Request
> (RTR), data length is always zero regardless of DLC value and else, if
> the DLC is greater than 8, the length is 8. Contrary to common belief,
> ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow DLCs greater than 8
> for Classical Frames and specifies that those DLCs shall indicate that
> the data field is 8 bytes long.
> 
> Above facts are widely unknown and so many developpers uses the "len"
> field of "struct canfd_frame" to get the length of classical CAN
> frames: this is incorrect!
> 
> This patch introduces function get_can_len() which can be used in
> remediation. The function takes the SKB as an input in order to be
> able to determine if the frame is classical or FD.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Link: https://lore.kernel.org/r/20201002154219.4887-4-mailhol.vincent@wanadoo.fr
> [mkl: renamed get_can_len() -> can_get_len()]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   include/linux/can/dev.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 41ff31795320..2bb132fc6d88 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -192,6 +192,29 @@ u8 can_dlc2len(u8 can_dlc);
>   /* map the sanitized data length to an appropriate data length code */
>   u8 can_len2dlc(u8 len);
>   
> +/*
> + * can_get_len(skb) - get the length of the CAN payload.
> + *
> + * In classical CAN, the length of the data (i.e. CAN payload) is not
> + * always equal to the DLC! If the frame is a Remote Transmission
> + * Request (RTR), data length is always zero regardless of DLC value
> + * and else, if the DLC is greater than 8, the length is 8. Contrary
> + * to common belief, ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow
> + * DLCs greater than 8 for Classical Frames and specifies that those
> + * DLCs shall indicate that the data field is 8 bytes long.
> + */
> +static inline u8 can_get_len(const struct sk_buff *skb)
> +{
> +	const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
> +
> +	if (can_is_canfd_skb(skb))
> +		return min_t(u8, cf->len, CANFD_MAX_DLEN);
> +	else if (cf->can_id & CAN_RTR_FLAG)
> +		return 0;
> +	else
> +		return min_t(u8, cf->len, CAN_MAX_DLEN);
> +}

The main idea behind this patch and patch 05/16 is to provide a correct 
statistic in the tx bytes, right?

A simple test for the CAN_RTR_FLAG will do the job as all the length 
sanitizing is already done in the tx path by can_dropped_invalid_skb() 
in all known drivers right *before* the skb is stored in the echo skb array.

IMO there's no need for a separate helper function. Maybe a macro which 
should have something with 'payload' in its name - to determine the tx 
byte statistics based on CAN_RTR_FLAG ...

Regards,
Oliver

> +
>   struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>   				    unsigned int txqs, unsigned int rxqs);
>   #define alloc_candev(sizeof_priv, echo_skb_max) \
> 
