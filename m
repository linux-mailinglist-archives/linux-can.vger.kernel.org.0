Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ABF332A6B
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 16:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCIP3G (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 10:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhCIP2k (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 10:28:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB191C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 07:28:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJeHm-0007kM-Db; Tue, 09 Mar 2021 16:28:38 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B4A1A5F1E89;
        Tue,  9 Mar 2021 15:28:37 +0000 (UTC)
Date:   Tue, 9 Mar 2021 16:28:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Message-ID: <20210309152837.3vpzfgcxsexr7l7u@pengutronix.de>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-3-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ok34hgvp3t34rgzx"
Content-Disposition: inline
In-Reply-To: <20210309082128.23125-3-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ok34hgvp3t34rgzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 09:21:27, Stephane Grosjean wrote:
> Since the peak_usb driver also supports the CAN-USB interfaces
> "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch adds
> their names to the list of explicitly supported devices.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 6183a42f6491..8e6250c4c417 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -19,6 +19,8 @@
> =20
>  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
>  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB X6 adapter");
> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-Chip USB");

I've exchanged these, to correspond the order of the device ids.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ok34hgvp3t34rgzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHlCIACgkQqclaivrt
76lIPQgAqlUATmrunfXMRqgMKjU27OQKeri743S0wnhCvbNcZBqk6tKKjuc4ymoR
se5aAISzY+zfaivRsVy3jWloZfJD4debAUu9KtUcDlsgrXuHXG/eq+qDTeeQC3O1
nRAQMFdEe84BZsgGniozgXa7ETgHEXvW4HGHlioE9574Lqu7WUhtZme7uEl2mZoD
qTjyge2mpRtVYRSfgjzBTUJoJrMcJtD2fSUgA7/H1RZ4WHGn+0RpVtZzve7ofWJg
U9Y/zkdelurnEqYTCHanU+xGP11qLpQQeq80GeYERoR/2AXCOJgvqU7GRsazQYjd
8nkKsyGgKIsZ8IMGVMB2uwHYh8slKg==
=PH9L
-----END PGP SIGNATURE-----

--ok34hgvp3t34rgzx--
