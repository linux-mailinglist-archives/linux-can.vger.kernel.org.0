Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2D77B81FD
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbjJDOQ3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 10:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbjJDOQZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 10:16:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DD8AB
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 07:16:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo2fk-0001WD-Gj; Wed, 04 Oct 2023 16:16:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo2fk-00B3Kw-3e; Wed, 04 Oct 2023 16:16:20 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CB94E22F02C;
        Wed,  4 Oct 2023 14:16:19 +0000 (UTC)
Date:   Wed, 4 Oct 2023 16:16:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 27/27] can: at91_can: switch to rx-offload implementation
Message-ID: <20231004-phrase-cobalt-ca6cbe109280-mkl@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
 <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de>
 <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
 <CAMZ6RqLMC0LjbTp1oh8fpPFcrCg+APr+b5zA9sS=wC4Ad692FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpstgxvvlegr664m"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLMC0LjbTp1oh8fpPFcrCg+APr+b5zA9sS=wC4Ad692FA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--fpstgxvvlegr664m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.10.2023 23:07:49, Vincent Mailhol wrote:
> My message had a second part, did you miss it?

Doh, sorry.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fpstgxvvlegr664m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdc7AACgkQvlAcSiqK
BOjSZwf+MXW4dZPWofPWndZZH6rNfz5OKiz23pMHyMfGJ0w6rt26uS6aejOyR4+k
MXYlG3dqXKqziPAbhAE4SoWu1o6Y39r/K+a0ojOSJkXDomOLtzl+irdys4pFCLnP
DcEeOxH//mZzjR2SxA5sFDd+oyu8oNqZ0WBXZswqTUaz5a+gv5no1gujRIyj1Ds5
wIDPjlk3eX36+4Ft5JLz6rhTHMphatMxpmKGJUwUMJ4eFTj2cGoIt8L3nEBd3lO0
+fndBDjTEfhtZxcIhTSssS3xX0rQaGeg7S0CYD/9y8k3J132lvs5VQBylAuHifIk
Rp/d6PgsWuLJspBIjpqUSRnb5bTasQ==
=TJGw
-----END PGP SIGNATURE-----

--fpstgxvvlegr664m--
