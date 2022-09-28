Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D65ED70A
	for <lists+linux-can@lfdr.de>; Wed, 28 Sep 2022 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiI1ICu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Sep 2022 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiI1ICt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Sep 2022 04:02:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B347B784
        for <linux-can@vger.kernel.org>; Wed, 28 Sep 2022 01:02:48 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1odS1m-0006bw-11; Wed, 28 Sep 2022 10:02:46 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 36D77EF5B5;
        Wed, 28 Sep 2022 08:02:44 +0000 (UTC)
Date:   Wed, 28 Sep 2022 10:02:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     dariobin@libero.it
Cc:     Jacob Kroon <jacob.kroon@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220928080243.er7pnbu4mmvyfsbw@pengutronix.de>
References: <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
 <36690382.801104.1663955706569@mail1.libero.it>
 <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
 <8665ef57-17fb-dfd7-afa2-8e5bebceb617@gmail.com>
 <1885528784.804387.1663962304792@mail1.libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hd3phou75aeary3y"
Content-Disposition: inline
In-Reply-To: <1885528784.804387.1663962304792@mail1.libero.it>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hd3phou75aeary3y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.09.2022 21:45:04, dariobin@libero.it wrote:
> I didn't understand if you applied two patches separately or not.
> This was the only patch I had thought of. Which was similar to Marc's=20
> for the interrupt part but differed in the c_can_start_xmit part.
>=20
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -464,13 +464,19 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff =
*skb,
>                 return NETDEV_TX_BUSY;
> =20
>         idx =3D c_can_get_tx_head(tx_ring);
> +       if (idx < c_can_get_tx_tail(tx_ring)) {
> +               if (priv->type =3D=3D BOSCH_D_CAN) {
> +                       cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
> +               } else {
> +                       netif_stop_queue(priv->dev);
> +                       return NETDEV_TX_BUSY;

This works, but it is frowned upon. You intentionally omit adequate flow
control for the C_CAN core. The overhead for starting the
ndo_start_xmit() callback and aborting it with ETDEV_TX_BUSY is
considered too high.

> +               }
> +       }
> +
>         tx_ring->head++;
>         if (c_can_get_tx_free(tx_ring) =3D=3D 0)
>                 netif_stop_queue(dev);
> =20
> -       if (idx < c_can_get_tx_tail(tx_ring))
> -               cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
> -
>         /* Store the message in the interface so we can call
>          * can_put_echo_skb(). We must do this before we enable
>          * transmit as we might race against do_tx().
> @@ -723,7 +729,6 @@ static void c_can_do_tx(struct net_device *dev)
>         struct c_can_tx_ring *tx_ring =3D &priv->tx;
>         struct net_device_stats *stats =3D &dev->stats;
>         u32 idx, obj, pkts =3D 0, bytes =3D 0, pend;
> -       u8 tail;
> =20
>         if (priv->msg_obj_tx_last > 32)
>                 pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
> @@ -759,15 +764,20 @@ static void c_can_do_tx(struct net_device *dev)
>         stats->tx_bytes +=3D bytes;
>         stats->tx_packets +=3D pkts;
> =20
> -       tail =3D c_can_get_tx_tail(tx_ring);
> +       if (priv->type =3D=3D BOSCH_D_CAN) {
> +               u8 tail;
> +
> +               tail =3D c_can_get_tx_tail(tx_ring);
> =20
> -       if (tail =3D=3D 0) {
> -               u8 head =3D c_can_get_tx_head(tx_ring);
> +               if (tail =3D=3D 0) {
> +                       u8 head =3D c_can_get_tx_head(tx_ring);
> =20
> -               /* Start transmission for all cached messages */
> -               for (idx =3D tail; idx < head; idx++) {
> -                       obj =3D idx + priv->msg_obj_tx_first;
> -                       c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQS=
T);
> +                       /* Start transmission for all cached messages */
> +                       for (idx =3D tail; idx < head; idx++) {
> +                               obj =3D idx + priv->msg_obj_tx_first;
> +                               c_can_object_put(dev, IF_NAPI, obj,
> +                                                IF_COMM_TXRQST);
> +                       }
>                 }
>         }
>  }
>=20
> I changed it a little from the previous email because I noticed a problem.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hd3phou75aeary3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMz/6AACgkQrX5LkNig
013Oxwf/WdJqVnM/ZmpZ1KVCKX7eUcWTqM6AAt/Zhi6B6FCEiYssuYj5VcUkFXU8
kjY+i3AYiYWsSpAXZ/PptniROXFRwz1ZQGntnXuzOaI9ecSWm465gd0ANdF1Smii
gOwWF3xxzBjGhJkXoxjLtCEq+nYf1hM4f6sDdKuMoems6qs+eNmSzTgRRMuEpJv+
I9eGrBFeQiMgnsJPnYlOtD2rAE09Nbxmg+QFdhHk74+X+gfteSYF1p101Z4XPqFz
s/H4ft9zSYj49102ej7w9L4Ahkg1EV3hCG2KDF2qwDL4W3e6BP/6j+nnn5lKdhJK
hBzrzhm0wTP+tbf0vI9ypI0PiiORIA==
=4JrX
-----END PGP SIGNATURE-----

--hd3phou75aeary3y--
