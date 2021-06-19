Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67D3ADBD1
	for <lists+linux-can@lfdr.de>; Sat, 19 Jun 2021 23:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhFSVoo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Jun 2021 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFSVoo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 17:44:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA5C061574
        for <linux-can@vger.kernel.org>; Sat, 19 Jun 2021 14:42:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1luijW-0003fw-P1; Sat, 19 Jun 2021 23:42:30 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8352:71b5:153f:5f88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9CF7A63F7D7;
        Sat, 19 Jun 2021 21:42:29 +0000 (UTC)
Date:   Sat, 19 Jun 2021 23:42:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Harald Mommer <hmo@opensynergy.com>, linux-can@vger.kernel.org
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
Message-ID: <20210619214228.7ojjr7fa77uzmv7g@pengutronix.de>
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <4dad20db-b9be-24c8-d97b-7cc614a7c7c9@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jxnuzvooyynjgf6x"
Content-Disposition: inline
In-Reply-To: <4dad20db-b9be-24c8-d97b-7cc614a7c7c9@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jxnuzvooyynjgf6x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2021 20:23:39, Oliver Hartkopp wrote:
> > Even if the Linux Kernel doesn't drop any messages, not all CAN
> > controllers support that feature. On the Linux side we try our best, but
> > some USB attached devices don't report a TX complete event back, so the
> > driver triggers the CAN echo skb after the USB transfer has been
> > completed.
> >=20
> > We don't have a feature flag to query if the Linux driver support proper
> > CAN echo on TX complete notification.
>=20
> We have. It is set in struct netdevice.flags and called IFF_ECHO.
>=20
> https://elixir.bootlin.com/linux/v5.12.11/source/net/can/af_can.c#L257

The flag tells the rest of the stack, that the driver takes care of
generating the CAN echo packages.

Several USB based driver set the IFF_ECHO flag, but the USB device don't
signal the TX-complete to the host. These drivers generate the CAN echo
frame after the successful USB TX transmission. This is better than
letting the networking stack generate the CAN echo frame, but it's not
100% perfect.

> E.g. the slcan driver does not have this bit set.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jxnuzvooyynjgf6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDOZMIACgkQqclaivrt
76kUXQgAnnqij7QxQ3x660VjTP3m29EFjczMg4YJNswG2p7vIZH0IzAhfFflXC5y
fzPKy76w0IzHKOHe46Ewrxn3ITu3xUW1wKoeBasatbx4IYe5d/RQpvYSxip4l3ME
bGm9m8rM9ezqEBDAHtjloaf2186YFN9hvsVFClfLJmtCZhO/bInQl+mlYJFsQfiQ
PUm0+PUBbxlLKK55kXT94gdqVTWUjk4W8V70BNjuGX20ziP2TnoW+xNsf02ngZZY
lZGQmItZ0UJWrGizE1RP+rjIO67NCDKSS7ofF5JOqpv/ndxj3i6cGLd+aBTRr7su
/BZKiSJ7qzXveLHmHR1+BmH5ht+8cQ==
=b7Y7
-----END PGP SIGNATURE-----

--jxnuzvooyynjgf6x--
