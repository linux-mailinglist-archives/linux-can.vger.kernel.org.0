Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6D347530
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 10:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhCXJ5w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Mar 2021 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhCXJ5i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 05:57:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC79C0613DE
        for <linux-can@vger.kernel.org>; Wed, 24 Mar 2021 02:57:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lP0GX-0005Cl-5x; Wed, 24 Mar 2021 10:57:29 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ac2f:839b:d9d7:b2c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 078375FED4F;
        Wed, 24 Mar 2021 09:57:25 +0000 (UTC)
Date:   Wed, 24 Mar 2021 10:57:25 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
Message-ID: <20210324095725.ro5zs2qnmhemzvts@pengutronix.de>
References: <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
 <a5599800-53f4-c53f-abcc-e166ea9028b9@rasmusvillemoes.dk>
 <080d9e5c-fe1f-4a64-2938-8ca6d8a98d78@hartkopp.net>
 <0a8e8e95-c1a2-ede6-9f87-1ab7a0a155e3@rasmusvillemoes.dk>
 <212c8bc3-89f9-9c33-ed1b-b50ac04e7532@hartkopp.net>
 <1a6dd272-8bc2-57dc-5592-47a08493193a@rasmusvillemoes.dk>
 <2c82ec23-3551-61b5-1bd8-178c3407ee83@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ek6ltibujq7z5ejj"
Content-Disposition: inline
In-Reply-To: <2c82ec23-3551-61b5-1bd8-178c3407ee83@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ek6ltibujq7z5ejj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.03.2021 10:09:22, Oliver Hartkopp wrote:
> @Marc: Looks like we can not get around the __packed() fix :-(
>=20
> At least we now have some more documentation to be referenced and I would
> suggest to point out that some compilers handle the union alignment like
> this.

It's not the compiler, but the ABI.

> To make clear in the comments what we are suppressing here any why.

Feel free to post an updated patch description.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ek6ltibujq7z5ejj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBbDQIACgkQqclaivrt
76kTYwf+JN9hl9/dzGKPNaxn1f/3DJlArPSCS3xSarYe3TcKgT+t4LG/D9urkzNP
vIbfXeQ78dqjhgwBttM4Niog5NhakpiJdJ8+dhoQ/55PkOrwBQSB8ilPyV2NcBqj
CqjyyVxzgW+uQ9ULauQascrt0T5K0bwcRNSvJ+/Gm9tw+q73wQ+PPPninyo/WX04
erOE9EjMIxtjlxjBSBY6/gXNG0h4PqOr6ejhQrdc26QBJmOYyImCOr5OxR8K2T+H
J+PZMolNN57wkVzFa1eB8Ru8fESxCfp676ojfAdHdoo1jGUgnvxc+Xjq6VL4h2Zs
eK0kbC8BuNFSiILjmizP8l+Bqcmw9g==
=8MVo
-----END PGP SIGNATURE-----

--ek6ltibujq7z5ejj--
