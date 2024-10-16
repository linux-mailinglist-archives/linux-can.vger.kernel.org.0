Return-Path: <linux-can+bounces-1712-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84A9A0E3C
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2826DB222B0
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411120E03B;
	Wed, 16 Oct 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2A2rdh0m"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8ED20ADE7
	for <linux-can@vger.kernel.org>; Wed, 16 Oct 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092717; cv=none; b=f5aWCTgXTsEONiCu97GaonUufbUprUD6XBcfCN0GL4iBJM/ohgi/XARPGj6wdYIHyYfmNQ1WFjYiDsw1mhm9kKHHAVfPxo29YEI1RYXwtuioWFHEfOi+1uGVXFDZ7sAc26Abqw/dPNGxUD2IOl9H2qxkYRLXoC2Kf/XT7wzXtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092717; c=relaxed/simple;
	bh=et6nC1v896qFmVMDhC2Eay+Waajk2H8HCHq1efeucn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgiRN1tWe1lBo3yAf3b2XL7/vC6ledrDKqihTW24czXBlilcBrwEKqFu4P0G65oRp31/YhVLk4DerKtWGDHZXfCuYK3ckAZiXRbP1QaWqmLFzwwXiXyOwG0KaPc3igNDkzqczOrvcwJR3ve6/CUEvvcbTe9+VSKsulOAICUvGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2A2rdh0m; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so471a12.1
        for <linux-can@vger.kernel.org>; Wed, 16 Oct 2024 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729092712; x=1729697512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu+GB+uHENPaQUQ4sHqLSBy0t3XL51Quiz4Pu0NP5rg=;
        b=2A2rdh0mLJm8xj63l9ZfVCSlMLRp0DxSwLcfJ2bkBZndmMALm1hUH3YTX6UIj9+1Db
         TK6MBgw18bdrXF92jLomykg2ByKkYfL1NwX2aonOK98KhqQsNskZDvBOBOKhTEWNuus3
         9D/Koqp6ZirqJunMBZi6rYcUk/eV6bmoq1N4O0LOGBkSTKVJarzXxxLn4pAPzWmwBShw
         hljpDzbMZ7dWWWp4c7CvXlyaJ5aDMKFKKU4R/WO+j1ZOjFl+8rEKZl4+np5Ziykse04S
         IKZ/fig0p1NzYHMHioLALY9S+jym3X6u/nhQIERDPcXUl9SlMO1DZ0LMW7j5GotZVDbH
         69uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092712; x=1729697512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu+GB+uHENPaQUQ4sHqLSBy0t3XL51Quiz4Pu0NP5rg=;
        b=exIbDXVd7wUFG3zf/DCGCPtXZiGCBI7gcmWt8XcI1W+slN4EBTWv880oJZnL3Cz4cg
         93iR8DO1HiCEytWQnvK5X/w8H44wcYsN/+U0yelEGpv8ZQvO6l9Um7W09+qAD+Za4Ju2
         6L4cXvTsU+mAFEBcHOvFtkNkezpd9hE4hf+axcIGF2HNcWDHISfveS6fOtwdSruZktex
         wCz9ib81+WfDstAw101BW2U8P5flup0vMRGvGKXNbo7KJp4GCvq3PB4EfUSD8kfA2nn/
         vN6ZSkxa5ZbV0N8ofXrHTz6xNYKMAP8RNf2mJzxuyF3UgNw5kh7QHu53h+lvNVhRY3Dv
         /c6g==
X-Forwarded-Encrypted: i=1; AJvYcCWU7zpHG4KQRn8IDP8wR/wVA7Lb4X7XhA3TR+GKQwfQNfRqWild5+69xn8pRp1oRAZMZk0TihYrWqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFelkI3Hjjv1AzitchntqE7RAOc2lcWXx2ZnkLlyNcyZGFTpc
	RgvwfjvE2FzGd1gcEKSjqpS9wlkHQipBZ2/ZqB3Doh8gtWxyrSK0p/XjFmPmsZA=
X-Google-Smtp-Source: AGHT+IGBiQyqowiKIwYzSPRUSXHfIPUgmbRloCxmWBjfZepvu5bYTDGQXyZXYkvL/ex9KVOfblHvnw==
X-Received: by 2002:a17:907:7246:b0:a99:ebbb:1307 with SMTP id a640c23a62f3a-a99ebbb1413mr1413771266b.59.1729092712420;
        Wed, 16 Oct 2024 08:31:52 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:c75a:6d73:cead:b69a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298170dbsm195985566b.136.2024.10.16.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:31:51 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:31:50 +0200
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
Subject: Re: [PATCH v4 5/9] can: m_can: Support pinctrl wakeup state
Message-ID: <xiptvia2w5ocs7td2zgn3pueok2nzdslf7og4ekg3o6hdxus7r@quz2v54zmhyz>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
 <20241015-topic-mcan-wakeup-source-v6-12-v4-5-fdac1d1e7aa6@baylibre.com>
 <CAMZ6Rq+NA9G=iON56vQcr5dxEMqn-FFzT5rdxc6XrtW+4ww1XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y2xuvaaqr7j44mfa"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+NA9G=iON56vQcr5dxEMqn-FFzT5rdxc6XrtW+4ww1XQ@mail.gmail.com>


--y2xuvaaqr7j44mfa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Wed, Oct 16, 2024 at 11:26:22PM GMT, Vincent MAILHOL wrote:
> Hi Markus,
>=20
> This is a nice improvement from the v3.
>=20
> On Wed. 16 Oct. 2024 at 04:19, Markus Schneider-Pargmann
> <msp@baylibre.com> wrote:
> > am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> > a wakeup source. Add support to select the wakeup state if WOL is
> > enabled.
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  drivers/net/can/m_can/m_can.c | 68 +++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/net/can/m_can/m_can.h |  4 +++
> >  2 files changed, 72 insertions(+)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index 5a4e0ad07e9ecc82de5f1f606707f3380d3679fc..c539375005f71c88fd1f7d1=
a885ce890ce0e9327 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -2196,6 +2196,7 @@ static void m_can_get_wol(struct net_device *dev,=
 struct ethtool_wolinfo *wol)
