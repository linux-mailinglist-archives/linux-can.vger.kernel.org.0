Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE86F8133
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjEELFQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjEELFQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 07:05:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CCE19D42
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 04:05:15 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1putFR-0004oS-LV; Fri, 05 May 2023 13:05:13 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0B88C1BE824;
        Fri,  5 May 2023 11:05:13 +0000 (UTC)
Date:   Fri, 5 May 2023 13:05:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: Re: [PATCH v3 0/2] can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
Message-ID: <20230505-dwindling-hut-a6ee800036ea-mkl@pengutronix.de>
References: <20230505110308.81087-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eyvb73jcbfv3kcqy"
Content-Disposition: inline
In-Reply-To: <20230505110308.81087-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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


--eyvb73jcbfv3kcqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.05.2023 13:03:06, Marc Kleine-Budde wrote:
> sending v3 of Oliver's original patch
> (https://lore.kernel.org/all/20230406110845.5180-1-socketcan@hartkopp.net=
/).
>=20
> No code change since v2, but resending with standard git Message-Id
> headers. I wasn't satisfied with my headers experiment. Sorry for the
> noise.

I've also added stable on Cc while applying the series.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eyvb73jcbfv3kcqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRU4uMACgkQvlAcSiqK
BOjE1wf9GacURImvk0NHLG3FhJVSVdDS4qttWiCFjRifMIMBg+jrFTK2grdi/r2w
hkMisygnQZi4E8iOn5NVzpnO0KSmpy/DZXuffLq6ii/YuqItwTeSq5jNPZ0r0NH/
UNtWu6x/N/phyrdAwF/IGHX0W2gJhEWMvsBNYFmJT6uFbKvPGWtFJS8HE7Tq+SvL
OdrN2TL34A9TUWwf8Xsbg15Sv69JIgBpHDCbna7TPjc8+Lgln4TYQx0yucPUdpj7
4aPvzO9FyXT9mW5GHVQhSMJq8uHTSoCXe4z/2AIIMF7SdOMSzik2CyEFOCWtcX4j
RpT7YUKp5pWceeANWm/ormzIeGVemA==
=Ldqi
-----END PGP SIGNATURE-----

--eyvb73jcbfv3kcqy--
