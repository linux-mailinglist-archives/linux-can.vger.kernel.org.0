Return-Path: <linux-can+bounces-25-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E07EEAC6
	for <lists+linux-can@lfdr.de>; Fri, 17 Nov 2023 02:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8380280CA5
	for <lists+linux-can@lfdr.de>; Fri, 17 Nov 2023 01:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2CF1378;
	Fri, 17 Nov 2023 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB67182;
	Thu, 16 Nov 2023 17:40:06 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1339476b3a.1;
        Thu, 16 Nov 2023 17:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700185206; x=1700790006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdYng4uxwGoap3VYuWktkKMGXQO+/o0zneqHVo0/d+U=;
        b=ZF0dPvAepz8KQG/F5kWfl5B591L+l1XagTD7fvwiyd2preiStbXSnySZuNsTMPm81P
         Lyv40kjvlHAHQMcLaGLgrhE6/0NIaihb3Eb2TNvGwazzDgxH7VkR2gPShp3FXTqCExS2
         ftMubUj//Wp/U2U8EQB7UhN0/oid29lmeT48UlAq4FuGNp05Q8zVwl0Zq+e3rG3zzWUm
         0paRMws2i5oQvY7RYBWEXVKKXnVV61mrjF2aQnjJoYBZY0an2FPCic4xqs+OV++9n1Vr
         oLCEl/Y8QDuTS/MlV6x/b21Pzc/yMc2ey5Fm4K2/yHkLGFZnEx37S2Y1zRwSUxip/Nhp
         Aoyw==
X-Gm-Message-State: AOJu0YxU0dBTNc904dB8q8KEgIBrPVqlq1upKemUTTRWQeX3sxwWTytB
	EpabDLHjrlyFa8o8v3YluR4+S80t/dO+nAVF0Jk=
X-Google-Smtp-Source: AGHT+IFnYQchccZE+uq3l69/Y/xW9PC4KD4iMscwJqFKuNhE3WBw20u7BCHAHrYhwMH+zJgdO8l5aVNS4MiWoGPCmnE=
X-Received: by 2002:a05:6a20:1611:b0:188:28e:5a75 with SMTP id
 l17-20020a056a20161100b00188028e5a75mr1335836pzj.5.1700185205550; Thu, 16 Nov
 2023 17:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107184103.2802678-1-stefan.maetje@esd.eu>
 <20231107184103.2802678-3-stefan.maetje@esd.eu> <CAMZ6RqLOAC930GNOU+pWuoi6FgYwFOuFrSyAzVjvE2fuVgy8oA@mail.gmail.com>
 <5fd2aa06644baa7b05104c5c402016cb1b795b32.camel@esd.eu>
In-Reply-To: <5fd2aa06644baa7b05104c5c402016cb1b795b32.camel@esd.eu>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Fri, 17 Nov 2023 10:39:53 +0900
Message-ID: <CAMZ6RqKdd3_i3TMc6B-zFqCDf7zj1C+LWSn4tVH_NHzKdCaaKg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] can: esd: add support for esd GmbH PCIe/402 CAN
 interface family
To: =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, 
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Fri. 17 nov. 2023 at 05:53, Stefan M=C3=A4tje <Stefan.Maetje@esd.eu> wro=
te:
> Hi Vincent,
>
> thank you for your review. I've included most of your suggestions and a
> reworked patch will follow soon.
>
> Please have a look at my comments below.

Comments are satisfactory except for the dev_info() to report the features.

