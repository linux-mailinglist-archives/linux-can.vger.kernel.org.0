Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7735C2AD
	for <lists+linux-can@lfdr.de>; Mon, 12 Apr 2021 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhDLJrM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Apr 2021 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbhDLJmZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Apr 2021 05:42:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE82C061373
        for <linux-can@vger.kernel.org>; Mon, 12 Apr 2021 02:39:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lVt2H-0007xr-74; Mon, 12 Apr 2021 11:39:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3d5d:9164:44d1:db57])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F047060CC8F;
        Mon, 12 Apr 2021 09:39:11 +0000 (UTC)
Date:   Mon, 12 Apr 2021 11:39:11 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [RFC]: can-next 2021-04-06: peak_usb cleanups
Message-ID: <20210412093911.nh2xdzfqlzyybtte@pengutronix.de>
References: <20210406111622.1874957-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfy475kl2y7ky6ei"
Content-Disposition: inline
In-Reply-To: <20210406111622.1874957-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--rfy475kl2y7ky6ei
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.04.2021 13:16:12, Marc Kleine-Budde wrote:
> this series consist of several cleanups for the peak_usb driver. It
> was tested on the peak_usb_fd, but it also does some changes on the
> peak_usb, which I don't have access to.

I'll include the patches 01...06 in my next pull request. I'd like the
others to be tested on real hardware, which I don't have.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rfy475kl2y7ky6ei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmB0FTwACgkQqclaivrt
76kWMAgAqxFcEqNvgJiM8mS2y7oQmMVKOodK4nTEN+8OewaZVN14/pbYT5EU4qnv
31MLPhT+bmDnrP7/6QJTPT6zYBCKVNcXpJC558UuT7INikX/V2m7G0RBY3Uxez72
5UmUHaO4PcrmqqAxQ+I+EHlgoGeRPMlE4Ax0TrHHRL2iAp46FtMIQifBlmjmrFUE
G9gkRSMremcb5K0tX72Ac5WeAPZKMh/g9+C8SausMsd4Xah9V1ZSCjwEtQ9FSIwl
CPjqRLmY/MMU/5ob5r6kLNIPtq5wUagYTzG/My/KBxKdIEfFivJyVjU/jY23Q+uW
FJEs05xZglOJ9C39bWoS9loSyGz53A==
=tl8C
-----END PGP SIGNATURE-----

--rfy475kl2y7ky6ei--
