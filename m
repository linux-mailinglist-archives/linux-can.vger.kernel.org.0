Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE91643FCB2
	for <lists+linux-can@lfdr.de>; Fri, 29 Oct 2021 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhJ2Mzh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Oct 2021 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhJ2Mzg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Oct 2021 08:55:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27DC061570
        for <linux-can@vger.kernel.org>; Fri, 29 Oct 2021 05:53:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mgRNa-0005k3-BG; Fri, 29 Oct 2021 14:53:06 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-e533-710f-3fbf-10c2.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e533:710f:3fbf:10c2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5F04D6A0A36;
        Fri, 29 Oct 2021 12:53:05 +0000 (UTC)
Date:   Fri, 29 Oct 2021 14:53:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] can: peak_usb: always ask for BERR reporting for
 PCAN-USB devices
Message-ID: <20211029125304.liokvwgi4qzsrz2i@pengutronix.de>
References: <20211021081505.18223-1-s.grosjean@peak-system.com>
 <20211021081505.18223-2-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3vyqyh3s57kwv446"
Content-Disposition: inline
In-Reply-To: <20211021081505.18223-2-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--3vyqyh3s57kwv446
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.10.2021 10:15:04, Stephane Grosjean wrote:
> Since for the PCAN-USB, the management of the transition to the
> ERROR_WARNING or ERROR_PASSIVE state is done according to the error
> counters, these must be requested unconditionally.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

This description indicates the patch should be backported, as it fixes a
problem. Can you figure out which patch added the problem in the first
place, so that we can add a Fixed tag?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3vyqyh3s57kwv446
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmF77q0ACgkQqclaivrt
76lVVQgAouX7PIBoBa0CBDvexuNcANK3xnEQBcPt5FdVP5Efz2Lcl4FUy16rcQZN
ZrwlCL8yM9ESLgEyddTLcPCMAGuupG2z/4n7n7NKMJK4rgJlc6WD5EmPwdE3JN2l
LAQ3jtLP7a5Jusq8610DnRsTrLTGTyyxt+pEuydrAcsBXsyZguJOsSbPofm/KnQk
PuIkP+piU6icIyv+muALW2q3ZAi9iebIVzzU8OB282KashpKQ9BMLRI9kiHlDfsj
wvi13QCJcWVGpbq62O6Uwywk+Y5+b8CGXLqOVlrXPAIpQnDrKTeTvkvYFZgytfTy
Mf56IasAMVHoN687Zm+XJIIxNcmaDw==
=XLqV
-----END PGP SIGNATURE-----

--3vyqyh3s57kwv446--
