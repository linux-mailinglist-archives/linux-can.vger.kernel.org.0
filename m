Return-Path: <linux-can+bounces-1694-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519ED99E2DB
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FE91F22CCC
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A21DF731;
	Tue, 15 Oct 2024 09:33:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAE1DD885;
	Tue, 15 Oct 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984796; cv=none; b=d1fk6ANWNYSmC/P2J8Ps50pKu52v7WJUdVjckLD0kICdFa6THeFQ6SjEdLSdysQUYAldxiFDYzVUmBPN1ynqH+g7tahuOIvk7jTlNgmpDkw8/ed9NHH4EdezsXVZ9lqrXfW12l1tMi05bsM/gYCDjdpBn8q1pH0PmAueu2P8n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984796; c=relaxed/simple;
	bh=dOaAS8wJ2A50oDalS1emV+PSUJxnu5E7Sq/iUntxQqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnewSs9iTwZqMo8zULud0935ZrlDHBtX4cCivHCxfUueAnToFKgtw63CEjeACYtARoELv+LMLN3w2Pxdyw2g/lkecnKpzGjdvXuii0bP72EKUvOSb7fLhiY0xjpqWB8ehQIiwQ07lKA+FdaocrBLe8V2Gk+F53hosRk6cyNSPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com; spf=none smtp.mailfrom=linux.starfivetech.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.starfivetech.com
X-QQ-mid: bizesmtpsz11t1728984653tuuhcm
X-QQ-Originating-IP: FyVkQTzHbidph24G3Hpj2bposX9GDJqUQsrDesnIQqU=
Received: from [192.168.60.235] ( [113.72.147.64])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Oct 2024 17:30:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12415353088928851253
Message-ID: <EAC60558E0B6E4BB+e5384c3c-ba45-48f5-a86f-a74e84309a14@linux.starfivetech.com>
Date: Tue, 15 Oct 2024 17:30:50 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Content-Language: en-US
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hal Feng <hal.feng@starfivetech.com>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com>
 <CAMZ6Rq+EM37Gvx8bLEwvhn+kUC9yGDiapwD0KX31-x-e-Rm3yQ@mail.gmail.com>
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <CAMZ6Rq+EM37Gvx8bLEwvhn+kUC9yGDiapwD0KX31-x-e-Rm3yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Mt0a3sbGBFltOKsX6VxeEzWzITb5Zr4uaTG86kToohyqyj5OAL1cHK+I
	nqzR5fn8QKsHqerMsm5RACCOVNuswqV0VhJmwg+yZpgrGoZF/yjSu+KgrqJXaGcxbD4QcbQ
	UG6reU0KMMvLd4GfawOFixxQP0yof9u3WjQ8EyZmCQeevsIBX9NkY1s50+LuZmm+LWup7eP
	5akrKj4pqdZusobEN0tjOz/m+lw9uoMe6+iMVeTosFfG+h6QBkvRhYqjfM9EhwBWgw1/Dg5
	8MCKNKOvVJH+ugMHIWhTaYCjYO5czyahuQkEhWX4OiJ55gD5IeHTzi/mPy4lrQK3F6kufyK
	SJSnQ5Wf6V/n3MS7wXTNMrjMe0EQVoTrCVrMzgaalKJpl9HaySaPbiOHjbnxQl+h16UYtiS
	tzHGe9TQykGQQZljWk1FWoT+2WjBr3FYWRTvlNzsM0N1EaLXX8YcjIVWd3b2kHW1oSGNP3O
	0YhC2JkU4HXe+SyP9EADte3iVEvlV0xNM/qmLHRPoqoyd4T8refdjfNNH3tPcXmFDeexxCc
	+NhQf0yg/BmUPRK636EwDYXmvKrRA5WYjgafO6WCiLcwzdtm6cPBlCGYsnyb9LJb3D3M6zC
	mTAgxqiujJumatCDSJNqXOtU/d6li9CRuHWdWnz+iBAqmY0UWTPKNccCP+CUU2Hg8rbKdBD
	OtIKKy1PapqfvWmE4JGyJp8w/9OdszxfiknBSiSPVzIVnTjmCWNTD96/LZMuIb20Nq78t1v
	WLE8DK4aTvltQ2bFs2FRSpHfrNfo/TJw2Y6TUgahbZLskNrqISxAl8Vrh4vQ2kzm4irOly7
	PYJ4tiJRTq9IgoxxXvt9EPCpnWC7J3MSF5F8zpky4w68MoGmHQMUtRk7mwxN7t/MCl5Mpay
	JhRWycpaUW2O33c92hA/IDr8EEeiih8uDQOLEHR9irDoEdP7HHhSLRqd+aYaPXIDs7ihaVP
	p7fjFe8pspp3siw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On 9/23/2024 11:41 AM, Vincent MAILHOL wrote:
> Hi Hal,
> 
> A few more comments on top of what Andrew already wrote.
> 
> On Mon. 23 Sep. 2024 at 00:09, Hal Feng <hal.feng@starfivetech.com> wrote:
>> From: William Qiu <william.qiu@starfivetech.com>
>>
>> Add driver for CAST CAN Bus Controller used on
>> StarFive JH7110 SoC.
>>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  MAINTAINERS                |   8 +
>>  drivers/net/can/Kconfig    |   7 +
>>  drivers/net/can/Makefile   |   1 +
>>  drivers/net/can/cast_can.c | 936 +++++++++++++++++++++++++++++++++++++
>>  4 files changed, 952 insertions(+)
>>  create mode 100644 drivers/net/can/cast_can.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cc40a9d9b8cd..9313b1a69e48 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5010,6 +5010,14 @@ S:       Maintained
>>  W:     https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
>>  F:     drivers/net/wireless/ath/carl9170/
>>
>> +CAST CAN DRIVER
>> +M:     William Qiu <william.qiu@starfivetech.com>
>> +M:     Hal Feng <hal.feng@starfivetech.com>
>> +L:     linux-can@vger.kernel.org
>> +S:     Supported
>> +F:     Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
>> +F:     drivers/net/can/cast_can.c
>> +
>>  CAVIUM I2C DRIVER
>>  M:     Robert Richter <rric@kernel.org>
>>  S:     Odd Fixes
>> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
>> index 7f9b60a42d29..a7ae8be5876f 100644
>> --- a/drivers/net/can/Kconfig
>> +++ b/drivers/net/can/Kconfig
>> @@ -124,6 +124,13 @@ config CAN_CAN327
>>
>>           If this driver is built as a module, it will be called can327.
>>
>> +config CAN_CASTCAN
>> +       tristate "CAST CAN"
>> +       depends on ARCH_STARFIVE || COMPILE_TEST
>> +       depends on COMMON_CLK && HAS_IOMEM
>> +       help
>> +         CAST CAN driver. This driver supports both CAN and CANFD IP.
> 
> Nitpick, maybe briefly mention the module name:
> 
>   If built as a module, it will be named cast_can.

