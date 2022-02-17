Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFA4BAAAD
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 21:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbiBQURX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 15:17:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiBQURW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 15:17:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF71BBAB80
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 12:17:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKnD2-0004Rs-3s; Thu, 17 Feb 2022 21:17:00 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D2C923686C;
        Thu, 17 Feb 2022 20:16:56 +0000 (UTC)
Date:   Thu, 17 Feb 2022 21:16:53 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Chandrasekar R <rcsekar@samsung.com>
Cc:     linux-can@vger.kernel.org, 'Rob Herring' <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        'Benjamin Gaignard' <benjamin.gaignard@st.com>
Subject: Re: [PATCH net-next] dt-binding: can: m_can: fix indention of table
 in bosch,mram-cfg description
Message-ID: <20220217201653.gq7e2vsblvdrl2mz@pengutronix.de>
References: <CGME20220217130613epcas5p148a75f63b455ad14decf075f1842114b@epcas5p1.samsung.com>
 <20220217101111.2291151-1-mkl@pengutronix.de>
 <006f01d82417$39d94e20$ad8bea60$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g7w27xgijfezubhe"
Content-Disposition: inline
In-Reply-To: <006f01d82417$39d94e20$ad8bea60$@samsung.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--g7w27xgijfezubhe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.02.2022 21:28:35, Chandrasekar R wrote:
> > Subject: [PATCH net-next] dt-binding: can: m_can: fix indention of table
> in
> > bosch,mram-cfg description
> >=20
> > This patch fixes the indention of the table in the description of the
> > bosch,mram-cfg property.
> >=20
> > Cc: Sriram Dash <sriram.dash@samsung.com>
> This id does not exists anymore.

Thanks, already removed.

> > Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> Changes looks fine,=20
> Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>

Added to the patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--g7w27xgijfezubhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIOrTIACgkQrX5LkNig
010WGgf9GTX2GfPQx5aPLu81at7VKKCIrJLe+Pt8nXQVKyHPrgJki1siY6evOx2E
vs6E2uPe4oP++oIfud9EN5GVm49T0dkkxadX2X6Tk7sNnarOzcBbdG/YrphPEiIz
jJOE7VTv44JNpEMLx+VKXQOa9004nWNXL4EXMUtfQ8XQhxsVF0+GHkxT1h4n1LQK
fmp4FLMDBy/gkjK4sRpOjFMDdVQ8rPOMJPqXp1Z/PxEoQfnMxph2Y7GREbduB2QV
E9TRzEwYjlTXeKBLMRYatgrqKowaGsH/EPejQft/OWuzWxI2r3U1BG6PGJFKl0zM
Vh8UaNI9c+5iV7K+G3Ftvtk2pBzAHg==
=5/As
-----END PGP SIGNATURE-----

--g7w27xgijfezubhe--
