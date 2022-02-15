Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF94B6A88
	for <lists+linux-can@lfdr.de>; Tue, 15 Feb 2022 12:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiBOLT0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Feb 2022 06:19:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiBOLT0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Feb 2022 06:19:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C89107D1A
        for <linux-can@vger.kernel.org>; Tue, 15 Feb 2022 03:19:16 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nJvrX-0004vC-5K; Tue, 15 Feb 2022 12:19:15 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 814D833AE8;
        Tue, 15 Feb 2022 11:19:14 +0000 (UTC)
Date:   Tue, 15 Feb 2022 12:19:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: m_can_read_fifo, can_fd_dlc2len returns sometimes
 cf->len=0
Message-ID: <20220215111911.zw5b4dhjulaatwdn@pengutronix.de>
References: <5215c43f-d208-4bc6-5bd3-3425bc4f107a@photo-meter.com>
 <20211112130744.gqnnkn67oxwumczq@pengutronix.de>
 <88ddcee3-65b6-4b4e-332c-6f23ad39c35f@photo-meter.com>
 <20220114142946.ozv3vzjkuss4rj72@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b2gvpzdawbn5cbue"
Content-Disposition: inline
In-Reply-To: <20220114142946.ozv3vzjkuss4rj72@pengutronix.de>
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


--b2gvpzdawbn5cbue
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.01.2022 15:29:46, Marc Kleine-Budde wrote:
> > 2. After applying of your Path the system is spammed until death with
> > messages (I have cut out the repeating):

How to reproduce this problem?

> > [  755.039082] tcan4x5x spi4.0 can1: ack error
> > [  755.040039] tcan4x5x spi4.0 can1: ack error
> > [  755.040071] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> > [  755.040358] tcan4x5x spi4.0 can1: ack error
> > [  755.040677] tcan4x5x spi4.0 can1: ack error
> > [  755.040709] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> > [  755.040997] tcan4x5x spi4.0 can1: ack error
> > [  755.041029] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> > [  755.041315] tcan4x5x spi4.0 can1: ack error
> > [  755.041347] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> > [  755.041635] tcan4x5x spi4.0 can1: ack error
> > [  755.041667] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> > [  755.041954] tcan4x5x spi4.0 can1: ack error
> > [  755.041986] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> > [  755.042017] tcan4x5x spi4.0 can1: __skb_queue_add_sort: pos=3D0x0000=
0000,
> > new=3D0x00000000, diff=3D         0, queue_len=3D1
> > [  755.042288] tcan4x5x spi4.0 can1: ack error
> > [  755.042320] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail

I was not able to reproduce it.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--b2gvpzdawbn5cbue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmILjCwACgkQrX5LkNig
010uEwgAiYnIf8si6ZeLAGptNbliMDz84b+Ivjb59fTuJiYfnF0gCDIZwfJrvH/8
X41Rq2HDNeciPpwWdk6/FHJFJI/dAuskVteMkC4mVayyVPJQuzr2Dj3qDj1nLMe0
SaSmgTPEUix1ooySWQ6NGWYNfdyrq/0K2s0obb/yTKCYTYS3cMM02m3NJgKUHN3U
kkfUdXg14HAbIVEhynC38Cig4kCXrbFh7/vyB5FO8yGh1KZiSx9wtW2sFAc5W2IT
ixIqscH62LKt8cmSN0D8U4hTCkKfjqgcx16NcCtYshbA8Qzj81wZw0NdaeWiIdFN
QNNTq9fLmnGZ4yacCaYGLJNfYzUafw==
=34+6
-----END PGP SIGNATURE-----

--b2gvpzdawbn5cbue--
