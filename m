Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B4A2BA8F3
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 12:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgKTLXt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 06:23:49 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:33833 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgKTLXt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2020 06:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605871422;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=jU0zOVoODlkAJjGqxa8+qtY/HTi0AhyqICrOXWxIzis=;
        b=A2WQH/5KhTWeNrTZhQ80b68KgmjNg6ZRNY642P2cWUhyBhwq9aSItrB83yD5WAkTuC
        A76je2z2vYuOg/58Jc1E9TkkYu+R3wUlDcpePXA6dAu/r2wS5cNjl5+1VjAXIDeE6BiD
        BD6z+361Oo3hb/zT3VVdm3jOpjVh8Xd8JtEU0RiSctKtX8O2kOrSjG1EnNJm5IM1tOei
        8aTNwV0gykEk+maPg95Do99GKOW6ccY2Ynvrszgv1ZbbFHzedwRWvhOjuLrcTvf82ncQ
        oBG+NzkjnYTnMG/mI+avqno5nvGw5yXQ+spa7vdJARSAcmpM9qG5GB9cD33q0sJHm/84
        p5Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMlqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwAKBNYX5l
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 20 Nov 2020 12:23:34 +0100 (CET)
Subject: Re: [net] can: gs_usb: fix endianess problem with candleLight
 firmware
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Maximilian Schneider <max@schneidersoft.net>,
        Hubert Denkmair <hubert@denkmair.de>,
        Michael Rausch <mr@netadair.de>
References: <20201120103818.3386964-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <9872e561-ddb5-4d0f-4d7c-fa74269f1208@hartkopp.net>
Date:   Fri, 20 Nov 2020 12:23:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120103818.3386964-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.11.20 11:38, Marc Kleine-Budde wrote:
> The firmware on the original USB2CAN by Geschwister Schneider Technologie
> Entwicklungs- und Vertriebs UG exchanges all data between the host and the
> device in host byte order. This is done with the struct
> gs_host_config::byte_order member, which is sent first to indicate the desired
> byte order.
> 
> The widely used open source firmware candleLight doesn't support this feature
> and exchanges the data in little endian byte order. This breaks if a device
> with candleLight firmware is used on big endianess systems.

Looks like this problem showed up pretty late.

Won't it be better to implement the feature in the candlelight firmware 
so that only the big endian users need to upgrade the candlelight 
firmware instead of disabling this nice feature?

Regards,
Oliver

