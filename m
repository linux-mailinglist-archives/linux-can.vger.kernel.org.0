Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78697117520
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 20:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLITBH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 14:01:07 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:24722 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfLITBH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 14:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575918065;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=A+CXK1XYb7hPHcQRhLEJ+qV2+rey+TcEOw54adaNl4U=;
        b=S7WXaSw/RuhMzlQOo1WCp9L1GZYgGnQITUA1gF5NwrzuWRf7G6FpU6ZhJswlRsW54u
        vEhkuRviet8ZbcijF0YbPt7n1V3HXjE6mR7Wer3XMHajM3+rVb3TvlDMhE8D1NaI7aVR
        hpt0kifbqiJXQuNn0CNtYXK71oNRF46oilbNF4LZT3iC9+5loQhI2PykRkSGbe+vxzsE
        3WFIyp1fYir57woc4/KP1EwhCTQWOoNq3AcTIJzgpYZNdmaZETbTmrH7S6VM70hNAKrm
        XiK7TZTOyxU2GX4b9noQ6F5NPmLsmRLGQtU8HZgo/6gbJD3nx1CGn24G60obbvn++tpX
        BCpA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h5kkUC"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.0.2 DYNA|AUTH)
        with ESMTPSA id 90101evB9J13Mkm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 9 Dec 2019 20:01:03 +0100 (CET)
Subject: Re: [PATCH v2] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
References: <20191209160559.2710-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4f9579b3-a4ff-0190-02ae-0b6a912eb6b1@hartkopp.net>
Date:   Mon, 9 Dec 2019 20:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209160559.2710-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 09/12/2019 17.05, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> KMSAN sysbot detected a read access to an untinitialized value in the headroom
> of an outgoing CAN related sk_buff. When using CAN sockets this area is filled
> appropriately - but when using a packet socket this initialization is missing.
> 
> The problematic read access occurs in the CAN receive path which can only be
> triggered when the sk_buff is sent through a (virtual) CAN interface. So we
> check in the sending path whether we need to perform the missing
> initializations.
> 
> Fixes: d3b58c47d330d ("can: replace timestamp as unique skb attribute")
> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v1
> - rename to can_skb_headroom_valid()
> - reverse logic
> - move to dev.c

Applying this patch and also my v1 patch to Linux 4.1 fails in both 
cases due to cosmetic changes (int to bool, comment style clean-up).

So we can not create a patch which is more convenient to be applied to 
stable Linux 4.1+ anyway.

Feel free to add

Cc: linux-stable <stable@vger.kernel.org> # >= v4.1

Thanks,
Oliver

> 
>   drivers/net/can/dev.c   | 30 ++++++++++++++++++++++++++++++
>   include/linux/can/dev.h |  5 +++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 6ee06a49fb4c..14f1d9ee28a5 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -403,6 +403,36 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
>   }
>   EXPORT_SYMBOL_GPL(can_change_state);
>   
> +/* Check for outgoing skbs that have not been created by the CAN subsystem */
> +bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
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
> +EXPORT_SYMBOL_GPL(can_skb_headroom_valid);
> +
>   /* Local echo of CAN messages
>    *
>    * CAN network devices *should* support a local echo functionality
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 9b3c720a31b1..ca087894458b 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -91,6 +91,8 @@ struct can_priv {
>   #define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
>   #define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
>   
> +bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb);
> +
>   /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
>   static inline bool can_dropped_invalid_skb(struct net_device *dev,
>   					  struct sk_buff *skb)
> @@ -108,6 +110,9 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
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
