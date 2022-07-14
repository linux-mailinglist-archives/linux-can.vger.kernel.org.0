Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3457562B
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiGNUGJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiGNUGH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 16:06:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEFA624B4
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 13:06:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oC562-0006HM-MS; Thu, 14 Jul 2022 22:06:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F0B8BB1117;
        Thu, 14 Jul 2022 20:06:01 +0000 (UTC)
Date:   Thu, 14 Jul 2022 22:06:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
Message-ID: <20220714200601.mklari3b6uvb7b2e@pengutronix.de>
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-4-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idizgpgf5clvgwff"
Content-Disposition: inline
In-Reply-To: <20220714160541.2071-4-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--idizgpgf5clvgwff
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.07.2022 18:05:39, Oliver Hartkopp wrote:
> Extend the CAN device driver infrastructure to handle CAN XL frames.
> This especially addresses the increased data length which is extended
> to uint16 for CAN XL.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/rx-offload.c |  2 +-
>  drivers/net/can/dev/skb.c        | 55 ++++++++++++++++++++++++++------
>  include/linux/can/skb.h          |  6 +++-
>  3 files changed, 52 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-of=
fload.c
> index a32a01c172d4..8505e547e922 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
> @@ -245,11 +245,11 @@ unsigned int can_rx_offload_get_echo_skb(struct can=
_rx_offload *offload,
>  					 unsigned int *frame_len_ptr)
>  {
>  	struct net_device *dev =3D offload->dev;
>  	struct net_device_stats *stats =3D &dev->stats;
>  	struct sk_buff *skb;
> -	u8 len;
> +	unsigned int len;
>  	int err;
> =20
>  	skb =3D __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>  	if (!skb)
>  		return 0;
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 8bb62dd864c8..c4283fa680be 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -53,11 +53,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_=
device *dev,
>  	BUG_ON(idx >=3D priv->echo_skb_max);
> =20
>  	/* check flag whether this packet has to be looped back */
>  	if (!(dev->flags & IFF_ECHO) ||
>  	    (skb->protocol !=3D htons(ETH_P_CAN) &&
> -	     skb->protocol !=3D htons(ETH_P_CANFD))) {
> +	     skb->protocol !=3D htons(ETH_P_CANFD) &&
> +	     skb->protocol !=3D htons(ETH_P_CANXL))) {
>  		kfree_skb(skb);
>  		return 0;
>  	}
> =20
>  	if (!priv->echo_skb[idx]) {
> @@ -86,12 +87,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_=
device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(can_put_echo_skb);
> =20
>  struct sk_buff *
> -__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
> -		   unsigned int *frame_len_ptr)
> +__can_get_echo_skb(struct net_device *dev, unsigned int idx,
> +		   unsigned int *len_ptr, unsigned int *frame_len_ptr)
>  {
>  	struct can_priv *priv =3D netdev_priv(dev);
> =20
>  	if (idx >=3D priv->echo_skb_max) {
>  		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of b=
ounds (%u/max %u)\n",
> @@ -103,17 +104,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned=
 int idx, u8 *len_ptr,
>  		/* Using "struct canfd_frame::len" for the frame
>  		 * length is supported on both CAN and CANFD frames.
>  		 */
>  		struct sk_buff *skb =3D priv->echo_skb[idx];
>  		struct can_skb_priv *can_skb_priv =3D can_skb_prv(skb);
> -		struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> =20
>  		/* get the real payload length for netdev statistics */
> -		if (cf->can_id & CAN_RTR_FLAG)
> -			*len_ptr =3D 0;
> -		else
> -			*len_ptr =3D cf->len;
> +		*len_ptr =3D can_skb_get_data_len(skb);
> =20
>  		if (frame_len_ptr)
>  			*frame_len_ptr =3D can_skb_priv->frame_len;
> =20
>  		priv->echo_skb[idx] =3D NULL;
> @@ -139,11 +136,11 @@ __can_get_echo_skb(struct net_device *dev, unsigned=
 int idx, u8 *len_ptr,
>   */
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx,
>  			      unsigned int *frame_len_ptr)
>  {
>  	struct sk_buff *skb;
> -	u8 len;
> +	unsigned int len;
> =20
>  	skb =3D __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>  	if (!skb)
>  		return 0;
> =20
> @@ -244,10 +241,47 @@ struct sk_buff *alloc_canfd_skb(struct net_device *=
dev,
> =20
>  	return skb;
>  }
>  EXPORT_SYMBOL_GPL(alloc_canfd_skb);
> =20
> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> +				struct canxl_frame **cfx,
> +				unsigned int datalen)
> +{
> +	struct sk_buff *skb;
> +
> +	if (datalen < CANXL_MIN_DLEN || datalen > CANXL_MAX_DLEN)
> +		goto out_error;
> +
> +	skb =3D netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> +			       CANXL_HEAD_SZ + datalen);
> +	if (unlikely(!skb))
> +		goto out_error;
> +
> +	skb->protocol =3D htons(ETH_P_CANXL);
> +	skb->pkt_type =3D PACKET_BROADCAST;
> +	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +
> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	skb_reset_transport_header(skb);
> +
> +	can_skb_reserve(skb);
> +	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +	can_skb_prv(skb)->skbcnt =3D 0;
> +
> +	*cfx =3D skb_put_zero(skb, CANXL_HEAD_SZ + datalen);

Should the CANXL_XLF be set here?

I have a bad feeling if we have a struct canxl_frame with a fixed size,
but it might not completely be backed by data.....

For example, I've updated the gs_usb driver to work with flexible arrays
to accommodate the different USB frame length:=20

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c=
#L216

Maybe we should talk to Kees Cook what's best to use here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--idizgpgf5clvgwff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLQdyYACgkQrX5LkNig
010ezQf8CKzlSC3dM5Tvk5pzyT2ew4+elMyydqxpUuhHSjI+DI7JXG8eaLqWC5nO
6TaQ4jvnaC6mkb30YSzym/ii/Rx3yMzOcC9sF5uPdB1KO8y/EhXcYJvz6ADeSM6F
3k2+gxsIKQ2Spv6DoiCkmy7lYkI6K/VGLqnwqe0pn+YlbsRdDIBiymX/6y6RNJR/
9NCQ3UXSxLLyWZ7D7cVWJ77Vszz+c0V2EBymBQ4dMhFMR1X/eccMQxu3LfENtHBo
A9qAUtQtJE+Wf1yf7BRBohS9RVVfpCsyRXk+9qjQBqhba97lVlI5Rq8PNcPKGRGs
+tOvRonGvFkAEe8E0XTqpG+KvGLBZg==
=09kR
-----END PGP SIGNATURE-----

--idizgpgf5clvgwff--
