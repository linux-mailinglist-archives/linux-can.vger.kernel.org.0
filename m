Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E13673DB
	for <lists+linux-can@lfdr.de>; Wed, 21 Apr 2021 21:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbhDUT7J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Apr 2021 15:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245596AbhDUT7I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Apr 2021 15:59:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664FDC06174A
        for <linux-can@vger.kernel.org>; Wed, 21 Apr 2021 12:58:35 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m13so43538902oiw.13
        for <linux-can@vger.kernel.org>; Wed, 21 Apr 2021 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkfRV6GXLtNs4iOGq1WOmrpDT81x03l3HcOOoQkcWbo=;
        b=YqGpsPR23lO6yfyuuJlp+h2RdqSFVY4gkHwwEhsCHx9V3I8KO1WOnC0tiRsY3nXZw/
         HNFsy+lJRjhO52Ga2UEaIk1pWRCh6O8NGuEl8jJSgKKQbisuEp4ZaSXphYBYaypljHM7
         DSVweTxT+ZGUE+eoq08a/KiARgzEImDBl+CAaZp7Uo8dwcaybF2ge17NZpaB7qNoawVh
         EIL8gnrT3/TiFAq/gWGnr5VletaXqLPkqOWHwsIsVhJfBCSaJyq61aBrDAqKHEKluT2a
         bCLv5fml0jf8r99D7epQMAWa31J3r5F2r4bCqYa1Ad4UWFzBlGmID+6YMisAs+Pk117w
         LINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkfRV6GXLtNs4iOGq1WOmrpDT81x03l3HcOOoQkcWbo=;
        b=rqXxqzDCVeZxCQqMinT1arwZb5O1tlkcDGcr570EuKI2oIqFyCddKDBI4mDS7B0yjI
         O+tPvc/K2Nn5XjmXZ5VKoTQLGWDBWsyxUHvQmvS7sWIHAWIXy1yKVytiWhhlIYoa1xrD
         lirnC2UPAecsT6/bAyrPaLCHteyRve603elOnkfknsF/p0wZzL3iHQHGYvmpD/l25NF7
         wJ3VErSIgHUHTjbBsSuJz/mSIY4GBXJLC4W0n22+t87PbExFPMyDimz2uOaUgiQ+SpBj
         qvRUUAbJrSYy71vCghvcJny13xDxUF+X2MEr+QDIFyZRLBJsesoJNAklfynZCMSxKG0T
         xxYw==
X-Gm-Message-State: AOAM533HQ2c/qMeBgsv9KGJVjbg280EBWRnSUCWg7q7jbzF0upJaX1LT
        X/seO7MgOblvOCFaZfbEqjtM5EgVEDd1Yed2Vvtu1w==
X-Google-Smtp-Source: ABdhPJya6jS43/RzAZtVQWG+DWoTrVGJLy1/3SJwjEPlv9Em90yxDhLuPNpyPXRndNTKsjBJlcoBlSn5OT51DqGB1oE=
X-Received: by 2002:aca:cf09:: with SMTP id f9mr6072597oig.38.1619035114646;
 Wed, 21 Apr 2021 12:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210407080118.1916040-1-mkl@pengutronix.de> <20210407080118.1916040-7-mkl@pengutronix.de>
In-Reply-To: <20210407080118.1916040-7-mkl@pengutronix.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Wed, 21 Apr 2021 12:58:23 -0700
Message-ID: <CAPgEAj6N9d=s1a-P_P0mBe1aV2tQBQ4m6shvbPcPvX7W1NNzJw@mail.gmail.com>
Subject: Re: [net-next 6/6] can: mcp251xfd: mcp251xfd_regmap_crc_read(): work
 around broken CRC on TBC register
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Manivannan Sadhasivam <mani@kernel.org>,
        Will C <will@macchina.cc>,
        Thomas Kopp <thomas.kopp@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Apr 7, 2021 at 1:01 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> MCP251XFD_REG_TBC is the time base counter register. It increments
