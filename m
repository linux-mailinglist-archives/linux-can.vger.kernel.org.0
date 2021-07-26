Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5E3D56B5
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhGZI4U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 04:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhGZI4U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 04:56:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259FDC061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 02:36:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7x2V-0000qj-L6; Mon, 26 Jul 2021 11:36:47 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1455:5f5:50a2:3493])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BC675657E35;
        Mon, 26 Jul 2021 09:36:46 +0000 (UTC)
Date:   Mon, 26 Jul 2021 11:36:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org, yasushi.shoji@gmail.com
Subject: Re: [PATCH] MAINTAINERS: add Yasushi SHOJI as reviewer for the
 Microchip CAN BUS Analyzer Tool driver
Message-ID: <20210726093646.rahtialrojy2dcjb@pengutronix.de>
References: <20210726092945.1017567-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwn2iad6kneylyvs"
Content-Disposition: inline
In-Reply-To: <20210726092945.1017567-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gwn2iad6kneylyvs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2021 11:29:45, Marc Kleine-Budde wrote:
> This patch adds Yasushi SHOJI as a reviewer for the Microchip CAN BUS
> Analyzer Tool driver.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58afeb12d3b3..8a002b48fbdb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11327,6 +11327,12 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/radio/radio-maxiradio*
> =20
> +MCAB MICROCHIP CAN BUS ANALYZER TOOL DRIVER
> +R:	Yasushi SHOJI <yasushi.shoji@gmail.com>

Yasushi, I just noticed you're using more than one email address, which
one should be added here?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gwn2iad6kneylyvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD+gisACgkQqclaivrt
76mlQQf/YMaa/tjrk7dHHBjg19pN0fNmWTxXy8So0b5nQccCAo92kCqKxuLWL0+F
awf/5dJm7wi4pUmtZxsAbu1YezTCiszOo3vcgyA9c12gRCEgkYskEKhIsx9Gvr16
pn1Ap/mNQDx+SmVbfxtRd2BggbBafeeIoyYxnYuU/Cw10NItIHVYYgua2AIYg1/Z
gZIo5DU/47lxBgm83eScNn+RIyHsOz+LvB5mCAMluJA7z/6IpDSUYcAil/47KPRp
gPzDUckF2CM56vBVIaMpaLdOhjSWyByJ/3wk6c4XeeSfTOejlTTXw9ag3Gz7R3PC
1BzpDXputH3kHmfHR6grI0FjRYHxJQ==
=pMnz
-----END PGP SIGNATURE-----

--gwn2iad6kneylyvs--
