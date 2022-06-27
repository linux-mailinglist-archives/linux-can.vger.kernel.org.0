Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDCD55D529
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiF0OZK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Jun 2022 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiF0OZJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 10:25:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FDD13F2D
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 07:25:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5pfj-0005SK-0a; Mon, 27 Jun 2022 16:25:03 +0200
Received: from pengutronix.de (p200300ea0f229100e97a6e34b3068c93.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:e97a:6e34:b306:8c93])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0FDE0A0427;
        Mon, 27 Jun 2022 14:25:02 +0000 (UTC)
Date:   Mon, 27 Jun 2022 16:25:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     davem@davemloft.net, kuba@kernel.org, max@enpas.org,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: patch "tty: Add N_CAN327 line discipline ID for ELM327 based CAN
 driver" added to tty-linus
Message-ID: <20220627142501.linj2iv3cslxfpgi@pengutronix.de>
References: <1656338186201221@kroah.com>
 <20220627141408.rdquaslehydluas6@pengutronix.de>
 <Yrm9Ezlw1dLmIxyS@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpgv5zekrldsbiwi"
Content-Disposition: inline
In-Reply-To: <Yrm9Ezlw1dLmIxyS@kroah.com>
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


--wpgv5zekrldsbiwi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.06.2022 16:22:11, Greg KH wrote:
> On Mon, Jun 27, 2022 at 04:14:08PM +0200, Marc Kleine-Budde wrote:
> > Hello Greg, David and Jakub,
> >=20
> > On 27.06.2022 15:56:26, gregkh@linuxfoundation.org wrote:
> > > This is a note to let you know that I've just added the patch titled
> > >=20
> > >     tty: Add N_CAN327 line discipline ID for ELM327 based CAN driver
> > >=20
> > > to my tty git tree which can be found at
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> > > in the tty-linus branch.
> > >=20
> > > The patch will show up in the next release of the linux-next tree
> > > (usually sometime within the next 24 hours during the week.)
> > >=20
> > > The patch will hopefully also be merged in Linus's tree for the
> > > next -rc kernel release.
> >=20
> > This means this patch will go mainline with v5.20, right? The earliest
> > this hits net-next/master will be after that, so the net-next for v5.21.
> >=20
> > Is there a way to get this into net-next/master earlier? As Max has a
> > CAN driver depending on the new line discipline ID added in this patch.
>=20
> I have no objection for this patch to also go through the net-next
> branch right now:
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> That should solve the issue, right?

Sure it does! Thanks a lot!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wpgv5zekrldsbiwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK5vboACgkQrX5LkNig
013WdAf45pU7SStbFXvTWj7WdZZpvYdpz5T1i2DTeVh+i5MGdPPXANLpvHL2Wf2F
Coh+qTOconnr5VQ0jIg+3nyxJScEvK6LYJSOQITDTaLv6t3iYFJ2zSH6McIfRBS0
uDkVJrtLS5GywqAZl9Qs6woRYtAn2eB0T6o8HohkuNhaFkO+MQbTAANDMT0SASrE
whrKy2aKQVnS6RvEWRwQKhIfAhRao81Mx3Qb6SWYR1hjnA3CTiNiujlDkFBXiEIq
UCCrXZrFVqQW8fSbUWEiXdGLDsztpv/SCyl7Pt0xbjQept2aDlAzPxrp8t4YIhgc
u7p93uj19X1ibM7feDjR1r+j6z7Y
=dKOa
-----END PGP SIGNATURE-----

--wpgv5zekrldsbiwi--
