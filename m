Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200FE30446E
	for <lists+linux-can@lfdr.de>; Tue, 26 Jan 2021 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbhAZGBY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jan 2021 01:01:24 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:38342 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbhAYNHj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jan 2021 08:07:39 -0500
Received: by mail-yb1-f173.google.com with SMTP id r32so13244242ybd.5
        for <linux-can@vger.kernel.org>; Mon, 25 Jan 2021 05:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clorWl7c0epQ9aWZUlZai3La/HxSIj4whmhXYs51RUQ=;
        b=LaBGjTSGEmssDG+Pij5JKuFICUFUGjxi/FAZk8Qd8BC/l7TY8a0WiS7prKnL6XmETo
         aP621JjsNSQ5nDDHCDcjgcoQjccCDnUR5krBR+OPmAh+5+nvRyReKS5r2hcVLWIcHnvp
         x+YT6sHZwCXLSePkGd3ipxGJFAabEiohhy3mhW+4qXMflJ84KepUOm+ue3uZNl12+Mur
         9DAhjBiNc1vc86UbjxFkaQUab4p2Grng4VCi/gYfmU/roxfkgER+H4kQZuo0hIifVYna
         VWPjOiXXWY1siULYesZKJ6odP7yBh/BjT3Ec1YaspOjhmgCaM8gmS4jf4ZNw/6Stw1DW
         gMew==
X-Gm-Message-State: AOAM53237UsfbuWZYs1aJvgYUNNtwRVx1/1EoL6Ph3jOFqQFm/3PMCkT
        9vzTo9UGUiQ+ksVJWYNKibqv+CKNeePbTtiFd8difoEyzRAIsw==
X-Google-Smtp-Source: ABdhPJwrQUVOKGcDl2LuptKm9HlJkkQaBvBLnlHP8Wtvm3EUq5o8KaS3ysf2FlJPd+x6aH3neO2eyBo1ZhMxh/u/T8c=
X-Received: by 2002:a25:38e:: with SMTP id 136mr596225ybd.226.1611579959739;
 Mon, 25 Jan 2021 05:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20210122110533.2728-1-abhijeet.badurkar@duagon.com>
 <CAMZ6Rq+MPpknpxwKv0-eV8J3FbKw7AigWrzbMC1HJgEUv8f56A@mail.gmail.com>
 <0673cb4c-f6ce-027c-8028-62161ca47f9c@duagon.com> <CAMZ6RqLLU2BC1m_F8Dfi9_n_AoQ6CgfOgtY3xwTscdLvJN4+Ag@mail.gmail.com>
 <b50ee651-880a-9093-9c79-d6f398fe4280@pengutronix.de>
In-Reply-To: <b50ee651-880a-9093-9c79-d6f398fe4280@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 25 Jan 2021 22:05:48 +0900
Message-ID: <CAMZ6RqJT+tnYuX9ymaQ-vWeBJPUZ+FfPxN358819mK7WHKCRRg@mail.gmail.com>
Subject: Re: [PATCH v6] net: can: Introduce MEN 16Z192-00 CAN controller driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Abhijeet Badurkar <abhijeet.badurkar@duagon.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can <linux-can@vger.kernel.org>,
        andreas.geissler@duagon.com, stefan.schlosser@duagon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 25 Jan 2021 at 20:43, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 1/25/21 12:01 PM, Vincent MAILHOL wrote:
