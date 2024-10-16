Return-Path: <linux-can+bounces-1711-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266259A0CB8
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694E2B2712E
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E2120B1EA;
	Wed, 16 Oct 2024 14:32:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D2209F59;
	Wed, 16 Oct 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089140; cv=none; b=eum6IIF90iIbE1JI5GFLHPPBKrkP3srSIf6G2XrvZD2IBB0rA2e0QYZqbsGyOpCSk0uV1RKBXG4s7cC1ew1z4AkbMbQ6sSe9bYsUkqCMj9uQ8tgL4Fox5VQeqQmd5TEByaxxX58Fy+TTOkgTkmDSvcqbnAs0/UMPyMzrM7InkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089140; c=relaxed/simple;
	bh=cL6/iEITEkqI1kGR9ikJ0rjtp3Ih/i+CjMVOEFFmh4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNiV83DIAh25bG43ufByw04Ovz9DiYz1QoGwNWoMiD+Yv9iyyU85UAMKdB9doV4Jy0OzzqR+QpgL3vtRT5ftxxVA+h6VxvunNoVWk0xzSyGzdaW9cg9BySRItlE0+eue6jPLDjgBZYz+IsVvYXOUGzoZsvTRYm3Wv8Cti56dHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso467865966b.1;
        Wed, 16 Oct 2024 07:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729089136; x=1729693936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSNiWdoyjPld1XydLnGWhx59ZAvesHEXD9q6WahTtD8=;
        b=rE7/0CAcBj0oFHOpPX/8Iyg7ukpQMun1EgnSmyPyLt7f3hqy+MaFZFfd7H8hj9GGJo
         Nd8yZE7PHISk5sGvqu7NnQLU1xkz2zP9kUQdZaEuMuOQhT5FumezwTagUZeI1mhA/Hn+
         i9Ag24AOhwwVFHFNjM+PBUGqR4AQ+9alRcl0pEuyqg0BmAM3m6fxiwunlwu+wZVH3kPz
         1vi4ZGZBtWK1dB2md5Zl0bvXaAt1rl1nYp8ylq60XNqc1znq7YdxPfJqkLSvqYqMh4ru
         7xwmUeLW8fnBapguqkFZ9yl2AhydDFNdtGCKkpuj3vDDHF4XksSs6dloFMHyufhHSNk3
         cutA==
X-Forwarded-Encrypted: i=1; AJvYcCUhqbT4UQ6ooaZyNpk6zWdIqbbiO6zpLGiERbWYu7kBNk5VA9MrDl/JGHEShnikJyB1zuvAIPWBWqBQEW8l@vger.kernel.org, AJvYcCV9WERxtx59g65J8syNoE/wx128gdFlO2yvvbmiAgtrG+0D364d60PLq4BOs8DUI+JoF4QKqv3OHmYj@vger.kernel.org, AJvYcCX35nH5DsJcLOP5GmaqM/Vtu27zw96QYr6t/Iq+lRb4DS5s03bIVFW11eYAhLHr2DL2ePAWjZKohaTL@vger.kernel.org, AJvYcCX7N22Ie9F2twII6Zcib54WpSmkI6qbL5uATbdinkQxM+P3Y6Q24/sDdZfWFEp0FmTtjyCfYenY@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfWYS3Cxh+G7cRrKBNhJvqNjLNvNfB3SOKFASumwJbMPF9kgT
	5nxh/fQNWVVNDBUmi0fBu7dfBy5a1rOuf/6FTOMPhuPt3a+B0IaTWyKgQYa8WkFWOzXYGFCk7+/
	2xjnDRrFUuOT3Oe3GnLTxMA7t4G8=
X-Google-Smtp-Source: AGHT+IHIRvEp4YvtVQ1ixCe8NKzoxNPRFn5DlgVaLXK5XyUINKKI62mZa6ua3k/lIFZaBGu7y/WSpqnDGSIiREWEh6c=
X-Received: by 2002:a17:907:d85f:b0:a99:4025:82e1 with SMTP id
 a640c23a62f3a-a9a34dfd1fbmr318914166b.41.1729089136043; Wed, 16 Oct 2024
 07:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
 <20241015-topic-mcan-wakeup-source-v6-12-v4-3-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-3-fdac1d1e7aa6@baylibre.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 16 Oct 2024 23:32:06 +0900
Message-ID: <CAMZ6RqJfBbFRaynjFAbi5quAvcA1bYj7Dw_vJ7rDsLRaEheZrw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] can: m_can: Map WoL to device_set_wakeup_enable
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

On Wed. 16 Oct. 2024 at 04:18, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
> In some devices the pins of the m_can module can act as a wakeup source.
> This patch helps do that by connecting the PHY_WAKE WoL option to
> device_set_wakeup_enable. By marking this device as being wakeup
> enabled, this setting can be used by platform code to decide which
> sleep or poweroff mode to use.
>
> Also this prepares the driver for the next patch in which the pinctrl
> settings are changed depending on the desired wakeup source.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

I left a nitpick below. Regardless:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
>  drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a978b960f1f1e1e8273216ff330ab789d0fd6d51..d427645a5b3baf7d0a648e3b008d7d7de7f23374 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2185,6 +2185,36 @@ static int m_can_set_coalesce(struct net_device *dev,
>         return 0;
>  }
>
> +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> +{
> +       struct m_can_classdev *cdev = netdev_priv(dev);
> +
> +       wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +       wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +}
> +
> +static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> +{
> +       struct m_can_classdev *cdev = netdev_priv(dev);
> +       bool wol_enable = !!(wol->wolopts & WAKE_PHY);
> +       int ret;
> +
> +       if ((wol->wolopts & WAKE_PHY) != wol->wolopts)

Here, you want to check if a bit other than WAKE_PHY is set, isn't it?
What about doing this:

          if (wol->wolopts & ~WAKE_PHY)

instead?

> +               return -EINVAL;
> +
> +       if (wol_enable == device_may_wakeup(cdev->dev))
> +               return 0;
> +
> +       ret = device_set_wakeup_enable(cdev->dev, wol_enable);
> +       if (ret) {
> +               netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
> +                          ERR_PTR(ret));
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
>         .supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
>                 ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
> @@ -2194,10 +2224,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
>         .get_ts_info = ethtool_op_get_ts_info,
>         .get_coalesce = m_can_get_coalesce,
>         .set_coalesce = m_can_set_coalesce,
> +       .get_wol = m_can_get_wol,
> +       .set_wol = m_can_set_wol,
>  };
>
>  static const struct ethtool_ops m_can_ethtool_ops = {
>         .get_ts_info = ethtool_op_get_ts_info,
> +       .get_wol = m_can_get_wol,
> +       .set_wol = m_can_set_wol,
>  };
>
>  static int register_m_can_dev(struct m_can_classdev *cdev)
> @@ -2324,6 +2358,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>                 goto out;
>         }
>
> +       if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> +               device_set_wakeup_capable(dev, true);
> +
>         /* Get TX FIFO size
>          * Defines the total amount of echo buffers for loopback
>          */
>
> --
> 2.45.2
>
>

