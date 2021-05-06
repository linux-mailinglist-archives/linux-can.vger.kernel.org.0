Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74FD3754E4
	for <lists+linux-can@lfdr.de>; Thu,  6 May 2021 15:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhEFNjW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 May 2021 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhEFNjV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 May 2021 09:39:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A8C061574
        for <linux-can@vger.kernel.org>; Thu,  6 May 2021 06:38:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1leeCr-0006g4-V1; Thu, 06 May 2021 15:38:22 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:56e8:75f4:d926:a060])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 277DB61E1A9;
        Thu,  6 May 2021 13:38:21 +0000 (UTC)
Date:   Thu, 6 May 2021 15:38:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Message-ID: <20210506133820.ynabngerxtc5vsea@pengutronix.de>
References: <b70da5bc15974457b172794ef1149a99@liebherr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="727cc3pie6hciqt2"
Content-Disposition: inline
In-Reply-To: <b70da5bc15974457b172794ef1149a99@liebherr.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--727cc3pie6hciqt2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.05.2021 12:45:38, Sottas Guillaume (LMB) wrote:
> Thank you for your investigations, seems to be the way to go? What is
> the next step, could I help in any way or are you going to merge your
> patch directly? I'm not really sure how we should go further in order
> to inegrate your fix in the code...

Maybe we can use sk->sk_err directly instead of adding a new variable.
I've send a patch, please test.

> Thank you in advance for your feedback,

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--727cc3pie6hciqt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCT8UkACgkQqclaivrt
76nnQgf/W6WISVX86+fO8Wk5DlAstO1inIXjOeP33XUzOyS0K5kylDaS8mcF1RgO
+/RbWIDL3mJIyIz0WJ3WJA3qsbedWJsGfJffHQmngULPgZ/uvIc/7cGXntjsvfEw
OS6EI6zESnBwBqmrRphRPxPjX2lTbsiKY1/8tb2ciPDdE+xAdFtdqYUJVbvjP21i
YbTyW0LNkJov2CnQ3qQVD3lfyK2S5quWjqQFhYzitEg9nG7blAkx8PMFEwNhNfnx
TS4BP4MhGUs1BeDs/Iyi0VZlWh6yDHU9rgolCNGRjst9sNm5+Zn8U3yPzOviVlTM
aUVcLfhNK04deriT2G41V9wdgI2o6Q==
=OGdq
-----END PGP SIGNATURE-----

--727cc3pie6hciqt2--
