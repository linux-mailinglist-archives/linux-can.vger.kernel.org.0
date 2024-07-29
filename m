Return-Path: <linux-can+bounces-1034-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAD093F0C6
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCCF2811DB
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DF813CF82;
	Mon, 29 Jul 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="o9fPmLMB"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6113C9A2;
	Mon, 29 Jul 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244606; cv=none; b=gcJbUIpr3ARBAR9Y7qMRfNxyiE6gVTphxd08O35AxfLiXPHwelirCcqN1Z+dkYBdjj9hHsR4u2coAQrWNxQWvlAs9KXLN7/UTnz1i8iE8/1GsU5LD4cqU1/dbexpHq/6JXt16F91T0ORb1RkiIyWEzpwLHSwA+qMIbdbWIVeyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244606; c=relaxed/simple;
	bh=vCO3rsz4c96FQBi8lBkTzWSFhuPoohJEICqV05nVnqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UV5RObZvMZAy+7Sa3I8Rn6CD0Of3hYvCih4zXwforM4z8qW3OnAarMRmkEgMWk92TZRWhkaQIk0oIa6T2ynOGDSHFOY4+aF7Dk2q4pcZD8Rrg+8pimBbzAizRprfUQdmYzTGk6JzPGxWunrPc7m8yER7rwnUiTCc5WWVjRygdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=o9fPmLMB; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JMXOgVywNt8Njq2iXfRLDs6RYuucGTU1xDoulcabn5o=; b=o9fPmLMB75Q6LfZsEVtMgFgTZZ
	DR8IDwsG3Yor5M89f2NXxUp0fcT7DJnNuXRIpn9czqWNisB2PeO44h5u1XvYuJMuo7gjnKhdyUdgz
	lpn8rLaDIJuZrj1Z5CgCu8Bl+Kt99Shwd+vKPyLFNIRyFSwUufG56p1oC3I72bYIolAGe7bzOmfzT
	ULVMZxrlVPXAynNEFx/iXKx5JmSAynUDiKX/64lrgvg6ZulqqZDIOCXbJCNW4fdLZ+mmi04DRA2oB
	/gLTMae6z0gEwwuHWS0DiwdbPRKlvuQZQRa8SiKdVlUzMXzl+yHT3/kj47YJ2TgtLjQiVOczdZUmT
	u4BDqJag==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1sYM6H-000OTm-2F; Mon, 29 Jul 2024 10:51:25 +0200
Received: from [185.17.218.86] (helo=[192.168.64.76])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1sYM6G-000Iz2-0W;
	Mon, 29 Jul 2024 10:51:24 +0200
Message-ID: <8dc30044f36a451766d2332f2869dce9d5e6f333.camel@geanix.com>
Subject: Re: [PATCH v2 4/7] can: m_can: Support pinctrl wakeup state
From: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Chandrasekar Ramakrishnan
 <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Conor Dooley <conor@kernel.org>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
Date: Mon, 29 Jul 2024 10:51:23 +0200
In-Reply-To: <20240729074135.3850634-5-msp@baylibre.com>
References: <20240729074135.3850634-1-msp@baylibre.com>
	 <20240729074135.3850634-5-msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27350/Sun Jul 28 10:25:11 2024)

Hi Markus,