> Best regards,
>     Stefan
>
>
> Am Mittwoch, den 08.11.2023, 20:00 +0900 schrieb Vincent MAILHOL:
> > Hi,
> >
> > I do not know much about PCI, so no thorough review of that part. Here
> > is a set of small fixes or nitpicks. The driver starts to look good.
> > If things go right, expect to receive my reviewed-by tag in the next
> > iteration.
> >
> > On Wed. 8 Nov. 2023 at 08:30, Stefan M=C3=A4tje <stefan.maetje@esd.eu> =
wrote:
> > > This patch adds support for the PCI based PCIe/402 CAN interface fami=
ly
> > > from esd GmbH that is available with various form factors
> > > (https://esd.eu/en/products/402-series-can-interfaces).
> > >
> > > All boards utilize a FPGA based CAN controller solution developed
> > > by esd (esdACC). For more information on the esdACC see
> > > https://esd.eu/en/products/esdacc.
> > >
> > > This driver detects all available CAN interface board variants of
> > > the family but atm. operates the CAN-FD capable devices in
> > > Classic-CAN mode only! A later patch will introduce the CAN-FD
> > > functionality in this driver.
> >
> > The driver already introduces pieces of code for CAN-FD, for example
> > struct can_bittiming_const pci402_bittiming_const_canfd. Would it make
> > sense to remove those for now and send them altogether in the
> > follow-up patch which will add CAN-FD?
>
> I can see that from a pure software point of view it would be fine to
> completely split the new driver in a CAN Classic support driver and
> then have another patch as addon to complete the CAN-FD extension.
>
> The only stuff that still could be removed is the is the bit timing struc=
t
> for CAN-FD boards named pci402_bittiming_const_canfd and the CAN-FD branc=
h
> in the acc_set_bittiming() function together with four defines for the
> TSEG fields in the CAN-FD case. Then code needs to be added to make the
> "struct pci_device_id pci402_tbl" table much more specific so the driver
> is not be probed for the CAN-FD boards.
>
> I don't like the idea to additionally do this to render CAN-FD capable
> boards useless when they could be used as CAN Classic boards with no
> disadvantage.

My apologies. I misinterpreted struct can_bittiming_const
pci402_bittiming_const_canfd to be a databittiming (which would have
been dead code) where in reality it is the nominal bittiming of a
CAN-FD capable board.

You are right. Please forget this comment and sorry for the noise.

> > > Co-developed-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>
> > > Signed-off-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>
> > > Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> > > ---
> > >  drivers/net/can/Kconfig                |   1 +
> > >  drivers/net/can/Makefile               |   1 +
> > >  drivers/net/can/esd/Kconfig            |  12 +
> > >  drivers/net/can/esd/Makefile           |   7 +
> > >  drivers/net/can/esd/esd_402_pci-core.c | 512 ++++++++++++++++
> > >  drivers/net/can/esd/esdacc.c           | 771 +++++++++++++++++++++++=
++
> > >  drivers/net/can/esd/esdacc.h           | 393 +++++++++++++
> > >  7 files changed, 1697 insertions(+)
> > >  create mode 100644 drivers/net/can/esd/Kconfig
> > >  create mode 100644 drivers/net/can/esd/Makefile
> > >  create mode 100644 drivers/net/can/esd/esd_402_pci-core.c
> > >  create mode 100644 drivers/net/can/esd/esdacc.c
> > >  create mode 100644 drivers/net/can/esd/esdacc.h
> > >
> > > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > > index 649453a3c858..b9a65b44ccef 100644
> > > --- a/drivers/net/can/Kconfig
> > > +++ b/drivers/net/can/Kconfig
> > > @@ -217,6 +217,7 @@ config CAN_XILINXCAN
> > >  source "drivers/net/can/c_can/Kconfig"
> > >  source "drivers/net/can/cc770/Kconfig"
> > >  source "drivers/net/can/ctucanfd/Kconfig"
> > > +source "drivers/net/can/esd/Kconfig"
> > >  source "drivers/net/can/ifi_canfd/Kconfig"
> > >  source "drivers/net/can/m_can/Kconfig"
> > >  source "drivers/net/can/mscan/Kconfig"
> > > diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> > > index ff8f76295d13..4669cd51e7bf 100644
> > > --- a/drivers/net/can/Makefile
> > > +++ b/drivers/net/can/Makefile
> > > @@ -8,6 +8,7 @@ obj-$(CONFIG_CAN_VXCAN)         +=3D vxcan.o
> > >  obj-$(CONFIG_CAN_SLCAN)                +=3D slcan/
> > >
> > >  obj-y                          +=3D dev/
> > > +obj-y                          +=3D esd/
> > >  obj-y                          +=3D rcar/
> > >  obj-y                          +=3D spi/
> > >  obj-y                          +=3D usb/
> > > diff --git a/drivers/net/can/esd/Kconfig b/drivers/net/can/esd/Kconfi=
g
> > > new file mode 100644
> > > index 000000000000..54bfc366634c
> > > --- /dev/null
> > > +++ b/drivers/net/can/esd/Kconfig
> > > @@ -0,0 +1,12 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +config CAN_ESD_402_PCI
> > > +       tristate "esd electronics gmbh CAN-PCI(e)/402 family"
> > > +       depends on PCI && HAS_DMA
> > > +       help
> > > +         Support for C402 card family from esd electronics gmbh.
> > > +         This card family is based on the ESDACC CAN controller and
> > > +         available in several form factors:  PCI, PCIe, PCIe Mini,
> > > +         M.2 PCIe, CPCIserial, PMC, XMC  (see https://esd.eu/en)
> > > +
> > > +         This driver can also be built as a module. In this case the
> > > +         module will be called esd_402_pci.
> > > diff --git a/drivers/net/can/esd/Makefile b/drivers/net/can/esd/Makef=
ile
> > > new file mode 100644
> > > index 000000000000..5dd2d470c286
> > > --- /dev/null
> > > +++ b/drivers/net/can/esd/Makefile
> > > @@ -0,0 +1,7 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +#  Makefile for esd gmbh ESDACC controller driver
> > > +#
> > > +esd_402_pci-objs :=3D esdacc.o esd_402_pci-core.o
> > > +
> > > +obj-$(CONFIG_CAN_ESD_402_PCI) +=3D esd_402_pci.o
> > > diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can=
/esd/esd_402_pci-core.c
> > > new file mode 100644
> > > index 000000000000..5793d41c17c2
> > > --- /dev/null
> > > +++ b/drivers/net/can/esd/esd_402_pci-core.c
> > > @@ -0,0 +1,512 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (C) 2015 - 2016 Thomas K=C3=B6rper, esd electronic syst=
em design gmbh
> > > + * Copyright (C) 2017 - 2022 Stefan M=C3=A4tje, esd electronics gmbh
> > > + */
> > > +
> > > +#include <linux/can/dev.h>
> > > +#include <linux/can.h>
> > > +#include <linux/can/netlink.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/netdevice.h>
> > > +#include <linux/pci.h>
> > > +
> > > +#include "esdacc.h"
> > > +
> > > +#define ESD_PCI_DEVICE_ID_PCIE402 0x0402
> > > +
> > > +#define PCI402_FPGA_VER_MIN 0x003d
> > > +#define PCI402_MAX_CORES 6
> > > +#define PCI402_BAR 0
> > > +#define PCI402_IO_OV_OFFS 0
> > > +#define PCI402_IO_PCIEP_OFFS 0x10000
> > > +#define PCI402_IO_LEN_TOTAL 0x20000
> > > +#define PCI402_IO_LEN_CORE 0x2000
> > > +#define PCI402_PCICFG_MSICAP 0x50
> > > +
> > > +#define PCI402_DMA_MASK DMA_BIT_MASK(32)
> > > +#define PCI402_DMA_SIZE ALIGN(0x10000, PAGE_SIZE)
> > > +
> > > +#define PCI402_PCIEP_OF_INT_ENABLE 0x0050
> > > +#define PCI402_PCIEP_OF_BM_ADDR_LO 0x1000
> > > +#define PCI402_PCIEP_OF_BM_ADDR_HI 0x1004
> > > +#define PCI402_PCIEP_OF_MSI_ADDR_LO 0x1008
> > > +#define PCI402_PCIEP_OF_MSI_ADDR_HI 0x100c
> > > +
> > > +/* The BTR register capabilities described by the can_bittiming_cons=
t structures
> > > + * below are valid since ESDACC version 0x0032.
> > > + */
> > > +
> > > +/* Used if the ESDACC FPGA is built as CAN-Classic version. */
> > > +static const struct can_bittiming_const pci402_bittiming_const =3D {
> > > +       .name =3D "esd_402",
> > > +       .tseg1_min =3D 1,
> > > +       .tseg1_max =3D 16,
> > > +       .tseg2_min =3D 1,
> > > +       .tseg2_max =3D 8,
> > > +       .sjw_max =3D 4,
> > > +       .brp_min =3D 1,
> > > +       .brp_max =3D 512,
> > > +       .brp_inc =3D 1,
> > > +};
> > > +
> > > +/* Used if the ESDACC FPGA is built as CAN-FD version. */
> > > +static const struct can_bittiming_const pci402_bittiming_const_canfd=
 =3D {
> > > +       .name =3D "esd_402fd",
> > > +       .tseg1_min =3D 1,
> > > +       .tseg1_max =3D 256,
> > > +       .tseg2_min =3D 1,
> > > +       .tseg2_max =3D 128,
> > > +       .sjw_max =3D 128,
> > > +       .brp_min =3D 1,
> > > +       .brp_max =3D 256,
> > > +       .brp_inc =3D 1,
> > > +};
> > > +
> > > +static const struct net_device_ops pci402_acc_netdev_ops =3D {
> > > +       .ndo_open =3D acc_open,
> > > +       .ndo_stop =3D acc_close,can_
> > > +       .ndo_start_xmit =3D acc_start_xmit,
> > > +       .ndo_change_mtu =3D can_change_mtu
> >
> >                                         ^
> > Generic comment: add a comma after the last entry to have a cleaner
> > diff if members get added later on.
>
> Normally I do this but I missed this here.

Ack.

> > Please also populate net_device_ops.ndo_eth_ioctl() and
> > netdev->ethtool_ops for the hardware timestamp support. Use below
> > commit as a reference:
> >
> >   https://git.kernel.org/torvalds/c/1d46efa0008a
>
> I had seen your original patches in July 2022 and had them on my todo lis=
t.
> I'll patch this in as recommended asap and then check if the defaults are
> matching the esdACCs hardware capabilities.

Ack.

> > > +};
> > > +
> > > +struct pci402_card {
> > > +       /* Actually mapped io space, all other iomem derived from thi=
s */
> > > +       void __iomem *addr;
> > > +       void __iomem *addr_pciep;
> > > +
> > > +       void *dma_buf;
> > > +       dma_addr_t dma_hnd;
> > > +
> > > +       struct acc_ov ov;
> > > +       struct acc_core *cores;
> > > +
> > > +       bool msi_enabled;
> > > +};
> > > +
> > > +static irqreturn_t pci402_interrupt(int irq, void *dev_id)
> > > +{
> > > +       struct pci_dev *pdev =3D dev_id;
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +       irqreturn_t irq_status;
> > > +
> > > +       irq_status =3D acc_card_interrupt(&card->ov, card->cores);
> > > +
> > > +       return irq_status;
> > > +}
> > > +
> > > +static int pci402_set_msiconfig(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +       u32 addr_lo_offs =3D 0;
> > > +       u32 addr_lo =3D 0;
> > > +       u32 addr_hi =3D 0;
> > > +       u32 data =3D 0;
> > > +       u16 csr =3D 0;
> > > +       int err;
> > > +
> > > +       /* The FPGA hard IP PCIe core implements a 64-bit MSI Capabil=
ity
> > > +        * Register Format
> > > +        */
> > > +       err =3D pci_read_config_word(pdev, PCI402_PCICFG_MSICAP + PCI=
_MSI_FLAGS, &csr);
> > > +       if (err)
> > > +               goto failed;
> > > +
> > > +       err =3D pci_read_config_dword(pdev, PCI402_PCICFG_MSICAP + PC=
I_MSI_ADDRESS_LO,
> > > +                                   &addr_lo);
> > > +       if (err)
> > > +               goto failed;
> > > +       err =3D pci_read_config_dword(pdev, PCI402_PCICFG_MSICAP + PC=
I_MSI_ADDRESS_HI,
> > > +                                   &addr_hi);
> > > +       if (err)
> > > +               goto failed;
> > > +
> > > +       err =3D pci_read_config_dword(pdev, PCI402_PCICFG_MSICAP + PC=
I_MSI_DATA_64,
> > > +                                   &data);
> > > +       if (err)
> > > +               goto failed;
> > > +
> > > +       addr_lo_offs =3D addr_lo & 0x0000ffff;
> > > +       addr_lo &=3D 0xffff0000;
> > > +
> > > +       if (addr_hi)
> > > +               addr_lo |=3D 1; /* To enable 64-Bit addressing in PCI=
e endpoint */
> > > +
> > > +       if (!(csr & PCI_MSI_FLAGS_ENABLE)) {
> > > +               err =3D -EINVAL;
> > > +               goto failed;
> > > +       }
> > > +
> > > +       iowrite32(addr_lo, card->addr_pciep + PCI402_PCIEP_OF_MSI_ADD=
R_LO);
> > > +       iowrite32(addr_hi, card->addr_pciep + PCI402_PCIEP_OF_MSI_ADD=
R_HI);
> > > +       acc_ov_write32(&card->ov, ACC_OV_OF_MSI_ADDRESSOFFSET, addr_l=
o_offs);
> > > +       acc_ov_write32(&card->ov, ACC_OV_OF_MSI_DATA, data);
> > > +
> > > +       return 0;
> > > +
> > > +failed:
> > > +       pci_warn(pdev, "Error while setting MSI configuration:\n"
> > > +                "CSR: 0x%.4x, addr: 0x%.8x%.8x, offs: 0x%.4x, data: =
0x%.8x\n",
> > > +                csr, addr_hi, addr_lo, addr_lo_offs, data);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static int pci402_init_card(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +
> > > +       card->ov.addr =3D card->addr + PCI402_IO_OV_OFFS;
> > > +       card->addr_pciep =3D card->addr + PCI402_IO_PCIEP_OFFS;
> > > +
> > > +       acc_reset_fpga(&card->ov);
> > > +       acc_init_ov(&card->ov, &pdev->dev);
> > > +
> > > +       if (card->ov.version < PCI402_FPGA_VER_MIN) {
> > > +               pci_err(pdev,
> > > +                       "ESDACC version (0x%.4x) outdated, please upd=
ate\n",
> > > +                       card->ov.version);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (card->ov.timestamp_frequency !=3D ACC_TS_FREQ_80MHZ) {
> > > +               pci_err(pdev,
> > > +                       "esdACC timestamp frequency of %uHz not suppo=
rted by driver. Aborted.\n",
> > > +                       card->ov.timestamp_frequency);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (card->ov.active_cores > PCI402_MAX_CORES) {
> > > +               pci_err(pdev,
> > > +                       "Card has more active cores (%u) than support=
ed by driver. Aborted.\n",
> >
> >                                                     ^^^^
> >
> > From the Linux coding style:
> >
> >   Printing numbers in parentheses (%d) adds no value and should be avoi=
ded.
> >
> > Ref: https://www.kernel.org/doc/html/v4.10/process/coding-style.html#pr=
inting-kernel-messages
> >
>
> Removed () and reworded message.

Ack.

> > > +                       card->ov.active_cores);
> > > +               return -EINVAL;
> > > +       }
> > > +       card->cores =3D devm_kcalloc(&pdev->dev, card->ov.active_core=
s,
> > > +                                  sizeof(struct acc_core), GFP_KERNE=
L);
> > > +       if (!card->cores)
> > > +               return -ENOMEM;
> > > +
> > > +       if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD) {
> > > +               pci_warn(pdev,
> > > +                        "ESDACC with CAN-FD feature detected. This d=
river doesn't support CAN-FD yet.\n");
> > > +       }
> > > +
> > > +#ifdef __LITTLE_ENDIAN
> > > +       /* So card converts all busmastered data to LE for us: */
> > > +       acc_ov_set_bits(&card->ov, ACC_OV_OF_MODE,
> > > +                       ACC_OV_REG_MODE_MASK_ENDIAN_LITTLE);
> > > +#endif
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int pci402_init_interrupt(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +       int err;
> > > +
> > > +       err =3D pci_enable_msi(pdev);
> > > +       if (!err) {
> > > +               err =3D pci402_set_msiconfig(pdev);
> > > +               if (!err) {
> > > +                       card->msi_enabled =3D true;
> > > +                       acc_ov_set_bits(&card->ov, ACC_OV_OF_MODE,
> > > +                                       ACC_OV_REG_MODE_MASK_MSI_ENAB=
LE);
> > > +                       pci_info(pdev, "MSI enabled\n");
> >
> > Consider using dev_dbg() instead of dev_info() here.
>
> Changed to pci_dbg() and reworded message to make clear that this message=
 marks
> that the MSI preparation in the esdACC FPGA succeeded.

Ack.

> > > +               }
> > > +       }
> > > +
> > > +       err =3D devm_request_irq(&pdev->dev, pdev->irq, pci402_interr=
upt,
> > > +                              IRQF_SHARED, dev_name(&pdev->dev), pde=
v);
> > > +       if (err)
> > > +               goto failure_msidis;
> > > +
> > > +       iowrite32(1, card->addr_pciep + PCI402_PCIEP_OF_INT_ENABLE);
> > > +
> > > +       return 0;
> > > +
> > > +failure_msidis:
> > > +       if (card->msi_enabled) {
> > > +               acc_ov_clear_bits(&card->ov, ACC_OV_OF_MODE,
> > > +                                 ACC_OV_REG_MODE_MASK_MSI_ENABLE);
> > > +               pci_disable_msi(pdev);
> > > +               card->msi_enabled =3D false;
> > > +       }
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static void pci402_finish_interrupt(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +
> > > +       iowrite32(0, card->addr_pciep + PCI402_PCIEP_OF_INT_ENABLE);
> > > +       devm_free_irq(&pdev->dev, pdev->irq, pdev);
> > > +
> > > +       if (card->msi_enabled) {
> > > +               acc_ov_clear_bits(&card->ov, ACC_OV_OF_MODE,
> > > +                                 ACC_OV_REG_MODE_MASK_MSI_ENABLE);
> > > +               pci_disable_msi(pdev);
> > > +               card->msi_enabled =3D false;
> > > +       }
> > > +}
> > > +
> > > +static int pci402_init_dma(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +       int err;
> > > +
> > > +       err =3D dma_set_coherent_mask(&pdev->dev, PCI402_DMA_MASK);
> > > +       if (err) {
> > > +               pci_err(pdev, "DMA set mask failed!\n");
> > > +               return err;
> > > +       }
> > > +
> > > +       /* The ESDACC DMA engine needs the DMA buffer aligned to a 64=
k
> > > +        * boundary. The DMA API guarantees to align the returned buf=
fer to the
> > > +        * smallest PAGE_SIZE order which is greater than or equal to=
 the
> > > +        * requested size. With PCI402_DMA_SIZE =3D=3D 64kB this suff=
ices here.
> > > +        */
> > > +       card->dma_buf =3D dma_alloc_coherent(&pdev->dev, PCI402_DMA_S=
IZE,
> > > +                                          &card->dma_hnd, GFP_KERNEL=
);
> > > +       if (!card->dma_buf)
> > > +               return -ENOMEM;
> > > +
> > > +       acc_init_bm_ptr(&card->ov, card->cores, card->dma_buf);
> > > +
> > > +       iowrite32(card->dma_hnd,
> > > +                 card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_LO);
> > > +       iowrite32(0, card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_HI);
> > > +
> > > +       pci_set_master(pdev);
> > > +
> > > +       acc_ov_set_bits(&card->ov, ACC_OV_OF_MODE,
> > > +                       ACC_OV_REG_MODE_MASK_BM_ENABLE);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void pci402_finish_dma(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +       int i;
> > > +
> > > +       acc_ov_clear_bits(&card->ov, ACC_OV_OF_MODE,
> > > +                         ACC_OV_REG_MODE_MASK_BM_ENABLE);
> > > +
> > > +       pci_clear_master(pdev);
> > > +
> > > +       iowrite32(0, card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_LO);
> > > +       iowrite32(0, card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_HI);
> > > +
> > > +       card->ov.bmfifo.messages =3D NULL;
> > > +       card->ov.bmfifo.irq_cnt =3D NULL;
> > > +       for (i =3D 0; i < card->ov.active_cores; i++) {
> > > +               struct acc_core *core =3D &card->cores[i];
> > > +
> > > +               core->bmfifo.messages =3D NULL;
> > > +               core->bmfifo.irq_cnt =3D NULL;
> > > +       }
> > > +
> > > +       dma_free_coherent(&pdev->dev, PCI402_DMA_SIZE, card->dma_buf,
> > > +                         card->dma_hnd);
> > > +       card->dma_buf =3D NULL;
> > > +}
> > > +
> > > +static int pci402_init_cores(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +       int err;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < card->ov.active_cores; i++) {
> > > +               struct acc_core *core =3D &card->cores[i];
> > > +               struct acc_net_priv *priv;
> > > +               struct net_device *netdev;
> > > +               u32 fifo_config;
> > > +
> > > +               core->addr =3D card->ov.addr + (i + 1) * PCI402_IO_LE=
N_CORE;
> > > +
> > > +               fifo_config =3D acc_read32(core, ACC_CORE_OF_TXFIFO_C=
ONFIG);
> > > +               core->tx_fifo_size =3D (fifo_config >> 24);
> > > +               if (core->tx_fifo_size <=3D 1) {
> > > +                       pci_err(pdev, "Invalid tx_fifo_size!\n");
> > > +                       err =3D -EINVAL;
> > > +                       goto failure;
> > > +               }
> > > +
> > > +               netdev =3D alloc_candev(sizeof(*priv), core->tx_fifo_=
size);
> > > +               if (!netdev) {
> > > +                       err =3D -ENOMEM;
> > > +                       goto failure;
> > > +               }
> > > +               core->netdev =3D netdev;
> > > +
> > > +               netdev->flags |=3D IFF_ECHO;
> > > +               netdev->dev_port =3D i;
> > > +               netdev->netdev_ops =3D &pci402_acc_netdev_ops;
> > > +               SET_NETDEV_DEV(netdev, &pdev->dev);
> > > +
> > > +               priv =3D netdev_priv(netdev);
> > > +               priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBAC=
K |
> > > +                       CAN_CTRLMODE_LISTENONLY |
> > > +                       CAN_CTRLMODE_BERR_REPORTING |
> > > +                       CAN_CTRLMODE_CC_LEN8_DLC;
> > > +
> > > +               priv->can.clock.freq =3D card->ov.core_frequency;
> > > +               if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD)
> > > +                       priv->can.bittiming_const =3D &pci402_bittimi=
ng_const_canfd;
> > > +               else
> > > +                       priv->can.bittiming_const =3D &pci402_bittimi=
ng_const;
> > > +               priv->can.do_set_bittiming =3D acc_set_bittiming;
> > > +               priv->can.do_set_mode =3D acc_set_mode;
> > > +               priv->can.do_get_berr_counter =3D acc_get_berr_counte=
r;
> > > +
> > > +               priv->core =3D core;
> > > +               priv->ov =3D &card->ov;
> > > +
> > > +               err =3D register_candev(netdev);
> > > +               if (err) {
> > > +                       free_candev(core->netdev);
> > > +                       core->netdev =3D NULL;
> > > +                       goto failure;
> > > +               }
> > > +
> > > +               netdev_info(netdev, "registered\n");
> >
> > Isn't this already reported by the core? Please check and if
> > redundant, remove (same comment for the unregister below).
>
> The register and unregister messages are only printed from the driver lev=
el.
> Also other CAN drivers print these kind of register and unregister messag=
es.
> I'll keep them for now.

OK. Thanks for checking.

> > > +       }
> > > +
> > > +       return 0;
> > > +
> > > +failure:
> > > +       for (i--; i >=3D 0; i--) {
> > > +               struct acc_core *core =3D &card->cores[i];
> > > +
> > > +               netdev_info(core->netdev, "unregistering...\n");
> > > +               unregister_candev(core->netdev);
> > > +
> > > +               free_candev(core->netdev);
> > > +               core->netdev =3D NULL;
> > > +       }
> >
> > Nitpick: this cleanup loop has the same content as the loop in
> > pci402_finish_cores(). Might be worth factorizing the code in an
> > helper function that would free a single core.
>
> Moved code to helper function pci402_unregister_core() and call
> this function twice.

Ack.

> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static void pci402_finish_cores(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < card->ov.active_cores; i++) {
> > > +               struct acc_core *core =3D &card->cores[i];
> > > +
> > > +               netdev_info(core->netdev, "unregister\n");
> > > +               unregister_candev(core->netdev);
> > > +
> > > +               free_candev(core->netdev);
> > > +               core->netdev =3D NULL;
> > > +       }
> > > +}
> > > +
> > > +static int pci402_probe(struct pci_dev *pdev, const struct pci_devic=
e_id *ent)
> > > +{
> > > +       struct pci402_card *card =3D NULL;
> > > +       int err;
> > > +
> > > +       err =3D pci_enable_device(pdev);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       card =3D devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
> > > +       if (!card) {
> > > +               err =3D -ENOMEM;
> > > +               goto failure_disable_pci;
> > > +       }
> > > +
> > > +       pci_set_drvdata(pdev, card);
> > > +
> > > +       err =3D pci_request_regions(pdev, pci_name(pdev));
> > > +       if (err)
> > > +               goto failure_disable_pci;
> > > +
> > > +       card->addr =3D pci_iomap(pdev, PCI402_BAR, PCI402_IO_LEN_TOTA=
L);
> > > +       if (!card->addr) {
> > > +               err =3D -ENOMEM;
> > > +               goto failure_release_regions;
> > > +       }
> > > +
> > > +       err =3D pci402_init_card(pdev);
> > > +       if (err)
> > > +               goto failure_unmap;
> > > +
> > > +       err =3D pci402_init_dma(pdev);
> > > +       if (err)
> > > +               goto failure_unmap;
> > > +
> > > +       err =3D pci402_init_interrupt(pdev);
> > > +       if (err)
> > > +               goto failure_finish_dma;
> > > +
> > > +       err =3D pci402_init_cores(pdev);
> > > +       if (err)
> > > +               goto failure_finish_interrupt;
> > > +
> > > +       return 0;
> > > +
> > > +failure_finish_interrupt:
> > > +       pci402_finish_interrupt(pdev);
> > > +
> > > +failure_finish_dma:
> > > +       pci402_finish_dma(pdev);
> > > +
> > > +failure_unmap:
> > > +       pci_iounmap(pdev, card->addr);
> > > +
> > > +failure_release_regions:
> > > +       pci_release_regions(pdev);
> > > +
> > > +failure_disable_pci:
> > > +       pci_disable_device(pdev);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static void pci402_remove(struct pci_dev *pdev)
> > > +{
> > > +       struct pci402_card *card =3D pci_get_drvdata(pdev);
> > > +
> > > +       pci402_finish_interrupt(pdev);
> > > +       pci402_finish_cores(pdev);
> > > +       pci402_finish_dma(pdev);
> > > +       pci_iounmap(pdev, card->addr);
> > > +       pci_release_regions(pdev);
> > > +       pci_disable_device(pdev);
> > > +}
> > > +
> > > +static const struct pci_device_id pci402_tbl[] =3D {
> > > +       {
> > > +               .vendor =3D PCI_VENDOR_ID_ESDGMBH,
> > > +               .device =3D ESD_PCI_DEVICE_ID_PCIE402,
> > > +               .subvendor =3D PCI_VENDOR_ID_ESDGMBH,
> > > +               .subdevice =3D PCI_ANY_ID,
> > > +       },
> > > +       { 0, }
> > > +};
> > > +MODULE_DEVICE_TABLE(pci, pci402_tbl);
> > > +
> > > +static struct pci_driver pci402_driver =3D {
> > > +       .name =3D KBUILD_MODNAME,
> > > +       .id_table =3D pci402_tbl,
> > > +       .probe =3D pci402_probe,
> > > +       .remove =3D pci402_remove,
> > > +};
> > > +module_pci_driver(pci402_driver);
> > > +
> > > +MODULE_DESCRIPTION("Socket-CAN driver for esd CAN 402 card family wi=
th esdACC core on PCIe");
> > > +MODULE_AUTHOR("Thomas K=C3=B6rper <socketcan@esd.eu>");
> > > +MODULE_AUTHOR("Stefan M=C3=A4tje <stefan.maetje@esd.eu>");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdac=
c.c
> > > new file mode 100644
> > > index 000000000000..49017c986c70
> > > --- /dev/null
> > > +++ b/drivers/net/can/esd/esdacc.c
> > > @@ -0,0 +1,771 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (C) 2015 - 2016 Thomas K=C3=B6rper, esd electronic syst=
em design gmbh
> > > + * Copyright (C) 2017 - 2022 Stefan M=C3=A4tje, esd electronics gmbh
> >
> >                         ^^^^
> > 2023? (Same comment for other files)
>
> Updated ...

Ack.

> >
> > > + */
> > > +
> > > +#include "esdacc.h"
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/io.h>
> > > +#include <linux/ktime.h>
> > > +
> > > +/* ecc value of esdACC equals SJA1000's ECC register */
> > > +#define ACC_ECC_SEG                    0x1f
> > > +#define ACC_ECC_DIR                    0x20
> > > +#define ACC_ECC_BIT                    0x00
> > > +#define ACC_ECC_FORM                   0x40
> > > +#define ACC_ECC_STUFF                  0x80
> > > +#define ACC_ECC_MASK                   0xc0
> > > +
> > > +#define ACC_BM_IRQ_UNMASK_ALL          0x55555555U
> > > +#define ACC_BM_IRQ_MASK_ALL            0xaaaaaaaaU
> > > +#define ACC_BM_IRQ_MASK                        0x2U
> > > +#define ACC_BM_IRQ_UNMASK              0x1U
> > > +#define ACC_BM_LENFLAG_TX              0x20
> > > +
> > > +#define ACC_REG_STATUS_IDX_STATUS_DOS  16
> > > +#define ACC_REG_STATUS_IDX_STATUS_ES   17
> > > +#define ACC_REG_STATUS_IDX_STATUS_EP   18
> > > +#define ACC_REG_STATUS_IDX_STATUS_BS   19
> > > +#define ACC_REG_STATUS_IDX_STATUS_RBS  20
> > > +#define ACC_REG_STATUS_IDX_STATUS_RS   21
> > > +#define ACC_REG_STATUS_MASK_STATUS_DOS BIT(ACC_REG_STATUS_IDX_STATUS=
_DOS)
> > > +#define ACC_REG_STATUS_MASK_STATUS_ES  BIT(ACC_REG_STATUS_IDX_STATUS=
_ES)
> > > +#define ACC_REG_STATUS_MASK_STATUS_EP  BIT(ACC_REG_STATUS_IDX_STATUS=
_EP)
> > > +#define ACC_REG_STATUS_MASK_STATUS_BS  BIT(ACC_REG_STATUS_IDX_STATUS=
_BS)
> > > +#define ACC_REG_STATUS_MASK_STATUS_RBS BIT(ACC_REG_STATUS_IDX_STATUS=
_RBS)
> > > +#define ACC_REG_STATUS_MASK_STATUS_RS  BIT(ACC_REG_STATUS_IDX_STATUS=
_RS)
> >
> > Many of these macros are not used:
> >
> >   ./include/linux/ctype.h:43:19: warning: declaration of =E2=80=98isdig=
it=E2=80=99
> > shadows a built-in function [-Wshadow]
> >      43 | static inline int isdigit(int c)
> >         |                   ^~~~~~~
> >   drivers/net/can/esd/esdacc.c:24: warning: macro "ACC_BM_IRQ_UNMASK"
> > is not used [-Wunused-macros]
> >      24 | #define ACC_BM_IRQ_UNMASK  0x1U
> >         |
> >   drivers/net/can/esd/esdacc.c:27: warning: macro
> > "ACC_REG_STATUS_IDX_STATUS_DOS" is not used [-Wunused-macros]
> >      27 | #define ACC_REG_STATUS_IDX_STATUS_DOS 16
> >         |
> >   drivers/net/can/esd/esdacc.c:37: warning: macro
> > "ACC_REG_STATUS_MASK_STATUS_RBS" is not used [-Wunused-macros]
> >      37 | #define ACC_REG_STATUS_MASK_STATUS_RBS
> > BIT(ACC_REG_STATUS_IDX_STATUS_RBS)
> >         |
> >   drivers/net/can/esd/esdacc.c:38: warning: macro
> > "ACC_REG_STATUS_MASK_STATUS_RS" is not used [-Wunused-macros]
> >      38 | #define ACC_REG_STATUS_MASK_STATUS_RS
> > BIT(ACC_REG_STATUS_IDX_STATUS_RS)
> >         |
> >   drivers/net/can/esd/esdacc.c:32: warning: macro
> > "ACC_REG_STATUS_IDX_STATUS_RS" is not used [-Wunused-macros]
> >      32 | #define ACC_REG_STATUS_IDX_STATUS_RS 21
> >         |
> >   drivers/net/can/esd/esdacc.c:31: warning: macro
> > "ACC_REG_STATUS_IDX_STATUS_RBS" is not used [-Wunused-macros]
> >      31 | #define ACC_REG_STATUS_IDX_STATUS_RBS 20
> >         |
> >   drivers/net/can/esd/esdacc.c:33: warning: macro
> > "ACC_REG_STATUS_MASK_STATUS_DOS" is not used [-Wunused-macros]
> >      33 | #define ACC_REG_STATUS_MASK_STATUS_DOS
> > BIT(ACC_REG_STATUS_IDX_STATUS_DOS)
> >         |
> >   drivers/net/can/esd/esdacc.c:22: warning: macro
> > "ACC_BM_IRQ_MASK_ALL" is not used [-Wunused-macros]
> >      22 | #define ACC_BM_IRQ_MASK_ALL  0xaaaaaaaaU
>
>
> Removed unused macros and also remove defines to only declare a bit numbe=
r
> that is used in a follow up mask define macro.

Ack.

> > > +static void acc_resetmode_enter(struct acc_core *core)
> > > +{
> > > +       acc_set_bits(core, ACC_CORE_OF_CTRL_MODE,
> > > +                    ACC_REG_CONTROL_MASK_MODE_RESETMODE);
> > > +
> > > +       /* Read back reset mode bit to flush PCI write posting */
> > > +       acc_resetmode_entered(core);
> > > +}
> > > +
> > > +static void acc_resetmode_leave(struct acc_core *core)
> > > +{
> > > +       acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
> > > +                      ACC_REG_CONTROL_MASK_MODE_RESETMODE);
> > > +
> > > +       /* Read back reset mode bit to flush PCI write posting */
> > > +       acc_resetmode_entered(core);
> > > +}
> > > +
> > > +static void acc_txq_put(struct acc_core *core, u32 acc_id, u8 acc_dl=
c,
> > > +                       const void *data)
> > > +{
> > > +       acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
> > > +                          *((const u32 *)(data + 4)));
> > > +       acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
> > > +                          *((const u32 *)data));
> > > +       acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
> > > +       /* CAN id must be written at last. This write starts TX. */
> > > +       acc_write32(core, ACC_CORE_OF_TXFIFO_ID, acc_id);
> > > +}
> > > +
> > > +/* Convert timestamp from esdACC time stamp ticks to ns
> > > + *
> > > + * The conversion factor ts2ns from time stamp counts to ns is basic=
ally
> > > + *     ts2ns =3D NSEC_PER_SEC / timestamp_frequency
> > > + *
> > > + * We handle here only a fixed timestamp frequency of 80MHz. The
> > > + * resulting ts2ns factor would be 12.5.
> > > + *
> > > + * At the end we multiply by 12 and add the half of the HW timestamp
> > > + * to get a multiplication by 12.5. This way any overflow is
> > > + * avoided until ktime_t itself overflows.
> > > + */
> > > +#define ACC_TS_FACTOR (NSEC_PER_SEC / ACC_TS_FREQ_80MHZ)
> > > +#define ACC_TS_80MHZ_SHIFT 1
> > > +
> > > +static ktime_t acc_ts2ktime(struct acc_ov *ov, u64 ts)
> > > +{
> > > +       u64 ns;
> > > +
> > > +       ns =3D (ts * ACC_TS_FACTOR) + (ts >> ACC_TS_80MHZ_SHIFT);
> > > +
> > > +       return ns_to_ktime(ns);
> > > +}
> > > +
> > > +void acc_init_ov(struct acc_ov *ov, struct device *dev)
> > > +{
> > > +       u32 temp;
> > > +
> > > +       temp =3D acc_ov_read32(ov, ACC_OV_OF_VERSION);
> > > +       ov->version =3D temp;
> > > +       ov->features =3D (temp >> 16);
> > > +
> > > +       temp =3D acc_ov_read32(ov, ACC_OV_OF_INFO);
> > > +       ov->total_cores =3D temp;
> > > +       ov->active_cores =3D (temp >> 8);
> > > +
> > > +       ov->core_frequency =3D acc_ov_read32(ov, ACC_OV_OF_CANCORE_FR=
EQ);
> > > +       ov->timestamp_frequency =3D acc_ov_read32(ov, ACC_OV_OF_TS_FR=
EQ_LO);
> > > +
> > > +       /* Depending on ESDACC feature NEW_PSC enable the new prescal=
er
> > > +        * or adjust core_frequency according to the implicit divisio=
n by 2.
> > > +        */
> > > +       if (ov->features & ACC_OV_REG_FEAT_MASK_NEW_PSC) {
> > > +               acc_ov_set_bits(ov, ACC_OV_OF_MODE,
> > > +                               ACC_OV_REG_MODE_MASK_NEW_PSC_ENABLE);
> > > +       } else {
> > > +               ov->core_frequency /=3D 2;
> > > +       }
> > > +
> > > +       dev_info(dev,
> > > +                "ESDACC v%u, freq: %u/%u, feat/strap: 0x%x/0x%x, cor=
es: %u/%u\n",
> > > +                ov->version, ov->core_frequency, ov->timestamp_frequ=
ency,
> > > +                ov->features, acc_ov_read32(ov, ACC_OV_OF_INFO) >> 1=
6,
> > > +                ov->active_cores, ov->total_cores);
> >
> > Consider using dev_dbg() instead of dev_info() here.
>
> I kept the dev_info() call because this carries important information for=
 the user that
> he can't see if his kernel was not built with dynamic debug support.
>
> The output shows the esdACC FPGA version, the feature and strap bits that=
 show what
> kind of add-on boards are connected to the CAN-PCIe/402* base board and h=
ow many of
> the implemented CAN interfaces are active.
>
> As an example for the kernel messages I quote the load messages for two b=
oards below.
> One of them is a CAN Classic board, the other one is CAN-FD capable.
>
> [] esd_402_pci 0000:01:00.0: enabling device (0000 -> 0002)
> [] esd_402_pci 0000:01:00.0: esdACC v73, freq: 80000000/80000000, feat/st=
rap: 0xf490/0x7b3d, cores: 2/4
> [] esd_402_pci 0000:01:00.0 can0: registered
> [] esd_402_pci 0000:01:00.0 can1: registered
> [] esd_402_pci 0000:05:00.0: enabling device (0000 -> 0002)
> [] esd_402_pci 0000:05:00.0: esdACC v75, freq: 80000000/80000000, feat/st=
rap: 0xfc90/0x143f, cores: 4/4
> [] esd_402_pci 0000:05:00.0: esdACC with CAN-FD feature detected. This dr=
iver doesn't support CAN-FD yet.
> [] esd_402_pci 0000:05:00.0 can2: registered
> [] esd_402_pci 0000:05:00.0 can3: registered
> [] esd_402_pci 0000:05:00.0 can4: registered
> [] esd_402_pci 0000:05:00.0 can5: registered

There is a general guidance that "when drivers work properly, they are
quiet". For example, see this message from Greg:

  https://lore.kernel.org/lkml/Y2YdH4dd8u%2FeUEXg@kroah.com/

If you need to report that extra information, the kernel log is not
the good place. devlink is one option for things such as the version
numbers:

  https://docs.kernel.org/networking/devlink/devlink-info.html

I do not think that there is a field to report the number of cores, so
you may want to speak to the devlink maintainers to see if you can add
this.

For the CAN specific capabilities netlink is a better place. What are
the features supported by your device which can not yet be reported
through the CAN controller features framework?

If you do not feel like implementing proper information reporting now,
then simply remove or make it a debug message.

> > > +}
> > > +
> > > +void acc_init_bm_ptr(struct acc_ov *ov, struct acc_core *cores, cons=
t void *mem)
> > > +{
> > > +       unsigned int u;
> > > +
> > > +       /* DMA buffer layout as follows where N is the number of CAN =
cores
> > > +        * implemented in the FPGA, i.e. N =3D ov->total_cores
> > > +        *
> > > +        *   Layout                   Section size
> > > +        * +-----------------------+
> > > +        * | FIFO Card/Overview    |  ACC_CORE_DMABUF_SIZE
> > > +        * |                       |
> > > +        * +-----------------------+
> > > +        * | FIFO Core0            |  ACC_CORE_DMABUF_SIZE
> > > +        * |                       |
> > > +        * +-----------------------+
> > > +        * | ...                   |  ...
> > > +        * |                       |
> > > +        * +-----------------------+
> > > +        * | FIFO CoreN            |  ACC_CORE_DMABUF_SIZE
> > > +        * |                       |
> > > +        * +-----------------------+
> > > +        * | irq_cnt Card/Overview |  sizeof(u32)
> > > +        * +-----------------------+
> > > +        * | irq_cnt Core0         |  sizeof(u32)
> > > +        * +-----------------------+
> > > +        * | ...                   |  ...
> > > +        * +-----------------------+
> > > +        * | irq_cnt CoreN         |  sizeof(u32)
> > > +        * +-----------------------+
> >
> > Nitpick, instead of drawing all the cells in ascii art, please prefer
> > a more frugal style.
> > Example:
> >
> >  Layout                 Section size
> > ---------------------------------------------
> >  FIFO Card/Overview     ACC_CORE_DMABUF_SIZE
> >  FIFO Core0             ACC_CORE_DMABUF_SIZE
> >  ...                    ...
>
> Condensed the comment as proposed.

Ack.

> > > +        */
> > > +       ov->bmfifo.messages =3D mem;
> > > +       ov->bmfifo.irq_cnt =3D mem + (ov->total_cores + 1U) * ACC_COR=
E_DMABUF_SIZE;
> > > +
> > > +       for (u =3D 0U; u < ov->active_cores; u++) {
> > > +               struct acc_core *core =3D &cores[u];
> > > +
> > > +               core->bmfifo.messages =3D mem + (u + 1U) * ACC_CORE_D=
MABUF_SIZE;
> > > +               core->bmfifo.irq_cnt =3D ov->bmfifo.irq_cnt + (u + 1U=
);
> > > +       }
> > > +}
> > > +
> > > +int acc_open(struct net_device *netdev)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> > > +       struct acc_core *core =3D priv->core;
> > > +       u32 tx_fifo_status;
> > > +       u32 ctrl_mode;
> > > +       int err;
> > > +
> > > +       /* Retry to enter RESET mode if out of sync. */
> > > +       if (priv->can.state !=3D CAN_STATE_STOPPED) {
> > > +               netdev_warn(netdev, "Entered %s() with bad can.state:=
 %s\n",
> > > +                           __func__, can_get_state_str(priv->can.sta=
te));
> > > +               acc_resetmode_enter(core);
> > > +               priv->can.state =3D CAN_STATE_STOPPED;
> > > +       }
> > > +
> > > +       err =3D open_candev(netdev);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       ctrl_mode =3D ACC_REG_CONTROL_MASK_IE_RXTX |
> > > +                       ACC_REG_CONTROL_MASK_IE_TXERROR |
> > > +                       ACC_REG_CONTROL_MASK_IE_ERRWARN |
> > > +                       ACC_REG_CONTROL_MASK_IE_OVERRUN |
> > > +                       ACC_REG_CONTROL_MASK_IE_ERRPASS;
> > > +
> > > +       if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> > > +               ctrl_mode |=3D ACC_REG_CONTROL_MASK_IE_BUSERR;
> > > +
> > > +       if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > > +               ctrl_mode |=3D ACC_REG_CONTROL_MASK_MODE_LOM;
> > > +
> > > +       acc_set_bits(core, ACC_CORE_OF_CTRL_MODE, ctrl_mode);
> > > +
> > > +       acc_resetmode_leave(core);
> > > +       priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > > +
> > > +       /* Resync TX FIFO indices to HW state after (re-)start. */
> > > +       tx_fifo_status =3D acc_read32(core, ACC_CORE_OF_TXFIFO_STATUS=
);
> > > +       core->tx_fifo_head =3D tx_fifo_status & 0xff;
> > > +       core->tx_fifo_tail =3D (tx_fifo_status >> 8) & 0xff;
> > > +
> > > +       netif_start_queue(netdev);
> > > +       return 0;
> > > +}
> > > +
> > > +int acc_close(struct net_device *netdev)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> > > +       struct acc_core *core =3D priv->core;
> > > +
> > > +       acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
> > > +                      ACC_REG_CONTROL_MASK_IE_RXTX |
> > > +                      ACC_REG_CONTROL_MASK_IE_TXERROR |
> > > +                      ACC_REG_CONTROL_MASK_IE_ERRWARN |
> > > +                      ACC_REG_CONTROL_MASK_IE_OVERRUN |
> > > +                      ACC_REG_CONTROL_MASK_IE_ERRPASS |
> > > +                      ACC_REG_CONTROL_MASK_IE_BUSERR);
> > > +
> > > +       netif_stop_queue(netdev);
> > > +       acc_resetmode_enter(core);
> > > +       priv->can.state =3D CAN_STATE_STOPPED;
> > > +
> > > +       /* Mark pending TX requests to be aborted after controller re=
start. */
> > > +       acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
> > > +
> > > +       /* ACC_REG_CONTROL_MASK_MODE_LOM is only accessible in RESET =
mode */
> > > +       acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
> > > +                      ACC_REG_CONTROL_MASK_MODE_LOM);
> > > +
> > > +       close_candev(netdev);
> > > +       return 0;
> > > +}
> > > +
> > > +netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *n=
etdev)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> > > +       struct acc_core *core =3D priv->core;
> > > +       struct can_frame *cf =3D (struct can_frame *)skb->data;
> > > +       u8 tx_fifo_head =3D core->tx_fifo_head;
> > > +       int fifo_usage;
> > > +       u32 acc_id;
> > > +       u8 acc_dlc;
> > > +
> > > +       if (can_dropped_invalid_skb(netdev, skb))
> > > +               return NETDEV_TX_OK;
> > > +
> > > +       /* Access core->tx_fifo_tail only once because it may be chan=
ged
> > > +        * from the interrupt level.
> > > +        */
> > > +       fifo_usage =3D tx_fifo_head - core->tx_fifo_tail;
> > > +       if (fifo_usage < 0)
> > > +               fifo_usage +=3D core->tx_fifo_size;
> > > +
> > > +       if (fifo_usage >=3D core->tx_fifo_size - 1) {
> > > +               netdev_err(core->netdev,
> > > +                          "BUG: TX ring full when queue awake!\n");
> > > +               netif_stop_queue(netdev);
> > > +               return NETDEV_TX_BUSY;
> > > +       }
> > > +
> > > +       if (fifo_usage =3D=3D core->tx_fifo_size - 2)
> > > +               netif_stop_queue(netdev);
> > > +
> > > +       acc_dlc =3D can_get_cc_dlc(cf, priv->can.ctrlmode);
> > > +       if (cf->can_id & CAN_RTR_FLAG)
> > > +               acc_dlc |=3D ACC_CAN_RTR_FLAG;
> > > +
> > > +       if (cf->can_id & CAN_EFF_FLAG) {
> > > +               acc_id =3D cf->can_id & CAN_EFF_MASK;
> > > +               acc_id |=3D ACC_CAN_EFF_FLAG;
> > > +       } else {
> > > +               acc_id =3D cf->can_id & CAN_SFF_MASK;
> > > +       }
> > > +
> > > +       can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
> > > +
> > > +       tx_fifo_head++;
> > > +       if (tx_fifo_head >=3D core->tx_fifo_size)
> > > +               tx_fifo_head =3D 0U;
> >
> > Those three lines are repeated several times when setting tx_fifo_head
> > or tx_fifo_tail. I suggest adding an helper function (e.g.
> > acc_inc_fifo_idx()) to factorize all that.
>
> I'll still need to have a look.
>
>
> > > +       core->tx_fifo_head =3D tx_fifo_head;
> > > +
> > > +       acc_txq_put(core, acc_id, acc_dlc, cf->data);
> > > +
> > > +       return NETDEV_TX_OK;
> > > +}
> > > +
> > > +int acc_get_berr_counter(const struct net_device *netdev,
> > > +                        struct can_berr_counter *bec)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> > > +       u32 core_status =3D acc_read32(priv->core, ACC_CORE_OF_STATUS=
);
> > > +
> > > +       bec->txerr =3D (core_status >> 8) & 0xff;
> > > +       bec->rxerr =3D core_status & 0xff;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int acc_set_mode(struct net_device *netdev, enum can_mode mode)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> > > +
> > > +       switch (mode) {
> > > +       case CAN_MODE_START:
> > > +               /* Paranoid FIFO index check. */
> > > +               {
> > > +                       const u32 tx_fifo_status =3D
> > > +                               acc_read32(priv->core, ACC_CORE_OF_TX=
FIFO_STATUS);
> > > +                       const u8 hw_fifo_head =3D tx_fifo_status;
> > > +
> > > +                       if (hw_fifo_head !=3D priv->core->tx_fifo_hea=
d ||
> > > +                           hw_fifo_head !=3D priv->core->tx_fifo_tai=
l) {
> > > +                               netdev_warn(netdev,
> > > +                                           "TX FIFO mismatch: T %2u =
H %2u; TFHW %#08x\n",
> > > +                                           priv->core->tx_fifo_tail,
> > > +                                           priv->core->tx_fifo_head,
> > > +                                           tx_fifo_status);
> > > +                       }
> > > +               }
> > > +               acc_resetmode_leave(priv->core);
> > > +               /* To leave the bus-off state the esdACC controller b=
egins
> > > +                * here a grace period where it counts 128 "idle cond=
itions" (each
> > > +                * of 11 consecutive recessive bits) on the bus as re=
quired
> > > +                * by the CAN spec.
> > > +                *
> > > +                * During this time the TX FIFO may still contain alr=
eady
> > > +                * aborted "zombie" frames that are only drained from=
 the FIFO
> > > +                * at the end of the grace period.
> > > +                *
> > > +                * To not to interfere with this drain process we don=
't
> > > +                * call netif_wake_queue() here. When the controller =
reaches
> > > +                * the error-active state again, it informs us about =
that
> > > +                * with an acc_bmmsg_errstatechange message. Then
> > > +                * netif_wake_queue() is called from
> > > +                * handle_core_msg_errstatechange() instead.
> > > +                */
> > > +               break;
> > > +
> > > +       default:
> > > +               return -EOPNOTSUPP;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int acc_set_bittiming(struct net_device *netdev)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> > > +       const struct can_bittiming *bt =3D &priv->can.bittiming;
> > > +       u32 brp;
> > > +       u32 btr;
> > > +
> > > +       if (priv->ov->features & ACC_OV_REG_FEAT_MASK_CANFD) {
> > > +               u32 fbtr =3D 0;
> > > +
> > > +               netdev_dbg(netdev, "bit timing: brp %u, prop %u, ph1 =
%u ph2 %u, sjw %u\n",
> > > +                          bt->brp, bt->prop_seg,
> > > +                          bt->phase_seg1, bt->phase_seg2, bt->sjw);
> > > +
> > > +               brp =3D FIELD_PREP(ACC_REG_BRP_FD_MASK_BRP, bt->brp -=
 1);
> > > +
> > > +               btr =3D FIELD_PREP(ACC_REG_BTR_FD_MASK_TSEG1, bt->pha=
se_seg1 + bt->prop_seg - 1);
> > > +               btr |=3D FIELD_PREP(ACC_REG_BTR_FD_MASK_TSEG2, bt->ph=
ase_seg2 - 1);
> > > +               btr |=3D FIELD_PREP(ACC_REG_BTR_FD_MASK_SJW, bt->sjw =
- 1);
> > > +
> > > +               /* Keep order of accesses to ACC_CORE_OF_BRP and ACC_=
CORE_OF_BTR. */
> > > +               acc_write32(priv->core, ACC_CORE_OF_BRP, brp);
> > > +               acc_write32(priv->core, ACC_CORE_OF_BTR, btr);
> > > +
> > > +               netdev_dbg(netdev, "ESDACC: BRP %u, NBTR 0x%08x, DBTR=
 0x%08x",
> > > +                          brp, btr, fbtr);
> > > +       } else {
> > > +               netdev_dbg(netdev, "bit timing: brp %u, prop %u, ph1 =
%u ph2 %u, sjw %u\n",
> > > +                          bt->brp, bt->prop_seg,
> > > +                          bt->phase_seg1, bt->phase_seg2, bt->sjw);
> > > +
> > > +               brp =3D FIELD_PREP(ACC_REG_BRP_CL_MASK_BRP, bt->brp -=
 1);
> > > +
> > > +               btr =3D FIELD_PREP(ACC_REG_BTR_CL_MASK_TSEG1, bt->pha=
se_seg1 + bt->prop_seg - 1);
> > > +               btr |=3D FIELD_PREP(ACC_REG_BTR_CL_MASK_TSEG2, bt->ph=
ase_seg2 - 1);
> > > +               btr |=3D FIELD_PREP(ACC_REG_BTR_CL_MASK_SJW, bt->sjw =
- 1);
> > > +
> > > +               /* Keep order of accesses to ACC_CORE_OF_BRP and ACC_=
CORE_OF_BTR. */
> > > +               acc_write32(priv->core, ACC_CORE_OF_BRP, brp);
> > > +               acc_write32(priv->core, ACC_CORE_OF_BTR, btr);
> > > +
> > > +               netdev_dbg(netdev, "ESDACC: BRP %u, BTR 0x%08x", brp,=
 btr);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void handle_core_msg_rxtxdone(struct acc_core *core,
> > > +                                    const struct acc_bmmsg_rxtxdone =
*msg)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> > > +       struct net_device_stats *stats =3D &core->netdev->stats;
> > > +       struct sk_buff *skb;
> > > +
> > > +       if (msg->dlc.rxtx.len & ACC_BM_LENFLAG_TX) {
> > > +               u8 tx_fifo_tail =3D core->tx_fifo_tail;
> > > +
> > > +               if (core->tx_fifo_head =3D=3D tx_fifo_tail) {
> > > +                       netdev_warn(core->netdev,
> > > +                                   "TX interrupt, but queue is empty=
!?\n");
> > > +                       return;
> > > +               }
> > > +
> > > +               /* Direct access echo skb to attach HW time stamp. */
> > > +               skb =3D priv->can.echo_skb[tx_fifo_tail];
> > > +               if (skb) {
> > > +                       skb_hwtstamps(skb)->hwtstamp =3D
> > > +                               acc_ts2ktime(priv->ov, msg->ts);
> > > +               }
> > > +
> > > +               stats->tx_packets++;
> > > +               stats->tx_bytes +=3D can_get_echo_skb(core->netdev, t=
x_fifo_tail,
> > > +                                                   NULL);
> > > +
> > > +               tx_fifo_tail++;
> > > +               if (tx_fifo_tail >=3D core->tx_fifo_size)
> > > +                       tx_fifo_tail =3D 0U;
> > > +               core->tx_fifo_tail =3D tx_fifo_tail;
> > > +
> > > +               netif_wake_queue(core->netdev);
> > > +
> > > +       } else {
> > > +               struct can_frame *cf;
> > > +
> > > +               skb =3D alloc_can_skb(core->netdev, &cf);
> > > +               if (!skb) {
> > > +                       stats->rx_dropped++;
> > > +                       return;
> > > +               }
> > > +
> > > +               cf->can_id =3D msg->id & CAN_EFF_MASK;
> >
> > Semantically, you want the exclude the EFF, RTR and ERR flags, right?
> > If so, use CAN_ERR_MASK instead of CAN_EFF_MASK.
> >
> >   https://elixir.bootlin.com/linux/v6.6/source/include/uapi/linux/can.h=
#L63
> >
> > Please also check the other use of CAN_EFF_MASK throughout the driver.
>
> At this point the CAN ID is extracted from esdACC's ID register. I confes=
s I
> was kind of too lazy to create an esdACC specific define with the same co=
ntent
> as CAN_EFF_MASK.
>
> This is now done as ACC_ID_ID_MASK and used here. Additionally there is n=
ow
> also an ACC_ID_EFF_FLAG renamed from ACC_CAN_EFF_FLAG (seen below).

Ack.

> > > +               if (msg->id & ACC_CAN_EFF_FLAG)
> > > +                       cf->can_id |=3D CAN_EFF_FLAG;
> > > +
> > > +               can_frame_set_cc_len(cf, msg->dlc.rx.len & ACC_CAN_DL=
C_MASK,
> > > +                                    priv->can.ctrlmode);
> > > +
> > > +               if (msg->dlc.rx.len & ACC_CAN_RTR_FLAG) {
> > > +                       cf->can_id |=3D CAN_RTR_FLAG;
> > > +               } else {
> > > +                       memcpy(cf->data, msg->data, cf->len);
> > > +                       stats->rx_bytes +=3D cf->len;
> > > +               }
> > > +               stats->rx_packets++;
> > > +
> > > +               skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->o=
v, msg->ts);
> > > +
> > > +               netif_rx(skb);
> > > +       }
> > > +}
> > > +
> > > +static void handle_core_msg_txabort(struct acc_core *core,
> > > +                                   const struct acc_bmmsg_txabort *m=
sg)
> > > +{
> > > +       struct net_device_stats *stats =3D &core->netdev->stats;
> > > +       u8 tx_fifo_tail =3D core->tx_fifo_tail;
> > > +       u32 abort_mask =3D msg->abort_mask;   /* u32 extend to avoid =
warnings later */
> > > +
> > > +       /* The abort_mask shows which frames were aborted in ESDACC's=
 FIFO. */
> > > +       while (tx_fifo_tail !=3D core->tx_fifo_head && (abort_mask)) =
{
> > > +               const u32 tail_mask =3D (1U << tx_fifo_tail);
> > > +
> > > +               if (!(abort_mask & tail_mask))
> > > +                       break;
> > > +               abort_mask &=3D ~tail_mask;
> > > +
> > > +               can_free_echo_skb(core->netdev, tx_fifo_tail, NULL);
> > > +               stats->tx_dropped++;
> > > +               stats->tx_aborted_errors++;
> > > +
> > > +               tx_fifo_tail++;
> > > +               if (tx_fifo_tail >=3D core->tx_fifo_size)
> > > +                       tx_fifo_tail =3D 0;
> > > +       }
> > > +       core->tx_fifo_tail =3D tx_fifo_tail;
> > > +       if (abort_mask)
> > > +               netdev_warn(core->netdev, "Unhandled aborted messages=
\n");
> > > +
> > > +       if (!acc_resetmode_entered(core))
> > > +               netif_wake_queue(core->netdev);
> > > +}
> > > +
> > > +static void handle_core_msg_overrun(struct acc_core *core,
> > > +                                   const struct acc_bmmsg_overrun *m=
sg)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> > > +       struct net_device_stats *stats =3D &core->netdev->stats;
> > > +       struct can_frame *cf;
> > > +       struct sk_buff *skb;
> > > +
> > > +       /* lost_cnt may be 0 if not supported by ESDACC version */
> > > +       if (msg->lost_cnt) {
> > > +               stats->rx_errors +=3D msg->lost_cnt;
> > > +               stats->rx_over_errors +=3D msg->lost_cnt;
> > > +       } else {
> > > +               stats->rx_errors++;
> > > +               stats->rx_over_errors++;
> > > +       }
> > > +
> > > +       skb =3D alloc_can_err_skb(core->netdev, &cf);
> > > +       if (!skb) {
> > > +               stats->rx_dropped++;
> > > +               return;
> > > +       }
> > > +
> > > +       cf->can_id |=3D CAN_ERR_CRTL;
> > > +       cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> > > +
> > > +       skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->ov, msg->=
ts);
> > > +
> > > +       netif_rx(skb);
> > > +}
> > > +
> > > +static void handle_core_msg_buserr(struct acc_core *core,
> > > +                                  const struct acc_bmmsg_buserr *msg=
)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> > > +       struct net_device_stats *stats =3D &core->netdev->stats;
> > > +       struct can_frame *cf;
> > > +       struct sk_buff *skb;
> > > +       const u32 reg_status =3D msg->reg_status;
> > > +       const u8 rxerr =3D reg_status;
> > > +       const u8 txerr =3D (reg_status >> 8);
> > > +       u8 can_err_prot_type =3D 0U;
> > > +
> > > +       priv->can.can_stats.bus_error++;
> > > +
> > > +       /* Error occurred during transmission? */
> > > +       if ((msg->ecc & ACC_ECC_DIR) =3D=3D 0) {
> > > +               can_err_prot_type |=3D CAN_ERR_PROT_TX;
> > > +               stats->tx_errors++;
> > > +       } else {
> > > +               stats->rx_errors++;
> > > +       }
> >
> > Nitpick: check the "boolean true" branch first:
> >
> >         if (msg->ecc & ACC_ECC_DIR) {
> >                 stats->rx_errors++;
> >         } else {
> >                 can_err_prot_type |=3D CAN_ERR_PROT_TX;
> >                 stats->tx_errors++;
> >         }
>
> Change applied.

