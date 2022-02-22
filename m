Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E464BFD81
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiBVPwE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiBVPwD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:52:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E013F6C
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:51:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMXRw-0001FQ-1m; Tue, 22 Feb 2022 16:51:36 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 885B23A9DB;
        Tue, 22 Feb 2022 15:51:35 +0000 (UTC)
Date:   Tue, 22 Feb 2022 16:51:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <20220222155135.xgzxddoz372zdsv4@pengutronix.de>
References: <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
 <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
 <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
 <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wdize5o7xpwvbdnj"
Content-Disposition: inline
In-Reply-To: <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
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


--wdize5o7xpwvbdnj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 16:48:35, Michael Anochin wrote:
> > Keep us informed if that helps.
> No, this does not help. It was my start-point with <0x0 0 0 16 0 0 1 1>
> I continue to dive in with debug-printing.

Still any error messages?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wdize5o7xpwvbdnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIVBoIACgkQrX5LkNig
013gtwf+LB+QJkMGD+RtylH5S+XDs+gxDOT7a/4GB3QIrAx5bnnpivdHzgqe7pJj
kLpIqO5Vfm2f3dmWGLPFiD+rwG4ToGho5vxDTs739r8jJVnlniM7JA1OTxH7ttDn
FYMxOzlghJYXgAiezEEQIOf2ZqCtl+curDQe4w61ZAV1nL/JuBQ6riqHKRujLkWw
KCQmGhz9cgrCUr4To3sSH9w/Tve/nzcRa8SidUIfeBI2Wary5x/ls4sGxjpMogwP
OZ/rXybug/P56nGLaQhBS3I/eyqE6uP7z4ZsaYSEf8NKGMY7i668wQ4QGNZWk0hM
Jb0FrN8CPvu8h+UUuqIkJyaZfIUIxg==
=0Auk
-----END PGP SIGNATURE-----

--wdize5o7xpwvbdnj--
