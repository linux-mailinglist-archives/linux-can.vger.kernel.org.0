Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE394BF9BA
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 14:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiBVNor (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 08:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiBVNor (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 08:44:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05A1275DE
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 05:44:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMVSm-0000cx-Cz; Tue, 22 Feb 2022 14:44:20 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BEDB03A825;
        Tue, 22 Feb 2022 13:44:19 +0000 (UTC)
Date:   Tue, 22 Feb 2022 14:44:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2p5lrhgdnjjkriiy"
Content-Disposition: inline
In-Reply-To: <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
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


--2p5lrhgdnjjkriiy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please keep the Mailing List on Cc.

On 22.02.2022 14:26:22, Michael Anochin wrote:
> I try it. But I sink in rx-offload.c with __skb_queue_add_sort and
> napi scheduler. That blocks work_queue for tx, but I don't understand
> how. Need help.

Your idea that m_can_rx_peripheral() in m_can_isr() may fail is valid.
You can add a netdev_error() to report the error if
m_can_rx_peripheral() fails. Then investigate further.

> May be I should increase the quota for napi polling?

Try to increase and check if that helps.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2p5lrhgdnjjkriiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIU6LAACgkQrX5LkNig
011OMAf/Sb6KbVYj81TcyH4aOSATVZlyveDlRcS/56aPjSTUBpHL3wVpYPRHedbJ
Vb9mkw1YEwMh033ZfHuj+xSTzUQWdo3Xm+BQmJE73BLVsqN5hURmICKwFhGbzAAd
n0CZnlsP14M+o/yqrkm9vUWvgzL9O2n0pNxoq7hBGxXGWii6CFybIcBipjJKu2cF
vRBFXtIaHFs6kFG2prFMMukkmNXgYf5m2BsyucaQEXtpe5kwVRIjvESYeth6D16Q
bSBvMZM5ls5s21KfmziJpSiLKN57Nm3LKWgpnsLqICX5x2gnxvVSiyy7pphRNkIz
UeF7FdAzni2uIAvLQeJ3Yz4YPowrmg==
=oeew
-----END PGP SIGNATURE-----

--2p5lrhgdnjjkriiy--
