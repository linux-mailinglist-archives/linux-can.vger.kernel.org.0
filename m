Return-Path: <linux-can+bounces-5327-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF34C45693
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 09:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BB124E8972
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA64A2F6937;
	Mon, 10 Nov 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlcVhNfb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754492F549D
	for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764330; cv=none; b=Mu5t5nJoJsx86u99aISFq0FJz4T+CkeecsfnQ/a+ndjpXs3DlDshqOsFibdERGMqkCjBOTHoNEnHxYIJvHnmr+5RaYE4+kw/+HOX8rYvr/ao8wo51JUGVR+8Kg8BstIJ5TZtsRZB//iVM8jEmXdFolKUgG9ifP/c4Gtfq6jN5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764330; c=relaxed/simple;
	bh=zqKdTXLiwN0fcb7WkcsKTjqpng93a7VC/tOEh4dTlmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEpIHyeVxVaP46jy4QqsibbtadPw10XitJgqahQBGU4esxhuY2vbTooPzPfThrDnIlFTSqYJN3iJnxNHj7iVUrDy6AwlqMP+putfuwcydANYQUEdP/GlFx1/+uEDaF5c948dJNo9fNiTTwKppb9mjEBs83qum5237ypU7gFhjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlcVhNfb; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-786a822e73aso28475667b3.3
        for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 00:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762764327; x=1763369127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzsbNcBLm2Xpzoo9GhZtU8EgZBenA7zGN5vz1SKOorc=;
        b=VlcVhNfbwG02XDd8pIzOT6lfy9kujYyzs49ItLwNIvOamRGuW39FihYbmOdps3lctC
         kcfVt+xREl3/X7t8UEhsyDcP6BJcVC9ts1csu8a7RlTTzYoP2LJZAEZKQY1a0WWh5JQ5
         Z/hhUgJs1Ofz6r96/QC6HkV6IoAe7rgEQCu/ukcksqJk55C725VVAa2uGBVI1b2GweXS
         FYiNPot8wRmd1/q3QWV1cL7loI/RwO4nJ+Kmui9HhxOJCO3y6lST1Gye7x0hPqArEo+y
         hxPP97+Y5pxPpsTaqE3eJs+RIWvW3RQqu5ev1FzV57kh9ZDVTMX4m5uw+dFndoI4WbXF
         bxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764327; x=1763369127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzsbNcBLm2Xpzoo9GhZtU8EgZBenA7zGN5vz1SKOorc=;
        b=UHZ6a0DazRCEvmucZ4tyoJK9mqOvAkXdtG1qBO6BpZJ94fqK/o5GFRvCziEavZVazu
         AS3CHb0NTPPaIKL4+s5HZdCklrxR0LIxuiT/huoVn5X+F4+szM3lRzrDICTwBpTTaRUc
         6dzXslWUbY4uuxJ+dXPUduYYmRu5odCeIvxgaAWmI8vOBVqz21ewgt7e/4A4p/PbrfvS
         gnmnLJEYDSaSnZ/cbUyc3C9Xh0PcqzbxX/r0hca39uDMKJLtxi7Vsflu56B0hayoUFnE
         hxzZBmzBeF9S0Gte0poPRt4rYbQbveRRHRT17cYAct2554hngckQcxYPf2u2mZv8BFUl
         ZfrA==
X-Forwarded-Encrypted: i=1; AJvYcCX+B7bNqQ6Q72zyqvsJRHYHbjR4AYLr9e3GSVMVOEpqygjmxood11Xh25bQY7RFqYXIXFnwC9lF02c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/E6GrnvYuG4NsAODYmbJin6db5P0Z/WhEsjjYP6wwEKJUTfuD
	QGWX/9MCty+ye2lXVCytMLu6pYv1L5IDAEgalEO02diSPCgl5uD9aifemh0r4/iRIjUDegekh3j
	g3wNvSJwwmzPOrc6fYvviBpPw3qwt7QU=
X-Gm-Gg: ASbGncsfsw//cE0bIBU4bEotoV8+f2PnZnzcWAjI/JhcMFmaWKoie2Stqdac5s65wfL
	90BXANpcfTf2a22E0LLBMbLw27ce0wlaVBjZLRkc7PNFH85SiSBWN36hkawv7IRk0iatDcLjl8n
	qbubWhtWRLs9B+OLFgqb+94PjizSihS952v9RsvW9EBio9zCbhESrAQU0jxA7Uq18j9Ar3S+3JF
	SI113q4kFc23zKJCydHdfH7Z47HleJn6deH59ZEJzHmJ0PQssY0rHfxIk5tGw==
X-Google-Smtp-Source: AGHT+IEuMmt95Cqu+sfIrJi6S6D7HS6xkJqyIluRYQtiIAhynzSXoHyExqFSloU7VZgk7jYy2QP8ya0HfQIfaqMhb1o=
X-Received: by 2002:a05:690c:4d41:b0:786:9774:a39c with SMTP id
 00721157ae682-787d5376709mr69585247b3.9.1762764326984; Mon, 10 Nov 2025
 00:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-tja1145-support-v4-0-4d3ca13c8881@liebherr.com> <20251015-tja1145-support-v4-2-4d3ca13c8881@liebherr.com>
