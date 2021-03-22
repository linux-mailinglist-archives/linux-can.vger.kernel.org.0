Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB9343BF5
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 09:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVIlR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVIlA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 04:41:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12646C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 01:41:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lOG7O-0001kL-My; Mon, 22 Mar 2021 09:40:58 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2d14:11e9:80f:5de6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 40FD75FCA3C;
        Mon, 22 Mar 2021 07:53:17 +0000 (UTC)
Date:   Mon, 22 Mar 2021 08:53:16 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v4 1/1] can: netlink: do tdco calculation after data
 bittiming is copied to can_priv
Message-ID: <20210322075316.343tc2yh62zewf4c@pengutronix.de>
References: <20210321073329.1454-1-mailhol.vincent@wanadoo.fr>
 <20210321073329.1454-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="is3k5laf7uxq2jmv"
Content-Disposition: inline
In-Reply-To: <20210321073329.1454-2-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--is3k5laf7uxq2jmv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.03.2021 16:33:29, Vincent Mailhol wrote:
> The call to can_calc_tdco() is done too early. The data_bittiming
> field of can_priv is not yet updated.
>=20
> Moving the call after tdco is memcopied solves the issue.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Hi Marc,
>=20
> Please squash this into below commit:
> 2b3d40020eca ("can: bittiming: add calculation for CAN FD Transmitter Del=
ay Compensation (TDC)")

done

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--is3k5laf7uxq2jmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBYTOkACgkQqclaivrt
76lzcQf6A0lbSFzpdXFgM+RGhdRYAK6vv4iYL+nUr9oOoHzPhnrStk+Wsv3tHzPx
s00I6qxqlQMnZqZKT+Ey+uax4mkk795l7r6JhPkCqKZKEQr4LMSuLDP/kCY9eKX1
NkhaXBpTRNAssy73veh2NajO9QyDtM2YDsya6DaPCxZXBPpGGpuTrAYixwC0eUgg
ls/y3NP+1epPHaVkPMdkd83ZFXzXLwKJwcFYq7Rr7k+OMqP7hR4N/h6CYHgXlkjC
yRPYVjzVoAHFps0j9T29fV1pgM/TtogoUtjTe7N/PeiIJ3JJ/6HviIBg30OSmd0z
w6AtXUanvt7ZChj/TABGxogSBaMFuQ==
=8uu2
-----END PGP SIGNATURE-----

--is3k5laf7uxq2jmv--
