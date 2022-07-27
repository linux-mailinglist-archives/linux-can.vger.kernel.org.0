Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA35821C1
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 10:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiG0IGp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 04:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0IGp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 04:06:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A243E58
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 01:06:44 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGc3z-000250-48; Wed, 27 Jul 2022 10:06:39 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CCA05BBECA;
        Wed, 27 Jul 2022 08:06:35 +0000 (UTC)
Date:   Wed, 27 Jul 2022 10:06:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v3 14/14] can: peak_usb: advertise timestamping
 capabilities and add ioctl support
Message-ID: <20220727080634.l6uttnbrmwbabh3o@pengutronix.de>
References: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-15-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kzbnrtqiturjn2zh"
Content-Disposition: inline
In-Reply-To: <20220726102454.95096-15-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kzbnrtqiturjn2zh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2022 19:24:54, Vincent Mailhol wrote:
> Currently, userland has no method to query which timestamping features
> are supported by the peak_usb driver (aside maybe of getting RX
> messages and obseverse whever or not hardware timestamps stay at
> zero).
>=20
> The canonical way for a network driver to advertise what kind of
> timestamping it supports is to implement
> ethtool_ops::get_ts_info(). Here, we use the CAN specific
> can_ethtool_op_get_ts_info_hwts() function to achieve this.
>=20
> In addition, the driver currently does not support the hardware
> timestamps ioctls. According to [1], SIOCSHWTSTAMP is "must" and
> SIOCGHWTSTAMP is "should". This patch fills up that gap by
> implementing net_device_ops::ndo_eth_ioctl() using the CAN specific
> function can_eth_ioctl_hwts().
>=20
> [1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
> Implementation: Device Drivers"
> Link: https://docs.kernel.org/networking/timestamping.html#hardware-times=
tamping-implementation-device-drivers
>=20
> CC: Stephane Grosjean <s.grosjean@peak-system.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>=20
> Hi St=C3=A9phane, as far as I understand, the pcan_usb and the pacn_usb_p=
ro
                                                            ^^^^
                                                            pcan

> support hardware timestamps but the pcan_usb_fd doesn't. If not the
> case, let me know.
>=20
> This is not tested. If you find any issue or if you want to modify,
> feel free to pick up that patch and resend it.

I have a:

| Bus 002 Device 009: ID 0c72:0012 PEAK System PCAN-USB FD

It supports hardware RX timestamps (Debian kernel 5.18.0-2-amd64) only:

|  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  01
|  (1970-01-01 02:17:09.473817)  peakfd0  RX - -  002   [1]  3C
|  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  02
|  (1970-01-01 02:17:09.673980)  peakfd0  RX - -  002   [1]  3D

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kzbnrtqiturjn2zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLg8gcACgkQrX5LkNig
0114eAgAgakEW/3GF2kxidPqS1gRGvV4XyFavXReBSbn8jse+Ud+opXahxn+/h+9
BgEWZGQNTmsiovzu+vLq6i5Dyglj8jnmK76cqdBsHFEuorFkXaRLiyyLF/NTwsl9
t/RE5Jx5jEROiGeNfANQ78MWjY4T9RUsZIldzDVuH9JoyiJqzY7rllSkuZ9UyE4w
k7JPiTwhfF8Wf/p+iIHtsnIAL4Hyj3xzuZ/yijR+VqH7u/d3Gi4Q3vCSFHF2DHvn
unNP9nmIk0QPuZ+UVNJgtG5ZUXJnnK1AP3vgxkqKPZYosx67F83ofpqiM+S8Kkp/
qNd9zpAaXJhiH5MiS/CFv3GC/Rjq9Q==
=o+nF
-----END PGP SIGNATURE-----

--kzbnrtqiturjn2zh--
