Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046164BA0AA
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 14:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiBQNJX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 08:09:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiBQNJV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 08:09:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70E294123
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 05:09:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKgWp-0007Ea-KK; Thu, 17 Feb 2022 14:08:59 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E1BC836498;
        Thu, 17 Feb 2022 13:08:58 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:08:55 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Chandrasekar R <rcsekar@samsung.com>
Cc:     'Krzysztof Kozlowski' <krzk@kernel.org>, linux-can@vger.kernel.org,
        'Rob Herring' <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next] dt-binding: can: m_can: list Chandrasekar
 Ramakrishnan as maintainer
Message-ID: <20220217130855.xytm7k7xwc3eyo5x@pengutronix.de>
References: <20220217113839.2311417-1-mkl@pengutronix.de>
 <CGME20220217115220epcas5p4655af31ab39c62e8acb89ce1652aa1cf@epcas5p4.samsung.com>
 <3fb21251-a4de-2300-d1c6-5b98dd3c36d1@kernel.org>
 <000801d823f7$36e98ec0$a4bcac40$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a53qhljvanyxhev2"
Content-Disposition: inline
In-Reply-To: <000801d823f7$36e98ec0$a4bcac40$@samsung.com>
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


--a53qhljvanyxhev2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.02.2022 17:39:26, Chandrasekar R wrote:
> I will take up the activity, Will actively work on reviewing the
> patches now on.

Good to hear! I've bounced you the latest m_can DT bindings patches:

https://lore.kernel.org/all/20220124220653.3477172-4-mkl@pengutronix.de
https://lore.kernel.org/all/20220217101111.2291151-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--a53qhljvanyxhev2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIOSOUACgkQrX5LkNig
010i9Qf9HcryhP9mjl6XTHegCdg6lzeZQyfONGquh+aZAguqaIEA2YkS17IGW0sg
anMAP3lZ/1FyQ3J8noUDB9mLKvxWr5fCYHYq+mATGnHnG5xx6IxUPLrWXrQpjkEh
ka1OnxtEtvc/L1Jfx4VQMgWybmSgFv3GItggadGML8qzl6JaCpOUP/QWFZAO6BjF
xL0xC0ce2AnPHZvIpLXbs4E46SPWSPPp7ICyaL0ietGZTwz/oCvvfwjMvATtgnVc
TJz4HJURbEDKy1J5ntzxmH1HAbtz4mDOI2xEUhxeprIBT61kKLVdVVQIkLx87oTh
O84zba+v0Y5wqtAKLsmuvclbvHMFeg==
=1Eo9
-----END PGP SIGNATURE-----

--a53qhljvanyxhev2--
