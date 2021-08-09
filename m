Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA03E4BDD
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhHISLR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhHISLR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Aug 2021 14:11:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF7C0613D3
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 11:10:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mD9jj-0005Qq-7s; Mon, 09 Aug 2021 20:10:55 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:b60e:a8cd:6ec5:c321])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 06473663797;
        Mon,  9 Aug 2021 18:10:53 +0000 (UTC)
Date:   Mon, 9 Aug 2021 20:10:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Hussein Alasadi <alasadi@arecs.eu>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] m_can: fixed typo in m_can_set_bittiming() causing
 corrupt DBTP register content
Message-ID: <20210809181051.5a7vckphc5mizv2f@pengutronix.de>
References: <FRYP281MB06140984ABD9994C0AAF7433D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oa6nwyo7gp5ghwt7"
Content-Disposition: inline
In-Reply-To: <FRYP281MB06140984ABD9994C0AAF7433D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oa6nwyo7gp5ghwt7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Hussein Alasadi,

On 09.08.2021 17:36:52, Hussein Alasadi wrote:
> Fixed M_CAN_DBTP corrupt register contents:
> * NBTP_xxx defines were being used instead of DBTP_xxx.
> * reg_btp was not getting ORed with the possibly-existing DBTP_TDC flag.

Thanks for your patch!

Can you please re-send the patch with your "Signed-off-by:". For details
see:

https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/submitt=
ing-patches.rst#L356

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oa6nwyo7gp5ghwt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmERb6kACgkQqclaivrt
76kRpAf/ZpJ2EcWP6+jmxAwKzix2m2HncrUD6D+7APgU42C07gH91AXWuXA3pcxj
sWf7DjeWF75zgZp0+BDGfGpSq1ZsOSc7rgz5/A/agtIBE8aqht3v8ZNWhPtBOkhv
Fm77GBu9rAGZv3TbCzonpeEwn8AavZoEEycx3FgnD9+TtJnt33QWhPPWsSrgQ31/
xNntaIh8QjLLxevZZbReQmkhmPs9mCwjYWToO0JPHFKq0ewzx8t7Wxuies/2fGpW
G3T1JnH0FuOBR15xaTzSBUXQRQCygoFMVm7LSkU5Eolx/tTaoOAn0ZET7C4WB7Gz
gi4DY87E7KVT5MfNgsPJFbh6j/4yeA==
=2tHs
-----END PGP SIGNATURE-----

--oa6nwyo7gp5ghwt7--
