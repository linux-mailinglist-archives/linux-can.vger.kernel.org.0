Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1994D70CA06
	for <lists+linux-can@lfdr.de>; Mon, 22 May 2023 21:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjEVTyJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 May 2023 15:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjEVTyI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 May 2023 15:54:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF995
        for <linux-can@vger.kernel.org>; Mon, 22 May 2023 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1684785235; i=ps.report@gmx.net;
        bh=X2XH+LEb2sQQAITuDi3WC3YGwM0s/n7vGfGHV4ch5X4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=dHyrItw/hliMp4nfCxT6qAPcImffpJQ309nGtoa07vl/1gb0TiZQ8QkHh6pfciR3N
         LrEYL+/sX3HpxobRZqz+t4/1rFT1kH/l6EU+37gZoLsp1kvFXNqlzxA7oNVtLxoSUm
         YRn8hVCDtC2c3iKxbZRHkfDyPRlbz5UH3oIdZ3x/QApuhdXqWdEbyAU4jQr93WmV8u
         e5xKmgcItg/cTkZKXnbOGC7QVLt3rIw+qlm46HjT6JAuwpDt7KaPzz2LfYo0sYLcOc
         oNSWliE9LY0R2GqlZEx3MArXd4nA8EOpBap8uKz/Ti0dCE3zo9QscGRn5+Rn5R/lrf
         SkyjaRdrrBSeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.209.74]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1qG63e20aX-00tQA1; Mon, 22
 May 2023 21:53:55 +0200
Date:   Mon, 22 May 2023 21:53:54 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Florian Ferg <flfe@hms-networks.de>, socketcan@hms-networks.de
Subject: Re: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Message-ID: <20230522215354.2c79c007@gmx.net>
In-Reply-To: <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
References: <20230515212930.1019702-1-mkl@pengutronix.de>
        <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sQ4cj69yJw+khCOeKNW1XUu4Q+bujIr9Ne1ol6CTRoeFtXv7tIn
 pUEzePP+h7oDWcc8fRpt3xNycajnQ1VHgOUg8tT7SfdtbLP+QzxZJppouvlzHUfy2X3GxhF
 +hcEObanvmuZL65+FK2LxwsbFrl/p+sle3/5H/Ef8gta8UxWfauh5xq7mViJ0CzQR4dHS2r
 Eo2dHzX0wJDXU9jtBW40w==
UI-OutboundReport: notjunk:1;M01:P0:8K8CG7up1BA=;0NwHYmzcdHjeel0mhncNE1B8jtW
 3iY+tnEkYDpHdf/Q5wr9lINN93u+LCh9ujXEV8LRWRCO7gnOcpuJ/R6J3KcOi+zi0YGSAJXRS
 ALUL9Yj9mIrSdwLOa82rDbB1aM4lJCHG+QRNt29lrzLCQiwzfZeOO6NjgXbF9Dc5r0OBWo1Q5
 n1BhcBf/iSv12uT923C4b8siwXaBBjt9ORRxVECAQYRM0I1kg8qdB5cz2/+CgtK0B9WeDxT+g
 l6Ce6l+G2mrzoPl3aymGl2kJQD8OZIQUjpDdIKQcA00M14nto0+IUDm3FMs439mm4hzsGBESe
 rfU91ZISMZ0yCMEXJKqzjXWb3+vmoyH70P+A4+odTljNJh7pNwCT+WCnUd9tGd6UYOM1w5wEK
 jawHOLJsJdhAScc4KGghFMBXlDSEU0jWDJLghQIW/PqhRLpyMkmSa16+Xry5sqMhMOs5EcpG8
 So1kKT5N0Sos2nAf/NaoucGZn98j8KVHvLpy+45N19hd/is2oR4MTPx2gVDdSkFcivywc4y4X
 qSINoKNkQPXKrdYpzROIAyD62kz1J9YCvznpCS829MhCoVECABQGwzCfpr1kDFsp4j4fVSrub
 /enn+WPy0oNZ3Rg6Hdy3deizojeXdhMcaR+MGfRlAAWEjraueCT9/HeMdUI6AeDD/YggAd2xL
 HOowsfHSk9XnGDEMl6d+Emi+4oZqZfEJhw97Y/Shdifmy8CsdVlz/NOHH/DZHhPf6WNg/NDlD
 FXRztWuH4gL+HVk6gkLTpGKjKJNVUZuVSkJEoUpOOOYGi8F+h/EPz9whM3G1lXQ6j+WgguVOB
 YS+vauMvilVUPh3R0A6hfSEgjXSQfQB61xXR+KDdIDC20K0xBQfT1W25aH3KAXHY0IhdWEu+n
 lC2dwNawP0NCtaEE+DtnHQ8jX+6FVufRrDCl/ZUSOdEQ8gUgtTMjGt+ybz0CClWR9pATNCuOI
 ZhsOGLokLD9rI1agIDsmxmiKRr0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Vincent, Marc,

Added CC: socketcan@hms-networks.de (taken from the copyright headers)

@Marc: Your updated version (still) works for me...

@Vincent: Thanks for review (and for the detailed links), will send out an
updated version addressing most (all but one) of your review comments,
see remarks/questions below...

On Tue, 16 May 2023 18:30:18 +0900, Vincent Mailhol <vincent.mailhol@gmail.=
com> wrote:

> On Tue. 16 May 2023 =C3=A0 06:30, Marc Kleine-Budde <mkl@pengutronix.de> =
wrote:
> > From: Florian Ferg <flfe@hms-networks.de>
> >
> > This patch adds the driver for the IXXAT USB-to-CAN interfaces. There
> > is an adapter for the older communication layer cl1 and another
> > adapter for the newer communication layer cl2.
> >
> > Cc: Peter Seiderer <ps.report@gmx.net>
> > Signed-off-by: Florian Ferg <flfe@hms-networks.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Hello,
> >
> > this is a quick port of Florian's driver to recent net-next. Compile
> > tested only. =20
>=20
> And this is my quick review. I did not try to understand the full
> logic, just looked for the usual suspect. If someone is willing to
> address these comments, then I would do another deeper review.
>=20
> > regards,
> > Marc
> >
> >  drivers/net/can/usb/Kconfig                   |   17 +
> >  drivers/net/can/usb/Makefile                  |    1 +
> >  drivers/net/can/usb/ixxat_usb/Makefile        |    2 +
> >  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  132 ++
> >  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  255 ++++
> >  .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 1299 +++++++++++++++++
> >  .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  519 +++++++
> >  7 files changed, 2225 insertions(+)
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
> >
> > diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> > index 445504ababce..9ce31848d257 100644
> > --- a/drivers/net/can/usb/Kconfig
> > +++ b/drivers/net/can/usb/Kconfig
> > @@ -50,6 +50,23 @@ config CAN_GS_USB
> >           choose Y for built in support,
> >           M to compile as module (module will be named: gs_usb).
> >
> > +config CAN_IXXAT_USB
> > +       tristate "IXXAT USB-to-CAN interfaces"
> > +       help
> > +         This driver adds support for IXXAT USB-to-CAN devices.
> > +
> > +         The driver provides support for the following devices:
> > +           - IXXAT USB-to-CAN compact
> > +           - IXXAT USB-to-CAN embedded
> > +           - IXXAT USB-to-CAN professional
> > +           - IXXAT USB-to-CAN automotive
> > +           - IXXAT USB-to-CAN FD compact
> > +           - IXXAT USB-to-CAN FD professional
> > +           - IXXAT USB-to-CAN FD automotive
> > +           - IXXAT USB-to-CAN FD MiniPCIe
> > +           - IXXAT USB-to-CAR
> > +           - IXXAT CAN-IDM101
> > +
> >  config CAN_KVASER_USB
> >         tristate "Kvaser CAN/USB interface"
> >         help
> > diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> > index 1ea16be5743b..d57c06e95751 100644
> > --- a/drivers/net/can/usb/Makefile
> > +++ b/drivers/net/can/usb/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_CAN_EMS_USB) +=3D ems_usb.o
> >  obj-$(CONFIG_CAN_ESD_USB) +=3D esd_usb.o
> >  obj-$(CONFIG_CAN_ETAS_ES58X) +=3D etas_es58x/
> >  obj-$(CONFIG_CAN_GS_USB) +=3D gs_usb.o
> > +obj-$(CONFIG_CAN_IXXAT_USB) +=3D ixxat_usb/
> >  obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb/
> >  obj-$(CONFIG_CAN_MCBA_USB) +=3D mcba_usb.o
> >  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
> > diff --git a/drivers/net/can/usb/ixxat_usb/Makefile b/drivers/net/can/u=
sb/ixxat_usb/Makefile
> > new file mode 100644
> > index 000000000000..125d2705979f
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_CAN_IXXAT_USB) +=3D ixxat_usb2can.o
> > +ixxat_usb2can-y =3D ixxat_usb_cl1.o ixxat_usb_cl2.o ixxat_usb_core.o
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/ne=
t/can/usb/ixxat_usb/ixxat_usb_cl1.c
> > new file mode 100644
> > index 000000000000..2a17392db583
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* CAN driver adapter for IXXAT USB-to-CAN CL1
> > + *
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published
> > + * by the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + */ =20
>=20
> The SPDX identifier is enough. No need to add the full GPL
> boilerplate. This comment also applies to the other files.

O.k, and did change all SPDX-License identifier to GPL-2.0-only accordingly=
..

>=20
> > +#include <linux/kernel.h>
> > +#include <linux/can/dev.h>
> > +#include <linux/usb.h> =20
>=20
> Please reorder the includes by lexicographic order. The same comment
> applies to the other #includes from the other files.

O.k.

>=20
> > +#include "ixxat_usb_core.h"
> > +
> > +#define IXXAT_USB_CLOCK 8000000
> > +
> > +#define IXXAT_USB_BUFFER_SIZE_RX 512
> > +#define IXXAT_USB_BUFFER_SIZE_TX 256
> > +
> > +#define IXXAT_USB_MODES (CAN_CTRLMODE_3_SAMPLES | \
> > +                        CAN_CTRLMODE_BERR_REPORTING | \
> > +                        CAN_CTRLMODE_LISTENONLY) \ =20
>=20
> Remove this #define and put them directly in the declaration of struct
> ixxat_usb_adapter usb2can_cl1. The same comment applies to the other
> *_USB_MODES declarations.

O.k.

>=20
> > +#define IXXAT_USB_BTMODE_TSM_CL1 0x80
> > +
> > +/* bittiming parameters */
> > +#define IXXAT_USB2CAN_TSEG1_MIN 1
> > +#define IXXAT_USB2CAN_TSEG1_MAX 16
> > +#define IXXAT_USB2CAN_TSEG2_MIN 1
> > +#define IXXAT_USB2CAN_TSEG2_MAX 8
> > +#define IXXAT_USB2CAN_SJW_MAX 4
> > +#define IXXAT_USB2CAN_BRP_MIN 1
> > +#define IXXAT_USB2CAN_BRP_MAX 64
> > +#define IXXAT_USB2CAN_BRP_INC 1 =20
>=20
> Remove the #defines and put the value directly in struct
> can_bittiming_const usb2can_b. The same comment also applies the the
> other bittiming parameter declarations.

O.k.

>=20
> > +/* USB endpoint mapping for CL1 */
> > +#define IXXAT_USB2CAN_EP1_IN (1 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP2_IN (2 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP3_IN (3 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP4_IN (4 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP5_IN (5 | USB_DIR_IN)
> > +
> > +#define IXXAT_USB2CAN_EP1_OUT (1 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP2_OUT (2 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP3_OUT (3 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP4_OUT (4 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP5_OUT (5 | USB_DIR_OUT) =20
>=20
> Remove the #defines and put the value directly instruct
> ixxat_usb_adapter usb2can_cl1. The same comment also applies the the
> other USB end points declarations.

O.k.

>=20
> > +#define IXXAT_USB_CAN_CMD_INIT 0x325
> > +
> > +static const struct can_bittiming_const usb2can_bt =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D IXXAT_USB2CAN_TSEG1_MIN,
> > +       .tseg1_max =3D IXXAT_USB2CAN_TSEG1_MAX,
> > +       .tseg2_min =3D IXXAT_USB2CAN_TSEG2_MIN,
> > +       .tseg2_max =3D IXXAT_USB2CAN_TSEG2_MAX,
> > +       .sjw_max =3D IXXAT_USB2CAN_SJW_MAX,
> > +       .brp_min =3D IXXAT_USB2CAN_BRP_MIN,
> > +       .brp_max =3D IXXAT_USB2CAN_BRP_MAX,
> > +       .brp_inc =3D IXXAT_USB2CAN_BRP_INC,
> > +};
> > +
> > +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const struct can_bittiming *bt =3D &dev->can.bittiming;
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_init_cl1_cmd *cmd;
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +       const u32 snd_size =3D sizeof(*cmd); =20
>=20
> Remove those size variables and directly use sizeof(cmd->res) and
> sizeof(*cmd) in the code.

