Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC60D583BC9
	for <lists+linux-can@lfdr.de>; Thu, 28 Jul 2022 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiG1KJv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jul 2022 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiG1KJe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2022 06:09:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA181A192
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2022 03:09:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oH0SQ-0005Rw-6L; Thu, 28 Jul 2022 12:09:30 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E1FF9BCC02;
        Thu, 28 Jul 2022 10:09:27 +0000 (UTC)
Date:   Thu, 28 Jul 2022 12:09:26 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v4 00/14] can: add ethtool support and reporting of
 timestamping capabilities
Message-ID: <20220728100926.ypvazixdmnlrh3gq@pengutronix.de>
References: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4b6hkae6tssp72j5"
Content-Disposition: inline
In-Reply-To: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
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


--4b6hkae6tssp72j5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.07.2022 19:16:27, Vincent Mailhol wrote:
> This series revolves around ethtool and timestamping. Its ultimate
> goal is that the timestamping implementation within socketCAN meets
> the specification of other network drivers in the kernel. This way,
> tcpdump or other tools derived from libpcap can be used to do
> timestamping on CAN devices.
>=20
> * Example on a device with hardware timestamp support *
>=20
> Before this series:
> | # tcpdump -j adapter_unsynced -i can0
> | tcpdump: WARNING: When trying to set timestamp type
> | 'adapter_unsynced' on can0: That type of time stamp is not supported
> | by that device
>=20
> After applying this series, the warning disappears and tcpdump can be
> used to get RX hardware timestamps.
>=20
>=20
> This series is articulated in three major parts.
>=20
> * Part 1: Add TX software timestamps and report the software
>   timestamping capabilities through ethtool.
>=20
> All the drivers using can_put_echo_skb() already support TX software
> timestamps. However, the five drivers not using this function (namely
> can327, janz-ican3, slcan, vcan and vxcan) lack such support. Patch 1
> to 4 adds this support.  Finally, patch 5 advertises the timesamping
> capabilities of all drivers which do not support hardware timestamps.
>=20
>=20
> * Part 2: add TX hardware timestapms
>=20
> This part is a single patch. In SocketCAN TX hardware is equal to the
> RX hardware timestamps of the corresponding loopback frame. Reuse the
> TX hardware timestamp to populate the RX hardware timestamp. While the
> need of this feature can be debatable, we implement it here so that
> generic timestamping tools which are agnostic of the specificity of
> SocketCAN can still obtain the value. For example, tcpdump expects for
> both TX and RX hardware timestamps to be supported in order to do:
> | # tcpdump -j adapter_unsynced -i canX
>=20
>=20
> * Part 3: report the hardware timestamping capabilities and implement
>   the hardware timestamps ioctls.
>=20
> The kernel documentation specifies in [1] that, for the drivers which
> support hardware timestamping, SIOCSHWTSTAMP ioctl must be supported
> and that SIOCGHWTSTAMP ioctl should be supported. Currently, none of
> the CAN drivers do so. This is a gap.
>=20
> Furthermore, even if not specified, the tools based on libpcap
> (e.g. tcpdump) also expect ethtool_ops::get_ts_info to be implemented.
>=20
> This last part first adds some generic implementation of
> net_device_ops::ndo_eth_ioctl and ethtool_ops::get_ts_info which can
> be used by the drivers with hardware timestamping capabilities.
>=20
> It then uses those generic functions to add ioctl and reporting
> functionalities to the drivers with hardware timestamping support
> (namely: mcp251xfd, etas_es58x, kvaser_{pciefd,usb}, peak_{canfd,usb})
>=20
>=20
> [1] Kernel doc: Timestamping, section 3.1 "Hardware Timestamping
> Implementation: Device Drivers"
> Link: https://docs.kernel.org/networking/timestamping.html#hardware-times=
tamping-implementation-device-drivers
>=20
>=20
> * Testing *
>=20
> I also developed a tool to test all the different timestamps. For
> those who would also like to test it, please have a look at:
> https://lore.kernel.org/linux-can/20220725134345.432367-1-mailhol.vincent=
@wanadoo.fr/T/

Applied to linux-can-next/master with fixed mscan driver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4b6hkae6tssp72j5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLiYFMACgkQrX5LkNig
012ZCgf/YPkyUBn5PpWJ//y0KDHCuvMd2qe5Z6my6PGuoa6Ztj1hjgzq26dmSgGT
5o0tOAO+KAXTAQ2iyDJytisCellKC35SgKFBA1eMRX4dTNsxq8UotzBDXemYGcnk
UqYRtA4OszBDFt29aL6XVgMj9Z5OSglxDjY31C4762/tHsIPtkCV1Idzh20p0xa7
P7zGZ67IecfhjxSe+PlAFatw5WG37WAIgyBKbZAKCuLVVBUkRuMetuzTFkOi6Jfq
vkBpx7AsyYTZjWWukOUDsBOV85w16mlnUDqWfFG8aocT0cn5wu1yvxsXme6+kdJ0
f1Wvh7UJNrDFNW9L/fAet1VQ37Iplg==
=ri+6
-----END PGP SIGNATURE-----

--4b6hkae6tssp72j5--
