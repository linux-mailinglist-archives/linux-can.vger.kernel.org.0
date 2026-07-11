Return-Path: <linux-can+bounces-8319-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3BTKHRyzUWoqHgMAu9opvQ
	(envelope-from <linux-can+bounces-8319-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 05:06:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B981474020E
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 05:06:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cB7mC3oR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8319-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8319-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DACE300CFD9
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 03:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BA2737F8;
	Sat, 11 Jul 2026 03:05:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AFA2561A2
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 03:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739148; cv=none; b=uKOtT2wu++lPeDHsZBNR3i1vQI+pPqeXmXfZdeZmyI1g6i8w8+aafNWL+HdFqsGA9P+N2I4I5tYVivmILPB1z6glu0YQpTNMGlv5PxBSCWKOE8qCRnIIZbaJrogoErhWg2lDBe9pBubKnQ3rwO+HI0TPmZxoUg78ldl3qVPsQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739148; c=relaxed/simple;
	bh=diAOIf9lqFJ2nyuU7q/KEZCo3DAizTz7cvr53oILfQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwe6OLQYTlKz39Um+ZhKI4PKemmzAIR7txPYJ8uMielwa2UVapFJtAdedxRxRYSQkLSlNSrD7P+Zfnnpg/kzMIshTRIiTr/cg7cYY1uJu0TVkQu3Qx2Uu0tv1vwcubOg3Iqf8EeIzeBMrt4WHbr/m0o5ECNj6IgCIBEHZxnQp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB7mC3oR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C537E1F00A3E
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 03:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783739144;
	bh=DiKwtKKh/sMvPSRkmfz6pTRmTCpVLo/Yt10AT5S9Eyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cB7mC3oR2Tn0a+07yHKPxks0Jyl5UsgU+MI/p1vcUSqp8o+bKcnObeG5UJDoHLIUs
	 mfpRiuYY1YVz3kIodc1IJ1kOA5EX7SJBSnqm1Y22X9VaOahaxSyX0UA739Bg/Vd9Yu
	 LUxievDI0H2tUk41IpoOcK2NnbH+el/TFcBROiivT1nAlCGFhejx/ytQXOUiIijAmw
	 Fyb7A2Yd1RA7HbV03uWaMRw7n26weMZYLgvma1cbI8DsshqxT7N3uUtmcM9an3IzmL
	 udCQbFlxFXj+f0A6zsyFTYmVtosI5uBTH2b45p3hVSH6jmBAiZS2nIzXdC8FoC3aLp
	 u8kXVhLfzFy0A==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so183225266b.3
        for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:05:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp6whGWBmzqz9PUFkELrhOdRPK1Sf3bFvM1jU8UZdT8pfZ8Nk2qVwG+I+Ho2fsv9l9nFc2iY6M3MXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzYCY8i1nwv8GMLNAbb9fINMHQFhbi1VIx138+ZkfRVsNxIyY
	SXEzhAjj5VZqhXbah3bvYnKdbHUom1wRvjvSTrqpZ66cpcE3X0Q8DS8ME9b2Ub/8Ta5ca3AL0KU
	bGEaw2rb9yfacQAxv8LsTtic8zOFeaao=
X-Received: by 2002:a17:907:c80f:b0:c15:b886:8413 with SMTP id
 a640c23a62f3a-c161e924efemr51278666b.26.1783739142158; Fri, 10 Jul 2026
 20:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783670733.git.zhoubinbin@loongson.cn> <20507209923b81f7902b3315d1b5837e36b31a67.1783670733.git.zhoubinbin@loongson.cn>
In-Reply-To: <20507209923b81f7902b3315d1b5837e36b31a67.1783670733.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Jul 2026 11:05:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6NOYmE3vvXwWH5gsA61zf8QXKNPmnih7yv=fiMqtJq5g@mail.gmail.com>
X-Gm-Features: AUfX_mwyjBYdAxjcJOGn36E0A6EktjWDuPRDYs6gry717CVb5xBRA4AAmgOvAJ4
Message-ID: <CAAhV-H6NOYmE3vvXwWH5gsA61zf8QXKNPmnih7yv=fiMqtJq5g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] can: Add Loongson CAN-FD controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Bingxiong Li <libingxiong@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-can@vger.kernel.org, jeffbai@aosc.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,aosc.io];
	TAGGED_FROM(0.00)[bounces-8319-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:zhoubb.aaron@gmail.com,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:libingxiong@loongson.cn,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chenhuacai@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,loongson.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B981474020E

Hi, Binbin,

On Fri, Jul 10, 2026 at 4:22=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Add a new driver for the Loongson CAN-FD controller, which is integrated
> into Loongson-2K series SoCs. The controller supports both CAN 2.0 and
> CAN-FD protocols, with up to 8 TX buffers and a flexible RX buffer.
>
> The driver implements the core CAN device operations:
>  - NAPI-based receive path with interrupt masking to reduce overhead;
>  - TX echo support for accurate loopback and echo skb handling;
>  - Error reporting (warning, passive, bus-off) with detailed status;
>  - Support for common CAN controller modes: loopback, listen-only,
>    one-shot, FD, and non-ISO FD;
>  - Auto TDC (Transmitter Delay Compensation) for FD data phase.
>
> Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
> Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                      |    7 +
>  drivers/net/can/Kconfig          |   11 +
>  drivers/net/can/Makefile         |    1 +
>  drivers/net/can/loongson_canfd.c | 1716 ++++++++++++++++++++++++++++++
>  4 files changed, 1735 insertions(+)
>  create mode 100644 drivers/net/can/loongson_canfd.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec8661b446fb..9bd016da08bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15042,6 +15042,13 @@ F:     arch/loongarch/
>  F:     drivers/*/*loongarch*
>  F:     drivers/cpufreq/loongson3_cpufreq.c
>
> +LOONGSON CAN FD DRIVER
> +M:     Bingxiong Li <libingxiong@loongson.cn>
> +M:     Binbin Zhou <zhoubinbin@loongson.cn>
> +L:     linux-can@vger.kernel.org
> +S:     Maintained
> +F:     drivers/net/can/loongson_canfd/
> +
>  LOONGSON GPIO DRIVER
>  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
>  L:     linux-gpio@vger.kernel.org
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e15e320db476..55c40b0654fb 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -189,6 +189,17 @@ config CAN_KVASER_PCIEFD
>             Kvaser M.2 PCIe 4xCAN
>             Kvaser PCIe 8xCAN
>
> +config CAN_LOONGSON_CANFD
> +       tristate "Loongson CAN-FD controller"
> +       depends on HAS_IOMEM
> +       select REGMAP_MMIO
> +       help
> +         This is a canfd driver switch for the Loongson platform,
> +         integrated with the Loongson-2K series SoCs.
> +
> +         To compile as a module, choose M here: the module will be
> +         called loongson_canfd.
> +
>  config CAN_SLCAN
>         tristate "Serial / USB serial CAN Adaptors (slcan)"
>         depends on TTY
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index d7bc10a6b8ea..1ce78443d710 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_CAN_GRCAN)               +=3D grcan.o
>  obj-$(CONFIG_CAN_IFI_CANFD)    +=3D ifi_canfd/
>  obj-$(CONFIG_CAN_JANZ_ICAN3)   +=3D janz-ican3.o
>  obj-$(CONFIG_CAN_KVASER_PCIEFD)        +=3D kvaser_pciefd/
> +obj-$(CONFIG_CAN_LOONGSON_CANFD)       +=3D loongson_canfd.o
>  obj-$(CONFIG_CAN_MSCAN)                +=3D mscan/
>  obj-$(CONFIG_CAN_M_CAN)                +=3D m_can/
>  obj-$(CONFIG_CAN_PEAK_PCIEFD)  +=3D peak_canfd/
> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> index 000000000000..0e85005a9bb1
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -0,0 +1,1716 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * LOONGSON CANFD controller
> + *
> + * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/ethtool.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/skbuff.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#define LOONGSON_CANFD_DEVICE_ID       0x0     /* CANFD controller ID Re=
gister */
> +#define LOONGSON_CANFD_MODE            0x4     /* Mode Configuration Reg=
ister */
> +#define LOONGSON_CANFD_CONF            0x8     /* Configure Register */
> +#define LOONGSON_CANFD_STAT            0xc     /* Status Register */
> +#define LOONGSON_CANFD_CMD             0x10    /* Command Register */
> +#define LOONGSON_CANFD_INT_STAT                0x14    /* Interrupt Stat=
us Register */
> +#define LOONGSON_CANFD_INT_ENA         0x18    /* Interrupt Enable Regis=
ter */
> +#define LOONGSON_CANFD_INT_MASK                0x1c    /* Interrupt Mask=
 Register */
> +#define LOONGSON_CANFD_BTR_NORM                0x20    /* Normal Rate Co=
nfiguration Register */
> +#define LOONGSON_CANFD_BTR_FD          0x24    /* FD Data Rate Configura=
tion Register */
> +#define LOONGSON_CANFD_ERL             0x28    /* Error Threshold Config=
uration Register */
> +#define LOONGSON_CANFD_FSTAT           0x2c    /* Error Status Register =
*/
> +#define LOONGSON_CANFD_ERC             0x30    /* Error Count Register *=
/
> +#define LOONGSON_CANFD_BRE             0x34    /* Rate Error Count Regis=
ter */
> +#define LOONGSON_CANFD_CTR_PRES                0x38    /* Error Count De=
bug Register */
> +#define LOONGSON_CANFD_ERR_CAPT                0x3c    /* Error Capture =
Status Register */
> +#define LOONGSON_CANFD_RETX_CNT                0x40    /* Retransmission=
 Count Register */
> +#define LOONGSON_CANFD_ALC             0x44    /* Lost Arbitration Captu=
re Register */
> +#define LOONGSON_CANFD_TRV_DLY         0x48    /* Transmission Delay Mea=
surement Register */
> +#define LOONGSON_CANFD_SSP_CFG         0x4c    /* Second Sampling Point =
Configuration Register */
> +#define LOONGSON_CANFD_RX_FR_CNT       0x50    /* Receive Message Count =
Register */
> +#define LOONGSON_CANFD_TX_FR_CNT       0x54    /* Transmit Message Count=
 Register */
> +#define LOONGSON_CANFD_DEBUG           0x58    /* Debug Register */
> +#define LOONGSON_CANFD_TS              0x5c    /* Timestamp Register */
> +#define LOONGSON_CANFD_TX_FRM_TST      0x60    /* Transmit Message Debug=
 Register */
> +#define LOONGSON_CANFD_FRC_DIV         0x64    /* Fractional Divider Rat=
io Register */
> +#define LOONGSON_CANFD_FLT_A_MASK      0x68    /* Filter A Mask Register=
 */
> +#define LOONGSON_CANFD_FLT_A_VAL       0x6c    /* Filter A value Registe=
r */
> +#define LOONGSON_CANFD_FLT_B_MASK      0x70    /* Filter B Mask Register=
 */
> +#define LOONGSON_CANFD_FLT_B_VAL       0x74    /* Filter B value Registe=
r */
> +#define LOONGSON_CANFD_FLT_C_MASK      0x78    /* Filter C Mask Register=
 */
> +#define LOONGSON_CANFD_FLT_C_VAL       0x7c    /* Filter C value Registe=
r */
> +#define LOONGSON_CANFD_FLT_R_LOW       0x80    /* Range Filter Low Thres=
hold Register */
> +#define LOONGSON_CANFD_FLT_R_HI                0x84    /* Range Filter H=
igh Threshold Register */
> +#define LOONGSON_CANFD_FLT_CTRL                0x88    /* Filter Control=
 Register */
> +#define LOONGSON_CANFD_RX_MEM_INFO     0x8c    /* Receive Buffer Informa=
tion Register */
> +#define LOONGSON_CANFD_RX_PRT          0x90    /* Receive Buffer Pointer=
 Register */
> +#define LOONGSON_CANFD_RX_STAT         0x94    /* Receive Buffer Status =
Register */
> +#define LOONGSON_CANFD_RX_DATA         0x98    /* Receive Data Register =
*/
> +#define LOONGSON_CANFD_TX_STAT         0x9c    /* Transmit Buffer Status=
 Register */
> +#define LOONGSON_CANFD_TX_CMD          0xa0    /* Transmit Command Regis=
ter */
> +#define LOONGSON_CANFD_TX_SEL          0xa4    /* Transmit Buffer Select=
ion Register */
> +#define LOONGSON_CANFD_TX_DATA_1       0xb0
> +#define LOONGSON_CANFD_TX_DATA_18      0xf4
> +
> +/* Bitfields of CANFD controller ID register */
> +#define REG_ID_MASK                    GENMASK(15, 0)
> +#define REG_ID_VER_MIN                 GENMASK(23, 16)
> +#define REG_ID_VER_MAJ                 GENMASK(31, 24)
> +
> +/* Bitfields of Mode Configuration register */
> +#define REG_MODE_RST                   BIT(0)  /* Soft Reset */
> +#define REG_MODE_BMM                   BIT(1)  /* Bus Monitoring Mode */
> +#define REG_MODE_STM                   BIT(2)  /* Self-Test Mode */
> +#define REG_MODE_AFM                   BIT(3)  /* Receive Filter Mode */
> +#define REG_MODE_FDE                   BIT(4)  /* CANFD Enabled */
> +#define REG_MODE_TTTM                  BIT(5)  /* Timed Transmission Mod=
e */
> +#define REG_MODE_ROM                   BIT(6)  /* Restricted Operation M=
ode */
> +#define REG_MODE_ACF                   BIT(7)  /* No ACK Mode*/
> +#define REG_MODE_TSTM                  BIT(8)  /* Test Mode */
> +#define REG_MODE_RXBAM                 BIT(9)  /* Receive Buffer Auto Mo=
de */
> +#define REG_MODE_ITSM                  BIT(10) /* Internal Timestamp Mod=
e */
> +#define REG_MODE_RTSOP                 BIT(12) /* Receive Buffer Timesta=
mp Addition Mode */
> +#define REG_MODE_BUFM                  BIT(13) /* Transmit Buffer Mode *=
/
> +
> +/* Bitfields of Configure register */
> +#define REG_CONF_RTRLE                 BIT(0)  /* Retransmission Thresho=
ld Enable */
> +#define REG_CONF_RTRTH                 GENMASK(4, 1)   /* Retransmission=
 Threshold */
> +#define REG_CONF_ILBP                  BIT(5)  /* Internal Loopback Mode=
 */
> +#define REG_CONF_ENA                   BIT(6)  /* Controller Enable */
> +#define REG_CONF_NISOFD                        BIT(7)  /* NON-ISO CANFD =
Protocol Enable */
> +#define REG_CONF_PEX                   BIT(8)  /* Protocol Exception Han=
dling */
> +#define REG_CONF_FDRF                  BIT(10) /* Ignore Remote Frame En=
able */
> +
> +/* Bitfields of Status register */
> +#define REG_STAT_RXNE                  BIT(0)  /* Receive Buffer Not Emp=
ty Status */
> +#define REG_STAT_DOR                   BIT(1)  /* Receive Data Overflow =
Status */
> +#define REG_STAT_EFT                   BIT(3)  /* Error Frame Flag */
> +#define REG_STAT_RXS                   BIT(4)  /* Receive Status Flag */
> +#define REG_STAT_TXS                   BIT(5)  /* Transmission Status Fl=
ag */
> +#define REG_STAT_EWL                   BIT(6)  /* Transmission Error Thr=
eshold Flag */
> +#define REG_STAT_IDLE                  BIT(7)  /* Bus Idle Flag */
> +#define REG_STAT_PEXS                  BIT(8)  /* Protocol Exception Sta=
tus */
> +#define REG_STAT_STCNT                 BIT(16) /* Transmission Count Sup=
port */
> +
> +/* Bitfields of Command register */
> +#define REG_CMD_RXRPMV                 BIT(1)  /* Receive Buffer Read-to=
-Move */
> +#define REG_CMD_RRB                    BIT(2)  /* Receive Buffer Release=
 */
> +#define REG_CMD_CDO                    BIT(3)  /* Received Data Overflow=
 Status Clear */
> +#define REG_CMD_ERCRST                 BIT(4)  /* Error Count Clear */
> +#define REG_CMD_RXFCRST                        BIT(5)  /* Receive Frame =
Count Clear */
> +#define REG_CMD_TXFCRST                        BIT(6)  /* Transmit Frame=
 Count Clear */
> +#define REG_CMD_CPEXS                  BIT(7)  /* Exception Status Clear=
 */
> +
> +/* Bitfields of Interrupt Status register */
> +#define REG_INT_STAT_RXI               BIT(0)  /* Message Reception Inte=
rrupt */
> +#define REG_INT_STAT_TXI               BIT(1)  /* Message Transmission I=
nterrupt */
> +#define REG_INT_STAT_EWLI              BIT(2)  /* Error Warning Threshol=
d Interrupt */
> +#define REG_INT_STAT_DOI               BIT(3)  /* Receive Data Overflow =
Interrupt */
> +#define REG_INT_STAT_FCSI              BIT(4)  /* Fault State Change Int=
errupt */
> +#define REG_INT_STAT_ALI               BIT(5)  /* Arbitration Loss Inter=
rupt */
> +#define REG_INT_STAT_BEI               BIT(6)  /* Bus Error Interrupt */
> +#define REG_INT_STAT_RXFI              BIT(7)  /* Receive Buffer Full In=
terrupt */
> +#define REG_INT_STAT_BSI               BIT(8)  /* Rate Switching Interru=
pt */
> +#define REG_INT_STAT_RBNEI             BIT(9)  /* Receive Buffer Not Emp=
ty Interrupt */
> +#define REG_INT_STAT_TXBHCI            BIT(10) /* Transmit Buffer Hardwa=
re Command Interrupt */
> +#define REG_INT_STAT_OFI               BIT(11) /* Overload Frame Transmi=
ssion Interrupt */
> +#define REG_INT_STAT_DMADI             BIT(12) /* Message DMA Transfer C=
omplete Interrupt */
> +
> +#define REG_INT_STAT_ERRORI            (REG_INT_STAT_EWLI | REG_INT_STAT=
_FCSI |\
> +                                        REG_INT_STAT_ALI | REG_INT_STAT_=
BEI)
> +
> +/* Bitfields of Interrupt Enable register */
> +#define REG_INT_ENA_SET                        GENMASK(12, 0)
> +#define REG_INT_ENA_CLR                        GENMASK(28, 16)
> +
> +/* Bitfields of Interrupt Mask register */
> +#define REG_INT_MASK_SET               GENMASK(12, 0)
> +#define REG_INT_MASK_CLR               GENMASK(28, 16)
> +
> +/* Bitfields of Normal Rate Configuration register */
> +#define REG_BTR_PROP                   GENMASK(6, 0)
> +#define REG_BTR_PH1                    GENMASK(12, 7)
> +#define REG_BTR_PH2                    GENMASK(18, 13)
> +#define REG_BTR_BRP                    GENMASK(22, 19)
> +#define REG_BTR_SJW                    GENMASK(31, 27)
> +
> +/* Bitfields of FD Data Rate Configuration register */
> +#define REG_BTR_FD_PROP                        GENMASK(6, 0)
> +#define REG_BTR_FD_PH1                 GENMASK(12, 7)
> +#define REG_BTR_FD_PH2                 GENMASK(18, 13)
> +#define REG_BTR_FD_BRP                 GENMASK(26, 19)
> +#define REG_BTR_FD_SJW                 GENMASK(31, 27)
> +
> +/* Bitfields of Error Threshold Configuration register */
> +#define REG_ERL_ERP                    GENMASK(7, 0)
> +#define REG_ERL_EW                     GENMASK(23, 16)
> +
> +/* Bitfields of Error Status register */
> +#define REG_FSTAT_ERA                  BIT(0)
> +#define REG_FSTAT_ERP                  BIT(1)
> +#define REG_FSTAT_BOF                  BIT(2)
> +
> +#define REG_FSTAT_MASK                 GENMASK(2, 0)
> +
> +/* Bitfields of Error Count register */
> +#define REG_ERC_TEC                    GENMASK(8, 0)
> +#define REG_ERC_REC                    GENMASK(24, 16)
> +
> +/* Bitfields of Rate Error Count register */
> +#define REG_BRE_NORM                   GENMASK(15, 0)
> +#define REG_BRE_FD_DATA                        GENMASK(31, 16)
> +
> +/* Bitfields of Error Count Debug register */
> +#define REG_CTR_PRES_CTPV              GENMASK(8, 0)
> +#define REG_CTR_PRES_PTX               BIT(9)
> +#define REG_CTR_PRES_PRX               BIT(10)
> +
> +/* Bitfields of Error Capture Status register */
> +#define REG_ERR_CAPT_POS               GENMASK(4, 0)
> +#define REG_ERR_CAPT_TYPE              GENMASK(7, 5)
> +
> +/* Bitfields of Retransmission Count register */
> +#define REG_RETX_CNT_VAL               GENMASK(3, 0)
> +
> +/* Bitfields of Lost Arbitration Capture register */
> +#define REG_ALC_BIT_POS                        GENMASK(4, 0)
> +#define REG_ALC_ID_FIELD               GENMASK(7, 5)
> +
> +/* Bitfields of Transmission Delay Measurement register */
> +#define REG_TRV_DLY_VAL                        GENMASK(6, 0)
> +
> +/* Bitfields of Second Sampling Point Configuration register */
> +#define REG_SSP_CFG_OFF                        GENMASK(7, 0)
> +#define REG_SSP_CFG_SRC                        GENMASK(9, 8)
> +#define REG_SSP_CFG_SAT                        BIT(10)
> +
> +/* Bitfields of Receive Message Count register */
> +#define REG_RX_FR_CNT_VAL              GENMASK(31, 0)
> +
> +/* Bitfields of Transmit Message Count register */
> +#define REG_TX_FR_CNT_VAL              GENMASK(31, 0)
> +
> +/* Bitfields of Debug register */
> +#define REG_DEBUG_STF_CNT              GENMASK(2, 0)
> +#define REG_DEBUG_DSTF_CNT             GENMASK(5, 3)
> +#define REG_DEBUG_PC_ARB               BIT(6)
> +#define REG_DEBUG_PC_CON               BIT(7)
> +#define REG_DEBUG_PC_DAT               BIT(8)
> +#define REG_DEBUG_PC_STC               BIT(9)
> +#define REG_DEBUG_PC_CRC               BIT(10)
> +#define REG_DEBUG_PC_CRCD              BIT(11)
> +#define REG_DEBUG_PC_ACK               BIT(12)
> +#define REG_DEBUG_PC_ACKD              BIT(13)
> +#define REG_DEBUG_PC_EOF               BIT(14)
> +#define REG_DEBUG_PC_INT               BIT(15)
> +#define REG_DEBUG_PC_SUSP              BIT(16)
> +#define REG_DEBUG_PC_OVR               BIT(17)
> +#define REG_DEBUG_PC_SOF               BIT(18)
> +
> +/* Bitfields of Timestamp register */
> +#define REG_TS_TIMESTAMP               GENMASK(15, 0)
> +#define REG_TS_PSC                     GENMASK(24, 16)
> +
> +/* Bitfields of Fractional Divider Ratio register */
> +#define REG_FRC_FRC_DBT                        GENMASK(15, 8)
> +#define REG_FRC_FRC_NBT                        GENMASK(7, 0)
> +
> +/* Bitfields of Filter A Mask register */
> +#define REG_FIL_A_MASK                 GENMASK(28, 0)
> +
> +/* Bitfields of Filter A value register */
> +#define REG_FIL_A_VAL                  GENMASK(28, 0)
> +
> +/* Bitfields of Filter B Mask register */
> +#define REG_FIL_B_MASK                 GENMASK(28, 0)
> +
> +/* Bitfields of Filter B value register */
> +#define REG_FIL_B_VAL                  GENMASK(28, 0)
> +
> +/* Bitfields of Filter C Mask register */
> +#define REG_FIL_C_MASK                 GENMASK(28, 0)
> +
> +/* Bitfields of Filter C value register */
> +#define REG_FIL_C_VAL                  GENMASK(28, 0)
> +
> +/* Bitfields of Range Filter Low Threshold register */
> +#define REG_FIL_R_LOW_VAL              GENMASK(28, 0)
> +
> +/* Bitfields of Range Filter High Threshold register */
> +#define REG_FIL_R_HI_VAL               GENMASK(28, 0)
> +
> +/* Bitfields of Filter Control register */
> +#define REG_FIL_CTRL_FANB              BIT(0)
> +#define REG_FIL_CTRL_FANE              BIT(1)
> +#define REG_FIL_CTRL_FAFB              BIT(2)
> +#define REG_FIL_CTRL_FAFE              BIT(3)
> +#define REG_FIL_CTRL_FBNB              BIT(4)
> +#define REG_FIL_CTRL_FBNE              BIT(5)
> +#define REG_FIL_CTRL_FBFB              BIT(6)
> +#define REG_FIL_CTRL_FBFE              BIT(7)
> +#define REG_FIL_CTRL_FCNB              BIT(8)
> +#define REG_FIL_CTRL_FCNE              BIT(9)
> +#define REG_FIL_CTRL_FCFB              BIT(10)
> +#define REG_FIL_CTRL_FCFE              BIT(11)
> +#define REG_FIL_CTRL_FRNB              BIT(12)
> +#define REG_FIL_CTRL_FRNE              BIT(13)
> +#define REG_FIL_CTRL_FRFB              BIT(14)
> +#define REG_FIL_CTRL_FRFE              BIT(15)
> +#define REG_FIL_CTRL_SFA               BIT(16)
> +#define REG_FIL_CTRL_SFB               BIT(17)
> +#define REG_FIL_CTRL_SFC               BIT(18)
> +#define REG_FIL_CTRL_SFR               BIT(19)
> +
> +/* Bitfields of Receive Buffer Information register */
> +#define REG_RX_MEM_INFO_BUFF_SIZE      GENMASK(12, 0)
> +#define REG_RX_MEM_INFO_MEM_FREE       GENMASK(28, 16)
> +
> +/* Bitfields of Receive Buffer Pointer register */
> +#define REG_RX_PTR_WPP                 GENMASK(11, 0)
> +#define REG_RX_PTR_RPP                 GENMASK(27, 16)
> +
> +/* Bitfields of Receive Buffer Status register */
> +#define REG_RX_STAT_RXE                        BIT(0)
> +#define REG_RX_STAT_RXF                        BIT(1)
> +#define REG_RX_STAT_RXMOF              BIT(2)
> +#define REG_RX_STAT_RXFRC              GENMASK(14, 4)
> +#define REG_RX_STAT_RTSOP              BIT(16)
> +
> +/* Bitfields of Receive Data register */
> +#define REG_RX_DATA_VAL                        GENMASK(31, 0)
> +
> +/* Bitfields of Transmit Buffer Status register */
> +#define REG_TX_STAT_BRP                        GENMASK(7, 0)
> +#define REG_TX_STAT_TXS                        GENMASK(10, 8)
> +#define REG_TX_STAT_BS                 GENMASK(31, 16)
> +
> +#define REG_TX_STAT_BS_TX_MASK_BASE    GENMASK(17, 16)
> +
> +/* Bitfields of Transmit Command register */
> +#define REG_TX_CMD_BAR                 GENMASK(7, 0)
> +#define REG_TX_CMD_BCR                 GENMASK(15, 8)
> +#define REG_TX_CMD_BSC                 GENMASK(23, 16)
> +
> +/* Bitfields of Transmit Buffer Selection register */
> +#define REG_TX_SEL_BUF_SEL             GENMASK(3, 0)
> +#define REG_TX_SEL_BUF_CNT             GENMASK(7, 4)
> +
> +/* Loongson CANFD Frame format */
> +#define LOONGSON_CANFD_FRAME_META0     0x0
> +#define LOONGSON_CANFD_FRAME_META1     0x4
> +#define LOONGSON_CANFD_FRAME_DB_1      0x8
> +
> +/* Bitfields of FRAME META0 */
> +#define REG_FRAME_META0_ID_EXT         GENMASK(17, 0)
> +#define REG_FRAME_META0_ID_BASE                GENMASK(28, 18)
> +#define REG_FRAME_META0_RTR            BIT(29) /* Remote Transmission Re=
quest, only in CAN2.0 */
> +/* Extended Identifier Type. 1: 29 bits ID, 0: 11 bits ID. */
> +#define REG_FRAME_META0_XDT            BIT(30)
> +#define REG_FRAME_META0_ESI            BIT(31) /* Error State Indicator,=
 only in CAN-FD */