O.k.

>=20
> > +       u8 opmode =3D IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STAN=
DARD;
> > +       u8 btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << =
6); =20
>=20
> Add a macro definition for the 0x3f  and 0x3 masks using GENMASK() and
> then calculate the value using FIELD_PREP().

O.k., define names o.k.?

+#define IXXAT_USB_CAN_BTR0_BRP_MASK GENMASK(5, 0)
+#define IXXAT_USB_CAN_BTR0_SJW_MASK GENMASK(7, 6)

>=20
> > +       u8 btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
> > +                 (((bt->phase_seg2 - 1) & 0x7) << 4); =20
>=20
> Same: GENMASK() and FIELD_PREP().

O.k., define names o.k.?

+#define IXXAT_USB_CAN_BTR1_TIME_SEG1_MASK GENMASK(3, 0)
+#define IXXAT_USB_CAN_BTR1_TIME_SEG2_MASK GENMASK(6, 4)

>=20
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> > +               btr1 |=3D IXXAT_USB_BTMODE_TSM_CL1;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> > +               opmode |=3D IXXAT_USB_OPMODE_ERRFRAME;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > +               opmode |=3D IXXAT_USB_OPMODE_LISTONLY;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(snd_size - rcv_size);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->mode =3D opmode;
> > +       cmd->btr0 =3D btr0;
> > +       cmd->btr1 =3D btr1;
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +const struct ixxat_usb_adapter usb2can_cl1 =3D {
> > +       .clock =3D IXXAT_USB_CLOCK,
> > +       .bt =3D &usb2can_bt,
> > +       .btd =3D NULL,
> > +       .modes =3D IXXAT_USB_MODES,
> > +       .buffer_size_rx =3D IXXAT_USB_BUFFER_SIZE_RX,
> > +       .buffer_size_tx =3D IXXAT_USB_BUFFER_SIZE_TX,
> > +       .ep_msg_in =3D {
> > +               IXXAT_USB2CAN_EP1_IN,
> > +               IXXAT_USB2CAN_EP2_IN,
> > +               IXXAT_USB2CAN_EP3_IN,
> > +               IXXAT_USB2CAN_EP4_IN,
> > +               IXXAT_USB2CAN_EP5_IN
> > +       },
> > +       .ep_msg_out =3D {
> > +               IXXAT_USB2CAN_EP1_OUT,
> > +               IXXAT_USB2CAN_EP2_OUT,
> > +               IXXAT_USB2CAN_EP3_OUT,
> > +               IXXAT_USB2CAN_EP4_OUT,
> > +               IXXAT_USB2CAN_EP5_OUT
> > +       },
> > +       .ep_offs =3D 0,
> > +       .init_ctrl =3D ixxat_usb_init_ctrl
> > +};
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/ne=
t/can/usb/ixxat_usb/ixxat_usb_cl2.c
> > new file mode 100644
> > index 000000000000..c08f323c5765
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
> > @@ -0,0 +1,255 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* CAN driver adapter for IXXAT USB-to-CAN CL2
> > + *
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published
> > + * by the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/can/dev.h>
> > +#include <linux/usb.h>
> > +
> > +#include "ixxat_usb_core.h"
> > +
> > +#define IXXAT_USB_CLOCK 80000000
> > +
> > +#define IXXAT_USB_BUFFER_SIZE_RX 512
> > +#define IXXAT_USB_BUFFER_SIZE_TX 512
> > +
> > +#define IXXAT_USB_MODES (CAN_CTRLMODE_3_SAMPLES | \
> > +                        CAN_CTRLMODE_LISTENONLY | \
> > +                        CAN_CTRLMODE_BERR_REPORTING | \
> > +                        CAN_CTRLMODE_FD | \
> > +                        CAN_CTRLMODE_FD_NON_ISO)
> > +
> > +/* bittiming parameters CL2 */
> > +#define IXXAT_USB2CAN_TSEG1_MIN 1
> > +#define IXXAT_USB2CAN_TSEG1_MAX 256
> > +#define IXXAT_USB2CAN_TSEG2_MIN 1
> > +#define IXXAT_USB2CAN_TSEG2_MAX 256
> > +#define IXXAT_USB2CAN_SJW_MAX 128
> > +#define IXXAT_USB2CAN_BRP_MIN 2
> > +#define IXXAT_USB2CAN_BRP_MAX 513
> > +#define IXXAT_USB2CAN_BRP_INC 1
> > +
> > +#define IXXAT_USB2CAN_TSEG1_MIN_DATA 1
> > +#define IXXAT_USB2CAN_TSEG1_MAX_DATA 256
> > +#define IXXAT_USB2CAN_TSEG2_MIN_DATA 1
> > +#define IXXAT_USB2CAN_TSEG2_MAX_DATA 256
> > +#define IXXAT_USB2CAN_SJW_MAX_DATA 128
> > +#define IXXAT_USB2CAN_BRP_MIN_DATA 2
> > +#define IXXAT_USB2CAN_BRP_MAX_DATA 513
> > +#define IXXAT_USB2CAN_BRP_INC_DATA 1
> > +
> > +/* bittiming parameters CAN IDM */
> > +#define IXXAT_CANIDM_TSEG1_MIN 1
> > +#define IXXAT_CANIDM_TSEG1_MAX 256
> > +#define IXXAT_CANIDM_TSEG2_MIN 1
> > +#define IXXAT_CANIDM_TSEG2_MAX 128
> > +#define IXXAT_CANIDM_SJW_MAX 128
> > +#define IXXAT_CANIDM_BRP_MIN 1
> > +#define IXXAT_CANIDM_BRP_MAX 512
> > +#define IXXAT_CANIDM_BRP_INC 1
> > +
> > +#define IXXAT_CANIDM_TSEG1_MIN_DATA 1
> > +#define IXXAT_CANIDM_TSEG1_MAX_DATA 32
> > +#define IXXAT_CANIDM_TSEG2_MIN_DATA 1
> > +#define IXXAT_CANIDM_TSEG2_MAX_DATA 16
> > +#define IXXAT_CANIDM_SJW_MAX_DATA 8
> > +#define IXXAT_CANIDM_BRP_MIN_DATA 1
> > +#define IXXAT_CANIDM_BRP_MAX_DATA 32
> > +#define IXXAT_CANIDM_BRP_INC_DATA 1
> > +
> > +/* USB endpoint mapping for CL2 */
> > +#define IXXAT_USB2CAN_EP1_IN (1 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP2_IN (2 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP3_IN (3 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP4_IN (4 | USB_DIR_IN)
> > +#define IXXAT_USB2CAN_EP5_IN (5 | USB_DIR_IN)
> > +
> > +#define IXXAT_USB2CAN_EP1_OUT (1 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP2_OUT (2 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP3_OUT (3 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP4_OUT (4 | USB_DIR_OUT)
> > +#define IXXAT_USB2CAN_EP5_OUT (5 | USB_DIR_OUT)
> > +
> > +/* USB endpoint mapping for CAN IDM */
> > +#define IXXAT_CANIDM_EP1_IN (2 | USB_DIR_IN)
> > +#define IXXAT_CANIDM_EP2_IN (4 | USB_DIR_IN)
> > +#define IXXAT_CANIDM_EP3_IN (6 | USB_DIR_IN)
> > +#define IXXAT_CANIDM_EP4_IN (8 | USB_DIR_IN)
> > +#define IXXAT_CANIDM_EP5_IN (10 | USB_DIR_IN)
> > +
> > +#define IXXAT_CANIDM_EP1_OUT (1 | USB_DIR_OUT)
> > +#define IXXAT_CANIDM_EP2_OUT (3 | USB_DIR_OUT)
> > +#define IXXAT_CANIDM_EP3_OUT (5 | USB_DIR_OUT)
> > +#define IXXAT_CANIDM_EP4_OUT (7 | USB_DIR_OUT)
> > +#define IXXAT_CANIDM_EP5_OUT (9 | USB_DIR_OUT)
> > +
> > +#define IXXAT_USB_CAN_CMD_INIT 0x337
> > +
> > +static const struct can_bittiming_const usb2can_bt =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D IXXAT_USB2CAN_TSEG1_MIN,
> > +       .tseg1_max =3D IXXAT_USB2CAN_TSEG1_MAX,
> > +       .tseg2_min =3D IXXAT_USB2CAN_TSEG2_MIN,
> > +       .tseg2_max =3D IXXAT_USB2CAN_TSEG2_MAX,
> > +       .sjw_max =3D IXXAT_USB2CAN_SJW_MAX,
> > +       .brp_min =3D IXXAT_USB2CAN_BRP_MIN,
> > +       .brp_max =3D IXXAT_USB2CAN_BRP_MAX,
> > +       .brp_inc =3D IXXAT_USB2CAN_BRP_INC,
> > +};
> > +
> > +static const struct can_bittiming_const usb2can_btd =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D IXXAT_USB2CAN_TSEG1_MIN_DATA,
> > +       .tseg1_max =3D IXXAT_USB2CAN_TSEG1_MAX_DATA,
> > +       .tseg2_min =3D IXXAT_USB2CAN_TSEG2_MIN_DATA,
> > +       .tseg2_max =3D IXXAT_USB2CAN_TSEG2_MAX_DATA,
> > +       .sjw_max =3D IXXAT_USB2CAN_SJW_MAX_DATA,
> > +       .brp_min =3D IXXAT_USB2CAN_BRP_MIN_DATA,
> > +       .brp_max =3D IXXAT_USB2CAN_BRP_MAX_DATA,
> > +       .brp_inc =3D IXXAT_USB2CAN_BRP_INC_DATA,
> > +};
> > +
> > +static const struct can_bittiming_const canidm_bt =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D IXXAT_CANIDM_TSEG1_MIN,
> > +       .tseg1_max =3D IXXAT_CANIDM_TSEG1_MAX,
> > +       .tseg2_min =3D IXXAT_CANIDM_TSEG2_MIN,
> > +       .tseg2_max =3D IXXAT_CANIDM_TSEG2_MAX,
> > +       .sjw_max =3D IXXAT_CANIDM_SJW_MAX,
> > +       .brp_min =3D IXXAT_CANIDM_BRP_MIN,
> > +       .brp_max =3D IXXAT_CANIDM_BRP_MAX,
> > +       .brp_inc =3D IXXAT_CANIDM_BRP_INC
> > +};
> > +
> > +static const struct can_bittiming_const canidm_btd =3D {
> > +       .name =3D IXXAT_USB_CTRL_NAME,
> > +       .tseg1_min =3D IXXAT_CANIDM_TSEG1_MIN_DATA,
> > +       .tseg1_max =3D IXXAT_CANIDM_TSEG1_MAX_DATA,
> > +       .tseg2_min =3D IXXAT_CANIDM_TSEG2_MIN_DATA,
> > +       .tseg2_max =3D IXXAT_CANIDM_TSEG2_MAX_DATA,
> > +       .sjw_max =3D IXXAT_CANIDM_SJW_MAX_DATA,
> > +       .brp_min =3D IXXAT_CANIDM_BRP_MIN_DATA,
> > +       .brp_max =3D IXXAT_CANIDM_BRP_MAX_DATA,
> > +       .brp_inc =3D IXXAT_CANIDM_BRP_INC_DATA
> > +};
> > +
> > +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const struct can_bittiming *bt =3D &dev->can.bittiming;
> > +       const struct can_bittiming *btd =3D &dev->can.data_bittiming;
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_init_cl2_cmd *cmd;
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +       const u32 snd_size =3D sizeof(*cmd);
> > +       u32 btmode =3D IXXAT_USB_BTMODE_NAT;
> > +       u8 exmode =3D 0;
> > +       u8 opmode =3D IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STAN=
DARD;
> > +
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> > +               btmode =3D IXXAT_USB_BTMODE_TSM;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> > +               opmode |=3D IXXAT_USB_OPMODE_ERRFRAME;
> > +       if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > +               opmode |=3D IXXAT_USB_OPMODE_LISTONLY;
> > +       if (dev->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_=
ISO)) {
> > +               exmode |=3D IXXAT_USB_EXMODE_EXTDATA | IXXAT_USB_EXMODE=
_FASTDATA;
> > +
> > +               if (!(dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
> > +                       exmode |=3D IXXAT_USB_EXMODE_ISOFD;
> > +       }
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(snd_size - rcv_size);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->opmode =3D opmode;
> > +       cmd->exmode =3D exmode;
> > +       cmd->sdr.mode =3D cpu_to_le32(btmode);
> > +       cmd->sdr.bps =3D cpu_to_le32(bt->brp);
> > +       cmd->sdr.ts1 =3D cpu_to_le16(bt->prop_seg + bt->phase_seg1);
> > +       cmd->sdr.ts2 =3D cpu_to_le16(bt->phase_seg2);
> > +       cmd->sdr.sjw =3D cpu_to_le16(bt->sjw);
> > +       cmd->sdr.tdo =3D 0;
> > +
> > +       if (exmode) {
> > +               cmd->fdr.mode =3D cpu_to_le32(btmode);
> > +               cmd->fdr.bps =3D cpu_to_le32(btd->brp);
> > +               cmd->fdr.ts1 =3D cpu_to_le16(btd->prop_seg + btd->phase=
_seg1);
> > +               cmd->fdr.ts2 =3D cpu_to_le16(btd->phase_seg2);
> > +               cmd->fdr.sjw =3D cpu_to_le16(btd->sjw);
> > +               cmd->fdr.tdo =3D cpu_to_le16(btd->brp * (btd->phase_seg=
1 + 1 +
> > +                                                      btd->prop_seg));
> > +       }
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +const struct ixxat_usb_adapter usb2can_cl2 =3D {
> > +       .clock =3D IXXAT_USB_CLOCK,
> > +       .bt =3D &usb2can_bt,
> > +       .btd =3D &usb2can_btd,
> > +       .modes =3D IXXAT_USB_MODES,
> > +       .buffer_size_rx =3D IXXAT_USB_BUFFER_SIZE_RX,
> > +       .buffer_size_tx =3D IXXAT_USB_BUFFER_SIZE_TX,
> > +       .ep_msg_in =3D {
> > +               IXXAT_USB2CAN_EP1_IN,
> > +               IXXAT_USB2CAN_EP2_IN,
> > +               IXXAT_USB2CAN_EP3_IN,
> > +               IXXAT_USB2CAN_EP4_IN,
> > +               IXXAT_USB2CAN_EP5_IN
> > +       },
> > +       .ep_msg_out =3D {
> > +               IXXAT_USB2CAN_EP1_OUT,
> > +               IXXAT_USB2CAN_EP2_OUT,
> > +               IXXAT_USB2CAN_EP3_OUT,
> > +               IXXAT_USB2CAN_EP4_OUT,
> > +               IXXAT_USB2CAN_EP5_OUT
> > +       },
> > +       .ep_offs =3D 1,
> > +       .init_ctrl =3D ixxat_usb_init_ctrl
> > +};
> > +
> > +const struct ixxat_usb_adapter can_idm =3D {
> > +       .clock =3D IXXAT_USB_CLOCK,
> > +       .bt =3D &canidm_bt,
> > +       .btd =3D &canidm_btd,
> > +       .modes =3D IXXAT_USB_MODES,
> > +       .buffer_size_rx =3D IXXAT_USB_BUFFER_SIZE_RX,
> > +       .buffer_size_tx =3D IXXAT_USB_BUFFER_SIZE_TX,
> > +       .ep_msg_in =3D {
> > +               IXXAT_CANIDM_EP1_IN,
> > +               IXXAT_CANIDM_EP2_IN,
> > +               IXXAT_CANIDM_EP3_IN,
> > +               IXXAT_CANIDM_EP4_IN,
> > +               IXXAT_CANIDM_EP5_IN
> > +       },
> > +       .ep_msg_out =3D {
> > +               IXXAT_CANIDM_EP1_OUT,
> > +               IXXAT_CANIDM_EP2_OUT,
> > +               IXXAT_CANIDM_EP3_OUT,
> > +               IXXAT_CANIDM_EP4_OUT,
> > +               IXXAT_CANIDM_EP5_OUT
> > +       },
> > +       .ep_offs =3D 0,
> > +       .init_ctrl =3D ixxat_usb_init_ctrl
> > +};
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/n=
et/can/usb/ixxat_usb/ixxat_usb_core.c
> > new file mode 100644
> > index 000000000000..eee5a6b39774
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
> > @@ -0,0 +1,1299 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* CAN driver for IXXAT USB-to-CAN
> > + *
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published
> > + * by the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/can/dev.h>
> > +#include <linux/kthread.h>
> > +#include <linux/usb.h>
> > +
> > +#include "ixxat_usb_core.h"
> > +
> > +MODULE_AUTHOR("Marcel Schmidt <socketcan@hms-networks.de>");
> > +MODULE_DESCRIPTION("CAN driver for IXXAT USB-to-CAN / CAN FD adapters"=
);
> > +MODULE_LICENSE("GPL v2");
> > +
> > +/* Table of devices that work with this driver */
> > +static const struct usb_device_id ixxat_usb_table[] =3D {
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_COMPACT_PRODUCT_ID) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_EMBEDDED_PRODUCT_ID) =
},
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_PROFESSIONAL_PRODUCT_=
ID) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_AUTOMOTIVE_PRODUCT_ID=
) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_COMPACT_PRODUCT_ID=
) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PROFESSIONAL_PRODU=
CT_ID) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_AUTOMOTIVE_PRODUCT=
_ID) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PCIE_MINI_PRODUCT_=
ID) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAR_PRODUCT_ID) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM101_PRODUCT_ID) },
> > +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM200_PRODUCT_ID) },
> > +       { } /* Terminating entry */
> > +};
> > +
> > +MODULE_DEVICE_TABLE(usb, ixxat_usb_table);
> > +
> > +void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
> > +                        struct ixxat_usb_dal_res *res)
> > +{
> > +       req->size =3D cpu_to_le32(sizeof(*req));
> > +       req->port =3D cpu_to_le16(0xffff);
> > +       req->socket =3D cpu_to_le16(0xffff);
> > +       req->code =3D cpu_to_le32(0);
> > +
> > +       res->res_size =3D cpu_to_le32(sizeof(*res));
> > +       res->ret_size =3D cpu_to_le32(0);
> > +       res->code =3D cpu_to_le32(0xffffffff);
> > +}
> > +
> > +int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *r=
eq,
> > +                      const u16 req_size, void *res, const u16 res_siz=
e)
> > +{
> > +       const int to =3D msecs_to_jiffies(IXXAT_USB_MSG_TIMEOUT);
> > +       const u8 rq =3D 0xff;
> > +       const u8 rti =3D USB_TYPE_VENDOR | USB_DIR_IN;
> > +       const u8 rto =3D USB_TYPE_VENDOR | USB_DIR_OUT;
> > +       int i;
> > +       int pos =3D 0;
> > +       int rcp =3D usb_rcvctrlpipe(dev, 0);
> > +       int scp =3D usb_sndctrlpipe(dev, 0);
> > +       int ret =3D 0;
> > +       struct ixxat_usb_dal_res *dal_res =3D res;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
> > +               ret =3D usb_control_msg(dev, scp, rq, rto, port, 0, req=
, req_size,
> > +                                     to);
> > +               if (ret < 0)
> > +                       msleep(IXXAT_USB_MSG_CYCLE);
> > +               else
> > +                       break;
> > +       }
> > +
> > +       if (ret < 0) {
> > +               dev_err(&dev->dev, "Error %d: TX command failure\n", re=
t); =20
>=20
> For all your errors, use %pe to print the mnemonic instead of the error c=
ode.
>=20
>                  dev_err(&dev->dev, "TX command failure: %pe\n", ERR_PTR(=
ret));
>=20

O.K.

> > +               goto fail;
> > +       }
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
> > +               const int rs =3D res_size - pos;
> > +               void *rb =3D res + pos;
> > +
> > +               ret =3D usb_control_msg(dev, rcp, rq, rti, port, 0, rb,=
 rs, to);
