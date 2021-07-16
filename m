Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24683CB582
	for <lists+linux-can@lfdr.de>; Fri, 16 Jul 2021 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhGPJ7m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Jul 2021 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhGPJ7l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Jul 2021 05:59:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46273C06175F
        for <linux-can@vger.kernel.org>; Fri, 16 Jul 2021 02:56:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m4KaL-0007vS-P1; Fri, 16 Jul 2021 11:56:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:df95:c0e5:d620:3bac])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D170F650901;
        Fri, 16 Jul 2021 09:56:44 +0000 (UTC)
Date:   Fri, 16 Jul 2021 11:56:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] can: peak_usb: Add a "firmware update available"
 msg to old PCAN-USB
Message-ID: <20210716095643.pciy6tpijqvqvuzd@pengutronix.de>
References: <20210715142842.35793-1-s.grosjean@peak-system.com>
 <20210715142842.35793-2-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ro2rqowo25me347"
Content-Disposition: inline
In-Reply-To: <20210715142842.35793-2-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7ro2rqowo25me347
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.07.2021 16:28:42, Stephane Grosjean wrote:
> When the driver detects that the PCAN-USB device runs an old firmware
> (< 4.1) then it prints a message suggesting to contact
> <support@peak-system.com> for a possible firmware update.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Squashed into the "can: peak_usb: PCAN-USB: add support of loopback and
one-shot mode" patch

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7ro2rqowo25me347
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDxV9cACgkQqclaivrt
76mmcwgAjAnktWhsCrGTiLIgIZkbxML4vRmT4E3/6cZesl9ODhWwxWvMxdaXKNVH
wEJytm6S6oLbFyDZBo/J1caRDpqM2fOXkoqP3nvQM29mTG7xIuBE3FCIbcJonWo4
dOmFZmANH+M82lJyaGtpBVdrWMnoFI92swh2hEZoaQ3z6znbG2xYUHZ2JMIBRK2m
kotBkfFEE0E/BV9imFGbp+VlUdCoJP2wwHNhnRxCPLuA14dYS3Yzlz4pgbf2wP6p
qgjliOog3CirfN3Erfc/BDL91I0YQge5W5ac2ZpubIHBHKlGeMEXFkBVkRDFsj/I
BdyCP69weW+6IjHQlDY0vIB7hYq8Jg==
=1LRw
-----END PGP SIGNATURE-----

--7ro2rqowo25me347--