> 
> To fix this problem, all u32 (but not the struct gs_host_frame::echo_id, which
> is a transparent cookie) are converted to __le32.
> 
> Cc: Maximilian Schneider <max@schneidersoft.net>
> Cc: Hubert Denkmair <hubert@denkmair.de>
> Reported-by: Michael Rausch <mr@netadair.de>
> Link: https://lore.kernel.org/r/b58aace7-61f3-6df7-c6df-69fee2c66906@netadair.de
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/usb/gs_usb.c | 131 +++++++++++++++++++----------------
>   1 file changed, 70 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3005157059ca..018ca3b057a3 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -63,21 +63,27 @@ enum gs_can_identify_mode {
>   };
>   
>   /* data types passed between host and device */
> +
> +/* The firmware on the original USB2CAN by Geschwister Schneider
> + * Technologie Entwicklungs- und Vertriebs UG exchanges all data
> + * between the host and the device in host byte order. This is done
> + * with the struct gs_host_config::byte_order member, which is sent
> + * first to indicate the desired byte order.
> + *
> + * The widely used open source firmware candleLight doesn't support
> + * this feature and exchanges the data in little endian byte order.
> + */
>   struct gs_host_config {
> -	u32 byte_order;
> +	__le32 byte_order;
>   } __packed;
> -/* All data exchanged between host and device is exchanged in host byte order,
> - * thanks to the struct gs_host_config byte_order member, which is sent first
> - * to indicate the desired byte order.
> - */
>   
>   struct gs_device_config {
>   	u8 reserved1;
>   	u8 reserved2;
>   	u8 reserved3;
>   	u8 icount;
> -	u32 sw_version;
> -	u32 hw_version;
> +	__le32 sw_version;
> +	__le32 hw_version;
>   } __packed;
>   
>   #define GS_CAN_MODE_NORMAL               0
> @@ -87,26 +93,26 @@ struct gs_device_config {
>   #define GS_CAN_MODE_ONE_SHOT             BIT(3)
>   
>   struct gs_device_mode {
> -	u32 mode;
> -	u32 flags;
> +	__le32 mode;
> +	__le32 flags;
>   } __packed;
>   
>   struct gs_device_state {
> -	u32 state;
> -	u32 rxerr;
> -	u32 txerr;
> +	__le32 state;
> +	__le32 rxerr;
> +	__le32 txerr;
>   } __packed;
>   
>   struct gs_device_bittiming {
> -	u32 prop_seg;
> -	u32 phase_seg1;
> -	u32 phase_seg2;
> -	u32 sjw;
> -	u32 brp;
> +	__le32 prop_seg;
> +	__le32 phase_seg1;
> +	__le32 phase_seg2;
> +	__le32 sjw;
> +	__le32 brp;
>   } __packed;
>   
>   struct gs_identify_mode {
> -	u32 mode;
> +	__le32 mode;
>   } __packed;
>   
>   #define GS_CAN_FEATURE_LISTEN_ONLY      BIT(0)
> @@ -117,23 +123,23 @@ struct gs_identify_mode {
>   #define GS_CAN_FEATURE_IDENTIFY         BIT(5)
>   
>   struct gs_device_bt_const {
> -	u32 feature;
> -	u32 fclk_can;
> -	u32 tseg1_min;
> -	u32 tseg1_max;
> -	u32 tseg2_min;
> -	u32 tseg2_max;
> -	u32 sjw_max;
> -	u32 brp_min;
> -	u32 brp_max;
> -	u32 brp_inc;
> +	__le32 feature;
> +	__le32 fclk_can;
> +	__le32 tseg1_min;
> +	__le32 tseg1_max;
> +	__le32 tseg2_min;
> +	__le32 tseg2_max;
> +	__le32 sjw_max;
> +	__le32 brp_min;
> +	__le32 brp_max;
> +	__le32 brp_inc;
>   } __packed;
>   
>   #define GS_CAN_FLAG_OVERFLOW 1
>   
>   struct gs_host_frame {
>   	u32 echo_id;
> -	u32 can_id;
> +	__le32 can_id;
>   
>   	u8 can_dlc;
>   	u8 channel;
> @@ -329,13 +335,13 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>   		if (!skb)
>   			return;
>   
> -		cf->can_id = hf->can_id;
> +		cf->can_id = le32_to_cpu(hf->can_id);
>   
>   		cf->can_dlc = get_can_dlc(hf->can_dlc);
>   		memcpy(cf->data, hf->data, 8);
>   
>   		/* ERROR frames tell us information about the controller */
> -		if (hf->can_id & CAN_ERR_FLAG)
> +		if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
>   			gs_update_state(dev, cf);
>   
>   		netdev->stats.rx_packets++;
> @@ -418,11 +424,11 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
>   	if (!dbt)
>   		return -ENOMEM;
>   
> -	dbt->prop_seg = bt->prop_seg;
> -	dbt->phase_seg1 = bt->phase_seg1;
> -	dbt->phase_seg2 = bt->phase_seg2;
> -	dbt->sjw = bt->sjw;
> -	dbt->brp = bt->brp;
> +	dbt->prop_seg = cpu_to_le32(bt->prop_seg);
> +	dbt->phase_seg1 = cpu_to_le32(bt->phase_seg1);
> +	dbt->phase_seg2 = cpu_to_le32(bt->phase_seg2);
> +	dbt->sjw = cpu_to_le32(bt->sjw);
> +	dbt->brp = cpu_to_le32(bt->brp);
>   
>   	/* request bit timings */
>   	rc = usb_control_msg(interface_to_usbdev(intf),
> @@ -503,7 +509,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
>   
>   	cf = (struct can_frame *)skb->data;
>   
> -	hf->can_id = cf->can_id;
> +	hf->can_id = cpu_to_le32(cf->can_id);
>   	hf->can_dlc = cf->can_dlc;
>   	memcpy(hf->data, cf->data, cf->can_dlc);
>   
> @@ -573,6 +579,7 @@ static int gs_can_open(struct net_device *netdev)
>   	int rc, i;
>   	struct gs_device_mode *dm;
>   	u32 ctrlmode;
> +	u32 flags = 0;
>   
>   	rc = open_candev(netdev);
>   	if (rc)
> @@ -640,24 +647,24 @@ static int gs_can_open(struct net_device *netdev)
>   
>   	/* flags */
>   	ctrlmode = dev->can.ctrlmode;
> -	dm->flags = 0;
>   
>   	if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
> -		dm->flags |= GS_CAN_MODE_LOOP_BACK;
> +		flags |= GS_CAN_MODE_LOOP_BACK;
>   	else if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
> -		dm->flags |= GS_CAN_MODE_LISTEN_ONLY;
> +		flags |= GS_CAN_MODE_LISTEN_ONLY;
>   
>   	/* Controller is not allowed to retry TX
>   	 * this mode is unavailable on atmels uc3c hardware
>   	 */
>   	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> -		dm->flags |= GS_CAN_MODE_ONE_SHOT;
> +		flags |= GS_CAN_MODE_ONE_SHOT;
>   
>   	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> -		dm->flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
> +		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
>   
>   	/* finally start device */
> -	dm->mode = GS_CAN_MODE_START;
> +	dm->mode = cpu_to_le32(GS_CAN_MODE_START);
> +	dm->flags = cpu_to_le32(flags);
>   	rc = usb_control_msg(interface_to_usbdev(dev->iface),
>   			     usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
>   			     GS_USB_BREQ_MODE,
> @@ -737,9 +744,9 @@ static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
>   		return -ENOMEM;
>   
>   	if (do_identify)
> -		imode->mode = GS_CAN_IDENTIFY_ON;
> +		imode->mode = cpu_to_le32(GS_CAN_IDENTIFY_ON);
>   	else
> -		imode->mode = GS_CAN_IDENTIFY_OFF;
> +		imode->mode = cpu_to_le32(GS_CAN_IDENTIFY_OFF);
>   
>   	rc = usb_control_msg(interface_to_usbdev(dev->iface),
>   			     usb_sndctrlpipe(interface_to_usbdev(dev->iface),
> @@ -790,6 +797,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
>   	struct net_device *netdev;
>   	int rc;
>   	struct gs_device_bt_const *bt_const;
> +	u32 feature;
>   
>   	bt_const = kmalloc(sizeof(*bt_const), GFP_KERNEL);
>   	if (!bt_const)
> @@ -830,14 +838,14 @@ static struct gs_can *gs_make_candev(unsigned int channel,
>   
>   	/* dev setup */
>   	strcpy(dev->bt_const.name, "gs_usb");
> -	dev->bt_const.tseg1_min = bt_const->tseg1_min;
> -	dev->bt_const.tseg1_max = bt_const->tseg1_max;
> -	dev->bt_const.tseg2_min = bt_const->tseg2_min;
> -	dev->bt_const.tseg2_max = bt_const->tseg2_max;
> -	dev->bt_const.sjw_max = bt_const->sjw_max;
> -	dev->bt_const.brp_min = bt_const->brp_min;
> -	dev->bt_const.brp_max = bt_const->brp_max;
> -	dev->bt_const.brp_inc = bt_const->brp_inc;
> +	dev->bt_const.tseg1_min = le32_to_cpu(bt_const->tseg1_min);
> +	dev->bt_const.tseg1_max = le32_to_cpu(bt_const->tseg1_max);
> +	dev->bt_const.tseg2_min = le32_to_cpu(bt_const->tseg2_min);
> +	dev->bt_const.tseg2_max = le32_to_cpu(bt_const->tseg2_max);
> +	dev->bt_const.sjw_max = le32_to_cpu(bt_const->sjw_max);
> +	dev->bt_const.brp_min = le32_to_cpu(bt_const->brp_min);
> +	dev->bt_const.brp_max = le32_to_cpu(bt_const->brp_max);
> +	dev->bt_const.brp_inc = le32_to_cpu(bt_const->brp_inc);
>   
>   	dev->udev = interface_to_usbdev(intf);
>   	dev->iface = intf;
> @@ -854,28 +862,29 @@ static struct gs_can *gs_make_candev(unsigned int channel,
>   
>   	/* can setup */
>   	dev->can.state = CAN_STATE_STOPPED;
> -	dev->can.clock.freq = bt_const->fclk_can;
> +	dev->can.clock.freq = le32_to_cpu(bt_const->fclk_can);
>   	dev->can.bittiming_const = &dev->bt_const;
>   	dev->can.do_set_bittiming = gs_usb_set_bittiming;
>   
>   	dev->can.ctrlmode_supported = 0;
>   
> -	if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
> +	feature = le32_to_cpu(bt_const->feature);
> +	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
>   		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
>   
> -	if (bt_const->feature & GS_CAN_FEATURE_LOOP_BACK)
> +	if (feature & GS_CAN_FEATURE_LOOP_BACK)
>   		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK;
>   
> -	if (bt_const->feature & GS_CAN_FEATURE_TRIPLE_SAMPLE)
> +	if (feature & GS_CAN_FEATURE_TRIPLE_SAMPLE)
>   		dev->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
>   
> -	if (bt_const->feature & GS_CAN_FEATURE_ONE_SHOT)
> +	if (feature & GS_CAN_FEATURE_ONE_SHOT)
>   		dev->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
>   
>   	SET_NETDEV_DEV(netdev, &intf->dev);
>   
> -	if (dconf->sw_version > 1)
> -		if (bt_const->feature & GS_CAN_FEATURE_IDENTIFY)
> +	if (le32_to_cpu(dconf->sw_version) > 1)
> +		if (feature & GS_CAN_FEATURE_IDENTIFY)
>   			netdev->ethtool_ops = &gs_usb_ethtool_ops;
>   
>   	kfree(bt_const);
> @@ -910,7 +919,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>   	if (!hconf)
>   		return -ENOMEM;
>   
> -	hconf->byte_order = 0x0000beef;
> +	hconf->byte_order = cpu_to_le32(0x0000beef);
>   
>   	/* send host config */
>   	rc = usb_control_msg(interface_to_usbdev(intf),
> 
