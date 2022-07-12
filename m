Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332625712EC
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiGLHRO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 03:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiGLHRO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 03:17:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC874DD7
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 00:17:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oBA8u-0007qq-46; Tue, 12 Jul 2022 09:17:12 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-2099-0011-e8c0-354d.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:2099:11:e8c0:354d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7CBBBAE58B;
        Tue, 12 Jul 2022 07:17:11 +0000 (UTC)
Date:   Tue, 12 Jul 2022 09:17:11 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Message-ID: <20220712071711.msc5aq7rjahwaia2@pengutronix.de>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
 <20220711194116.ohkn7lp3o24h7rp5@pengutronix.de>
 <8a4f80f0-6088-a138-b415-f7bd0b5b5c54@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uizabxuzexektje6"
Content-Disposition: inline
In-Reply-To: <8a4f80f0-6088-a138-b415-f7bd0b5b5c54@hartkopp.net>
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


--uizabxuzexektje6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.07.2022 09:12:49, Oliver Hartkopp wrote:
>=20
>=20
> On 11.07.22 21:41, Marc Kleine-Budde wrote:
> > On 11.07.2022 20:34:23, Oliver Hartkopp wrote:
> > > Enable the PF_CAN infrastructure to handle CAN XL frames. A new ether=
net
> > > protocol type ETH_P_CANXL is defined to tag skbuffs containing the CA=
N XL
> > > frame data structure.
> > >=20
> > > As the length information is now a uint16 value for CAN XL a new help=
er
> > > function can_get_data_len() is introduced to retrieve the data length
> > > from all types of CAN frames.
> > >=20
> > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > > ---
> > >   include/linux/can/skb.h       | 14 ++++++++++
> > >   include/uapi/linux/if_ether.h |  1 +
> > >   net/can/af_can.c              | 49 +++++++++++++++++++++++++++++---=
---
> > >   3 files changed, 56 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> > > index 182749e858b3..d043bc4afd6d 100644
> > > --- a/include/linux/can/skb.h
> > > +++ b/include/linux/can/skb.h
> > > @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct=
 sk_buff *skb)
> > >   {
> > >   	/* the CAN specific type of skb is identified by its data length */
> > >   	return skb->len =3D=3D CANFD_MTU;
> > >   }
> > > +/* get data length inside of CAN frame for all frame types */
> > > +static inline unsigned int can_get_data_len(struct sk_buff *skb)
> > > +{
> > > +	if(skb->len =3D=3D CANXL_MTU) {
> > > +		const struct canxl_frame *cfx =3D (struct canxl_frame *)skb->data;
> > > +
> > > +		return cfx->len;
> > > +	} else {
> > > +		const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> > > +
> > > +		return cfd->len;
> > > +	}
> > > +}
> > > +
> > >   #endif /* !_CAN_SKB_H */
> > > diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_et=
her.h
> > > index d370165bc621..69e0457eb200 100644
> > > --- a/include/uapi/linux/if_ether.h
> > > +++ b/include/uapi/linux/if_ether.h
> > > @@ -136,10 +136,11 @@
> > >   #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP f=
rames*/
> > >   #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP fr=
ames */
> > >   #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
> > >   #define ETH_P_CAN	0x000C		/* CAN: Controller Area Network */
> > >   #define ETH_P_CANFD	0x000D		/* CANFD: CAN flexible data rate*/
> > > +#define ETH_P_CANXL	0x000E		/* CANXL: eXtended frame Length */
> > >   #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
> > >   #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
> > >   #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
> > >   #define ETH_P_CONTROL	0x0016		/* Card specific control frames */
> > >   #define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
> >=20
> > This file doesn't change that often I suppose. Or does it make sense to
> > send this change mainline as soon as possible?
>=20
> AFAIK you only can reserve these values when you have a reference that us=
es
> it. I don't seen any additional pressure here.

There have been added other types that are not used in the kernel (yet).

> > > diff --git a/net/can/af_can.c b/net/can/af_can.c
> > > index 1fb49d51b25d..2c9f48aa5f1f 100644
> > > --- a/net/can/af_can.c
> > > +++ b/net/can/af_can.c
> > > @@ -197,31 +197,32 @@ static int can_create(struct net *net, struct s=
ocket *sock, int protocol,
> > >    *  -EINVAL when the skb->data does not contain a valid CAN frame
> > >    */
> > >   int can_send(struct sk_buff *skb, int loop)
> > >   {
> > >   	struct sk_buff *newskb =3D NULL;
> > > -	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> > > +	unsigned int len =3D can_get_data_len(skb);
> > >   	struct can_pkg_stats *pkg_stats =3D dev_net(skb->dev)->can.pkg_sta=
ts;
> > >   	int err =3D -EINVAL;
> > >   	if (skb->len =3D=3D CAN_MTU) {
> > >   		skb->protocol =3D htons(ETH_P_CAN);
> > > -		if (unlikely(cfd->len > CAN_MAX_DLEN))
> > > +		if (unlikely(len > CAN_MAX_DLEN))
> > >   			goto inval_skb;
> > >   	} else if (skb->len =3D=3D CANFD_MTU) {
> > >   		skb->protocol =3D htons(ETH_P_CANFD);
> > > -		if (unlikely(cfd->len > CANFD_MAX_DLEN))
> > > +		if (unlikely(len > CANFD_MAX_DLEN))
> > > +			goto inval_skb;
> > > +	} else if (skb->len =3D=3D CANXL_MTU) {
> > > +		skb->protocol =3D htons(ETH_P_CANXL);
> > > +		if (unlikely(len > CANXL_MAX_DLEN || len =3D=3D 0))
> >=20
> > Do we need a helper for the > CANXL_MAX_DLEN || =3D=3D 0 check?
>=20
> Some can_xl_is_valid_data_size(unsigned int len) ?

In other location you're using "canxl" not "can_xl".
What about: canxl_valid_data_size()

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uizabxuzexektje6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLNH/QACgkQrX5LkNig
011CIggAmFsoB4kSyP0hc9LrHyAFampbh0fQkVTo/sl3Koh/fYTT/K3kYIp5Ec8n
3Tqms1Y4uxug4nXr324jdc64rdu11pnlw+PPwIkVioab8ymyasN+azCYLQw2Z4pZ
xGePNW0tuCANRYZWUSk1iMfNd4pDyuLmT4V1sDb1VdF8yI6RPTxj9idMpRK4aK0Z
dovgkdOcUz/rfd1tS3+QqU3qgavIpbzM8+VsTeqL6xVkVw+Jv/J4MbXWfRz8iRCi
AXk2rdTlRaf+s6Qt+Kgij/X9e+9JF8zMIebp3+sgAhwH8Qm3HbQ7j3eF2IrKuymb
VbhCJh01WbduYOXtPCppCgog3ECeSA==
=AAOs
-----END PGP SIGNATURE-----

--uizabxuzexektje6--
