Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00CB29E7C8
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 10:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgJ2Juk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Oct 2020 05:50:40 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:17437 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJ2Juk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Oct 2020 05:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603965035;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=MGPGZzA2Jxemu5POOEqa+fVJy7QBNQ0VUv7Bygx6zO0=;
        b=NG0VgdycgOEP6LGSiXabgbE1YLtQ0Mwp1t1VmHcJMwj9Ha4afogoh0Pj5QKUczigUf
        wp4QKBjzaNbqJawjqGLgvPSnEfKYIC2x+TKWveGb+sUAY2bm7jpAfDtQcD6BY7Yu3Ier
        fO5oVqzD5DaRUDcP+KSRkTJCxZvYWCYnEiQSVjMyArZLiaB+xPyJ3MqYwYwNWPKd7EPh
        qzW18bMK5x6zcB2fF5jiIoK3UjmZntGW3pP2/CdyUvjJEBlXa1qb26YTfbkBl0pf6MQC
        leplKFf88smePQ3mBm1VK6bHD+qc3/87RrsblSIdiUBAZyyyHculefEPzkAI6gsgvULe
        eG8w==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOM1ppw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bew9T9oW0vP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 29 Oct 2020 10:50:32 +0100 (CET)
Subject: Re: [PATCH testing-only] can-dev: implement len8_dlc in some CAN USB
 adapters for testing
To:     mkl@pengutronix.de, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201029083258.41569-1-socketcan@hartkopp.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d58008e9-3e07-73b4-27bb-ac5eeebacc0f@hartkopp.net>
Date:   Thu, 29 Oct 2020 10:50:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029083258.41569-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Info: usb8dev and gs_usb work as expected.
The hack for the PCAN FD adapter crashes the system - I have to look 
into it ...

