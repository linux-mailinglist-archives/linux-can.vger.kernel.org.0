Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88312118A
	for <lists+linux-can@lfdr.de>; Mon, 16 Dec 2019 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfLPRRi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Dec 2019 12:17:38 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:24890 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPRRi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2019 12:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576516656;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OQyVzgjBIbYqK6ida5ynPWumouikbM4/9v3e3+KM/4A=;
        b=KYOcEJDCUWaclX+Gmx8Oi2pePiJ2AuQdK4ruKAaKNXUYNg9fvEV+EC70gaCYERml2k
        vpGTp2fYR36ip9QJIedtXqWBTMt5Pd8wGBF6ZItE8OhHczdBUKzbWdxzU+UoG0GcMkLV
        sXDka0Vg0iDYpdoG10UKBWX8jbNonKmQYB1Yg5JOwjCJnxwon9LCuOUuqk3sLRoTGSYp
        GKN9vpHSVKSZdrlehjdIwCBt5sp0gCShr9BwhQZnJg6WKmcIg4fDXidty+UVdxFyHZ5B
        pYI95ssn7j1Yl4S724HYdBqSIPYPTEn6JToEo0R6V7lJDb8yHwzO49MGamPdwk+krELh
        DXpg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUMh6kkRA"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.0.7 DYNA|AUTH)
        with ESMTPSA id x04ebavBGHHYDoX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 16 Dec 2019 18:17:34 +0100 (CET)
Subject: Re: [PATCH v3] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
References: <20191210103130.11201-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ea12de3d-e258-f4a7-6219-71995dbe8134@hartkopp.net>
Date:   Mon, 16 Dec 2019 18:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210103130.11201-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 10/12/2019 11.31, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> KMSAN sysbot detected a read access to an untinitialized value in the
> headroom of an outgoing CAN related sk_buff. When using CAN sockets this
> area is filled appropriately - but when using a packet socket this
> initialization is missing.
> 
> The problematic read access occurs in the CAN receive path which can
> only be triggered when the sk_buff is sent through a (virtual) CAN
> interface. So we check in the sending path whether we need to perform
> the missing initializations.
> 
> Fixes: d3b58c47d330d ("can: replace timestamp as unique skb attribute")
> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

When do you want to push it upstream?

The patch is ok for me.
Do you need another Acked-by or Tested-by tag?

Best regards,
Oliver

> ---
> Changes since v2:
> - move can_skb_headroom_valid() to header file and make it inline again
>    to fix compilation if CAN_DEV is not enabled.
> 
>   include/linux/can/dev.h | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 9b3c720a31b1..5e3d45525bd3 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -18,6 +18,7 @@
>   #include <linux/can/error.h>
>   #include <linux/can/led.h>
>   #include <linux/can/netlink.h>
> +#include <linux/can/skb.h>
>   #include <linux/netdevice.h>
>   
>   /*
> @@ -91,6 +92,36 @@ struct can_priv {
>   #define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
>   #define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
>   
> +/* Check for outgoing skbs that have not been created by the CAN subsystem */
> +static inline bool can_skb_headroom_valid(struct net_device *dev,
> +					  struct sk_buff *skb)
> +{
> +	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
> +	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
> +		return false;
> +
> +	/* af_packet does not apply CAN skb specific settings */
> +	if (skb->ip_summed == CHECKSUM_NONE) {
> +		/* init headroom */
> +		can_skb_prv(skb)->ifindex = dev->ifindex;
> +		can_skb_prv(skb)->skbcnt = 0;
> +
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +		/* preform proper loopback on capable devices */
> +		if (dev->flags & IFF_ECHO)
> +			skb->pkt_type = PACKET_LOOPBACK;
> +		else
> +			skb->pkt_type = PACKET_HOST;
> +
> +		skb_reset_mac_header(skb);
> +		skb_reset_network_header(skb);
> +		skb_reset_transport_header(skb);
> +	}
> +
> +	return true;
> +}
> +
>   /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
>   static inline bool can_dropped_invalid_skb(struct net_device *dev,
>   					  struct sk_buff *skb)
> @@ -108,6 +139,9 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
>   	} else
>   		goto inval_skb;
>   
> +	if (!can_skb_headroom_valid(dev, skb))
> +		goto inval_skb;
> +
>   	return false;
>   
>   inval_skb:
> 