Ack.

> > > +       /* Determine error type */
> > > +       switch (msg->ecc & ACC_ECC_MASK) {
> > > +       case ACC_ECC_BIT:
> > > +               can_err_prot_type |=3D CAN_ERR_PROT_BIT;
> > > +               break;
> > > +       case ACC_ECC_FORM:
> > > +               can_err_prot_type |=3D CAN_ERR_PROT_FORM;
> > > +               break;
> > > +       case ACC_ECC_STUFF:
> > > +               can_err_prot_type |=3D CAN_ERR_PROT_STUFF;
> > > +               break;
> > > +       default:
> > > +               can_err_prot_type |=3D CAN_ERR_PROT_UNSPEC;
> > > +               break;
> > > +       }
> > > +
> > > +       skb =3D alloc_can_err_skb(core->netdev, &cf);
> > > +       if (!skb) {
> > > +               stats->rx_dropped++;
> >
> > The CAN err skb is a socket CAN concept. It does not represent an
> > actual CAN frame. So no need to count that one as an rx_dropped.
>
> I'm aware that the "error frames" are artificially generated in the drive=
r. But I had
> the impression that in "newer" drivers the skb allocation errors would be=
 communicated
> to the user land using this mechanism (increasing rx_dropped).
>
> In any case I have removed now the incrementing of stats.rx_dropped for
> alloc_can_error_skb() failures now.
>
> Yes, I can follow the argumentation that the "error frames" are never on =
the bus and
> therefore should not be counted. But I can also imagine that it would be =
fine to see
> at least in the statistics that information that the driver tried to tran=
sfer could
> not be conveyed to the user land.
>
> Looking at https://www.kernel.org/doc/html/latest/networking/statistics.h=
tml skb
> allocation errors would also better go into stats.rx_missed_errors and no=
t in the
> stats.rx_dropped counter (this is explicitly mentioned in the rx_dropped =
description).

That's a valid comment. I also agree that stats.rx_missed_errors is a
better field.

> Unfortunately the behaviour of the current CAN drivers is not uniform. I'=
ve examined
> around 20 CAN drivers that touch the stats.rx_dropped. From these 20 driv=
ers 19
> drivers increment stats.rx_dropped for failures of alloc_can(fd)_skb() in=
 the RX
> path. But also 6 drivers do increase stats.rx_dropped for failures of
> alloc_can_error_skb(). This is around one third of the drivers.
>
> Perhaps the intended and preferred behaviour should be discussed in front=
 of a
> broader audience.

This is not the only thing that is (was) not uniform. I already spent
a fair amount of effort to clean-up all the mess:

  https://git.kernel.org/torvalds/c/676068db69b8

So far, no one argued against this. Now that it is agreed that
stats->rx_packets++ is not used anymore to count "successful" error
skb, stats.rx_dropped should not be used to count "unsuccessful" error
skb. If anyone reading this disagree, please raise your concern here.
The stats.rx_dropped instead of stats.rx_missed_error issue is still
here because I forget to fix it back then. I may fix it someday. But
meanwhile, I would like new drivers to do it right.

> > > +               return;
> > > +       }
> > > +
> > > +       cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> >
> > Set the CAN_ERR_CNT flag to inform the userland that the error
> > counters are available.
>
> Added the CAN_ERR_CNT to the cf->can_id.

