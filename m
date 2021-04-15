Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5475360533
	for <lists+linux-can@lfdr.de>; Thu, 15 Apr 2021 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhDOJEo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Apr 2021 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhDOJEn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Apr 2021 05:04:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AC9C061574
        for <linux-can@vger.kernel.org>; Thu, 15 Apr 2021 02:04:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lWxv5-000169-KF; Thu, 15 Apr 2021 11:04:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:983:856d:54dc:ee1c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B209860F2DC;
        Thu, 15 Apr 2021 09:04:12 +0000 (UTC)
Date:   Thu, 15 Apr 2021 11:04:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] can: etas_es58x: Fix missing null check on netdev
 pointer
Message-ID: <20210415090412.q3k4tmsp3rdfj54t@pengutronix.de>
References: <20210415084723.1807935-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szmpbpc75mtqb4hx"
Content-Disposition: inline
In-Reply-To: <20210415084723.1807935-1-colin.king@canonical.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--szmpbpc75mtqb4hx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.04.2021 09:47:23, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is an assignment to *netdev that is can potentially be null but the
> null check is checking netdev and not *netdev as intended. Fix this by
> adding in the missing * operator.
>=20
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CA=
N USB interfaces")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good. Applied to linux-can-next/testing.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--szmpbpc75mtqb4hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmB4AYgACgkQqclaivrt
76lQ5gf+MVDfgP/lHzpBKIj8U4d1CJ+Hb2cUtI+HcxDsNqc08ZCbsoiWhze1E0df
W4Hv7r7oN5RtUpsmM5hF8NV1jwjR3/buD6AIaTTMYWLOLm0QU+o/W2uKydBy1M9y
ythlIG/6MN132kMeNLk7iHfXzT4jHCrVouq1kNVGZBwch+ljGCYw+1LJ5WwCutvh
PP04dZZF/9EmYX10mWgmor6bMcD5tCPGd4P54sYsGuN6KV0pZiCWK2H2xqpi8sPW
K3yWIPUnrI3RGqwmwAq/0v+JHi2rpipNvEUKz6+t326FhQcE6vy6oQ71pfcHM3Vk
FN2fr4XDZLDEqPIe3Sl90lCNwKWhBA==
=NznM
-----END PGP SIGNATURE-----

--szmpbpc75mtqb4hx--
