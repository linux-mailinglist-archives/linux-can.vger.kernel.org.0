Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC054BAAAF
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 21:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiBQURw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 15:17:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241812AbiBQURv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 15:17:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4FABAB80
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 12:17:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKnDX-0004UJ-QC; Thu, 17 Feb 2022 21:17:31 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 455B036871;
        Thu, 17 Feb 2022 20:17:31 +0000 (UTC)
Date:   Thu, 17 Feb 2022 21:17:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Chandrasekar R <rcsekar@samsung.com>
Cc:     linux-can@vger.kernel.org, 'Rob Herring' <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/9] dt-binding: can: m_can: include common CAN
 controller bindings
Message-ID: <20220217201728.x7rrj3qeoj67wevt@pengutronix.de>
References: <20220124215642.3474154-1-mkl@pengutronix.de>
 <CGME20220217130709epcas5p4a339ca58cc485aa1732eaa3b4b0409cb@epcas5p4.samsung.com>
 <20220124215642.3474154-4-mkl@pengutronix.de>
 <007001d82418$2c5fcac0$851f6040$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7nhneshlxj7zhrgb"
Content-Disposition: inline
In-Reply-To: <007001d82418$2c5fcac0$851f6040$@samsung.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7nhneshlxj7zhrgb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.02.2022 21:35:22, Chandrasekar R wrote:
> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: 25 January 2022 03:27
> > To: linux-can@vger.kernel.org
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>; Chandrasekar Ramakrishnan
> > <rcsekar@samsung.com>
> > Subject: [PATCH 3/9] dt-binding: can: m_can: include common CAN control=
ler
> > bindings
> >=20
> > Since commit
> >=20
> > | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> >=20
> > there is a common CAN controller binding. Add this to the m_can binding.
> >=20
> > Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>

Thanks for you review.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7nhneshlxj7zhrgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIOrVUACgkQrX5LkNig
013Dxgf/VwK2eRM5pVq4OIu9yEnx6DIb3aQT7MCQnk6cWiRUbSvHxQ4S/e05JY6G
B9nfXLZlN6yoB8DX9XtkyCaDxpX3lVdp+1F+cA7pMH3jw7CNY1sGsBWxiTlQmwz8
9tQs7pwoCsnWtt1azqcg1fZb3GafsN58xW4mU61T3TvVyj7NHY+eTEJbwyUn0Zyj
nitegv+fSVqEHcuu+ARpcXrGy8bqSSN4uVgIduB/Km7Vhth84c9JLQzpy6uUZZcr
bToqG7rdXcVZu2iheg/aBtGvlyzv7Rk2o16VMOzlKF7+PBEsULBMFzOlH262MRVH
MAk2CDnh3rMwGFZP5JNyvdnamI67EA==
=aOhB
-----END PGP SIGNATURE-----

--7nhneshlxj7zhrgb--