Ack.

> > > +
> > > +       /* Set protocol error type */
> > > +       cf->data[2] =3D can_err_prot_type;
> > > +       /* Set error location */
> > > +       cf->data[3] =3D msg->ecc & ACC_ECC_SEG;
> > > +
> > > +       /* Insert CAN TX and RX error counters. */
> > > +       cf->data[6] =3D txerr;
> > > +       cf->data[7] =3D rxerr;
> > > +
> > > +       skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->ov, msg->=
ts);
> > > +
> > > +       netif_rx(skb);
> > > +}
> > > +
> > > +static void
> > > +handle_core_msg_errstatechange(struct acc_core *core,
> > > +                              const struct acc_bmmsg_errstatechange =
*msg)
> > > +{
> > > +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> > > +       struct net_device_stats *stats =3D &core->netdev->stats;
> > > +       struct can_frame *cf =3D NULL;
> > > +       struct sk_buff *skb;
> > > +       const u32 reg_status =3D msg->reg_status;
> > > +       const u8 rxerr =3D reg_status;
> > > +       const u8 txerr =3D (reg_status >> 8);
> > > +       enum can_state new_state;
> > > +
> > > +       if (reg_status & ACC_REG_STATUS_MASK_STATUS_BS) {
> > > +               new_state =3D CAN_STATE_BUS_OFF;
> > > +       } else if (reg_status & ACC_REG_STATUS_MASK_STATUS_EP) {
> > > +               new_state =3D CAN_STATE_ERROR_PASSIVE;
> > > +       } else if (reg_status & ACC_REG_STATUS_MASK_STATUS_ES) {
> > > +               new_state =3D CAN_STATE_ERROR_WARNING;
> > > +       } else {
> > > +               new_state =3D CAN_STATE_ERROR_ACTIVE;
> > > +               if (priv->can.state =3D=3D CAN_STATE_BUS_OFF) {
> > > +                       /* See comment in acc_set_mode() for CAN_MODE=
_START */
> > > +                       netif_wake_queue(core->netdev);
> > > +               }
> > > +       }
> > > +
> > > +       skb =3D alloc_can_err_skb(core->netdev, &cf);
> > > +
> > > +       if (new_state !=3D priv->can.state) {
> > > +               enum can_state tx_state, rx_state;
> > > +
> > > +               tx_state =3D (txerr >=3D rxerr) ?
> > > +                       new_state : CAN_STATE_ERROR_ACTIVE;
> > > +               rx_state =3D (rxerr >=3D txerr) ?
> > > +                       new_state : CAN_STATE_ERROR_ACTIVE;
> > > +
> > > +               /* Always call can_change_state() to update the state
> > > +                * even if alloc_can_err_skb() may have failed.
> > > +                * can_change_state() can cope with a NULL cf pointer=
.
> > > +                */
> > > +               can_change_state(core->netdev, cf, tx_state, rx_state=
);
> > > +       }
> > > +
> > > +       if (skb) {
> > > +               cf->data[6] =3D txerr;
> > > +               cf->data[7] =3D rxerr;
> >
> > Set the CAN_ERR_CNT flag to inform the userland that the error
> > counters are available.
>
> Added the CAN_ERR_CNT to the cf->can_id.

Ack.

> > > +
> > > +               skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->o=
v, msg->ts);
> > > +
> > > +               netif_rx(skb);
> > > +       } else {
> > > +               stats->rx_dropped++;
> >
> > The CAN err skb is a socket CAN concept. It does not represent an
> > actual CAN frame. So no need to count that one as an rx_dropped.
>
> Already commented on this at the previous occurrence.

Ack.

> > > +       }
> > > +
> > > +       if (new_state =3D=3D CAN_STATE_BUS_OFF) {
> > > +               acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
> > > +               can_bus_off(core->netdev);
> > > +       }
> > > +}
> > > +
> > > +static void handle_core_interrupt(struct acc_core *core)
> > > +{
> > > +       u32 msg_fifo_head =3D core->bmfifo.local_irq_cnt & 0xff;
> > > +
> > > +       while (core->bmfifo.msg_fifo_tail !=3D msg_fifo_head) {
> > > +               const union acc_bmmsg *msg =3D
> > > +                       &core->bmfifo.messages[core->bmfifo.msg_fifo_=
tail];
> > > +
> > > +               switch (msg->msg_id) {
> > > +               case BM_MSG_ID_RXTXDONE:
> > > +                       handle_core_msg_rxtxdone(core, &msg->rxtxdone=
);
> > > +                       break;
> > > +
> > > +               case BM_MSG_ID_TXABORT:
> > > +                       handle_core_msg_txabort(core, &msg->txabort);
> > > +                       break;
> > > +
> > > +               case BM_MSG_ID_OVERRUN:
> > > +                       handle_core_msg_overrun(core, &msg->overrun);
> > > +                       break;
> > > +
> > > +               case BM_MSG_ID_BUSERR:
> > > +                       handle_core_msg_buserr(core, &msg->buserr);
> > > +                       break;
> > > +
> > > +               case BM_MSG_ID_ERRPASSIVE:
> > > +               case BM_MSG_ID_ERRWARN:
> > > +                       handle_core_msg_errstatechange(core,
> > > +                                                      &msg->errstate=
change);
> > > +                       break;
> > > +
> > > +               default:
> > > +                       /* Ignore all other BM messages (like the CAN=
-FD messages) */
> > > +                       break;
> > > +               }
> > > +
> > > +               core->bmfifo.msg_fifo_tail =3D
> > > +                               (core->bmfifo.msg_fifo_tail + 1) & 0x=
ff;
> > > +       }
> > > +}
> > > +
> > > +/**
> > > + * acc_card_interrupt() - handle the interrupts of an esdACC FPGA
> > > + *
> > > + * @ov: overview module structure
> > > + * @cores: array of core structures
> > > + *
> > > + * This function handles all interrupts pending for the overview mod=
ule and the
> > > + * CAN cores of the esdACC FPGA.
> > > + *
> > > + * It examines for all cores (the overview module core and the CAN c=
ores)
> > > + * the bmfifo.irq_cnt and compares it with the previously saved
> > > + * bmfifo.local_irq_cnt. An IRQ is pending if they differ. The esdAC=
C FPGA
> > > + * updates the bmfifo.irq_cnt values by DMA.
> > > + *
> > > + * The pending interrupts are masked by writing to the IRQ mask regi=
ster at
> > > + * ACC_OV_OF_BM_IRQ_MASK. This register has for each core a two bit =
command
> > > + * field evaluated as follows:
> > > + *
> > > + * Define,   bit pattern: meaning
> > > + *                    00: no action
> > > + * ACC_BM_IRQ_UNMASK, 01: unmask interrupt
> > > + * ACC_BM_IRQ_MASK,   10: mask interrupt
> > > + *                    11: no action
> > > + *
> > > + * For each CAN core with a pending IRQ handle_core_interrupt() hand=
les all
> > > + * busmaster messages from the message FIFO. The last handled messag=
e (FIFO
> > > + * index) is written to the CAN core to acknowledge its handling.
> > > + *
> > > + * Last step is to unmask all interrupts in the FPGA using
> > > + * ACC_BM_IRQ_UNMASK_ALL.
> >
> > If using kdoc style, then also document the return value. c.f. this
> > W=3D2 error message:
> >
> >   drivers/net/can/esd/esdacc.c:719: warning: No description found for
> > return value of 'acc_card_interrupt'
>
> Added a description of the return value as needed.

Ack.

> >
> > > + */
> > > +irqreturn_t acc_card_interrupt(struct acc_ov *ov, struct acc_core *c=
ores)
> > > +{
> > > +       u32 irqmask;
> > > +       int i;
> > > +
> > > +       /* First we look for whom interrupts are pending, card/overvi=
ew
> > > +        * or any of the cores. Two bits in irqmask are used for each=
;
> > > +        * Each two bit field is set to ACC_BM_IRQ_MASK if an IRQ is
> > > +        * pending.
> > > +        */
> > > +       irqmask =3D 0;
> > > +       if (READ_ONCE(*ov->bmfifo.irq_cnt) !=3D ov->bmfifo.local_irq_=
cnt) {
> > > +               irqmask |=3D ACC_BM_IRQ_MASK;
> > > +               ov->bmfifo.local_irq_cnt =3D READ_ONCE(*ov->bmfifo.ir=
q_cnt);
> > > +       }
> > > +
> > > +       for (i =3D 0; i < ov->active_cores; i++) {
> > > +               struct acc_core *core =3D &cores[i];
> > > +
> > > +               if (READ_ONCE(*core->bmfifo.irq_cnt) !=3D core->bmfif=
o.local_irq_cnt) {
> > > +                       irqmask |=3D (ACC_BM_IRQ_MASK << (2 * (i + 1)=
));
> > > +                       core->bmfifo.local_irq_cnt =3D READ_ONCE(*cor=
e->bmfifo.irq_cnt);
> > > +               }
> > > +       }
> > > +
> > > +       if (!irqmask)
> > > +               return IRQ_NONE;
> > > +
> > > +       /* At second we tell the card we're working on them by writin=
g irqmask,
> > > +        * call handle_{ov|core}_interrupt and then acknowledge the
> > > +        * interrupts by writing irq_cnt:
> > > +        */
> > > +       acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_MASK, irqmask);
> > > +
> > > +       if (irqmask & ACC_BM_IRQ_MASK) {
> > > +               /* handle_ov_interrupt(); - no use yet. */
> > > +               acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_COUNTER,
> > > +                              ov->bmfifo.local_irq_cnt);
> > > +       }
> > > +
> > > +       for (i =3D 0; i < ov->active_cores; i++) {
> > > +               struct acc_core *core =3D &cores[i];
> > > +
> > > +               if (irqmask & (ACC_BM_IRQ_MASK << (2 * (i + 1)))) {
> > > +                       handle_core_interrupt(core);
> > > +                       acc_write32(core, ACC_OV_OF_BM_IRQ_COUNTER,
> > > +                                   core->bmfifo.local_irq_cnt);
> > > +               }
> > > +       }
> > > +
> > > +       acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_MASK, ACC_BM_IRQ_UNMASK_A=
LL);
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdac=
c.h
> > > new file mode 100644
> > > index 000000000000..73651bc1d52c
> > > --- /dev/null
> > > +++ b/drivers/net/can/esd/esdacc.h
> > > @@ -0,0 +1,393 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* Copyright (C) 2015 - 2016 Thomas K=C3=B6rper, esd electronic syst=
em design gmbh
> > > + * Copyright (C) 2017 - 2022 Stefan M=C3=A4tje, esd electronics gmbh
> > > + */
> > > +
> > > +#include <linux/bits.h>
> > > +#include <linux/can/dev.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/netdevice.h>
> > > +#include <linux/units.h>
> > > +
> > > +#define ACC_TS_FREQ_80MHZ                      (80 * HZ_PER_MHZ)
> > > +
> > > +#define ACC_CAN_EFF_FLAG                       0x20000000
> > > +#define ACC_CAN_RTR_FLAG                       0x10
> > > +#define ACC_CAN_DLC_MASK                       0x0f
> > > +
> > > +#define ACC_OV_OF_PROBE                                0x0000
> > > +#define ACC_OV_OF_VERSION                      0x0004
> > > +#define ACC_OV_OF_INFO                         0x0008
> > > +#define ACC_OV_OF_CANCORE_FREQ                 0x000c
> > > +#define ACC_OV_OF_TS_FREQ_LO                   0x0010
> > > +#define ACC_OV_OF_TS_FREQ_HI                   0x0014
> > > +#define ACC_OV_OF_IRQ_STATUS_CORES             0x0018
> > > +#define ACC_OV_OF_TS_CURR_LO                   0x001c
> > > +#define ACC_OV_OF_TS_CURR_HI                   0x0020
> > > +#define ACC_OV_OF_IRQ_STATUS                   0x0028
> > > +#define ACC_OV_OF_MODE                         0x002c
> > > +#define ACC_OV_OF_BM_IRQ_COUNTER               0x0070
> > > +#define ACC_OV_OF_BM_IRQ_MASK                  0x0074
> > > +#define ACC_OV_OF_MSI_DATA                     0x0080
> > > +#define ACC_OV_OF_MSI_ADDRESSOFFSET            0x0084
> >
> > The #define indentation style is not consistant between the different
> > files. Please pick one (I suggest the single space to make it easier
> > to add more defines later on).
>
> Switched to the single space indentation style. Switched to bit mask and
> mask declaration using BIT() and GENMASK() macros, respectively.
>
> Removed all defines declaring bit numbers which are only used for definit=
ion
> of bits and masks in other defines later.

