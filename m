Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D71588334
	for <lists+linux-can@lfdr.de>; Tue,  2 Aug 2022 22:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiHBUqu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Aug 2022 16:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiHBUqu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Aug 2022 16:46:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7883611813
        for <linux-can@vger.kernel.org>; Tue,  2 Aug 2022 13:46:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oIymt-0001Rt-UB; Tue, 02 Aug 2022 22:46:47 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2B952C19FC;
        Tue,  2 Aug 2022 20:46:47 +0000 (UTC)
Date:   Tue, 2 Aug 2022 22:46:45 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 0/4] can-round-trip-stats
Message-ID: <20220802204645.eejaeg3gwn7nhdhq@pengutronix.de>
References: <20220725134345.432367-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eap2zdfd77wfdza"
Content-Disposition: inline
In-Reply-To: <20220725134345.432367-1-mailhol.vincent@wanadoo.fr>
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


--3eap2zdfd77wfdza
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2022 22:43:41, Vincent Mailhol wrote:
> This series applies to below branch of Marc's fork of can-utils:
>=20
> https://github.com/marckleinebudde/can-utils/tree/can-roundtrip-stats
>=20
> It does some cleanup on the can-round-trip-stats in a first time and
> then add the support for hardware timestamps (including TX hardware
> timestamps).
>=20
> This series can be helpfull for those of you who want to test the
> kernel patch series which I recently posted:
> https://lore.kernel.org/linux-can/20220725133208.432176-1-mailhol.vincent=
@wanadoo.fr/T/

Applied and added some more cleanup patches.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3eap2zdfd77wfdza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLpjTMACgkQrX5LkNig
011w1gf+MOHG8YirU0fc3en65aO2iFm/A3htP//O12vOqCXoi6v7eUdo0dybcygZ
DWw5VA9uKg6HTa4SAyl2r7lJbyhUwzMUPjGY2xlqqFe3/CQxh/dh2ZGnRLgFVbwl
It9M2PDanwHk8C2iE0DIRiPjuHCXXTVaxe+ghHIKIgwqOnt6o0pVxlwJ2DmNygLF
+cwFC5bp6mqmN1AANAbWqd8s9NQHS+x+lj/PI8f14yGs7nHKqtkVOg2fw5CYwGd2
ION7TjOXN2oVjuZ7h4mI7XkgOg6y/mHwH4QBKuiCsB/ctxAGnsewULqoFyVF1oMJ
c60DewSU9zalCILzmM7SMFeabJzApw==
=YcQh
-----END PGP SIGNATURE-----

--3eap2zdfd77wfdza--
