Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272FB3502ED
	for <lists+linux-can@lfdr.de>; Wed, 31 Mar 2021 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhCaPG3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Mar 2021 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbhCaPGD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Mar 2021 11:06:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897DC061574
        for <linux-can@vger.kernel.org>; Wed, 31 Mar 2021 08:06:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRcPx-0006RT-Ft; Wed, 31 Mar 2021 17:06:01 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a06:b6ed:4055:757b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8BFB9605033;
        Wed, 31 Mar 2021 15:06:00 +0000 (UTC)
Date:   Wed, 31 Mar 2021 17:05:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251x: fix support for half duplex SPI host
 controllers
Message-ID: <20210331150559.5fbus7itrotjwvxs@pengutronix.de>
References: <20210330100246.1074375-1-mkl@pengutronix.de>
 <CAJ+vNU0w2faqmW0MOA9FQD8=vxpJH1Lc8c0BMcAVKGNq1vNjjg@mail.gmail.com>
 <20210331071427.w4bplxt2hoiduho2@pengutronix.de>
 <CAJ+vNU10c5NtLaG64VhcYO8E9sA3di6v5_MnNHVTaFrfkrpxyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zatwqarglwkofgwg"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU10c5NtLaG64VhcYO8E9sA3di6v5_MnNHVTaFrfkrpxyQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zatwqarglwkofgwg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.03.2021 07:54:19, Tim Harvey wrote:
> > Your patch only converted the SPI read path to use half duplex
> > transfers. My patch also converts the SPI write path.
> >
> > If your half duplex controller works without that patch, the controller
> > driver doesn't advertise correctly that it is half duplex only. If the
> > hardware is indeed half duplex only, better send a patch that sets the
> > half duplex flag. If the hardware support full duplex, but the driver
> > somehow doesn't implement it correctly, so that it implements half
> > duplex only you should at least drop a note on the SPI mailing list.

[...]

> Thanks for the explanation!
>=20
> I was surprised as the 5.4 kernel I use with the CN803x OcteonTX using
> drivers/spi/spi-cavium-thunderx.c works fine but as you say it is
> because the host controller does not advertise half duplex only in
> that kernel. I did mainlin in e8510d43f219 ("spi: spi-cavium-thunderx:
> flag controller as half duplex") which appears in 5.9.

Thanks for mainlining the half duplex flag and clarifying the issue
here, I was to lazy to look up which controller you're using and if the
patch was mainlined.

> > Can you test this patch and give me a Tested-by?
> >
>=20
> I did verify that with this patch 5.12-rc5 initializes the mcp251x on
> the CN803x OcteonTx and without it we fail.
>=20
> Tested on a GW6404 board with an OcteonTX SoC and MCP25625
>=20
> Tested-By: Tim Harvey <tharvey@gateworks.com>

Thanks a lot!

> By the way, I believe you were discussing at one point the possibility
> of adding something in the spi core that would be able to implement
> half duplex transactions for drivers written for full duplex
> communication. Is that something on your list or even possible?

Yes I had this discussion, but the only thing the SPI core can do is to
aggregate several half duplex transfers into one full duplex one. This
requires a lot of memory handling/copying and I decided to not work on
this.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zatwqarglwkofgwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBkj80ACgkQqclaivrt
76ljawf9EHwaju91gEqdYyvu2QjzZGQW5lvXa2siuWG9+VLOILR2WPocd2jmAPcO
g9qNVaifKgiTcERFzn5DaS0ZiIzOe1nX1xREc2Ke9K8vL0LNPENDc2hJTgAYW852
UlU7O/SFlTtB5vBwWhrqIGIWDGVNCXi7ZNsEdYBp7VJlnnAc9eTVwm54T3fiSE3S
4UidEs7eOcMNeQXNvPzZspuSoMzOvo/hzBnFzacoRhFd6df7jHvFJeR1kvtgx2wG
qd6WsV7ZbhLXjJm6Qx5rITZNc+5LvRvtdHeOxfjPX5GMozIztcYI8usyVaPF+USu
dYhbrW34rjUgIXwyDbSVYA8Fu7MWTg==
=VMAd
-----END PGP SIGNATURE-----

--zatwqarglwkofgwg--
