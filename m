Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA97060A7
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEQHDs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEQHDi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 03:03:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6D469D
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 00:03:31 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzBC5-00032O-0U; Wed, 17 May 2023 09:03:29 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5619A1C6CD4;
        Wed, 17 May 2023 07:03:28 +0000 (UTC)
Date:   Wed, 17 May 2023 09:03:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/6] can: kvaser_pciefd: Bug fixes
Message-ID: <20230517-pupil-feminism-1d4c174298b3-mkl@pengutronix.de>
References: <20230516134318.104279-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5n2zvuh3abgtqrfg"
Content-Disposition: inline
In-Reply-To: <20230516134318.104279-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5n2zvuh3abgtqrfg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.05.2023 15:43:12, Jimmy Assarsson wrote:
> This patch series contains various bug fixes for the kvaser_pciefd driver.

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5n2zvuh3abgtqrfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRkfD0ACgkQvlAcSiqK
BOg7Cwf8C+Ayby9FJgbORyYmq00AW/uC++0wJdoWevj+aOSalaapYPtzlNlZ2L1/
YeBw1MzD7xMsrco5D53rDONHiWl3F9PkGqf69nLC+CRTCa+Ji/UUnJcIA50u6qGG
5V9Mp3+O4GSVam0LEFJ3MisCf8mgfibXJdsXXadKPLjURl0ZcmccF+bECgrbitrI
wi6ZVUNFmJxrDdV685bZMKPcsphDo+ff1glbpc4mO+TsZmo5HbjqlQ3AA2cRRGuC
UoLVZeJEZojHVQu5QFBp+8QTjz3ZfsEh/guOFAXntUNTaM39n2g+R3ZD5fD1d968
qYpP3b4dBxoiZ/BU9xWDGgk1IFN4pg==
=XLmn
-----END PGP SIGNATURE-----

--5n2zvuh3abgtqrfg--
