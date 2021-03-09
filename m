Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A669A3323A4
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCILIA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 06:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCILHn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 06:07:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F032C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 03:07:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJaDF-0004Zw-Os; Tue, 09 Mar 2021 12:07:41 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C03145F1693;
        Tue,  9 Mar 2021 11:07:40 +0000 (UTC)
Date:   Tue, 9 Mar 2021 12:07:39 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Message-ID: <20210309110739.x2njhvrau5v5vtaz@pengutronix.de>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-3-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huz3ah2xobmge22y"
Content-Disposition: inline
In-Reply-To: <20210309082128.23125-3-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--huz3ah2xobmge22y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 09:21:27, Stephane Grosjean wrote:
> Since the peak_usb driver also supports the CAN-USB interfaces
> "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch adds
> their names to the list of explicitly supported devices.

Can you look up which patch added support for these interfaces? Then we
can add a Fixes tag.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--huz3ah2xobmge22y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHVvkACgkQqclaivrt
76ni7Qf/UmmKrhyAJmn5gnslI3AItRVJDCnw+gWLFVAe3PGZ18dwDcju2SvX9Z63
X0dNhSbXFwqna7Dy25+JA7I3EhGbK60qeNoPenp+g1lYB/Y1Vu33R+UeO0YHq2DJ
DEx+jKG8WA5HdUSfMT440sH5RI/EX6tgIVZ1t9/Cnd/yJSKuKvhOYWGlDgEVHL0z
9dKrDvaYfZ7Q82mjskBgtOBj+QuMS4YQOQCMOgskvvzb3Bm0KZlwGQj9Hznqr4Af
+ZFky7Br+gdAaVEig0Zwc9s/Xo6lxFrKYpY1uB15zIuzgPi8A4ZBBM48rFZzZuJd
KrhKsmxC6E+YVrtaukxlrdJgyS8Mww==
=Ls+i
-----END PGP SIGNATURE-----

--huz3ah2xobmge22y--
