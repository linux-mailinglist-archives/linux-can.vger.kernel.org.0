Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CC4C02E2
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 21:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiBVULK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 15:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBVULJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 15:11:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587F610CF38
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 12:10:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMbUf-0006oK-ON; Tue, 22 Feb 2022 21:10:41 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1943-8214-ef4b-3caa.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1943:8214:ef4b:3caa])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 106253AC27;
        Tue, 22 Feb 2022 20:10:41 +0000 (UTC)
Date:   Tue, 22 Feb 2022 21:10:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <20220222201035.ywqnclhregzmkjzq@pengutronix.de>
References: <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
 <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
 <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
 <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
 <20220222155135.xgzxddoz372zdsv4@pengutronix.de>
 <b946db8c-ac32-afb0-95aa-8658d1176a89@photo-meter.com>
 <874k4qvq77.fsf@hardanger.blackshift.org>
 <65c90e02-e9b9-988c-bd54-235804386a4b@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rhr74yibvzzof36n"
Content-Disposition: inline
In-Reply-To: <65c90e02-e9b9-988c-bd54-235804386a4b@photo-meter.com>
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


--rhr74yibvzzof36n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 17:41:54, Michael Anochin wrote:
>=20
> > You're missing a "netif_wake_queue done" here. There's probably an
> > interrupt associated with this event. Add a print if that IRQ is active
> > right after reading the IRQ status register
>=20
> Done, only on enter in m_can_isr "m_can_isr: ir=3D", not exit.
>=20
> If there are a RX traffic on but, the latchup happens very quickly.

I just looked again at your overlay. Please change the IRQ type to
IRQ_TYPE_LEVEL_LOW. With edge falling you'll miss interrupts sooner or
later.

regards,
Marc

BTW: it's documented as level low in the bindings documentation:

|		interrupts =3D <14 IRQ_TYPE_LEVEL_LOW>;

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rhr74yibvzzof36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIVQzcACgkQrX5LkNig
011wSQgAgSVZgKhrbzmo8TZ8m+Sd4aHQYN9V2PuYqmOwbXWQzPAG3pkyrBFKeNop
m8DQmMLlq9EGLY9na8tpaibSsxHYijoL/nYtzSrxtmu0REQ8Hj31OUQSdaZCDcwU
Unr/WlKT6aLViIziFTmoN7TWgZbLAjL5IP0znoWPcM97I6squgLormKbgQTo1l1a
1+U7YuRRq9OdRL06OtcB+jiYWCfGZfZV+QiwxiBTv85aJ9t15sJmDYJDeMR7FtKy
npzlMmOcNOdoE0JV/JujlyJTyTgqd6754yslUkZu3Hom3xT4687FZ0NBcze3XTuh
+AwZtYTReWdJi2NgtmI3ihq3aOTMAQ==
=UVW7
-----END PGP SIGNATURE-----

--rhr74yibvzzof36n--
