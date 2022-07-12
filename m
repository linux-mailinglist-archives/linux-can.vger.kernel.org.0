Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBF571406
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 10:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiGLIKy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiGLIKe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 04:10:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FEC64E2B
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 01:10:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oBAy2-0007g0-WF; Tue, 12 Jul 2022 10:10:03 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-2099-0011-e8c0-354d.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:2099:11:e8c0:354d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 50AE0AE657;
        Tue, 12 Jul 2022 08:10:02 +0000 (UTC)
Date:   Tue, 12 Jul 2022 10:10:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Message-ID: <20220712081001.6m3wcidplh5o3gh7@pengutronix.de>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
 <20220711194116.ohkn7lp3o24h7rp5@pengutronix.de>
 <8a4f80f0-6088-a138-b415-f7bd0b5b5c54@hartkopp.net>
 <20220712071711.msc5aq7rjahwaia2@pengutronix.de>
 <546d29ce-dca6-e171-f3ac-016025ce3e45@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="piy34kihjqv4zqh7"
Content-Disposition: inline
In-Reply-To: <546d29ce-dca6-e171-f3ac-016025ce3e45@hartkopp.net>
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


--piy34kihjqv4zqh7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.07.2022 10:02:28, Oliver Hartkopp wrote:
> > > > > --- a/include/uapi/linux/if_ether.h
> > > > > +++ b/include/uapi/linux/if_ether.h
> > > > > @@ -136,10 +136,11 @@
> > > > >    #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN =
PPP frames*/
> > > > >    #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP =
MP frames */
> > > > >    #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
> > > > >    #define ETH_P_CAN	0x000C		/* CAN: Controller Area Network */
> > > > >    #define ETH_P_CANFD	0x000D		/* CANFD: CAN flexible data rate*/
> > > > > +#define ETH_P_CANXL	0x000E		/* CANXL: eXtended frame Length */
> > > > >    #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP=
*/
> > > > >    #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
> > > > >    #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
> > > > >    #define ETH_P_CONTROL	0x0016		/* Card specific control frames =
*/
> > > > >    #define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
> > > >=20
> > > > This file doesn't change that often I suppose. Or does it make sens=
e to
> > > > send this change mainline as soon as possible?
> > >=20
> > > AFAIK you only can reserve these values when you have a reference tha=
t uses
> > > it. I don't seen any additional pressure here.
> >=20
> > There have been added other types that are not used in the kernel (yet).
> >=20
>=20
> Ok?!?
>=20
> I remembered some discussion about PF_FLEXRAY which bounced some years ag=
o.
>=20
> But I think it should be fine if we get this small patchset discussed and
> upstreamed to net-next in this round, right?

ACK

> > > > > diff --git a/net/can/af_can.c b/net/can/af_can.c
> > > > > index 1fb49d51b25d..2c9f48aa5f1f 100644
> > > > > --- a/net/can/af_can.c
> > > > > +++ b/net/can/af_can.c
> > > > > @@ -197,31 +197,32 @@ static int can_create(struct net *net, stru=
ct socket *sock, int protocol,
> > > > >     *  -EINVAL when the skb->data does not contain a valid CAN fr=
ame
> > > > >     */
> > > > >    int can_send(struct sk_buff *skb, int loop)
> > > > >    {
> > > > >    	struct sk_buff *newskb =3D NULL;
> > > > > -	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> > > > > +	unsigned int len =3D can_get_data_len(skb);
> > > > >    	struct can_pkg_stats *pkg_stats =3D dev_net(skb->dev)->can.pk=
g_stats;
> > > > >    	int err =3D -EINVAL;
> > > > >    	if (skb->len =3D=3D CAN_MTU) {
> > > > >    		skb->protocol =3D htons(ETH_P_CAN);
> > > > > -		if (unlikely(cfd->len > CAN_MAX_DLEN))
> > > > > +		if (unlikely(len > CAN_MAX_DLEN))
> > > > >    			goto inval_skb;
> > > > >    	} else if (skb->len =3D=3D CANFD_MTU) {
> > > > >    		skb->protocol =3D htons(ETH_P_CANFD);
> > > > > -		if (unlikely(cfd->len > CANFD_MAX_DLEN))
> > > > > +		if (unlikely(len > CANFD_MAX_DLEN))
> > > > > +			goto inval_skb;
> > > > > +	} else if (skb->len =3D=3D CANXL_MTU) {
> > > > > +		skb->protocol =3D htons(ETH_P_CANXL);
> > > > > +		if (unlikely(len > CANXL_MAX_DLEN || len =3D=3D 0))
> > > >=20
> > > > Do we need a helper for the > CANXL_MAX_DLEN || =3D=3D 0 check?
> > >=20
> > > Some can_xl_is_valid_data_size(unsigned int len) ?
> >=20
> > In other location you're using "canxl" not "can_xl".

=2E..but that's the struct canxl_frame and alloc_canxl_skb().

> I just thought about can_blablabla() as common namespace for our function=
s.

ACK it is. There are:

include/linux/can/length.h:160:u8 can_fd_dlc2len(u8 dlc);
include/linux/can/length.h:163:u8 can_fd_len2dlc(u8 len);

> But canxl_whatever() is also safe ;-)
>=20
> > What about: canxl_valid_data_size()

Sorry for the noise,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--piy34kihjqv4zqh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLNLFcACgkQrX5LkNig
013X4gf/e1NuSjSPgcHFzEpdiePEj2Mqot09J4li3vFhs2Dey/FNCQWL96Govuz7
f0qEPXXs0hLzFQe6y7JPhgCzFZU+KSl3dT6h8welAabkErb0ZkxkeH9mHFj/z0oR
xBh5/ChWc9bZURsiAkeCJw/vYYuIFn7tiBHHy0j2mIUoTcS7GF5Yb6+9intyEQVN
psZMxRa9uXWNNpa04+l6+g/2mv8Q/uEax9EleuDpz5as+gp+MqQTGNF9+bNUY0E3
RejIcQ+rq44c2UhiBKcbSvGm7L+DpMFeZ2DA0PrpaPna8bZKRUi8sTESBUK75Hna
cVdjcvhzG4Hzjo3sn1Uew8r598tDhg==
=fnXp
-----END PGP SIGNATURE-----

--piy34kihjqv4zqh7--
