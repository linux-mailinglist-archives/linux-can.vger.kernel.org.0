Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF5380A58
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 15:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhENNXP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhENNXO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 09:23:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E0C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 06:22:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r12so4428019wrp.1
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n5Y+ht6ouMsoJdhN1SBxDt4jfxmlwqhhJMSleB0BB3s=;
        b=cmYmMJ5ayOa4SKi3vcfhcGpUKJrue3/q7tLqdUxb9CcZGT8AZ91K0TtrrKJfknwC7t
         R/Bl7zfpvfDMQfJ3wzKAzJrCjBplOvvN6wMA05vgk/tOC36PlLMmMjFqLL7q3b5lSZRl
         Lv59arHoqiVfnaVZBqN5Jxo3Aap1wq58SuxslMSZiSIH8lC4ZraT/tXA7pyL53GbrLwd
         ex6WqjTzbBzkFw0/iZMSohJ2BLD/9OKgmPJNwRjRI0sxHl5THTrC+CLWedoSk2/B3CkW
         Ib18Kb2ntqlr/BvF452+Xzw+sUf1STz3wYKAgUz/IF6f0MGAGyFqM2QUVG6+FKotcpuI
         oC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n5Y+ht6ouMsoJdhN1SBxDt4jfxmlwqhhJMSleB0BB3s=;
        b=ipNiaHFXHevp8IH5mXczuCej+WIeEyB12+ntJFzIlwuDiyeNjKQqUK8ixSqx8jz6HB
         4Irsc6NtVBwrhEGiiCD+MY9aFEI4mKTJYhZaGWsB4GsgiEEEwAofnweUajfIdJo7zWHz
         6bFHbiN0y7zchSv1C4f0iTT7ohuezFP38s34j3Lgg5KodS0Tuodbs6slUhlfh4/UGiL8
         0Fqqzq7+jTP/dxNgFkdVNgn847GeiwdzUpgWgG7E4zhGpDtwvId+iRmbo3kje16O/K9Q
         UZCQfiDyHm+hAWNMsdp0nC+HLoYdbpGN8YWIU9stBei0FAog/S/YRQXWaozM9h1NBQdh
         jyMg==
X-Gm-Message-State: AOAM531WYEOFLakOmqGtqJ3vY7M/gGovJnxxzNBMtYnBQynqe/iVH879
        QUxxdkKLf1TceYhHHRxvrriN6RQK0WK9bw==
X-Google-Smtp-Source: ABdhPJwZYgUZIdiYASdYeFdeytAA4CflPHSik/h2RDgS2uHUO+yVw/mB9HfXpD2e8onbNqQFBCoXow==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr58401243wrs.17.1620998522209;
        Fri, 14 May 2021 06:22:02 -0700 (PDT)
Received: from bigthink (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id c14sm6417865wrt.77.2021.05.14.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:22:01 -0700 (PDT)
Date:   Fri, 14 May 2021 14:21:59 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 1/3] can: m_can: add handle_dev_interrupts
 callback to m_can_ops
Message-ID: <20210514132159.ohq5wtekdjea64yy@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514121946.2344901-2-torin@maxiluxsystems.com>
 <20210514122610.q7mhf3frapxig5xg@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="thpnoidfje6biaey"
Content-Disposition: inline
In-Reply-To: <20210514122610.q7mhf3frapxig5xg@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--thpnoidfje6biaey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 02:26:10PM +0200, Marc Kleine-Budde wrote:
> On 14.05.2021 13:19:44, Torin Cooper-Bennun wrote:
> > This callback will allow M_CAN-based devices, e.g. TI TCAN4550, to
> > handle device-specific interrupts which are not part of the M_CAN core,
> > but are signaled on the same interrupt pin.
> >=20
> > Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
>=20
> Another option would be to register a 2nd threaded interrupt handler in
> the tcan4x5x driver....But this is much simpler.

Total separation of the two does make some sense. Events arising from
the device-specific interrupt handling would be things like
under-/over-voltage faults, CAN stuck dominant, SPI malfunction, etc...
things that M_CAN shouldn't have to care about at all.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--thpnoidfje6biaey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCeeXQACgkQj1jJmDXJ
kUhkNgv9GTuP3mka3DCu9+LNlybxQZGkFpNbDl6eoF3v7GFofce0qFIq3LyQkfjV
1bW2PKR1l+4IXohQzPCbWTKqWBhYppyADrMo1o0dNDbU4dw3SFvsXN0sRJRUGslz
HCrTYLxczb2qgdbRUlDX2tRhmMLous2Di44YXKBkdDZM9wiHnw9kV4BLr8tk8RkS
B84KvaLXh0/LSjNWnZO8nvVFNxse+xjzM9Fh1X3c/rUyRogRW+a+GB6E32mTBnzG
Ko+Av6ihtz5qlKDvfuxRxynqLt+X0op0jNrglsXNeZWS77Hvw+y7yxTHZpB6xnBY
eNVwRmLzIkERPgHhLyi72tyy/loZHCkF+QAmkM8i2MDOep4T33r6meXPVI+Iio3W
P3Al4vxldfwXXdoNlpWpg91iM6ZWochUomb7AC3rblWrf2Nyk3hsgmfjrzR0ov10
SyS0FTnKHOmKgRkchHtfGXtPxuuBhN6ZNyS5cu5LDBbYYB2mUxN5kdzcboI7Jd/Y
wWeH7m9f
=qMk9
-----END PGP SIGNATURE-----

--thpnoidfje6biaey--
