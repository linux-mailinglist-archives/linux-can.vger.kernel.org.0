Return-Path: <linux-can+bounces-5567-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3949C79214
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 14:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F8EA4EB625
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBFF342C8E;
	Fri, 21 Nov 2025 13:03:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCD343D9B
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730195; cv=none; b=H/wg3ZqxVt0G4FrvqQaiDO96Av8ONJJeekSGivETKe18xCvD7uoMQRf6KCt3e9dyS/TCADFcLUr/AbwcK6QINgN5cyurc2A4mR6aNsWthic8xMYLkTXFLFxU+aW0OOBsrAHhzPAxs2lrkWE3HmFdSfx3ZW/8MN/0v2oGHJ6AJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730195; c=relaxed/simple;
	bh=YkK/oXJnGvbZKU3ual5nicstOZljfEPn/ryE7CiXY1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOtR7SCCs0osXMm6S2Cu0nCeuj+1WOcedvn2QMYgUPwWvr1rS0opFdUpzVN7mNapeVT15J1TfwgfbQE7CuS2IZTSmnSQFD4xFOjFgCtdLEW9FeAPrDBHLqUJ4F7phCetllb+7XReRRkeI3JxuEG+uC/xIlbwu47Fk1oTNR91tg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMQn2-0002cf-1Y; Fri, 21 Nov 2025 14:03:04 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMQn1-001alV-2Y;
	Fri, 21 Nov 2025 14:03:03 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 692C74A4807;
	Fri, 21 Nov 2025 13:03:03 +0000 (UTC)
Date: Fri, 21 Nov 2025 14:03:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH 10/10] can: grcan: Add CANFD support alongside legacy CAN
Message-ID: <20251121-refined-economic-oyster-5de770-mkl@pengutronix.de>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-11-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vo5t3wpyf3tgrk32"
Content-Disposition: inline
In-Reply-To: <20251118092115.3455-11-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vo5t3wpyf3tgrk32
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/10] can: grcan: Add CANFD support alongside legacy CAN
MIME-Version: 1.0

On 18.11.2025 10:21:15, Arun Muthusamy wrote:
> Include CANFD support with the legacy CAN support, enabling
> support for extended data payloads up to 64 bytes, higher bit rates,
> handle canecho frames.
>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 240 ++++++++++++++++++++++++++++------------
>  1 file changed, 167 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 8753bff4f917..ff7ab979d2c9 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -44,6 +44,8 @@
>
>  #define GRCAN_RESERVE_SIZE(slot1, slot2) (((slot2) - (slot1)) / 4 - 1)
>
> +#define CHECK_SLOT_FDF(slot) ((slot) & GRCAN_RX_FDF)
> +
>  struct grcan_registers {
>  	u32 conf;	/* 0x00 */
>  	u32 stat;	/* 0x04 */
> @@ -181,8 +183,11 @@ struct grcan_registers {
>  			  | GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR	\
>  			  | GRCAN_IRQ_TXLOSS)
>  #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERROR=
S)
> +#define GRCAN_CTRL_MODES (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHO=
T)
> +#define GRCAN_CTRL_MODES_FD (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_=
SHOT | CAN_CTRLMODE_FD)

IMHO no need for these defines, just list the CAN_CTRLMODE

