Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F171345A26
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 09:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCWIyo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCWIyb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 04:54:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02EC061574
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 01:54:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lOcnv-0006nF-9r; Tue, 23 Mar 2021 09:54:23 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:c81e:25b5:b851:4b31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9D78B5FDCE9;
        Tue, 23 Mar 2021 08:54:19 +0000 (UTC)
Date:   Tue, 23 Mar 2021 09:54:18 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
Message-ID: <20210323085418.4g7rojhkvcg2ib4e@pengutronix.de>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
 <c0fb01a8-6a6a-7e5f-f932-697065d18600@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xnic7x6gdvsivnn6"
Content-Disposition: inline
In-Reply-To: <c0fb01a8-6a6a-7e5f-f932-697065d18600@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xnic7x6gdvsivnn6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.03.2021 09:32:10, Oliver Hartkopp wrote:
> I wonder if the compiler configurations (gcc -v) or the options used at
> kernel build time are identical.

I tested several compilers and with my .config never triggered a
problem, but with Rong Chen it does. I'm trying to figure out which
option it is, stay tuned.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xnic7x6gdvsivnn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBZrLgACgkQqclaivrt
76nh/Af/XCDATEr7hCC2ZJBPYp/yGLTR7OJDq2gr0SmYtIpxI3vgfr5BfKkMhJ0H
QdMhm1AcYRJeKAzmcTd6vs5M6Ol62PQqI4xhy+212rzsUCiPpTkSae2lt9P/nkbs
2UrlkyhygQOPERiavQ46Omb5uD3C8Mftvahh7cJCCmzqKkbW5NJgAbYPtdA+OErA
G1K70Ekt8WawfYXvyt/WC/vc4TpdbGM70T6mfxWM5xklKL+Lohjp04vIeJWHCG8t
Qub6aRsrQ2NWCQVsIHB59eq4wKLzMeibCdZ2XhkqF9IY5LhATnUkZaS3st0EFrl7
VYNJZ/AeZy7aRC47/c3RMCmQpRcyiw==
=dnxo
-----END PGP SIGNATURE-----

--xnic7x6gdvsivnn6--
