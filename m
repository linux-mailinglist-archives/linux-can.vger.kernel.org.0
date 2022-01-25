Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1BF49AF09
	for <lists+linux-can@lfdr.de>; Tue, 25 Jan 2022 10:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454345AbiAYI7B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jan 2022 03:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453909AbiAYI4h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jan 2022 03:56:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68430C049654
        for <linux-can@vger.kernel.org>; Mon, 24 Jan 2022 23:55:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nCGfX-0005jK-BU; Tue, 25 Jan 2022 08:55:11 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 87E9921910;
        Tue, 25 Jan 2022 07:55:09 +0000 (UTC)
Date:   Tue, 25 Jan 2022 08:55:06 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        devicetree@vger.kernel.org, lrich Hecht <uli+renesas@fpond.eu>
Subject: Re: [PATCH net-next 4/4] dt-binding: can: rcar-can: include common
 CAN controller bindings
Message-ID: <20220125075506.5z3myalobo3quvv2@pengutronix.de>
References: <20220124220653.3477172-1-mkl@pengutronix.de>
 <20220124220653.3477172-5-mkl@pengutronix.de>
 <1643084091.565337.1221464.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gy5vknydgq65x3lv"
Content-Disposition: inline
In-Reply-To: <1643084091.565337.1221464.nullmailer@robh.at.kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gy5vknydgq65x3lv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.01.2022 22:14:51, Rob Herring wrote:
> On Mon, 24 Jan 2022 23:06:53 +0100, Marc Kleine-Budde wrote:
> > Since commit
> >=20
> > | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> >=20
> > there is a common CAN controller binding. Add this to the rcar-can
> > binding.
> >=20
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: lrich Hecht <uli+renesas@fpond.eu>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  .../devicetree/bindings/net/can/renesas,rcar-can.yaml          | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Good bot!

> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/can/renesas,rcar-can.yaml:102:1: =
[error] duplication of key "allOf" in mapping (key-duplicates)

Right, the renesas,rcar-can.yaml already contains a "allOf: $ref:
can-controller.yaml", I'll drop that patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gy5vknydgq65x3lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHvrNcACgkQqclaivrt
76lJcAgAgOAo/Ymi1KObX1g1ir3N/bXQj+K4FfyTRLaISPapqbXTLxl53g6GZxhl
erlJZLrGmtH2T7kxGfMFKZ1I/mmj8jyB0aUqRiDD3/RBk52kTGPRg25f2ioE0v3Y
4DznEDa4E5ZvQODquVh6cfuhuwGBCkxtv0hQit6CA36HFstvArrNnuu9h0juQW/j
LwnXKz48zP0KBRkAicZobFio8R3VXrsoEz2FgGbaOsZhrurzdMKqYT615YKfyApF
+i4/sXGEDPELvfK3uQcS1Fo7iWZqLp5xgKqzDa3Lm7U/aUEins8L8R5If57hWS2R
OLQ8dj8JbyfvGjblIm/oq5goGp5gGQ==
=hzzM
-----END PGP SIGNATURE-----

--gy5vknydgq65x3lv--
