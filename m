Return-Path: <linux-can+bounces-1715-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D039A121D
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D710D1C23606
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8496B20C009;
	Wed, 16 Oct 2024 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cJLgizQw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5D2141A4
	for <linux-can@vger.kernel.org>; Wed, 16 Oct 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105049; cv=none; b=ekX8amRGYGL9QKKrNLe3JFVxxQlahUlEfVXuF9U//cXAOb6PboJPplPybBeU5+AEz/0E97HAcFq29uDXDohuhYBYwXpx+5A24FqN0JmF9faccGBkt5aGwuxkbIz9lrzryyE1XtyQhjeB7KeV2ggsrcLNH8ZkUQLWtKWjLt0hONo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105049; c=relaxed/simple;
	bh=wPhXh+r05SEEfRW+dlu3z9cBN5oJMYRSD9axo7QTfyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyl/EbnKGZb/hn0Ysb/K+BUmKyz19Tereb6FgwM1ZjInPzCMUOPTldTcAvMTHlfpC4yeUQP7zrBBIlI/NC4k2akVkROMv+KwrFPmaxxjU2KaLv+7EZaQSyOCO4FIDUaZsBy9T9u3g/nquhv6ds60VKHAXrod+qqTIqAycU7BrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cJLgizQw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99650da839so19528066b.2
        for <linux-can@vger.kernel.org>; Wed, 16 Oct 2024 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729105045; x=1729709845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NSjzf6BPB669SPmFQAhJmWU/60txO/dSmZRKiOfK1k=;
        b=cJLgizQwuo343rmAyv7+Vh7bhP/YxApELozMIBM7bDV3CsMutjeZpaQkGFOrjGKT+9
         sP/cJwPLL7+zHa3qxXqBt7PPVEYPanopy0APl6GO3Rj44/8Cj0W23RNa7u6lJoHg0EXN
         1UqvyblayPWquQia4oyJMNbSW2gVZ/t8iY1q6vjPm2Ncg5sKjci1MKcLZ+52gVLi1QXA
         u2X5I526OI8EdY2SFeqgugUCXK7UgKYej7cPNK+zgpq0L9844nvbo1ihiCHjr2t8YNfH
         nZG0f6ixZB35dOuAEZCAYg5LQyVMQScb+cTyBiFgS7Yrd/vPfky1UrgTqf/MmgfESGkj
         uyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105045; x=1729709845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NSjzf6BPB669SPmFQAhJmWU/60txO/dSmZRKiOfK1k=;
        b=UM8Uo6fQrhQrXOz1LHT3K1dHj760MvRQZKnv6e1w7sh3oztfsdlJXb5m2BawCVxN+b
         P9eFIYG7z6nZHlfw4Y/8LVAIXvBF25VRz5irjkcRUCgvpcX282hdc42yyPwI+kJ/sSv5
         l8zKb8KPZP8ALU4jIFFhixK3XHospqO/5OSWv8fyBqlwzZ78K99daynARlosJbEHM1qU
         0rJda3ToMkcMKwdKLCtz56kr/IXz5WocHcFGTDepvZctJcS+Pk9prMkU9UIJUz0tp0JE
         lz9XGsfp1oEbQ4Zn9rkdiPJ0wCXATtVuyDKv4MquzKWhi+6VloESehbNZI8XKUDeMeEk
         mUpw==
X-Forwarded-Encrypted: i=1; AJvYcCWmo1v0bV0MzGIZ8VRfFBk8vq+jSrUqFaVKwQpXEJoXZtcQUPqngOgXEqqW6uGglCuDZM9KX4HKGb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMz5U6rE8DxEobPHeMgaRJcIsL0jF++UEQMGlbhv7cdNagbeC/
	/W5uPrav5yXS76EC25QDVrkwet+njfl7N1KMGJwCFyJjSFB5SA/9OHDEuSqHRTA=
X-Google-Smtp-Source: AGHT+IF5YBy+a1zYqbbQ1euqQQPHYEnpcp3B22EIBtiwIKZl3LYqWIhzQbqF0HNbo0k9eO8w1IAJRQ==
X-Received: by 2002:a17:907:1c9b:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a99e3b3329dmr1593991766b.20.1729105045045;
        Wed, 16 Oct 2024 11:57:25 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:c75a:6d73:cead:b69a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29816adbsm210816666b.109.2024.10.16.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:57:24 -0700 (PDT)
