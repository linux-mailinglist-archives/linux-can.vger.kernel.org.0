Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC763C8C7B
	for <lists+linux-can@lfdr.de>; Wed, 14 Jul 2021 21:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhGNTmI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Jul 2021 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhGNTlw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Jul 2021 15:41:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14CC0613E4
        for <linux-can@vger.kernel.org>; Wed, 14 Jul 2021 12:39:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m3kie-00040T-Rh; Wed, 14 Jul 2021 21:38:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1d5a:f852:d9c2:1ad3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3A00F64F582;
        Wed, 14 Jul 2021 19:38:55 +0000 (UTC)
Date:   Wed, 14 Jul 2021 21:38:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@kernel-space.org>, wg@grandegger.com,
        geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
Subject: Re: [PATCH v5 3/5] m68k: m5441x: add flexcan support
Message-ID: <20210714193854.dq2seoew4n35b4xv@pengutronix.de>
References: <20210702094841.327679-1-angelo@kernel-space.org>
 <20210702094841.327679-3-angelo@kernel-space.org>
 <1a95b055-5d14-f43e-81dd-d0a0ddbdb1f1@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x7n7x7b7kzsqdjtu"
Content-Disposition: inline
In-Reply-To: <1a95b055-5d14-f43e-81dd-d0a0ddbdb1f1@linux-m68k.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--x7n7x7b7kzsqdjtu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.07.2021 14:33:42, Greg Ungerer wrote:
[...]
> That way the timing of patches 1, 4 and 5 being applied doesn't matter.
> There is no way to enable CONFIG_CAN_FLEXCAN until patch 4 is applied.
> (And you probably should have swapped the order of patches 4 and 5, so th=
at
> the Kconfig change is the last in the series.)

Done - I've changed the order of 4 and 5.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--x7n7x7b7kzsqdjtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDvPUsACgkQqclaivrt
76lB0Qf/eMk2WptefHW22omca5u8HrR8KKRB9h6GjlKqPgz2X3x4csIdyGV072Wz
2wLr6f4hds9nEPjb9jv5rwoyXCxQlcl+Yk7oMzr3QTQoOZTMTm+UetUc5lcZ2m9a
5QXrLkA9zcKpDKtpgXPXBUA4IBTa4Wz4bDklhD2kF5ffdOm/11wMfZkLxIHcFg4e
3PnG5SlCc/Rw+KflZehF+u/kViiRRwd4gDBt/sZ2KdiP1E2mMsl6IK91M1OPP6fg
qEjcMpE/T7HoJAKDkYxRq9y0GXybM8wz8nHFLmA7Z9aj6r7mK0PLvX+XGLOPfkh+
Iz15/aSZS1mUFGR4bWJmqKsZINEjag==
=4RRU
-----END PGP SIGNATURE-----

--x7n7x7b7kzsqdjtu--
