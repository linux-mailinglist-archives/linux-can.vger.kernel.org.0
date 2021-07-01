Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534B73B8FBE
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhGAJaP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbhGAJaP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jul 2021 05:30:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23733C061756
        for <linux-can@vger.kernel.org>; Thu,  1 Jul 2021 02:27:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lysyz-00085t-L8; Thu, 01 Jul 2021 11:27:41 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6b79:f6d8:f46:d3ca])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DAE09646E7B;
        Thu,  1 Jul 2021 09:27:38 +0000 (UTC)
Date:   Thu, 1 Jul 2021 11:27:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v4 1/5] can: flexcan: add platform data header
Message-ID: <20210701092738.iw4l4vekpvn2c4an@pengutronix.de>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c7oiqs2ggujfmpun"
Content-Disposition: inline
In-Reply-To: <20210630230016.4099050-1-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--c7oiqs2ggujfmpun
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2021 01:00:12, Angelo Dureghello wrote:
> Add platform data header for flexcan.

BTW: the DKIM signatures on your mails are invalid:

|   =E2=9C=97 [PATCH v4 1/5] can: flexcan: add platform data header
|     + Link: https://lore.kernel.org/r/20210630230016.4099050-1-angelo@ker=
nel-space.org
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|   =E2=9C=97 [PATCH v4 4/5] can: flexcan: update Kconfig to enable coldfire
|     + Link: https://lore.kernel.org/r/20210630230016.4099050-4-angelo@ker=
nel-space.org
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|   =E2=9C=97 [PATCH v4 5/5] can: flexcan: add mcf5441x support
|     + Link: https://lore.kernel.org/r/20210630230016.4099050-5-angelo@ker=
nel-space.org
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|   ---
|   Attestation is available, but did not succeed:
|     =E2=9C=97 Failed DKIM/kernel-space.org attestation

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--c7oiqs2ggujfmpun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDdiocACgkQqclaivrt
76lj0Af7BNQ1yY7XBqYQWK8wLqzvm0lzsLD28lBBxj8Pw8x810un/T/dXRBcWYXG
qKmI1cRz+tYQJrSn9H86VKKwdnPIYh2fq5ngJlpcfRoEY3wa9wEBsGUZ8/jqWFam
fLdH0CwYvDqkGzMfo1WmlW8fgXPNCJbefYbQ0DHypDcUD3RHnOh/KQD9PklT8YNp
h5SP6Z6yKzjuOhL1PMe0DqiP/sB4xLYYkv8dCIvWXcqPA0DcITEiIIQmWpd/grHk
wXR1Z+JjqRtAFBebB39T3b17qyuK/w4ACxVgWluIfz7zRp9iz7eceEgGUDT0hlxo
Uk6W1TSrbWZ7FHGtKYa4V1wkC/6YRw==
=TVEc
-----END PGP SIGNATURE-----

--c7oiqs2ggujfmpun--
