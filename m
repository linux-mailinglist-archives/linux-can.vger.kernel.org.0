Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A100A3AFF37
	for <lists+linux-can@lfdr.de>; Tue, 22 Jun 2021 10:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVI2B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Jun 2021 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFVI2A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Jun 2021 04:28:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35709C061574
        for <linux-can@vger.kernel.org>; Tue, 22 Jun 2021 01:25:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvbj3-0002XS-4B
        for linux-can@vger.kernel.org; Tue, 22 Jun 2021 10:25:41 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f4a:9a72:36be:c814])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7275C641113
        for <linux-can@vger.kernel.org>; Tue, 22 Jun 2021 08:25:40 +0000 (UTC)
Date:   Tue, 22 Jun 2021 10:25:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can <linux-can@vger.kernel.org>
Subject: LIN (ISO 17987)
Message-ID: <20210622082539.hdm57g3auvtmiyxc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zg3xalw3z5hq32bs"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zg3xalw3z5hq32bs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello CAN community,

has anyone experience with a LIN stack for Linux? Can you recommend one?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zg3xalw3z5hq32bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDRnoEACgkQqclaivrt
76mgbwgAqjYjrWfsnan0GwCW6n7qFmWnhJJ2uB1ZRm9wxnEaQSU2KcDUPDKMAYH5
518RC1gYRvDMHno92Y5Q36B0PYi6Awql891Gu+FriqABV+9RJDx63U24oRrIE7SJ
DJeov/3y0ke+dvw9Cy1Nj5wRrQWbd6Wblb1pU7n/aSWaJEz1Fs+ZTxfXh6C4OOkQ
DkRdX/6fBmeElHG9rLFLAapmOk1QUNwvtpU6ENVJLSkBhgSb2QlcQUK0EyhIaY8h
zKsxAL4qeJhLEwINt6kwmZxx+DPMMbUjh+MqPqFbZXdO+EylmdovP1Nmf/ZCxdhm
mBhom/Sk9zB27iXaVLeSrzW+OPfxpw==
=0xq6
-----END PGP SIGNATURE-----

--zg3xalw3z5hq32bs--