> +
> +/* Bitfields of FRAME META1 */
> +#define REG_FRAME_META1_TIMESTAMP      GENMASK(15, 0)
> +#define REG_FRAME_META1_DLC            GENMASK(19, 16) /* Data Length Co=
de */
> +#define REG_FRAME_META1_BRS            BIT(20) /* Bit Rate Shift, Only i=
n CANFD */
> +/* Flexible Data-rate Format. 1: CANFD, 0: CAN2.0 */
> +#define REG_FRAME_META1_FDF            BIT(21)
> +#define REG_FRAME_META1_RWCNT          GENMASK(28, 24) /* Read Word Coun=
ter */
> +
> +/* Bitfields of FRAME TEST */
> +#define REG_FRAME_TEST_FSTC            BIT(0)
> +#define REG_FRAME_TEST_FCRC            BIT(1)
> +#define REG_FRAME_TEST_SDLC            BIT(2)
> +#define REG_FRAME_TEST_TPRM            GENMASK(12, 8)
> +
> +#define DEV_NAME                       "loongson_canfd"
> +#define LOONGSON_CANFD_ID              0xBABE
> +#define LOONGSON_CANFD_DW_BYTE         4
> +#define LOONGSON_CANFD_TXBUF_NUM       8
> +#define LOONGSON_CANFD_MAX_RTXTH       0xf
> +
> +/**
> + * struct loongson_canfd_priv - This definition define CAN driver instan=
ce
> + * @can: CAN private data structure.
> + * @napi: NAPI structure
> + * @regmap: regmap of the CAN device
> + * @res: Pointer to the CAN device respurce
> + * @tx_lock: Lock for synchronizing TX interrupt handling
> + */
> +struct loongson_canfd_priv {
> +       struct can_priv         can;            /* must be first member! =
*/
> +       struct napi_struct      napi;
> +       struct regmap           *regmap;
> +       struct resource         *res;
> +       spinlock_t              tx_lock;        /* protect the sending qu=
eue */
> +};
> +
> +/**
> + * enum loongson_canfd_txbuf_sts - status of TX buffer
> + * @TX_BS_IDLE: Status processed or not sent.
> + * @TX_BS_VALID: Sending successful.
> + * @TX_BS_FAIL: Sending failed.
> + * @TX_BS_CANCEL: Sending cancelled.
> + */
> +enum loongson_canfd_txbuf_sts {
> +       TX_BS_IDLE      =3D 0x0,
> +       TX_BS_VALID     =3D 0x1,
> +       TX_BS_FAIL      =3D 0x2,
> +       TX_BS_CANCEL    =3D 0x3
> +};
> +
> +/**
> + * enum loongson_canfd_txbuf_cmd - command of TX buffer
> + * @TXT_CMD_ADD: Buffer add request.
> + * @TXT_CMD_CANCEL: Buffer cancel request.
> + * @TXT_CMD_SR_CLEAN: Buffer send record clear.
> + *     1: to clear the send completion record (LOONGSON_CANFD_TX_STAT[BS=
]).
> + */
> +enum loongson_canfd_txbuf_cmd {
> +       TXT_CMD_ADD             =3D 0x01,
> +       TXT_CMD_CANCEL          =3D 0x02,
> +       TXT_CMD_SR_CLEAN        =3D 0x03
> +};
> +
> +static const struct can_bittiming_const loongson_canfd_bit_timing =3D {
> +       .name           =3D DEV_NAME,
> +       .tseg1_min      =3D 2,
> +       .tseg1_max      =3D 63,
> +       .tseg2_min      =3D 2,
> +       .tseg2_max      =3D 63,
> +       .sjw_max        =3D 31,
> +       .brp_min        =3D 1,
> +       .brp_max        =3D 15,
> +       .brp_inc        =3D 1,
> +};
> +
> +static const struct can_bittiming_const loongson_canfd_bit_timing_data =
=3D {
> +       .name           =3D DEV_NAME,
> +       .tseg1_min      =3D 2,
> +       .tseg1_max      =3D 63,
> +       .tseg2_min      =3D 2,
> +       .tseg2_max      =3D 63,
> +       .sjw_max        =3D 31,
> +       .brp_min        =3D 1,
> +       .brp_max        =3D 255,
> +       .brp_inc        =3D 1,
> +};
> +
> +/* CAN FD Transmission Delay Compensation constants */
> +static const struct can_tdc_const loongson_canfd_tdc_data =3D {
> +       .tdcv_min       =3D 0,
> +       .tdcv_max       =3D 0,
> +       .tdco_min       =3D 1,
> +       .tdco_max       =3D 127,
> +       .tdcf_min       =3D 0,    /* Filter window not supported */
> +       .tdcf_max       =3D 0,
> +};
> +
> +/**
> + * loongson_canfd_enabled() - Gets the controller is enabled
> + * @priv: Pointer to private data
> + *
> + * Return: True - the controller is enabled.
> + *        False - the controller is disabled.
> + */
> +static bool loongson_canfd_enabled(struct loongson_canfd_priv *priv)
> +{
> +       return !!regmap_test_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_=
CONF_ENA);
> +}
> +
> +/**
> + * loongson_canfd_txbuf_freed() - Gets the flag for TX buffer to be sent
> + * @priv: Pointer to private data
> + *
> + * Return: True - TX buffer is empty.
> + *        False - TX buffer is processing
> + */
> +static bool loongson_canfd_txbuf_freed(struct loongson_canfd_priv *priv)
> +{
> +       return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, RE=
G_TX_STAT_BRP);
> +}
> +
> +/**
> + * loongson_canfd_disable_interrupts() - Disable all interrupts
> + * @priv: Pointer to private data
> + */
> +static void loongson_canfd_disable_interrupts(struct loongson_canfd_priv=
 *priv)
