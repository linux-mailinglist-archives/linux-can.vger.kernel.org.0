Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0335A396EDA
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhFAIZZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhFAIZY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 04:25:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A81C061574
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 01:23:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c5so2121756wrq.9
        for <linux-can@vger.kernel.org>; Tue, 01 Jun 2021 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nLI/XvwXb3aAYxvhf6rF3BOzNGQgF22qtpLMYuIvVk=;
        b=qpJSIT1sEcZbOLmTzBSsPoFY2aTcXMlOXn3BhQ37g8B75Tbel6KMCEJxqRmuh8Ha+b
         15TVSnB+QYqn1udogLV8o/X8JXqx83/U2qur6vQDqQTPX8/NXxyhALoNGzAW3vI6cU9R
         iuRHDkZhqn/JUsJsiuVwaWcZLxMwG7BSYQDaQmFKH9i+akIPMFVkRUER8wAd8PPYruOS
         JdN8YOX45EaGByx+ETfRAzuccHi+shoTIu73Th1r91PWcvNf6dAznoOWWPtT1cAC9J4Q
         z6so+PSdlMjFqZ3GlnT1kfcpFSAzIxV/fWE6G8lnMjCi28JBrTNCyr7ydtRHv3UGU1I+
         0zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nLI/XvwXb3aAYxvhf6rF3BOzNGQgF22qtpLMYuIvVk=;
        b=OjwreXcwI3uTVIfzXWieu6xLJw2NNwH9TYwRCy1G21fjRtqiE1Zd4QArq/T0cdn3LX
         cIkP7giP6mQcznZdGGfWIzINaVQKdaZctZHIAgUjvQ515ChevaMiB4XOq5yoN7OpBiYA
         P25d9wX/Cla8TLXzrvtPeDXWkE8aLuBzY8RPYPZXW18uGFYLKCee70t+Iv383veSDg48
         mgu8zE2qZWxWUrQAfwJufcpuesoVL7lYyj/fofOSaaOXPLYn9u74shQE1pN2CHMovtcP
         Rw4H4XNOIncZ7z6M/57a5qX94XYdURuHxw367Ecwpy1kmZQgYrkzHaRRdGuF8KCwVdiK
         rRCg==
X-Gm-Message-State: AOAM530mW8VDINrP2kMetyb965mMUIB/bjSyAjOgxBj3iiwE0SnM1cEM
        B+NAIaUO8n2JA4WYYJXD1JRrhJPLFK7/sg==
X-Google-Smtp-Source: ABdhPJy1KKGL009Or2DvuJx3VdjaxAC2mzAYTdcxEO7+Q+J8bj5XC7Nen0D0IqOcME0UVLRvljq/Cw==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr549502wrw.93.1622535821617;
        Tue, 01 Jun 2021 01:23:41 -0700 (PDT)
Received: from bigthink (94.197.211.16.threembb.co.uk. [94.197.211.16])
        by smtp.gmail.com with ESMTPSA id t5sm1747222wmi.32.2021.06.01.01.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:23:41 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:23:38 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 2/5] can: m_can: m_can_isr(): handle
 device-specific interrupts
Message-ID: <20210601082338.b7t67oebywhcwcnd@bigthink>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-3-torin@maxiluxsystems.com>
 <20210526150705.s4ms7jhowsuts3yf@pengutronix.de>
 <20210526151833.5ppprex6zzrclr6u@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hm6azvrphclzpj77"
Content-Disposition: inline
In-Reply-To: <20210526151833.5ppprex6zzrclr6u@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hm6azvrphclzpj77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 05:18:33PM +0200, Marc Kleine-Budde wrote:
> On 26.05.2021 17:07:05, Marc Kleine-Budde wrote:
> > On 26.05.2021 13:47:44, Torin Cooper-Bennun wrote:
> > > +	if (!ir) {
> > > +		/* Handle device-specific interrupts */
> > > +		if (cdev->ops->handle_dev_interrupts)
> > > +			irq_ret =3D cdev->ops->handle_dev_interrupts(cdev, false);
> > > +		return irq_ret;
> > > +	}
> > > +
> > > +	/* ACK M_CAN interrupts */
> > > +	m_can_write(cdev, M_CAN_IR, ir);
> > > =20
> > > +	/* ACK device-specific interrupts */
> > >  	if (cdev->ops->handle_dev_interrupts)
> > >  		cdev->ops->handle_dev_interrupts(cdev, true);
> >=20
> > Why do you call a 2nd time the handle_dev_interrupts() callback?
>=20
> I see, clear and no clear. Why are these two separate operations?

As discussed here,

https://lore.kernel.org/linux-can/20210514141012.3ehw4tosog3lreq4@pengutron=
ix.de/

you previously recommended adding a 2nd parameter the callback to
indicate that we only want to clear the device IR, not read it, in order
to save an SPI transaction when M_CAN core interrupts were already
handled.

However, quoting from your previous mail,

> On 26.05.2021 13:47:44, Torin Cooper-Bennun wrote:
> > Device-specific interrupts are handled, if no M_CAN core interrupts were
> > handled in the ISR call.
>=20
> In case there are both core and device specific interrupts the kernel
> IRQ handler will call the ISR a 2nd time - should be OK.

this implies I should leave device IR totally alone unless no M_CAN
interrupts are asserted, and do the following only:

|	ir =3D m_can_read(cdev, M_CAN_IR);
|
|	if (!ir) {
|		/* Handle device-specific interrupts */
|		if (cdev->ops->handle_dev_interrupts)
|			irq_ret =3D cdev->ops->handle_dev_interrupts(cdev, false);
|		return irq_ret;
|	}
|
|	/* ACK M_CAN interrupts */
|	m_can_write(cdev, M_CAN_IR, ir);

I can probably also kill off the clear_only parameter.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--hm6azvrphclzpj77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEHoj68wxDgkT3Oo2Mj1jJmDXJkUgFAmC17ooACgkQj1jJmDXJ
kUjoNwwAgKqzgOmOiOqDOg9y/basan6iksCH6DLCTScHP9CP5+Ua89Yyr7pcNkqZ
F+MXJXixTBgr1PbS4ZF2u+E0DEWLcRY5UPEStNROkVaPggsYf522z0uNXyQnDRiG
bP7Bv6iaiLEInLnFNnHmX2vUhaQI3vZ2ne/AefO2nkY/bfw0iXF2eI1fQHyBbsL0
ALNRzUhNmdlYDvYXIbUpQR6hTMmINWZPFp4IfLhViqV6QQdWB/rtE6d7flqdjfLe
H9YI0w/uLtyUD8q/gL0fiMV/dhxiO9bJqUsDR7E3Acb2ABSoVtjEg1v3dZy4n7zl
bMGNnYuzFaeKxk1/ecaYijAig7TOwjuLsxidvckgp/lxDykIPL6NEt2VQ53EChjl
WDYXKG9QE7mzrKdWPo25CXwkUm0ans02oakVsD/QXsp+f6KzbnG/ORKXIpUbzwrJ
gYWffHgLymXt3V98dk61HjOUfa/470GpJrPA+yluGdX3ZEiF0vxwq91J9dBaXvlg
pk84EIDt
=HPqz
-----END PGP SIGNATURE-----

--hm6azvrphclzpj77--