Date: Wed, 16 Oct 2024 20:57:23 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v4 3/9] can: m_can: Map WoL to device_set_wakeup_enable
Message-ID: <zas3pyfuv2f2qouctwdi6poaznobytq53mjjusificzfloafsl@q3oursy6rxjn>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
 <20241015-topic-mcan-wakeup-source-v6-12-v4-3-fdac1d1e7aa6@baylibre.com>
 <CAMZ6RqJfBbFRaynjFAbi5quAvcA1bYj7Dw_vJ7rDsLRaEheZrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbge6drx2p5okdk6"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJfBbFRaynjFAbi5quAvcA1bYj7Dw_vJ7rDsLRaEheZrw@mail.gmail.com>


--kbge6drx2p5okdk6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Wed, Oct 16, 2024 at 11:32:06PM GMT, Vincent MAILHOL wrote:
> On Wed. 16 Oct. 2024 at 04:18, Markus Schneider-Pargmann
> <msp@baylibre.com> wrote:
> > In some devices the pins of the m_can module can act as a wakeup source.
> > This patch helps do that by connecting the PHY_WAKE WoL option to
> > device_set_wakeup_enable. By marking this device as being wakeup
> > enabled, this setting can be used by platform code to decide which
> > sleep or poweroff mode to use.
> >
> > Also this prepares the driver for the next patch in which the pinctrl
> > settings are changed depending on the desired wakeup source.
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>=20
> I left a nitpick below. Regardless:
>=20
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
> > ---
> >  drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index a978b960f1f1e1e8273216ff330ab789d0fd6d51..d427645a5b3baf7d0a648e3=
b008d7d7de7f23374 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -2185,6 +2185,36 @@ static int m_can_set_coalesce(struct net_device =
*dev,
> >         return 0;
> >  }
> >
> > +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolin=
fo *wol)
> > +{
> > +       struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +
> > +       wol->supported =3D device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > +       wol->wolopts =3D device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > +}
> > +
> > +static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinf=
o *wol)
> > +{
> > +       struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +       bool wol_enable =3D !!(wol->wolopts & WAKE_PHY);
> > +       int ret;
> > +
> > +       if ((wol->wolopts & WAKE_PHY) !=3D wol->wolopts)
>=20
> Here, you want to check if a bit other than WAKE_PHY is set, isn't it?
> What about doing this:
>=20
>           if (wol->wolopts & ~WAKE_PHY)
>=20
> instead?

Yes, thanks, that is better. Thank you for your reviews!

Best
Markus

>=20
> > +               return -EINVAL;
> > +
> > +       if (wol_enable =3D=3D device_may_wakeup(cdev->dev))
> > +               return 0;
> > +
> > +       ret =3D device_set_wakeup_enable(cdev->dev, wol_enable);
> > +       if (ret) {
> > +               netdev_err(cdev->net, "Failed to set wakeup enable %pE\=
n",
> > +                          ERR_PTR(ret));
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static const struct ethtool_ops m_can_ethtool_ops_coalescing =3D {
> >         .supported_coalesce_params =3D ETHTOOL_COALESCE_RX_USECS_IRQ |
> >                 ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
> > @@ -2194,10 +2224,14 @@ static const struct ethtool_ops m_can_ethtool_o=
ps_coalescing =3D {
> >         .get_ts_info =3D ethtool_op_get_ts_info,
> >         .get_coalesce =3D m_can_get_coalesce,
> >         .set_coalesce =3D m_can_set_coalesce,
> > +       .get_wol =3D m_can_get_wol,
> > +       .set_wol =3D m_can_set_wol,
> >  };
> >
> >  static const struct ethtool_ops m_can_ethtool_ops =3D {
> >         .get_ts_info =3D ethtool_op_get_ts_info,
> > +       .get_wol =3D m_can_get_wol,
> > +       .set_wol =3D m_can_set_wol,
> >  };
> >
> >  static int register_m_can_dev(struct m_can_classdev *cdev)
> > @@ -2324,6 +2358,9 @@ struct m_can_classdev *m_can_class_allocate_dev(s=
truct device *dev,
> >                 goto out;
> >         }
> >
> > +       if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup=
-source"))
> > +               device_set_wakeup_capable(dev, true);
> > +
> >         /* Get TX FIFO size
> >          * Defines the total amount of echo buffers for loopback
> >          */
> >
> > --
> > 2.45.2
> >
> >

--kbge6drx2p5okdk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZxAMjAAKCRAkjLTi1BWu
P/5DAP4wefyrUYIEtW0zEvZcxFGGUxIhdW9X8KsYmidnPmRCMQEAu6U7HHuys0aY
E+xLPVnlePLxFke28ta1HXjD0B5r6w4=
=VBQg
-----END PGP SIGNATURE-----

--kbge6drx2p5okdk6--

