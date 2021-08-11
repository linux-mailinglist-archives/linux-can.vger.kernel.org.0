Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA953E8A40
	for <lists+linux-can@lfdr.de>; Wed, 11 Aug 2021 08:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhHKGfw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Aug 2021 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhHKGfw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Aug 2021 02:35:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA69EC061765
        for <linux-can@vger.kernel.org>; Tue, 10 Aug 2021 23:35:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mDhpk-0007Yp-Fu; Wed, 11 Aug 2021 08:35:24 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:b918:d60a:cbe6:2fa])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C1887664FAB;
        Wed, 11 Aug 2021 06:35:22 +0000 (UTC)
Date:   Wed, 11 Aug 2021 08:35:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Matt Kline <matt@bitbashing.io>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2 2/2] can: m_can: Batch FIFO writes during CAN transmit
Message-ID: <20210811063520.aw6hkll2kax22ytr@pengutronix.de>
References: <20210727015855.17482-1-matt@bitbashing.io>
 <20210727015855.17482-3-matt@bitbashing.io>
 <20210804091858.vvvrzrmnmi76mg3c@pengutronix.de>
 <YRLl5PavqmjkIkeD@kline-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uq2gyiooy45fpfwk"
Content-Disposition: inline
In-Reply-To: <YRLl5PavqmjkIkeD@kline-desktop>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--uq2gyiooy45fpfwk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.08.2021 13:47:32, Matt Kline wrote:
> On Wed, Aug 04, 2021 at 11:18:58AM +0200, Marc Kleine-Budde wrote:
> > > =20
> > > -	cdev->ops->write_fifo(cdev, addr_offset, val);
> > > +	result =3D cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
> > > +	WARN_ON(result !=3D 0);
> >=20
> > What about converting all read/write functions to return an error, and
> > handle the error in the caller?
>=20
> Yeah, that would be cleaner.

In the mcp251xfd (another SPI-CAN controller) driver I have the same
problem. I've basically implemented error checking everywhere. If there
is an error in the interrupt handler, I shut down the driver, see:

https://elixir.bootlin.com/linux/v5.13/source/drivers/net/can/spi/mcp251xfd=
/mcp251xfd-core.c#L2298

> > >  	/* acknowledge rx fifo 0 */
> > > @@ -1546,8 +1548,8 @@ static netdev_tx_t m_can_tx_handler(struct m_ca=
n_classdev *cdev)
> > >  	struct net_device *dev =3D cdev->net;
> > >  	struct sk_buff *skb =3D cdev->tx_skb;
> > >  	u32 id, cccr, fdflags;
> > > -	int i;
> > >  	int putidx;
> > > +	u32 id_and_dlc[2];
> >=20
> > Can you create a struct for this?
>=20
> Ditto, sure!

A struct can easily extended to hold the data, too.

> > > =20
> > >  	cdev->tx_skb =3D NULL;
> > > =20
> > > @@ -1563,18 +1565,16 @@ static netdev_tx_t m_can_tx_handler(struct m_=
can_classdev *cdev)
> > >  	if (cf->can_id & CAN_RTR_FLAG)
> > >  		id |=3D TX_BUF_RTR;
> > > =20
> > > +	id_and_dlc[0] =3D id;
> > > +
> > >  	if (cdev->version =3D=3D 30) {
> > >  		netif_stop_queue(dev);
> > > =20
> > > -		/* message ram configuration */
> > > -		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id);
> > > -		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DLC,
> > > -				 can_fd_len2dlc(cf->len) << 16);
> > > +		id_and_dlc[1] =3D can_fd_len2dlc(cf->len) << 16;
> > > =20
> > > -		for (i =3D 0; i < cf->len; i +=3D 4)
> > > -			m_can_fifo_write(cdev, 0,
> > > -					 M_CAN_FIFO_DATA(i / 4),
> > > -					 *(u32 *)(cf->data + i));
> > > +		/* Write the frame ID, DLC, and payload to the FIFO element. */
> > > +		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(id=
_and_dlc));
> > > +		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(=
cf->len, 4));
> >=20
> > Does it make sense to combine these, too? Same for the v3.1 variant.
>=20
> I think that's the eventual goal, but since the ID, DLC, and frame data w=
ould
> have to be contiguous for a single m_can_fifo_write(), you'd end up copyi=
ng
> things around.

Yes, but at least for the SPI this is a neglectable overhead.

> I wanted to start with this smaller, simpler patch first. Is that
> alright?

Fine with me!

> I'll try to send a v3 up shortly.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uq2gyiooy45fpfwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmETb6YACgkQqclaivrt
76l3OAf/fPSRaNm97Mrj7Bpy+1/KncFegEgWvAOvyMvcB1JJTS/z01jioHEmNYhI
7NkLtUk8gdJehEW9qnUvSt1QYqHljmtGaguwq4u11bPSZFMmVyQkyDQQrUudYSRx
DPD/1qwEJfPiHlwzM6tLPeF506vDxydZCsE/eXuLJTQt5O0tcDwFWpSyldxyp0O9
HmHmo4tRlV1vgc5yOUbOg+H15c/GWkyTvEtMDW6TJuitxSRicy72V3LS0beVq4n4
NZzgZje7KbVn8XpztwiKOBNbhv9X5VEAMwp0uWUS86nW/99cXyMegd8trbuNMHvz
u0+eO7mmbJ8/5rIgkiG0r4T60E7BqA==
=xJYH
-----END PGP SIGNATURE-----

--uq2gyiooy45fpfwk--
