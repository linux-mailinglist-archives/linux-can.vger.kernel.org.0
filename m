Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35843B9B88
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 06:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhGBEg3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 00:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhGBEg2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 00:36:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC8C061762
        for <linux-can@vger.kernel.org>; Thu,  1 Jul 2021 21:33:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id a133so9895810oib.13
        for <linux-can@vger.kernel.org>; Thu, 01 Jul 2021 21:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q95NNcCkJCRAILVMolWJqho/v410HD3h1DHD0+87pNs=;
        b=HdGk4AXkSFygLOUNlKOqJ+tf5to/aDt5rQ7X+nVXrFwqXIm170irz8zrUCp7ZGYoC8
         SW/HpfK9cjtWfBH6PaYZnm6tgpqleM/e6fn1TAVa+xy+tBeCv+6/PMiX79q/Nn7ubkin
         E56Z+ruedsd7ljwwobWsdHxFKf5ZD15MTigNlAvZz/AGrrKqrM6d4MOoOjltvx60qnJG
         MpZxhsA7QCnofBxus5YxWxD35JWbHCWcYxe/HPXPY/3WpoAqU5288aA5g+MFTg4/XEQu
         wo5bkJIE4VQCV+s6jbytQAFWflwJ0ux75EwPCOvh929Go+JstY6kfhksT6haRZScd06C
         xzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q95NNcCkJCRAILVMolWJqho/v410HD3h1DHD0+87pNs=;
        b=jzHVeTn+86QXWk1K82GSgDj7ehtRVmLP4mXAE5gEvXM8h7cXXAsNbaDSGLZ46VTNqz
         LW5s9cQLA4Q5q5Xf+W4LxzNbuTagUJKRaWWinlMTAMqd8tdd+QyU2FlSgpoYube52HW0
         S5NoLzPzxmqMcRuP2CQInoZpOEQaaoiMtSjMvoiZ+hDdIP5Y8x9ZfnrP4DV/dWp0K8Fk
         1MLmTlw18dHOn/m5lWQ/dV8TUeX1/LArRE6sJcnzd197q3TR6Q28GbASvEmhnzPxFR4w
         kcgPvIR3bfGPnSpAee6HBqnyeMjJyVE15HJLHUXhOzQklfxC1CWhoMkvMQ9T7IAl3mYc
         PyEg==
X-Gm-Message-State: AOAM530DD3IoJQOrJu6HHJ54hLIuOwfYpqq8IbYqh5GcjflEJurAH3/P
        /Ja9hTUS28zYpBo7OWHIPL6/xERsJM0lbILPqX8=
X-Google-Smtp-Source: ABdhPJzXuIZL++KnCprRfbPO3Sds+1bDBZpXfcag+Upe//CoJVk00iM24Vk9sMYrSiNd/Y/Vul+nfNtQOKNZSTrHGho=
X-Received: by 2002:aca:2806:: with SMTP id 6mr10039093oix.2.1625200434725;
 Thu, 01 Jul 2021 21:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com> <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
 <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de> <029101d76855$fa5ac300$ef104900$@gmail.com>
 <20210625065626.b7afwhptoyoxoblx@pengutronix.de> <20210625121648.hg4hihfmddss7ptu@pengutronix.de>
 <020f01d769da$9fac86b0$df059410$@gmail.com> <022d01d769e2$e623cbf0$b26b63d0$@gmail.com>
In-Reply-To: <022d01d769e2$e623cbf0$b26b63d0$@gmail.com>
From:   Joshua Quesenberry <engnfrc@gmail.com>
Date:   Fri, 2 Jul 2021 00:33:43 -0400
Message-ID: <CAMGHUokQ6ojxF1TDz_DfG4f7FVua3MZO2MLV02CJOgLqDPGc3g@mail.gmail.com>
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, Joshua Quesenberry <EngnFrc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc,

I tried adding "#define DEBUG" to the top of spi-bcm2835.c, but I
don't see any additional logging in the output of dmesg. Any other
ideas? Anything you all notice in the Saleae data worth mentioning?

Thanks!

Josh Q

On Fri, Jun 25, 2021 at 12:55 PM Joshua Quesenberry <engnfrc@gmail.com> wro=
te:
>
> Forgive me, I forgot can0 =3D spi0.1 and can1 =3D spi0.0 right now becaus=
e I killed my UDEV rule so I was tapped onto the wrong CS line. Attached is=
 a snapshot of what I'm seeing AND an export of the data from Saleae which =
