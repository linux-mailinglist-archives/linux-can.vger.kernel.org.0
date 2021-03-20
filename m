Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800A8342C46
	for <lists+linux-can@lfdr.de>; Sat, 20 Mar 2021 12:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCTLei (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 20 Mar 2021 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCTLec (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 20 Mar 2021 07:34:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80304C0613A5
        for <linux-can@vger.kernel.org>; Sat, 20 Mar 2021 03:39:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNX6s-0002vO-08; Sat, 20 Mar 2021 09:37:26 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e4c4:ff15:b7f:c586])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D739B5FB19C;
        Sat, 20 Mar 2021 08:37:24 +0000 (UTC)
Date:   Sat, 20 Mar 2021 09:37:24 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] can: dev: can_free_echo_skb(): extend to return can
 frame length
Message-ID: <20210320083724.rtdpai6cbdc7ilcn@pengutronix.de>
References: <20210319142700.305648-1-mkl@pengutronix.de>
 <20210319142700.305648-3-mkl@pengutronix.de>
 <CAMZ6RqJWBB_YRuTxeM8m_=iOz5ABs1Fq1++tdeEZ7vb=jOG9iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ptolampwd5cjnwj4"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJWBB_YRuTxeM8m_=iOz5ABs1Fq1++tdeEZ7vb=jOG9iQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ptolampwd5cjnwj4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.03.2021 17:03:02, Vincent MAILHOL wrote:
> On Fri. 19 mars 2021 at 23:27, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > In order to implement byte queue limits (bql) in CAN drivers, the
> > length of the CAN frame needs to be passed into the networking stack
> > even if the transmission failed for some reason.
> >
> > To avoid to calculate this length twice, extend can_free_echo_skb() to
> > return that value. Convert all users of this function, too.
> >
> > This patch is the natural extension of commit:
> >
> > | 9420e1d495e2 ("can: dev: can_get_echo_skb(): extend to return can
> > |                frame length")
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> [...]
> > diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/=
can/usb/etas_es58x/es58x_core.c
> > index 95d0a02e408b..724ba72237dc 100644
> > --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> > +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> > @@ -314,7 +314,7 @@ static void es58x_can_free_echo_skb_tail(struct net=
_device *netdev)
> >         struct sk_buff *skb =3D priv->can.echo_skb[priv->tx_tail & fifo=
_mask];
> >
> >         netdev_completed_queue(netdev, 1, can_skb_prv(skb)->frame_len);
> > -       can_free_echo_skb(netdev, priv->tx_tail & fifo_mask);
> > +       can_free_echo_skb(netdev, priv->tx_tail & fifo_mask, NULL);
>=20
> Do you already have the etas_es58x driver in can-next/testing?

Locally :) I did the can_free_echo_skb() changes on top of that, this is
why these patches change the es58x_core.c, too.

> Or were you working on the wrong branch?

Don't think so.

> Could you push the last version of can-next/testing? It would be
> easier for me.

I push the testing branch including the can_free_echo_skb() patches. I
added the etas_es58x patches on top and pushed that into a branch called
etas_es58x.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ptolampwd5cjnwj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBVtEEACgkQqclaivrt
76n+xQf+IzxMR5Ub2J95taBIzLlrZeHvMVj3GRoOYn6Pu9Ipxv0B9vq77mRM3tcj
D8qxx5p+sZBvj2LUv2ZovniGfGv7sFvaaUNyOfk9Ys3HZpbBSgKB+TGOSO4k6/ja
38mKlixHsVXxAlBMtYRCu69GNSQrGq+8jMsXamHkBBYyo/xvsoSjtTqwz57lHp17
f6yW3APnsR4PTD1qR/GcKGrvpeghqi/SpH2SQyuQlcDQFCkbDuAyu7VX3TzKYZ6M
bMmRgA9axMU5s93z5MtjDvhyc2Nn7+Kea7A1oMztZ4sPMHZFTARWgAz+MgcWmnRI
d5jCR2cxJyLq1aQCh6YW8DlH/80uWA==
=eNHC
-----END PGP SIGNATURE-----

--ptolampwd5cjnwj4--