> >>>> +/* CTL/BTR Register Bits */
> >>>> +#define MEN_Z192_CTL0_INITRQ           BIT(0)
> >>>> +#define MEN_Z192_CTL0_SLPRQ            BIT(1)
> >>>> +#define MEN_Z192_CTL1_INITAK           BIT(8)
> >>>> +#define MEN_Z192_CTL1_SLPAK            BIT(9)
> >>>> +#define MEN_Z192_CTL1_LISTEN           BIT(12)
> >>>> +#define MEN_Z192_CTL1_LOOPB            BIT(13)
> >>>> +#define MEN_Z192_CTL1_CANE             BIT(15)
> >>>> +#define MEN_Z192_BTR0_BRP              GENMASK(21, 16)
> >>>> +#define MEN_Z192_BTR0_SJW              GENMASK(23, 22)
> >>>> +#define MEN_Z192_BTR1_TSEG1            GENMASK(27, 24)
> >>>> +#define MEN_Z192_BTR1_TSEG2            GENMASK(30, 28)
> >>>> +#define MEN_Z192_BTR1_SAMP             BIT(31)
> >>>
> >>> Please use only one space between the #define and the value.
> >> I had tried that before, but that makes the code difficult to read. The other drivers in mainline have also used more than one space.
> >
> > When I sent my first patch, I received the same comment asking me
> > to remove extra spaces. I am not here to argue which one is the
> > most readable. I just recommend you to do as such because it is
> > the prefered style here.
>
> IMHO one space only pays out, once you add something to the driver, which
> doesn't fit into the current indention level.
>
> [...]
>
> >>>> +struct men_z192_cf_buf {
> >>>> +       u32 can_id;
> >>>> +       u32 data[2];
> >>>
> >>> Is it possible to make it u8 data[CAN_MAX_DLEN]?
> >> The core has two 32-bit registers for data, therefore array of two 32-bit
> >> elements has been used.
> >
> > First thing, u32 is wrong, it should be either __le32 or __be32
> > to make your code portable.
>
> You should describe the memory/packet/etc... layout of the hardware here, so if
> it's organized in 32 bit values, use them here.
>
> If you have to use __le32, __be32 or u32 depends on how the HW is connected to
> your linux box. If it's USB you have to use the le or be variants.
>
> For memory mapped IO with readl/writel and friend, according to:
>
> > https://elixir.bootlin.com/linux/latest/source/include/asm-generic/io.h#L141
>
> {read,write}{b,w,l,q}() access little endian memory and return result in native
> endianness.

ACK. I missed that point. Now the u32[] type makes sense.

> > The data field of struct can_frame is an array of bytes. You have
> > to make a choice which is either casting cf->data to
> > __be32[] (what you did) or make your data field a u8[].
> >
> > If I am correct, u8[] and __be32[] has the same memory
> > layout. Thus I think it is more readable to declare it your data
> > field as a u8[] despite how it is declared on the
> > controller (and you can add a comment to reflect that).
>
> See above, that should describe your controller.

ACK

> [...]
>
> >>>> +static int men_z192_xmit(struct sk_buff *skb, struct net_device *ndev)
> >>>> +{
> >>>> +       struct can_frame *cf = (struct can_frame *)skb->data;
> >>>> +       struct men_z192 *priv = netdev_priv(ndev);
> >>>> +       struct men_z192_regs __iomem *regs = priv->regs;
> >>>> +       struct men_z192_cf_buf __iomem *cf_buf;
> >>>> +       int status;
> >>>> +       u32 id;
> >>>> +       u16 id_11_bits;
> >>>> +       u32 id_18_bits;
> >>>> +
> >>>> +       if (can_dropped_invalid_skb(ndev, skb))
> >>>> +               return NETDEV_TX_OK;
> >>>> +
> >>>> +       status = readl(&regs->rx_tx_sts);
> >>>> +
> >>>> +       if (FIELD_GET(MEN_Z192_TX_BUF_CNT, status) == MEN_Z192_MAX_BUF_LVL) {
> >>>> +               netif_stop_queue(ndev);
> >>>> +               netdev_err(ndev, "not enough space in TX buffer\n");
> >>>> +
> >>>> +               return NETDEV_TX_BUSY;
> >>>> +       }
> >>>
> >>> Could you stop the queue in advance to prevent returning NETDEV_TX_BUSY?
> >> sorry, didn'get you. You mean before checking buffer count for max level? The queue is to be stopped when there are no transmission buffers left in the hardawre, right?
> >> And since now buffer is full, means NETDEV_TX_BUSY?
> >
> > Please refer to: https://www.kernel.org/doc/html/latest//networking/driver.html
>
> In short:
> Once your TX-buffer is full, call netif_stop_queue(). This stops the stack to
> call your xmit function. Onc you've successfully send a CAN frame, call
> netif_start_queue().
>
> Have a look at the mcp251xfd driver, how to implement that race-free. You can
> check if xmit is called with full buffer as a safety net and reutrn TX_BUSY, but
> if that happens your driver is racy.
>
> >>>> +
> >>>> +       cf_buf = priv->dev_base + MEN_Z192_TX_BUF_START;
> >>>> +
> >>>> +       if (cf->can_id & CAN_EFF_FLAG) {
> >>>> +               /* Extended frame */
> >>>> +               id = cf->can_id & CAN_EFF_MASK;
> >>>> +               id_11_bits = FIELD_GET(MEN_Z192_CAN_ID_11_BITS, id);
> >>>> +               id_18_bits = FIELD_GET(MEN_Z192_CAN_ID_18_BITS, id);
> >>>> +
> >>>> +               id = FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, id_11_bits) |
> >>>> +                    MEN_Z192_CFBUF_SRR |
> >>>> +                    MEN_Z192_CFBUF_IDE |
> >>>> +                    FIELD_PREP(MEN_Z192_CFBUF_ID_18_BITS, id_18_bits);
> >>>> +
> >>>> +               if (cf->can_id & CAN_RTR_FLAG)
> >>>> +                       id |= MEN_Z192_CFBUF_E_RTR;
> >>>> +       } else {
> >>>> +               /* Standard frame */
> >>>> +               id = FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, cf->can_id);
> >>>> +
> >>>> +               if (cf->can_id & CAN_RTR_FLAG)
> >>>> +                       id |= MEN_Z192_CFBUF_S_RTR;
> >>>> +       }
> >>>> +
> >>>> +       writel(id, &cf_buf->can_id);
> >>>> +       writel(cf->can_dlc, &cf_buf->length);
> >>>> +
> >>>> +       if (!(cf->can_id & CAN_RTR_FLAG) && cf->can_dlc) {
> >>>> +               writel(be32_to_cpup((__be32 *)(cf->data)), &cf_buf->data[0]);
> >>>> +               if (cf->can_dlc > 4)
> >>>> +                       writel(be32_to_cpup((__be32 *)(cf->data + 4)),
> >>>> +                              &cf_buf->data[1]);
> >>>
> >>> Why do you cast cf->data to __be32? Shouldn't the cf_buf->data
> >>> which should be of type __be32 instead (or as commented above,
> >>> make cf_buf->data an array of bytes).
>
> cf->data is in __be32 format. (As Vincent said above, an an u8 array for 4
> members has the same mem layout as a __be32).

ACK

> >> wanted to write 4 bytes with correct byte ordering. When function
> >> be32_to_cpup is used for that purpose, it's parameter has to be of type
> >> __be32, which is why casting is done. As already said, there are two 32-bit
> >> registers for storing entire 8-byte CAN data, so it is realized with an
> >> array of 32-bit type with length of 2.
>
> > be32_to_cpup is to convert endianness from the device to the cpu.
> >
> > As commented above, the type of your data[] is wrong.
>
> I don't think so, as writel assumes a __le32 HW-register converted to native
> endianess.

ACK. In the light of Marc's explanation, Abhijeet's original code looks fine.

> > Also, did you test your code on a big endian architecture?
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
