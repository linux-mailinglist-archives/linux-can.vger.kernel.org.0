Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC833281D
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCIOGo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 09:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhCIOGl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 09:06:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE1C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 06:06:41 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJd0S-000697-3h; Tue, 09 Mar 2021 15:06:40 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 55A155F19F8;
        Tue,  9 Mar 2021 14:06:39 +0000 (UTC)
Date:   Tue, 9 Mar 2021 15:06:38 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Introducing new CAN FD bittiming parameters:
 Transmission Delay Compensation (TDC)
Message-ID: <20210309140638.qt7neb3rcjzdodxf@pengutronix.de>
References: <20210309135748.29258-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vhmvw4uqdgnz5fvh"
Content-Disposition: inline
In-Reply-To: <20210309135748.29258-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vhmvw4uqdgnz5fvh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 22:57:46, Vincent Mailhol wrote:
> A set of two incremental patches to be applied to the v2.
> Both patches are fully cosmetics.

Squashed and updated linux-can-next/testing

Thanks,
Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vhmvw4uqdgnz5fvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHgOsACgkQqclaivrt
76l+sAf/aay9+E113a02eZYdNDE4kcqmDPOm2KAmPkonuGoD/+bOVW4HekjELpQJ
+WYPMhTYeQe/nt1eZI61MaDdTO/AEz1xJXpLtvVgBhbNEGAWR/rGx7tVtrMI7Qeg
dkX+r+eWPdVIuN/8ZbWdLCJOfO9NniPwCqPCF1Wna/zweXMAQun//BbnVlFiSios
Zn8pjk0YNYyxCZCwexkcDTDHwcjPXzWi7GOY1WIMPKhY9Di0IYtBq9Bfp5hz3zey
Kz0wBBJFogrAtgbtwe/lAccnbytC2VO671iRHrlStfCOu+jn5N2QNVGJX7a6v/tC
z4lxCscMG+ZqMDZA3MQtwWF8O6yrmQ==
=T/g0
-----END PGP SIGNATURE-----

--vhmvw4uqdgnz5fvh--
