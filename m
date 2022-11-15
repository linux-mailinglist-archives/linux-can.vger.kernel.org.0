Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00928629318
	for <lists+linux-can@lfdr.de>; Tue, 15 Nov 2022 09:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiKOIP6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Nov 2022 03:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiKOIPu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Nov 2022 03:15:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34C021249
        for <linux-can@vger.kernel.org>; Tue, 15 Nov 2022 00:15:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1our6h-0001Rf-4H; Tue, 15 Nov 2022 09:15:47 +0100
Received: from pengutronix.de (hardanger-3.fritz.box [IPv6:2a03:f580:87bc:d400:6ac2:39cd:4970:9b29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1D85F11D457;
        Tue, 15 Nov 2022 08:15:46 +0000 (UTC)
Date:   Tue, 15 Nov 2022 09:15:45 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils-dev v3 0/6] can-utils-dev: a set of update and
 cleanup patches
Message-ID: <20221115081545.lovcyysosrix4dk6@pengutronix.de>
References: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6nodibnvpslrh3w"
Content-Disposition: inline
In-Reply-To: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
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


--d6nodibnvpslrh3w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.11.2022 01:38:42, Vincent Mailhol wrote:
> This series contain cleanup patches and update of header files. There
> is no real relation between each patch (aside of 2/6 and 3/6 which
> form a pair) so I will end the cover letter here and let you refer to
> the short description.

Applied to master.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--d6nodibnvpslrh3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNzSq8ACgkQrX5LkNig
0106OAf+JAfXtIHr7uwiR7N1F3440BU2PfR4FSocREEcHoslH1QjUMvKs83Q0hxH
wze5B/hO0BJjr4pi2MfjjLP3lGDByHqVblCg4NkIQIN5yh198pJ93OnNXON+ks3X
xsNF/xsHWMJv/i60fnLMlSuUQqnxe73J68lsJgMiJceLhFVcg4RHLpYkQuOI5RkE
Cnl7zVacA8sgHzelReppWzK/TYN1orqOrb224QBuMmDheo8iSGT5fQUxMy2n1tTA
CxMJCEo9i8Rzt7gsQSqhCHUowA++KNrKh1E1pqXSc29YRLUQlVts1gW+oPu9yFzG
lH437EKMK3lNkvqUlG4IJAKE0zG4Yw==
=cTE4
-----END PGP SIGNATURE-----

--d6nodibnvpslrh3w--
