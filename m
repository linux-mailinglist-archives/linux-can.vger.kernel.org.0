Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B482A1758
	for <lists+linux-can@lfdr.de>; Sat, 31 Oct 2020 13:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgJaM1l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 31 Oct 2020 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgJaM1k (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 31 Oct 2020 08:27:40 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AF3C0613D5
        for <linux-can@vger.kernel.org>; Sat, 31 Oct 2020 05:27:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a6so8111422otp.10
        for <linux-can@vger.kernel.org>; Sat, 31 Oct 2020 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUeEIMYVissc6Y+RJtqliJt9OuU+ukPzCN1Qs6fJkdM=;
        b=v1XzATl76KNFkhMDiKhBMrDRdlTw+5n88oP+o/d1klStmDpDYAafkYs8eCSgn8PqX7
         yzJeQjbyvjq4lWHHlJjfSg1x4HmnT4s90P7F0x6vMRXkHbhIBCf1iQvfus8kb1Fsrwqh
         TIgvf2JUNQqD1NVp45sPdk7ZkJWhg0DOBwW0tOs7/1BayG9HLO8Sz/6BfLE/0L3wr2k8
         rjO+fg1upUAEDaI6Y3JO8AXfOvq/nUBA3LKkxE0/A9Q4AezFE4kMwc3qvgiW/4jpf6N8
         XjhhG7Ajcyp6X0Z834gPFyLeLPQtp+T5OzmPjNaTZnKBVec16QuDwJ0o3/cUyAsNsz17
         wZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUeEIMYVissc6Y+RJtqliJt9OuU+ukPzCN1Qs6fJkdM=;
        b=lhcd+NhHX9TYPKzfEBcfblA37PuGBtxKolXPlLiMo7Mo77q665EvqqmAbRxZUhXLiW
         mWnuycwWT37AOBRqfOOHPt6kiHzeRknBiG8asgwZqhH9oKEQqaFJ/0v9UwpKA7ORK5Op
         cJpvINbQxNWk3vpHwObBTRtRhhGw/U2LDba7qxHQM/IutxmGj1mPXVSU5bTV1i1UyM4v
         vmUihPUbUS9DmaNpm/5Kjt9+DqrtNUSEiOeIgKe0KxgmWOhOrfHv/GJWKqTbq4pjg5q+
         zUrUotQfN3MYYMVU2776+jYqS33HF8CyIHwozd+2fXGsSqtkF8BpIx2IT6aRuWkyhDmR
         CzDg==
X-Gm-Message-State: AOAM5315MSmWNS+dE3IbbeiF5s7ScbC15uoJbC+3Yh/E8pQw/U3IvWAJ
        jHXhdXNcI3nR2HgeUIn8MLgEuaF903b+ycTpVPoMBw==
X-Google-Smtp-Source: ABdhPJx9ie1G+lZErqZNyXsgXsyYoQ7YUhejKJ1wiC8InN6pU3PZEE74kuikX12iTGwD87Md5HuixAbHrSwV7PB49dk=
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr5137214otc.114.1604147258674;
 Sat, 31 Oct 2020 05:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <68846197-98dc-b991-1ec8-a477ceb8d614@posteo.de> <715b3c3b-dbbc-688c-9757-578455c3a607@pengutronix.de>
 <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de> <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
 <CAPgEAj4DceAkPySUekDZPAKwNToxNjz6Yr66_3mqkE-0iiKAYA@mail.gmail.com>
 <92dd7044-8f0d-154b-eb04-8cec1b572dd2@pengutronix.de> <fa70fffa-7702-7cd0-dcfb-15bd18c3bb15@posteo.de>
 <2a1ddec7-ca28-ae44-dc06-f80f0017bf1f@pengutronix.de> <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
 <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
 <41b606d5-5991-4d4f-bd6f-aaaf31cbc9b5@pengutronix.de> <6a7061a4-771d-6703-1e30-273050abfb9d@posteo.de>
 <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de> <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
 <CAPgEAj4W61tCSkdrCP2J4dL7WwQ1NKzFCUGjY9o4_qj+NG5KEA@mail.gmail.com> <3d19330b-860b-7d76-bc6d-768a7b00ed4b@pengutronix.de>
In-Reply-To: <3d19330b-860b-7d76-bc6d-768a7b00ed4b@pengutronix.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Sat, 31 Oct 2020 13:27:46 +0100
Message-ID: <CAPgEAj6qZxfsyuarVgvnXkHd3ZUAP-3fgD-nONCcn-C5xY44+Q@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Oct 28, 2020 at 8:58 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 10/28/20 4:47 AM, Drew Fustini wrote:
> >> I assumed the Waveshare instructions work but that is error on my part
> >> for not actually reproducing.  That is what I will do first.
> >> Ultimately, I want the freshly upstreamed driver working but I should
> >> check if their driver tarball works.
> >
> > The Waveshare installer uses the 4.19 kernel with the mcp25xxfd
> > driver.  However, it also fails, sio I think I need to dig deeper:
> >
> > pi@raspberrypi:~ $ dmesg | grep -Ei spi\|can
> > [    4.263765] CAN device driver interface
> > [    4.286258] mcp25xxfd_can: loading out-of-tree module taints kernel.
> > [    5.477511] mcp25xxfd spi1.0: Cannot initialize MCP2517. Wrong
> > wiring? (oscilator register reads as 00000000)
>
> It reads the osc as 0x0, too. This is the same error as you've seen with my driver.
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


Alright, it looks like I had faulty hardware!  I got a Waveshare CAN
FD hat and both the old waveshare-provided driver and the new
mcp251xfd driver work.

Well, at least for can0 with mcp251xfd-spi0-0:

[   14.530587] CAN device driver interface
[   14.548941] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe():
devm_clk_get()
[   14.548977] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe(): feq=40000000
[   14.549045] spi_master spi0: will run message pump with realtime priority
[   14.562946] mcp251xfd spi0.0 can0: MCP2517FD rev0.0 (-RX_INT
+MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.

However, I am still trying to figure out can1.  I tried
mcp251xfd-spi0-1 and mcp251xfd-spi1-0 but neither was able to
initialize the device.  I am using:

commit 9e02abd4fe591b2d7f369cdaaaf8f1269b7c8693 (HEAD ->
v5.4-rpi/mcp251xfd-20201022-54, marc/v5.4-rpi/mcp251xfd-20201022-54)
Author: Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Fri Nov 15 00:54:07 2019 +0100

    mcp251xfd-spi0-0, mcp251xfd-spi0-1, mcp251xfd-spi1-0: add overlays

    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

I'll try tweaking it a bit and see if I get any further.

Thanks,
Drew