OK.

> 
>>  config CAN_FLEXCAN
>>         tristate "Support for Freescale FLEXCAN based chips"
>>         depends on OF || COLDFIRE || COMPILE_TEST
>> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
>> index 4669cd51e7bf..2f1ebd7c0efe 100644
>> --- a/drivers/net/can/Makefile
>> +++ b/drivers/net/can/Makefile
>> @@ -17,6 +17,7 @@ obj-y                         += softing/
>>  obj-$(CONFIG_CAN_AT91)         += at91_can.o
>>  obj-$(CONFIG_CAN_BXCAN)                += bxcan.o
>>  obj-$(CONFIG_CAN_CAN327)       += can327.o
>> +obj-$(CONFIG_CAN_CASTCAN)      += cast_can.o
>>  obj-$(CONFIG_CAN_CC770)                += cc770/
>>  obj-$(CONFIG_CAN_C_CAN)                += c_can/
>>  obj-$(CONFIG_CAN_CTUCANFD)     += ctucanfd/
>> diff --git a/drivers/net/can/cast_can.c b/drivers/net/can/cast_can.c
>> new file mode 100644
>> index 000000000000..020a2eaa236b
>> --- /dev/null
>> +++ b/drivers/net/can/cast_can.c
>> @@ -0,0 +1,936 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * CAST Controller Area Network Bus Controller Driver
>> + *
>> + * Copyright (c) 2022-2024 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/can/dev.h>
>> +#include <linux/can/error.h>
>> +#include <linux/clk.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +
>> +#define DRIVER_NAME "cast_can"
>> +
>> +enum ccan_reg {
>> +       CCAN_RUBF       = 0x00, /* Receive Buffer Registers 0x00-0x4f */
>> +       CCAN_RUBF_ID    = 0x00,
>> +       CCAN_RBUF_CTL   = 0x04,
>> +       CCAN_RBUF_DATA  = 0x08,
>> +       CCAN_TBUF       = 0x50, /* Transmit Buffer Registers 0x50-0x97 */
>> +       CCAN_TBUF_ID    = 0x50,
>> +       CCAN_TBUF_CTL   = 0x54,
>> +       CCAN_TBUF_DATA  = 0x58,
>> +       CCAN_TTS        = 0x98, /* Transmission Time Stamp 0x98-0x9f */
>> +       CCAN_CFG_STAT   = 0xa0,
>> +       CCAN_TCMD       = 0xa1,
>> +       CCAN_TCTRL      = 0xa2,
>> +       CCAN_RCTRL      = 0xa3,
>> +       CCAN_RTIE       = 0xa4,
>> +       CCAN_RTIF       = 0xa5,
>> +       CCAN_ERRINT     = 0xa6,
>> +       CCAN_LIMIT      = 0xa7,
>> +       CCAN_S_SEG_1    = 0xa8,
>> +       CCAN_S_SEG_2    = 0xa9,
>> +       CCAN_S_SJW      = 0xaa,
>> +       CCAN_S_PRESC    = 0xab,
>> +       CCAN_F_SEG_1    = 0xac,
>> +       CCAN_F_SEG_2    = 0xad,
>> +       CCAN_F_SJW      = 0xae,
>> +       CCAN_F_PRESC    = 0xaf,
>> +       CCAN_EALCAP     = 0xb0,
>> +       CCAN_RECNT      = 0xb2,
>> +       CCAN_TECNT      = 0xb3,
>> +};
>> +
>> +enum ccan_reg_bit_mask {
>> +       CCAN_RST_MASK             = BIT(7), /* Set Reset Bit */
>> +       CCAN_FULLCAN_MASK         = BIT(4),
>> +       CCAN_FIFO_MASK            = BIT(5),
>> +       CCAN_TSONE_MASK           = BIT(2),
>> +       CCAN_TSALL_MASK           = BIT(1),
>> +       CCAN_LBMEMOD_MASK         = BIT(6), /* Set loopback external mode */
>> +       CCAN_LBMIMOD_MASK         = BIT(5), /* Set loopback internal mode */
>> +       CCAN_BUSOFF_MASK          = BIT(0),
>> +       CCAN_TTSEN_MASK           = BIT(7),
>> +       CCAN_BRS_MASK             = BIT(4), /* CAN-FD Bit Rate Switch mask */
>> +       CCAN_EDL_MASK             = BIT(5), /* Extended Data Length */
>> +       CCAN_DLC_MASK             = GENMASK(3, 0),
>> +       CCAN_TENEXT_MASK          = BIT(6),
>> +       CCAN_IDE_MASK             = BIT(7),
>> +       CCAN_RTR_MASK             = BIT(6),
>> +       CCAN_INTR_ALL_MASK        = GENMASK(7, 0), /* All interrupts enable mask */
>> +       CCAN_RIE_MASK             = BIT(7),
>> +       CCAN_RFIE_MASK            = BIT(5),
>> +       CCAN_RAFIE_MASK           = BIT(4),
>> +       CCAN_EIE_MASK             = BIT(1),
>> +       CCAN_TASCTIVE_MASK        = BIT(1),
>> +       CCAN_RASCTIVE_MASK        = BIT(2),
>> +       CCAN_TBSEL_MASK           = BIT(7), /* Message writen in STB */
>                                                          ^^^^^^
> 
> Typo: writen -> written

Will fix it later.

> 
>> +       CCAN_STBY_MASK            = BIT(5),
>> +       CCAN_TPE_MASK             = BIT(4), /* Transmit primary enable */
>> +       CCAN_TPA_MASK             = BIT(3),
>> +       CCAN_SACK_MASK            = BIT(7),
>> +       CCAN_RREL_MASK            = BIT(4),
>> +       CCAN_RSTAT_NOT_EMPTY_MASK = GENMASK(1, 0),
>> +       CCAN_RIF_MASK             = BIT(7),
>> +       CCAN_RAFIF_MASK           = BIT(4),
>> +       CCAN_RFIF_MASK            = BIT(5),
>> +       CCAN_TPIF_MASK            = BIT(3), /* Transmission Primary Interrupt Flag */
>> +       CCAN_TSIF_MASK            = BIT(2),
>> +       CCAN_EIF_MASK             = BIT(1),
>> +       CCAN_AIF_MASK             = BIT(0),
>> +       CCAN_EWARN_MASK           = BIT(7),
>> +       CCAN_EPASS_MASK           = BIT(6),
>> +       CCAN_EPIE_MASK            = BIT(5),
>> +       CCAN_EPIF_MASK            = BIT(4),
>> +       CCAN_ALIE_MASK            = BIT(3),
>> +       CCAN_ALIF_MASK            = BIT(2),
>> +       CCAN_BEIE_MASK            = BIT(1),
>> +       CCAN_BEIF_MASK            = BIT(0),
>> +       CCAN_AFWL_MASK            = BIT(6),
>> +       CCAN_EWL_MASK             = (BIT(3) | GENMASK(1, 0)),
>> +       CCAN_KOER_MASK            = GENMASK(7, 5),
>> +       CCAN_BIT_ERROR_MASK       = BIT(5),
>> +       CCAN_FORM_ERROR_MASK      = BIT(6),
>> +       CCAN_STUFF_ERROR_MASK     = GENMASK(6, 5),
>> +       CCAN_ACK_ERROR_MASK       = BIT(7),
>> +       CCAN_CRC_ERROR_MASK       = (BIT(7) | BIT(5)),
>> +       CCAN_OTH_ERROR_MASK       = GENMASK(7, 6),
>> +};
>> +
>> +/* CCAN_S/F_SEG_1 bitfield shift */
>> +#define SEG_1_SHIFT            0
>> +#define SEG_2_SHIFT            8
>> +#define SJW_SHIFT              16
>> +#define PRESC_SHIFT            24
>> +
>> +enum cast_can_type {
>> +       CAST_CAN_TYPE_CAN = 0,
>> +       CAST_CAN_TYPE_CANFD,
>> +};
>> +
>> +struct ccan_priv {
>> +       struct can_priv can;
>> +       struct napi_struct napi;
>> +       struct device *dev;
>> +       void __iomem *reg_base;
>> +       struct clk_bulk_data clks[3];
>> +       struct reset_control *resets;
>> +       u32 cantype;
>> +};
>> +
>> +struct cast_can_data {
>> +       enum cast_can_type cantype;
>> +       const struct can_bittiming_const *bittime_const;
>> +       int (*syscon_update)(struct ccan_priv *priv);
>> +};
>> +
>> +static struct can_bittiming_const ccan_bittiming_const = {
>> +       .name = DRIVER_NAME,
>> +       .tseg1_min = 2,
>> +       .tseg1_max = 16,
>> +       .tseg2_min = 2,
>> +       .tseg2_max = 8,
>> +       .sjw_max = 4,
>> +       .brp_min = 1,
>> +       .brp_max = 256,
>> +       .brp_inc = 1,
>> +};
>> +
>> +static struct can_bittiming_const ccan_bittiming_const_canfd = {
>> +       .name = DRIVER_NAME,
>> +       .tseg1_min = 2,
>> +       .tseg1_max = 64,
>> +       .tseg2_min = 2,
>> +       .tseg2_max = 16,
>> +       .sjw_max = 16,
>> +       .brp_min = 1,
>> +       .brp_max = 256,
>> +       .brp_inc = 1,
>> +};
>> +
>> +static struct can_bittiming_const ccan_data_bittiming_const_canfd = {
>> +       .name = DRIVER_NAME,
>> +       .tseg1_min = 1,
>> +       .tseg1_max = 16,
>> +       .tseg2_min = 2,
>> +       .tseg2_max = 8,
>> +       .sjw_max = 8,
>> +       .brp_min = 1,
>> +       .brp_max = 256,
>> +       .brp_inc = 1,
>> +};
>> +
>> +static inline u32 ccan_read_reg(const struct ccan_priv *priv, u8 reg)
>> +{
>> +       return ioread32(priv->reg_base + reg);
>> +}
>> +
>> +static inline void ccan_write_reg(const struct ccan_priv *priv, u8 reg, u32 value)
>> +{
>> +       iowrite32(value, priv->reg_base + reg);
>> +}
>> +
>> +static inline u8 ccan_read_reg_8bit(const struct ccan_priv *priv,
>> +                                   enum ccan_reg reg)
>> +{
>> +       u8 reg_down;
>> +       union val {
>> +               u8 val_8[4];
>> +               u32 val_32;
>> +       } val;
>> +
>> +       reg_down = ALIGN_DOWN(reg, 4);
>> +       val.val_32 = ccan_read_reg(priv, reg_down);
>> +       return val.val_8[reg - reg_down];
>> +}
>> +
>> +static inline void ccan_write_reg_8bit(const struct ccan_priv *priv,
>> +                                      enum ccan_reg reg, u8 value)
>> +{
>> +       u8 reg_down;
>> +       union val {
>> +               u8 val_8[4];
>> +               u32 val_32;
>> +       } val;
>> +
>> +       reg_down = ALIGN_DOWN(reg, 4);
>> +       val.val_32 = ccan_read_reg(priv, reg_down);
>> +       val.val_8[reg - reg_down] = value;
>> +       ccan_write_reg(priv, reg_down, val.val_32);
>> +}
>> +
>> +static void ccan_reg_set_bits(const struct ccan_priv *priv,
>> +                             enum ccan_reg reg,
>> +                             enum ccan_reg_bit_mask bits)
>> +{
>> +       u8 val;
>> +
>> +       val = ccan_read_reg_8bit(priv, reg);
>> +       val |= bits;
>> +       ccan_write_reg_8bit(priv, reg, val);
>> +}
>> +
>> +static void ccan_reg_clear_bits(const struct ccan_priv *priv,
>> +                               enum ccan_reg reg,
>> +                               enum ccan_reg_bit_mask bits)
>> +{
>> +       u8 val;
>> +
>> +       val = ccan_read_reg_8bit(priv, reg);
>> +       val &= ~bits;
>> +       ccan_write_reg_8bit(priv, reg, val);
>> +}
>> +
>> +static void ccan_set_reset_mode(struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +
>> +       ccan_reg_set_bits(priv, CCAN_CFG_STAT, CCAN_RST_MASK);
>> +}
>> +
>> +static int ccan_bittime_configuration(struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       struct can_bittiming *bt = &priv->can.bittiming;
>> +       struct can_bittiming *dbt = &priv->can.data_bittiming;
>> +       u32 bittiming, data_bittiming;
>> +       u8 reset_test;
>> +
>> +       reset_test = ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
>> +
>> +       if (!(reset_test & CCAN_RST_MASK)) {
>> +               netdev_alert(ndev, "Not in reset mode, cannot set bit timing\n");
>> +               return -EPERM;
>> +       }
>> +
>> +       /* Check the bittime parameter */
>> +       if ((((int)(bt->phase_seg1 + bt->prop_seg + 1) - 2) < 0) ||
>> +           (((int)(bt->phase_seg2) - 1) < 0) ||
>> +           (((int)(bt->sjw) - 1) < 0) ||
>> +           (((int)(bt->brp) - 1) < 0))
>> +               return -EINVAL;
> 
> Here, you are checking for wraparounds. But can this really happen? We
> know for sure that:
> 
>   - bt->phase_seg1 + bt->prop_seg1 <= ccan_bittiming_const->tseg1_max
>   - bt->phase_seg1 >= ccan_bittiming_const->tseg2_min
> 
> and so on.
> 
> Unless there is a condition under which this issue can show up, remove
> the check.

OK, will drop it.

> 
>> +       bittiming = ((bt->phase_seg1 + bt->prop_seg + 1 - 2) << SEG_1_SHIFT) |
>> +                        ((bt->phase_seg2 - 1) << SEG_2_SHIFT) |
>> +                        ((bt->sjw - 1) << SJW_SHIFT) |
>> +                        ((bt->brp - 1) << PRESC_SHIFT);
>> +
>> +       ccan_write_reg(priv, CCAN_S_SEG_1, bittiming);
>> +
>> +       if (priv->cantype == CAST_CAN_TYPE_CANFD) {
>> +               if ((((int)(dbt->phase_seg1 + dbt->prop_seg + 1) - 2) < 0) ||
>> +                   (((int)(dbt->phase_seg2) - 1) < 0) ||
>> +                   (((int)(dbt->sjw) - 1) < 0) ||
>> +                   (((int)(dbt->brp) - 1) < 0))
>> +                       return -EINVAL;
>> +
>> +               data_bittiming = ((dbt->phase_seg1 + dbt->prop_seg + 1 - 2) << SEG_1_SHIFT) |
>> +                                ((dbt->phase_seg2 - 1) << SEG_2_SHIFT) |
>> +                                ((dbt->sjw - 1) << SJW_SHIFT) |
>> +                                ((dbt->brp - 1) << PRESC_SHIFT);
> 
> Nitpick: the calculation for the bittiming and the data_bittiming is
> the same. Can you factorize this calculation in a helper function?

Yes, will add a helper function to calculate.

> 
>> +               ccan_write_reg(priv, CCAN_F_SEG_1, data_bittiming);
>> +       }
>> +
>> +       ccan_reg_clear_bits(priv, CCAN_CFG_STAT, CCAN_RST_MASK);
>> +
>> +       netdev_dbg(ndev, "Slow bit rate: %08x\n", ccan_read_reg(priv, CCAN_S_SEG_1));
>> +       netdev_dbg(ndev, "Fast bit rate: %08x\n", ccan_read_reg(priv, CCAN_F_SEG_1));
>> +
>> +       return 0;
>> +}
>> +
>> +static int ccan_chip_start(struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       int err;
>> +
>> +       ccan_set_reset_mode(ndev);
>> +
>> +       err = ccan_bittime_configuration(ndev);
>> +       if (err) {
>> +               netdev_err(ndev, "Bittime setting failed!\n");
>> +               return err;
>> +       }
>> +
>> +       /* Set Almost Full Warning Limit */
>> +       ccan_reg_set_bits(priv, CCAN_LIMIT, CCAN_AFWL_MASK);
>> +
>> +       /* Programmable Error Warning Limit = (EWL+1)*8. Set EWL=11->Error Warning=96 */
>> +       ccan_reg_set_bits(priv, CCAN_LIMIT, CCAN_EWL_MASK);
>> +
>> +       /* Interrupts enable */
>> +       ccan_write_reg_8bit(priv, CCAN_RTIE, CCAN_INTR_ALL_MASK);
>> +
>> +       /* Error Interrupts enable(Error Passive and Bus Error) */
>> +       ccan_reg_set_bits(priv, CCAN_ERRINT, CCAN_EPIE_MASK);
>> +
>> +       /* Check whether it is loopback mode or normal mode */
>> +       if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
>> +               ccan_reg_set_bits(priv, CCAN_CFG_STAT, CCAN_LBMIMOD_MASK);
>> +       else
>> +               ccan_reg_clear_bits(priv, CCAN_CFG_STAT, CCAN_LBMEMOD_MASK | CCAN_LBMIMOD_MASK);
>> +
>> +       priv->can.state = CAN_STATE_ERROR_ACTIVE;
>> +
>> +       return 0;
>> +}
>> +
>> +static int ccan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>> +{
>> +       int ret;
>> +
>> +       switch (mode) {
>> +       case CAN_MODE_START:
>> +               ret = ccan_chip_start(ndev);
>> +               if (ret) {
>> +                       netdev_err(ndev, "Could not start CAN device !\n");
>> +                       return ret;
>> +               }
>> +               netif_wake_queue(ndev);
>> +               break;
>> +       default:
>> +               ret = -EOPNOTSUPP;
>> +               break;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void ccan_tx_interrupt(struct net_device *ndev, u8 isr)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +
>> +       /* wait till transmission of the PTB or STB finished */
>> +       while (isr & (CCAN_TPIF_MASK | CCAN_TSIF_MASK)) {
>> +               if (isr & CCAN_TPIF_MASK)
>> +                       ccan_reg_set_bits(priv, CCAN_RTIF, CCAN_TPIF_MASK);
>> +
>> +               if (isr & CCAN_TSIF_MASK)
>> +                       ccan_reg_set_bits(priv, CCAN_RTIF, CCAN_TSIF_MASK);
>> +
>> +               isr = ccan_read_reg_8bit(priv, CCAN_RTIF);
>> +       }
>> +
>> +       ndev->stats.tx_bytes += can_get_echo_skb(ndev, 0, NULL);
>> +       ndev->stats.tx_packets++;
>> +       netif_wake_queue(ndev);
>> +}
>> +
>> +static void ccan_rxfull_interrupt(struct net_device *ndev, u8 isr)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +
>> +       if (isr & CCAN_RAFIF_MASK)
>> +               ccan_reg_set_bits(priv, CCAN_RTIF, CCAN_RAFIF_MASK);
>> +
>> +       if (isr & (CCAN_RAFIF_MASK | CCAN_RFIF_MASK))
>> +               ccan_reg_set_bits(priv, CCAN_RTIF, CCAN_RAFIF_MASK | CCAN_RFIF_MASK);
>> +}
>> +
>> +static enum can_state ccan_get_chip_status(struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       u8 can_stat, eir;
>> +
>> +       can_stat = ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
>> +       eir = ccan_read_reg_8bit(priv, CCAN_ERRINT);
>> +
>> +       if (can_stat & CCAN_BUSOFF_MASK)
>> +               return CAN_STATE_BUS_OFF;
>> +
>> +       if (eir & CCAN_EPASS_MASK)
>> +               return CAN_STATE_ERROR_PASSIVE;
>> +
>> +       if (eir & CCAN_EWARN_MASK)
>> +               return CAN_STATE_ERROR_WARNING;
>> +
>> +       return CAN_STATE_ERROR_ACTIVE;
>> +}
>> +
>> +static void ccan_error_interrupt(struct net_device *ndev, u8 isr, u8 eir)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       struct net_device_stats *stats = &ndev->stats;
>> +       struct can_frame *cf;
>> +       struct sk_buff *skb;
>> +       u8 koer, recnt = 0, tecnt = 0, can_stat = 0;
>> +
>> +       skb = alloc_can_err_skb(ndev, &cf);
>> +
>> +       koer = ccan_read_reg_8bit(priv, CCAN_EALCAP) & CCAN_KOER_MASK;
>> +       recnt = ccan_read_reg_8bit(priv, CCAN_RECNT);
>> +       tecnt = ccan_read_reg_8bit(priv, CCAN_TECNT);
>> +
>> +       /* Read CAN status */
>> +       can_stat = ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
>> +
>> +       /* Bus off ---> active error mode */
>> +       if ((isr & CCAN_EIF_MASK) && priv->can.state == CAN_STATE_BUS_OFF)
>> +               priv->can.state = ccan_get_chip_status(ndev);
>> +
>> +       /* State selection */
>> +       if (can_stat & CCAN_BUSOFF_MASK) {
>> +               priv->can.state = ccan_get_chip_status(ndev);
>> +               priv->can.can_stats.bus_off++;
>> +               ccan_reg_set_bits(priv, CCAN_CFG_STAT, CCAN_BUSOFF_MASK);
>> +               can_bus_off(ndev);
>> +               if (skb)
>> +                       cf->can_id |= CAN_ERR_BUSOFF;
>> +       } else if (eir & CCAN_EPASS_MASK) {
>> +               priv->can.state = ccan_get_chip_status(ndev);
>> +               priv->can.can_stats.error_passive++;
>> +               if (skb) {
>> +                       cf->can_id |= CAN_ERR_CRTL;
>> +                       cf->data[1] |= (recnt > 127) ? CAN_ERR_CRTL_RX_PASSIVE : 0;
>> +                       cf->data[1] |= (tecnt > 127) ? CAN_ERR_CRTL_TX_PASSIVE : 0;
> 
> Use the CAN state thresholds from include/uapi/linux/can/error.h:
> 
>   recnt >= CAN_ERROR_PASSIVE_THRESHOLD
> 
> and so on.

Get it.

> 
> Replace the ternary operator by an if.

OK. It will be more readable.

> 
>> +                       cf->data[6] = tecnt;
>> +                       cf->data[7] = recnt;
>> +               }
>> +       } else if (eir & CCAN_EWARN_MASK) {
>> +               priv->can.state = ccan_get_chip_status(ndev);
>> +               priv->can.can_stats.error_warning++;
>> +               if (skb) {
>> +                       cf->can_id |= CAN_ERR_CRTL;
>> +                       cf->data[1] |= (recnt > 95) ? CAN_ERR_CRTL_RX_WARNING : 0;
>> +                       cf->data[1] |= (tecnt > 95) ? CAN_ERR_CRTL_TX_WARNING : 0;
> 
> Ditto with CAN_ERROR_WARNING_THRESHOLD.

Get it.

> 
>> +                       cf->data[6] = tecnt;
>> +                       cf->data[7] = recnt;
>> +               }
>> +       }
>> +
>> +       /* Check for in protocol defined error interrupt */
>> +       if (eir & CCAN_BEIF_MASK) {
>> +               if (skb)
>> +                       cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
>> +
>> +               if (koer == CCAN_BIT_ERROR_MASK) {
>> +                       stats->tx_errors++;
>> +                       if (skb)
>> +                               cf->data[2] = CAN_ERR_PROT_BIT;
>> +               } else if (koer == CCAN_FORM_ERROR_MASK) {
>> +                       stats->rx_errors++;
>> +                       if (skb)
>> +                               cf->data[2] = CAN_ERR_PROT_FORM;
>> +               } else if (koer == CCAN_STUFF_ERROR_MASK) {
>> +                       stats->rx_errors++;
>> +                       if (skb)
>> +                               cf->data[3] = CAN_ERR_PROT_STUFF;
>> +               } else if (koer == CCAN_ACK_ERROR_MASK) {
>> +                       stats->tx_errors++;
>> +                       if (skb)
>> +                               cf->data[2] = CAN_ERR_PROT_LOC_ACK;
>> +               } else if (koer == CCAN_CRC_ERROR_MASK) {
>> +                       stats->rx_errors++;
>> +                       if (skb)
>> +                               cf->data[2] = CAN_ERR_PROT_LOC_CRC_SEQ;
>> +               }
>> +               priv->can.can_stats.bus_error++;
>> +       }
>> +
>> +       if (skb) {
>> +               stats->rx_packets++;
>> +               stats->rx_bytes += cf->can_dlc;
> 
> Do not increase the reception statistics for an error frame. Refer to:
> 
>   https://git.kernel.org/torvalds/c/676068db69b8
> 
> for the reason why.

Will fix it accordingly.

> 
>> +               netif_rx(skb);
>> +       }
>> +
>> +       netdev_dbg(ndev, "Recnt is 0x%02x", ccan_read_reg_8bit(priv, CCAN_RECNT));
>> +       netdev_dbg(ndev, "Tecnt is 0x%02x", ccan_read_reg_8bit(priv, CCAN_TECNT));
> 
> Either remove this error message or print something more explicit. The
> end-user may not know what a Recnt is. Something like this is better:
> 
>   netdev_dbg(ndev, "Rx error count: 0x%02x", ccan_read_reg_8bit(priv,
> CCAN_RECNT));
> 
> If there are a lot of errors on the but, this can create a lot of
> spam. If you decide to keep, encapsulate this in a:
> 
>   if (net_ratelimit())