> >  static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinf=
o *wol)
> >  {
> >         struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +       struct pinctrl_state *new_pinctrl_state =3D NULL;
> >         bool wol_enable =3D !!(wol->wolopts & WAKE_PHY);
> >         int ret;
> >
> > @@ -2212,7 +2213,28 @@ static int m_can_set_wol(struct net_device *dev,=
 struct ethtool_wolinfo *wol)
> >                 return ret;
> >         }
> >
> > +       if (wol_enable)
> > +               new_pinctrl_state =3D cdev->pinctrl_state_wakeup;
> > +       else
> > +               new_pinctrl_state =3D cdev->pinctrl_state_default;
> > +
> > +       if (IS_ERR_OR_NULL(new_pinctrl_state))
> > +               return 0;
> > +
> > +       ret =3D pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
> > +       if (ret) {
> > +               netdev_err(cdev->net, "Failed to select pinctrl state %=
pE\n",
> > +                          ERR_PTR(ret));
> > +               goto err_wakeup_enable;
> > +       }
> > +
> >         return 0;
> > +
> > +err_wakeup_enable:
> > +       /* Revert wakeup enable */
> > +       device_set_wakeup_enable(cdev->dev, !wol_enable);
> > +
> > +       return ret;
> >  }
> >
> >  static const struct ethtool_ops m_can_ethtool_ops_coalescing =3D {
> > @@ -2340,6 +2362,44 @@ int m_can_class_get_clocks(struct m_can_classdev=
 *cdev)
> >  }
> >  EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
> >
> > +static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *c=
lass_dev)
> > +{
> > +       struct device *dev =3D class_dev->dev;
> > +       int ret;
> > +
> > +       class_dev->pinctrl =3D devm_pinctrl_get(dev);
> > +       if (IS_ERR(class_dev->pinctrl)) {
> > +               ret =3D PTR_ERR(class_dev->pinctrl);
> > +               class_dev->pinctrl =3D NULL;
> > +
> > +               if (ret =3D=3D -ENODEV)
> > +                       return 0;
> > +
> > +               return dev_err_probe(dev, ret, "Failed to get pinctrl\n=
");
> > +       }
> > +
> > +       class_dev->pinctrl_state_wakeup =3D
> > +               pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
> > +       if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
> > +               ret =3D PTR_ERR(class_dev->pinctrl_state_wakeup);
> > +               class_dev->pinctrl_state_wakeup =3D NULL;
> > +
> > +               if (ret =3D=3D -ENODEV)
> > +                       return 0;
> > +
> > +               return dev_err_probe(dev, ret, "Failed to lookup pinctr=
l wakeup state\n");
> > +       }
> > +
> > +       class_dev->pinctrl_state_default =3D
> > +               pinctrl_lookup_state(class_dev->pinctrl, "default");
> > +       if (IS_ERR(class_dev->pinctrl_state_default)) {
> > +               ret =3D PTR_ERR(class_dev->pinctrl_state_default);
>=20
> Sorry if this is a silly question, but why aren't you doing the:
>=20
>                   class_dev->pinctrl_state_default =3D NULL;
>=20
>                   if (ret =3D=3D -ENODEV)
>                           return 0;
>=20
> thing the same way you are doing it for the pinctrl and the
> pinctrl_state_wakeup?

There are no silly questions.
The idea is that if the wakeup pinctrl state was already found, then the
default pinctrl state is required and not optional, so no check for
-ENODEV. Otherwise it doesn't make sense with the current binding or the
implementation of the driver.

Best
Markus

>=20
> > +               return dev_err_probe(dev, ret, "Failed to lookup pinctr=
l default state\n");
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
> >                                                 int sizeof_priv)
> >  {
> > @@ -2380,7 +2440,15 @@ struct m_can_classdev *m_can_class_allocate_dev(=
struct device *dev,
> >
> >         m_can_of_parse_mram(class_dev, mram_config_vals);
> >
> > +       ret =3D m_can_class_setup_optional_pinctrl(class_dev);
> > +       if (ret)
> > +               goto err_free_candev;
> > +
> >         return class_dev;
> > +
> > +err_free_candev:
> > +       free_candev(net_dev);
> > +       return ERR_PTR(ret);
> >  }
> >  EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
> >
> > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_ca=
n.h
> > index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..b75b0dd6ccc93973d0891da=
ac07c92b61f81dc2a 100644
> > --- a/drivers/net/can/m_can/m_can.h
> > +++ b/drivers/net/can/m_can/m_can.h
> > @@ -126,6 +126,10 @@ struct m_can_classdev {
> >         struct mram_cfg mcfg[MRAM_CFG_NUM];
> >
> >         struct hrtimer hrtimer;
> > +
> > +       struct pinctrl *pinctrl;
> > +       struct pinctrl_state *pinctrl_state_default;
> > +       struct pinctrl_state *pinctrl_state_wakeup;
> >  };
> >
> >  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, in=
t sizeof_priv);

--y2xuvaaqr7j44mfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZw/cYQAKCRAkjLTi1BWu
P9CpAP4tX6a7M/kgJ8Ionz7a+AUZJWoKeQ03+ywDZeTLHS0NwwD/ZSQcEr8w5ZY4
HJ81DP3OYzHD87xDgszoGjzKdz/IsAU=
=25DM
-----END PGP SIGNATURE-----

--y2xuvaaqr7j44mfa--

