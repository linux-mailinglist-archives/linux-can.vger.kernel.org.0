Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B886582252
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiG0InG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 04:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiG0InF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 04:43:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B4345995
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 01:43:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGcdB-0006ds-4E; Wed, 27 Jul 2022 10:43:01 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D42C1BBF23;
        Wed, 27 Jul 2022 08:42:59 +0000 (UTC)
Date:   Wed, 27 Jul 2022 10:42:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v3 14/14] can: peak_usb: advertise timestamping
 capabilities and add ioctl support
Message-ID: <20220727084257.brcbbf7lksoeekbr@pengutronix.de>
References: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-15-mailhol.vincent@wanadoo.fr>
 <20220727080634.l6uttnbrmwbabh3o@pengutronix.de>
 <CAMZ6RqL0sNAFtLiiopeaA2Oyqq15=dhdOnLivTWngPxGyAFHQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ami4arnxzv53pxnd"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL0sNAFtLiiopeaA2Oyqq15=dhdOnLivTWngPxGyAFHQw@mail.gmail.com>
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


--ami4arnxzv53pxnd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.07.2022 17:29:25, Vincent MAILHOL wrote:
> On Wed. 27 Jul. 2022 at 17:10, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > On 26.07.2022 19:24:54, Vincent Mailhol wrote:
> > > Currently, userland has no method to query which timestamping features
> > > are supported by the peak_usb driver (aside maybe of getting RX
> > > messages and obseverse whever or not hardware timestamps stay at
> > > zero).
> > >
> > > The canonical way for a network driver to advertise what kind of
> > > timestamping it supports is to implement
> > > ethtool_ops::get_ts_info(). Here, we use the CAN specific
> > > can_ethtool_op_get_ts_info_hwts() function to achieve this.
> > >
> > > In addition, the driver currently does not support the hardware
> > > timestamps ioctls. According to [1], SIOCSHWTSTAMP is "must" and
> > > SIOCGHWTSTAMP is "should". This patch fills up that gap by
> > > implementing net_device_ops::ndo_eth_ioctl() using the CAN specific
> > > function can_eth_ioctl_hwts().
> > >
> > > [1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
> > > Implementation: Device Drivers"
> > > Link: https://docs.kernel.org/networking/timestamping.html#hardware-t=
imestamping-implementation-device-drivers
> > >
> > > CC: Stephane Grosjean <s.grosjean@peak-system.com>
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > ---
> > >
> > > Hi St=C3=A9phane, as far as I understand, the pcan_usb and the pacn_u=
sb_pro
> >                                                             ^^^^
> >                                                             pcan
> >
> > > support hardware timestamps but the pcan_usb_fd doesn't. If not the
> > > case, let me know.
> > >
> > > This is not tested. If you find any issue or if you want to modify,
> > > feel free to pick up that patch and resend it.
> >
> > I have a:
> >
> > | Bus 002 Device 009: ID 0c72:0012 PEAK System PCAN-USB FD
> >
> > It supports hardware RX timestamps (Debian kernel 5.18.0-2-amd64) only:
> >
> > |  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  01
> > |  (1970-01-01 02:17:09.473817)  peakfd0  RX - -  002   [1]  3C
> > |  (1970-01-01 01:00:00.000000)  peakfd0  TX - -  002   [1]  02
> > |  (1970-01-01 02:17:09.673980)  peakfd0  RX - -  002   [1]  3D
>=20
> Thanks for the confirmation. So this means that all Peak hardware
> supports the hardware timestamping.

The PCAN-USB FD only support RX hardware timestamping, not TX.

> This will greatly simplify the
> logic. No need to have two different struct ethtool_ops. I will
> prepare a v4.

We have a peak_pciefd card:

| 01:00.0 Network controller: PEAK-System Technik GmbH Device 0018 (rev 01)

Only RX HW timestamps (Debian kernel 5.16.0-0.bpo.4-amd64):

|  (1970-01-01 01:00:00.000000)  can0_iobus  TX - -  601   [8]  40 0C 21 01=
 00 00 00 00
|  (1970-02-16 18:25:06.810100)  can0_iobus  RX - -  581   [8]  53 0C 21 01=
 00 00 00 00
|  (1970-01-01 01:00:00.000000)  can0_iobus  TX - -  602   [8]  40 0C 21 01=
 00 00 00 00
|  (1970-02-16 18:25:06.819380)  can0_iobus  RX - -  582   [8]  53 0C 21 01=
 00 00 00 00

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ami4arnxzv53pxnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLg+o4ACgkQrX5LkNig
010BJwf/Uy/NRQFiynYaUIboDmpvpZagFXfAYiTc7ixFktL/XUm+BJQRDHLLj/xc
/ELvLBuuRW2sMCrzw9zreVGbVqT51Gfk3FQJBUBeKIrpQrjaLA5FhZnK4Dfp2dnD
ydPCZm0Knxk0k+z1+1v9OqRIWopzsR6gQ9MgUVa78KNr81KEFbSF4R+a90qMKMEg
Nm5CZGsUfTICa39DLUT9hvds0EofVkiAdvNWJlKI3LHgOb+x3C3FaKUss05OAI7D
/YW4FXL9o19c+h7vDAEBa6RfC2pON7eUKiE4ZfCERTmgCRJ7FOmyoV61BItV0LvU
ZWsOIiLheFF7iXTlFeY55DCwRHO4ng==
=yvJ1
-----END PGP SIGNATURE-----

--ami4arnxzv53pxnd--