> +{
> +       regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, FIELD_MAX(REG_=
INT_ENA_CLR) << 16);
> +       regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, FIELD_MAX(REG=
_INT_MASK_SET));
> +}
> +
> +/**
> + * loongson_canfd_get_txbuf_sts() - Gets status of TX buffer
> + * @priv: Pointer to private data
> + * @buf_id: Buffer index (0-based)
> + *
> + * Return: Status of TX buffer
> + */
> +static enum loongson_canfd_txbuf_sts
> +loongson_canfd_get_txbuf_sts(struct loongson_canfd_priv *priv, u8 buf_id=
)
> +{
> +       u32 sts, mask;
> +
> +       mask =3D REG_TX_STAT_BS_TX_MASK_BASE << 2 * buf_id;
> +       regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &sts);
> +
> +       return field_get(mask, sts);
> +}
> +
> +/**
> + * loongson_canfd_get_txbuf_id() - Gets the index of a non-idle TX buffe=
r
> + * @priv: Pointer to private data
> + * @sts: Status of TXT buffer to outside
> + *
> + * Return: Buffer index (0-based)
> + */
> +static unsigned int loongson_canfd_get_txbuf_id(struct loongson_canfd_pr=
iv *priv,
> +                                               enum loongson_canfd_txbuf=
_sts *sts)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < LOONGSON_CANFD_TXBUF_NUM; i++) {
> +               if (loongson_canfd_get_txbuf_sts(priv, i)) {
> +                       *sts =3D loongson_canfd_get_txbuf_sts(priv, i);
> +                       break;
> +               }
> +       }
> +
> +       if (i =3D=3D LOONGSON_CANFD_TXBUF_NUM)
> +               *sts =3D TX_BS_IDLE;
> +
> +       return i;
> +}
> +
> +/**
> + * loongson_canfd_txbuf_is_writable() - Checks if frame can be inserted =
to TX Buffer
> + * @priv: Pointer to private data
> + * @buf_id: Buffer index (0-based)
> + *
> + * Return: True - Frame can be inserted to TXT Buffer,
> + *        False - If attempted, frame will not be inserted to TX Buffer
> + */
> +static bool loongson_canfd_txbuf_is_writable(struct loongson_canfd_priv =
*priv, u8 buf_id)
> +{
> +       enum loongson_canfd_txbuf_sts bs;
> +
> +       bs =3D loongson_canfd_get_txbuf_sts(priv, buf_id);
> +       if (bs)
> +               return false;
> +
> +       return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, BI=
T(buf_id));
> +}
> +
> +/**
> + * loongson_canfd_set_txbuf_cmd() - Applies command on TX buffer
> + * @ndev: Pointer to net_device structure
> + * @cmd: Command to set
> + * @buf_id: Buffer index (0-based)
> + */
> +static void loongson_canfd_set_txbuf_cmd(struct net_device *ndev,
> +                                        enum loongson_canfd_txbuf_cmd cm=
d, u8 buf_id)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       u32 mask;
> +
> +       switch (cmd) {
> +       case TXT_CMD_ADD:
> +               mask =3D REG_TX_CMD_BAR;
> +               break;
> +       case TXT_CMD_CANCEL:
> +               mask =3D REG_TX_CMD_BCR;
> +               break;
> +       case TXT_CMD_SR_CLEAN:
> +               mask =3D REG_TX_CMD_BSC;
> +               break;
> +       default:
> +               netdev_err(ndev, "Unknown command id: %x\n", cmd);
> +               return;
> +       }
> +
> +       regmap_write(priv->regmap, LOONGSON_CANFD_TX_CMD, field_prep(mask=
, BIT(buf_id)));
> +}
> +
> +/**
> + * loongson_canfd_rxbuf_empty() - Gets the RX buffer is empty
> + * @priv: Pointer to private data
> + *
> + * Return: True - RX buffer is empty.
> + *        False - RX buffer is processing
> + */
> +static bool loongson_canfd_rxbuf_empty(struct loongson_canfd_priv *priv)
> +{
> +       return !!regmap_test_bits(priv->regmap, LOONGSON_CANFD_RX_STAT, R=
EG_RX_STAT_RXE);
> +}
> +
> +/**
> + * loongson_canfd_reset() - Issues software reset request to Loongson CA=
NFD
> + * @ndev: Pointer to net_device structure
> + */
> +static void loongson_canfd_reset(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +       regmap_write(priv->regmap, LOONGSON_CANFD_MODE, REG_MODE_RST);
> +       regmap_write(priv->regmap, LOONGSON_CANFD_MODE, REG_MODE_RXBAM | =
REG_MODE_BUFM);
> +}
> +
> +/**
> + * loongson_canfd_set_btr() - Sets CAN bus bit timing in Loongson CANFD
> + * @ndev: Pointer to net_device structure
> + * @bt: Pointer to Bit timing structure
> + * @nominal: True - Nominal bit timing, False - Data bit timing
> + */
> +static void loongson_canfd_set_btr(struct net_device *ndev, struct can_b=
ittiming *bt, bool nominal)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       u32 ph1_max =3D FIELD_MAX(REG_BTR_PH1);
> +       u32 btr =3D 0;
> +
> +       /*
> +        * The timing calculation functions have only constraints on tseg=
1,
> +        * which is prop_seg + phase1_seg combined.
> +        * tseg1 is then split in half and stored into prog_seg and phase=
_seg1.
> +        * In Loongson CAN-FD, PROP is 7 bits wide but PH1 only 6, so we =
must
> +        * re-distribute the values here.
> +        */
> +       if (bt->phase_seg1 > ph1_max) {
> +               bt->prop_seg +=3D bt->phase_seg1 - ph1_max;
> +               bt->phase_seg1 =3D ph1_max;
> +       }
> +
> +       if (nominal) {
> +               btr =3D FIELD_PREP(REG_BTR_PROP, bt->prop_seg) |
> +                     FIELD_PREP(REG_BTR_PH1, bt->phase_seg1) |
> +                     FIELD_PREP(REG_BTR_PH2, bt->phase_seg2) |
> +                     FIELD_PREP(REG_BTR_BRP, bt->brp) |
> +                     FIELD_PREP(REG_BTR_SJW, bt->sjw);
> +
> +               regmap_write(priv->regmap, LOONGSON_CANFD_BTR_NORM, btr);
> +       } else {
> +               btr =3D FIELD_PREP(REG_BTR_FD_PROP, bt->prop_seg) |
> +                     FIELD_PREP(REG_BTR_FD_PH1, bt->phase_seg1) |
> +                     FIELD_PREP(REG_BTR_FD_PH2, bt->phase_seg2) |
> +                     FIELD_PREP(REG_BTR_FD_BRP, bt->brp) |
> +                     FIELD_PREP(REG_BTR_FD_SJW, bt->sjw);
> +
> +               regmap_write(priv->regmap, LOONGSON_CANFD_BTR_FD, btr);
> +       }
> +}
> +
> +/**
> + * loongson_canfd_set_bittiming() - CAN set nominal bit timing routine
> + * @ndev: Pointer to net_device structure
> + *
> + * Return: 0 on success, -%EPERM on error
> + */
> +static int loongson_canfd_set_bittiming(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       struct can_bittiming *bt =3D &priv->can.bittiming;
> +
> +       /* Note that bt may be modified here */
> +       loongson_canfd_set_btr(ndev, bt, true);
> +
> +       return 0;
> +}
> +
> +/**
> + * loongson_canfd_set_data_bittiming() - CAN set data bit timing routine
> + * @ndev: Pointer to net_device structure
> + *
> + * Return: 0 on success, -%EPERM on error
> + */
> +static int loongson_canfd_set_data_bittiming(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       struct can_bittiming *dbt =3D &priv->can.fd.data_bittiming;
> +
> +       /* Note that dbt may be modified here */
> +       loongson_canfd_set_btr(ndev, dbt, false);
> +
> +       return 0;
> +}
> +
> +/**
> + * loongson_canfd_get_auto_tdcv - Get Transmitter Delay Compensation Val=
ue
> + * @ndev: Pointer to net_device structure
> + * @tdcv: Pointer to TDCV value
> + *
> + * Return: 0 on success
> + */
> +static int loongson_canfd_get_auto_tdcv(const struct net_device *ndev, u=
32 *tdcv)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       u32 val;
> +
> +       regmap_read(priv->regmap, LOONGSON_CANFD_TRV_DLY, &val);
> +       *tdcv =3D FIELD_GET(REG_TRV_DLY_VAL, val);
> +
> +       return 0;
> +}
> +
> +/**
> + * loongson_canfd_set_secondary_sample_point() - Set secondary sample po=
int in Loongson CANFD
> + * @ndev: Pointer to net_device structure
> + *
> + * Return: 0 on success, -%EPERM if controller is enabled
> + */
> +static int loongson_canfd_set_secondary_sample_point(struct net_device *=
ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       u32 ssp_cfg;
> +
> +       if (loongson_canfd_enabled(priv)) {
> +               netdev_err(ndev, "BUG! Cannot set SSP - CAN is enabled\n"=
);
> +               return -EPERM;
> +       }
> +
> +       if (can_fd_tdc_is_enabled(&priv->can))
> +               ssp_cfg =3D FIELD_PREP(REG_SSP_CFG_OFF, priv->can.fd.tdc.=
tdco) |
> +                         FIELD_PREP(REG_SSP_CFG_SRC, 0x0);
> +       else
> +               ssp_cfg =3D FIELD_PREP(REG_SSP_CFG_SRC, 0x1);
> +
> +       regmap_write(priv->regmap, LOONGSON_CANFD_SSP_CFG, ssp_cfg);
> +
> +       return 0;
> +}
> +
> +/**
> + * loongson_canfd_set_conf_mode() - Sets Loongson CANFD mode and configu=
re registers
> + * @priv: Pointer to private data
> + */
> +static void loongson_canfd_set_conf_mode(struct loongson_canfd_priv *pri=
v)
> +{
> +       u32 ctrlmode =3D priv->can.ctrlmode;
> +       u32 mode, conf;
> +
> +       regmap_read(priv->regmap, LOONGSON_CANFD_MODE, &mode);
> +
> +       if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +               mode |=3D REG_MODE_BMM;
> +       else
> +               mode &=3D ~REG_MODE_BMM;
> +
> +       if (ctrlmode & CAN_CTRLMODE_FD)
> +               mode |=3D REG_MODE_FDE;
> +       else
> +               mode &=3D ~REG_MODE_FDE;
> +
> +       if (ctrlmode & CAN_CTRLMODE_PRESUME_ACK)
> +               mode |=3D REG_MODE_ACF;
> +       else
> +               mode &=3D ~REG_MODE_ACF;
> +
> +       /*
> +        * Some bits fixed:
> +        * TSTM - Off, User shall not be able to change REC/TEC by hand
> +        * during operation
> +        */
> +       mode &=3D ~REG_MODE_TSTM;
> +       regmap_write(priv->regmap, LOONGSON_CANFD_MODE, mode);
> +
> +       regmap_read(priv->regmap, LOONGSON_CANFD_CONF, &conf);
> +
> +       if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +               conf |=3D REG_CONF_ILBP;
> +       else
> +               conf &=3D ~REG_CONF_ILBP;
> +
> +       if (ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> +               conf |=3D REG_CONF_NISOFD;
> +       else
> +               conf &=3D ~REG_CONF_NISOFD;
> +
> +       /* One shot mode supported indirectly via Retransmit limit */
> +       conf &=3D ~FIELD_PREP(REG_CONF_RTRTH, LOONGSON_CANFD_MAX_RTXTH);
> +
> +       if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +               conf |=3D REG_CONF_RTRLE;
> +       else
> +               conf |=3D REG_CONF_RTRLE | FIELD_PREP(REG_CONF_RTRTH, LOO=
NGSON_CANFD_MAX_RTXTH);
> +
> +       regmap_write(priv->regmap, LOONGSON_CANFD_CONF, conf);
> +}
> +
> +/**
> + * loongson_canfd_chip_start() - This routine starts the driver
> + * @ndev: Pointer to net_device structure
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int loongson_canfd_chip_start(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       u16 int_ena, int_msk;
> +       int ret;
> +
> +       /* Configure bit-rates and ssp */
> +       ret =3D loongson_canfd_set_bittiming(ndev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D loongson_canfd_set_data_bittiming(ndev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D loongson_canfd_set_secondary_sample_point(ndev);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Setting mode and configure registers */
> +       loongson_canfd_set_conf_mode(priv);
> +
> +       /* Configure interrupts */
> +       int_ena =3D REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
> +                 REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
> +
> +       /* Bus error reporting */
> +       if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +               int_ena |=3D REG_INT_STAT_ALI | REG_INT_STAT_BEI;
> +
> +       int_msk =3D FIELD_GET(REG_INT_MASK_SET, ~int_ena); /* Mask all di=
sabled interrupts */
> +
> +       /* It's after reset, so there is no need to clear anything */
> +       regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, int_msk);
> +       regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, int_ena);
> +
> +       /* Controller enters ERROR_ACTIVE on initial FCSI */
> +       priv->can.state =3D CAN_STATE_STOPPED;
> +
> +       /* Enable the controller */
> +       regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_EN=
A, REG_CONF_ENA);
> +
> +       return 0;
> +}
> +
> +/**
> + * loongson_canfd_do_set_mode() - Sets mode of the driver
> + * @ndev: Pointer to net_device structure
> + * @mode: Tells the mode of the driver
> + *
> + * This check the drivers state and calls the corresponding modes to set=
.
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int loongson_canfd_do_set_mode(struct net_device *ndev, enum can_=
mode mode)
> +{
> +       int ret;
> +
> +       switch (mode) {
> +       case CAN_MODE_START:
> +               loongson_canfd_reset(ndev);
> +
> +               ret =3D loongson_canfd_chip_start(ndev);
> +               if (ret < 0) {
> +                       netdev_err(ndev, "loongson_canfd_chip_start faile=
d!\n");
> +                       return ret;
> +               }
> +
> +               netif_wake_queue(ndev);
> +               break;
> +       default:
> +               ret =3D -EOPNOTSUPP;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * loongson_canfd_insert_frame() - Inserts frame to TXT buffer
> + * @priv: Pointer to private data
> + * @cf:         Pointer to CAN frame to be inserted
> + * @buf: TXT Buffer index to which frame is inserted (0-based)
> + * @isfdf: True - CAN FD Frame, False - CAN 2.0 Frame
> + *
> + * Return:
> + * * True - Frame inserted successfully
> + * * False - Frame was not inserted due to one of:
> + *     1. TXT Buffer is not writable (it is in wrong state)
> + *     2. Invalid TXT buffer index
> + *     3. Invalid frame length
> + */
> +static bool loongson_canfd_insert_frame(struct loongson_canfd_priv *priv=
,
> +                                       const struct canfd_frame *cf, u8 =
buf, bool isfdf)
> +{
> +       u32 meta0, meta1 =3D 0;
> +
> +       if (buf >=3D LOONGSON_CANFD_TXBUF_NUM)
> +               return false;
> +
> +       if (!loongson_canfd_txbuf_is_writable(priv, buf))
> +               return false;
> +
> +       /* Prepare identifier */
> +       if (cf->can_id & CAN_EFF_FLAG) {
> +               meta0 =3D cf->can_id & CAN_EFF_MASK;
> +               meta0 |=3D REG_FRAME_META0_XDT;
> +       } else {
> +               meta0 =3D FIELD_PREP(REG_FRAME_META0_ID_BASE, cf->can_id =
& CAN_SFF_MASK);
> +       }
> +
> +       /* Prepare Frame format */
> +       if (cf->can_id & CAN_RTR_FLAG)
> +               meta0 |=3D REG_FRAME_META0_RTR;
> +
> +       if (isfdf) {
> +               meta1 =3D REG_FRAME_META1_FDF;
> +
> +               if (cf->flags & CANFD_BRS)
> +                       meta1 |=3D REG_FRAME_META1_BRS;
> +       }
> +
> +       meta1 |=3D FIELD_PREP(REG_FRAME_META1_DLC, can_fd_len2dlc(cf->len=
));
> +
> +       /* TXT buffer select */
> +       regmap_write(priv->regmap, LOONGSON_CANFD_TX_SEL, buf);
> +
> +       /* Write ID, Frame format */
> +       regmap_write(priv->regmap, LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CA=
NFD_FRAME_META0, meta0);
> +       regmap_write(priv->regmap, LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CA=
NFD_FRAME_META1, meta1);
> +
> +       if (cf->can_id & CAN_RTR_FLAG)
> +               return true;
> +
> +       /* Write Data payload */
> +       for (unsigned int i =3D 0; i < cf->len; i +=3D LOONGSON_CANFD_DW_=
BYTE) {
> +               regmap_write(priv->regmap,
> +                            LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_FR=
AME_DB_1 + i,
> +                            *(u32 *)(cf->data + i));
> +       }
> +
> +       return true;
> +}
> +
> +/**
> + * loongson_canfd_start_xmit() - Starts the transmission
> + * @skb: sk_buff pointer that contains data to be Txed
> + * @ndev: Pointer to net_device structure
> + *
> + * Invoked from upper layers to initiate transmission. Uses the next ava=
ilable free TX Buffer and
> + * populates its fields to start the transmission.
> + *
> + * Return: %NETDEV_TX_OK on success,
> + *         %NETDEV_TX_BUSY when no free TX buffer is available, negative=
 return values reserved
> + *         for error cases.
> + */
> +static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
> +{
> +       struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       u32 buf_id =3D 0, tx_stat, i =3D 0;
> +       unsigned long tx_brp;
> +       u16 tx_bs;
> +
> +       if (can_dropped_invalid_skb(ndev, skb))
> +               return NETDEV_TX_OK;
> +
> +       guard(spinlock_irqsave)(&priv->tx_lock);
> +
> +       if (unlikely(!loongson_canfd_txbuf_freed(priv))) {
> +               netif_stop_queue(ndev);
> +               netdev_err(ndev, "BUG!, no TXB free when queue awake!\n")=
;
> +               return NETDEV_TX_BUSY;
> +       }
> +
> +       regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &tx_stat);
> +       tx_brp =3D FIELD_GET(REG_TX_STAT_BRP, tx_stat);
> +       tx_bs =3D FIELD_GET(REG_TX_STAT_BS, tx_stat);
> +
> +       for_each_clear_bit(i, &tx_brp, LOONGSON_CANFD_TXBUF_NUM) {
> +               u32 transmission_complete_mask =3D 0x3 << (i * 2);
> +
> +               if (!(tx_bs & transmission_complete_mask)) {
> +                       buf_id =3D i;
> +                       break;
> +               }
> +       }
> +
> +       if (!loongson_canfd_insert_frame(priv, cf, buf_id, can_is_canfd_s=
kb(skb))) {
> +               netdev_err(ndev, "TXNF set but cannot insert frame into T=
XTB! HW Bug?");
> +               kfree_skb(skb);
> +               ndev->stats.tx_dropped++;
> +               return NETDEV_TX_OK;
> +       }
> +
> +       can_put_echo_skb(skb, ndev, buf_id, 0);
> +
> +       loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_ADD, buf_id);
> +
> +       /* Check if all TX buffers are full */
> +       if (!loongson_canfd_txbuf_freed(priv))
> +               netif_stop_queue(ndev);
> +
> +       return NETDEV_TX_OK;
> +}
> +
> +/**
> + * loongson_canfd_rx() -  Called from CAN ISR to complete the received f=
rame processing
> + * @ndev: Pointer to net_device structure
> + *
> + * This function is invoked from the CAN isr to process the Rx frames. I=
t does minimal
> + * processing and invokes "netif_receive_skb" to complete further proces=
sing.
> + * Return: 1 when frame is passed to the network layer, 0 when the first=
 frame word is read but
> + *        system is out of free SKBs temporally and left code to resolve=
 SKB allocation later,
> + *         -%EAGAIN in a case of empty Rx FIFO.
> + */
> +static int loongson_canfd_rx(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       struct net_device_stats *stats =3D &ndev->stats;
> +       u32 meta0, meta1, dlc, rwcnt, dbcnt, i, data;
> +       struct canfd_frame *cfd;
> +       struct can_frame *ccf;
> +       struct sk_buff *skb;
> +       bool is_can_fd;
> +
> +       regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
> +       regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
> +
> +       /* Number of characters received */
> +       rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
> +       if (!rwcnt)
> +               return -EAGAIN;
> +       dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;
> +
> +       /* Flexible Data-rate Format */
> +       is_can_fd =3D meta1 & REG_FRAME_META1_FDF;
> +       if (is_can_fd) {
> +               skb =3D alloc_canfd_skb(ndev, &cfd);
> +       } else {
> +               skb =3D alloc_can_skb(ndev, &ccf);
> +               cfd =3D (struct canfd_frame *)ccf;
> +       }
> +
> +       if (unlikely(!skb)) {
> +               for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
> +                       regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA,=
 &data);
> +               ndev->stats.rx_dropped++;
> +               return 0;
> +       }
> +
> +       /* Extended Identifier Type */
> +       if (meta0 & REG_FRAME_META0_XDT)
> +               cfd->can_id =3D (meta0 & CAN_EFF_MASK) | CAN_EFF_FLAG;
> +       else
> +               cfd->can_id =3D FIELD_GET(REG_FRAME_META0_ID_BASE, meta0)=
 & CAN_SFF_MASK;