> > +               if (ret < 0) {
> > +                       msleep(IXXAT_USB_MSG_CYCLE);
> > +                       continue;
> > +               }
> > +
> > +               pos +=3D ret;
> > +               if (pos < res_size)
> > +                       msleep(IXXAT_USB_MSG_CYCLE);
> > +               else
> > +                       break;
> > +       }
> > +
> > +       if (pos !=3D res_size)
> > +               ret =3D -EBADMSG;
> > +
> > +       if (ret < 0) {
> > +               dev_err(&dev->dev, "Error %d: RX command failure\n", re=
t);
> > +               goto fail;
> > +       }
> > +
> > +       ret =3D le32_to_cpu(dal_res->code);
> > +
> > +fail:
> > +       return ret;
> > +}
> > +
> > +static void ixxat_usb_update_ts_now(struct ixxat_usb_device *dev, u32 =
ts_now)
> > +{
> > +       u32 *ts_dev =3D &dev->time_ref.ts_dev_0;
> > +       ktime_t *kt_host =3D &dev->time_ref.kt_host_0;
> > +       u64 timebase =3D (u64)0x00000000FFFFFFFF - (u64)(*ts_dev) + (u6=
4)ts_now; =20
>=20
> Replace 0x00000000FFFFFFFF by U32_MAX from linux/limits.h

O.k.

>=20
> > +       *kt_host =3D ktime_add_us(*kt_host, timebase);
> > +       *ts_dev =3D ts_now;
> > +}
> > +
> > +static void ixxat_usb_get_ts_tv(struct ixxat_usb_device *dev, u32 ts,
> > +                               ktime_t *k_time)
> > +{
> > +       ktime_t tmp_time =3D dev->time_ref.kt_host_0;
> > +
> > +       if (ts < dev->time_ref.ts_dev_last)
> > +               ixxat_usb_update_ts_now(dev, ts);
> > +
> > +       dev->time_ref.ts_dev_last =3D ts;
> > +       tmp_time =3D ktime_add_us(tmp_time, ts - dev->time_ref.ts_dev_0=
);
> > +
> > +       if (k_time)
> > +               *k_time =3D tmp_time;
> > +}
> > +
> > +static void ixxat_usb_set_ts_now(struct ixxat_usb_device *dev, u32 ts_=
now)
> > +{
> > +       dev->time_ref.ts_dev_0 =3D ts_now;
> > +       dev->time_ref.kt_host_0 =3D ktime_get_real();
> > +       dev->time_ref.ts_dev_last =3D ts_now;
> > +}
> > +
> > +static int ixxat_usb_get_dev_caps(struct usb_device *dev,
> > +                                 struct ixxat_dev_caps *dev_caps)
> > +{
> > +       int i;
> > +       int err;
> > +       struct ixxat_usb_caps_cmd *cmd;
> > +       const u32 cmd_size =3D sizeof(*cmd);
> > +       const u32 req_size =3D sizeof(cmd->req);
> > +       const u32 rcv_size =3D cmd_size - req_size;
> > +       const u32 snd_size =3D req_size + sizeof(cmd->res);
> > +       u16 num_ctrl;
> > +
> > +       cmd =3D kmalloc(cmd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVCAPS);
> > +       cmd->res.res_size =3D cpu_to_le32(rcv_size);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd=
, snd_size,
> > +                                &cmd->res, rcv_size);
> > +       if (err)
> > +               goto fail;
> > +
> > +       dev_caps->bus_ctrl_count =3D cmd->caps.bus_ctrl_count;
> > +       num_ctrl =3D le16_to_cpu(dev_caps->bus_ctrl_count);
> > +       if (num_ctrl > ARRAY_SIZE(dev_caps->bus_ctrl_types)) {
> > +               err =3D -EINVAL;
> > +               goto fail;
> > +       }
> > +
> > +       for (i =3D 0; i < num_ctrl; i++)
> > +               dev_caps->bus_ctrl_types[i] =3D cmd->caps.bus_ctrl_type=
s[i];
> > +
> > +fail:
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_get_dev_info(struct usb_device *dev,
> > +                                 struct ixxat_dev_info *dev_info)
> > +{
> > +       int err;
> > +       struct ixxat_usb_info_cmd *cmd;
> > +       const u32 cmd_size =3D sizeof(*cmd);
> > +       const u32 req_size =3D sizeof(cmd->req);
> > +       const u32 rcv_size =3D cmd_size - req_size;
> > +       const u32 snd_size =3D req_size + sizeof(cmd->res);
> > +
> > +       cmd =3D kmalloc(cmd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVINFO);
> > +       cmd->res.res_size =3D cpu_to_le32(rcv_size);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd=
, snd_size,
> > +                                &cmd->res, rcv_size);
> > +       if (err)
> > +               goto fail;
> > +
> > +       if (dev_info) {
> > +               memcpy(dev_info->device_id, &cmd->info.device_id,
> > +                      sizeof(cmd->info.device_id));
> > +               memcpy(dev_info->device_name, &cmd->info.device_name,
> > +                      sizeof(cmd->info.device_name));
> > +               dev_info->device_fpga_version =3D cmd->info.device_fpga=
_version;
> > +               dev_info->device_version =3D cmd->info.device_version;
> > +       }
> > +
> > +fail:
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_start_ctrl(struct ixxat_usb_device *dev, u32 *tim=
e_ref)
> > +{
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_start_cmd *cmd;
> > +       const u32 cmd_size =3D sizeof(*cmd);
> > +       const u32 req_size =3D sizeof(cmd->req);
> > +       const u32 rcv_size =3D cmd_size - req_size;
> > +       const u32 snd_size =3D req_size + sizeof(cmd->res);
> > +
> > +       cmd =3D kmalloc(cmd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_START);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->res.res_size =3D cpu_to_le32(rcv_size);
> > +       cmd->time =3D 0;
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       if (err)
> > +               goto fail;
> > +
> > +       if (time_ref)
> > +               *time_ref =3D le32_to_cpu(cmd->time);
> > +
> > +fail:
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_stop_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_stop_cmd *cmd;
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +       const u32 snd_size =3D sizeof(*cmd);
> > +
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(snd_size - rcv_size);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_STOP);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +       cmd->action =3D cpu_to_le32(IXXAT_USB_STOP_ACTION_CLEARALL);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_power_ctrl(struct usb_device *dev, u8 mode)
> > +{
> > +       int err;
> > +       struct ixxat_usb_power_cmd *cmd;
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +       const u32 snd_size =3D sizeof(*cmd);
> > +
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.size =3D cpu_to_le32(snd_size - rcv_size);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_BRD_CMD_POWER);
> > +       cmd->mode =3D mode;
> > +
> > +       err =3D ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd=
, snd_size,
> > +                                &cmd->res, rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_reset_ctrl(struct ixxat_usb_device *dev)
> > +{
> > +       const u16 port =3D dev->ctrl_index;
> > +       int err;
> > +       struct ixxat_usb_dal_cmd *cmd;
> > +       const u32 snd_size =3D sizeof(*cmd);
> > +       const u32 rcv_size =3D sizeof(cmd->res);
> > +
> > +       cmd =3D kmalloc(snd_size, GFP_KERNEL);
> > +       if (!cmd)
> > +               return -ENOMEM;
> > +
> > +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
> > +       cmd->req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_RESET);
> > +       cmd->req.port =3D cpu_to_le16(port);
> > +
> > +       err =3D ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd=
->res,
> > +                                rcv_size);
> > +       kfree(cmd);
> > +       return err;
> > +}
> > +
> > +static void ixxat_usb_stop_queue(struct ixxat_usb_device *dev)
> > +{
> > +       struct net_device *netdev =3D dev->netdev;
> > +       u32 i;
> > +
> > +       netif_stop_queue(netdev);
> > +       usb_kill_anchored_urbs(&dev->rx_submitted);
> > +       usb_kill_anchored_urbs(&dev->tx_submitted);
> > +       atomic_set(&dev->active_tx_urbs, 0);
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               if (dev->tx_contexts[i].echo_index !=3D IXXAT_USB_MAX_T=
X_URBS) {
> > +                       can_free_echo_skb(netdev, i, NULL);
> > +                       dev->tx_contexts[i].echo_index =3D IXXAT_USB_MA=
X_TX_URBS;
> > +               }
> > +       }
> > +}
> > +
> > +static int ixxat_usb_restart(struct ixxat_usb_device *dev)
> > +{
> > +       int err;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       u32 t;
> > +
> > +       ixxat_usb_stop_queue(dev);
> > +       err =3D ixxat_usb_stop_ctrl(dev);
> > +       if (err)
> > +               goto fail;
> > +
> > +       err =3D ixxat_usb_start_ctrl(dev, &t);
> > +       if (err)
> > +               goto fail;
> > +
> > +       dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +       netif_wake_queue(netdev);
> > +
> > +fail:
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_set_mode(struct net_device *netdev, enum can_mode=
 mode)
> > +{
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +
> > +       if (mode !=3D CAN_MODE_START)
> > +               return -EOPNOTSUPP;
> > +
> > +       return ixxat_usb_restart(dev);
> > +}
> > +
> > +static int ixxat_usb_get_berr_counter(const struct net_device *netdev,
> > +                                     struct can_berr_counter *bec)
> > +{
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +
> > +       *bec =3D dev->bec;
> > +       return 0;
> > +}
> > +
> > +static int ixxat_usb_handle_canmsg(struct ixxat_usb_device *dev,
> > +                                  struct ixxat_can_msg *rx)
> > +{
> > +       const u32 ixx_flags =3D le32_to_cpu(rx->base.flags);
> > +       const u8 dlc =3D IXXAT_USB_DECODE_DLC(ixx_flags);
> > +       struct canfd_frame *cf;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct sk_buff *skb;
> > +       u8 flags =3D 0;
> > +       u8 len;
> > +       u8 min_size;
> > +
> > +       if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL) {
> > +               if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_FDR)
> > +                       flags |=3D CANFD_BRS;
> > +
> > +               if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_ESI)
> > +                       flags |=3D CANFD_ESI;
> > +
> > +               len =3D can_fd_dlc2len(dlc);
> > +       } else {
> > +               len =3D can_cc_dlc2len(dlc);
> > +       }
> > +
> > +       min_size =3D sizeof(rx->base) + len;
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               min_size +=3D sizeof(rx->cl1) - sizeof(rx->cl1.data);
> > +       else
> > +               min_size +=3D sizeof(rx->cl2) - sizeof(rx->cl2.data);
> > +
> > +       if (rx->base.size < (min_size - 1)) {
> > +               netdev_err(netdev, "Error: Invalid can data message siz=
e\n");
> > +               return -EBADMSG;
> > +       }
> > +
> > +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_OVR) {
> > +               netdev->stats.rx_over_errors++;
> > +               netdev->stats.rx_errors++;
> > +               netdev_err(netdev, "Error: Message overflow\n");
> > +       }
> > +
> > +       if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL)
> > +               skb =3D alloc_canfd_skb(netdev, &cf);
> > +       else
> > +               skb =3D alloc_can_skb(netdev, (struct can_frame **)&cf);
> > +
> > +       if (!skb)
> > +               return -ENOMEM;
> > +
> > +       cf->can_id =3D le32_to_cpu(rx->base.msg_id);
> > +       cf->len =3D len;
> > +       cf->flags |=3D flags;
> > +
> > +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_EXT)
> > +               cf->can_id |=3D CAN_EFF_FLAG;
> > +
> > +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_RTR) {
> > +               cf->can_id |=3D CAN_RTR_FLAG;
> > +       } else {
> > +               if (dev->adapter =3D=3D &usb2can_cl1)
> > +                       memcpy(cf->data, rx->cl1.data, len);
> > +               else
> > +                       memcpy(cf->data, rx->cl2.data, len);
> > +       }
> > +
> > +       ixxat_usb_get_ts_tv(dev, le32_to_cpu(rx->base.time), &skb->tsta=
mp);
> > +
> > +       netdev->stats.rx_packets++;
> > +       netdev->stats.rx_bytes +=3D cf->len; =20
>=20
> Do not increase the rx_bytes count when receiving a remove frame.

