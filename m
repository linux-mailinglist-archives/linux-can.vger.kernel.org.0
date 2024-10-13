Return-Path: <linux-can+bounces-1642-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D926299B95D
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 14:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B42281B1B
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4F13FD83;
	Sun, 13 Oct 2024 12:27:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F917557;
	Sun, 13 Oct 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728822443; cv=none; b=aFw8KmvGX+/YY4Ysh6bMC2h2iTn97ouqc/v7V4sEyIBkQ4oIdeTamxdQbmE1YHjrkIF+X7zCUpnHTl7ZcO+75nJfaDVDg7E+M+jAIedtHSXIqAIjdEiM9TAzIpwyiUU5O3aTjFsxLdInPUcX49qJsRsUCfMOR0EgzbWGXCYoeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728822443; c=relaxed/simple;
	bh=x+zD/WYcDujMc/h7FRMCogzgYeBnbJg2d03lynWdtgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wpk9jmh6JVPONscc+P6Z0rm93USAqaljMSl/BGxHpN14EOXqyuBYkB+xqkQ9uo537Fo6ck1io2Kdv0nFaX2qVkHPf7CVD1nTCCaA03ZbcOUFhbGtLfWLFvArbS2A/px9vc6reU3t0hAWAUXTIamNsGYYBB4CEh+iGrMbO6jU8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99d1b7b5f5so213629666b.0;
        Sun, 13 Oct 2024 05:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728822440; x=1729427240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nqPQ/97DF1bREfwdAtltLcX9nQAeWtcp/CbuNd+/QM=;
        b=SfEmIOdmPbvvZ5lzYBIsj/+SNaDe00NZsXwV1Gn1frBTe+0vKowfp7NwsKZQhg0wjh
         yK9KQnUoDXBm/QP8mI/Zxc4737bvHwkQ9LiWvkJydS6e07cMIVXtmSwIxJ+RZ2LcqrhX
         y0N4BsQ1+IGj6CG18pKU94vLDLmhdAE5bSvGkdSbgL68UBBZRpqMN9EhLdmVmc2956J/
         jQhUjX65mPtBYohCKtGAHwq+hk3Q35B2GHced7u/IAcApSF0L+NiX5wcHVgGOgi/00Y1
         4r9JiYhFDUAaHH0+K6ah7p2Chlp/cTQgdW/v9VBD+N9q83jH6kRqwL5ukQqp1CcR+Zi1
         hAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUAPfnhP7fs0+FBto3UbpIjFjPgga4ZW76+PhQ6smmWRauR8bQl4pO+qusRFEvS99ELnLdRgi49EfUtTe+n@vger.kernel.org, AJvYcCUtKXxZbi9eUz9eDUIXZLwGzRSbDpDF32FooaHtVzOLjlJvengyUOq0/xj4XopG9hvnfhi6xZo4aVk/@vger.kernel.org, AJvYcCXgj3THBT5JHsoHZij4t4RlRVXu7S5HEPHmjAE7AZM2NemMu8s57Tt7tje5jN1zLv2rnstscB9PLkBg@vger.kernel.org, AJvYcCXnCjvFMq8+aIQAf8viNZ4MqfFlA8crJr52mWlCxttoWgBwfSKaPPPLSJgel5pKMhfHhdPzbXfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmpvw2LqrUBT/J3EJ0dJ5aLLrVuDkGXEX7ISnSScFAK1V0iW+c
	R8uY+pxd+pOuTs/annTB8zgm8P6DTuZxUZptNTvCborrsF6nZNnuZ9E5HTRONOIZVTA0/Nn3inM
	ZBc+r7P30SGZhxhfl2/SV68VCPNo=