Ack.

> > > +/* Feature flags are contained in the upper 16 bit of the version
> > > + * register at ACC_OV_OF_VERSION but only used with these masks afte=
r
> > > + * extraction into an extra variable =3D> (xx - 16).
> > > + */
> > > +#define ACC_OV_REG_FEAT_IDX_CANFD              (27 - 16)
> > > +#define ACC_OV_REG_FEAT_IDX_NEW_PSC            (28 - 16)
> > > +#define ACC_OV_REG_FEAT_MASK_CANFD             BIT(ACC_OV_REG_FEAT_I=
DX_CANFD)
> > > +#define ACC_OV_REG_FEAT_MASK_NEW_PSC           BIT(ACC_OV_REG_FEAT_I=
DX_NEW_PSC)
> > > +
> > > +#define ACC_OV_REG_MODE_MASK_ENDIAN_LITTLE     0x00000001
> > > +#define ACC_OV_REG_MODE_MASK_BM_ENABLE         0x00000002
> > > +#define ACC_OV_REG_MODE_MASK_MODE_LED          0x00000004
> > > +#define ACC_OV_REG_MODE_MASK_TIMER             0x00000070
> > > +#define ACC_OV_REG_MODE_MASK_TIMER_ENABLE      0x00000010
> > > +#define ACC_OV_REG_MODE_MASK_TIMER_ONE_SHOT    0x00000020
> > > +#define ACC_OV_REG_MODE_MASK_TIMER_ABSOLUTE    0x00000040
> > > +#define ACC_OV_REG_MODE_MASK_TS_SRC            0x00000180
> > > +#define ACC_OV_REG_MODE_MASK_I2C_ENABLE                0x00000800
> > > +#define ACC_OV_REG_MODE_MASK_MSI_ENABLE                0x00004000
> > > +#define ACC_OV_REG_MODE_MASK_NEW_PSC_ENABLE    0x00008000
> > > +#define ACC_OV_REG_MODE_MASK_FPGA_RESET                0x80000000
> > > +
> > > +#define ACC_CORE_OF_CTRL_MODE                  0x0000
> > > +#define ACC_CORE_OF_STATUS_IRQ                 0x0008
> > > +#define ACC_CORE_OF_BRP                                0x000c
> > > +#define ACC_CORE_OF_BTR                                0x0010
> > > +#define ACC_CORE_OF_FBTR                       0x0014
> > > +#define ACC_CORE_OF_STATUS                     0x0030
> > > +#define ACC_CORE_OF_TXFIFO_CONFIG              0x0048
> > > +#define ACC_CORE_OF_TXFIFO_STATUS              0x004c
> > > +#define ACC_CORE_OF_TX_STATUS_IRQ              0x0050
> > > +#define ACC_CORE_OF_TX_ABORT_MASK              0x0054
> > > +#define ACC_CORE_OF_BM_IRQ_COUNTER             0x0070
> > > +#define ACC_CORE_OF_TXFIFO_ID                  0x00c0
> > > +#define ACC_CORE_OF_TXFIFO_DLC                 0x00c4
> > > +#define ACC_CORE_OF_TXFIFO_DATA_0              0x00c8
> > > +#define ACC_CORE_OF_TXFIFO_DATA_1              0x00cc
> > > +
> > > +#define ACC_REG_CONTROL_IDX_MODE_RESETMODE     0
> > > +#define ACC_REG_CONTROL_IDX_MODE_LOM           1
> > > +#define ACC_REG_CONTROL_IDX_MODE_STM           2
> > > +#define ACC_REG_CONTROL_IDX_MODE_TRANSEN       5
> > > +#define ACC_REG_CONTROL_IDX_MODE_TS            6
> > > +#define ACC_REG_CONTROL_IDX_MODE_SCHEDULE      7
> > > +#define ACC_REG_CONTROL_MASK_MODE_RESETMODE    \
> > > +                               BIT(ACC_REG_CONTROL_IDX_MODE_RESETMOD=
E)
> > > +#define ACC_REG_CONTROL_MASK_MODE_LOM          \
> > > +                               BIT(ACC_REG_CONTROL_IDX_MODE_LOM)
> > > +#define ACC_REG_CONTROL_MASK_MODE_STM          \
> > > +                               BIT(ACC_REG_CONTROL_IDX_MODE_STM)
> > > +#define ACC_REG_CONTROL_MASK_MODE_TRANSEN      \
> > > +                               BIT(ACC_REG_CONTROL_IDX_MODE_TRANSEN)
> > > +#define ACC_REG_CONTROL_MASK_MODE_TS           \
> > > +                               BIT(ACC_REG_CONTROL_IDX_MODE_TS)
> > > +#define ACC_REG_CONTROL_MASK_MODE_SCHEDULE     \
> > > +                               BIT(ACC_REG_CONTROL_IDX_MODE_SCHEDULE=
)
> > > +
> > > +#define ACC_REG_CONTROL_IDX_IE_RXTX    8
> > > +#define ACC_REG_CONTROL_IDX_IE_TXERROR 9
> > > +#define ACC_REG_CONTROL_IDX_IE_ERRWARN 10
> > > +#define ACC_REG_CONTROL_IDX_IE_OVERRUN 11
> > > +#define ACC_REG_CONTROL_IDX_IE_TSI     12
> > > +#define ACC_REG_CONTROL_IDX_IE_ERRPASS 13
> > > +#define ACC_REG_CONTROL_IDX_IE_BUSERR  15
> > > +#define ACC_REG_CONTROL_MASK_IE_RXTX   BIT(ACC_REG_CONTROL_IDX_IE_RX=
TX)
> > > +#define ACC_REG_CONTROL_MASK_IE_TXERROR BIT(ACC_REG_CONTROL_IDX_IE_T=
XERROR)
> > > +#define ACC_REG_CONTROL_MASK_IE_ERRWARN BIT(ACC_REG_CONTROL_IDX_IE_E=
RRWARN)
> > > +#define ACC_REG_CONTROL_MASK_IE_OVERRUN BIT(ACC_REG_CONTROL_IDX_IE_O=
VERRUN)
> > > +#define ACC_REG_CONTROL_MASK_IE_TSI    BIT(ACC_REG_CONTROL_IDX_IE_TS=
I)
> > > +#define ACC_REG_CONTROL_MASK_IE_ERRPASS BIT(ACC_REG_CONTROL_IDX_IE_E=
RRPASS)
> > > +#define ACC_REG_CONTROL_MASK_IE_BUSERR BIT(ACC_REG_CONTROL_IDX_IE_BU=
SERR)
> > > +
> > > +/* BRP and BTR register layout for CAN-Classic version */
> > > +#define ACC_REG_BRP_CL_MASK_BRP         GENMASK(8, 0)
> > > +#define ACC_REG_BTR_CL_MASK_TSEG1       GENMASK(3, 0)
> > > +#define ACC_REG_BTR_CL_MASK_TSEG2       GENMASK(18, 16)
> > > +#define ACC_REG_BTR_CL_MASK_SJW         GENMASK(25, 24)
> > > +
> > > +/* BRP and BTR register layout for CAN-FD version */
> > > +#define ACC_REG_BRP_FD_MASK_BRP         GENMASK(7, 0)
> > > +#define ACC_REG_BTR_FD_MASK_TSEG1       GENMASK(7, 0)
> > > +#define ACC_REG_BTR_FD_MASK_TSEG2       GENMASK(22, 16)
> > > +#define ACC_REG_BTR_FD_MASK_SJW         GENMASK(30, 24)
> > > +
> > > +/* 256 BM_MSGs of 32 byte size */
> > > +#define ACC_CORE_DMAMSG_SIZE           32U
> > > +#define ACC_CORE_DMABUF_SIZE           (256U * ACC_CORE_DMAMSG_SIZE)
> > > +
> > > +enum acc_bmmsg_id {
> > > +       BM_MSG_ID_RXTXDONE =3D 0x01,
> > > +       BM_MSG_ID_TXABORT =3D 0x02,
> > > +       BM_MSG_ID_OVERRUN =3D 0x03,
> > > +       BM_MSG_ID_BUSERR =3D 0x04,
> > > +       BM_MSG_ID_ERRPASSIVE =3D 0x05,
> > > +       BM_MSG_ID_ERRWARN =3D 0x06,
> > > +       BM_MSG_ID_TIMESLICE =3D 0x07,
> > > +       BM_MSG_ID_HWTIMER =3D 0x08,
> > > +       BM_MSG_ID_HOTPLUG =3D 0x09,
> > > +};
> > > +
> > > +/* The struct acc_bmmsg_* structure declarations that follow here pr=
ovide
> > > + * access to the ring buffer of bus master messages maintained by th=
e FPGA
> > > + * bus master engine. All bus master messages have the same size of
> > > + * ACC_CORE_DMAMSG_SIZE and a minimum alignment of ACC_CORE_DMAMSG_S=
IZE in
> > > + * memory.
> > > + *
> > > + * All structure members are natural aligned. Therefore we should no=
t need
> > > + * a __packed attribute. All struct acc_bmmsg_* declarations have at=
 least
> > > + * reserved* members to fill the structure to the full ACC_CORE_DMAM=
SG_SIZE.
> > > + *
> > > + * A failure of this property due padding will be detected at compil=
e time
> > > + * by static_assert(sizeof(union acc_bmmsg) =3D=3D ACC_CORE_DMAMSG_S=
IZE).
> > > + */
> > > +
> > > +struct acc_bmmsg_rxtxdone {
> > > +       u8 msg_id;
> > > +       u8 txfifo_level;
> > > +       u8 reserved1[2];
> > > +       u8 txtsfifo_level;
> > > +       u8 reserved2[3];
> > > +       u32 id;
> > > +       union {
> > > +               struct {
> > > +                       u8 len;
> > > +                       u8 reserved0;
> >
> > Technically, this one is not reserved because is it used in both rx
> > and tx structures.
> >
> > > +                       u8 bits;
> > > +                       u8 state;
> > > +               } rxtx;
> > > +               struct {
> > > +                       u8 len;
> > > +                       u8 msg_lost;
> > > +                       u8 bits;
> > > +                       u8 state;
> > > +               } rx;
> > > +               struct {
> > > +                       u8 len;
> > > +                       u8 txfifo_idx;
> > > +                       u8 bits;
> > > +                       u8 state;
> > > +               } tx;
> > > +       } dlc;
> >
> >           ^^^
> > This looks like a misnomer to me: the union contains more than the dlc.
>
> This union really represents the esdACC's DLC register that indeed contai=
ns
> more than the CAN DLC only.

Ack.

> After talking to the collegue who maintains the esdACC core I've changed =
the
> structure declaration as follows due to changes in the esdACC core. The
> union dlc became a structure acc_dlc:
>
> struct acc_bmmsg_rxtxdone {
>         u8 msg_id;
>         u8 txfifo_level;
>         u8 reserved1[2];
>         u8 txtsfifo_level;
>         u8 reserved2[3];
>         u32 id;
>         struct {
>                 u8 len;
>                 u8 txdfifo_idx;
>                 u8 zeroes8;
>                 u8 reserved;
>         } acc_dlc;
>         u8 data[CAN_MAX_DLEN];
>         /* Time stamps in struct acc_ov::timestamp_frequency ticks. */
>         u64 ts;
> };

Looks better than before. Thanks for the change.

> > What about:
> >
> >         struct {
> >                 u8 len;
> >                 union {
> >                         u8 rx_msg_lost;
> >                         u8 tx_fifo_idx;
> >                 } __packed;
> >                 u8 bits;
> >                 u8 state;
> >         } rxtx;
> >
> > in place of that union?
> >
> > > +       u8 data[8];
> >
> > Nitpick:
> >
> >         u8 data[CAN_MAX_DLEN];
>
> Use now the appropriate define.

Ack.

> > > +       /* Time stamps in struct acc_ov::timestamp_frequency ticks. *=
/
> > > +       u64 ts;
> > > +};
> > > +
> > > +struct acc_bmmsg_txabort {
> > > +       u8 msg_id;
> > > +       u8 txfifo_level;
> > > +       u16 abort_mask;
> > > +       u8 txtsfifo_level;
> > > +       u8 reserved2[1];
> > > +       u16 abort_mask_txts;
> > > +       u64 ts;
> > > +       u32 reserved3[4];
> > > +};
> > > +
> > > +struct acc_bmmsg_overrun {
> > > +       u8 msg_id;
> > > +       u8 txfifo_level;
> > > +       u8 lost_cnt;
> > > +       u8 reserved1;
> > > +       u8 txtsfifo_level;
> > > +       u8 reserved2[3];
> > > +       u64 ts;
> > > +       u32 reserved3[4];
> > > +};
> > > +
> > > +struct acc_bmmsg_buserr {
> > > +       u8 msg_id;
> > > +       u8 txfifo_level;
> > > +       u8 ecc;
> > > +       u8 reserved1;
> > > +       u8 txtsfifo_level;
> > > +       u8 reserved2[3];
> > > +       u64 ts;
> > > +       u32 reg_status;
> > > +       u32 reg_btr;
> > > +       u32 reserved3[2];
> > > +};
> > > +
> > > +struct acc_bmmsg_errstatechange {
> > > +       u8 msg_id;
> > > +       u8 txfifo_level;
> > > +       u8 reserved1[2];
> > > +       u8 txtsfifo_level;
> > > +       u8 reserved2[3];
> > > +       u64 ts;
> > > +       u32 reg_status;
> > > +       u32 reserved3[3];
> > > +};
> > > +
> > > +struct acc_bmmsg_timeslice {
> > > +       u8 msg_id;
> > > +       u8 txfifo_level;
> > > +       u8 reserved1[2];
> > > +       u8 txtsfifo_level;
> > > +       u8 reserved2[3];
> > > +       u64 ts;
> > > +       u32 reserved3[4];
> > > +};
> > > +
> > > +struct acc_bmmsg_hwtimer {
> > > +       u8 msg_id;
> > > +       u8 reserved1[3];
> > > +       u32 reserved2[1];
> > > +       u64 timer;
> > > +       u32 reserved3[4];
> > > +};
> > > +
> > > +struct acc_bmmsg_hotplug {
> > > +       u8 msg_id;
> > > +       u8 reserved1[3];
> > > +       u32 reserved2[7];
> > > +};
> > > +
> > > +union acc_bmmsg {
> > > +       u8 msg_id;
> > > +       struct acc_bmmsg_rxtxdone rxtxdone;
> > > +       struct acc_bmmsg_txabort txabort;
> > > +       struct acc_bmmsg_overrun overrun;
> > > +       struct acc_bmmsg_buserr buserr;
> > > +       struct acc_bmmsg_errstatechange errstatechange;
> > > +       struct acc_bmmsg_timeslice timeslice;
> > > +       struct acc_bmmsg_hwtimer hwtimer;
> > > +};
> > > +
> > > +/* Check size of union acc_bmmsg to be of expected size. */
> > > +static_assert(sizeof(union acc_bmmsg) =3D=3D ACC_CORE_DMAMSG_SIZE);
> > > +
> > > +struct acc_bmfifo {
> > > +       const union acc_bmmsg *messages;
> > > +       /* irq_cnt points to an u32 value where the ESDACC FPGA depos=
its
> > > +        * the bm_fifo head index in coherent DMA memory. Only bits 7=
..0
> > > +        * are valid. Use READ_ONCE() to access this memory location.
> > > +        */
> > > +       const u32 *irq_cnt;
> > > +       u32 local_irq_cnt;
> > > +       u32 msg_fifo_tail;
> > > +};
> > > +
> > > +struct acc_core {
> > > +       void __iomem *addr;
> > > +       struct net_device *netdev;
> > > +       struct acc_bmfifo bmfifo;
> > > +       u8 tx_fifo_size;
> > > +       u8 tx_fifo_head;
> > > +       u8 tx_fifo_tail;
> > > +};
> > > +
> > > +struct acc_ov {
> > > +       void __iomem *addr;
> > > +       struct acc_bmfifo bmfifo;
> > > +       u32 timestamp_frequency;
> > > +       u32 core_frequency;
> > > +       u16 version;
> > > +       u16 features;
> > > +       u8 total_cores;
> > > +       u8 active_cores;
> > > +};
> > > +
> > > +struct acc_net_priv {
> > > +       struct can_priv can; /* must be the first member! */
> > > +       struct acc_core *core;
> > > +       struct acc_ov *ov;
> > > +};
> > > +
> > > +static inline u32 acc_read32(struct acc_core *core, unsigned short o=
ffs)
> > > +{
> > > +       return ioread32be(core->addr + offs);
> > > +}
> > > +
> > > +static inline void acc_write32(struct acc_core *core,
> > > +                              unsigned short offs, u32 v)
> > > +{
> > > +       iowrite32be(v, core->addr + offs);
> > > +}
> > > +
> > > +static inline void acc_write32_noswap(struct acc_core *core,
> > > +                                     unsigned short offs, u32 v)
> > > +{
> > > +       iowrite32(v, core->addr + offs);
> > > +}
> > > +
> > > +static inline void acc_set_bits(struct acc_core *core,
> > > +                               unsigned short offs, u32 mask)
> > > +{
> > > +       u32 v =3D acc_read32(core, offs);
> > > +
> > > +       v |=3D mask;
> > > +       acc_write32(core, offs, v);
> > > +}
> > > +
> > > +static inline void acc_clear_bits(struct acc_core *core,
> > > +                                 unsigned short offs, u32 mask)
> > > +{
> > > +       u32 v =3D acc_read32(core, offs);
> > > +
> > > +       v &=3D ~mask;
> > > +       acc_write32(core, offs, v);
> > > +}
> > > +
> > > +static inline int acc_resetmode_entered(struct acc_core *core)
> > > +{
> > > +       u32 ctrl =3D acc_read32(core, ACC_CORE_OF_CTRL_MODE);
> > > +
> > > +       return (ctrl & ACC_REG_CONTROL_MASK_MODE_RESETMODE) !=3D 0;
> > > +}
> > > +
> > > +static inline u32 acc_ov_read32(struct acc_ov *ov, unsigned short of=
fs)
> > > +{
> > > +       return ioread32be(ov->addr + offs);
> > > +}
> > > +
> > > +static inline void acc_ov_write32(struct acc_ov *ov,
> > > +                                 unsigned short offs, u32 v)
> > > +{
> > > +       iowrite32be(v, ov->addr + offs);
> > > +}
> > > +
> > > +static inline void acc_ov_set_bits(struct acc_ov *ov,
> > > +                                  unsigned short offs, u32 b)
> > > +{
> > > +       u32 v =3D acc_ov_read32(ov, offs);
> > > +
> > > +       v |=3D b;
> > > +       acc_ov_write32(ov, offs, v);
> > > +}
> > > +
> > > +static inline void acc_ov_clear_bits(struct acc_ov *ov,
> > > +                                    unsigned short offs, u32 b)
> > > +{
> > > +       u32 v =3D acc_ov_read32(ov, offs);.
> > > +
> > > +       v &=3D ~b;
> > > +       acc_ov_write32(ov, offs, v);
> > > +}
> > > +
> > > +static inline void acc_reset_fpga(struct acc_ov *ov)
> > > +{
> > > +       acc_ov_write32(ov, ACC_OV_OF_MODE, ACC_OV_REG_MODE_MASK_FPGA_=
RESET);
> > > +
> > > +       /* Also reset I^2C, to re-detect card addons at every driver =
start: */
> > > +       acc_ov_clear_bits(ov, ACC_OV_OF_MODE, ACC_OV_REG_MODE_MASK_I2=
C_ENABLE);
> > > +       mdelay(2);
> > > +       acc_ov_set_bits(ov, ACC_OV_OF_MODE, ACC_OV_REG_MODE_MASK_I2C_=
ENABLE);
> > > +       mdelay(10);
> >
> > Maybe add a macro to replace those two delays magic numbers?
>
> After talking to the esdACC maintainer the function was reworked. The fir=
st delay could
> be removed. For the 10ms delay a define was added.

Ack.

> >
> > > +}
> > > +
> > > +void acc_init_ov(struct acc_ov *ov, struct device *dev);
> > > +void acc_init_bm_ptr(struct acc_ov *ov, struct acc_core *cores,
> > > +                    const void *mem);
> > > +int acc_open(struct net_device *netdev);
> > > +int acc_close(struct net_device *netdev);
> > > +netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *n=
etdev);
> > > +int acc_get_berr_counter(const struct net_device *netdev,
> > > +                        struct can_berr_counter *bec);
> > > +int acc_set_mode(struct net_device *netdev, enum can_mode mode);
> > > +int acc_set_bittiming(struct net_device *netdev);
> > > +irqreturn_t acc_card_interrupt(struct acc_ov *ov, struct acc_core *c=
ores);
> > > --
> > > 2.34.1
> > >
> > >