> +
> +       /* BRS, ESI, RTR Flags */
> +       cfd->flags =3D 0;
> +
> +       if (is_can_fd) {
> +               if (meta1 & REG_FRAME_META1_BRS)
> +                       cfd->flags |=3D CANFD_BRS;
> +
> +               if (meta0 & REG_FRAME_META0_ESI)
> +                       cfd->flags |=3D CANFD_ESI;
> +       } else if (meta0 & REG_FRAME_META0_RTR) {
> +               cfd->can_id |=3D CAN_RTR_FLAG;
> +       }
> +
> +       /* Data Length Code */
> +       dlc =3D FIELD_GET(REG_FRAME_META1_DLC, meta1);
> +       if (is_can_fd)
> +               cfd->len =3D can_fd_dlc2len(dlc);
> +       else
> +               can_frame_set_cc_len(ccf, dlc, priv->can.ctrlmode);
> +
> +       /* Data */
> +       for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
> +               regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)=
(cfd->data + i));
> +
> +       while (unlikely(i < dbcnt)) {
> +               regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +               i +=3D LOONGSON_CANFD_DW_BYTE;
> +       }
> +
> +       if (!(cfd->can_id & CAN_RTR_FLAG))
> +               stats->rx_bytes +=3D cfd->len;
> +       stats->rx_packets++;
> +       netif_receive_skb(skb);
> +
> +       return 1;
> +}
> +
> +/**
> + * loongson_canfd_read_fault_state() - Reads Loongson CANFD fault state.
> + * @ndev: Pointer to net_device structure
> + *
> + * Returns: Fault confinement state of controller
> + */
> +static enum can_state loongson_canfd_read_fault_state(struct net_device =
*ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       enum can_state sts =3D CAN_STATE_ERROR_PASSIVE;
> +       u32 fstat;
> +
> +       regmap_read(priv->regmap, LOONGSON_CANFD_FSTAT, &fstat);
> +
> +       switch (FIELD_GET(REG_FSTAT_MASK, fstat)) {
> +       case REG_FSTAT_ERA:
> +               u32 ewl, erl, rec_tec, max_tec;
> +
> +               regmap_read(priv->regmap, LOONGSON_CANFD_ERL, &erl);
> +               regmap_read(priv->regmap, LOONGSON_CANFD_ERC, &rec_tec);
> +
> +               ewl =3D FIELD_GET(REG_ERL_EW, erl);
> +               max_tec =3D max(FIELD_GET(REG_ERC_REC, rec_tec), FIELD_GE=
T(REG_ERC_TEC, rec_tec));
> +
> +               if (ewl > max_tec)
> +                       sts =3D CAN_STATE_ERROR_ACTIVE;
> +               else
> +                       sts =3D CAN_STATE_ERROR_WARNING;
> +               break;
> +       case REG_FSTAT_ERP:
> +               sts =3D CAN_STATE_ERROR_PASSIVE;
> +               break;
> +       case REG_FSTAT_BOF:
> +               sts =3D CAN_STATE_BUS_OFF;
> +               break;
> +       default:
> +               netdev_err(ndev, "Invalid error state.\n");
> +               break;
> +       }
> +
> +       return sts;
> +}
> +
> +/**
> + * loongson_canfd_get_bec() - Reads REC/TEC counter values from controll=
er
> + * @priv: Pointer to private data
> + * @bec: Pointer to Error counter structure
> + */
> +static void loongson_canfd_get_bec(struct loongson_canfd_priv *priv, str=
uct can_berr_counter *bec)
> +{
> +       u32 erc;
> +
> +       regmap_read(priv->regmap, LOONGSON_CANFD_ERC, &erc);
> +       bec->rxerr =3D FIELD_GET(REG_ERC_REC, erc);
> +       bec->txerr =3D FIELD_GET(REG_ERC_TEC, erc);
> +}
> +
> +/**
> + * loongson_canfd_get_berr_counter() - error counter routine
> + * @ndev: Pointer to net_device structure
> + * @bec: Pointer to can_berr_counter structure
> + *
> + * Return: 0 always
> + */
> +static int loongson_canfd_get_berr_counter(const struct net_device *ndev=
,
> +                                          struct can_berr_counter *bec)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +       loongson_canfd_get_bec(priv, bec);
We usually need a blank line here.

