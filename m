Return-Path: <linux-can+bounces-2023-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C79C8241
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 05:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93F1284CDE
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 04:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C231E8826;
	Thu, 14 Nov 2024 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EOFOgcL8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BF1553AA;
	Thu, 14 Nov 2024 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731560103; cv=none; b=WySvPPeX678nWIV7YF7xyjbYvtWAgq2MAUDGuTOm7dotQJs3AhCm4/w/+PYxmizQERNVbW0PDA6wTWdbkQsynNO31NJyUYxwSG27VYqjz3i/BsTWmVKVRcCOTHqi9/l5sgiVygdMVku05OlGV/ecs9KteQSuYZp5praDS+IoEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731560103; c=relaxed/simple;
	bh=o/5emXLfx9w6iWylWGCKAI4AJ2vE+YqEyXCPtzvueeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0nXcBeKrLYTy3Qsa9luXCfe+/7yamsHJnUuLKeerY4UDsHp1B4dMhQJm3jb8HwRtdi7Sri4a2Hz2c9wFFJvd+1MYUb6fv7O2INCqqaFsCyvBgUgtOS+abtxaaKhpb8Ln6IcNrLfSc4h947G/pyCbwXm+A7A5HSBRifFj95hUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EOFOgcL8; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by smtp.orange.fr with ESMTPSA
	id BRrVt6lmrmvx4BRrVt9AwL; Thu, 14 Nov 2024 05:53:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731560025;
	bh=1EDa0vg4ZBXnx63Iz6EA6oPRRRo42Elpu8PdgGbLErU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=EOFOgcL80OMUStwlt1/cSXRToGXQWb7t2ydd73hhXtbKz1asFu5olRod6MPs4aVtm
	 zTs9FLZYzoHox0xuodbWWFIIC3S08LgpEzoYYtkLgrctF6Ryo81cl2hG8R8kbKHbn3
	 VCyksgenrLkKRAF3zZSRad49MKoJMwCJeTKJYJpVkscjTkBJ0t+owvKXPh5AqVYAnY
	 CQdlNk2JNtx0dX8orq4s1fDqOdTwbsnoEOx6GIpy7iiQ3e+9wajU6sitlE83+5fZrf
	 wHFWEmqsiF0tsvgjm+dmvyJmEQzrhgmqLcN18RmH+HQmQOuXUfQ+0+8mGoko2mcpx0
	 F6alpS1vgw0ug==
X-ME-Helo: mail-ej1-f44.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 05:53:45 +0100
X-ME-IP: 209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a850270e2so31057066b.0;
        Wed, 13 Nov 2024 20:53:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHt7zHxQwAk3Az9wWMG+6/mDLIlSclNLegYtPkyGOiJqrvKQWZ9qKS0R9XkaQDl4v0EoHk1Brp@vger.kernel.org, AJvYcCVYVQQlv52vZeGSPF4IYJiPqkLtRu+xgdgRt4entCMzYVoU1vNc+xMTXEdlNv3NuZLRqWhMrPwyPvaS@vger.kernel.org, AJvYcCW0h7AfTQASSqOuLzVAH5MZSUAiWMaEvWLgjK2WBGFNJ78XX1fWrkqmX7ckKz3uaO+H632jYzw94WbW@vger.kernel.org, AJvYcCXBMHa8+S+LbneygsNLfeEAVYdGr56cNiB6N7naIx1EhyC9bSL5bLYH9VavngBdaq/tXfRjTbTigy2R0Bhu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8pxJwxcHFZLV7HTB/YXUAEj2+evs5ru2x3zdZxbP6FhboMih
	jWb2ypR1+Nkur0mQqjAe8JRLn2DpVb//o0cwCyVyHBGeH438TuSJrfrYH6xTDCH/X4iSvBHn4nw
	Ps3SXQYfodx+AJEyCvfb1oU/PzPA=
X-Google-Smtp-Source: AGHT+IESI/Fks52+BoNd/GzjvshhIgxdlgulbfGGZFgoEKu8CbVbivjecQTI3En+lKEI4jB/Yi3PiBNAvLfDB2XRils=
X-Received: by 2002:a17:907:7fa9:b0:aa2:c79:c940 with SMTP id
 a640c23a62f3a-aa20ccdb8b4mr63959766b.1.1731560024972; Wed, 13 Nov 2024
 20:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com> <20241111-tcan-wkrqv-v2-1-9763519b5252@geanix.com>
