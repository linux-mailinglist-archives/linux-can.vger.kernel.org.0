Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923DC572EA3
	for <lists+linux-can@lfdr.de>; Wed, 13 Jul 2022 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiGMHCK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jul 2022 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGMHCJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2022 03:02:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D09E0F5F
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 00:02:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oBWNq-0004xp-B7; Wed, 13 Jul 2022 09:02:06 +0200
Received: from pengutronix.de (124-137-103-86.dynamic.cust.vb-bordesholm.de [86.103.137.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7E597AFA41;
        Wed, 13 Jul 2022 07:02:05 +0000 (UTC)
Date:   Wed, 13 Jul 2022 09:02:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Message-ID: <20220713070201.lzih3zqwxdjcyh2p@pengutronix.de>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
 <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
 <79a8a09e-fa85-cbdc-47cd-e54d89b71728@hartkopp.net>
 <CAMZ6RqJMJEjYaokH798a=GqPPDGps1_x=hMtCijkWs8dMrfNPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="grdff2ohn34ri64e"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJMJEjYaokH798a=GqPPDGps1_x=hMtCijkWs8dMrfNPQ@mail.gmail.com>
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


--grdff2ohn34ri64e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.07.2022 08:58:26, Vincent Mailhol wrote:
> On Wed. 13 Jul. 2022 at 05:20, Oliver Hartkopp <socketcan@hartkopp.net> w=
rote:
> > On 12.07.22 03:23, Vincent Mailhol wrote:
> > > On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
> > >> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethe=
rnet
> > >> protocol type ETH_P_CANXL is defined to tag skbuffs containing the C=
AN XL
> > >> frame data structure.
> > >>
> > >> As the length information is now a uint16 value for CAN XL a new hel=
per
> > >> function can_get_data_len() is introduced to retrieve the data length
> > >> from all types of CAN frames.
> > >>
> > >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > >> ---
> > >>   include/linux/can/skb.h       | 14 ++++++++++
> > >>   include/uapi/linux/if_ether.h |  1 +
> > >>   net/can/af_can.c              | 49 +++++++++++++++++++++++++++++--=
----
> > >>   3 files changed, 56 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> > >> index 182749e858b3..d043bc4afd6d 100644
> > >> --- a/include/linux/can/skb.h
> > >> +++ b/include/linux/can/skb.h
> > >> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struc=
t sk_buff *skb)
> > >>   {
> > >>          /* the CAN specific type of skb is identified by its data l=
ength */
> > >>          return skb->len =3D=3D CANFD_MTU;
> > >>   }
> > >>
> > >> +/* get data length inside of CAN frame for all frame types */> +sta=
tic inline unsigned int can_get_data_len(struct sk_buff *skb)
> > >> +{
> > >> +       if(skb->len =3D=3D CANXL_MTU) {
> > >> +               const struct canxl_frame *cfx =3D (struct canxl_fram=
e *)skb->data;
> > >> +
> > >> +               return cfx->len;
> > >> +       } else {
> > >> +               const struct canfd_frame *cfd =3D (struct canfd_fram=
e *)skb->data;
> > >> +
> > >> +               return cfd->len;
> > >> +       }
> > >> +}
> > >
> > > What about the RTR frames?
> > >
> > > If there are cases in which we intentionally want the declared length
> > > and not the actual length, it might be good to have two distinct
> > > helper functions.
> >
> > Good idea.
> >
> > > /* get data length inside of CAN frame for all frame types. For
> > >   * RTR frames, return zero. */
> > > static inline unsigned int can_get_actual_len(struct sk_buff *skb)
> >
> > I would name this one can_get_data_len()
>=20
> ACK.
>=20
> > > {
> > >         const struct canxl_frame *cfx =3D (struct canxl_frame *)skb->=
data;
> > >         const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->=
data;
> > >
> > >         if (skb->len =3D=3D CANXL_MTU)
> > >                 return cfx->len;
> > >
> > >         /* RTR frames have an actual length of zero */
> > >         if (skb->len =3D=3D CAN_MTU && cfd->flags & CAN_RTR_FLAG)
> > >                 return 0;
> > >
> > >         return cfd->len;
> > > }
> > >
> > >
> > > /* get data length inside of CAN frame for all frame types. For
> > >   * RTR frames, return requested length. */
> > > static inline unsigned int can_get_declared_len(struct sk_buff *skb)
> >
> > I would name this one can_get_len()
>=20
> I anticipate that most of the time, developers do not want to get the
> RTR length but the actual length (e.g. to memcpy data[] or to increase
> statistics). People will get confused between can_get_data_len() and
> can_get_len() due to the similar names. So I would suggest a more
> explicit name to point out that this one is probably not the one you
> want to use.
> Candidates name I can think of:
>  * can_get_raw_len()
>  * can_get_advertised_len()
>  * can_get_rtr_len()
>=20
> The only time you want to access the raw len (with real RTR value) is
> in the TX path when you fill your device's structures. But here the
> can_get_cc_dlc() is a better helper function which is already RTR
> aware.

There also is

| unsigned int can_skb_get_frame_len(const struct sk_buff *skb)

It gives the length of the frame on the wire in bytes. We should use a
common naming scheme. Let's always use can_skb_ as a prefix or drop the
skb_ from this function.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--grdff2ohn34ri64e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLObecACgkQrX5LkNig
010xCAgAimEnNK+NG//P0ThKEGO498FH1bEarfC8fX8K92dP4FzTYpyOe6h9bVVE
IKRa796GnOnlx7SkgOzVvQn1dc/viGMq9Bs/7jWIQW58Wif4J1tpAUwITyFqd+sE
5KbkWoOG1cLd7FLJOzE17nASyeSphtUqRNcZ6TtDnK+2QkKjqWwAfaJjdqx7o3//
jCerUezfkWkvNHxZX3cxynEgxk/BJ3XGRaLVO/lDyJ0WIpC95O34DINuLbPK7FB/
qOKdsD126MZ+B26+mz13YAYfC9LjSBupgJ7KDQgFVfgrkqlXYo2w8nLONsvn8LXY
TjvW3bGyMFObS+bydnA4/EfpKd2BIg==
=6PR7
-----END PGP SIGNATURE-----

--grdff2ohn34ri64e--