> +       return 0;
> +}
> +
> +/**
> + * loongson_canfd_err_interrupt() - Error frame ISR
> + * @ndev: net_device pointer
> + * @isr: interrupt status register value
> + *
> + * This is the CAN error interrupt and it will check the type of error a=
nd forward the error
> + * frame to upper layers.
> + */
> +static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 is=
r)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       struct net_device_stats *stats =3D &ndev->stats;
> +       struct can_berr_counter bec;
> +       u32 capt, alc, mask =3D 0;
> +       enum can_state state;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +
> +       loongson_canfd_get_bec(priv, &bec);
> +
> +       state =3D loongson_canfd_read_fault_state(ndev);
> +       regmap_read(priv->regmap, LOONGSON_CANFD_ERR_CAPT, &capt);
> +       regmap_read(priv->regmap, LOONGSON_CANFD_ALC, &alc);
> +
> +       netdev_dbg(ndev, "%s: ISR 0x%08x, rxerr %d, txerr %d, error type =
%lu, pos %lu, ALC id_field %lu, bit %lu\n",
> +                  __func__, isr, bec.rxerr, bec.txerr,
> +                  FIELD_GET(REG_ERR_CAPT_TYPE, capt), FIELD_GET(REG_ERR_=
CAPT_POS, capt),
> +                  FIELD_GET(REG_ALC_ID_FIELD, alc), FIELD_GET(REG_ALC_BI=
T_POS, alc));
> +
> +       skb =3D alloc_can_err_skb(ndev, &cf);
> +
> +       /*
> +        * EWLI: error warning limit condition met
> +        * FCSI: fault confinement state changed
> +        * ALI:  arbitration lost (just informative)
> +        * BEI:  bus error interrupt
> +        */
> +       if ((isr & REG_INT_STAT_FCSI) || (isr & REG_INT_STAT_EWLI)) {
> +               netdev_info(ndev, "state changes from %s to %s\n",
> +                           can_get_state_str(priv->can.state), can_get_s=
tate_str(state));
> +
> +               if (priv->can.state =3D=3D state)
> +                       netdev_warn(ndev, "cur and pre state is the same!=
(miss intr?)\n");
> +
> +               mask |=3D REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;
> +               priv->can.state =3D state;
> +               switch (state) {
> +               case CAN_STATE_BUS_OFF:
> +                       priv->can.can_stats.bus_off++;
> +                       if (priv->can.restart_ms)
> +                               regmap_write(priv->regmap, LOONGSON_CANFD=
_CMD,
> +                                            REG_CMD_ERCRST);
> +
> +                       can_bus_off(ndev);
> +                       if (skb)
> +                               cf->can_id |=3D CAN_ERR_BUSOFF;
> +                       break;
> +               case CAN_STATE_ERROR_PASSIVE:
> +                       priv->can.can_stats.error_passive++;
> +                       if (skb) {
> +                               cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CN=
T;
> +                               if (bec.rxerr >=3D CAN_ERROR_PASSIVE_THRE=
SHOLD)
> +                                       cf->data[1] =3D CAN_ERR_CRTL_RX_P=
ASSIVE;
> +                               else
> +                                       cf->data[1] =3D CAN_ERR_CRTL_TX_P=
ASSIVE;
> +                               cf->data[6] =3D bec.txerr;
> +                               cf->data[7] =3D bec.rxerr;
> +                       }
> +                       break;
> +               case CAN_STATE_ERROR_WARNING:
> +                       priv->can.can_stats.error_warning++;
> +                       if (skb) {
> +                               cf->can_id |=3D CAN_ERR_CRTL | CAN_ERR_CN=
T;
> +                               if (bec.txerr > bec.rxerr)
> +                                       cf->data[1] |=3D CAN_ERR_CRTL_TX_=
WARNING;
> +                               else
> +                                       cf->data[1] |=3D CAN_ERR_CRTL_RX_=
WARNING;
> +                               cf->data[6] =3D bec.txerr;
> +                               cf->data[7] =3D bec.rxerr;
> +                       }
> +                       break;
> +               case CAN_STATE_ERROR_ACTIVE:
> +                       if (skb) {
> +                               cf->can_id |=3D CAN_ERR_CNT;
> +                               cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
> +                               cf->data[6] =3D bec.txerr;
> +                               cf->data[7] =3D bec.rxerr;
> +                       }
> +                       break;
> +               default:
> +                       netdev_err(ndev, "Unexpected state: %d, %s!\n", s=
tate,
> +                                  can_get_state_str(state));
> +                       break;
> +               }
> +       }
> +
> +       /* Check for Arbitration Lost interrupt */
> +       if (isr & REG_INT_STAT_ALI) {
> +               mask |=3D REG_INT_STAT_ALI;
> +               netdev_err(ndev, "Arbitration Lost interrupt\n");
> +               priv->can.can_stats.arbitration_lost++;
> +               if (skb) {
> +                       cf->can_id |=3D CAN_ERR_LOSTARB;
> +                       cf->data[0] =3D CAN_ERR_LOSTARB_UNSPEC;
> +               }
> +       }
> +
> +       /* Check for Bus Error interrupt */
> +       if (isr & REG_INT_STAT_BEI) {
> +               mask |=3D REG_INT_STAT_BEI;
> +               netdev_err(ndev, "Bus Error interrupt\n");
> +               priv->can.can_stats.bus_error++;
> +               stats->rx_errors++;
> +               if (skb) {
> +                       cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +                       cf->data[2] =3D CAN_ERR_PROT_UNSPEC;
> +                       cf->data[3] =3D CAN_ERR_PROT_LOC_UNSPEC;
> +               }
> +       }
> +
> +       if (skb)
> +               netif_rx(skb);
> +
> +       regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, mask);
> +       regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, mask << 16);
> +}
> +
> +static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
> +{
> +       struct net_device *ndev =3D napi->dev;
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       int work_done =3D 0, ret =3D 1;
> +       bool rxbuf_is_empty;
> +       u32 sts;
> +
> +       rxbuf_is_empty =3D loongson_canfd_rxbuf_empty(priv);
> +
> +       while (!rxbuf_is_empty && work_done < quota && ret > 0) {
> +               ret =3D loongson_canfd_rx(ndev);
> +               work_done++;
> +               rxbuf_is_empty =3D loongson_canfd_rxbuf_empty(priv);
> +       }
> +
> +       /* Check for RX FIFO Overflow */
> +       regmap_read(priv->regmap, LOONGSON_CANFD_STAT, &sts);
> +       if (sts & REG_STAT_DOR) {
> +               struct net_device_stats *stats =3D &ndev->stats;
> +               struct can_frame *cf;
> +               struct sk_buff *skb;
> +
> +               netdev_info(ndev, "Loongson canfd RX overflow\n");
> +               stats->rx_over_errors++;
> +               stats->rx_errors++;
> +
> +               skb =3D alloc_can_err_skb(ndev, &cf);
> +               if (skb) {
> +                       cf->can_id |=3D CAN_ERR_CRTL;
> +                       cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> +                       netif_rx(skb);
> +               }
> +
> +               /* Clear Data Overrun */
> +               regmap_write(priv->regmap, LOONGSON_CANFD_CMD, REG_CMD_CD=
O);
> +       }
> +
> +       if (rxbuf_is_empty && ret !=3D 0) {
> +               if (napi_complete_done(napi, work_done)) {
> +                       /*
> +                        * Clear and enable RBNEI. It is level-triggered,
> +                        * so there is no race condition.
> +                        */
> +                       regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T, REG_INT_STAT_RBNEI);
> +                       regmap_write(priv->regmap, LOONGSON_CANFD_INT_MAS=
K,
> +                                    (REG_INT_STAT_RBNEI << 16));
> +               }
> +       }
> +
> +       return work_done;
> +}
> +
> +/**
> + * loongson_canfd_tx_interrupt() - Tx done Isr
> + * @ndev: net_device pointer
> + */
> +static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       struct net_device_stats *stats =3D &ndev->stats;
> +       enum loongson_canfd_txbuf_sts sts;
> +       bool some_buffers_processed;
> +       u32 buf_id;
> +
> +       do {
> +               some_buffers_processed =3D false;
> +
> +               guard(spinlock_irqsave)(&priv->tx_lock);
> +
> +               while ((buf_id =3D loongson_canfd_get_txbuf_id(priv, &sts=
)) <
> +                       LOONGSON_CANFD_TXBUF_NUM) {
> +                       switch (sts) {
> +                       case TX_BS_VALID:
> +                               stats->tx_bytes +=3D can_get_echo_skb(nde=
v, buf_id, NULL);
> +                               stats->tx_packets++;
> +                               break;
> +                       case TX_BS_FAIL:
> +                               u32 cnt;
> +                               /*
> +                                * This indicated that retransmit limit h=
as been reached.
> +                                * Obviously we should not echo the frame=
, but also not indicate any
> +                                * kind of error. If desired, it was alre=
ady reported (possible
> +                                * multiple times) on each arbitration lo=
st.
> +                                */
> +                               regmap_read(priv->regmap, LOONGSON_CANFD_=
TX_FR_CNT, &cnt);
> +                               netdev_warn(ndev, "TXB in FAIL state, TX =
frame count: %d\n", cnt);
> +                               can_free_echo_skb(ndev, buf_id, NULL);
> +                               stats->tx_dropped++;
> +                               break;
> +                       case TX_BS_CANCEL:
> +                               /*
> +                                * We *could* re-queue the frame, but mul=
tiqueue/abort is
> +                                * not supported yet anyway.
> +                                */
> +                               netdev_warn(ndev, "TXB in CANCEL state\n"=
);
> +                               can_free_echo_skb(ndev, buf_id, NULL);
> +                               stats->tx_dropped++;
> +                               break;
> +                       default:
> +                               netdev_warn(ndev, "TXB unexpected status:=
 %d\n", sts);
> +                               break;
> +                       }
> +
> +                       loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_SR_CLE=
AN, buf_id);
> +                       some_buffers_processed =3D true;
> +               }
> +
> +               /*
> +                * If no buffers were processed this time, we cannot clea=
r - that would introduce
> +                * a race condition.
> +                */
> +               if (some_buffers_processed) {
> +                       /*
> +                        * Clear the interrupt again. We do not want to r=
eceive again interrupt
> +                        * for the buffer already handled. If it is the l=
ast finished one then
> +                        * it would cause log of spurious interrupt.
> +                        */
> +                       regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T, REG_INT_STAT_TXBHCI);
> +               }
> +       } while (some_buffers_processed);
> +
> +       guard(spinlock_irqsave)(&priv->tx_lock);
> +       /* Check if at least one TX buffer is free */
> +       if (loongson_canfd_txbuf_freed(priv))
> +               netif_wake_queue(ndev);
> +}
> +
> +/**
> + * loongson_canfd_interrupt() - CAN Isr
> + * @irq: irq number
> + * @dev_id: device id pointer
> + *
> + * This is the Loongson CANFD ISR. It checks for the type of interrupt
> + * and invokes the corresponding ISR.
> + *
> + * Return:
> + * IRQ_NONE - If CAN device is in sleep mode, IRQ_HANDLED otherwise
> + */
> +static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
> +{
> +       struct net_device *ndev =3D (struct net_device *)dev_id;
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       u32 isr, imask;
> +
> +       for (unsigned int irq_loops =3D 0; irq_loops < 10000; irq_loops++=
) {
> +               /* Get the interrupt status */
> +               regmap_read(priv->regmap, LOONGSON_CANFD_INT_STAT, &isr);
> +               if (!isr) {
> +                       if (irq_loops)
> +                               return IRQ_HANDLED;
> +                       else
> +                               return IRQ_NONE;
> +               }
> +
> +               /* Receive Buffer Not Empty Interrupt */
> +               if (isr & REG_INT_STAT_RBNEI) {
> +                       /*
> +                        * Mask RXBNEI the first, then clear interrupt an=
d schedule NAPI.
> +                        * Even if another IRQ fires, RBNEI will always b=
e 0 (masked).
> +                        */
> +                       regmap_write(priv->regmap, LOONGSON_CANFD_INT_MAS=
K, REG_INT_STAT_RBNEI);
> +                       regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T, REG_INT_STAT_RBNEI);
> +                       napi_schedule(&priv->napi);
> +               }
> +
> +               /* TX Buffer HW Command Interrupt */
> +               if (isr & REG_INT_STAT_TXBHCI)
> +                       loongson_canfd_tx_interrupt(ndev);
> +
> +               /* Error interrupts */
> +               imask =3D isr & REG_INT_STAT_ERRORI;
> +               if (imask) {
> +                       regmap_write(priv->regmap, LOONGSON_CANFD_INT_MAS=
K, imask);
> +                       regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T, imask);
> +                       loongson_canfd_err_interrupt(ndev, isr);
> +               }
> +
> +               /* Ignore RI, TI, LFI, RFI, BSI */
> +       }
> +
> +       netdev_err(ndev, "Intterupt state: 0x%x.\n", isr);
> +
> +       if (isr & REG_INT_STAT_TXBHCI) {
> +               for (unsigned int i =3D 0; i < LOONGSON_CANFD_TXBUF_NUM; =
i++) {
> +                       u32 sts =3D loongson_canfd_get_txbuf_sts(priv, i)=
;
> +
> +                       netdev_err(ndev, "TX buf %d status: 0x%x.\n", i, =
sts);
> +               }
> +       }
> +
> +       loongson_canfd_disable_interrupts(priv);
I'm not sure, but no interrupts after this? I think there should be
other places to enable interrupts.


