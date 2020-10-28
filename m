Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F1829D2B9
	for <lists+linux-can@lfdr.de>; Wed, 28 Oct 2020 22:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgJ1VeT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 17:34:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39177 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgJ1VeR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 17:34:17 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kXjVn-0000c5-Bm; Wed, 28 Oct 2020 12:21:03 +0100
Received: from [IPv6:2a03:f580:87bc:d400:9a81:bf61:4515:808d] (unknown [IPv6:2a03:f580:87bc:d400:9a81:bf61:4515:808d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 406F2583D5C;
        Wed, 28 Oct 2020 11:21:02 +0000 (UTC)
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201028110033.113702-1-socketcan@hartkopp.net>
 <20201028110033.113702-5-socketcan@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 4/4] can: rename can_dlc with len for all struct can_frame
 users
Message-ID: <febc25d0-e715-1494-c972-0939ac46d481@pengutronix.de>
Date:   Wed, 28 Oct 2020 12:20:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201028110033.113702-5-socketcan@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uOvq40UGvYtNmujvdXlh6YNBGzAqql0dl"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uOvq40UGvYtNmujvdXlh6YNBGzAqql0dl
Content-Type: multipart/mixed; boundary="Hpj5nGYsW97Fs8bpMh8poHn9c46fElqCJ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, mailhol.vincent@wanadoo.fr
Cc: linux-can@vger.kernel.org
Message-ID: <febc25d0-e715-1494-c972-0939ac46d481@pengutronix.de>
Subject: Re: [PATCH 4/4] can: rename can_dlc with len for all struct can_frame
 users
References: <20201028110033.113702-1-socketcan@hartkopp.net>
 <20201028110033.113702-5-socketcan@hartkopp.net>
In-Reply-To: <20201028110033.113702-5-socketcan@hartkopp.net>

--Hpj5nGYsW97Fs8bpMh8poHn9c46fElqCJ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/28/20 12:00 PM, Oliver Hartkopp wrote:
> Cleanup the can_dlc usage by renaming it with len from can_frame.len
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

[...]

> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 6dee4f8f2024..537dd4636c90 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -28,14 +28,14 @@ MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.c=
om>");
>  /* CAN DLC to real data length conversion helpers */
> =20
>  static const u8 dlc2len[] =3D {0, 1, 2, 3, 4, 5, 6, 7,
>  			     8, 12, 16, 20, 24, 32, 48, 64};
> =20
> -/* get data length from can_dlc with sanitized can_dlc */
> -u8 can_dlc2len(u8 can_dlc)
> +/* get data length from dlc with sanitized len */
> +u8 can_dlc2len(u8 dlc)
>  {
> -	return dlc2len[can_dlc & 0x0F];
> +	return dlc2len[dlc & 0x0F];
>  }
>  EXPORT_SYMBOL_GPL(can_dlc2len);

unrelated change.

[...]


> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/=
peak_canfd/peak_canfd.c
> index cc01db0c18b8..c25cb53eba4e 100644
> --- a/drivers/net/can/peak_canfd/peak_canfd.c
> +++ b/drivers/net/can/peak_canfd/peak_canfd.c

[...]

> @@ -650,11 +650,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct s=
k_buff *skb,
>  	struct pucan_tx_msg *msg;
>  	u16 msg_size, msg_flags;
>  	unsigned long flags;
>  	bool should_stop_tx_queue;
>  	int room_left;
> -	u8 can_dlc;
> +	u8 len;

unrelated change

> =20
>  	if (can_dropped_invalid_skb(ndev, skb))
>  		return NETDEV_TX_OK;
> =20
>  	msg_size =3D ALIGN(sizeof(*msg) + cf->len, 4);
> @@ -680,22 +680,22 @@ static netdev_tx_t peak_canfd_start_xmit(struct s=
k_buff *skb,
>  		msg->can_id =3D cpu_to_le32(cf->can_id & CAN_SFF_MASK);
>  	}
> =20
>  	if (can_is_canfd_skb(skb)) {
>  		/* CAN FD frame format */
> -		can_dlc =3D can_len2dlc(cf->len);
> +		len =3D can_len2dlc(cf->len);
> =20
>  		msg_flags |=3D PUCAN_MSG_EXT_DATA_LEN;
> =20
>  		if (cf->flags & CANFD_BRS)
>  			msg_flags |=3D PUCAN_MSG_BITRATE_SWITCH;
> =20
>  		if (cf->flags & CANFD_ESI)
>  			msg_flags |=3D PUCAN_MSG_ERROR_STATE_IND;
>  	} else {
>  		/* CAN 2.0 frame format */
> -		can_dlc =3D cf->len;
> +		len =3D cf->len;
> =20
>  		if (cf->can_id & CAN_RTR_FLAG)
>  			msg_flags |=3D PUCAN_MSG_RTR;
>  	}
> =20
> @@ -705,11 +705,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct s=
k_buff *skb,
>  	/* set driver specific bit to differentiate with application loopback=
 */
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
>  		msg_flags |=3D PUCAN_MSG_SELF_RECEIVE;
> =20
>  	msg->flags =3D cpu_to_le16(msg_flags);
> -	msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(priv->index, can_dlc);
> +	msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(priv->index, len);
>  	memcpy(msg->d, cf->data, cf->len);
> =20
>  	/* struct msg client field is used as an index in the echo skbs ring =
*/
>  	msg->client =3D priv->echo_idx;
> =20

[...]

> diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/sof=
ting/softing_fw.c
> index ccd649a8e37b..7e1536877993 100644
> --- a/drivers/net/can/softing/softing_fw.c
> +++ b/drivers/net/can/softing/softing_fw.c
> @@ -622,11 +622,11 @@ int softing_startstop(struct net_device *dev, int=
 up)
>  	 * from here, no errors should occur, or the failed: part
>  	 * must be reviewed
>  	 */
>  	memset(&msg, 0, sizeof(msg));
>  	msg.can_id =3D CAN_ERR_FLAG | CAN_ERR_RESTARTED;
> -	msg.can_dlc =3D CAN_ERR_DLC;
> +	msg.len =3D CAN_ERR_DLC;

unrelated?

_u>  	for (j =3D 0; j < ARRAY_SIZE(card->net); ++j) {
>  		if (!(bus_bitmask_start & (1 << j)))
>  			continue;
>  		netdev =3D card->net[j];
>  		if (!netdev)
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/s=
ofting/softing_main.c
> index 5cc175fd7067..42acfd5149e5 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -82,22 +82,22 @@ static netdev_tx_t softing_netdev_start_xmit(struct=
 sk_buff *skb,
>  	if (cf->can_id & CAN_EFF_FLAG)
>  		*ptr |=3D CMD_XTD;
>  	if (priv->index)
>  		*ptr |=3D CMD_BUS2;
>  	++ptr;
> -	*ptr++ =3D cf->can_dlc;
> +	*ptr++ =3D cf->len;
>  	*ptr++ =3D (cf->can_id >> 0);
>  	*ptr++ =3D (cf->can_id >> 8);
>  	if (cf->can_id & CAN_EFF_FLAG) {
>  		*ptr++ =3D (cf->can_id >> 16);
>  		*ptr++ =3D (cf->can_id >> 24);
>  	} else {
>  		/* increment 1, not 2 as you might think */
>  		ptr +=3D 1;
>  	}
>  	if (!(cf->can_id & CAN_RTR_FLAG))
> -		memcpy(ptr, &cf->data[0], cf->can_dlc);
> +		memcpy(ptr, &cf->data[0], cf->len);
>  	memcpy_toio(&card->dpram[DPRAM_TX + DPRAM_TX_SIZE * fifo_wr],
>  			buf, DPRAM_TX_SIZE);
>  	if (++fifo_wr >=3D DPRAM_TX_CNT)
>  		fifo_wr =3D 0;
>  	iowrite8(fifo_wr, &card->dpram[DPRAM_TX_WR]);
> @@ -165,11 +165,11 @@ static int softing_handle_1(struct softing *card)=

>  		int j;
>  		/* reset condition */
>  		iowrite8(0, &card->dpram[DPRAM_RX_LOST]);
>  		/* prepare msg */
>  		msg.can_id =3D CAN_ERR_FLAG | CAN_ERR_CRTL;
> -		msg.can_dlc =3D CAN_ERR_DLC;
> +		msg.len =3D CAN_ERR_DLC;
>  		msg.data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>  		/*
>  		 * service to all buses, we don't know which it was applicable
>  		 * but only service buses that are online
>  		 */
> @@ -216,11 +216,11 @@ static int softing_handle_1(struct softing *card)=

>  		uint8_t can_state, state;
> =20
>  		state =3D *ptr++;
> =20
>  		msg.can_id =3D CAN_ERR_FLAG;
> -		msg.can_dlc =3D CAN_ERR_DLC;
> +		msg.len =3D CAN_ERR_DLC;

unrelated?

> =20
>  		if (state & SF_MASK_BUSOFF) {
>  			can_state =3D CAN_STATE_BUS_OFF;
>  			msg.can_id |=3D CAN_ERR_BUSOFF;
>  			state =3D STATE_BUSOFF;
> @@ -259,11 +259,11 @@ static int softing_handle_1(struct softing *card)=

>  		}
> =20
>  	} else {
>  		if (cmd & CMD_RTR)
>  			msg.can_id |=3D CAN_RTR_FLAG;
> -		msg.can_dlc =3D can_get_cc_len(*ptr++);
> +		msg.len =3D can_get_cc_len(*ptr++);

same here?

>  		if (cmd & CMD_XTD) {
>  			msg.can_id |=3D CAN_EFF_FLAG;
>  			msg.can_id |=3D le32_to_cpup((void *)ptr);
>  			ptr +=3D 4;
>  		} else {
> @@ -292,19 +292,19 @@ static int softing_handle_1(struct softing *card)=

>  				--priv->tx.pending;
>  			if (card->tx.pending)
>  				--card->tx.pending;
>  			++netdev->stats.tx_packets;
>  			if (!(msg.can_id & CAN_RTR_FLAG))
> -				netdev->stats.tx_bytes +=3D msg.can_dlc;
> +				netdev->stats.tx_bytes +=3D msg.len;

same here?

>  		} else {
>  			int ret;
> =20
>  			ret =3D softing_netdev_rx(netdev, &msg, ktime);
>  			if (ret =3D=3D NET_RX_SUCCESS) {
>  				++netdev->stats.rx_packets;
>  				if (!(msg.can_id & CAN_RTR_FLAG))
> -					netdev->stats.rx_bytes +=3D msg.can_dlc;
> +					netdev->stats.rx_bytes +=3D msg.len;

same here?

>  			} else {
>  				++netdev->stats.rx_dropped;
>  			}
>  		}
>  	}

[...]

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.=
c
> index 07fe84968391..3a097c240e5a 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -133,11 +133,11 @@ struct gs_device_bt_const {
> =20
>  struct gs_host_frame {
>  	u32 echo_id;
>  	u32 can_id;
> =20
> -	u8 can_dlc;
> +	u8 len;

unrelated change?

>  	u8 channel;
>  	u8 flags;
>  	u8 reserved;
> =20
>  	u8 data[8];
> @@ -329,19 +329,19 @@ static void gs_usb_receive_bulk_callback(struct u=
rb *urb)
>  		if (!skb)
>  			return;
> =20
>  		cf->can_id =3D hf->can_id;
> =20
> -		cf->can_dlc =3D can_get_cc_len(hf->can_dlc);
> +		cf->len =3D can_get_cc_len(hf->len);
>  		memcpy(cf->data, hf->data, 8);
> =20
>  		/* ERROR frames tell us information about the controller */
>  		if (hf->can_id & CAN_ERR_FLAG)
>  			gs_update_state(dev, cf);
> =20
>  		netdev->stats.rx_packets++;
> -		netdev->stats.rx_bytes +=3D hf->can_dlc;
> +		netdev->stats.rx_bytes +=3D hf->len;
> =20
>  		netif_rx(skb);
>  	} else { /* echo_id =3D=3D hf->echo_id */
>  		if (hf->echo_id >=3D GS_MAX_TX_URBS) {
>  			netdev_err(netdev,
> @@ -349,11 +349,11 @@ static void gs_usb_receive_bulk_callback(struct u=
rb *urb)
>  				   hf->echo_id);
>  			goto resubmit_urb;
>  		}
> =20
>  		netdev->stats.tx_packets++;
> -		netdev->stats.tx_bytes +=3D hf->can_dlc;
> +		netdev->stats.tx_bytes +=3D hf->len;
> =20
>  		txc =3D gs_get_tx_context(dev, hf->echo_id);
> =20
>  		/* bad devices send bad echo_ids. */
>  		if (!txc) {
> @@ -376,11 +376,11 @@ static void gs_usb_receive_bulk_callback(struct u=
rb *urb)
>  		skb =3D alloc_can_err_skb(netdev, &cf);
>  		if (!skb)
>  			goto resubmit_urb;
> =20
>  		cf->can_id |=3D CAN_ERR_CRTL;
> -		cf->can_dlc =3D CAN_ERR_DLC;
> +		cf->len =3D CAN_ERR_DLC;
>  		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;
>  		netif_rx(skb);
>  	}
> @@ -502,12 +502,12 @@ static netdev_tx_t gs_can_start_xmit(struct sk_bu=
ff *skb,
>  	hf->channel =3D dev->channel;
> =20
>  	cf =3D (struct can_frame *)skb->data;
> =20
>  	hf->can_id =3D cf->can_id;
> -	hf->can_dlc =3D cf->can_dlc;
> -	memcpy(hf->data, cf->data, cf->can_dlc);
> +	hf->len =3D cf->len;
> +	memcpy(hf->data, cf->data, cf->len);
> =20
>  	usb_fill_bulk_urb(urb, dev->udev,
>  			  usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT),
>  			  hf,
>  			  sizeof(*hf),







> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers=
/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index 0f1d3e807d63..d6e18bcb1a7f 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -256,11 +256,11 @@ int kvaser_usb_can_rx_over_error(struct net_devic=
e *netdev)
> =20
>  	cf->can_id |=3D CAN_ERR_CRTL;
>  	cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
> =20
>  	return 0;
>  }
> =20
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/driver=
s/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index b2d56bb1950a..a9a1f7f5a50e 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -893,11 +893,11 @@ static void kvaser_usb_hydra_update_state(struct =
kvaser_usb_net_priv *priv,
>  	cf->data[6] =3D bec->txerr;
>  	cf->data[7] =3D bec->rxerr;
> =20
>  	stats =3D &netdev->stats;
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
>  }
> =20
>  static void kvaser_usb_hydra_state_event(const struct kvaser_usb *dev,=

>  					 const struct kvaser_cmd *cmd)
> @@ -1047,11 +1047,11 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_=
net_priv *priv,
>  	cf->can_id |=3D CAN_ERR_BUSERROR;
>  	cf->data[6] =3D bec.txerr;
>  	cf->data[7] =3D bec.rxerr;
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
> =20
>  	priv->bec.txerr =3D bec.txerr;
>  	priv->bec.rxerr =3D bec.rxerr;
>  }
> @@ -1082,11 +1082,11 @@ static void kvaser_usb_hydra_one_shot_fail(stru=
ct kvaser_usb_net_priv *priv,
>  		priv->can.can_stats.arbitration_lost++;
>  	}
> =20
>  	stats->tx_errors++;
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
>  }
> =20
>  static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *d=
ev,
>  					    const struct kvaser_cmd *cmd)
> @@ -1178,19 +1178,19 @@ static void kvaser_usb_hydra_rx_msg_std(const s=
truct kvaser_usb *dev,
>  	}
> =20
>  	if (flags & KVASER_USB_HYDRA_CF_FLAG_OVERRUN)
>  		kvaser_usb_can_rx_over_error(priv->netdev);
> =20
> -	cf->can_dlc =3D can_get_cc_len(cmd->rx_can.dlc);
> +	cf->len =3D can_get_cc_len(cmd->rx_can.dlc);
> =20
>  	if (flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME)
>  		cf->can_id |=3D CAN_RTR_FLAG;
>  	else
> -		memcpy(cf->data, cmd->rx_can.data, cf->can_dlc);
> +		memcpy(cf->data, cmd->rx_can.data, cf->len);
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
>  }
> =20
>  static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
>  					const struct kvaser_cmd_ext *cmd)
> @@ -1432,11 +1432,11 @@ kvaser_usb_hydra_frame_to_cmd_std(const struct =
kvaser_usb_net_priv *priv,
>  	struct kvaser_cmd *cmd;
>  	struct can_frame *cf =3D (struct can_frame *)skb->data;
>  	u32 flags;
>  	u32 id;
> =20
> -	*frame_len =3D cf->can_dlc;
> +	*frame_len =3D cf->len;
> =20
>  	cmd =3D kcalloc(1, sizeof(struct kvaser_cmd), GFP_ATOMIC);
>  	if (!cmd)
>  		return NULL;
> =20
> @@ -1453,11 +1453,11 @@ kvaser_usb_hydra_frame_to_cmd_std(const struct =
kvaser_usb_net_priv *priv,
>  		id |=3D KVASER_USB_HYDRA_EXTENDED_FRAME_ID;
>  	} else {
>  		id =3D cf->can_id & CAN_SFF_MASK;
>  	}
> =20
> -	cmd->tx_can.dlc =3D cf->can_dlc;
> +	cmd->tx_can.dlc =3D cf->len;
> =20
>  	flags =3D (cf->can_id & CAN_EFF_FLAG ?
>  		 KVASER_USB_HYDRA_CF_FLAG_EXTENDED_ID : 0);
> =20
>  	if (cf->can_id & CAN_RTR_FLAG)
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers=
/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index dcc5aa022e8f..493a33bbe2df 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -348,11 +348,11 @@ kvaser_usb_leaf_frame_to_cmd(const struct kvaser_=
usb_net_priv *priv,
>  	struct kvaser_usb *dev =3D priv->dev;
>  	struct kvaser_cmd *cmd;
>  	u8 *cmd_tx_can_flags =3D NULL;		/* GCC */
>  	struct can_frame *cf =3D (struct can_frame *)skb->data;
> =20
> -	*frame_len =3D cf->can_dlc;
> +	*frame_len =3D cf->len;
> =20
>  	cmd =3D kmalloc(sizeof(*cmd), GFP_ATOMIC);
>  	if (cmd) {
>  		cmd->u.tx_can.tid =3D transid & 0xff;
>  		cmd->len =3D *cmd_len =3D CMD_HEADER_LEN +
> @@ -381,12 +381,12 @@ kvaser_usb_leaf_frame_to_cmd(const struct kvaser_=
usb_net_priv *priv,
>  			cmd->id =3D CMD_TX_STD_MESSAGE;
>  			cmd->u.tx_can.data[0] =3D (cf->can_id >> 6) & 0x1f;
>  			cmd->u.tx_can.data[1] =3D cf->can_id & 0x3f;
>  		}
> =20
> -		cmd->u.tx_can.data[5] =3D cf->can_dlc;
> -		memcpy(&cmd->u.tx_can.data[6], cf->data, cf->can_dlc);
> +		cmd->u.tx_can.data[5] =3D cf->len;
> +		memcpy(&cmd->u.tx_can.data[6], cf->data, cf->len);
> =20
>  		if (cf->can_id & CAN_RTR_FLAG)
>  			*cmd_tx_can_flags |=3D MSG_FLAG_REMOTE_FRAME;
>  	}
>  	return cmd;
> @@ -574,11 +574,11 @@ static void kvaser_usb_leaf_tx_acknowledge(const =
struct kvaser_usb *dev,
>  		skb =3D alloc_can_err_skb(priv->netdev, &cf);
>  		if (skb) {
>  			cf->can_id |=3D CAN_ERR_RESTARTED;
> =20
>  			stats->rx_packets++;
> -			stats->rx_bytes +=3D cf->can_dlc;
> +			stats->rx_bytes +=3D cf->len;
>  			netif_rx(skb);
>  		} else {
>  			netdev_err(priv->netdev,
>  				   "No memory left for err_skb\n");
>  		}
> @@ -692,11 +692,11 @@ kvaser_usb_leaf_rx_error_update_can_state(struct =
kvaser_usb_net_priv *priv,
>  static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
>  				     const struct kvaser_usb_err_summary *es)
>  {
>  	struct can_frame *cf;
>  	struct can_frame tmp_cf =3D { .can_id =3D CAN_ERR_FLAG,
> -				    .can_dlc =3D CAN_ERR_DLC };
> +				    .len =3D CAN_ERR_DLC };
>  	struct sk_buff *skb;
>  	struct net_device_stats *stats;
>  	struct kvaser_usb_net_priv *priv;
>  	enum can_state old_state, new_state;
> =20
> @@ -776,11 +776,11 @@ static void kvaser_usb_leaf_rx_error(const struct=
 kvaser_usb *dev,
> =20
>  	cf->data[6] =3D es->txerr;
>  	cf->data[7] =3D es->rxerr;
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
>  }
> =20
>  /* For USBCAN, report error to userspace if the channels's errors coun=
ter
>   * has changed, or we're the only channel seeing a bus error state.
> @@ -976,17 +976,17 @@ static void kvaser_usb_leaf_rx_can_msg(const stru=
ct kvaser_usb *dev,
>  		if (cf->can_id & KVASER_EXTENDED_FRAME)
>  			cf->can_id &=3D CAN_EFF_MASK | CAN_EFF_FLAG;
>  		else
>  			cf->can_id &=3D CAN_SFF_MASK;
> =20
> -		cf->can_dlc =3D can_get_cc_len(cmd->u.leaf.log_message.dlc);
> +		cf->len =3D can_get_cc_len(cmd->u.leaf.log_message.dlc);
> =20
>  		if (cmd->u.leaf.log_message.flags & MSG_FLAG_REMOTE_FRAME)
>  			cf->can_id |=3D CAN_RTR_FLAG;
>  		else
>  			memcpy(cf->data, &cmd->u.leaf.log_message.data,
> -			       cf->can_dlc);
> +			       cf->len);
>  	} else {
>  		cf->can_id =3D ((rx_data[0] & 0x1f) << 6) | (rx_data[1] & 0x3f);
> =20
>  		if (cmd->id =3D=3D CMD_RX_EXT_MESSAGE) {
>  			cf->can_id <<=3D 18;
> @@ -994,20 +994,20 @@ static void kvaser_usb_leaf_rx_can_msg(const stru=
ct kvaser_usb *dev,
>  				      ((rx_data[3] & 0xff) << 6) |
>  				      (rx_data[4] & 0x3f);
>  			cf->can_id |=3D CAN_EFF_FLAG;
>  		}
> =20
> -		cf->can_dlc =3D can_get_cc_len(rx_data[5]);
> +		cf->len =3D can_get_cc_len(rx_data[5]);
> =20
>  		if (cmd->u.rx_can_header.flag & MSG_FLAG_REMOTE_FRAME)
>  			cf->can_id |=3D CAN_RTR_FLAG;
>  		else
> -			memcpy(cf->data, &rx_data[6], cf->can_dlc);
> +			memcpy(cf->data, &rx_data[6], cf->len);
>  	}
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
>  }
> =20
>  static void kvaser_usb_leaf_start_chip_reply(const struct kvaser_usb *=
dev,
>  					     const struct kvaser_cmd *cmd)
> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_=
usb.c
> index 14352718b004..3d5bd8b0fbd3 100644
> --- a/drivers/net/can/usb/mcba_usb.c
> +++ b/drivers/net/can/usb/mcba_usb.c
> @@ -182,11 +182,11 @@ static inline struct mcba_usb_ctx *mcba_usb_get_f=
ree_ctx(struct mcba_priv *priv,
>  			ctx =3D &priv->tx_context[i];
>  			ctx->ndx =3D i;
> =20
>  			if (cf) {
>  				ctx->can =3D true;
> -				ctx->dlc =3D cf->can_dlc;
> +				ctx->dlc =3D cf->len;
>  			} else {
>  				ctx->can =3D false;
>  				ctx->dlc =3D 0;
>  			}
> =20
> @@ -348,11 +348,11 @@ static netdev_tx_t mcba_usb_start_xmit(struct sk_=
buff *skb,
>  		put_unaligned_be16((cf->can_id & CAN_SFF_MASK) << 5,
>  				   &usb_msg.sid);
>  		usb_msg.eid =3D 0;
>  	}
> =20
> -	usb_msg.dlc =3D cf->can_dlc;
> +	usb_msg.dlc =3D cf->len;
> =20
>  	memcpy(usb_msg.data, cf->data, usb_msg.dlc);
> =20
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		usb_msg.dlc |=3D MCBA_DLC_RTR_MASK;
> @@ -449,16 +449,16 @@ static void mcba_usb_process_can(struct mcba_priv=
 *priv,
>  	}
> =20
>  	if (msg->dlc & MCBA_DLC_RTR_MASK)
>  		cf->can_id |=3D CAN_RTR_FLAG;
> =20
> -	cf->can_dlc =3D can_get_cc_len(msg->dlc & MCBA_DLC_MASK);
> +	cf->len =3D can_get_cc_len(msg->dlc & MCBA_DLC_MASK);
> =20
> -	memcpy(cf->data, msg->data, cf->can_dlc);
> +	memcpy(cf->data, msg->data, cf->len);
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
> =20
>  	can_led_event(priv->netdev, CAN_LED_EVENT_RX);
>  	netif_rx(skb);
>  }
> =20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> index 5df74533ba4d..abecb77e34f2 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -594,11 +594,11 @@ static int pcan_usb_decode_error(struct pcan_usb_=
msg_context *mc, u8 n,
>  		peak_usb_get_ts_time(&mc->pdev->time_ref, mc->ts16,
>  				     &hwts->hwtstamp);
>  	}
> =20
>  	mc->netdev->stats.rx_packets++;
> -	mc->netdev->stats.rx_bytes +=3D cf->can_dlc;
> +	mc->netdev->stats.rx_bytes +=3D cf->len;
>  	netif_rx(skb);
> =20
>  	return 0;
>  }
> =20
> @@ -732,11 +732,11 @@ static int pcan_usb_decode_data(struct pcan_usb_m=
sg_context *mc, u8 status_len)
>  		mc->ptr +=3D 2;
> =20
>  		cf->can_id =3D le16_to_cpu(tmp16) >> 5;
>  	}
> =20
> -	cf->can_dlc =3D can_get_cc_len(rec_len);
> +	cf->len =3D can_get_cc_len(rec_len);
> =20
>  	/* Only first packet timestamp is a word */
>  	if (pcan_usb_decode_ts(mc, !mc->rec_ts_idx))
>  		goto decode_failed;
> =20
> @@ -749,21 +749,21 @@ static int pcan_usb_decode_data(struct pcan_usb_m=
sg_context *mc, u8 status_len)
>  		cf->can_id |=3D CAN_RTR_FLAG;
>  	} else {
>  		if ((mc->ptr + rec_len) > mc->end)
>  			goto decode_failed;
> =20
> -		memcpy(cf->data, mc->ptr, cf->can_dlc);
> +		memcpy(cf->data, mc->ptr, cf->len);
>  		mc->ptr +=3D rec_len;
>  	}
> =20
>  	/* convert timestamp into kernel time */
>  	hwts =3D skb_hwtstamps(skb);
>  	peak_usb_get_ts_time(&mc->pdev->time_ref, mc->ts16, &hwts->hwtstamp);=

> =20
>  	/* update statistics */
>  	mc->netdev->stats.rx_packets++;
> -	mc->netdev->stats.rx_bytes +=3D cf->can_dlc;
> +	mc->netdev->stats.rx_bytes +=3D cf->len;
>  	/* push the skb */
>  	netif_rx(skb);
> =20
>  	return 0;
> =20
> @@ -836,11 +836,11 @@ static int pcan_usb_encode_msg(struct peak_usb_de=
vice *dev, struct sk_buff *skb,
>  	obuf[1] =3D 1;
> =20
>  	pc =3D obuf + PCAN_USB_MSG_HEADER_LEN;
> =20
>  	/* status/len byte */
> -	*pc =3D cf->can_dlc;
> +	*pc =3D cf->len;
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		*pc |=3D PCAN_USB_STATUSLEN_RTR;
> =20
>  	/* can id */
>  	if (cf->can_id & CAN_EFF_FLAG) {
> @@ -856,12 +856,12 @@ static int pcan_usb_encode_msg(struct peak_usb_de=
vice *dev, struct sk_buff *skb,
>  		pc +=3D 2;
>  	}
> =20
>  	/* can data */
>  	if (!(cf->can_id & CAN_RTR_FLAG)) {
> -		memcpy(pc, cf->data, cf->can_dlc);
> -		pc +=3D cf->can_dlc;
> +		memcpy(pc, cf->data, cf->len);
> +		pc +=3D cf->len;
>  	}
> =20
>  	obuf[(*size)-1] =3D (u8)(stats->tx_packets & 0xff);
> =20
>  	return 0;
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_fd.c
> index 57dfa443c995..3e875cdbadac 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -579,11 +579,11 @@ static int pcan_usb_fd_decode_status(struct pcan_=
usb_fd_if *usb_if,
>  		return -ENOMEM;
> =20
>  	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(sm->ts_low));
> =20
>  	netdev->stats.rx_packets++;
> -	netdev->stats.rx_bytes +=3D cf->can_dlc;
> +	netdev->stats.rx_bytes +=3D cf->len;
> =20
>  	return 0;
>  }
> =20
>  /* handle uCAN error message */
> @@ -735,11 +735,11 @@ static int pcan_usb_fd_encode_msg(struct peak_usb=
_device *dev,
>  				  struct sk_buff *skb, u8 *obuf, size_t *size)
>  {
>  	struct pucan_tx_msg *tx_msg =3D (struct pucan_tx_msg *)obuf;
>  	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>  	u16 tx_msg_size, tx_msg_flags;
> -	u8 can_dlc;
> +	u8 len;
> =20
>  	if (cfd->len > CANFD_MAX_DLEN)
>  		return -EINVAL;
> =20
>  	tx_msg_size =3D ALIGN(sizeof(struct pucan_tx_msg) + cfd->len, 4);
> @@ -754,29 +754,29 @@ static int pcan_usb_fd_encode_msg(struct peak_usb=
_device *dev,
>  		tx_msg->can_id =3D cpu_to_le32(cfd->can_id & CAN_SFF_MASK);
>  	}
> =20
>  	if (can_is_canfd_skb(skb)) {
>  		/* considering a CANFD frame */
> -		can_dlc =3D can_len2dlc(cfd->len);
> +		len =3D can_len2dlc(cfd->len);
> =20
>  		tx_msg_flags |=3D PUCAN_MSG_EXT_DATA_LEN;
> =20
>  		if (cfd->flags & CANFD_BRS)
>  			tx_msg_flags |=3D PUCAN_MSG_BITRATE_SWITCH;
> =20
>  		if (cfd->flags & CANFD_ESI)
>  			tx_msg_flags |=3D PUCAN_MSG_ERROR_STATE_IND;
>  	} else {
>  		/* CAND 2.0 frames */
> -		can_dlc =3D cfd->len;
> +		len =3D cfd->len;
> =20
>  		if (cfd->can_id & CAN_RTR_FLAG)
>  			tx_msg_flags |=3D PUCAN_MSG_RTR;
>  	}
> =20
>  	tx_msg->flags =3D cpu_to_le16(tx_msg_flags);
> -	tx_msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, can_dlc)=
;
> +	tx_msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, len);
>  	memcpy(tx_msg->d, cfd->data, cfd->len);
> =20
>  	/* add null size message to tag the end (messages are 32-bits aligned=
)
>  	 */
>  	tx_msg =3D (struct pucan_tx_msg *)(obuf + tx_msg_size);
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.c
> index c7564773fb2b..275087c39602 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -530,26 +530,26 @@ static int pcan_usb_pro_handle_canmsg(struct pcan=
_usb_pro_interface *usb_if,
>  	skb =3D alloc_can_skb(netdev, &can_frame);
>  	if (!skb)
>  		return -ENOMEM;
> =20
>  	can_frame->can_id =3D le32_to_cpu(rx->id);
> -	can_frame->can_dlc =3D rx->len & 0x0f;
> +	can_frame->len =3D rx->len & 0x0f;
> =20
>  	if (rx->flags & PCAN_USBPRO_EXT)
>  		can_frame->can_id |=3D CAN_EFF_FLAG;
> =20
>  	if (rx->flags & PCAN_USBPRO_RTR)
>  		can_frame->can_id |=3D CAN_RTR_FLAG;
>  	else
> -		memcpy(can_frame->data, rx->data, can_frame->can_dlc);
> +		memcpy(can_frame->data, rx->data, can_frame->len);
> =20
>  	hwts =3D skb_hwtstamps(skb);
>  	peak_usb_get_ts_time(&usb_if->time_ref, le32_to_cpu(rx->ts32),
>  			     &hwts->hwtstamp);
> =20
>  	netdev->stats.rx_packets++;
> -	netdev->stats.rx_bytes +=3D can_frame->can_dlc;
> +	netdev->stats.rx_bytes +=3D can_frame->len;
>  	netif_rx(skb);
> =20
>  	return 0;
>  }
> =20
> @@ -660,11 +660,11 @@ static int pcan_usb_pro_handle_error(struct pcan_=
usb_pro_interface *usb_if,
>  	dev->can.state =3D new_state;
> =20
>  	hwts =3D skb_hwtstamps(skb);
>  	peak_usb_get_ts_time(&usb_if->time_ref, le32_to_cpu(er->ts32), &hwts-=
>hwtstamp);
>  	netdev->stats.rx_packets++;
> -	netdev->stats.rx_bytes +=3D can_frame->can_dlc;
> +	netdev->stats.rx_bytes +=3D can_frame->len;
>  	netif_rx(skb);
> =20
>  	return 0;
>  }
> =20
> @@ -765,18 +765,18 @@ static int pcan_usb_pro_encode_msg(struct peak_us=
b_device *dev,
>  	u8 data_type, len, flags;
>  	struct pcan_usb_pro_msg usb_msg;
> =20
>  	pcan_msg_init_empty(&usb_msg, obuf, *size);
> =20
> -	if ((cf->can_id & CAN_RTR_FLAG) || (cf->can_dlc =3D=3D 0))
> +	if ((cf->can_id & CAN_RTR_FLAG) || (cf->len =3D=3D 0))
>  		data_type =3D PCAN_USBPRO_TXMSG0;
> -	else if (cf->can_dlc <=3D 4)
> +	else if (cf->len <=3D 4)
>  		data_type =3D PCAN_USBPRO_TXMSG4;
>  	else
>  		data_type =3D PCAN_USBPRO_TXMSG8;
> =20
> -	len =3D (dev->ctrl_idx << 4) | (cf->can_dlc & 0x0f);
> +	len =3D (dev->ctrl_idx << 4) | (cf->len & 0x0f);
> =20
>  	flags =3D 0;
>  	if (cf->can_id & CAN_EFF_FLAG)
>  		flags |=3D 0x02;
>  	if (cf->can_id & CAN_RTR_FLAG)
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index ea11a3f0392b..ef8f449ce475 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -612,19 +612,19 @@ static void ucan_rx_can_msg(struct ucan_priv *up,=
 struct ucan_message_in *m)
> =20
>  	/* fill the can frame */
>  	cf->can_id =3D canid;
> =20
>  	/* compute DLC taking RTR_FLAG into account */
> -	cf->can_dlc =3D ucan_can_get_cc_len(&m->msg.can_msg, len);
> +	cf->len =3D ucan_can_get_cc_len(&m->msg.can_msg, len);
> =20
>  	/* copy the payload of non RTR frames */
>  	if (!(cf->can_id & CAN_RTR_FLAG) || (cf->can_id & CAN_ERR_FLAG))
> -		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
> +		memcpy(cf->data, m->msg.can_msg.data, cf->len);
> =20
>  	/* don't count error frames as real packets */
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
> =20
>  	/* pass it to Linux */
>  	netif_rx(skb);
>  }
> =20
> @@ -1076,19 +1076,19 @@ static struct urb *ucan_prepare_tx_urb(struct u=
can_priv *up,
> =20
>  	if (cf->can_id & CAN_RTR_FLAG) {
>  		mlen =3D UCAN_OUT_HDR_SIZE +
>  			offsetof(struct ucan_can_msg, dlc) +
>  			sizeof(m->msg.can_msg.dlc);
> -		m->msg.can_msg.dlc =3D cf->can_dlc;
> +		m->msg.can_msg.dlc =3D cf->len;
>  	} else {
>  		mlen =3D UCAN_OUT_HDR_SIZE +
> -			sizeof(m->msg.can_msg.id) + cf->can_dlc;
> -		memcpy(m->msg.can_msg.data, cf->data, cf->can_dlc);
> +			sizeof(m->msg.can_msg.id) + cf->len;
> +		memcpy(m->msg.can_msg.data, cf->data, cf->len);
>  	}
>  	m->len =3D cpu_to_le16(mlen);
> =20
> -	context->dlc =3D cf->can_dlc;
> +	context->dlc =3D cf->len;
> =20
>  	m->subtype =3D echo_index;
> =20
>  	/* build the urb */
>  	usb_fill_bulk_urb(urb, up->udev,
> diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8=
dev.c
> index 9d1597ad7ba4..8aedb2ba37fb 100644
> --- a/drivers/net/can/usb/usb_8dev.c
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -447,11 +447,11 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_p=
riv *priv,
> =20
>  	priv->bec.txerr =3D txerr;
>  	priv->bec.rxerr =3D rxerr;
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	netif_rx(skb);
>  }
> =20
>  /* Read data and status frames */
>  static void usb_8dev_rx_can_msg(struct usb_8dev_priv *priv,
> @@ -468,22 +468,22 @@ static void usb_8dev_rx_can_msg(struct usb_8dev_p=
riv *priv,
>  		skb =3D alloc_can_skb(priv->netdev, &cf);
>  		if (!skb)
>  			return;
> =20
>  		cf->can_id =3D be32_to_cpu(msg->id);
> -		cf->can_dlc =3D can_get_cc_len(msg->dlc & 0xF);
> +		cf->len =3D can_get_cc_len(msg->dlc & 0xF);
> =20
>  		if (msg->flags & USB_8DEV_EXTID)
>  			cf->can_id |=3D CAN_EFF_FLAG;
> =20
>  		if (msg->flags & USB_8DEV_RTR)
>  			cf->can_id |=3D CAN_RTR_FLAG;
>  		else
> -			memcpy(cf->data, msg->data, cf->can_dlc);
> +			memcpy(cf->data, msg->data, cf->len);
> =20
>  		stats->rx_packets++;
> -		stats->rx_bytes +=3D cf->can_dlc;
> +		stats->rx_bytes +=3D cf->len;
>  		netif_rx(skb);
> =20
>  		can_led_event(priv->netdev, CAN_LED_EVENT_RX);
>  	} else {
>  		netdev_warn(priv->netdev, "frame type %d unknown",
> @@ -635,12 +635,12 @@ static netdev_tx_t usb_8dev_start_xmit(struct sk_=
buff *skb,
> =20
>  	if (cf->can_id & CAN_EFF_FLAG)
>  		msg->flags |=3D USB_8DEV_EXTID;
> =20
>  	msg->id =3D cpu_to_be32(cf->can_id & CAN_ERR_MASK);
> -	msg->dlc =3D cf->can_dlc;
> -	memcpy(msg->data, cf->data, cf->can_dlc);
> +	msg->dlc =3D cf->len;
> +	memcpy(msg->data, cf->data, cf->len);
>  	msg->end =3D USB_8DEV_DATA_END;
> =20
>  	for (i =3D 0; i < MAX_TX_URBS; i++) {
>  		if (priv->tx_contexts[i].echo_index =3D=3D MAX_TX_URBS) {
>  			context =3D &priv->tx_contexts[i];
> @@ -654,11 +654,11 @@ static netdev_tx_t usb_8dev_start_xmit(struct sk_=
buff *skb,
>  	if (!context)
>  		goto nofreecontext;
> =20
>  	context->priv =3D priv;
>  	context->echo_index =3D i;
> -	context->dlc =3D cf->can_dlc;
> +	context->dlc =3D cf->len;
> =20
>  	usb_fill_bulk_urb(urb, priv->udev,
>  			  usb_sndbulkpipe(priv->udev, USB_8DEV_ENDP_DATA_TX),
>  			  buf, size, usb_8dev_write_bulk_callback, context);
>  	urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> index 1740fbc371c4..f8445f6dbb3a 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -757,11 +757,11 @@ static int xcan_rx(struct net_device *ndev, int f=
rame_base)
>  	id_xcan =3D priv->read_reg(priv, XCAN_FRAME_ID_OFFSET(frame_base));
>  	dlc =3D priv->read_reg(priv, XCAN_FRAME_DLC_OFFSET(frame_base)) >>
>  				   XCAN_DLCR_DLC_SHIFT;
> =20
>  	/* Change Xilinx CAN data length format to socketCAN data format */
> -	cf->can_dlc =3D can_get_cc_len(dlc);
> +	cf->len =3D can_get_cc_len(dlc);
> =20
>  	/* Change Xilinx CAN ID format to socketCAN ID format */
>  	if (id_xcan & XCAN_IDR_IDE_MASK) {
>  		/* The received frame is an Extended format frame */
>  		cf->can_id =3D (id_xcan & XCAN_IDR_ID1_MASK) >> 3;
> @@ -782,17 +782,17 @@ static int xcan_rx(struct net_device *ndev, int f=
rame_base)
>  	data[0] =3D priv->read_reg(priv, XCAN_FRAME_DW1_OFFSET(frame_base));
>  	data[1] =3D priv->read_reg(priv, XCAN_FRAME_DW2_OFFSET(frame_base));
> =20
>  	if (!(cf->can_id & CAN_RTR_FLAG)) {
>  		/* Change Xilinx CAN data format to socketCAN data format */
> -		if (cf->can_dlc > 0)
> +		if (cf->len > 0)
>  			*(__be32 *)(cf->data) =3D cpu_to_be32(data[0]);
> -		if (cf->can_dlc > 4)
> +		if (cf->len > 4)
>  			*(__be32 *)(cf->data + 4) =3D cpu_to_be32(data[1]);
>  	}
> =20
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cf->len;
>  	stats->rx_packets++;
>  	netif_receive_skb(skb);
> =20
>  	return 1;
>  }
> @@ -968,11 +968,11 @@ static void xcan_update_error_state_after_rxtx(st=
ruct net_device *ndev)
> =20
>  		if (skb) {
>  			struct net_device_stats *stats =3D &ndev->stats;
> =20
>  			stats->rx_packets++;
> -			stats->rx_bytes +=3D cf->can_dlc;
> +			stats->rx_bytes +=3D cf->len;
>  			netif_rx(skb);
>  		}
>  	}
>  }
> =20
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 41b897965376..d045a0dc3dae 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -183,12 +183,12 @@ static inline void can_set_static_ctrlmode(struct=
 net_device *dev,
>  	/* override MTU which was set by default in can_setup()? */
>  	if (static_mode & CAN_CTRLMODE_FD)
>  		dev->mtu =3D CANFD_MTU;
>  }
> =20
> -/* get data length from can_dlc with sanitized can_dlc */
> -u8 can_dlc2len(u8 can_dlc);
> +/* get data length from dlc with sanitized len */
> +u8 can_dlc2len(u8 dlc);

unrealted?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--Hpj5nGYsW97Fs8bpMh8poHn9c46fElqCJ--

--uOvq40UGvYtNmujvdXlh6YNBGzAqql0dl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+ZVBoACgkQqclaivrt
76nUwQf9GJCforioIfaTm5ujMH3ObAo1GkaaI8ZJuvq0E/Oo6yVw24yzUYrq6dYY
9LatGgOI8wpxqcE/eTir5GlxBoitKhkJxQUmnWZFZB9AAKtSW/gUTl6qOS1cSlpJ
o4Xz0DfqI8U0nPXa+2bTwWmKKEMJ+8Th6KatPev+uWLxuNBEqHSCAsv7VaM6CErW
VK6h+WouaWGuj7jWQPXtgtLMb2OLCxeATNw949+xo0M4CeISCg8FOlKKrfda4JK/
8bI8PIRdxaeah+634m57r65ZO5J/Vb+f8aVrzdyfDnhkFhOlwzfHjRnl0ewm1L1L
VTpmQK/NZOicGZcmwHWgpKX9Qtu+mA==
=VmIb
-----END PGP SIGNATURE-----

--uOvq40UGvYtNmujvdXlh6YNBGzAqql0dl--