In-Reply-To: <20251015-tja1145-support-v4-2-4d3ca13c8881@liebherr.com>
From: Luoxi Li <lee.lockhey@gmail.com>
Date: Mon, 10 Nov 2025 16:45:15 +0800
X-Gm-Features: AWmQ_bkMNQv3RkM-zo57uNjTl11Gs6OZU97cOXivYKBV4sePGC3_nO_h8CxXLhE
Message-ID: <CAL7siYPsuB3g1-KRkjJx00Yhg6ZjOvyvv5H=8bo53bV9N21E3g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] phy: add basic support for NXPs TJA1145 CAN transceiver
To: dimitri.fedrau@liebherr.com
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested in ST platform. Now everything works. Thank you!

Tested-By: <lee.lockhey@gmail.com>

    --
    With Best Regards,
    Lockhey Lee

On Wed, Oct 15, 2025 at 3:37=E2=80=AFPM Dimitri Fedrau via B4 Relay
<devnull+dimitri.fedrau.liebherr.com@kernel.org> wrote:
>
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>
> Add basic driver support for NXPs TJA1145 CAN transceiver which brings th=
e
> PHY up/down by switching to normal/standby mode using SPI commands.
>
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/phy/Kconfig           |  10 +++
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/phy-nxp-tja1145.c | 184 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 195 insertions(+)
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 678dd0452f0aa0597773433f04d2a9ba77474d2a..2f2c8f29cce2beb20c584adfe=
8acfe23de14e128 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -101,6 +101,16 @@ config PHY_NXP_PTN3222
>           schemes. It supports all three USB 2.0 data rates: Low Speed, F=
ull
>           Speed and High Speed.
>
> +config PHY_NXP_TJA1145
> +       tristate "NXP TJA1145 CAN transceiver PHY"
> +       select GENERIC_PHY
> +       select REGMAP_SPI
> +       depends on SPI
> +       help
> +         This option enables support for NXPs TJA1145 CAN transceiver as=
 a PHY.
> +         This driver provides function for putting the transceiver in va=
rious
> +         functional modes using SPI commands.
> +
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index bfb27fb5a494283d7fd05dd670ebd1b12df8b1a1..48eac644d1e2b20f986f80de9=
5b40c26d080358b 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)          +=3D phy-snps-eus=
b2.o
>  obj-$(CONFIG_USB_LGM_PHY)              +=3D phy-lgm-usb.o
>  obj-$(CONFIG_PHY_AIROHA_PCIE)          +=3D phy-airoha-pcie.o
>  obj-$(CONFIG_PHY_NXP_PTN3222)          +=3D phy-nxp-ptn3222.o
> +obj-$(CONFIG_PHY_NXP_TJA1145)          +=3D phy-nxp-tja1145.o
>  obj-y                                  +=3D allwinner/   \
>                                            amlogic/     \
>                                            broadcom/    \
> diff --git a/drivers/phy/phy-nxp-tja1145.c b/drivers/phy/phy-nxp-tja1145.=
c
> new file mode 100644
> index 0000000000000000000000000000000000000000..56b5b47f6eb23945d9116c41a=
25d9b6daccdcefa
> --- /dev/null
> +++ b/drivers/phy/phy-nxp-tja1145.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Liebherr-Electronics and Drives GmbH
> + */
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/phy/phy.h>
> +#include <linux/spi/spi.h>
> +
> +#define TJA1145_MODE_CTRL              0x01
> +#define TJA1145_MODE_CTRL_MC           GENMASK(2, 0)
> +#define TJA1145_MODE_CRTL_STBY         BIT(2)
> +#define TJA1145_MODE_CRTL_NORMAL       TJA1145_MODE_CTRL_MC
> +
> +#define TJA1145_CAN_CTRL               0x20
> +#define TJA1145_CAN_CTRL_CMC           GENMASK(1, 0)
> +#define TJA1145_CAN_CTRL_ACTIVE                BIT(1)
> +
> +#define TJA1145_IDENT                  0x7e
> +#define TJA1145_IDENT_TJA1145T         0x70
> +
> +#define TJA1145_SPI_READ_BIT           BIT(0)
> +#define TJA1145T_MAX_BITRATE           1000000
> +
> +static int tja1145_phy_power_on(struct phy *phy)
> +{
> +       struct regmap *map =3D phy_get_drvdata(phy);
> +       int ret;
> +
> +       /*
> +        * Switch operating mode to normal which is the active operating =
mode.
> +        * In this mode, the device is fully operational.
> +        */
> +       ret =3D regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_C=
TRL_MC,
> +                                TJA1145_MODE_CRTL_NORMAL);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Switch to CAN operating mode active where the PHY can transmit=
 and