I prefer removing this error message. Thanks for your suggestions.

> 
>> +}
>> +
>> +static irqreturn_t ccan_interrupt(int irq, void *dev_id)
>> +{
>> +       struct net_device *ndev = (struct net_device *)dev_id;
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       u8 isr, eir;
>> +       u8 isr_handled = 0, eir_handled = 0;
>> +
>> +       /* Read the value of interrupt status register */
>> +       isr = ccan_read_reg_8bit(priv, CCAN_RTIF);
>> +
>> +       /* Read the value of error interrupt register */
>> +       eir = ccan_read_reg_8bit(priv, CCAN_ERRINT);
>> +
>> +       /* Check for Tx interrupt and processing it */
>> +       if (isr & (CCAN_TPIF_MASK | CCAN_TSIF_MASK)) {
>> +               ccan_tx_interrupt(ndev, isr);
>> +               isr_handled |= (CCAN_TPIF_MASK | CCAN_TSIF_MASK);
>> +       }
>> +
>> +       if (isr & (CCAN_RAFIF_MASK | CCAN_RFIF_MASK)) {
>> +               ccan_rxfull_interrupt(ndev, isr);
>> +               isr_handled |= (CCAN_RAFIF_MASK | CCAN_RFIF_MASK);
>> +       }
>> +
>> +       /* Check Rx interrupt and processing the receive interrupt routine */
>> +       if (isr & CCAN_RIF_MASK) {
>> +               ccan_reg_clear_bits(priv, CCAN_RTIE, CCAN_RIE_MASK);
>> +               ccan_reg_set_bits(priv, CCAN_RTIF, CCAN_RIF_MASK);
>> +
>> +               napi_schedule(&priv->napi);
>> +               isr_handled |= CCAN_RIF_MASK;
>> +       }
>> +
>> +       if ((isr & CCAN_EIF_MASK) | (eir & (CCAN_EPIF_MASK | CCAN_BEIF_MASK))) {
>> +               /* Reset EPIF and BEIF. Reset EIF */
>> +               ccan_reg_set_bits(priv, CCAN_ERRINT, eir & (CCAN_EPIF_MASK | CCAN_BEIF_MASK));
>> +               ccan_reg_set_bits(priv, CCAN_RTIF, isr & CCAN_EIF_MASK);
>> +
>> +               ccan_error_interrupt(ndev, isr, eir);
>> +
>> +               isr_handled |= CCAN_EIF_MASK;
>> +               eir_handled |= (CCAN_EPIF_MASK | CCAN_BEIF_MASK);
>> +       }
>> +
>> +       if (isr_handled == 0 && eir_handled == 0) {
>> +               netdev_err(ndev, "Unhandled interrupt!\n");
>> +               return IRQ_NONE;
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int ccan_open(struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       int ret;
>> +
>> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(priv->clks), priv->clks);
>> +       if (ret) {
>> +               netdev_err(ndev, "Failed to enable CAN clocks\n");
>> +               return ret;
>> +       }
>> +
>> +       /* Set chip into reset mode */
>> +       ccan_set_reset_mode(ndev);
>> +
>> +       /* Common open */
>> +       ret = open_candev(ndev);
>> +       if (ret)
>> +               goto clk_exit;
>> +
>> +       /* Register interrupt handler */
>> +       ret = devm_request_irq(priv->dev, ndev->irq, ccan_interrupt, IRQF_SHARED,
>> +                              ndev->name, ndev);
>> +       if (ret) {
>> +               netdev_err(ndev, "Request_irq err: %d\n", ret);
>> +               goto candev_exit;
>> +       }
>> +
>> +       ret = ccan_chip_start(ndev);
>> +       if (ret) {
>> +               netdev_err(ndev, "Could not start CAN device !\n");
> 
> Nipick: in English punctuation rules, there an no spaces before the
> exclamation mark:
> 
>   netdev_err(ndev, "Could not start CAN device!\n");
> 
> (or you may consider just removing the exclamation mark. No need to be
> so emotional for an error message).

Yeah, just drop the space and the exclamation.

> 
>> +               goto candev_exit;
>> +       }
>> +
>> +       napi_enable(&priv->napi);
>> +       netif_start_queue(ndev);
>> +
>> +       return 0;
>> +
>> +candev_exit:
>> +       close_candev(ndev);
>> +clk_exit:
>> +       clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clks), priv->clks);
>> +       return ret;
>> +}
>> +
>> +static int ccan_close(struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +
>> +       netif_stop_queue(ndev);
>> +       napi_disable(&priv->napi);
>> +
>> +       ccan_set_reset_mode(ndev);
>> +       priv->can.state = CAN_STATE_STOPPED;
>> +
>> +       close_candev(ndev);
>> +       clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clks), priv->clks);
>> +
>> +       return 0;
>> +}
>> +
>> +static netdev_tx_t ccan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>> +       u32 id, ctl, addr_off = CCAN_TBUF_DATA;
>> +       int i;
>> +
>> +       if (can_dropped_invalid_skb(ndev, skb))
>> +               return NETDEV_TX_OK;
>> +
>> +       netif_stop_queue(ndev);
> 
> Does your device only allow sending one frame at a time? Doesn't it
> have a transmission queue?

