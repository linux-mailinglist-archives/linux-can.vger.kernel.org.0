Return-Path: <linux-can+bounces-5098-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFFFBB481D
	for <lists+linux-can@lfdr.de>; Thu, 02 Oct 2025 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410F37B4C91
	for <lists+linux-can@lfdr.de>; Thu,  2 Oct 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C991261B9C;
	Thu,  2 Oct 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2LJGivk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE0259C94
	for <linux-can@vger.kernel.org>; Thu,  2 Oct 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421958; cv=none; b=ifbv9slE3ystdPcN7MbQCZO22PusVW8oEdTUjxgh3D2nJJpOJuxbVXEHJT73dvNy3Ja/2zipgpZ9QmJVLPiaT6h4Fn+mxLmuNJMFeDT54NdMrqkourz4NNzBQustGIjpdjsSK7hU/S0zbedYYdvAf5/Lm6mLLxdYpLoHYvo/sSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421958; c=relaxed/simple;
	bh=JsvUFrg6b+6lDk5XVXHpC85z+zVrdjy78d/YqQGfrHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kgrvi6amL0QaZYfGxanyCrSUFO6aLZVNexY+/6HaTRQ7N5WhCEQUpK0o0LKYgCUFYmrBjEtL3xo00ScxI2SzciFsAnH/GydPDMQvH5onfiTEJSPZDlpNXZH8ZRulGx1nyqUQdB+k/jlrXfo3dGbYp6uMhvDqsKobYXQ8YtxxV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2LJGivk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1240496a91.3
        for <linux-can@vger.kernel.org>; Thu, 02 Oct 2025 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421956; x=1760026756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsxj7YoiqGgfvPyXJFxW2Z8P+n52wRZ9xpiObgG4ULc=;
        b=N2LJGivkOnwAqSgqUaug/BFeKTGR/ufZvamXkBo/U7MZV0A44sQQHA00ihFNxv8jVN
         j2fXcKSUqiXOIl6nbdF58NUrhwE++etccKAt7anBYZp+RyBlHE861mvXV30N+SZdmNah
         m0eYGRaCjqtpbHLnzn5502Fdh8SjBMbHl7DwvlNrksLmabsOVGx7sWAjczXcS5QOt9eh
         ezBdlpIqdbOtzTcjRLT21+TG6eRmbhQ13y8M96ybYDYx1bWz0z50yXkLXKQJG+QEiFlL
         BMNi0TTPlrRpLlc+jD3L2tFaruQmJuc5WJDzTZOHJm91GBPhNmI3XoS7b2+q7M+Gml8g
         yrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421956; x=1760026756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsxj7YoiqGgfvPyXJFxW2Z8P+n52wRZ9xpiObgG4ULc=;
        b=t4WhacShxyBt9EvrbxvnKaiXkoQpFfaMHnRc4cwJslboM3/QyfW8MZ5Sb+El7QNw/O
         ejMKLksMZ2qirbsd/w6gg+arjkz1Iu+SZRch8Rk7TnMOnVmVHvZpE9ALlRwhTkkyXkHG
         YtMBipuq/mOA2uVzHGYkWweA6tk2ZSVPJYA0x3tN1HbPmwlkYcRFK3WJOqDcvgEPy7Gp
         baVPzaLm6kcqcJimvDOkh5QAZkP+r/8ClNw9WLEASrIQsrj67oUqK9hpfOk4cYQnhEUr
         mJtvXB0NP8nOdJ22MZwXJn8WnckGoHgFJqWAjDbQPdBtXnDg+Ne5q7+E4F8dbHNiyF0E
         Inmg==
X-Forwarded-Encrypted: i=1; AJvYcCWoN0vOg2PUCZq7hXgGD9z3S8yiqykUdELBMX8crclfq1a/gETCuLSM+yLObVvB4z8HzFEFXLUaJZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxuoy+0gmGApIQusAKFR7ofBwpsiYLz1CrJvMdsv+k+MdqUukK
	nwAKorERTysiw3aaI/bFBmH6U92Pa9Ls79gojjgWXiLK+TT6cl5mRfZFr9nAdDpNcn79IdLzDFU
	KgxpWz1C6gDDD6H4/l3XscJIgPQH3My4=
X-Gm-Gg: ASbGncves3J4qOXWaRFp8PsswlVNuJF9zZtaijF1rKKMT6wj+Mk2k0Dy8+jSITR0vE2
	lvBIEOfdFtM/zM4TsUccTbDR6CePjSul4NDDGhNG1S4rTO2fBD+TyXyjf81PL35YLSg4eDBsh3D
	EkMC650JNxYGURV8US++3jttDtWUhOfAHXvs8X8aG5CSJvVyoV+7qjtAvcVxPijrvgu2jboE4o0
	4o13zU15ZIKgkq6CRvfaYI0nvXQWPihoMdHbQGoxg==