X-Google-Smtp-Source: AGHT+IE754OHLLyEwBGVVzUzEsdRf+5N0gtrhvThoWd0nAPGAGbe+oFUCbDzx5kkkkXTooEYlfGRCVrgnjgT3yIEBYw=
X-Received: by 2002:a17:907:9610:b0:a99:90b6:1b10 with SMTP id
 a640c23a62f3a-a99b8eea8bcmr802951666b.0.1728822439530; Sun, 13 Oct 2024
 05:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-5-9752c714ad12@baylibre.com>
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-5-9752c714ad12@baylibre.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 13 Oct 2024 21:27:08 +0900
Message-ID: <CAMZ6Rq+E-0jdPHTwB0z0XKkz+UqhQVqT6ghPF21WFF0ZWc3-HA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] can: m_can: Support pinctrl wakeup state
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Fri. 11 Oct. 2024 at 22:19, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
> am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> a wakeup source. Add support to select the wakeup state if WOL is
> enabled.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/m_can.c | 60 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/can/m_can/m_can.h |  4 +++
>  2 files changed, 64 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 5ab0bb3f1c71e7dc4d6144f7b9e8f58d0e0303fe..c56d61b0d20b05be36c95ec4a6651b0457883b66 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2196,6 +2196,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>  static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>  {
>         struct m_can_classdev *cdev = netdev_priv(dev);
> +       struct pinctrl_state *new_pinctrl_state = NULL;
>         bool wol_enable = !!wol->wolopts & WAKE_PHY;
>         int ret;
>
> @@ -2212,7 +2213,28 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>                 return ret;
>         }
>
> +       if (wol_enable)
> +               new_pinctrl_state = cdev->pinctrl_state_wakeup;
> +       else
> +               new_pinctrl_state = cdev->pinctrl_state_default;
> +
> +       if (IS_ERR_OR_NULL(new_pinctrl_state))
> +               return 0;
> +
> +       ret = pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
> +       if (ret) {
> +               netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
> +                          ERR_PTR(ret));
> +               goto err_wakeup_enable;
> +       }
> +
>         return 0;
> +
> +err_wakeup_enable:
> +       /* Revert wakeup enable */
> +       device_set_wakeup_enable(cdev->dev, !wol_enable);
> +
> +       return ret;
>  }
>
>  static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
> @@ -2380,7 +2402,45 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>
>         m_can_of_parse_mram(class_dev, mram_config_vals);
>
> +       class_dev->pinctrl = devm_pinctrl_get(dev);
> +       if (IS_ERR(class_dev->pinctrl)) {
> +               ret = PTR_ERR(class_dev->pinctrl);
> +
> +               if (ret != -ENODEV) {
> +                       dev_err_probe(dev, ret, "Failed to get pinctrl\n");
> +                       goto err_free_candev;
> +               }
> +
> +               class_dev->pinctrl = NULL;
> +       } else {
> +               class_dev->pinctrl_state_wakeup =
> +                       pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
> +               if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
> +                       ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
> +                       ret = -EIO;

Here, ret is set twice, and the second time, it is unconditionally set
to -EIO...

> +                       if (ret != -ENODEV) {

... so isn't this check always true?

> +                               dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
> +                               goto err_free_candev;
> +                       }
> +
> +                       class_dev->pinctrl_state_wakeup = NULL;
> +               } else {
> +                       class_dev->pinctrl_state_default =
> +                               pinctrl_lookup_state(class_dev->pinctrl, "default");
> +                       if (IS_ERR(class_dev->pinctrl_state_default)) {
> +                               ret = PTR_ERR(class_dev->pinctrl_state_default);
> +                               dev_err_probe(dev, ret, "Failed to lookup pinctrl default state\n");
> +                               goto err_free_candev;
> +                       }
> +               }
> +       }
> +
>         return class_dev;
> +
> +err_free_candev:
> +       free_candev(net_dev);
> +       return ERR_PTR(ret);

Here, you have three levels of nested if/else. It took me a bit of
effort to read and understand the logic. Wouldn't it be better to do
some early return at the end of each of the if branches in order to
remove the nesting? I am thinking of this:

          class_dev->pinctrl = devm_pinctrl_get(dev);
          if (IS_ERR(class_dev->pinctrl)) {
                  ret = PTR_ERR(class_dev->pinctrl);

                  if (ret != -ENODEV) {
                          dev_err_probe(dev, ret, "Failed to get pinctrl\n");
                          goto err_free_candev;
                  }

                  class_dev->pinctrl = NULL;
                  return class_dev;
          }

          class_dev->pinctrl_state_wakeup =
pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
          if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
                  ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
                  dev_err_probe(dev, ret, "Failed to lookup pinctrl
wakeup state\n");
                  goto err_free_candev;
          }

          class_dev->pinctrl_state_default =
pinctrl_lookup_state(class_dev->pinctrl, "default");
          if (IS_ERR(class_dev->pinctrl_state_default)) {
                  ret = PTR_ERR(class_dev->pinctrl_state_default);
                  dev_err_probe(dev, ret, "Failed to lookup pinctrl
default state\n");
                  goto err_free_candev;
          }

          return class_dev;

  err_free_candev:
          free_candev(net_dev);
          return ERR_PTR(ret);

>  }
>  EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
>
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..b75b0dd6ccc93973d0891daac07c92b61f81dc2a 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -126,6 +126,10 @@ struct m_can_classdev {
>         struct mram_cfg mcfg[MRAM_CFG_NUM];
>
>         struct hrtimer hrtimer;
> +
> +       struct pinctrl *pinctrl;
> +       struct pinctrl_state *pinctrl_state_default;
> +       struct pinctrl_state *pinctrl_state_wakeup;
>  };
>
>  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
>
> --
> 2.45.2
>
>