The hardware has a transmission queue, but the current driver doesn't
use it. Let me use the transmission queue in the next version.

> 
>> +       /* Work in XMIT_PTB mode */
>> +       ccan_reg_clear_bits(priv, CCAN_TCMD, CCAN_TBSEL_MASK);
>> +
>> +       ccan_reg_clear_bits(priv, CCAN_TCMD, CCAN_STBY_MASK);
>> +
>> +       id = cf->can_id & ((cf->can_id & CAN_EFF_FLAG) ? CAN_EFF_MASK : CAN_SFF_MASK);
>> +
>> +       ctl = can_fd_len2dlc(cf->len);
>> +       ctl = (cf->can_id & CAN_EFF_FLAG) ? (ctl | CCAN_IDE_MASK) : (ctl & ~CCAN_IDE_MASK);
>> +
>> +       if (priv->cantype == CAST_CAN_TYPE_CANFD && can_is_canfd_skb(skb)) {
>> +               ctl |= (cf->flags & CANFD_BRS) ? (CCAN_BRS_MASK | CCAN_EDL_MASK) : CCAN_EDL_MASK;
> 
> Replace those long ternary operations with some il/else. It is easier to read.

OK.

> 
>> +               for (i = 0; i < cf->len; i += 4) {
>> +                       ccan_write_reg(priv, addr_off, *((u32 *)(cf->data + i)));
>> +                       addr_off += 4;
> 
> Nitpick, what about:
> 
>   ccan_write_reg(priv, CCAN_TBUF_DATA + i, *((u32 *)(cf->data + i)));
> 
> and then remove the declaration of addr_off.

Yeah, it will be clearer.

> 
>> +               }
>> +       } else {
>> +               ctl &= ~(CCAN_EDL_MASK | CCAN_BRS_MASK);
>> +
>> +               if (cf->can_id & CAN_RTR_FLAG) {
>> +                       ctl |= CCAN_RTR_MASK;
>> +               } else {
>> +                       ctl &= ~CCAN_RTR_MASK;
>> +                       ccan_write_reg(priv, addr_off, *((u32 *)(cf->data + 0)));
>> +                       ccan_write_reg(priv, addr_off + 4, *((u32 *)(cf->data + 4)));
> 
> In this else block, addr_off is just an alias of CCAN_TBUF_DATA. So,
> directly do:
> 
>   ccan_write_reg(priv, CCAN_TBUF_DATA, *((u32 *)(cf->data + 0)));
>   ccan_write_reg(priv, CCAN_TBUF_DATA + 4, *((u32 *)(cf->data + 4)));

OK.

> 
>> +               }
>> +       }
>> +
>> +       ccan_write_reg(priv, CCAN_TBUF_ID, id);
>> +       ccan_write_reg(priv, CCAN_TBUF_CTL, ctl);
>> +       ccan_reg_set_bits(priv, CCAN_TCMD, CCAN_TPE_MASK);
>> +
>> +       can_put_echo_skb(skb, ndev, 0, 0);
>> +
>> +       return NETDEV_TX_OK;
>> +}
>> +
>> +static const struct net_device_ops ccan_netdev_ops = {
>> +       .ndo_open = ccan_open,
>> +       .ndo_stop = ccan_close,
>> +       .ndo_start_xmit = ccan_start_xmit,
>> +       .ndo_change_mtu = can_change_mtu,
>> +};
> 
> Also add a struct ethtool_ops for the default timestamps:
> 
>   static const struct ethtool_ops ccan_ethtool_ops = {
>           .get_ts_info = ethtool_op_get_ts_info,
>   };
> 
> This assumes that your device does not support hardware timestamps. If
> you do have hardware timestamping support, please adjust accordingly.

