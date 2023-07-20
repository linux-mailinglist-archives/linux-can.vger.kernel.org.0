Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFDC75AAF4
	for <lists+linux-can@lfdr.de>; Thu, 20 Jul 2023 11:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGTJgP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Jul 2023 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGTJf4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Jul 2023 05:35:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C055B2
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 02:31:14 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qMPyr-0001sU-HT; Thu, 20 Jul 2023 11:29:53 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9A13E1F611A;
        Thu, 20 Jul 2023 09:29:52 +0000 (UTC)
Date:   Thu, 20 Jul 2023 11:29:52 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Cc:     linux-can@vger.kernel.org, vincent.mailhol@gmail.com
Subject: Re: [PATCH v2 8/8] can: ems_pci: Add myself as module author
Message-ID: <20230720-purplish-quizzical-247024e66671-mkl@pengutronix.de>
References: <20230120112616.6071-1-uttenthaler@ems-wuensche.com>
 <20230120112616.6071-9-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwowhfxlgh37ryyf"
Content-Disposition: inline
In-Reply-To: <20230120112616.6071-9-uttenthaler@ems-wuensche.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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


--wwowhfxlgh37ryyf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.01.2023 12:26:16, Gerhard Uttenthaler wrote:
> Added myself as module author
>=20
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>

Can you create an entry in the MAINTAINERS file? To keep the file
sorted, please use "./scripts/parse-maintainers.pl --order" and copy the
resulting MAINTAINERS.new to MAINTAINERS.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wwowhfxlgh37ryyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS4/o0ACgkQvlAcSiqK
BOhByQf+KDacTmn3/+wZH4/vfiu59cipLnNM424ajdxd1ki885HJKad/bIPzGAaj
vjXRdLK9m+qqHdSbVQDBMqiuZuUwfZQ/kvJni6CSadTPitgnATa+luX9VmyU7FYB
3E2+d6TkRJfuSkD+nudEkk79hd12tC3J72vKXbi6nZa3LOIKjriLcH4L9YChXz0M
5uaDnhk+8YT4C6FwXymF1/2ClL7riP5wky7Jz0NqdGVlihnPykxqdrTTG3vcL4l4
pqHoVmGjtSjw3OPUUxPF7Mv171/xgzsjPTBFW7A8YOGkmPLjv1UhTAukxBQwYRH/
xlf0D2mKhGm2pCIDVqE3Zi9PyjKC6Q==
=OplT
-----END PGP SIGNATURE-----

--wwowhfxlgh37ryyf--