Huacai

> +
> +       return IRQ_HANDLED;
> +}
> +
> +/**
> + * loongson_canfd_chip_stop() - Driver stop routine
> + * @ndev: Pointer to net_device structure
> + *
> + * This is the drivers stop routine. It will disable the interrupts and
> + * disable the controller.
> + */
> +static void loongson_canfd_chip_stop(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +       /* Disable interrupts and disable CAN */
> +       loongson_canfd_disable_interrupts(priv);
> +       regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_EN=
A, 0);
> +
> +       priv->can.state =3D CAN_STATE_STOPPED;
> +}
> +
> +/**
> + * loongson_canfd_open() - Driver open routine
> + * @ndev: Pointer to net_device structure
> + *
> + * This is the driver open routine.
> + * Return: 0 on success and failure value on error
> + */
> +static int loongson_canfd_open(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +       int ret;
> +
> +       loongson_canfd_reset(ndev);
> +
> +       /* Common open */
> +       ret =3D open_candev(ndev);
> +       if (ret) {
> +               netdev_warn(ndev, "open_candev failed!\n");
> +               return ret;
> +       }
> +
> +       napi_enable(&priv->napi);
> +       ret =3D request_irq(ndev->irq, loongson_canfd_interrupt, IRQF_SHA=
RED, ndev->name, ndev);
> +       if (ret < 0) {
> +               netdev_err(ndev, "irq allocation for CAN failed\n");
> +               goto exit_napi_disable;
> +       }
> +
> +       ret =3D loongson_canfd_chip_start(ndev);
> +       if (ret < 0) {
> +               netdev_err(ndev, "loongson_canfd_chip_start failed!\n");
> +               goto exit_free_irq;
> +       }
> +
> +       netdev_info(ndev, "loongson_canfd_device registered\n");
> +       netif_start_queue(ndev);
> +
> +       return 0;
> +
> +exit_free_irq:
> +       free_irq(ndev->irq, ndev);
> +exit_napi_disable:
> +       napi_disable(&priv->napi);
> +       close_candev(ndev);
> +       return ret;
> +}
> +
> +/**
> + * loongson_canfd_close() - Driver close routine
> + * @ndev: Pointer to net_device structure
> + *
> + * Return: 0 always
> + */
> +static int loongson_canfd_close(struct net_device *ndev)
> +{
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +       netif_stop_queue(ndev);
> +       napi_disable(&priv->napi);
> +       loongson_canfd_chip_stop(ndev);
> +       free_irq(ndev->irq, ndev);
> +       close_candev(ndev);
> +
> +       return 0;
> +}
> +
> +static const struct net_device_ops loongson_canfd_netdev_ops =3D {
> +       .ndo_open       =3D loongson_canfd_open,
> +       .ndo_stop       =3D loongson_canfd_close,
> +       .ndo_start_xmit =3D loongson_canfd_start_xmit,
> +};
> +
> +static const struct ethtool_ops loongson_canfd_ethtool_ops =3D {
> +       .get_ts_info =3D ethtool_op_get_ts_info,
> +};
> +
> +static const struct regmap_range loongson_canfd_reg_table_wr_range[] =3D=
 {
> +       regmap_reg_range(LOONGSON_CANFD_DEVICE_ID, LOONGSON_CANFD_CONF),
> +       regmap_reg_range(LOONGSON_CANFD_CMD, LOONGSON_CANFD_CMD),
> +       regmap_reg_range(LOONGSON_CANFD_INT_STAT, LOONGSON_CANFD_ERL),
> +       regmap_reg_range(LOONGSON_CANFD_CTR_PRES, LOONGSON_CANFD_CTR_PRES=
),
> +       regmap_reg_range(LOONGSON_CANFD_SSP_CFG, LOONGSON_CANFD_SSP_CFG),
> +       regmap_reg_range(LOONGSON_CANFD_TS, LOONGSON_CANFD_FLT_CTRL),
> +       regmap_reg_range(LOONGSON_CANFD_TX_CMD, LOONGSON_CANFD_TX_DATA_18=
),
> +};
> +
> +static const struct regmap_range loongson_canfd_reg_table_rd_range[] =3D=
 {
> +       regmap_reg_range(LOONGSON_CANFD_DEVICE_ID, LOONGSON_CANFD_STAT),
> +       regmap_reg_range(LOONGSON_CANFD_INT_STAT, LOONGSON_CANFD_BRE),
> +       regmap_reg_range(LOONGSON_CANFD_ERR_CAPT, LOONGSON_CANFD_TX_STAT)=
,
> +       regmap_reg_range(LOONGSON_CANFD_TX_SEL, LOONGSON_CANFD_TX_DATA_18=
),
> +};
> +
> +static const struct regmap_access_table loongson_canfd_reg_table_wr =3D =
{
> +       .yes_ranges =3D loongson_canfd_reg_table_wr_range,
> +       .n_yes_ranges =3D ARRAY_SIZE(loongson_canfd_reg_table_wr_range),
> +};
> +
> +static const struct regmap_access_table loongson_canfd_reg_table_rd =3D =
{
> +       .yes_ranges =3D loongson_canfd_reg_table_rd_range,
> +       .n_yes_ranges =3D ARRAY_SIZE(loongson_canfd_reg_table_rd_range),
> +};
> +
> +static bool loongson_canfd_volatile_reg(struct device *dev, unsigned int=
 reg)