In-Reply-To: <20241111-tcan-wkrqv-v2-1-9763519b5252@geanix.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 14 Nov 2024 13:53:34 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq++_yecNY-nNL7NK48ZsNPqH0KDRuqvCCGhUur24+7KGA@mail.gmail.com>
Message-ID: <CAMZ6Rq++_yecNY-nNL7NK48ZsNPqH0KDRuqvCCGhUur24+7KGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: tcan4x5x: add option for selecting nWKRQ voltage
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon. 11 Nov. 2024 at 17:55, Sean Nyekjaer <sean@geanix.com> wrote:
> nWKRQ supports an output voltage of either the internal reference voltage
> (3.6V) or the reference voltage of the digital interface 0 - 6V.
> Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> between them.
> Default is kept as the internal reference voltage.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..264bba830be50033347056da994102f8b614e51b 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -92,6 +92,8 @@
>  #define TCAN4X5X_MODE_STANDBY BIT(6)
>  #define TCAN4X5X_MODE_NORMAL BIT(7)
>
> +#define TCAN4X5X_NWKRQ_VOLTAGE_MASK BIT(19)
> +
>  #define TCAN4X5X_DISABLE_WAKE_MSK      (BIT(31) | BIT(30))
>  #define TCAN4X5X_DISABLE_INH_MSK       BIT(9)
>
> @@ -267,6 +269,11 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
>         if (ret)
>                 return ret;
>
> +       ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +                                TCAN4X5X_NWKRQ_VOLTAGE_MASK, tcan4x5x->nwkrq_voltage);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
>
> @@ -318,6 +325,28 @@ static const struct tcan4x5x_version_info
>         return &tcan4x5x_versions[TCAN4X5X];
>  }
>
> +static int tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> +{
> +       struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
> +       struct device_node *np = cdev->dev->of_node;
> +       u8 prop;
> +       int ret;
> +
> +       ret = of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
> +       if (!ret) {
> +               if (prop <= 1)
> +                       tcan4x5x->nwkrq_voltage = prop;
> +               else
> +                       dev_warn(cdev->dev,
> +                                "nwkrq-voltage-sel have invalid option: %u\n",
> +                                prop);
> +       } else {
> +               tcan4x5x->nwkrq_voltage = 0;
> +       }

If the

  if (prop <= 1)

condition fails, you print a warning, but you are not assigning a
value to tcan4x5x->nwkrq_voltage. Is this intentional?

What about:

        tcan4x5x->nwkrq_voltage = 0;
        ret = of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
        if (!ret) {
                if (prop <= 1)
                        tcan4x5x->nwkrq_voltage = prop;
                else
                        dev_warn(cdev->dev,
                                 "nwkrq-voltage-sel have invalid option: %u\n",
                                 prop);
        }

so that you make sure that tcan4x5x->nwkrq_voltage always gets a
default zero value? Else, if you can make sure that tcan4x5x is always
zero initialized, you can just drop the

        tcan4x5x->nwkrq_voltage = 0;

thing.

> +       return 0;
> +}
> +
>  static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
>                               const struct tcan4x5x_version_info *version_info)
>  {
> @@ -453,6 +482,12 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>                 goto out_power;
>         }
>
> +       ret = tcan4x5x_get_dt_data(mcan_class);
> +       if (ret) {
> +               dev_err(&spi->dev, "Getting dt data failed %pe\n", ERR_PTR(ret));
> +               goto out_power;
> +       }
> +
>         tcan4x5x_check_wake(priv);
>
>         ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
> diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
> index e62c030d3e1e5a713c997e7c8ecad4a44aff4e6a..04ebe5c64f4f7056a62e72e717cb85dd3817ab9c 100644
> --- a/drivers/net/can/m_can/tcan4x5x.h
> +++ b/drivers/net/can/m_can/tcan4x5x.h
> @@ -42,6 +42,8 @@ struct tcan4x5x_priv {
>
>         struct tcan4x5x_map_buf map_buf_rx;
>         struct tcan4x5x_map_buf map_buf_tx;
> +
> +       u8 nwkrq_voltage;
>  };
>
>  static inline void
>
> --
> 2.46.2
>
>

