Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E2570ADB
	for <lists+linux-can@lfdr.de>; Mon, 11 Jul 2022 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiGKTlV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGKTlU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 15:41:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57DB558FA
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 12:41:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oAzHS-0003vy-CD; Mon, 11 Jul 2022 21:41:18 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-959c-1f3c-38b0-6980.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:959c:1f3c:38b0:6980])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B8099AE0B1;
        Mon, 11 Jul 2022 19:41:16 +0000 (UTC)
Date:   Mon, 11 Jul 2022 21:41:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Message-ID: <20220711194116.ohkn7lp3o24h7rp5@pengutronix.de>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbmv4lssn3t7vern"
Content-Disposition: inline
In-Reply-To: <20220711183426.96446-3-socketcan@hartkopp.net>
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


--hbmv4lssn3t7vern
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.07.2022 20:34:23, Oliver Hartkopp wrote:
> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
> frame data structure.
>=20
> As the length information is now a uint16 value for CAN XL a new helper
> function can_get_data_len() is introduced to retrieve the data length
> from all types of CAN frames.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/skb.h       | 14 ++++++++++
>  include/uapi/linux/if_ether.h |  1 +
>  net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
>  3 files changed, 56 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 182749e858b3..d043bc4afd6d 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_=
buff *skb)
>  {
>  	/* the CAN specific type of skb is identified by its data length */
>  	return skb->len =3D=3D CANFD_MTU;
>  }
> =20
> +/* get data length inside of CAN frame for all frame types */
> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
> +{
> +	if(skb->len =3D=3D CANXL_MTU) {
> +		const struct canxl_frame *cfx =3D (struct canxl_frame *)skb->data;
> +
> +		return cfx->len;
> +	} else {
> +		const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> +
> +		return cfd->len;
> +	}
> +}
> +
>  #endif /* !_CAN_SKB_H */
> diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
> index d370165bc621..69e0457eb200 100644
> --- a/include/uapi/linux/if_ether.h
> +++ b/include/uapi/linux/if_ether.h
> @@ -136,10 +136,11 @@
>  #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames=
*/
>  #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames =
*/
>  #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
>  #define ETH_P_CAN	0x000C		/* CAN: Controller Area Network */
>  #define ETH_P_CANFD	0x000D		/* CANFD: CAN flexible data rate*/
> +#define ETH_P_CANXL	0x000E		/* CANXL: eXtended frame Length */
>  #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
>  #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
>  #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
>  #define ETH_P_CONTROL	0x0016		/* Card specific control frames */
>  #define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/

This file doesn't change that often I suppose. Or does it make sense to
send this change mainline as soon as possible?

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 1fb49d51b25d..2c9f48aa5f1f 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -197,31 +197,32 @@ static int can_create(struct net *net, struct socke=
t *sock, int protocol,
>   *  -EINVAL when the skb->data does not contain a valid CAN frame
>   */
>  int can_send(struct sk_buff *skb, int loop)
>  {
>  	struct sk_buff *newskb =3D NULL;
> -	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> +	unsigned int len =3D can_get_data_len(skb);
>  	struct can_pkg_stats *pkg_stats =3D dev_net(skb->dev)->can.pkg_stats;
>  	int err =3D -EINVAL;
> =20
>  	if (skb->len =3D=3D CAN_MTU) {
>  		skb->protocol =3D htons(ETH_P_CAN);
> -		if (unlikely(cfd->len > CAN_MAX_DLEN))
> +		if (unlikely(len > CAN_MAX_DLEN))
>  			goto inval_skb;
>  	} else if (skb->len =3D=3D CANFD_MTU) {
>  		skb->protocol =3D htons(ETH_P_CANFD);
> -		if (unlikely(cfd->len > CANFD_MAX_DLEN))
> +		if (unlikely(len > CANFD_MAX_DLEN))
> +			goto inval_skb;
> +	} else if (skb->len =3D=3D CANXL_MTU) {
> +		skb->protocol =3D htons(ETH_P_CANXL);
> +		if (unlikely(len > CANXL_MAX_DLEN || len =3D=3D 0))

Do we need a helper for the > CANXL_MAX_DLEN || =3D=3D 0 check?

>  			goto inval_skb;
>  	} else {
>  		goto inval_skb;
>  	}
> =20
> -	/* Make sure the CAN frame can pass the selected CAN netdevice.
> -	 * As structs can_frame and canfd_frame are similar, we can provide
> -	 * CAN FD frames to legacy CAN drivers as long as the length is <=3D 8
> -	 */
> -	if (unlikely(skb->len > skb->dev->mtu && cfd->len > CAN_MAX_DLEN)) {
> +	/* Make sure the CAN frame can pass the selected CAN netdevice */
> +	if (unlikely(skb->len > skb->dev->mtu)) {
>  		err =3D -EMSGSIZE;
>  		goto inval_skb;
>  	}
> =20
>  	if (unlikely(skb->dev->type !=3D ARPHRD_CAN)) {
> @@ -725,10 +726,36 @@ static int canfd_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
>  free_skb:
>  	kfree_skb(skb);
>  	return NET_RX_DROP;
>  }
> =20
> +static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
> +		     struct packet_type *pt, struct net_device *orig_dev)
> +{
> +	struct canxl_frame *cfx =3D (struct canxl_frame *)skb->data;
> +
> +	if (unlikely(dev->type !=3D ARPHRD_CAN || skb->len !=3D CANXL_MTU)) {
> +		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, =
len %d\n",
> +			     dev->type, skb->len);
> +		goto free_skb;
> +	}
> +
> +	/* This check is made separately since cfx->len would be uninitialized =
if skb->len =3D 0. */
> +	if (unlikely(cfx->len > CANXL_MAX_DLEN || cfx->len =3D=3D 0)) {
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hbmv4lssn3t7vern
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLMfNkACgkQrX5LkNig
0102Rwf+KREsxrmJhjscBQBuWDdUwo7I8qS6jkeL8RTPxgoM7h6abHvdDKT/17nL
+SHMbqCgBA8PIPdAHY4vXBE4Z542Ha5lQRO3uXoHqTmqLUnswLK0O1gGDMZU2iC3
QOvrq/2DB/htNPoUd2kne+TvX1P3QwRKB+/gqdoQQto/mQ1/nHNQTHrpEZ24dJLg
My/6RgWyJBntE5q7v8fvaZlsi6Z4LjSIdy45HMfwGxkVWshniNds7zd6fC8/yyIp
RnP/Fk6frl5UWEbL3jBHT0YVBOSpoTq9t43YspnzwG6ahQ3WHpdxlISMbQsx3wE4
CSpQ+hrNqUpHszHy/SM9zwLGr7Jiew==
=JvgZ
-----END PGP SIGNATURE-----

--hbmv4lssn3t7vern--
