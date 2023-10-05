Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1977BAA46
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJETgg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJETgf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:36:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967598
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:36:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoU9A-0007rU-H3; Thu, 05 Oct 2023 21:36:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoU9A-00BLA6-3R; Thu, 05 Oct 2023 21:36:32 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C60B322FF49;
        Thu,  5 Oct 2023 19:36:31 +0000 (UTC)
Date:   Thu, 5 Oct 2023 21:36:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 4/5] can: dev: can_restart(): update debug and error
 messages
Message-ID: <20231005-outbound-version-af7535241af3-mkl@pengutronix.de>
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
 <20231005-can-dev-fix-can-restart-v2-4-91b5c1fd922c@pengutronix.de>
 <CAMZ6RqKN+Ce5-iAcxrGjjMSU9FacU=CirUh+02PPNdEV7kOSQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x7vtzzcn4wzfee5j"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKN+Ce5-iAcxrGjjMSU9FacU=CirUh+02PPNdEV7kOSQg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--x7vtzzcn4wzfee5j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.10.2023 01:06:11, Vincent Mailhol wrote:
> On Thu. 5 Oct. 2023 at 23:31, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > Move the debug message "restarted" _after_ the successful restart of
> > the CAN device, because the restart may fail.
>=20
> You forgot to mention in the commit description that the restarts++
> also gets moved.
>=20
> (and I would not mind if you just fix it while applying instead of
> sending a v3).

fixed while applying :)

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x7vtzzcn4wzfee5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUfEDwACgkQvlAcSiqK
BOgZzwf+LQvOc3nnz6ySYZADi/BNEB7jI8P52xtAFiTT42dQ++tGaYvz/Jm5X3yc
87QuT3wnoY3FYbuL5Aks17Q5N9inYO/tgu/pu0BYgHWfj5mKgCeoHBldK2OJ93ux
YSlmAPeoWX7Zm/PS1e44hkJqagyufQvyepRG8AjAvx+MTw3h/NJ70iUKk77ayV+q
Ut4UMBtZCrvldBAdb4uto8QeGUtmsVStppy7eEI/JoW/g9al82YNjAOZX93uSASq
lLEUJxWHkZj0foHcsq1Gs2wiMSOfJ3GDZcJfXfxFdnrPRP8HL+RZm6ggrx3T691n
c+3OntPWrAF4UIQ2yIbF7i45BG1LFQ==
=4ezB
-----END PGP SIGNATURE-----

--x7vtzzcn4wzfee5j--