On Mon, 2024-07-29 at 09:41 +0200, Markus Schneider-Pargmann wrote:
> am62 requires a wakeup flag being set in pinctrl when mcan pins acts
> as
> a wakeup source. Add support to select the wakeup state if WOL is
> enabled.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> =C2=A0drivers/net/can/m_can/m_can.c | 57
> +++++++++++++++++++++++++++++++++++
> =C2=A0drivers/net/can/m_can/m_can.h |=C2=A0 4 +++
> =C2=A02 files changed, 61 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c
> b/drivers/net/can/m_can/m_can.c
> index 5b80a7d1f9a1..b71e7f8e9727 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2193,6 +2193,7 @@ static void m_can_get_wol(struct net_device
> *dev, struct ethtool_wolinfo *wol)
> =C2=A0static int m_can_set_wol(struct net_device *dev, struct
> ethtool_wolinfo *wol)
> =C2=A0{
> =C2=A0	struct m_can_classdev *cdev =3D netdev_priv(dev);
> +	struct pinctrl_state *new_pinctrl_state =3D NULL;
> =C2=A0	bool wol_enable =3D !!wol->wolopts & WAKE_PHY;
> =C2=A0	int ret;
> =C2=A0
> @@ -2209,7 +2210,27 @@ static int m_can_set_wol(struct net_device
> *dev, struct ethtool_wolinfo *wol)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (wol_enable)
> +		new_pinctrl_state =3D cdev->pinctrl_state_wakeup;
> +	else
> +		new_pinctrl_state =3D cdev->pinctrl_state_default;
> +
> +	if (!IS_ERR_OR_NULL(new_pinctrl_state)) {

Why not do

	if (IS_ERR_OR_NULL(new_pinctrl_state))
		return 0;

?

// Martin

> +		ret =3D pinctrl_select_state(cdev->pinctrl,
> new_pinctrl_state);
> +		if (ret) {
> +			netdev_err(cdev->net, "Failed to select
> pinctrl state %pE\n",
> +				=C2=A0=C2=A0 ERR_PTR(ret));
> +			goto err_wakeup_enable;
> +		}
> +	}
> +
> =C2=A0	return 0;
> +
> +err_wakeup_enable:
> +	/* Revert wakeup enable */
> +	device_set_wakeup_enable(cdev->dev, !wol_enable);
> +
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct ethtool_ops m_can_ethtool_ops_coalescing =3D {
> @@ -2377,7 +2398,43 @@ struct m_can_classdev
> *m_can_class_allocate_dev(struct device *dev,
> =C2=A0
> =C2=A0	m_can_of_parse_mram(class_dev, mram_config_vals);
> =C2=A0
> +	class_dev->pinctrl =3D devm_pinctrl_get(dev);
> +	if (IS_ERR(class_dev->pinctrl)) {
> +		ret =3D PTR_ERR(class_dev->pinctrl);
> +
> +		if (ret !=3D -ENODEV) {
> +			dev_err_probe(dev, ret, "Failed to get
> pinctrl\n");
> +			goto err_free_candev;
> +		}
> +
> +		class_dev->pinctrl =3D NULL;
> +	} else {
> +		class_dev->pinctrl_state_wakeup =3D
> pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
> +		if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
> +			ret =3D PTR_ERR(class_dev-
> >pinctrl_state_wakeup);
> +			ret =3D -EIO;
> +
> +			if (ret !=3D -ENODEV) {
> +				dev_err_probe(dev, ret, "Failed to
> lookup pinctrl wakeup state\n");
> +				goto err_free_candev;
> +			}
> +
> +			class_dev->pinctrl_state_wakeup =3D NULL;
> +		} else {
> +			class_dev->pinctrl_state_default =3D
> pinctrl_lookup_state(class_dev->pinctrl, "default");
> +			if (IS_ERR(class_dev-
> >pinctrl_state_default)) {
> +				ret =3D PTR_ERR(class_dev-
> >pinctrl_state_default);
> +				dev_err_probe(dev, ret, "Failed to
> lookup pinctrl default state\n");
> +				goto err_free_candev;
> +			}
> +		}
> +	}
> +
> =C2=A0	return class_dev;
> +
> +err_free_candev:
> +	free_candev(net_dev);
> +	return ERR_PTR(ret);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
> =C2=A0
> diff --git a/drivers/net/can/m_can/m_can.h
> b/drivers/net/can/m_can/m_can.h
> index 92b2bd8628e6..b75b0dd6ccc9 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -126,6 +126,10 @@ struct m_can_classdev {
> =C2=A0	struct mram_cfg mcfg[MRAM_CFG_NUM];
> =C2=A0
> =C2=A0	struct hrtimer hrtimer;
> +
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_state_default;
> +	struct pinctrl_state *pinctrl_state_wakeup;
> =C2=A0};
> =C2=A0
> =C2=A0struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
> int sizeof_priv);


