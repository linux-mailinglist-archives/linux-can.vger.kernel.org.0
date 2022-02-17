Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D94B9F41
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 12:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiBQLlM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 06:41:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbiBQLlC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 06:41:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF17F70C3
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 03:40:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKf9P-0003AR-Ds; Thu, 17 Feb 2022 12:40:43 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CD9473639B;
        Thu, 17 Feb 2022 11:40:42 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:40:39 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     CHANDRASEKAR RAMAKRISHNAN <rcsekar@samsung.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next] dt-binding: can: m_can: fix indention of table
 in bosch,mram-cfg description
Message-ID: <20220217114039.4hyfojwdsbrqle5v@pengutronix.de>
References: <20220217102525.33wtuoue5yp4xtq3@pengutronix.de>
 <20220217101111.2291151-1-mkl@pengutronix.de>
 <CGME20220217102535epcas5p28ce4527b5f60d9cb347c3e408d930d6a@epcms5p8>
 <1851788297.2379.1645096655629@mail-kr5-0>
 <20220217113605.s6k37qr3xzzi5sto@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jc4fbmiuuwz6zhjd"
Content-Disposition: inline
In-Reply-To: <20220217113605.s6k37qr3xzzi5sto@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jc4fbmiuuwz6zhjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.02.2022 12:36:05, Marc Kleine-Budde wrote:
> On 17.02.2022 16:47:35, CHANDRASEKAR RAMAKRISHNAN wrote:
> > Sure, Please add me.
> >=20
> > I will look in to it.
>=20
> The file "Documentation/devicetree/bindings/net/can/bosch,m_can.yaml"
> lists Sriram Dash (email bounces), while you are already listed in the
> MAINTAINERS file.
>=20
> I'll send an update to the DT bindings file.

-> https://lore.kernel.org/all/20220217113839.2311417-1-mkl@pengutronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jc4fbmiuuwz6zhjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIONDUACgkQrX5LkNig
010ctAf+Ify36wrDbM/iBdD+M+YBWiff8wH8dmjki2mZyyi42bpmSOXkHXPyRzk4
Vmu8hgz0AfW0V5JSWpIY1c0eTyDOjlYawqFd8KMfuGX6YikhqwsiAiyERgzCiAKm
dRv/GqGwkNfuPA/innh3Om5PPVh9DA9gX8Auhvl09Ce3CJeTRBAgHVQ75CKRlnTv
9uMHnlwyTy6sPWU0UzlYa+kGZovRL7hl9sd/cLP2UQYu8BqBLptbtsL8rTfVBifK
670ae8wi5yQKq5RPw6iZBG4PvCKqO1DjOsmzFCawAo+4+UR2AAtnWw+sRnKTpGEF
n6+D7vkhKBCdxmW4ZIsPEDKDObqq4g==
=NEU+
-----END PGP SIGNATURE-----

--jc4fbmiuuwz6zhjd--