> once per SYS clock tick, which is 20 or 40 MHz. Observation shows that
> if the lowest byte (which is transferred first on the SPI bus) of that
> register is 0x00 or 0x80 the calculated CRC doesn't always match the
> transferred one.
>
> To reproduce this problem let the driver read the TBC register in a
> high frequency. This can be done by attaching only the mcp251xfd CAN
> controller to a valid terminated CAN bus and send a single CAN frame.
> As there are no other CAN controller on the bus, the sent CAN frame is
> not ACKed and the mcp251xfd repeats it. If user space enables the bus
> error reporting, each of the NACK errors is reported with a time
> stamp (which is read from the TBC register) to user space.
>
> $ ip link set can0 down
> $ ip link set can0 up type can bitrate 500000 berr-reporting on
> $ cansend can0 4FF#ff.01.00.00.00.00.00.00
>
> This leads to several error messages per second:
>
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0010 (length=4, data=00 3a 86 da, CRC=0x7753) retrying.
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0010 (length=4, data=80 01 b4 da, CRC=0x5830) retrying.
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0010 (length=4, data=00 e9 23 db, CRC=0xa723) retrying.
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0010 (length=4, data=00 8a 30 db, CRC=0x4a9c) retrying.
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0010 (length=4, data=80 f3 43 db, CRC=0x66d2) retrying.
>
> If the highest bit in the lowest byte is flipped the transferred CRC
> matches the calculated one. We assume for now the CRC calculation in
> the chip works on wrong data and the transferred data is correct.
>
> This patch implements the following workaround:
>
> - If a CRC read error on the TBC register is detected and the lowest
>   byte is 0x00 or 0x80, the highest bit of the lowest byte is flipped
>   and the CRC is calculated again.
> - If the CRC now matches, the _original_ data is passed to the reader.
>   For now we assume transferred data was OK.
>
> Link: https://lore.kernel.org/r/20210406110617.1865592-5-mkl@pengutronix.de
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Thomas Kopp <thomas.kopp@microchip.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> index 35557ac43c03..297491516a26 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
> @@ -321,6 +321,40 @@ mcp251xfd_regmap_crc_read(void *context,
>                 if (err != -EBADMSG)
>                         return err;
>
> +               /* MCP251XFD_REG_TBC is the time base counter
> +                * register. It increments once per SYS clock tick,
> +                * which is 20 or 40 MHz.
> +                *
> +                * Observation shows that if the lowest byte (which is
> +                * transferred first on the SPI bus) of that register
> +                * is 0x00 or 0x80 the calculated CRC doesn't always
> +                * match the transferred one.
> +                *
> +                * If the highest bit in the lowest byte is flipped
> +                * the transferred CRC matches the calculated one. We
> +                * assume for now the CRC calculation in the chip
> +                * works on wrong data and the transferred data is
> +                * correct.
> +                */
> +               if (reg == MCP251XFD_REG_TBC &&
> +                   (buf_rx->data[0] == 0x0 || buf_rx->data[0] == 0x80)) {
> +                       /* Flip highest bit in lowest byte of le32 */
> +                       buf_rx->data[0] ^= 0x80;
> +
> +                       /* re-check CRC */
> +                       err = mcp251xfd_regmap_crc_read_check_crc(buf_rx,
> +                                                                 buf_tx,
> +                                                                 val_len);
> +                       if (!err) {
> +                               /* If CRC is now correct, assume
> +                                * transferred data was OK, flip bit
> +                                * back to original value.
> +                                */
> +                               buf_rx->data[0] ^= 0x80;
> +                               goto out;
> +                       }
> +               }
> +
>                 /* MCP251XFD_REG_OSC is the first ever reg we read from.
>                  *
>                  * The chip may be in deep sleep and this SPI transfer
> --
> 2.30.2
>
>

Hello Marc,

I am encountering similar error with the 5.10 raspberrypi kernel on
RPi 4 with MCP2518FD:

  mcp251xfd spi0.0 can0: CRC read error at address 0x0010 (length=4,
data=00 ad 58 67, CRC=0xbbfd) retrying

Would it be possible for you to pull these patches into a v5.10 branch
in your linux-rpi repo [1]?

Thanks,
Drew

[1] https://github.com/marckleinebudde/linux-rpi
