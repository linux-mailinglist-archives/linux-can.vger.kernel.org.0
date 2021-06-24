Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB73B2D79
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhFXLRW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhFXLRW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 07:17:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516DC061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 04:15:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwNK1-0004nY-NM
        for linux-can@vger.kernel.org; Thu, 24 Jun 2021 13:15:01 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 123E9642B3D
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 11:15:01 +0000 (UTC)
Date:   Thu, 24 Jun 2021 13:15:00 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH 3/3] can-calc-bittiming: add mcan
Message-ID: <20210624111500.ral5upfrrvlpkpbm@pengutronix.de>
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
 <20210624031954.26195-3-dev.kurt@vandijck-laurijssen.be>
 <20210624105005.2kgj6o5hwskl6rqo@pengutronix.de>
 <20210624105731.GB21224@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mygio7njlyqqnkmx"
Content-Disposition: inline
In-Reply-To: <20210624105731.GB21224@x1.vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mygio7njlyqqnkmx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 12:57:31, Kurt Van Dijck wrote:
> On Thu, 24 Jun 2021 12:50:05 +0200, Marc Kleine-Budde wrote:
> > On 24.06.2021 05:19:54, Kurt Van Dijck wrote:
> > > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > > ---
> > > +	}, {
> > > +		.bittiming_const =3D {
> > > +			.name =3D "mcan",
> >=20
> > This is for mcan > v3.1

correcting myself: >=3D v3.1

> I don't have any earlier.
> Can I just solve by putting "mcan-v3.1+"?

ACK

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mygio7njlyqqnkmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUaTEACgkQqclaivrt
76lDOQf/fWbqdbqWeBR3Wo08+HfWX3bQRPQsJBpVBJ8rodgTx5Gp3no8tzxihle0
E0xqTc9llU8R9xsyT8s5D50eRnOEMFP+gIdPYySER66YdScPvp8MFa8vIwROa144
WCSs1rs8I1ej7OV8wm/0jlr1P2RAFjWIUvnlhExW/LDljaT+Qgn+QDAkIJfE9T6g
L0H7h2EfVdzfbKiGFt4LbzqoJeTVnmWibv+UgS+OhsdCKQdFPtEbMWX2d5NhFMZF
h7k696K/oyaxi48CNls/2ouVlsN1JXqaPGdLosGwVX2vROKyDrqBCe9xTsI5E9gL
Vf4fXUXW3c9ZRYitTyOr8/jcUlB+DA==
=ajY4
-----END PGP SIGNATURE-----

--mygio7njlyqqnkmx--
