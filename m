Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2224BFD46
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiBVPnI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiBVPnG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:43:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7E33891
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:42:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMXJG-0008MQ-AR; Tue, 22 Feb 2022 16:42:38 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A71C43A9B0;
        Tue, 22 Feb 2022 15:42:37 +0000 (UTC)
Date:   Tue, 22 Feb 2022 16:42:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Matheus Eduardo Garbelini <mgarbelix@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: Looking for CAN FD sample captures for socket-can hardware
 integration testing
Message-ID: <20220222154237.hkie7wcgl5ng7aof@pengutronix.de>
References: <CANsTw8pbmOcHecJ-aVBhN6gHmmYmTVPOun0BqgfktZ=CyWGzOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2icsfvvt76d4vw4"
Content-Disposition: inline
In-Reply-To: <CANsTw8pbmOcHecJ-aVBhN6gHmmYmTVPOun0BqgfktZ=CyWGzOA@mail.gmail.com>
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


--x2icsfvvt76d4vw4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 22:21:36, Matheus Eduardo Garbelini wrote:
> I'm not sure if this is the right place to ask this, but I'm looking
> for some sample CAN FD captures to test different socketcan
> configurations in a real testbed.

In the github discussion
https://github.com/jgressmann/supercan/discussions/7 you specifically
asked for a capture of CAN-FD traffic in a car.

Is this still relevant for you?

> There is a lot of CAN FD hardware already available, but I could not
> find on the web any FD sample capture on the matter. Would appreciate
> it if anyone could share or point me to the direction on where to find
> CAN FD sample databases as reference for socketcan testing and FD
> frame simulation.

I don't have a car and usually don't have access to our customers real
CAN(-FD) environment. For testing I use the cangen tool of can-utils.

| https://github.com/linux-can/can-utils/blob/master/cangen.c

You can generate CAN-FD frames with certain length, payloads, gap
between frames and other parameters. For stress testing I use a
combination of cangen or cansequence to send and cansequence to receive,
another good tool is canfdtest (doing a full duplex test). Although both
tools (cansequence and canfdtest) cannot send CAN-FD frames yet.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--x2icsfvvt76d4vw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIVBGoACgkQrX5LkNig
011pWwgAhBU2gIU5WKWtK3QnAPHtW/ieeXJc0G0iexZtgPe8ZZRsj7zsbQft7wdv
SSQirJtqzp2cMvlgboGT7hOxTspduSlMIp/kyQUWsZqXvN3IXVNeZPVuUeAnaKxN
13LZKd+QH7CVTSqaaGA2gVDa/cggM5O1BabjdE2Q7L7Ey4CofXn5SlibR2UIGPR5
JIXm73zi4lKRYqd/yxRvvksGtTb/mYHu63Qs19ZLCvI3caye6abw4VWqjgQCH85Y
oQJyOmUHCrC5tbH5kiUkysQRS+EYkY+0TRQ59ypEmziBoLJVTNXxVEwMCDc79p9Z
qNVxCoxIGMQ/qzr8BL1/jmR2vAl79g==
=CGv4
-----END PGP SIGNATURE-----

--x2icsfvvt76d4vw4--