may prove more useful than snapshots.
>
> Thanks,
>
> Josh Q
>
> -----Original Message-----
> From: Joshua Quesenberry <engnfrc@gmail.com>
> Sent: Friday, June 25, 2021 11:56 AM
> To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
> Cc: 'Patrick Menschel' <menschel.p@posteo.de>; kernel@pengutronix.de; lin=
ux-can@vger.kernel.org; engnfrc@gmail.com
> Subject: RE: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
>
> Marc,
>
> I had already switched back to the normal clock speed in a previous email=
, so should be good there. It's been a while, but we're pushing the RPi pre=
tty hard and either there was a drop in overall resource usage or it was a =
matter of less dropped video frames (which is something we strive to minimi=
ze for the research we do) from the three USB cameras. At the moment I've g=
ot all the add-ons turned off and the load is minimal.
>
> I was able to get my hands on a Saleae and am attaching a snapshot of wha=
t happens when I run the ip link command. I am noticing that the chip selec=
t is never being toggled right now with the ip link command failing... so t=
hat just might be our root issue. So what can we do to figure out WHY the c=
hip select isn't acting as expected?
>
> I have probes attached to the following for CAN0:
>
> Pin Function
> 19  SPI0_MOSI
> 21  SPI0_MISO
> 23  SPI0_SCLK
> 24  GPIO8 / CS0
>
> Thanks,
>
> Josh Q
>
> -----Original Message-----
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Sent: Friday, June 25, 2021 8:17 AM
> To: Joshua Quesenberry <engnfrc@gmail.com>
> Cc: 'Patrick Menschel' <menschel.p@posteo.de>; kernel@pengutronix.de; lin=
ux-can@vger.kernel.org
> Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
>
> On 25.06.2021 08:56:26, Marc Kleine-Budde wrote:
> > On 23.06.2021 13:34:10, Joshua Quesenberry wrote:
> > > I added printing the error number as Marc suggested and the number
> > > appears to be -110 every time.
> >
> > #define       ETIMEDOUT       110     /* Connection timed out */
> > https://elixir.bootlin.com/linux/latest/source/include/uapi/asm-generi
> > c/errno.h#L93
> >
> > That means something has timed out, we see this in the previous log
> > message, too:
> >
> > > [   25.660006] CAN device driver interface
> > > [   25.668720] spi_master spi0: will run message pump with realtime
> > > priority
> > > [   25.676697] mcp251xfd spi0.1 can0: MCP2518FD rev0.0
> > > (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz
> > > m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
> > > [   25.684900] mcp251xfd spi0.0 can1: MCP2518FD rev0.0
> > > (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz
> > > m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
> > > [   28.098033] mcp251xfd spi0.1 rename4: renamed from can0
> > > [   28.175644] mcp251xfd spi0.0 can0: renamed from can1
> > > [   28.225891] mcp251xfd spi0.1 can1: renamed from rename4
> >                                    VVVVVVVVVVVVVVVVVVVVVV
> > > [  146.964971] mcp251xfd spi0.0: SPI transfer timed out [
> > > 146.965023] spi_master spi0: failed to transfer one message from
> > > queue (ret=3D-110)
> >
> > > [  146.965216] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0e0c (length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > > [  146.965247] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0e0c (length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > > [  146.965277] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0e0c (length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > > [  146.965286] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0e0c (length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> > > [  146.965331] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0000 (length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > > [  146.965360] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0000 (length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > > [  146.965389] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0000 (length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > > [  146.965397] mcp251xfd spi0.0 can0: CRC read error at address
> > > 0x0000 (length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> > > [  146.965413] A link change request failed with some changes
> > > committed already. Interface can0 may have been left with an
> > > inconsistent configuration, please check.
> > >
> > > Regarding the discussion about Kconfig flags, I went ahead and
> > > rebuilt kernel 5.10.44 using a config that was essentially
> > > arch/arm/configs/bcm2711_defconfig with these additions needed to
> > > get our I2S working. This should have undone the switch to ONDEMAND
> > > governor and enabling 1000 Hz clock.
> >
> > Please switch back the clock to the standard HZ setting.
>
> I compiled my 64 bit raspi kernel with HZ=3D1000 and my mcp2518fd board w=
orks without problem on my raspi4b.
>
> | static int bcm2835_spi_transfer_one_poll(struct spi_controller *ctlr,
> |                                        struct spi_device *spi,
> |                                        struct spi_transfer *tfr,
> |                                        u32 cs)
> | {
> [...]
> |       /* set the timeout to at least 2 jiffies */
> |       timeout =3D jiffies + 2 + HZ * polling_limit_us / 1000000;
>
> The timeout is calculated in jiffies. The jiffies variable is incremented=
 once per timer tick (which depends on the clock HZ configuration). There a=
re "HZ" jiffies per second. This means the above "2" equals 8ms (HZ=3D250),=
 but with HZ=3D1000 only 2ms.
>
> To keep the timeout constant, you can change this into:
>
>         timeout =3D jiffies + (HZ * 8) / 1000 + HZ * polling_limit_us / 1=
000000;
>
> However, the polling mode will only be used for transfers that should fin=
ish in 30 =C2=B5s. So even 2ms is far of...
>
> |
> |       /* loop until finished the transfer */
> |       while (bs->rx_len) {
> |               /* fill in tx fifo with remaining data */
> |               bcm2835_wr_fifo(bs);
> |
> |               /* read from fifo as much as possible */
> |               bcm2835_rd_fifo(bs);
> |
> |               /* if there is still data pending to read
> |                * then check the timeout
> |                */
> |               if (bs->rx_len && time_after(jiffies, timeout)) {
>
> If there is a timeout, the driver will fall back to IRQ mode.
>
>
> Can you add a "#define DEBUG" in spi-bcm2835.c, even before the other "#i=
nclude" directives. That should give you this debug message:
>
> |                       dev_dbg_ratelimited(&spi->dev,
> |                                           "timeout period reached: jiff=
ies: %lu remaining tx/rx: %d/%d
> | -
> falling back to interrupt mode\n",
> |                                           jiffies - timeout,
> |                                           bs->tx_len, bs->rx_len);
> |                       /* fall back to interrupt mode */
> |
> |                       /* update usage statistics */
> |                       bs->count_transfer_irq_after_polling++;
> |
> |                       return bcm2835_spi_transfer_one_irq(ctlr, spi,
> |                                                           tfr, cs, fals=
e);
>
> here it activates the IRQ. But I'm not sure if the fallback works correct=
ly....
>
> |               }
> |       }
> |
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