O.k.

>=20
> > +       netif_rx(skb);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ixxat_usb_handle_status(struct ixxat_usb_device *dev,
> > +                                  struct ixxat_can_msg *rx)
> > +{
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct can_frame *can_frame;
> > +       struct sk_buff *skb;
> > +       enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
> > +       u32 raw_status;
> > +       u8 min_size =3D sizeof(rx->base) + sizeof(raw_status);
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               min_size +=3D sizeof(rx->cl1) - sizeof(rx->cl1.data);
> > +       else
> > +               min_size +=3D sizeof(rx->cl2) - sizeof(rx->cl2.data);
> > +
> > +       if (rx->base.size < (min_size - 1)) {
> > +               netdev_err(netdev, "Error: Invalid can status message s=
ize\n");
> > +               return -EBADMSG;
> > +       }
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               raw_status =3D le32_to_cpup((__le32 *)rx->cl1.data);
> > +       else
> > +               raw_status =3D le32_to_cpup((__le32 *)rx->cl2.data); =20
>=20
> Use a union in the declaration of struct ixxat_can_msg_cl1 and struct
> ixxat_can_msg_cl2 and add a:
>=20
>          __le32 status;
>=20
> field in both of those unions.
>=20

O.k.

> > +
> > +       if (raw_status !=3D IXXAT_USB_CAN_STATUS_OK) {
> > +               if (raw_status & IXXAT_USB_CAN_STATUS_BUSOFF) {
> > +                       dev->can.can_stats.bus_off++;
> > +                       new_state =3D CAN_STATE_BUS_OFF;
> > +                       can_bus_off(netdev);
> > +               } else {
> > +                       if (raw_status & IXXAT_USB_CAN_STATUS_ERRLIM) {
> > +                               dev->can.can_stats.error_warning++;
> > +                               new_state =3D CAN_STATE_ERROR_WARNING;
> > +                       }
> > +
> > +                       if (raw_status & IXXAT_USB_CAN_STATUS_ERR_PAS) {
> > +                               dev->can.can_stats.error_passive++;
> > +                               new_state =3D CAN_STATE_ERROR_PASSIVE;
> > +                       }
> > +
> > +                       if (raw_status & IXXAT_USB_CAN_STATUS_OVERRUN)
> > +                               new_state =3D CAN_STATE_MAX;
> > +               }
> > +       }
> > +
> > +       if (new_state =3D=3D CAN_STATE_ERROR_ACTIVE) {
> > +               dev->bec.txerr =3D 0;
> > +               dev->bec.rxerr =3D 0;
> > +       }
> > +
> > +       if (new_state !=3D CAN_STATE_MAX)
> > +               dev->can.state =3D new_state;
> > +
> > +       skb =3D alloc_can_err_skb(netdev, &can_frame);
> > +       if (!skb)
> > +               return -ENOMEM;
> > +
> > +       switch (new_state) {
> > +       case CAN_STATE_ERROR_ACTIVE:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_ACTIVE;
> > +               break;
> > +       case CAN_STATE_ERROR_WARNING:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_TX_WARNING;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_RX_WARNING;
> > +               break;
> > +       case CAN_STATE_ERROR_PASSIVE:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
> > +               break;
> > +       case CAN_STATE_BUS_OFF:
> > +               can_frame->can_id |=3D CAN_ERR_BUSOFF;
> > +               break;
> > +       case CAN_STATE_MAX:
> > +               can_frame->can_id |=3D CAN_ERR_CRTL;
> > +               can_frame->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> > +               break;
> > +       default:
> > +               netdev_err(netdev, "Error: Unhandled can status %d\n",
> > +                          new_state);
> > +               break;
> > +       }
> > +
> > +       netdev->stats.rx_packets++;
> > +       netdev->stats.rx_bytes +=3D can_frame->can_dlc; =20
>=20
> Do not increase the statistics when generating an SocketCAN error frame.

O.k.

>=20
> > +       netif_rx(skb);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ixxat_usb_handle_error(struct ixxat_usb_device *dev,
> > +                                 struct ixxat_can_msg *rx)
> > +{
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct can_frame *can_frame;
> > +       struct sk_buff *skb;
> > +       u8 raw_error;
> > +       u8 min_size =3D sizeof(rx->base) + IXXAT_USB_CAN_ERROR_LEN;
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1)
> > +               min_size +=3D sizeof(rx->cl1) - sizeof(rx->cl1.data);
> > +       else
> > +               min_size +=3D sizeof(rx->cl2) - sizeof(rx->cl2.data);
> > +
> > +       if (rx->base.size < (min_size - 1)) {
> > +               netdev_err(netdev, "Error: Invalid can error message si=
ze\n");
> > +               return -EBADMSG;
> > +       }
> > +
> > +       if (dev->can.state =3D=3D CAN_STATE_BUS_OFF)
> > +               return 0;
> > +
> > +       if (dev->adapter =3D=3D &usb2can_cl1) {
> > +               raw_error =3D rx->cl1.data[IXXAT_USB_CAN_ERROR_CODE];
> > +               dev->bec.rxerr =3D rx->cl1.data[IXXAT_USB_CAN_ERROR_COU=
NTER_RX];
> > +               dev->bec.txerr =3D rx->cl1.data[IXXAT_USB_CAN_ERROR_COU=
NTER_TX];
> > +       } else {
> > +               raw_error =3D rx->cl2.data[IXXAT_USB_CAN_ERROR_CODE];
> > +               dev->bec.rxerr =3D rx->cl2.data[IXXAT_USB_CAN_ERROR_COU=
NTER_RX];
> > +               dev->bec.txerr =3D rx->cl2.data[IXXAT_USB_CAN_ERROR_COU=
NTER_TX];
> > +       }
> > +
> > +       if (raw_error =3D=3D IXXAT_USB_CAN_ERROR_ACK)
> > +               netdev->stats.tx_errors++;
> > +       else
> > +               netdev->stats.rx_errors++;
> > +
> > +       skb =3D alloc_can_err_skb(netdev, &can_frame);
> > +       if (!skb)
> > +               return -ENOMEM;
> > +
> > +       switch (raw_error) {
> > +       case IXXAT_USB_CAN_ERROR_ACK:
> > +               can_frame->can_id |=3D CAN_ERR_ACK;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_BIT:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_BIT;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_CRC:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[3] |=3D CAN_ERR_PROT_LOC_CRC_SEQ;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_FORM:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_FORM;
> > +               break;
> > +       case IXXAT_USB_CAN_ERROR_STUFF:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_STUFF;
> > +               break;
> > +       default:
> > +               can_frame->can_id |=3D CAN_ERR_PROT;
> > +               can_frame->data[2] |=3D CAN_ERR_PROT_UNSPEC;
> > +               break;
> > +       }
> > +
> > +       netdev->stats.rx_packets++;
> > +       netdev->stats.rx_bytes +=3D can_frame->can_dlc; =20
>=20
> Do not increase the statistics when generating an SocketCAN error frame.
>=20

O.k.

> > +       netif_rx(skb);
> > +
> > +       return 0;
> > +}
> > +
> > +static void ixxat_usb_decode_buf(struct urb *urb)
> > +{
> > +       struct ixxat_usb_device *dev =3D urb->context;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct ixxat_can_msg *can_msg;
> > +       int err =3D 0;
> > +       u32 pos =3D 0;
> > +       u8 *data =3D urb->transfer_buffer;
> > +
> > +       while (pos < urb->actual_length) {
> > +               u32 time;
> > +               u8 size;
> > +               u8 type;
> > +
> > +               can_msg =3D (struct ixxat_can_msg *)&data[pos];
> > +               if (!can_msg || !can_msg->base.size) {
> > +                       err =3D -ENOTSUPP;

checkpatch.pl warns about this one:

	WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
	#1045: FILE: drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c:644:
	+			err =3D -ENOTSUPP;

Is EOPNOTSUPP appropriate (or EBADMSG as below)?
=20
> > +                       netdev_err(netdev, "Error %d: Unsupported usb m=
sg\n",
> > +                                  err);
> > +                       break;
> > +               }
> > +
> > +               size =3D can_msg->base.size + 1;
> > +               if (size < sizeof(can_msg->base) ||
> > +                   (pos + size) > urb->actual_length) {
> > +                       err =3D -EBADMSG;
> > +                       netdev_err(netdev,
> > +                                  "Error %d: Invalid usb message size\=
n",
> > +                                  err);
> > +                       break;
> > +               }
> > +
> > +               type =3D le32_to_cpu(can_msg->base.flags);
> > +               type &=3D IXXAT_USB_MSG_FLAGS_TYPE;
> > +               time =3D le32_to_cpu(can_msg->base.time);
> > +
> > +               switch (type) {
> > +               case IXXAT_USB_CAN_DATA:
> > +                       err =3D ixxat_usb_handle_canmsg(dev, can_msg);
> > +                       if (err)
> > +                               goto fail;
> > +                       break;
> > +               case IXXAT_USB_CAN_STATUS:
> > +                       err =3D ixxat_usb_handle_status(dev, can_msg);
> > +                       if (err)
> > +                               goto fail;
> > +                       break;
> > +               case IXXAT_USB_CAN_ERROR:
> > +                       err =3D ixxat_usb_handle_error(dev, can_msg);
> > +                       if (err)
> > +                               goto fail;
> > +                       break;
> > +               case IXXAT_USB_CAN_TIMEOVR:
> > +                       ixxat_usb_get_ts_tv(dev, time, NULL);
> > +                       break;
> > +               case IXXAT_USB_CAN_INFO:
> > +               case IXXAT_USB_CAN_WAKEUP:
> > +               case IXXAT_USB_CAN_TIMERST:
> > +                       break;
> > +               default:
> > +                       netdev_err(netdev,
> > +                                  "Unhandled rec type 0x%02x (%d): ign=
ored\n", =20
>=20
> Do not use parenthesis in log messages.
>=20
> Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#pri=
nting-kernel-messages
>=20
>   Printing numbers in parentheses (%d) adds no value and should be avoide=
d.
>=20
> I do not think you need to print the same value in both hexadecimal
> and decimal. Better to simply remove the decimal one.

O.k.

>=20
> > +                                  type, type);
> > +                       break;
> > +               }
> > +
> > +               pos +=3D size;
> > +       }
> > +
> > +fail:
> > +       if (err)
> > +               netdev_err(netdev, "Error %d: Buffer decoding failed\n"=
, err);
> > +}
> > +
> > +static int ixxat_usb_encode_msg(struct ixxat_usb_device *dev,
> > +                               struct sk_buff *skb, u8 *obuf)
> > +{
> > +       int size;
> > +       struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> > +       struct ixxat_can_msg can_msg =3D { {0} }; =20
>=20
> I think that there was a bug in sparse in the part requiring you to do
> {{ 0 }} initialization when the first member of the structure was
> itself a structure. This being fixed, you can just do:
>=20
>          struct ixxat_can_msg can_msg =3D { 0 };
>=20

O.k.

> > +       struct ixxat_can_msg_base *msg_base =3D &can_msg.base;
> > +       u32 flags =3D 0;
> > +       u32 msg_id =3D 0;
> > +
> > +       if (cf->can_id & CAN_RTR_FLAG)
> > +               flags |=3D IXXAT_USB_MSG_FLAGS_RTR;
> > +
> > +       if (cf->can_id & CAN_EFF_FLAG) {
> > +               flags |=3D IXXAT_USB_MSG_FLAGS_EXT;
> > +               msg_id =3D cf->can_id & CAN_EFF_MASK;
> > +       } else {
> > +               msg_id =3D cf->can_id & CAN_SFF_MASK;
> > +       }
> > +
> > +       if (can_is_canfd_skb(skb)) {
> > +               flags |=3D IXXAT_USB_FDMSG_FLAGS_EDL;
> > +
> > +               if (!(cf->can_id & CAN_RTR_FLAG) && (cf->flags & CANFD_=
BRS))
> > +                       flags |=3D IXXAT_USB_FDMSG_FLAGS_FDR;
> > +
> > +               flags |=3D IXXAT_USB_ENCODE_DLC(can_fd_len2dlc(cf->len)=
);
> > +       } else {
> > +               flags |=3D IXXAT_USB_ENCODE_DLC(cf->len);
> > +       }
> > +
> > +       msg_base->flags =3D cpu_to_le32(flags);
> > +       msg_base->msg_id =3D cpu_to_le32(msg_id);
> > +       msg_base->size =3D sizeof(*msg_base) + cf->len - 1;
> > +       if (dev->adapter =3D=3D &usb2can_cl1) {
> > +               msg_base->size +=3D sizeof(can_msg.cl1);
> > +               msg_base->size -=3D sizeof(can_msg.cl1.data);
> > +               memcpy(can_msg.cl1.data, cf->data, cf->len);
> > +       } else {
> > +               msg_base->size +=3D sizeof(can_msg.cl2);
> > +               msg_base->size -=3D sizeof(can_msg.cl2.data);
> > +               memcpy(can_msg.cl2.data, cf->data, cf->len);
> > +       }
> > +
> > +       size =3D msg_base->size + 1;
> > +       memcpy(obuf, &can_msg, size);
> > +       return size;
> > +}
> > +
> > +static void ixxat_usb_read_bulk_callback(struct urb *urb)
> > +{
> > +       struct ixxat_usb_device *dev =3D urb->context;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct usb_device *udev =3D dev->udev;
> > +       int err;
> > +
> > +       if (!netif_device_present(netdev))
> > +               return;
> > +
> > +       switch (urb->status) {
> > +       case 0: /* success */
> > +               break;
> > +       case -EPROTO:
> > +       case -EILSEQ:
> > +       case -ENOENT:
> > +       case -ECONNRESET:
> > +       case -ESHUTDOWN:
> > +               return;
> > +       default:
> > +               netdev_err(netdev, "Rx urb aborted /(%d)\n", urb->statu=
s); =20
>=20
> Do not use parenthesis in log messages.
>=20
> Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#pri=
nting-kernel-messages
>=20
>   Printing numbers in parentheses (%d) adds no value and should be avoide=
d.
>=20

O.k., seems a common pattern, at least the same logging used in peak_usb,
change it there as well (but seems you answered this in another thread
already '...but bonus points if you send a clean-up patch to fix
the existing log messages...')?

> > +               goto resubmit_urb;
> > +       }
> > +
> > +       if (urb->actual_length > 0)
> > +               if (dev->state & IXXAT_USB_STATE_STARTED)
> > +                       ixxat_usb_decode_buf(urb);
> > +
> > +resubmit_urb:
> > +       usb_fill_bulk_urb(urb, udev, usb_rcvbulkpipe(udev, dev->ep_msg_=
in),
> > +                         urb->transfer_buffer, adapter->buffer_size_rx,
> > +                         ixxat_usb_read_bulk_callback, dev);
> > +
> > +       usb_anchor_urb(urb, &dev->rx_submitted);
> > +       err =3D usb_submit_urb(urb, GFP_ATOMIC);
> > +       if (!err)
> > +               return;
> > +
> > +       usb_unanchor_urb(urb);
> > +
> > +       if (err =3D=3D -ENODEV)
> > +               netif_device_detach(netdev);
> > +       else
> > +               netdev_err(netdev,
> > +                          "Error %d: Failed to resubmit read bulk urb\=
n", err);
> > +}
> > +
> > +static void ixxat_usb_write_bulk_callback(struct urb *urb)
> > +{
> > +       struct ixxat_tx_urb_context *context =3D urb->context;
> > +       struct ixxat_usb_device *dev;
> > +       struct net_device *netdev;
> > +
> > +       if (WARN_ON(!context))
> > +               return;
> > +
> > +       dev =3D context->dev;
> > +       netdev =3D dev->netdev;
> > +
> > +       if (!netif_device_present(netdev))
> > +               return;
> > +
> > +       if (!urb->status) {
> > +               netdev->stats.tx_packets++;
> > +               netdev->stats.tx_bytes +=3D can_get_echo_skb(netdev, co=
ntext->echo_index, NULL);
> > +       } else {
> > +               netdev_err(netdev, "Error %d: Tx urb aborted\n", urb->s=
tatus);
> > +               can_free_echo_skb(netdev, context->echo_index, NULL);
> > +       }
> > +
> > +       context->echo_index =3D IXXAT_USB_MAX_TX_URBS;
> > +       atomic_dec(&dev->active_tx_urbs);
> > +
> > +       if (!urb->status)
> > +               netif_wake_queue(netdev);
> > +}
> > +
> > +static netdev_tx_t ixxat_usb_start_xmit(struct sk_buff *skb,
> > +                                       struct net_device *netdev)
> > +{
> > +       int err;
> > +       int size;
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +       struct ixxat_tx_urb_context *context =3D NULL;
> > +       struct net_device_stats *stats =3D &netdev->stats;
> > +       struct urb *urb;
> > +       u8 *obuf;
> > +       u32 i;
> > +
> > +       if (can_dropped_invalid_skb(netdev, skb))
> > +               return NETDEV_TX_OK;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               if (dev->tx_contexts[i].echo_index =3D=3D IXXAT_USB_MAX=
_TX_URBS) {
> > +                       context =3D dev->tx_contexts + i;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (WARN_ON_ONCE(!context))
> > +               return NETDEV_TX_BUSY;
> > +
> > +       urb =3D context->urb;
> > +       obuf =3D urb->transfer_buffer;
> > +
> > +       size =3D ixxat_usb_encode_msg(dev, skb, obuf);
> > +
> > +       context->echo_index =3D i;
> > +
> > +       urb->transfer_buffer_length =3D size;
> > +       usb_anchor_urb(urb, &dev->tx_submitted);
> > +       can_put_echo_skb(skb, netdev, i, 0);
> > +       atomic_inc(&dev->active_tx_urbs);
> > +
> > +       err =3D usb_submit_urb(urb, GFP_ATOMIC);
> > +       if (err) {
> > +               can_free_echo_skb(netdev, i, NULL);
> > +               usb_unanchor_urb(urb);
> > +               atomic_dec(&dev->active_tx_urbs);
> > +
> > +               context->echo_index =3D IXXAT_USB_MAX_TX_URBS;
> > +
> > +               if (err =3D=3D -ENODEV) {
> > +                       netif_device_detach(netdev);
> > +               } else {
> > +                       stats->tx_dropped++;
> > +                       netdev_err(netdev,
> > +                                  "Error %d: Submitting tx-urb failed\=
n", err);
> > +               }
> > +       } else {
> > +               if (atomic_read(&dev->active_tx_urbs) >=3D IXXAT_USB_MA=
X_TX_URBS)
> > +                       netif_stop_queue(netdev);
> > +       }
> > +
> > +       return NETDEV_TX_OK;
> > +}
> > +
> > +static int ixxat_usb_setup_rx_urbs(struct ixxat_usb_device *dev)
> > +{
> > +       int i;
> > +       int err =3D 0;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct usb_device *udev =3D dev->udev;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_RX_URBS; i++) {
> > +               struct urb *urb;
> > +               u8 *buf;
> > +
> > +               urb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +               if (!urb) {
> > +                       err =3D -ENOMEM;
> > +                       netdev_err(netdev, "Error %d: No memory for URB=
s\n",
> > +                                  err);
> > +                       break;
> > +               }
> > +
> > +               buf =3D kmalloc(adapter->buffer_size_rx, GFP_KERNEL);
> > +               if (!buf) {
> > +                       usb_free_urb(urb);
> > +                       err =3D -ENOMEM;
> > +                       netdev_err(netdev,
> > +                                  "Error %d: No memory for USB-buffer\=
n", err);
> > +                       break;
> > +               }
> > +
> > +               usb_fill_bulk_urb(urb, udev,
> > +                                 usb_rcvbulkpipe(udev, dev->ep_msg_in)=
, buf,
> > +                                 adapter->buffer_size_rx,
> > +                                 ixxat_usb_read_bulk_callback, dev);
> > +
> > +               urb->transfer_flags |=3D URB_FREE_BUFFER;
> > +               usb_anchor_urb(urb, &dev->rx_submitted);
> > +
> > +               err =3D usb_submit_urb(urb, GFP_KERNEL);
> > +               if (err) {
> > +                       usb_unanchor_urb(urb);
> > +                       kfree(buf);
> > +                       usb_free_urb(urb);
> > +
> > +                       if (err =3D=3D -ENODEV)
> > +                               netif_device_detach(netdev);
> > +
> > +                       break;
> > +               }
> > +
> > +               usb_free_urb(urb);
> > +       }
> > +
> > +       if (i =3D=3D 0)
> > +               netdev_err(netdev, "Error: Couldn't setup any rx-URBs\n=
");
> > +
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_setup_tx_urbs(struct ixxat_usb_device *dev)
> > +{
> > +       int i;
> > +       int ret =3D 0;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +       struct net_device *netdev =3D dev->netdev;
> > +       struct usb_device *udev =3D dev->udev;
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               struct ixxat_tx_urb_context *context;
> > +               struct urb *urb;
> > +               u8 *buf;
> > +
> > +               urb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +               if (!urb) {
> > +                       ret =3D -ENOMEM;
> > +                       netdev_err(netdev, "Error %d: No memory for URB=
s\n",
> > +                                  ret);
> > +                       break;
> > +               }
> > +
> > +               buf =3D kmalloc(adapter->buffer_size_tx, GFP_KERNEL);
> > +               if (!buf) {
> > +                       usb_free_urb(urb);
> > +                       ret =3D -ENOMEM;
> > +                       netdev_err(netdev,
> > +                                  "Error %d: No memory for USB-buffer\=
n", ret);
> > +                       break;
> > +               }
> > +
> > +               context =3D dev->tx_contexts + i;
> > +               context->dev =3D dev;
> > +               context->urb =3D urb;
> > +
> > +               usb_fill_bulk_urb(urb, udev,
> > +                                 usb_sndbulkpipe(udev, dev->ep_msg_out=
), buf,
> > +                                 adapter->buffer_size_tx,
> > +                                 ixxat_usb_write_bulk_callback, contex=
t);
> > +
> > +               urb->transfer_flags |=3D URB_FREE_BUFFER;
> > +       }
> > +
> > +       if (i =3D=3D 0) {
> > +               netdev_err(netdev, "Error: Couldn't setup any tx-URBs\n=
");
> > +               usb_kill_anchored_urbs(&dev->rx_submitted);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static void ixxat_usb_disconnect(struct usb_interface *intf)
> > +{
> > +       struct ixxat_usb_device *dev;
> > +       struct ixxat_usb_device *prev_dev;
> > +
> > +       /* unregister the given device and all previous devices */
> > +       for (dev =3D usb_get_intfdata(intf); dev; dev =3D prev_dev) {
> > +               prev_dev =3D dev->prev_dev;
> > +               unregister_netdev(dev->netdev);
> > +               free_candev(dev->netdev);
> > +       }
> > +
> > +       usb_set_intfdata(intf, NULL);
> > +}
> > +
> > +static int ixxat_usb_start(struct ixxat_usb_device *dev)
> > +{
> > +       int err;
> > +       int i;
> > +       u32 time_ref =3D 0;
> > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > +
> > +       err =3D ixxat_usb_setup_rx_urbs(dev);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D ixxat_usb_setup_tx_urbs(dev);
> > +       if (err)
> > +               return err;
> > +
> > +       /* Try to reset the controller, in case it is already initializ=
ed
> > +        * from a previous unclean shutdown
> > +        */
> > +       ixxat_usb_reset_ctrl(dev);
> > +
> > +       if (adapter->init_ctrl) {
> > +               err =3D adapter->init_ctrl(dev);
> > +               if (err)
> > +                       goto fail;
> > +       }
> > +
> > +       if (!(dev->state & IXXAT_USB_STATE_STARTED)) {
> > +               err =3D ixxat_usb_start_ctrl(dev, &time_ref);
> > +               if (err)
> > +                       goto fail;
> > +
> > +               ixxat_usb_set_ts_now(dev, time_ref);
> > +       }
> > +
> > +       dev->bec.txerr =3D 0;
> > +       dev->bec.rxerr =3D 0;
> > +
> > +       dev->state |=3D IXXAT_USB_STATE_STARTED;
> > +       dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +       return 0;
> > +
> > +fail:
> > +       if (err =3D=3D -ENODEV)
> > +               netif_device_detach(dev->netdev);
> > +
> > +       netdev_err(dev->netdev, "Error %d: Couldn't submit control\n", =
err);
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
> > +               usb_free_urb(dev->tx_contexts[i].urb);
> > +               dev->tx_contexts[i].urb =3D NULL;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_open(struct net_device *netdev)
> > +{
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +       int err;
> > +
> > +       /* common open */
> > +       err =3D open_candev(netdev);
> > +       if (err)
> > +               goto fail;
> > +
> > +       /* finally start device */
> > +       err =3D ixxat_usb_start(dev);
> > +       if (err) {
> > +               netdev_err(netdev, "Error %d: Couldn't start device.\n"=
, err);
> > +               close_candev(netdev);
> > +               goto fail;
> > +       }
> > +
> > +       netif_start_queue(netdev);
> > +
> > +fail:
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_stop(struct net_device *netdev)
> > +{
> > +       int err =3D 0;
> > +       struct ixxat_usb_device *dev =3D netdev_priv(netdev);
> > +
> > +       ixxat_usb_stop_queue(dev);f
> > +       if (dev->state & IXXAT_USB_STATE_STARTED) {
> > +               err =3D ixxat_usb_stop_ctrl(dev);
> > +               if (err)
> > +                       netdev_warn(netdev, "Error %d: Cannot stop devi=
ce\n",
> > +                                   err);
> > +       }
> > +
> > +       dev->state &=3D ~IXXAT_USB_STATE_STARTED;
> > +       close_candev(netdev);
> > +       dev->can.state =3D CAN_STATE_STOPPED;
> > +       return err;
> > +}
> > +
> > +static const struct net_device_ops ixxat_usb_netdev_ops =3D {
> > +       .ndo_open =3D ixxat_usb_open,
> > +       .ndo_stop =3D ixxat_usb_stop,
> > +       .ndo_start_xmit =3D ixxat_usb_start_xmit
> > +};
> > +
> > +static const struct ixxat_usb_adapter *ixxat_usb_get_adapter(const u16=
 id)
> > +{
> > +       switch (id) { =20
>=20
> Instead of doing a switch on idProduct, you can use the driver_info
> field from struct usb_device_id to store the device quirks.
>=20
> You can then pass a pointer to your usb2can_cl1, usb2can_cl2 or
> can_idm structures into driver_info. Examples:
>=20
>   https://elixir.bootlin.com/linux/v6.2/source/drivers/net/can/usb/peak_u=
sb/pcan_usb_core.c#L30
>=20

O.k.

> > +       case USB2CAN_COMPACT_PRODUCT_ID:
> > +       case USB2CAN_EMBEDDED_PRODUCT_ID:
> > +       case USB2CAN_PROFESSIONAL_PRODUCT_ID:
> > +       case USB2CAN_AUTOMOTIVE_PRODUCT_ID:
> > +               return &usb2can_cl1;
> > +       case USB2CAN_FD_COMPACT_PRODUCT_ID:
> > +       case USB2CAN_FD_PROFESSIONAL_PRODUCT_ID:
> > +       case USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID:
> > +       case USB2CAN_FD_PCIE_MINI_PRODUCT_ID:
> > +       case USB2CAR_PRODUCT_ID:
> > +               return &usb2can_cl2;
> > +       case CAN_IDM101_PRODUCT_ID:
> > +       case CAN_IDM200_PRODUCT_ID:
> > +               return &can_idm;
> > +       default:
> > +               return NULL;
> > +       }
> > +}
> > +
> > +static int ixxat_usb_create_dev(struct usb_interface *intf,
> > +                               const struct ixxat_usb_adapter *adapter,
> > +                               u16 ctrl_index)
> > +{
> > +       struct usb_device *udev =3D interface_to_usbdev(intf);
> > +       struct ixxat_usb_device *dev;
> > +       struct net_device *netdev;
> > +       int err;
> > +       int i;
> > +
> > +       netdev =3D alloc_candev(sizeof(*dev), IXXAT_USB_MAX_TX_URBS);
> > +       if (!netdev) {
> > +               dev_err(&intf->dev, "Cannot allocate candev\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       dev =3D netdev_priv(netdev);
> > +       dev->udev =3D udev;
> > +       dev->netdev =3D netdev;
> > +       dev->adapter =3D adapter;
> > +       dev->ctrl_index =3D ctrl_index;
> > +       dev->state =3D IXXAT_USB_STATE_CONNECTED;
> > +
> > +       i =3D ctrl_index + adapter->ep_offs;
> > +       dev->ep_msg_in =3D adapter->ep_msg_in[i];
> > +       dev->ep_msg_out =3D adapter->ep_msg_out[i];
> > +
> > +       dev->can.clock.freq =3D adapter->clock;
> > +       dev->can.bittiming_const =3D adapter->bt;
> > +       dev->can.data_bittiming_const =3D adapter->btd;
> > +
> > +       dev->can.do_set_mode =3D ixxat_usb_set_mode;
> > +       dev->can.do_get_berr_counter =3D ixxat_usb_get_berr_counter;
> > +
> > +       dev->can.ctrlmode_supported =3D adapter->modes;
> > +
> > +       netdev->netdev_ops =3D &ixxat_usb_netdev_ops; =20
>=20
> Can you also populate ndev->ethtool_ops with the default timestamp info? =
c.f.
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D409c188c57cd
>=20

O.k.

> > +       netdev->flags |=3D IFF_ECHO; =20
>=20
> ctrl_index indicates the channer number, right? If so, add:
>=20
>           netdev->dev_port =3D ctrl_index
>=20
> Ref:
>=20
>   https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-net
>=20

O.k.

>=20
> > +       init_usb_anchor(&dev->rx_submitted);
> > +       init_usb_anchor(&dev->tx_submitted);
> > +
> > +       atomic_set(&dev->active_tx_urbs, 0);
> > +
> > +       for (i =3D 0; i < IXXAT_USB_MAX_TX_URBS; i++)
> > +               dev->tx_contexts[i].echo_index =3D IXXAT_USB_MAX_TX_URB=
S;
> > +
> > +       dev->prev_dev =3D usb_get_intfdata(intf);
> > +       usb_set_intfdata(intf, dev);
> > +
> > +       SET_NETDEV_DEV(netdev, &intf->dev);
> > +       err =3D register_candev(netdev);
> > +       if (err) {
> > +               dev_err(&intf->dev, "Error %d: Failed to register can d=
evice\n",
> > +                       err);
> > +               goto free_candev;
> > +       }
> > +
> > +       if (dev->prev_dev)
> > +               (dev->prev_dev)->next_dev =3D dev;
> > +
> > +       err =3D ixxat_usb_get_dev_info(udev, &dev->dev_info);
> > +       if (err) {
> > +               dev_err(&intf->dev,
> > +                       "Error %d: Failed to get device information\n",=
 err);
> > +               goto unreg_candev;
> > +       }
> > +
> > +       netdev_info(netdev, "%s: Connected Channel %u (device %s)\n",
> > +                   dev->dev_info.device_name, ctrl_index,
> > +                   dev->dev_info.device_id);
> > +
> > +       return 0;
> > +
> > +unreg_candev:
> > +       unregister_candev(netdev);
> > +free_candev:
> > +       usb_set_intfdata(intf, dev->prev_dev);
> > +       free_candev(netdev);
> > +       return err;
> > +}
> > +
> > +static int ixxat_usb_probe(struct usb_interface *intf,
> > +                          const struct usb_device_id *id)
> > +{
> > +       struct usb_device *udev =3D interface_to_usbdev(intf);
> > +       struct usb_host_interface *host_intf =3D intf->altsetting;
> > +       const struct ixxat_usb_adapter *adapter;
> > +       struct ixxat_dev_caps dev_caps;
> > +       u16 i;
> > +       int err;
> > +
> > +       usb_reset_configuration(udev);
> > +
> > +       adapter =3D ixxat_usb_get_adapter(id->idProduct);
> > +       if (!adapter) {
> > +               dev_err(&intf->dev, "%s: Unknown device id %d\n",
> > +                       IXXAT_USB_DRIVER_NAME, id->idProduct);
> > +               return -ENODEV;
> > +       }
> > +
> > +       for (i =3D 0; i < host_intf->desc.bNumEndpoints; i++) {
> > +               const u8 epaddr =3D host_intf->endpoint[i].desc.bEndpoi=
ntAddress;
> > +               int match;
> > +               u8 j;
> > +
> > +               /* Check if usb-endpoint address matches known usb-endp=
oints */
> > +               for (j =3D 0; j < IXXAT_USB_MAX_CHANNEL; j++) {
> > +                       u8 ep_msg_in =3D adapter->ep_msg_in[j];
> > +                       u8 ep_msg_out =3D adapter->ep_msg_in[j];
> > +
> > +                       if (epaddr =3D=3D ep_msg_in || epaddr =3D=3D ep=
_msg_out) {
> > +                               match =3D 1;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (!match)
> > +                       return -ENODEV;
> > +       }
> > +
> > +       err =3D ixxat_usb_power_ctrl(udev, IXXAT_USB_POWER_WAKEUP);
> > +       if (err)
> > +               return err;
> > +
> > +       msleep(IXXAT_USB_POWER_WAKEUP_TIME);
> > +
> > +       err =3D ixxat_usb_get_dev_caps(udev, &dev_caps);
> > +       if (err) {
> > +               dev_err(&intf->dev,
> > +                       "Error %d: Failed to get device capabilities\n"=
, err);
> > +               return err;
> > +       }
> > +
> > +       err =3D -ENODEV;
> > +       for (i =3D 0; i < le16_to_cpu(dev_caps.bus_ctrl_count); i++) {
> > +               u16 dev_bustype =3D le16_to_cpu(dev_caps.bus_ctrl_types=
[i]);
> > +               u8 bustype =3D IXXAT_USB_BUS_TYPE(dev_bustype);
> > +
> > +               if (bustype =3D=3D IXXAT_USB_BUS_CAN)
> > +                       err =3D ixxat_usb_create_dev(intf, adapter, i);
> > +
> > +               if (err) {
> > +                       /* deregister already created devices */
> > +                       ixxat_usb_disconnect(intf);
> > +                       return err;
> > +               }
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +static struct usb_driver ixxat_usb_driver =3D {
> > +       .name =3D IXXAT_USB_DRIVER_NAME,
> > +       .probe =3D ixxat_usb_probe,
> > +       .disconnect =3D ixxat_usb_disconnect,
> > +       .id_table =3D ixxat_usb_table,
> > +};
> > +
> > +module_usb_driver(ixxat_usb_driver);
> > diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/n=
et/can/usb/ixxat_usb/ixxat_usb_core.h
> > new file mode 100644
> > index 000000000000..0f3e4c0b9f1b
> > --- /dev/null
> > +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
> > @@ -0,0 +1,519 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/* CAN driver base for IXXAT USB-to-CAN
> > + *
> > + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.=
de>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published
> > + * by the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + */
> > +
> > +#ifndef IXXAT_USB_CORE_H
> > +#define IXXAT_USB_CORE_H
> > +
> > +#define IXXAT_USB_DRIVER_NAME "ixxat_usb2can"
> > +#define IXXAT_USB_CTRL_NAME "ixxat_usb"
> > +
> > +#define IXXAT_USB_VENDOR_ID 0x08d8
> > +
> > +/* supported device ids: CL1 */
> > +#define USB2CAN_COMPACT_PRODUCT_ID 0x0008
> > +#define USB2CAN_EMBEDDED_PRODUCT_ID 0x0009
> > +#define USB2CAN_PROFESSIONAL_PRODUCT_ID 0x000A
> > +#define USB2CAN_AUTOMOTIVE_PRODUCT_ID 0x000B
> > +
> > +/* supported device ids: CL2 */
> > +#define USB2CAN_FD_COMPACT_PRODUCT_ID 0x0014
> > +#define USB2CAN_FD_PROFESSIONAL_PRODUCT_ID 0x0016
> > +#define USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID 0x0017
> > +#define USB2CAN_FD_PCIE_MINI_PRODUCT_ID 0x001B
> > +#define USB2CAR_PRODUCT_ID 0x001C
> > +#define CAN_IDM101_PRODUCT_ID 0xFF12
> > +#define CAN_IDM200_PRODUCT_ID 0xFF13
> > +
> > +#define IXXAT_USB_BUS_CAN 1
> > +
> > +#define IXXAT_USB_BUS_TYPE(type) ((u8)(((type) >> 8) & 0x00FF))
> > +
> > +#define IXXAT_USB_STATE_CONNECTED BIT(0)
> > +#define IXXAT_USB_STATE_STARTED BIT(1)
> > +
> > +#define IXXAT_USB_MAX_CHANNEL 5
> > +#define IXXAT_USB_MAX_TYPES 32
> > +#define IXXAT_USB_MAX_RX_URBS 4
> > +#define IXXAT_USB_MAX_TX_URBS 10
> > +#define IXXAT_USB_MAX_COM_REQ 10
> > +
> > +#define IXXAT_USB_MSG_TIMEOUT 50
> > +#define IXXAT_USB_MSG_CYCLE 20
> > +
> > +#define IXXAT_USB_POWER_WAKEUP 0
> > +#define IXXAT_USB_POWER_WAKEUP_TIME 500
> > +
> > +#define IXXAT_USB_OPMODE_STANDARD BIT(0)
> > +#define IXXAT_USB_OPMODE_EXTENDED BIT(1)
> > +#define IXXAT_USB_OPMODE_ERRFRAME BIT(2)
> > +#define IXXAT_USB_OPMODE_LISTONLY BIT(3)
> > +
> > +#define IXXAT_USB_EXMODE_EXTDATA BIT(0)
> > +#define IXXAT_USB_EXMODE_FASTDATA BIT(1)
> > +#define IXXAT_USB_EXMODE_ISOFD BIT(2)
> > +
> > +#define IXXAT_USB_BTMODE_NAT BIT(0)
> > +#define IXXAT_USB_BTMODE_TSM BIT(1)
> > +
> > +#define IXXAT_USB_STOP_ACTION_CLEARALL 3
> > +
> > +#define IXXAT_RESTART_TASK_CYCLE_TIME 20
> > +
> > +#define IXXAT_USB_CAN_DATA 0x00
> > +#define IXXAT_USB_CAN_INFO 0x01
> > +#define IXXAT_USB_CAN_ERROR 0x02
> > +#define IXXAT_USB_CAN_STATUS 0x03
> > +#define IXXAT_USB_CAN_WAKEUP 0x04
> > +#define IXXAT_USB_CAN_TIMEOVR 0x05
> > +#define IXXAT_USB_CAN_TIMERST 0x06
> > +
> > +#define IXXAT_USB_CAN_STATUS_OK 0x00000000
> > +#define IXXAT_USB_CAN_STATUS_OVERRUN 0x00000002
> > +#define IXXAT_USB_CAN_STATUS_ERRLIM 0x00000004
> > +#define IXXAT_USB_CAN_STATUS_BUSOFF 0x00000008
> > +#define IXXAT_USB_CAN_STATUS_ERR_PAS 0x00002000
> > +
> > +#define IXXAT_USB_CAN_ERROR_LEN 5
> > +
> > +#define IXXAT_USB_CAN_ERROR_CODE 0
> > +#define IXXAT_USB_CAN_ERROR_COUNTER_RX 3
> > +#define IXXAT_USB_CAN_ERROR_COUNTER_TX 4
> > +
> > +#define IXXAT_USB_CAN_ERROR_STUFF 1
> > +#define IXXAT_USB_CAN_ERROR_FORM 2
> > +#define IXXAT_USB_CAN_ERROR_ACK 3
> > +#define IXXAT_USB_CAN_ERROR_BIT 4
> > +#define IXXAT_USB_CAN_ERROR_CRC 6
> > +
> > +#define IXXAT_USB_MSG_FLAGS_TYPE 0x000000FF
> > +#define IXXAT_USB_MSG_FLAGS_DLC 0x000F0000
> > +#define IXXAT_USB_MSG_FLAGS_OVR 0x00100000
> > +#define IXXAT_USB_MSG_FLAGS_RTR 0x00400000
> > +#define IXXAT_USB_MSG_FLAGS_EXT 0x00800000
> > +
> > +#define IXXAT_USB_DECODE_DLC(flags) (((flags) & IXXAT_USB_MSG_FLAGS_DL=
C) >> 16)
> > +#define IXXAT_USB_ENCODE_DLC(len) (((len) << 16) & IXXAT_USB_MSG_FLAGS=
_DLC) =20
>=20
> Remove those two #define. Instead, use FIELD_GET() and FIELD_PREP()
> directly in the code.
>=20

O.k.

> > +#define IXXAT_USB_FDMSG_FLAGS_EDL 0x00000400
> > +#define IXXAT_USB_FDMSG_FLAGS_FDR 0x00000800
> > +#define IXXAT_USB_FDMSG_FLAGS_ESI 0x00001000
> > +
> > +#define IXXAT_USB_CAN_CMD_START 0x326
> > +#define IXXAT_USB_CAN_CMD_STOP 0x327
> > +#define IXXAT_USB_CAN_CMD_RESET 0x328
> > +
> > +#define IXXAT_USB_BRD_CMD_GET_DEVCAPS 0x401
> > +#define IXXAT_USB_BRD_CMD_GET_DEVINFO 0x402
> > +#define IXXAT_USB_BRD_CMD_POWER 0x421
> > +
> > +/**
> > + * struct ixxat_can_msg_base - IXXAT CAN message base (CL1/CL2)
> > + * @size: Message size (this field excluded)
> > + * @time: Message timestamp
> > + * @msg_id: Message ID
> > + * @flags: Message flags
> > + *
> > + * Contains the common fields of an IXXAT CAN message on both CL1 and =
CL2
> > + * devices
> > + */
> > +struct ixxat_can_msg_base {
> > +       u8 size;
> > +       __le32 time;
> > +       __le32 msg_id;
> > +       __le32 flags;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_can_msg_cl1 - IXXAT CAN message (CL1)
> > + * @data: Message data (standard CAN frame)
> > + *
> > + * Contains the fields of an IXXAT CAN message on CL1 devices
> > + */
> > +struct ixxat_can_msg_cl1 {
> > +       u8 data[CAN_MAX_DLEN];
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_can_msg_cl2 - IXXAT CAN message (CL2)
> > + * @client_id: Client ID
> > + * @data: Message data (CAN FD frame)
> > + *
> > + * Contains the fields of an IXXAT CAN message on CL2 devices
> > + */
> > +struct ixxat_can_msg_cl2 {
> > +       __le32 client_id;
> > +       u8 data[CANFD_MAX_DLEN];
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_can_msg - IXXAT CAN message
> > + * @base: Base message
> > + * @cl1: Cl1 message
> > + * @cl2: Cl2 message
> > + *
> > + * Contains an IXXAT CAN message
> > + */
> > +struct ixxat_can_msg {
> > +       struct ixxat_can_msg_base base;
> > +       union {
> > +               struct ixxat_can_msg_cl1 cl1;
> > +               struct ixxat_can_msg_cl2 cl2;
> > +       };
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_dev_caps - Device capabilities
> > + * @bus_ctrl_count: Stores the bus controller counter
> > + * @bus_ctrl_types: Stores the bus controller types
> > + *
> > + * Contains the device capabilities
> > + */
> > +struct ixxat_dev_caps {
> > +       __le16 bus_ctrl_count;
> > +       __le16 bus_ctrl_types[IXXAT_USB_MAX_TYPES];
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_canbtp Bittiming parameters (CL2)
> > + * @mode: Operation mode
> > + * @bps: Bits per second
> > + * @ts1: First time segment
> > + * @ts2: Second time segment
> > + * @sjw: Synchronization jump width
> > + * @tdo: Transmitter delay offset
> > + *
> > + * Bittiming parameters of a CL2 initialization request
> > + */
> > +struct ixxat_canbtp {
> > +       __le32 mode;
> > +       __le32 bps;
> > +       __le16 ts1;
> > +       __le16 ts2;
> > +       __le16 sjw;
> > +       __le16 tdo; =20
>=20
> It seems that your device supports TDC. What is the reason to not configu=
re it?
>=20
> Please have a look at struct can_tdc:
>=20
>   https://elixir.bootlin.com/linux/v6.2/source/include/linux/can/bittimin=
g.h#L21
>=20
> Please refer to this patch if you want an example of how to use TDC:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D1010a8fa9608
>=20

Not sure about this one (and I have limited knowledge of the hardware detai=
ls),
seems I need to find more (spare) time to look into this one, or maybe
something better for an follow-up patch?

Regards,
Peter

> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_dev_info IXXAT usb device information
> > + * @device_name: Name of the device
> > + * @device_id: Device identification ( unique device id)
> > + * @device_version: Device version ( 0, 1, ...)
> > + * @device_fpga_version: Version of FPGA design
> > + *
> > + * Contains device information of IXXAT USB devices
> > + */
> > +struct ixxat_dev_info {
> > +       char device_name[16];
> > +       char device_id[16];
> > +       __le16 device_version;
> > +       __le32 device_fpga_version;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_time_ref Time reference
> > + * @kt_host_0: Latest time on the host
> > + * @ts_dev_0: Latest time stamp on the device
> > + * @ts_dev_last: Last device time stamp
> > + *
> > + * Contains time references of the device and the host
> > + */
> > +struct ixxat_time_ref {
> > +       ktime_t kt_host_0;
> > +       u32 ts_dev_0;
> > +       u32 ts_dev_last;
> > +};
> > +
> > +/**
> > + * struct ixxat_tx_urb_context URB content for transmission
> > + * @dev: IXXAT USB device
> > + * @urb: USB request block
> > + * @echo_index: Echo index
> > + * @dlc: Data length code
> > + * @count: Counter
> > + *
> > + * Contains content for USB request block transmissions
> > + */
> > +struct ixxat_tx_urb_context {
> > +       struct ixxat_usb_device *dev;
> > +       struct urb *urb;
> > +       u32 echo_index;
> > +};
> > +
> > +/**
> > + * struct ixxat_usb_device IXXAT USB device
> > + * @can: CAN common private data
> > + * @adapter: USB network descriptor
> > + * @udev: USB device
> > + * @netdev: Net_device
> > + * @active_tx_urbs: Active tx urbs
> > + * @tx_submitted: Submitted tx usb anchor
> > + * @tx_contexts: Buffer for tx contexts
> > + * @rx_submitted: Submitted rx usb anchor
> > + * @state: Device state
> > + * @ctrl_index: Controller index
> > + * @ep_msg_in: USB endpoint for incoming messages
> > + * @ep_msg_out: USB endpoint for outgoing messages
> > + * @prev_dev: Previous opened device
> > + * @next_dev: Next opened device in list
> > + * @time_ref: Time reference
> > + * @dev_info: Device information
> > + * @bec: CAN error counter
> > + *
> > + * IXXAT USB-to-CAN device
> > + */
> > +struct ixxat_usb_device {
> > +       struct can_priv can;
> > +       const struct ixxat_usb_adapter *adapter;
> > +       struct usb_device *udev;
> > +       struct net_device *netdev;
> > +
> > +       atomic_t active_tx_urbs;
> > +       struct usb_anchor tx_submitted;
> > +       struct ixxat_tx_urb_context tx_contexts[IXXAT_USB_MAX_TX_URBS];
> > +       struct usb_anchor rx_submitted;
> > +
> > +       u32 state;
> > +       u16 ctrl_index;
> > +
> > +       u8 ep_msg_in;
> > +       u8 ep_msg_out;
> > +
> > +       struct ixxat_usb_device *prev_dev;
> > +       struct ixxat_usb_device *next_dev;
> > +
> > +       struct ixxat_time_ref time_ref;
> > +       struct ixxat_dev_info dev_info;
> > +
> > +       struct can_berr_counter bec;
> > +};
> > +
> > +/**
> > + * struct ixxat_usb_dal_req IXXAT device request block
> > + * @size: Request size
> > + * @port: Request port
> > + * @socket: Request socket
> > + * @code: Request code
> > + *
> > + * IXXAT device request block
> > + */
> > +struct ixxat_usb_dal_req {
> > +       __le32 size;
> > +       __le16 port;
> > +       __le16 socket;
> > +       __le32 code;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_dal_res IXXAT device response block
> > + * @res_size: Expected response size
> > + * @ret_size: Actual response size
> > + * @code: Return code
> > + *
> > + * IXXAT device response block
> > + */
> > +struct ixxat_usb_dal_res {
> > +       __le32 res_size;
> > +       __le32 ret_size;
> > +       __le32 code;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_dal_cmd IXXAT device command
> > + * @req: Request block
> > + * @req: Response block
> > + *
> > + * IXXAT device command
> > + */
> > +struct ixxat_usb_dal_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_caps_cmd Device capabilities command
> > + * @req: Request block
> > + * @res: Response block
> > + * @caps: Device capabilities
> > + *
> > + * Can be sent to a device to request its capabilities
> > + */
> > +struct ixxat_usb_caps_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +       struct ixxat_dev_caps caps;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_init_cl1_cmd Initialization command (CL1)
> > + * @req: Request block
> > + * @mode: Operation mode
> > + * @btr0: Bittiming register 0
> > + * @btr1: Bittiming register 1
> > + * @padding: 1 byte padding
> > + * @res: Response block
> > + *
> > + * Can be sent to a CL1 device to initialize it
> > + */
> > +struct ixxat_usb_init_cl1_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       u8 mode;
> > +       u8 btr0;
> > +       u8 btr1;
> > +       u8 padding;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_init_cl2_cmd Initialization command (CL2)
> > + * @req: Request block
> > + * @opmode: Operation mode
> > + * @exmode: Extended mode
> > + * @sdr: Stadard bittiming parameters
> > + * @fdr: Fast data bittiming parameters
> > + * @_padding: 2 bytes padding
> > + * @res: Response block
> > + *
> > + * Can be sent to a CL2 device to initialize it
> > + */
> > +struct ixxat_usb_init_cl2_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       u8 opmode;
> > +       u8 exmode;
> > +       struct ixxat_canbtp sdr;
> > +       struct ixxat_canbtp fdr;
> > +       __le16 _padding;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_start_cmd Controller start command
> > + * @req: Request block
> > + * @res: Response block
> > + * @time: Timestamp
> > + *
> > + * Can be sent to a device to start its controller
> > + */
> > +struct ixxat_usb_start_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +       __le32 time;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_stop_cmd Controller stop command
> > + * @req: Request block
> > + * @action: Stop action
> > + * @res: Response block
> > + *
> > + * Can be sent to a device to start its controller
> > + */
> > +struct ixxat_usb_stop_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       __le32 action;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_power_cmd Power command
> > + * @req: Request block
> > + * @mode: Power mode
> > + * @_padding1: 1 byte padding
> > + * @_padding2: 2 byte padding
> > + * @res: Response block
> > + *
> > + * Can be sent to a device to set its power mode
> > + */
> > +struct ixxat_usb_power_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       u8 mode;
> > +       u8 _padding1;
> > +       __le16 _padding2;
> > +       struct ixxat_usb_dal_res res;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_info_cmd Device information command
> > + * @req: Request block
> > + * @res: Response block
> > + * @info: Device information
> > + *
> > + * Can be sent to a device to request its device information
> > + */
> > +struct ixxat_usb_info_cmd {
> > +       struct ixxat_usb_dal_req req;
> > +       struct ixxat_usb_dal_res res;
> > +       struct ixxat_dev_info info;
> > +} __packed;
> > +
> > +/**
> > + * struct ixxat_usb_adapter IXXAT USB device adapter
> > + * @clock: Clock frequency
> > + * @bt: Bittiming constants
> > + * @btd: Data bittiming constants
> > + * @modes: Supported modes
> > + * @buffer_size_rx: Buffer size for receiving
> > + * @buffer_size_tx: Buffer size for transfer
> > + * @ep_msg_in: USB endpoint buffer for incoming messages
> > + * @ep_msg_out: USB endpoint buffer for outgoing messages
> > + * @ep_offs: Endpoint offset (device depended)
> > + *
> > + * Device Adapter for IXXAT USB devices
> > + */
> > +struct ixxat_usb_adapter {
> > +       const u32 clock;
> > +       const struct can_bittiming_const *bt;
> > +       const struct can_bittiming_const *btd;
> > +       const u32 modes;
> > +       const u16 buffer_size_rx;
> > +       const u16 buffer_size_tx;
> > +       const u8 ep_msg_in[IXXAT_USB_MAX_CHANNEL];
> > +       const u8 ep_msg_out[IXXAT_USB_MAX_CHANNEL];
> > +       const u8 ep_offs;
> > +       int (*init_ctrl)(struct ixxat_usb_device *dev);
> > +};
> > +
> > +extern const struct ixxat_usb_adapter usb2can_cl1;
> > +extern const struct ixxat_usb_adapter usb2can_cl2;
> > +extern const struct ixxat_usb_adapter can_idm;
> > +
> > +/**
> > + * ixxat_usb_setup_cmd() - Setup a device command
> > + * @req: Request block
> > + * @res: Response block
> > + *
> > + * This function sets the default values in the request and the respon=
se block
> > + * of a device command
> > + */
> > +void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
> > +                        struct ixxat_usb_dal_res *res);
> > +
> > +/**
> > + * ixxat_usb_send_cmd() - Send a command to the device
> > + * @dev: USB device
> > + * @port: Command port
> > + * @req: Command request buffer
> > + * @req_size: Command request size
> > + * @res: Command response buffer
> > + * @res_size: Command response size
> > + *
> > + * This function sends a specific command to the device
> > + *
> > + * Return: Negative error code or zero on success
> > + */
> > +int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *r=
eq,
> > +                      const u16 req_size, void *res, const u16 res_siz=
e);
> > +
> > +#endif /* IXXAT_USB_CORE_H */
> > --
> > 2.39.2
> >
> > =20