X-Google-Smtp-Source: AGHT+IGGp117d+C4nGWCnd+e8rq+kUzsoIMiqTOEd1myMMBz03N8LD6xRLaicAUgmaalwvLRv0UG+Wa0FrJkVem0Kfg=
X-Received: by 2002:a17:90b:3b90:b0:330:604a:1009 with SMTP id
 98e67ed59e1d1-339a6f38562mr9750743a91.23.1759421955640; Thu, 02 Oct 2025
 09:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-can-v1-0-c075f702adea@nxp.com> <20250822-can-v1-3-c075f702adea@nxp.com>
In-Reply-To: <20250822-can-v1-3-c075f702adea@nxp.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:24:10 -0400
X-Gm-Features: AS18NWAvvuq0JYjwHcuYxgL_GvcWi5Rt-rN98_ZHunTTnePybtwPWJ4gpWP89Yw
Message-ID: <CALC8CXc3OAqY5XTN1XivSbSdki2ZcPKTqJfXruRiq=KWQPbR5w@mail.gmail.com>
Subject: Re: [PATCH 3/6] phy: phy-can-transceiver: Add dual channel support
 for TJA1048
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peng Fan.
Bet you once were of the tribe of the Wolf.
Pen Fang.

On Fri, Aug 22, 2025 at 12:07=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
>   has two channels.
> - Introduce can_transceiver_priv as a higher level encapsulation for
>   phy, mux_state, num_ch.
> - Alloc a phy for each channel
> - Support TJA1048 which is a dual high-speed CAN transceiver with
>   Sleep mode supported.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 117 +++++++++++++++++++++++++++-----=
------
>  1 file changed, 83 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index b49371a1272cd8a25b5e2271586b756103c64f0a..0e7b23073bfa8eae7200d30dc=
657a979f6cc9d86 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -17,13 +17,20 @@ struct can_transceiver_data {
>         u32 flags;
>  #define CAN_TRANSCEIVER_STB_PRESENT    BIT(0)
>  #define CAN_TRANSCEIVER_EN_PRESENT     BIT(1)
> +#define CAN_TRANSCEIVER_DUAL_CH                BIT(2)
>  };
>
>  struct can_transceiver_phy {
>         struct phy *generic_phy;
>         struct gpio_desc *standby_gpio;
>         struct gpio_desc *enable_gpio;
> +       struct can_transceiver_priv *priv;
> +};
> +
> +struct can_transceiver_priv {
> +       struct can_transceiver_phy *can_transceiver_phy;
>         struct mux_state *mux_state;
> +       int num_ch;
>  };
>
>  /* Power on function */
> @@ -32,8 +39,8 @@ static int can_transceiver_phy_power_on(struct phy *phy=
)
>         struct can_transceiver_phy *can_transceiver_phy =3D phy_get_drvda=
ta(phy);
>         int ret;
>
> -       if (can_transceiver_phy->mux_state) {
> -               ret =3D mux_state_select(can_transceiver_phy->mux_state);
> +       if (can_transceiver_phy->priv->mux_state) {
> +               ret =3D mux_state_select(can_transceiver_phy->priv->mux_s=
tate);
>                 if (ret) {
>                         dev_err(&phy->dev, "Failed to select CAN mux: %d\=
n", ret);
>                         return ret;
> @@ -56,8 +63,8 @@ static int can_transceiver_phy_power_off(struct phy *ph=
y)
>                 gpiod_set_value_cansleep(can_transceiver_phy->standby_gpi=
o, 1);
>         if (can_transceiver_phy->enable_gpio)
>                 gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio=
, 0);
> -       if (can_transceiver_phy->mux_state)
> -               mux_state_deselect(can_transceiver_phy->mux_state);
> +       if (can_transceiver_phy->priv->mux_state)
> +               mux_state_deselect(can_transceiver_phy->priv->mux_state);
>
>         return 0;
>  }
> @@ -76,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvd=
ata =3D {
>         .flags =3D CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESE=
NT,
>  };
>
> +static const struct can_transceiver_data tja1048_drvdata =3D {
> +       .flags =3D CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
> +};
> +
>  static const struct of_device_id can_transceiver_phy_ids[] =3D {
>         {
>                 .compatible =3D "ti,tcan1042",
> @@ -85,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_i=
ds[] =3D {
>                 .compatible =3D "ti,tcan1043",
>                 .data =3D &tcan1043_drvdata
>         },
> +       {
> +               .compatible =3D "nxp,tja1048",
> +               .data =3D &tja1048_drvdata
> +       },
>         {
>                 .compatible =3D "nxp,tja1051",
>                 .data =3D &tcan1043_drvdata
> @@ -107,11 +122,27 @@ devm_mux_state_get_optional(struct device *dev, con=
st char *mux_name)
>         return devm_mux_state_get(dev, mux_name);
>  }
>
> +static struct phy *can_transceiver_phy_xlate(struct device *dev, const s=
truct of_phandle_args *args)
> +{
> +       struct can_transceiver_priv *priv =3D dev_get_drvdata(dev);
> +       u32 idx;
> +
> +       if (priv->num_ch =3D=3D 1)
> +               return priv->can_transceiver_phy[0].generic_phy;
> +
> +       if (args->args_count !=3D 1)
> +               return ERR_PTR(-EINVAL);
> +
> +       idx =3D args->args[0];
> +
> +       return priv->can_transceiver_phy[idx].generic_phy;
> +}
> +
>  static int can_transceiver_phy_probe(struct platform_device *pdev)
>  {
>         struct phy_provider *phy_provider;
>         struct device *dev =3D &pdev->dev;
> -       struct can_transceiver_phy *can_transceiver_phy;
> +       struct can_transceiver_priv *priv;
>         const struct can_transceiver_data *drvdata;
>         const struct of_device_id *match;
>         struct phy *phy;
> @@ -119,52 +150,70 @@ static int can_transceiver_phy_probe(struct platfor=
m_device *pdev)
>         struct gpio_desc *enable_gpio;
>         struct mux_state *mux_state;
>         u32 max_bitrate =3D 0;
> -       int err;
> -
> -       can_transceiver_phy =3D devm_kzalloc(dev, sizeof(struct can_trans=
ceiver_phy), GFP_KERNEL);
> -       if (!can_transceiver_phy)
> -               return -ENOMEM;
> +       int num_ch =3D 1;
> +       int err, i;
>
>         match =3D of_match_node(can_transceiver_phy_ids, pdev->dev.of_nod=
e);
>         drvdata =3D match->data;
>
> +       priv =3D devm_kzalloc(dev, sizeof(struct can_transceiver_priv), G=
FP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
> +               num_ch =3D 2;
> +
> +       priv->num_ch =3D num_ch;
> +       priv->can_transceiver_phy =3D devm_kcalloc(dev, num_ch, sizeof(st=
ruct can_transceiver_phy),
> +                                                GFP_KERNEL);
> +       if (!priv->can_transceiver_phy)
> +               return -ENOMEM;
> +
>         mux_state =3D devm_mux_state_get_optional(dev, NULL);
>         if (IS_ERR(mux_state))
>                 return PTR_ERR(mux_state);
>
> -       can_transceiver_phy->mux_state =3D mux_state;
> -
> -       phy =3D devm_phy_create(dev, dev->of_node,
> -                             &can_transceiver_phy_ops);
> -       if (IS_ERR(phy)) {
> -               dev_err(dev, "failed to create can transceiver phy\n");
> -               return PTR_ERR(phy);
> -       }
> +       priv->mux_state =3D mux_state;
>
>         err =3D device_property_read_u32(dev, "max-bitrate", &max_bitrate=
);
>         if ((err !=3D -EINVAL) && !max_bitrate)
>                 dev_warn(dev, "Invalid value for transceiver max bitrate.=
 Ignoring bitrate limit\n");
> -       phy->attrs.max_link_rate =3D max_bitrate;
>
> -       can_transceiver_phy->generic_phy =3D phy;
> +       for (i =3D 0; i < num_ch; i++) {
> +               phy =3D devm_phy_create(dev, dev->of_node, &can_transceiv=
er_phy_ops);
> +               if (IS_ERR(phy)) {
> +                       dev_err(dev, "failed to create can transceiver ph=
y\n");
> +                       return PTR_ERR(phy);
> +               }
>
> -       if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
> -               standby_gpio =3D devm_gpiod_get_optional(dev, "standby", =
GPIOD_OUT_HIGH);
> -               if (IS_ERR(standby_gpio))
> -                       return PTR_ERR(standby_gpio);
> -               can_transceiver_phy->standby_gpio =3D standby_gpio;
> -       }
> +               phy->attrs.max_link_rate =3D max_bitrate;
>
> -       if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
> -               enable_gpio =3D devm_gpiod_get_optional(dev, "enable", GP=
IOD_OUT_LOW);
> -               if (IS_ERR(enable_gpio))
> -                       return PTR_ERR(enable_gpio);
> -               can_transceiver_phy->enable_gpio =3D enable_gpio;
> -       }
> +               priv->can_transceiver_phy[i].generic_phy =3D phy;
> +               priv->can_transceiver_phy[i].priv =3D priv;
> +
> +               if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
> +                       standby_gpio =3D devm_gpiod_get_index_optional(de=
v, "standby", i,
> +                                                                    GPIO=
D_OUT_HIGH);
> +                       if (IS_ERR(standby_gpio))
> +                               return PTR_ERR(standby_gpio);
> +                       priv->can_transceiver_phy[i].standby_gpio =3D sta=
ndby_gpio;
> +               }
> +
> +               if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
> +                       enable_gpio =3D devm_gpiod_get_index_optional(dev=
, "enable", i,
> +                                                                   GPIOD=
_OUT_LOW);
> +                       if (IS_ERR(enable_gpio))
> +                               return PTR_ERR(enable_gpio);
> +                       priv->can_transceiver_phy[i].enable_gpio =3D enab=
le_gpio;
> +               }
>
> -       phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver=
_phy);
> +               phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
> +                               &priv->can_transceiver_phy[i]);
> +       }
>
> -       phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple=
_xlate);
> +       phy_provider =3D devm_of_phy_provider_register(dev, can_transceiv=
er_phy_xlate);
>
>         return PTR_ERR_OR_ZERO(phy_provider);
>  }
>
> --
> 2.37.1
>
>

