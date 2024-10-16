Return-Path: <linux-can+bounces-1710-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9F19A0C92
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 16:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BCFB219D1
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866520C027;
	Wed, 16 Oct 2024 14:26:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787920ADDA;
	Wed, 16 Oct 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088795; cv=none; b=mZWxJchGAV6tUH6/udX83KlWn2FCDfFIctpN0F6IBBXza9RDBSHlb0EWr+DCOe1TtMWWzX5XeCw8TFXJc5C3uXWFS/WyNyuxBnpTBSu2xQLHy0d3BGjuz4z2PRtPW9a+h/9iTvrUJEx++TyGQ1nYjCgKY1OZFGIdbT6x0r/cCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088795; c=relaxed/simple;
	bh=BTpTIYQMDBwzjByt2BCxD0+WshTPDmkDdWMziv5LqKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMN/ZcBw42f6vRYlIMyVXP116/+0K8bYOFkITHyLl6kXyEapzrmZzERIIKzgH3G5GuGCbB/KBV8jaG13/KmVfbTbOzzC2onOeuXwM7I6/jalDy7YKck1UDB23ICQinuxKFmkmv/VFqoz0IWvF9tKWEAnYy5KgRibyp/RC5dAmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0474e70eso568932366b.0;
        Wed, 16 Oct 2024 07:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088792; x=1729693592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kosQyuVWG39YynNEUKXJCBxsTPwg1HVhHQTa1Z8n7k=;
        b=pi4EIQkJqvhlSSI4WnScMkTcxna2yU4iBbiEsoIQ8LWyXz++j2xxyt08cQVUmTC0pu
         LX2oYqo38ZwgQ1NfXsRvrheYrLVcWzrY6v91poBnepI1O4Is6dYCmhpyXFaTDyhbMToq
         ZZIpwaQ2lmbYjbYa9YovmTwVnvKQVTdXCs4JiN4GnxiKOVusUbkSvCdNYn2BzB6tE17L
         yf0oy5I7O5lEs/+E0ziwgTNDgGNV/PMmpUOuyyzuXDcR5pL6uZHadScgKBFqzXyT6cqJ
         PTnELi6aIlYTjBDTxJk4HOCWUcbdJX85oKBvXh7TNN17QbCOUJAOAJKwXnHVjcpqmtiH
         8Mpw==
X-Forwarded-Encrypted: i=1; AJvYcCUM+SUdPcQ5xlhA9zFvqSC5ZbBSuJ81l1dGoPSNHHqLAztaNtt0Njc0yEyWR+5UpGu7KIqgOwyyppbpxahl@vger.kernel.org, AJvYcCV+m3439rIGQLhawzCEGRM5Ov3JPVZYjU+urI94bZyHSMXgZx18Ti0DMdPS0wbBuT3xYQrMtgdtgGsk@vger.kernel.org, AJvYcCWta3hkrRUgW6guxcJ4fbN1TKmqra/nagM/GWYazMmqpdOB3S8+eSnvKsVK3i1Sc+4X6ZeBCeQMAmL0@vger.kernel.org, AJvYcCX2g5lyaq6nXY0Lmy6tZFoWNhDekwr+6VHCG0b4N8r2YDarDL7ke/N9sQgro4UlNsJMwZWDNnam@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xuq5RZ3RmbYpFGXsQ7TZ/USrw/N4jYcflwGr2Fl/ZYnrCJ74
	oWuRtSgg3rg+UloZLd4nKaK7xVXtYENDHmIlI29ouXXvvv9vRxmpYzQO0UJ3zbzlT+vv/K6jSfD
	HiX761qgCLaiFbahsaXKElp5bW3fPdJ+yYSo=
X-Google-Smtp-Source: AGHT+IHxBPBf+m6UScPiP9T7rYboW+BUqS+rSedKKCFS0zaiDPv4D0O5W7BTwDQfrFhb1gdRSpU0fFSgNbjyzR/tOYY=
X-Received: by 2002:a17:906:6a1e:b0:a99:f2bf:7c64 with SMTP id
 a640c23a62f3a-a99f2bf8de2mr1100863466b.17.1729088791572; Wed, 16 Oct 2024
 07:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
 <20241015-topic-mcan-wakeup-source-v6-12-v4-5-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-5-fdac1d1e7aa6@baylibre.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 16 Oct 2024 23:26:22 +0900
Message-ID: <CAMZ6Rq+NA9G=iON56vQcr5dxEMqn-FFzT5rdxc6XrtW+4ww1XQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] can: m_can: Support pinctrl wakeup state
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

This is a nice improvement from the v3.

On Wed. 16 Oct. 2024 at 04:19, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
> am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> a wakeup source. Add support to select the wakeup state if WOL is
> enabled.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/m_can.c | 68 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/can/m_can/m_can.h |  4 +++
>  2 files changed, 72 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 5a4e0ad07e9ecc82de5f1f606707f3380d3679fc..c539375005f71c88fd1f7d1a885ce890ce0e9327 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2196,6 +2196,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>  static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>  {
>         struct m_can_classdev *cdev = netdev_priv(dev);
> +       struct pinctrl_state *new_pinctrl_state = NULL;
>         bool wol_enable = !!(wol->wolopts & WAKE_PHY);
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
> @@ -2340,6 +2362,44 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
>
> +static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *class_dev)
> +{
> +       struct device *dev = class_dev->dev;
> +       int ret;
> +
> +       class_dev->pinctrl = devm_pinctrl_get(dev);
> +       if (IS_ERR(class_dev->pinctrl)) {
> +               ret = PTR_ERR(class_dev->pinctrl);
> +               class_dev->pinctrl = NULL;
> +
> +               if (ret == -ENODEV)
> +                       return 0;
> +
> +               return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
> +       }
> +
> +       class_dev->pinctrl_state_wakeup =
> +               pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
> +       if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
> +               ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
> +               class_dev->pinctrl_state_wakeup = NULL;
> +
> +               if (ret == -ENODEV)
> +                       return 0;
> +
> +               return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
> +       }
> +
> +       class_dev->pinctrl_state_default =
> +               pinctrl_lookup_state(class_dev->pinctrl, "default");
> +       if (IS_ERR(class_dev->pinctrl_state_default)) {
> +               ret = PTR_ERR(class_dev->pinctrl_state_default);

Sorry if this is a silly question, but why aren't you doing the:

                  class_dev->pinctrl_state_default = NULL;

                  if (ret == -ENODEV)
                          return 0;

thing the same way you are doing it for the pinctrl and the
pinctrl_state_wakeup?

> +               return dev_err_probe(dev, ret, "Failed to lookup pinctrl default state\n");
> +       }
> +
> +       return 0;
> +}
> +
>  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>                                                 int sizeof_priv)
>  {
> @@ -2380,7 +2440,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>
>         m_can_of_parse_mram(class_dev, mram_config_vals);
>
> +       ret = m_can_class_setup_optional_pinctrl(class_dev);
> +       if (ret)
> +               goto err_free_candev;
> +
>         return class_dev;
> +
> +err_free_candev:
> +       free_candev(net_dev);
> +       return ERR_PTR(ret);
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