On 29.10.20 09:32, Oliver Hartkopp wrote:
> Namely those that are in mainline and I currently have on my desk ...
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   drivers/net/can/usb/gs_usb.c               |  8 ++++++--
>   drivers/net/can/usb/peak_usb/pcan_usb.c    |  8 ++++++--
>   drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 16 +++++++++++-----
>   drivers/net/can/usb/usb_8dev.c             | 10 ++++++----
>   include/linux/can/dev.h                    | 15 +++++++++++++++
>   5 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3a097c240e5a..fab6ed073e45 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -330,10 +330,13 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>   			return;
>   
>   		cf->can_id = hf->can_id;
>   
>   		cf->len = can_get_cc_len(hf->len);
> +		cf->len8_dlc = can_get_len8_dlc(dev->can.ctrlmode, cf->len,
> +						hf->len);
> +
>   		memcpy(cf->data, hf->data, 8);
>   
>   		/* ERROR frames tell us information about the controller */
>   		if (hf->can_id & CAN_ERR_FLAG)
>   			gs_update_state(dev, cf);
> @@ -502,11 +505,12 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
>   	hf->channel = dev->channel;
>   
>   	cf = (struct can_frame *)skb->data;
>   
>   	hf->can_id = cf->can_id;
> -	hf->len = cf->len;
> +	hf->len = can_get_cc_dlc(dev->can.ctrlmode, cf->len, cf->len8_dlc);
> +
>   	memcpy(hf->data, cf->data, cf->len);
>   
>   	usb_fill_bulk_urb(urb, dev->udev,
>   			  usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT),
>   			  hf,
> @@ -856,11 +860,11 @@ static struct gs_can *gs_make_candev(unsigned int channel,
>   	dev->can.state = CAN_STATE_STOPPED;
>   	dev->can.clock.freq = bt_const->fclk_can;
>   	dev->can.bittiming_const = &dev->bt_const;
>   	dev->can.do_set_bittiming = gs_usb_set_bittiming;
>   
> -	dev->can.ctrlmode_supported = 0;
> +	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
>   
>   	if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
>   		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
>   
>   	if (bt_const->feature & GS_CAN_FEATURE_LOOP_BACK)
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index abecb77e34f2..105a17dc8075 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -733,10 +733,12 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
>   
>   		cf->can_id = le16_to_cpu(tmp16) >> 5;
>   	}
>   
>   	cf->len = can_get_cc_len(rec_len);
> +	cf->len8_dlc = can_get_len8_dlc(mc->pdev->dev.can.ctrlmode, cf->len,
> +					rec_len);
>   
>   	/* Only first packet timestamp is a word */
>   	if (pcan_usb_decode_ts(mc, !mc->rec_ts_idx))
>   		goto decode_failed;
>   
> @@ -836,11 +838,12 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
>   	obuf[1] = 1;
>   
>   	pc = obuf + PCAN_USB_MSG_HEADER_LEN;
>   
>   	/* status/len byte */
> -	*pc = cf->len;
> +	*pc = can_get_cc_dlc(dev->can.ctrlmode, cf->len, cf->len8_dlc);
> +
>   	if (cf->can_id & CAN_RTR_FLAG)
>   		*pc |= PCAN_USB_STATUSLEN_RTR;
>   
>   	/* can id */
>   	if (cf->can_id & CAN_EFF_FLAG) {
> @@ -990,11 +993,12 @@ static const struct can_bittiming_const pcan_usb_const = {
>   const struct peak_usb_adapter pcan_usb = {
>   	.name = "PCAN-USB",
>   	.device_id = PCAN_USB_PRODUCT_ID,
>   	.ctrl_count = 1,
>   	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
> -			      CAN_CTRLMODE_BERR_REPORTING,
> +			      CAN_CTRLMODE_BERR_REPORTING |
> +			      CAN_CTRLMODE_CC_LEN8_DLC,
>   	.clock = {
>   		.freq = PCAN_USB_CRYSTAL_HZ / 2 ,
>   	},
>   	.bittiming_const = &pcan_usb_const,
>   
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 3e875cdbadac..3ed30ab79784 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -492,16 +492,20 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
>   		if (rx_msg_flags & PUCAN_MSG_ERROR_STATE_IND)
>   			cfd->flags |= CANFD_ESI;
>   
>   		cfd->len = can_dlc2len(pucan_msg_get_dlc(rm));
>   	} else {
> +		struct can_frame *cf = (struct can_frame *)cfd;
> +
>   		/* CAN 2.0 frame case */
>   		skb = alloc_can_skb(netdev, (struct can_frame **)&cfd);
>   		if (!skb)
>   			return -ENOMEM;
>   
>   		cfd->len = can_get_cc_len(pucan_msg_get_dlc(rm));
> +		cf->len8_dlc = can_get_len8_dlc(dev->can.ctrlmode, cf->len,
> +						pucan_msg_get_dlc(rm));
>   	}
>   
>   	cfd->can_id = le32_to_cpu(rm->can_id);
>   
>   	if (rx_msg_flags & PUCAN_MSG_EXT_ID)
> @@ -764,12 +768,14 @@ static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
>   			tx_msg_flags |= PUCAN_MSG_BITRATE_SWITCH;
>   
>   		if (cfd->flags & CANFD_ESI)
>   			tx_msg_flags |= PUCAN_MSG_ERROR_STATE_IND;
>   	} else {
> +		struct can_frame *cf = (struct can_frame *)cfd;
> +
>   		/* CAND 2.0 frames */
> -		len = cfd->len;
> +		len = can_get_cc_dlc(dev->can.ctrlmode, cf->len, cf->len8_dlc);
>   
>   		if (cfd->can_id & CAN_RTR_FLAG)
>   			tx_msg_flags |= PUCAN_MSG_RTR;
>   	}
>   
> @@ -1033,11 +1039,11 @@ static const struct can_bittiming_const pcan_usb_fd_data_const = {
>   
>   const struct peak_usb_adapter pcan_usb_fd = {
>   	.name = "PCAN-USB FD",
>   	.device_id = PCAN_USBFD_PRODUCT_ID,
>   	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
> -	.ctrlmode_supported = CAN_CTRLMODE_FD |
> +	.ctrlmode_supported = CAN_CTRLMODE_FD | CAN_CTRLMODE_CC_LEN8_DLC |
>   			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
>   	.clock = {
>   		.freq = PCAN_UFD_CRYSTAL_HZ,
>   	},
>   	.bittiming_const = &pcan_usb_fd_const,
> @@ -1105,11 +1111,11 @@ static const struct can_bittiming_const pcan_usb_chip_data_const = {
>   
>   const struct peak_usb_adapter pcan_usb_chip = {
>   	.name = "PCAN-Chip USB",
>   	.device_id = PCAN_USBCHIP_PRODUCT_ID,
>   	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
> -	.ctrlmode_supported = CAN_CTRLMODE_FD |
> +	.ctrlmode_supported = CAN_CTRLMODE_FD | CAN_CTRLMODE_CC_LEN8_DLC |
>   		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
>   	.clock = {
>   		.freq = PCAN_UFD_CRYSTAL_HZ,
>   	},
>   	.bittiming_const = &pcan_usb_chip_const,
> @@ -1177,11 +1183,11 @@ static const struct can_bittiming_const pcan_usb_pro_fd_data_const = {
>   
>   const struct peak_usb_adapter pcan_usb_pro_fd = {
>   	.name = "PCAN-USB Pro FD",
>   	.device_id = PCAN_USBPROFD_PRODUCT_ID,
>   	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
> -	.ctrlmode_supported = CAN_CTRLMODE_FD |
> +	.ctrlmode_supported = CAN_CTRLMODE_FD | CAN_CTRLMODE_CC_LEN8_DLC |
>   			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
>   	.clock = {
>   		.freq = PCAN_UFD_CRYSTAL_HZ,
>   	},
>   	.bittiming_const = &pcan_usb_pro_fd_const,
> @@ -1249,11 +1255,11 @@ static const struct can_bittiming_const pcan_usb_x6_data_const = {
>   
>   const struct peak_usb_adapter pcan_usb_x6 = {
>   	.name = "PCAN-USB X6",
>   	.device_id = PCAN_USBX6_PRODUCT_ID,
>   	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
> -	.ctrlmode_supported = CAN_CTRLMODE_FD |
> +	.ctrlmode_supported = CAN_CTRLMODE_FD | CAN_CTRLMODE_CC_LEN8_DLC |
>   			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
>   	.clock = {
>   		.freq = PCAN_UFD_CRYSTAL_HZ,
>   	},
>   	.bittiming_const = &pcan_usb_x6_const,
> diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
> index 8aedb2ba37fb..940f1720297e 100644
> --- a/drivers/net/can/usb/usb_8dev.c
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -469,11 +469,12 @@ static void usb_8dev_rx_can_msg(struct usb_8dev_priv *priv,
>   		if (!skb)
>   			return;
>   
>   		cf->can_id = be32_to_cpu(msg->id);
>   		cf->len = can_get_cc_len(msg->dlc & 0xF);
> -
> +		cf->len8_dlc = can_get_len8_dlc(priv->can.ctrlmode, cf->len,
> +						msg->dlc & 0xF);
>   		if (msg->flags & USB_8DEV_EXTID)
>   			cf->can_id |= CAN_EFF_FLAG;
>   
>   		if (msg->flags & USB_8DEV_RTR)
>   			cf->can_id |= CAN_RTR_FLAG;
> @@ -635,11 +636,11 @@ static netdev_tx_t usb_8dev_start_xmit(struct sk_buff *skb,
>   
>   	if (cf->can_id & CAN_EFF_FLAG)
>   		msg->flags |= USB_8DEV_EXTID;
>   
>   	msg->id = cpu_to_be32(cf->can_id & CAN_ERR_MASK);
> -	msg->dlc = cf->len;
> +	msg->dlc = can_get_cc_dlc(priv->can.ctrlmode, cf->len, cf->len8_dlc);
>   	memcpy(msg->data, cf->data, cf->len);
>   	msg->end = USB_8DEV_DATA_END;
>   
>   	for (i = 0; i < MAX_TX_URBS; i++) {
>   		if (priv->tx_contexts[i].echo_index == MAX_TX_URBS) {
> @@ -925,12 +926,13 @@ static int usb_8dev_probe(struct usb_interface *intf,
>   	priv->can.clock.freq = USB_8DEV_ABP_CLOCK;
>   	priv->can.bittiming_const = &usb_8dev_bittiming_const;
>   	priv->can.do_set_mode = usb_8dev_set_mode;
>   	priv->can.do_get_berr_counter = usb_8dev_get_berr_counter;
>   	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> -				      CAN_CTRLMODE_LISTENONLY |
> -				      CAN_CTRLMODE_ONE_SHOT;
> +				       CAN_CTRLMODE_LISTENONLY |
> +				       CAN_CTRLMODE_ONE_SHOT |
> +				       CAN_CTRLMODE_CC_LEN8_DLC;
>   
>   	netdev->netdev_ops = &usb_8dev_netdev_ops;
>   
>   	netdev->flags |= IFF_ECHO; /* we support local echo */
>   
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 45018fbad35f..dd7cc705c81a 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -168,10 +168,25 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>   {
>   	/* the CAN specific type of skb is identified by its data length */
>   	return skb->len == CANFD_MTU;
>   }
>   
> +static inline u8 can_check_len8_dlc(u32 ctrlmode, u8 len, u8 dlc, u8 ret)
> +{
> +	/* return value for len8_dlc only if all conditions apply */
> +	if ((ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC) &&
> +	    (len == CAN_MAX_DLEN) &&
> +	    (dlc > CAN_MAX_DLEN && dlc <= CAN_MAX_RAW_DLC))
> +		ret = dlc;
> +
> +	/* no valid len8_dlc value -> return provided default value */
> +	return ret;
> +}
> +
> +#define can_get_len8_dlc(cm, len, dlc) can_check_len8_dlc(cm, len, dlc, 0)
> +#define can_get_cc_dlc(cm, len, dlc) can_check_len8_dlc(cm, len, dlc, len)
> +
>   /* helper to define static CAN controller features at device creation time */
>   static inline void can_set_static_ctrlmode(struct net_device *dev,
>   					   u32 static_mode)
>   {
>   	struct can_priv *priv = netdev_priv(dev);
> 
