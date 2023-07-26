Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905A0763499
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjGZLNX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjGZLNW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 07:13:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399CB269A
        for <linux-can@vger.kernel.org>; Wed, 26 Jul 2023 04:13:19 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qOcRv-0001BM-7s; Wed, 26 Jul 2023 13:12:59 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0D3BE1FB27F;
        Wed, 26 Jul 2023 11:12:57 +0000 (UTC)
Date:   Wed, 26 Jul 2023 13:12:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RE: [PATCH v2 1/3] arm64: dts: imx93: add the Flex-CAN stop mode
 by GPR
Message-ID: <20230726-expedited-clinking-3e7f212352f7-mkl@pengutronix.de>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
 <20230726-moocher-managing-5a5352a4266a-mkl@pengutronix.de>
 <DB7PR04MB40107ED22966EF83DDA0759B9000A@DB7PR04MB4010.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="glv2skkv3tf7s5b2"
Content-Disposition: inline
In-Reply-To: <DB7PR04MB40107ED22966EF83DDA0759B9000A@DB7PR04MB4010.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--glv2skkv3tf7s5b2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2023 11:10:10, Bough Chen wrote:
> > >  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > > index 4ec9df78f205..d2040019e9c7 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > > @@ -319,6 +319,7 @@ flexcan1: can@443a0000 {
> > >  				assigned-clock-parents =3D <&clk
> > IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> > >  				assigned-clock-rates =3D <40000000>;
> > >  				fsl,clk-source =3D /bits/ 8 <0>;
> > > +				fsl,stop-mode =3D <&anomix_ns_gpr 0x14 0>;
> >=20
> > I think there's a typo in the mainline imx93.dtsi. AFAICS it's supposed=
 to be
> > "aonmix_ns_gpr", not "anomix_ns_gpr". But that's a different problem to
> > patch :)
>=20
> Yes, this is a typo.
> >=20
> > AFAICS, according to imx93, rev2 data sheet, offset 0x14 is 76.6.1.3 QC=
HANNEL
> > DISABLE (QCH_DIS) and bit 0 is "GPIO1". Are you sure this is the correc=
t reg?
> >=20
>=20
> Imx93 A1 doc has some update, I double confirm with the internal doc and =
IC team, the setting is correct.
> I also test on imx93-9x9 qsb board, system can be wakeup by this setting.

Thanks for double checking.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--glv2skkv3tf7s5b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTA/7UACgkQvlAcSiqK
BOj8HAf/ad3k8d8Ns6FEeuNcOzdNMPToWeyL2H6xN/1lD88jnF7pCPAsVt9xajCp
lQNb6Y4Nv0av+B2Q1qzdypwz4IIxPdzkkFWA7L3c1+59tO+SKxsJEBU9K9PYEw3b
jrR84W40irP0bpSDJIP3VcIfLMa5U8c7LkjNIaZHv73E74GmF1zwGGMasxTYbzNi
Hzcqqyg5vXPp0Lyb/PI6Rp+tT/DlelupD3R3BMhhmhBhJ8cWXVVFldPB8G7kys49
CqXRSzvg/X+oKs4didIPKPhUF0ay/HkcY+KuitVm/pi42qYNNKKTaRYKFoTLBAGn
Dtxq//ja6lLqhS/+bgOm/7g4F0kTjw==
=YycX
-----END PGP SIGNATURE-----

--glv2skkv3tf7s5b2--