> +{
> +       switch (reg) {
> +       case LOONGSON_CANFD_MODE:
> +       case LOONGSON_CANFD_CONF:
> +       case LOONGSON_CANFD_STAT:
> +       case LOONGSON_CANFD_INT_STAT:
> +       case LOONGSON_CANFD_INT_ENA:
> +       case LOONGSON_CANFD_INT_MASK:
> +       case LOONGSON_CANFD_ERL:
> +       case LOONGSON_CANFD_FSTAT:
> +       case LOONGSON_CANFD_ERC:
> +       case LOONGSON_CANFD_ERR_CAPT:
> +       case LOONGSON_CANFD_ALC:
> +       case LOONGSON_CANFD_TRV_DLY:
> +       case LOONGSON_CANFD_TX_FR_CNT:
> +       case LOONGSON_CANFD_RX_STAT:
> +       case LOONGSON_CANFD_RX_DATA:
> +       case LOONGSON_CANFD_TX_STAT:
> +       case LOONGSON_CANFD_TX_SEL:
> +               return true;
> +       default:
> +               return false;
> +       };
> +}
> +
> +static const struct regmap_config loongson_cangfd_regmap =3D {
> +       .reg_bits       =3D 32,
> +       .reg_stride     =3D 4,
> +       .val_bits       =3D 32,
> +       .wr_table       =3D &loongson_canfd_reg_table_wr,
> +       .rd_table       =3D &loongson_canfd_reg_table_rd,
> +       .volatile_reg   =3D loongson_canfd_volatile_reg,
> +       .max_register   =3D LOONGSON_CANFD_TX_DATA_18,
> +       .cache_type     =3D REGCACHE_MAPLE,
> +};
> +
> +static int loongson_canfd_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct loongson_canfd_priv *priv;
> +       struct net_device *ndev;
> +       struct regmap *regmap;
> +       struct resource *res;
> +       void __iomem *base;
> +       int ret =3D 0, irq;
> +       u32 clk_rate;
> +
> +       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap =3D devm_regmap_init_mmio(dev, base, &loongson_cangfd_regm=
ap);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       ret =3D device_property_read_u32(dev, "clock-frequency", &clk_rat=
e);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Missing clock-frequency p=
roperty\n");
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       /* Create a CAN device instance */
> +       ndev =3D alloc_candev(sizeof(*priv), LOONGSON_CANFD_TXBUF_NUM);
> +       if (!ndev)
> +               return -ENOMEM;
> +
> +       priv =3D netdev_priv(ndev);
> +       spin_lock_init(&priv->tx_lock);
> +       priv->regmap =3D regmap;
> +       priv->res =3D res;
> +
> +       priv->can.clock.freq =3D clk_rate;
> +       priv->can.bittiming_const =3D &loongson_canfd_bit_timing;
> +       priv->can.fd.data_bittiming_const =3D &loongson_canfd_bit_timing_=
data;
> +       priv->can.fd.tdc_const =3D &loongson_canfd_tdc_data;
> +
> +       priv->can.fd.do_set_data_bittiming =3D loongson_canfd_set_data_bi=
ttiming;
> +       priv->can.fd.do_get_auto_tdcv =3D loongson_canfd_get_auto_tdcv;
> +       priv->can.do_set_mode =3D loongson_canfd_do_set_mode;
> +       priv->can.do_set_bittiming =3D loongson_canfd_set_bittiming;
> +       priv->can.do_get_berr_counter =3D loongson_canfd_get_berr_counter=
;
> +
> +       priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK | CAN_CTRL=
MODE_LISTENONLY |
> +                                      CAN_CTRLMODE_3_SAMPLES | CAN_CTRLM=
ODE_ONE_SHOT |
> +                                      CAN_CTRLMODE_BERR_REPORTING | CAN_=
CTRLMODE_FD |
> +                                      CAN_CTRLMODE_PRESUME_ACK | CAN_CTR=
LMODE_FD_NON_ISO |
> +                                      CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMO=
DE_CC_LEN8_DLC;
> +
> +       ndev->irq =3D irq;
> +       ndev->flags |=3D IFF_ECHO;        /* We support local echo */
> +       platform_set_drvdata(pdev, ndev);
> +       ndev->netdev_ops =3D &loongson_canfd_netdev_ops;
> +       ndev->ethtool_ops =3D &loongson_canfd_ethtool_ops;
> +       SET_NETDEV_DEV(ndev, dev);
> +
> +       netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
> +
> +       ret =3D register_candev(ndev);
> +       if (ret) {
> +               dev_err(dev, "register_candev failed with %d\n", ret);
> +               goto err_candev_free;
> +       }
> +
> +       return 0;
> +
> +err_candev_free:
> +       netif_napi_del(&priv->napi);
> +       free_candev(ndev);
> +       return ret;
> +}
> +
> +/**
> + * loongson_canfd_remove - Unregister the device after releasing the res=
ources
> + * @pdev: Handle to the platform device structure
> + *
> + * This function frees all the resources allocated to the device.
> + */
> +static void loongson_canfd_remove(struct platform_device *pdev)
> +{
> +       struct net_device *ndev =3D platform_get_drvdata(pdev);
> +       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +       unregister_candev(ndev);
> +       netif_napi_del(&priv->napi);
> +       free_candev(ndev);
> +}
> +
> +static const struct acpi_device_id loongson_canfd_acpi_match[] =3D {
> +       { .id =3D "LOON0015" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_canfd_acpi_match);
> +
> +static struct platform_driver loongson_canfd_driver =3D {
> +       .probe  =3D loongson_canfd_probe,
> +       .remove =3D loongson_canfd_remove,
> +       .driver =3D {
> +               .name =3D DEV_NAME,
> +               .acpi_match_table =3D loongson_canfd_acpi_match,
> +       },
> +};
> +module_platform_driver(loongson_canfd_driver);
> +
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
> +MODULE_LICENSE("GPL");
> --
> 2.52.0
>
>

