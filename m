Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7046D345
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 13:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhLHMbD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 07:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhLHMbC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 07:31:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857AC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 04:27:30 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muw2i-0000Iv-R9; Wed, 08 Dec 2021 13:27:28 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-e45e-c028-b01c-c307.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e45e:c028:b01c:c307])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3E8066BFB8F;
        Wed,  8 Dec 2021 12:27:28 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:27:27 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v3 2/4] can: kvaser_usb: Use CAN_MHZ define in assignment
 of frequency
Message-ID: <20211208122727.gfttqvqkginqyu6w@pengutronix.de>
References: <20211208115607.202859-1-extja@kvaser.com>
 <20211208115607.202859-3-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vplgr4lcqc6gwlog"
Content-Disposition: inline
In-Reply-To: <20211208115607.202859-3-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vplgr4lcqc6gwlog
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.12.2021 12:56:05, Jimmy Assarsson wrote:
> Use the CAN_MHZ define when assigning frequencies.

I've change this to use MEGA /* Hz */, as CAN_MHZ has just been removed
=66rom the kernel, same for patch 4.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vplgr4lcqc6gwlog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGwpK0ACgkQqclaivrt
76ljFAf/TT/K7lRF2iee089nKMQCpdAapxlOUEtu7dZ8bJ9hTA/NOKZyU1xnjKR0
cX1WKGbEnkEc4VbD/TATfbTqpTG2txOzJ6MhIhmdTiu52C1FZm2sqM9YtWoIfUCO
eGsri9O8dJnf+OwaJRQ1vqqD/LTnLxGs7z2ZhY+y8hYO2ilpuisGuiFWaal23qIB
J3+7Ke4DYiO/vXcwL4WNdBYgdeOZcebjb1M/LekXz7eb9MynePpAIfRf83UN40bR
NAAqcu/wZGdiSyECjQMF6UmCQTkO6Y5Lcvt7sKx0LdqyX6UcoHNxUkAjCucplQ9n
sAI2ljElPsHcCWnUYs3MOx0AZPEOog==
=dmzT
-----END PGP SIGNATURE-----

--vplgr4lcqc6gwlog--
