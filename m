Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23D1380E67
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhENQry (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhENQry (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 12:47:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFAC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 09:46:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so80013wmh.4
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=68uJI801vfzIxUh6YSTM2MfS2Z0gvoqP2WlrselxlOo=;
        b=v/p3HAcvmQDmdDQcY2T2tTrZxE75nSTE1H3O5ypcWBmsyKrkBEGYf9yh/h0a1lP/z9
         DM5DNV40+E42svJ0h7nz7LJUahSLQZFGoRhyPzPSMGs8t36swSb7hUl8QkXMM8H1wgAt
         I3qzN4jCD0H3ulLbCvp1dwv7/9rdRWKp3bIRCwHQ64/Ln0JTy4BToWVp2hI9KbH0kmI0
         a/NXCuvJiXM6glAnDrW/nv6G8SNofuf28ADxN1Qz0flbEmlHPlQbZPADcO1UnBhBc4cQ
         IDvVlh4QEijT1daZbLj5XDB35ubq0N4NQ43ZyjyPXN0FPHNOTsTbWsLhhhXbp8zkZK49
         xcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=68uJI801vfzIxUh6YSTM2MfS2Z0gvoqP2WlrselxlOo=;
        b=BB56rxj+xtMbZf3c7Yi1JWmb0wzXZ83ZsisLQQlZZQnNAfNYYNzSLb43DSWvW734bJ
         9yBvNj6Vk7cYHsU3BAPqFWkpj/6INmnO7Xb5/cELtdFWjR4SQUrJA56DtwvMuZ8k++Sr
         Gm5LpjPJvXR3yAZZof8vL5XJWkrVLCQpLTjOLgatHwjUzglx+y4hwsy2Qcpy+KVaZ3rr
         iON2pjLd/khgMzw+ZFNsxDpGxKkSnU2RKxUbHUPr+SqeafFdMtVKcnIanHSBmu2qM8z2
         AQUjwbIp+dDIa+/Qt2AhLh0ZTrYQ6CKYvnq6vIpeSRRWBKfzTW4khrQtBrL+C/QKHZV9
         Ja4g==
X-Gm-Message-State: AOAM533t2kRC/cpraWS0N7rIGvVOgYQ4CcQQwuoSyJapIatY3OMJ5Jyp
        FH1r7RgKPyyVA+EjTrLI/QXCc+M+U5cvFg7I
X-Google-Smtp-Source: ABdhPJwx6D8IXtMfis7OEUQwAgWb3LwVYjTFJ/zIlfwcoDlb71ryFeLfBy9Q4TEIsuENWynxKL8lsA==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr13700348wmj.109.1621010800380;
        Fri, 14 May 2021 09:46:40 -0700 (PDT)
Received: from bigthink ([148.252.128.100])
        by smtp.gmail.com with ESMTPSA id h8sm7103780wrw.85.2021.05.14.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:46:39 -0700 (PDT)
Date:   Fri, 14 May 2021 17:46:37 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514164637.ikdluiachvoidmpy@bigthink>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
 <20210514131049.yluxu3cxaspeptvb@bigthink>
 <20210514141237.ps7gcfjhejnehbhv@pengutronix.de>
 <20210514144434.etefrlqq5pwcb34t@bigthink>
 <20210514145556.utpdscudwcidmmcz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zsenjdqkg3hl2hn6"
Content-Disposition: inline
In-Reply-To: <20210514145556.utpdscudwcidmmcz@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zsenjdqkg3hl2hn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 04:55:56PM +0200, Marc Kleine-Budde wrote:
> On 14.05.2021 15:44:34, Torin Cooper-Bennun wrote:
> > On Fri, May 14, 2021 at 04:12:37PM +0200, Marc Kleine-Budde wrote:
> > > > The TCAN4550 has interrupts that cannot be disabled or masked, incl=
uding
> > > > those for faults involving SPI, power, and transceiver issues (e.g.=
 CAN
> > > > stuck dominant).
> > >=20
> > > Ah, ok. Do they need any handling/acknowledge? You only read TCAN4X5X=
_INT_FLAGS, are
> > > those clear-or-read?
> >=20
> > In theory, for any of these, clearing the register should be sufficient
> > for the interrupt pin to go inactive... emphasis on "in theory".
>=20
> Ok, but as you noticed in your patch, if no IRQ is pending in M_CAN_IR,
> the main driver doesn't call the tcan4x5x handler.
>=20
> So the IRQ stays active, the IRQ handler is repeatedly called and
> returns IRQ_NONE. Then you get the nobody cared warning.

I miscommunicated a bit there. I was just referring to the fact that
some of these interrupts are really broken, e.g. re-asserting for no
reason, despite what the datasheet says, yada yada.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--zsenjdqkg3hl2hn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmCeqW0ACgkQj1jJmDXJ
kUjcWQwAg5gkDvqDRYyt4kxTFNnWIYlj/0fiG7I/pdSxhlgcj2gMer9e87p4lCTT
DYxs05NmhR4yDXnuyBNzCLT+IGnAqFZ1F/kVhMRXPJXUwVuyk/TvGUOoghdDbNnF
S7e967VVhSmH+PGhMwnndyj2lcrR4cwklI3dw/YQlWUcofUe7Vod5qBq1KcxJaP0
Qg668UwpcHCX4/yE6jyP2p5ag79nQ7COkHhP8kFojJdqgFSDCO4FXs2pmmL6dOI6
K2X36tb2Q8Uorh4daO9r5YZfL3pL8hv6RvxSDoT9mv6dKLUKaV+hbR6hGjcdddcI
UflU8cm1fqQpWDe9q7HAnp4PEKwdvrP8FursPf4AtVMGB9/KwUwQeULHhaY3hrAC
80CgIgGARm3n/YPBlvj/BMscnC/VMeCSFXr1f5S5pCskb16FyHvwmxMFoQ+dbWn4
lbl6QPLw7PBVic8mCcC3mtKazgOdiiGe8BNzRTsESqN5bYd3YysqPy4Zd313q+uj
bs13YuCI
=77Ln
-----END PGP SIGNATURE-----

--zsenjdqkg3hl2hn6--
