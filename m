Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1442A2D0D
	for <lists+linux-can@lfdr.de>; Mon,  2 Nov 2020 15:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBOfZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Nov 2020 09:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKBOfZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Nov 2020 09:35:25 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609BFC0617A6
        for <linux-can@vger.kernel.org>; Mon,  2 Nov 2020 06:35:25 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id u127so14831668oib.6
        for <linux-can@vger.kernel.org>; Mon, 02 Nov 2020 06:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcutU9/zOMnp/ZcTXHTsxtJvWQzybSS1aCnDw9k1LwQ=;
        b=cdUa6x2tnfUWNSrLjk9+02m65aa+6f0Xi5O3EO0XAL/NBWDg38UPUe0KelguGDsakv
         9Zw4qwegVAFUZBxQ3kpUH0KR5CuNni57UzEyhg5BKDlafozIGK7cBIRu5GdYhb9AT9rp
         WeIozuK4dryyDban1TGZ3sW7vsemJWRkvEaPHWJfEf9nxCznOeeIPX2jJAvY6oW0qetj
         dPgSoLd84VgHjq8K7jP5WSfYOyd5EmoyUSShStzV98Loz0RdJVXdEIy9US8LDD2S7lVe
         63Vci3q6YTnLWdW8o99Y9QaFHfsohOI5M9M0jjCYUmSOLPIWYWxDGpjROhHM7RTr512A
         cFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcutU9/zOMnp/ZcTXHTsxtJvWQzybSS1aCnDw9k1LwQ=;
        b=F5MbzsxO9LtzbxGGfLZZ62LvmNfGZqytFmFnEdTxMhF2XZJyzMASCpl22HXgVyfopG
         4dynK/viN/24cotwPk9q2DgJ1vn3EM1GFrcDS40TvyR7kZQODQHO63AbnUgcKgy/RCm4
         i/ikeG5eqDoPl/koX3iN6oya8trITqcbOgaTVzQR17IRtfjCF6ji+6VBcnTN8jAab9v5
         Wus7HlmYmYVLe3SNWX+h2oifdXDFbgK7TQMfmsSoGOAr2F11PBlj2SfH7XfDQ7ADZL7S
         57krOlX3MOFvZRLq7kuyejlhBfDsMw8HxTRT3faWulLQeJZX3IF955sHdzvffsnDJysW
         auKw==
X-Gm-Message-State: AOAM531lY0jO3ivmK0tdcI0LFbNc0LrSeuznbq+IM9uxxlNKENagPOSh
        7h2E89RsiLPzHFWmqQQMgUiY4jDQb0E18I+CgXBLmA==
X-Google-Smtp-Source: ABdhPJzRYWq1aIBxutlf9EvQZHfwoId1ZTRDJmmZuRshSsbbj3hAYAFgMf4GVKhfFrgdfzlHUm2ZlzAmUj+YHVs5SK8=
X-Received: by 2002:aca:b607:: with SMTP id g7mr9636949oif.38.1604327724567;
 Mon, 02 Nov 2020 06:35:24 -0800 (PST)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
 <41b606d5-5991-4d4f-bd6f-aaaf31cbc9b5@pengutronix.de> <6a7061a4-771d-6703-1e30-273050abfb9d@posteo.de>
 <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de> <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
 <CAPgEAj4W61tCSkdrCP2J4dL7WwQ1NKzFCUGjY9o4_qj+NG5KEA@mail.gmail.com>
 <3d19330b-860b-7d76-bc6d-768a7b00ed4b@pengutronix.de> <CAPgEAj6qZxfsyuarVgvnXkHd3ZUAP-3fgD-nONCcn-C5xY44+Q@mail.gmail.com>
 <e955f39f-2417-4dca-ee3c-70b328c1014d@posteo.de> <3a5f81d6-13ba-71b8-67a7-fe6e8a13f84a@posteo.de>
 <CAPgEAj7B5O5nwqr-nMBXNqgx9tD5=9XPG0W0=C21FMD6S+bR-A@mail.gmail.com>
 <3b7b6353-0493-210a-7c14-e7ccc1067365@pengutronix.de> <CAPgEAj7LcX3cb+syhtR1i3Uo1XkYYFQ_wDPV8GniaA-YwPk2Hg@mail.gmail.com>
 <08a1fb36-5efb-27d8-f5b9-bd2a923479a2@pengutronix.de> <CAPgEAj7BTJyiBg4QkKuekYH0zyrA-10dby3Lgb5qj2uiD4ZOYQ@mail.gmail.com>
 <fbe2bf42-706e-d27f-5bfd-f63b3c9b9ef2@pengutronix.de>
In-Reply-To: <fbe2bf42-706e-d27f-5bfd-f63b3c9b9ef2@pengutronix.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Mon, 2 Nov 2020 15:35:33 +0100
Message-ID: <CAPgEAj4HuSAgRoMC9Ldtk2tf=-3Ek9E_cYFQRG7+P-+rh2Q1SQ@mail.gmail.com>
Subject: Re: mcp251xfd: loopback test on waveshare canfd hat
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Nov 2, 2020 at 3:22 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 11/2/20 3:20 PM, Drew Fustini wrote:
> > I am able to have can0 (spi0.0) and can1 (spi1.0) initialize ok on the
> > waveshare canfd hat (solder jumper mode A) with the mcp251xfd driver
> > from Marc's rpi 5.4 branch.  However, I am not able to do a loopback
> > test successfully.
> >
> > No errors from setup:
> > sudo ip link set can0 type can bitrate 250000 listen-only on
> > sudo ip link set can1 type can bitrate 250000 listen-only on
>                                                 ^^^^^^^^^^^^^^
>
> It really does listen-only on the bus, i.e. not send anything :)
>
> Marc

Thanks for pointing that out!  /me might need new glasses :)

The can0->can1 test is now working with mcp251xfd:

pi@raspberrypi:~$ sudo ip link set can0 type can bitrate 250000
pi@raspberrypi:~$ sudo ip link set can1 type can bitrate 250000
pi@raspberrypi:~$ sudo ifconfig can0 up
pi@raspberrypi:~$ sudo ifconfig can1 up
pi@raspberrypi:~$ dmesg |tail
[   75.751015] mcp251xfd spi0.0 can0: bit-timing not yet defined
[   75.811003] mcp251xfd spi1.0 can1: bit-timing not yet defined
[   96.934271] mcp251xfd spi0.0 can0: FIFO setup: TEF: 8*12 bytes = 96
bytes, TX: 8*16 bytes = 128 bytes
[   96.934292] mcp251xfd spi0.0 can0: FIFO setup: RX-0: 32*20 bytes = 640 bytes
[   96.934308] mcp251xfd spi0.0 can0: FIFO setup: free: 1184 bytes
[   96.942154] IPv6: ADDRCONF(NETDEV_CHANGE): can0: link becomes ready
[   97.020451] mcp251xfd spi1.0 can1: FIFO setup: TEF: 8*12 bytes = 96
bytes, TX: 8*16 bytes = 128 bytes
[   97.020464] mcp251xfd spi1.0 can1: FIFO setup: RX-0: 32*20 bytes = 640 bytes
[   97.020474] mcp251xfd spi1.0 can1: FIFO setup: free: 1184 bytes
[   97.990436] IPv6: ADDRCONF(NETDEV_CHANGE): can1: link becomes ready

pi@raspberrypi:~$ candump can1 &
[1] 1037
pi@raspberrypi:~$ cansend can0 01a#11223344AABBCCDD
  can1  01A   [8]  11 22 33 44 AA BB CC DD

thanks,
drew
