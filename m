Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300D4B9FB3
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 13:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiBQMG1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 07:06:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbiBQMG1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 07:06:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E86FD1F
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 04:06:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKfXy-0007SI-L7; Thu, 17 Feb 2022 13:06:06 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2DC26363FD;
        Thu, 17 Feb 2022 12:06:05 +0000 (UTC)
Date:   Thu, 17 Feb 2022 13:06:01 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next] dt-binding: can: m_can: list Chandrasekar
 Ramakrishnan as maintainer
Message-ID: <20220217120601.dss4euvaazxtiyuh@pengutronix.de>
References: <20220217113839.2311417-1-mkl@pengutronix.de>
 <3fb21251-a4de-2300-d1c6-5b98dd3c36d1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxvifk6j46rveptm"
Content-Disposition: inline
In-Reply-To: <3fb21251-a4de-2300-d1c6-5b98dd3c36d1@kernel.org>
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


--kxvifk6j46rveptm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.02.2022 12:52:14, Krzysztof Kozlowski wrote:
> On 17/02/2022 12:38, Marc Kleine-Budde wrote:
> > Since Sriram Dash's email bounces, change the maintainer entry to
> > Chandrasekar Ramakrishnan. Chandrasekar Ramakrishnan is already listed
> > as a maintainer in the MAINTAINERS file.
> >=20
> > Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml=
 b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 3bc1ed39a0a5..b7f9803c1c6d 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > @@ -9,7 +9,7 @@ title: Bosch MCAN controller Bindings
> >  description: Bosch MCAN controller for CAN bus
> > =20
> >  maintainers:
> > -  - Sriram Dash <sriram.dash@samsung.com>
> > +  - Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> > =20
>=20
> There was no activity from that email at all, so entry in Maintainers
> and here will be half-dead... Since the change in maintainers in commit
> ba23dc6dcab5 ("MAINTAINERS: Update MCAN MMIO device driver maintainer")
> , Chandrasekar did not provide any reviews/acks/commits.
>=20
> Dear Chandrasekar,
> Are you planning to perform maintainer activities on this driver?

At least Chandrasekar just send an email, willing to do maintainer
duties, it was HTML only so it probably has not hit the mailing
lists....

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kxvifk6j46rveptm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIOOicACgkQrX5LkNig
011y8Qf8DoDFWP8MfOpfx+UOTDD6da1Mta7Wm/Y1KgrkbcWZCxRswxj/fAkpSUle
W+7vtDsoqx54giBAi1ojWav30AwZ6UBJkeqvycnG2eEjlI2hfWPB5q3DNldP5hEC
HsCv2Zvn7SfxIxSdcvnjs4SmGmX74SPf9+Emm+hvRzkvrtpFO8oMnBHQ/5lQvbmh
GepRPvLuNmJufWPJxz7jkj4JE81H6ddRN6bihfjl93+H+cSLUR55JgjMSkahhcpG
/++9lZR0nvfLVpZ3toAvwsoyiQf768q9DfS8zfiGe+P+OXp5NhDS1HDNPny9Lih3
ouQi+VUSSOaba27ayl2oEANW/mgxYg==
=eNPA
-----END PGP SIGNATURE-----

--kxvifk6j46rveptm--