Will add this struct ethtool_ops later.

> 
>> +static int ccan_rx(struct net_device *ndev)
>> +{
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       struct net_device_stats *stats = &ndev->stats;
>> +       struct canfd_frame *cf_fd;
>> +       struct can_frame *cf;
>> +       struct sk_buff *skb;
>> +       u32 can_id;
>> +       u8 dlc, control;
>> +       int i;
>> +
>> +       control = ccan_read_reg_8bit(priv, CCAN_RBUF_CTL);
>> +       can_id = ccan_read_reg(priv, CCAN_RUBF_ID);
>> +       dlc = ccan_read_reg_8bit(priv, CCAN_RBUF_CTL) & CCAN_DLC_MASK;
>> +
>> +       if (control & CCAN_EDL_MASK)
>> +               /* allocate sk_buffer for canfd frame */
>> +               skb = alloc_canfd_skb(ndev, &cf_fd);
>> +       else
>> +               /* allocate sk_buffer for can frame */
>> +               skb = alloc_can_skb(ndev, &cf);
>> +
>> +       if (!skb) {
>> +               stats->rx_dropped++;
>> +               return 0;
>> +       }
>> +
>> +       /* Change the CANFD or CAN2.0 data into socketcan data format */
>> +       if (control & CCAN_EDL_MASK)
>> +               cf_fd->len = can_fd_dlc2len(dlc);
>> +       else
>> +               cf->can_dlc = can_cc_dlc2len(dlc);
> 
> cf->can_dlc is deprecated. Use cf->len instead.

Get it.

> 
>> +       /* Change the CANFD or CAN2.0 id into socketcan id format */
>> +       if (control & CCAN_EDL_MASK) {
>> +               cf_fd->can_id = can_id;
>> +               cf_fd->can_id = (control & CCAN_IDE_MASK) ? (cf_fd->can_id | CAN_EFF_FLAG) :
>> +                            (cf_fd->can_id & ~CAN_EFF_FLAG);
>> +       } else {
>> +               cf->can_id = can_id;
>> +               cf->can_id = (control & CCAN_IDE_MASK) ? (cf->can_id | CAN_EFF_FLAG) :
>> +                            (cf->can_id & ~CAN_EFF_FLAG);
>> +       }
> 
> struct can_frame and struct canfd_frame have overlapping fields. You
> can just have one stack variable for both and then, no need for an
> if/else here.

Get it.

> 
>> +       if (!(control & CCAN_EDL_MASK))
>> +               if (control & CCAN_RTR_MASK)
>> +                       cf->can_id |= CAN_RTR_FLAG;
>> +
>> +       if (control & CCAN_EDL_MASK) {
> 
> You are checking for if (!(control & CCAN_EDL_MASK)) and just after
> for if (control & CCAN_EDL_MASK). Factorize those two together.

OK.

> 
>> +               for (i = 0; i < cf_fd->len; i += 4)
>> +                       *((u32 *)(cf_fd->data + i)) = ccan_read_reg(priv, CCAN_RBUF_DATA + i);
>> +       } else {
>> +               /* skb reads the received datas, if the RTR bit not set */
>> +               if (!(control & CCAN_RTR_MASK)) {
>> +                       *((u32 *)(cf->data + 0)) = ccan_read_reg(priv, CCAN_RBUF_DATA);
>> +                       *((u32 *)(cf->data + 4)) = ccan_read_reg(priv, CCAN_RBUF_DATA + 4);
>> +               }
>> +       }
>> +
>> +       ccan_reg_set_bits(priv, CCAN_RCTRL, CCAN_RREL_MASK);
>> +
>> +       stats->rx_bytes += (control & CCAN_EDL_MASK) ? cf_fd->len : cf->can_dlc;
> 
> No, cf_fd->len and cf->can_dlc are the same byte (these are parts of
> an union). It is just that cf->can_dlc is deprecated and is kept to
> not break the UAPI. In the kernel it should never be used.
> 
> Here, what you have to do is just to not increase stats->rx_bytes for
> RTR frames. Try to factorize this with the other checks which you did
> above.

Get it.

> 
>> +       stats->rx_packets++;
>> +       netif_receive_skb(skb);
>> +
>> +       return 1;
> 
> Why return 1 on success and 0 on failure? The convention in the kernel
> is that 0 means success. If you really want to keep 0 for failure, at
> least make this return boolean true or boolean false, but overall, try
> to follow the return conventions.

The return value here represents the number of successfully received packets.
It is used in ccan_rx_poll() for counting the number of successfully
received packets.

> 
>> +}
>> +
>> +static int ccan_rx_poll(struct napi_struct *napi, int quota)
>> +{
>> +       struct net_device *ndev = napi->dev;
>> +       struct ccan_priv *priv = netdev_priv(ndev);
>> +       int work_done = 0;
>> +       u8 rx_status = 0;
>> +
>> +       rx_status = ccan_read_reg_8bit(priv, CCAN_RCTRL);
>> +
>> +       /* Clear receive interrupt and deal with all the received frames */
>> +       while ((rx_status & CCAN_RSTAT_NOT_EMPTY_MASK) && (work_done < quota)) {
>> +               work_done += ccan_rx(ndev);
>> +
>> +               rx_status = ccan_read_reg_8bit(priv, CCAN_RCTRL);
>> +       }
>> +
>> +       napi_complete(napi);
>> +       ccan_reg_set_bits(priv, CCAN_RTIE, CCAN_RIE_MASK);
>> +
>> +       return work_done;
>> +}
>> +
>> +static int ccan_driver_probe(struct platform_device *pdev)
>> +{
>> +       struct net_device *ndev;
>> +       struct ccan_priv *priv;
>> +       const struct cast_can_data *ddata;
>> +       void __iomem *addr;
>> +       int ret;
>> +
>> +       addr = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(addr)) {
>> +               ret = PTR_ERR(addr);
>> +               goto exit;
> 
> No need for goto here:
> 
>   return PTR_ERR(addr);

OK.

> 
>> +       }
>> +
>> +       ddata = of_device_get_match_data(&pdev->dev);
>> +       if (!ddata)
>> +               return -ENODEV;
>> +
>> +       ndev = alloc_candev(sizeof(struct ccan_priv), 1);
>> +       if (!ndev) {
>> +               ret = -ENOMEM;
>> +               goto exit;
> 
> Same:
> 
>   return -ENOMEM;
> 
> (this done, remove the exit label).

OK.

> 
>> +       }
>> +
>> +       priv = netdev_priv(ndev);
>> +       priv->dev = &pdev->dev;
>> +       priv->cantype = ddata->cantype;
>> +       priv->can.bittiming_const = ddata->bittime_const;
>> +
>> +       if (ddata->syscon_update) {
>> +               ret = ddata->syscon_update(priv);
>> +               if (ret)
>> +                       goto free_exit;
>> +       }
>> +
>> +       priv->clks[0].id = "apb";
>> +       priv->clks[1].id = "timer";
>> +       priv->clks[2].id = "core";
>> +
>> +       ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(priv->clks), priv->clks);
>> +       if (ret) {
>> +               ret = dev_err_probe(&pdev->dev, ret, "Failed to get CAN clocks\n");
>> +               goto free_exit;
>> +       }
>> +
>> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(priv->clks), priv->clks);
>> +       if (ret) {
>> +               ret = dev_err_probe(&pdev->dev, ret, "Failed to enable CAN clocks\n");
>> +               goto free_exit;
>> +       }
>> +
>> +       priv->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
>> +       if (IS_ERR(priv->resets)) {
>> +               ret = dev_err_probe(&pdev->dev, PTR_ERR(priv->resets),
>> +                                   "Failed to get CAN resets");
>> +               goto clk_exit;
>> +       }
>> +
>> +       ret = reset_control_deassert(priv->resets);
>> +       if (ret)
>> +               goto clk_exit;
>> +
>> +       if (priv->cantype == CAST_CAN_TYPE_CANFD) {
>> +               priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_FD;
>> +               priv->can.data_bittiming_const = &ccan_data_bittiming_const_canfd;
>> +       } else {
>> +               priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
>> +       }
> 
> Nitpick, consider doing this:
> 
>   priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
>   if (priv->cantype == CAST_CAN_TYPE_CANFD) {
>           priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
>           priv->can.data_bittiming_const = &ccan_data_bittiming_const_canfd;
>   }

