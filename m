Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C084BF922
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 14:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiBVNU3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 08:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiBVNU3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 08:20:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93BC334E
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 05:20:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMV5F-0005Sq-V8; Tue, 22 Feb 2022 14:20:02 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 18F703A7B2;
        Tue, 22 Feb 2022 13:20:01 +0000 (UTC)
Date:   Tue, 22 Feb 2022 14:20:00 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gn6jyhuhgekkh2a2"
Content-Disposition: inline
In-Reply-To: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
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


--gn6jyhuhgekkh2a2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 12:14:23, Michael Anochin wrote:
> In the context of the ENOBUFS problem by using can interfaces under higher
> load:
>=20
> In m_can_isr handler, if rx fails (m_can_rx_peripheral), then no
> netif_wake_queue(dev) will be called. Can this lead to ENOBUFS?

Yes - Can you send a fix?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gn6jyhuhgekkh2a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIU4v4ACgkQrX5LkNig
011xBAf/R+QiOwepN6gWnQFbmSRh88tSfzma82TWBiWUlRL+ddT5qVqgjhddwxoc
VS267fY8VLo6UKtSO9lY+NjXX6sfMTE7FVrg+BAXheQnqPKR9aeuWI0hW0Xls4ZN
L3c2eIAxWaQ3v/rOPOlN10oOpnQPgur7gpVTfdAaw5OS76ihNCmgVaSItl9BRlpn
f7EB+qS3cMwQ32sj4M7jI2jylV4bFogym0iLimGNdV+/CKNRhV3qnAhhELKcjLYg
S//Ir2YKy7UcIztCrxjJ6AcZIaWGX51FuFLNHz3EzvL/YyeIL4VuIgkdnVj5AIi7
IubTKy5FiceZZYZbBKA9Wsqt11ZYpQ==
=zaYu
-----END PGP SIGNATURE-----

--gn6jyhuhgekkh2a2--