>
>  #define GRCAN_MSG_SIZE		16
> +#define GRCAN_CLASSIC_DATA_SIZE 8
>
>  #define GRCAN_MSG_IDE		0x80000000
>  #define GRCAN_MSG_RTR		0x40000000
> @@ -264,6 +269,12 @@ struct grcan_registers {
>  #define GRCANFD_FDBTR_PS2_BIT 5
>  #define GRCANFD_FDBTR_SJW_BIT 0
>
> +#define GRCAN_TX_BRS  BIT(25)
> +#define GRCAN_TX_FDF  BIT(26)
> +
> +#define GRCAN_RX_BRS  BIT(25)
> +#define GRCAN_RX_FDF  BIT(26)
> +
>  /* Hardware capabilities */
>  struct grcan_hwcap {
>  	/* CAN-FD capable, indicates GRCANFD IP.
> @@ -326,6 +337,13 @@ struct grcan_priv {
>
>  	struct sk_buff **echo_skb;	/* We allocate this on our own */
>
> +	/*
> +	 * Since the CAN FD frame has a variable length, this variable is used
> +	 * to keep track of the index of the CAN echo skb (socket buffer) frame.
> +	 * It's important for ensuring that we correctly manage the echo skb.
> +	 */
> +	u32 echo_skb_idx;
> +
>  	/* The echo skb pointer, pointing into echo_skb and indicating which
>  	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
>  	 * handling"-comment for grcan_start_xmit for more details.
> @@ -637,7 +655,7 @@ static int catch_up_echo_skb(struct net_device *dev, =
int budget, bool echo)
>  	struct grcan_registers __iomem *regs =3D priv->regs;
>  	struct grcan_dma *dma =3D &priv->dma;
>  	struct net_device_stats *stats =3D &dev->stats;
> -	int i, work_done;
> +	int work_done;
>
>  	/* Updates to priv->eskbp and wake-ups of the queue needs to
>  	 * be atomic towards the reads of priv->eskbp and shut-downs
> @@ -648,19 +666,22 @@ static int catch_up_echo_skb(struct net_device *dev=
, int budget, bool echo)
>  	for (work_done =3D 0; work_done < budget || budget < 0; work_done++) {
>  		if (priv->eskbp =3D=3D txrd)
>  			break;
> -		i =3D priv->eskbp / GRCAN_MSG_SIZE;
> -		if (echo) {
> -			/* Normal echo of messages */
> -			stats->tx_packets++;
> -			stats->tx_bytes +=3D can_get_echo_skb(dev, i, NULL);
> -		} else {
> -			/* For cleanup of untransmitted messages */
> -			can_free_echo_skb(dev, i, NULL);
> -		}
>
>  		priv->eskbp =3D grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
>  					     dma->tx.size);
>  		txrd =3D grcan_read_reg(&regs->txrd);
> +
> +		/* Grab the packet once the  packet is send or free untransmitted pack=
et*/
> +		if (priv->eskbp =3D=3D txrd) {
> +			if (echo) {
> +				/* Normal echo of messages */
> +				stats->tx_packets++;
> +				stats->tx_bytes +=3D can_get_echo_skb(dev, priv->echo_skb_idx, NULL);
> +			} else {
> +				/* For cleanup of untransmitted messages */
> +				can_free_echo_skb(dev, priv->echo_skb_idx, NULL);
> +			}
> +		}
>  	}
>  	return work_done;
>  }
> @@ -1174,6 +1195,7 @@ static int grcan_set_mode(struct net_device *dev, e=
num can_mode mode)
>  			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
>  				netif_wake_queue(dev);
>  		}
> +		priv->echo_skb_idx =3D 0;
>  		spin_unlock_irqrestore(&priv->lock, flags);
>  		return err;
>  	}
> @@ -1223,7 +1245,6 @@ static int grcan_open(struct net_device *dev)
>  		netif_start_queue(dev);
>  	priv->resetting =3D false;
>  	priv->closing =3D false;
> -
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -1294,20 +1315,29 @@ static void grcan_transmit_catch_up(struct net_de=
vice *dev)
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  }
>
> +static int grcan_numbds(int len)
> +{
> +	if (len <=3D GRCAN_CLASSIC_DATA_SIZE)
> +		return 1;
> +	return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MS=
G_SIZE);
> +}
> +
>  static int grcan_receive(struct net_device *dev, int budget)
>  {
>  	struct grcan_priv *priv =3D netdev_priv(dev);
>  	struct grcan_registers __iomem *regs =3D priv->regs;
>  	struct grcan_dma *dma =3D &priv->dma;
>  	struct net_device_stats *stats =3D &dev->stats;
> -	struct can_frame *cf;
> +	struct canfd_frame *cf;
>  	struct sk_buff *skb;
> -	u32 wr, rd, startrd;
> +	u32 wr, rd, dlc, startrd;
>  	u32 *slot;
>  	u32 rtr, eff;
> -	int work_done =3D 0;
> +	u8 *data;
> +	int i, bds, payload_offset, copy_len, work_done =3D 0;

Please take care of the infamous reverse-xmas-tree.

>
>  	rd =3D grcan_read_reg(&regs->rxrd);
> +
>  	startrd =3D rd;
>  	for (work_done =3D 0; work_done < budget; work_done++) {
>  		/* Check for packet to receive */
> @@ -1315,44 +1345,70 @@ static int grcan_receive(struct net_device *dev, =
int budget)
>  		if (rd =3D=3D wr)
>  			break;
>
> -		/* Take care of packet */
> -		skb =3D alloc_can_skb(dev, &cf);
> -		if (skb =3D=3D NULL) {
> +		slot =3D dma->rx.buf + rd;
> +
> +		if (CHECK_SLOT_FDF(slot[1]))

IMHO "slot[1] & GRCAN_RX_FDF" is more readable

> +			skb =3D alloc_canfd_skb(dev, &cf);
> +		else
> +			skb =3D alloc_can_skb(priv->dev, (struct can_frame **)&cf);
> +
> +		if (unlikely(!skb)) {
>  			netdev_err(dev,
>  				   "dropping frame: skb allocation failed\n");
>  			stats->rx_dropped++;
>  			continue;
>  		}
>
> -		slot =3D dma->rx.buf + rd;
> -		eff =3D slot[0] & GRCAN_MSG_IDE;
> -		rtr =3D slot[0] & GRCAN_MSG_RTR;
> -		if (eff) {
> -			cf->can_id =3D ((slot[0] & GRCAN_MSG_EID)
> -				      >> GRCAN_MSG_EID_BIT);
> -			cf->can_id |=3D CAN_EFF_FLAG;
> -		} else {
> -			cf->can_id =3D ((slot[0] & GRCAN_MSG_BID)
> -				      >> GRCAN_MSG_BID_BIT);
> -		}
> -		cf->len =3D can_cc_dlc2len((slot[1] & GRCAN_MSG_DLC)
> -					  >> GRCAN_MSG_DLC_BIT);
> -		if (rtr) {
> -			cf->can_id |=3D CAN_RTR_FLAG;
> -		} else {
> -			if (cf->can_dlc > 0) {
> -				*(u32 *)(cf->data) =3D slot[2];
> -				if (cf->can_dlc > 4)
> -					*(u32 *)(cf->data + 4) =3D slot[3];
> +		dlc =3D (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;
> +		if (CHECK_SLOT_FDF(slot[1]))
> +			cf->len =3D can_fd_dlc2len(dlc);
> +		else
> +			cf->len =3D can_cc_dlc2len(dlc);
> +
> +		bds =3D grcan_numbds(cf->len);
> +		payload_offset =3D 0;
> +		data =3D cf->data;
> +
> +		for (i =3D 0; i < bds; i++) {
> +			slot =3D dma->rx.buf + rd;
> +
> +			if (i =3D=3D 0) {
> +				eff =3D slot[0] & GRCAN_MSG_IDE;
> +				rtr =3D slot[0] & GRCAN_MSG_RTR;
> +				if (eff) {
> +					cf->can_id =3D ((slot[0] & GRCAN_MSG_EID)
> +						      >> GRCAN_MSG_EID_BIT);

you can use up to 100 chars now, but please move the ">>" to the end of
the line

> +					cf->can_id |=3D CAN_EFF_FLAG;
> +				} else {
> +					cf->can_id =3D ((slot[0] & GRCAN_MSG_BID)
> +						      >> GRCAN_MSG_BID_BIT);
> +				}
> +				if (rtr)
> +					cf->can_id |=3D CAN_RTR_FLAG;
> +
> +				dlc =3D (slot[1] & GRCAN_MSG_DLC) >> GRCAN_MSG_DLC_BIT;
> +				if (CHECK_SLOT_FDF(slot[1]))
> +					cf->len =3D can_fd_dlc2len(dlc);
> +				else
> +					cf->len =3D can_cc_dlc2len(dlc);
> +
> +				copy_len =3D min(cf->len, GRCAN_CLASSIC_DATA_SIZE);
> +				memcpy(data, &slot[2], copy_len);
> +				payload_offset +=3D copy_len;
> +			} else {
> +				copy_len =3D  min(cf->len - payload_offset, GRCAN_MSG_SIZE);
> +				memcpy(data + payload_offset, slot, copy_len);
> +				payload_offset +=3D copy_len;
>  			}
> -
> -			stats->rx_bytes +=3D cf->len;
> +			rd +=3D GRCAN_MSG_SIZE;
> +			if (rd >=3D dma->tx.size)
> +				rd -=3D dma->tx.size;
>  		}
> -		stats->rx_packets++;
>
> +		/* Update statistics and read pointer */
> +		stats->rx_packets++;
> +		stats->rx_bytes +=3D cf->len;
>  		netif_receive_skb(skb);
> -
> -		rd =3D grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
>  	}
>
>  	/* Make sure everything is read before allowing hardware to
> @@ -1479,12 +1535,15 @@ static netdev_tx_t grcan_start_xmit(struct sk_buf=
f *skb,
>  	struct grcan_priv *priv =3D netdev_priv(dev);
>  	struct grcan_registers __iomem *regs =3D priv->regs;
>  	struct grcan_dma *dma =3D &priv->dma;
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
> -	u32 id, txwr, txrd, space, txctrl;
> -	int slotindex;
> -	u32 *slot;
> -	u32 rtr, eff, dlc, tmp, err;
> +	struct can_frame *cf;
> +	struct canfd_frame *cfd;
> +	int i, bds, copy_len, payload_offset;
>  	unsigned long flags;
> +	u8 *payload;
> +	u8 len;
> +	u32 *slot;
> +	u32 eff, rtr, dlc, tmp, err, can_id;
> +	u32 id, txwr, txrd, space, txctrl;

reverse-xmas-tree for all vars you touch please

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vo5t3wpyf3tgrk32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgYwQACgkQDHRl3/mQ
kZxAEgf/TCDu6bUZyiVTtsFPbM67cqvsjnRdEq+m+mnZDNcTldYlr7OFz9JNDtb3
VItF/b7SEvjjWhWm5c78oSFVvcs2IzMb5FwBxiQnOA8D9OM4ZWbf+z7i1puYKTVz
S+U4ZnYSUtv63olZ0ADluJtWKCTk6M7RHxCCP7BOcat9UVMYT9aHS0iWRCJOxpTH
NWCtwlWyjjMMPboT8l49u8uwZkD6/DCFRKbU7bLNWNLBSzlRFMXwA7arcpZ3ANyK
WKOXGz7Sh5um16maKrGAKhGj1Z5dXPX0NYC0Sz2Toja4o7gPJQ8p1TmNoNj+z7IE
OG7Yp6kjSlCkgMCEZTVg3MvkHPFLWw==
=h0wo
-----END PGP SIGNATURE-----

--vo5t3wpyf3tgrk32--

