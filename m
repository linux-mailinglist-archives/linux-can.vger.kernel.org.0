Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26384380E2B
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhENQ3A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhENQ27 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 12:28:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7CC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 09:27:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d11so30558801wrw.8
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZ4O3gdqb06/kqztostiQWff9lnh0i3WRbcX9aKETQo=;
        b=oiWdL7AxkBAS6hjfY4XkAr0hEXl4bJkf4TXT3YAG4prBToiMQNBJbJROLJ+s9scyuN
         eMaAx2zlWn+15sf20A2xF9noEUZLCrRT9vfIz0te67nsJuKaLxb7X/zKGVyo4N8cya9I
         Q5WWBz1NBx2DiZXiD24MqGbwanRN2CBPKNWF3+jsTBcKLOCygB/Ma3Nf8pQIgsEpWmj0
         uiwTXP32AZ8Rdu7f4PySX/sOT1ljf4YtRNW8+I6Q1EEi0GgIAUrXkn7m/qmQEZgfn94V
         2xbfksYPu6Pv6YFVh3/sVENNq5rBX89bDQ2qs2EndndNTD3AMSadI5G+xqj5JULaQMLa
         hHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZ4O3gdqb06/kqztostiQWff9lnh0i3WRbcX9aKETQo=;
        b=MgF2ApURI6k+62MTvwAymaxOqWxhgNoIM49EGXqOi+wHWAar7nPLMrMYKbtTAQeouc
         siIamYiAsg9Cwy88D/1Ea1w2ElZkdr46DorETPM02d7kTxEvcrL+dk8JgcaJmbHAKWhp
         8Coigz9z1EqJlKh38zQwV/mLxNnGf9+nIuLc45QjdMwu7S4H3Eru8Aw7X95STFu6Wqp5
         BUWcyRKTWRK/cMBjqLIz1jJOkffny8wKnGv2BlthdTQKAj8S2LvQoBxf1uAp97AEWBWY
         cln+rHzuHDGWPTpZfXDcqPaD7YwVL91KzXsx8+dA+JLGl17fNDBz68TnobJnlnma49MC
         5QSg==
X-Gm-Message-State: AOAM533TvQpi5Da70MJHcNOP+0SzJPIzbLAavxMRxn2pj9C3P2rxDYq6
        jYpntq8UM/Fz+01L7pmNFH8iRhg9sDn6lqw1
X-Google-Smtp-Source: ABdhPJxRSwj2fxwLjUKYTQm+cINZTi8sIN3CPH3j23WehraI4df9/BOh0L9FEj5cKaRVJ61GlmjA9Q==
X-Received: by 2002:a05:6000:237:: with SMTP id l23mr54252397wrz.138.1621009665967;
        Fri, 14 May 2021 09:27:45 -0700 (PDT)
Received: from bigthink ([148.252.128.100])
        by smtp.gmail.com with ESMTPSA id s5sm5876616wmh.37.2021.05.14.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:27:45 -0700 (PDT)
Date:   Fri, 14 May 2021 17:27:43 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 3/3] can: tcan4x5x: add
 handle_dev_interrupts callback to ops
Message-ID: <20210514162743.tcyjpln2pf4qp7os@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514121946.2344901-4-torin@maxiluxsystems.com>
 <20210514141012.3ehw4tosog3lreq4@pengutronix.de>
 <20210514145101.uk7wldgsao5cvuj7@bigthink>
 <20210514151548.jqydfez77fp74fdf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jjsjar7testaxpcf"
Content-Disposition: inline
In-Reply-To: <20210514151548.jqydfez77fp74fdf@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jjsjar7testaxpcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 05:15:48PM +0200, Marc Kleine-Budde wrote:
> On 14.05.2021 15:51:01, Torin Cooper-Bennun wrote:
> > I agree we should shut down the interface - I've previously endured
> > serious debugging pain due to SPI errors going unrecognised and
> > causing havoc.
>=20
> You can eventually do the same, return negative error value from the
> tcan4x5x handler and the main IRQ handler will shut down the chip. A
> return value >=3D 0 would be the IRQ_*.
>=20
> Some background information:
>=20
> You have to keep in mind, the regmap_() functions might fail due to a
> non permanent problem, e.g. resource shortage (out-of-memory, etc...). I
> decided it's too complicated to properly recover from those, especially
> if the driver touches some FIFO pointer.
>=20
> The mcp251xfd chip offers CRC check summing during read. If the driver
> detect a CRC read error (that stays even after some retries), I let the
> regmap_read() function to return an error that is then passed down the
> call stack. And then chip will be shut down.

Cool, I'll keep this in mind.

Obviously tcan4550 has no such SPI checking, but it does have ECC memory
at least. Unrecoverable ECC errors are reported in the device
interrupts, so that's a good example of something I'd want to respond to
with a shutdown!

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--jjsjar7testaxpcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCepPsACgkQj1jJmDXJ
kUiungv/YCUia2NkMADYxLT3d9dqnTkRV1uWWuC4S2TpkUV/zya/7VRTYN8ei5eQ
kEprn31vFDYXU+VvjYXx1gcDeQjLPV9sjEhTrcH5XYl23ec3QcDfi5/vOcnxiggl
y0hdRndJRyof763ucyCMkhD7TLVy5q7nJTlLLE5/7zMyCOrKQxDNdJaTmIS3hbiR
54LcGz3IRZVKvz/2pahlWck/tMO8Fh+pCrOtwkXXXhNCnKmztPgPr2VMuCBsVwE0
kFCftQTh7wBOT499WrGa44X0SfqDCRdKUcS/7CtRr9hidZoYcKlnPVXUE5lQk0VW
QgpZdOINbd808+Sq19eqTb7pRAABSahz7OmAUbfNA0HN1jfQVhCMW4IvKqxmncN+
XKBolVQTSHvAyGHwPAYB5+wjyMs+SRuYEZo1FL2ISBGlQf20wfFaQIxMhPAR3XUR
WdyOxtV1QqgwvDUQYrlPMk0lBG/R33pr80HZoCPY/lNy+UT9BZqd3+kwqjOS277C
Y4yJaxyV
=bu9I
-----END PGP SIGNATURE-----

--jjsjar7testaxpcf--
