Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1B70D415
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjEWGjH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 02:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEWGjH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 02:39:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5369A100
        for <linux-can@vger.kernel.org>; Mon, 22 May 2023 23:39:06 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q1Lfj-0005zh-SL; Tue, 23 May 2023 08:39:03 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D574A1CA257;
        Tue, 23 May 2023 06:39:02 +0000 (UTC)
Date:   Tue, 23 May 2023 08:39:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Message-ID: <20230523-outlet-vaseline-b53d42733536-mkl@pengutronix.de>
References: <20230515212930.1019702-1-mkl@pengutronix.de>
 <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
 <20230522215354.2c79c007@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nlmdcoh7wiv3oxr"
Content-Disposition: inline
In-Reply-To: <20230522215354.2c79c007@gmx.net>
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


--3nlmdcoh7wiv3oxr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.05.2023 21:53:54, Peter Seiderer wrote:
> Added CC: socketcan@hms-networks.de (taken from the copyright headers)

Please remove, that mail is bouncing.

| Your message to socketcan@hms-networks.de couldn't be delivered.

flfe@hms-networks.de is bouncing, too:

| Florian Ferg (flfe@hms-networks.de)<mailto:flfe@hms-networks.de>
| A problem occurred during the delivery of this message. Please try to res=
end the message later.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3nlmdcoh7wiv3oxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRsX4MACgkQvlAcSiqK
BOjzKAf/T5K/6VZR+Frkho3xldNFCTz5iTKPIsB+bjLm7l9aC2jrZ6YSrjGN5rMx
rL/7qSNH63h0E+WBdO/LxDhP/zUCUeyjy0X/QF9BNypIsAEDivQdewWau7q95HeU
uxXkRgohkslTitl/PobwAhUUHS+T3gRVqBLXdSWk2YOSpO04gE25bYqU4QsSTJWI
bFxIU82E45RJNmvxGWCAgLrFiIruK5DeTiozj/SpNPJzNxm7ISvuFmfJbddnqVel
DzaDGigk/RSepcoLW9OTG8br1mjKCZcxeQApLcvGNG1epdnV/LVGloDrN8b2afQs
lpNb7eCi2NUemiwO18ALk5YFhoWmuA==
=xDKo
-----END PGP SIGNATURE-----

--3nlmdcoh7wiv3oxr--