OK.

> 
> Also, does you hardware support dlc greater than 8 (c.f.
> CAN_CTRLMODE_CC_LEN8_DLC)?

The class CAN (CC) mode does not support, but the CAN FD mode supports.

> 
>> +       priv->reg_base = addr;
>> +       priv->can.clock.freq = clk_get_rate(priv->clks[2].clk);
>> +       priv->can.do_set_mode = ccan_do_set_mode;
>> +       ndev->irq = platform_get_irq(pdev, 0);
>> +
>> +       /* We support local echo */
>> +       ndev->flags |= IFF_ECHO;
>> +       ndev->netdev_ops = &ccan_netdev_ops;
>> +
>> +       platform_set_drvdata(pdev, ndev);
>> +       SET_NETDEV_DEV(ndev, &pdev->dev);
>> +
>> +       netif_napi_add_tx_weight(ndev, &priv->napi, ccan_rx_poll, 16);
>> +       ret = register_candev(ndev);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to register (err=%d)\n", ret);
> 
>>From the Linux coding style:
> 
>   Printing numbers in parentheses (%d) adds no value and should be avoided.
> 
> Ref: https://www.kernel.org/doc/html/v4.10/process/coding-style.html#printing-kernel-messages

Will fix it accordingly.

Sorry for the late reply. Thank you for your detailed review.

Best regards,
Hal

