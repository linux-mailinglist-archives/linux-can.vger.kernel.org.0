Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD5580F68
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGZIy4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiGZIyz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:54:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323731376
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:54:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGGL4-0001ct-TH; Tue, 26 Jul 2022 10:54:50 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 00818BA8C8;
        Tue, 26 Jul 2022 08:54:48 +0000 (UTC)
Date:   Tue, 26 Jul 2022 10:54:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 00/10] can: remove litteral strings used for driver
 names and remove DRV_VERSION
Message-ID: <20220726085447.csoxejg63ho2vrfk@pengutronix.de>
References: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhhp32tkjpugt6av"
Content-Disposition: inline
In-Reply-To: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--yhhp32tkjpugt6av
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2022 17:26:57, Vincent Mailhol wrote:
> This is a cleanup series.
>=20
> The patches 1 to 8 get rid of any hardcoded strings and instead relies
> on the KBUILD_MODNAME macros to get the device name. Patch 9 replaces
> the ES58X_MODULE_NAME macro with KBUILD_MODNAME in
> etas_es58x. Finally, also in etas_es58x, patch 10 removes the
> DRV_VERSION so that the module uses the default behavior and advertise
> the kernel version instead of a custom version.

Added to linux-can-next/master. Dropped patch "[PATCH v2 03/14] can:
slcan: add software tx timestamps", to let Dario Binacchi pick that up.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yhhp32tkjpugt6av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLfq9UACgkQrX5LkNig
0125Nwf/eU8QAhjqgrSeEGQIJQlz24NgUS4/oichipu8fxxZIw80VsSFWYsmPcQc
ofn80pHsf0bZMGkQ6TU8/6S1wWkbNfHyrbco0LdDWEVN7W2bcIm0Tiw80izl8ENB
ORzgAvvdZhGahb4euh4HIC2g5fvJ8+NxlBP8/3g2AYGYwQb15dyl69SvHpqipI9z
Y1nXkY1rmXfb6bTKmTfZ3jlTMWwKuihKRWSHk0ybIJmD5JHv+LLsa6xWQeKVl6Oq
ZYeJTvSm74MG8/CSTAPSPkCABaSI4h4vlQtUaq72qMqjy64wFthFg0lkSfom69eQ
iW3OZzSVNYTT1HiKjjLr3Z3f9KCEqQ==
=/ZUH
-----END PGP SIGNATURE-----

--yhhp32tkjpugt6av--