> +        * receive data.
> +        */
> +       return regmap_update_bits(map, TJA1145_CAN_CTRL, TJA1145_CAN_CTRL=
_CMC,
> +                                 TJA1145_CAN_CTRL_ACTIVE);
> +}
> +
> +static int tja1145_phy_power_off(struct phy *phy)
> +{
> +       struct regmap *map =3D phy_get_drvdata(phy);
> +
> +       /*
> +        * Switch to operating mode standby, the PHY is unable to transmi=
t or
> +        * receive data in standby mode.
> +        */
> +       return regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_CT=
RL_MC,
> +                                 TJA1145_MODE_CRTL_STBY);
> +}
> +
> +static const struct phy_ops tja1145_phy_ops =3D {
> +       .power_on =3D tja1145_phy_power_on,
> +       .power_off =3D tja1145_phy_power_off,
> +};
> +
> +static const struct regmap_range tja1145_wr_holes_ranges[] =3D {
> +       regmap_reg_range(0x00, 0x00),
> +       regmap_reg_range(0x02, 0x03),
> +       regmap_reg_range(0x05, 0x05),
> +       regmap_reg_range(0x0b, 0x1f),
> +       regmap_reg_range(0x21, 0x22),
> +       regmap_reg_range(0x24, 0x25),
> +       regmap_reg_range(0x30, 0x4b),
> +       regmap_reg_range(0x4d, 0x60),
> +       regmap_reg_range(0x62, 0x62),
> +       regmap_reg_range(0x65, 0x67),
> +       regmap_reg_range(0x70, 0xff),
> +};
> +
> +static const struct regmap_access_table tja1145_wr_table =3D {
> +       .no_ranges =3D tja1145_wr_holes_ranges,
> +       .n_no_ranges =3D ARRAY_SIZE(tja1145_wr_holes_ranges),
> +};
> +
> +static const struct regmap_range tja1145_rd_holes_ranges[] =3D {
> +       regmap_reg_range(0x00, 0x00),
> +       regmap_reg_range(0x02, 0x02),
> +       regmap_reg_range(0x05, 0x05),
> +       regmap_reg_range(0x0b, 0x1f),
> +       regmap_reg_range(0x21, 0x21),
> +       regmap_reg_range(0x24, 0x25),
> +       regmap_reg_range(0x30, 0x4a),
> +       regmap_reg_range(0x4d, 0x5f),
> +       regmap_reg_range(0x62, 0x62),
> +       regmap_reg_range(0x65, 0x67),
> +       regmap_reg_range(0x70, 0x7d),
> +       regmap_reg_range(0x7f, 0xff),
> +};
> +
> +static const struct regmap_access_table tja1145_rd_table =3D {
> +       .no_ranges =3D tja1145_rd_holes_ranges,
> +       .n_no_ranges =3D ARRAY_SIZE(tja1145_rd_holes_ranges),
> +};
> +
> +static const struct regmap_config tja1145_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .reg_shift =3D -1,
> +       .val_bits =3D 8,
> +       .wr_table =3D &tja1145_wr_table,
> +       .rd_table =3D &tja1145_rd_table,
> +       .read_flag_mask =3D TJA1145_SPI_READ_BIT,
> +       .max_register =3D TJA1145_IDENT,
> +};
> +
> +static int tja1145_check_ident(struct device *dev, struct regmap *map)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       ret =3D regmap_read(map, TJA1145_IDENT, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val !=3D TJA1145_IDENT_TJA1145T) {
> +               dev_err(dev, "Expected device id: 0x%02x, got: 0x%02x\n",
> +                       TJA1145_IDENT_TJA1145T, val);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tja1145_probe(struct spi_device *spi)
> +{
> +       struct phy_provider *phy_provider;
> +       struct device *dev =3D &spi->dev;
> +       struct regmap *map;
> +       struct phy *phy;
> +       int ret;
> +
> +       map =3D devm_regmap_init_spi(spi, &tja1145_regmap_config);
> +       if (IS_ERR(map))
> +               return dev_err_probe(dev, PTR_ERR(map), "failed to init r=
egmap\n");
> +
> +       ret =3D tja1145_check_ident(dev, map);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to identify device=
\n");
> +
> +       phy =3D devm_phy_create(dev, dev->of_node, &tja1145_phy_ops);
> +       if (IS_ERR(phy))
> +               return dev_err_probe(dev, PTR_ERR(phy), "failed to create=
 PHY\n");
> +
> +       phy->attrs.max_link_rate =3D TJA1145T_MAX_BITRATE;
> +       phy_set_drvdata(phy, map);
> +       phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple=
_xlate);
> +
> +       return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct spi_device_id tja1145_spi_id[] =3D {
> +       { "tja1145" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, tja1145_spi_id);
> +
> +static const struct of_device_id tja1145_of_match[] =3D {
> +       { .compatible =3D "nxp,tja1145" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, tja1145_of_match);
> +
> +static struct spi_driver tja1145_driver =3D {
> +       .driver =3D {
> +               .name =3D "tja1145",
> +               .of_match_table =3D tja1145_of_match,
> +       },
> +       .probe =3D tja1145_probe,
> +       .id_table =3D tja1145_spi_id,
> +};
> +module_spi_driver(tja1145_driver);
> +
> +MODULE_DESCRIPTION("NXP TJA1145 CAN transceiver PHY driver");
> +MODULE_AUTHOR("Dimitri Fedrau <dimitri.fedrau@liebherr.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.39.5
>
>
>


--

