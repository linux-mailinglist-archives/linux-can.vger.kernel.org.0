Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B98547C7F
	for <lists+linux-can@lfdr.de>; Sun, 12 Jun 2022 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiFLVdu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 12 Jun 2022 17:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiFLVdt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 12 Jun 2022 17:33:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BA13F4B
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 14:33:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o0VDM-0007Ni-3X; Sun, 12 Jun 2022 23:33:44 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 85BE993514;
        Sun, 12 Jun 2022 21:33:34 +0000 (UTC)
Date:   Sun, 12 Jun 2022 23:33:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Rhett Aultman' <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        --cc=Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v3 2/2] can: gs_usb: fix DMA memory leak on close
Message-ID: <20220612213333.dgzzlskmmi5xew2z@pengutronix.de>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-3-rhett.aultman@samsara.com>
 <0b792b543f5f4b70ab9e102825329474@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v6hiuh6j37n74c3l"
Content-Disposition: inline
In-Reply-To: <0b792b543f5f4b70ab9e102825329474@AcuMS.aculab.com>
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


--v6hiuh6j37n74c3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2022 21:28:06, David Laight wrote:
> From: Rhett Aultman
> > Sent: 10 June 2022 22:34
> >=20
> > The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
> > gs_can_open() and then keeps this memory in an URB, with the expectation
> > that the memory will be freed when the URB is killed in gs_can_close().
> > Memory allocated with usb_alloc_coherent() cannot be freed in this way
> > and must be freed using usb_free_coherent() instead.  This means that
> > repeated cycles of calling gs_can_open() and gs_can_close() will lead to
> > a memory leak.
> >=20
> > Historically, drivers have handled this by keeping an array of pointers
> > to their DMA rx buffers and explicitly freeing them.  For an example of
> > this technique used in the esd_usb2 driver, see here:
> > https://www.spinics.net/lists/linux-can/msg08203.html
> >=20
> > While the above method works, the conditions that cause this leak are
> > not apparent to driver writers and the method for solving it at the
> > driver level has been piecemeal.  This patch makes use of a new
> > URB_FREE_COHERENT flag on the URB, reducing the solution of this memory
> > leak down to a single line of code.
> >=20
> > Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  drivers/net/can/usb/gs_usb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index b29ba9138866..4e7e6a7b961a 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -768,7 +768,7 @@ static int gs_can_open(struct net_device *netdev)
> >  					  buf,
> >  					  dev->parent->hf_size_rx,
> >  					  gs_usb_receive_bulk_callback, parent);
> > -			urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> > +			urb->transfer_flags =3D URB_NO_TRANSFER_DMA_MAP | URB_FREE_COHERENT;
>=20
> Should that be clearing any other flags?

This chance is intentional, Vincent suggested that in

| https://lore.kernel.org/all/CAMZ6RqKwvSswxThiKqEB8VhD5MyHvRbSwO_9-ZNwLgmn=
m-0iBw@mail.gmail.com

I think there are no other flags set, yet.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--v6hiuh6j37n74c3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKmW6sACgkQrX5LkNig
010/Vwf/ZJFC2GRahU667IgHUvw/NWy4L7FThd7D32GJZzuk51evb1ztToin5nxo
0y8igjhhWfpIUeOg/hRYDdJxS7d83o83L5O3wN+E0T3NbDKGYahrTWshSJ7MiObS
aE8KqkUzIKSxqBCxemboTGDKk3HUPwdENbUug0WSU3e4obxa67sQzugaewnuwvrD
V0rKwHCBgb59g7nDfPR6QeauTK9vylLgo7UaWaMQhLm77m7tBt9HLtRBBK3mkc/z
59H4v9bngAyFICVMeIltSFNoWxJSJLIh+RT075ChH005Fp2nullva2hM0higHeVX
nxF2I1jXnOY1q25xmlS69aP/eVClZg==
=9103
-----END PGP SIGNATURE-----

--v6hiuh6j37n74c3l--
