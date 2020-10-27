Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4629A4B8
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 07:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgJ0Ge6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 02:34:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33405 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJ0Ge6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 02:34:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id s21so251633oij.0
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2020 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OLZkKXHEUBY7DeEd3iPlPLN0NQpAEg6enu9STnS7gk=;
        b=ffXTeo09Myz4E6soRpWj2Esy56EmQrebOlb3RE7TmmoT1uSQrgSHt8qModdv583VB5
         ylDwsYc9wCjqHA/1Ctvj8kdagxf9BDstCFics+g9YAnZ4Ss2k8648LnNtoLoQQ+kt23a
         I5ddwt0WoVvSq9ZP4Ceh4ZIIFO7IkCXVBzImlnUqpATQX34dG2IJTArM3oibnMy9D2OF
         0xHJTwrm6pEQ7P57eQrxKkHgO4e7lRLMAiSj+v3uifIXSW7n577GqyJaAGk6jUVXLACv
         bk+POnX8MtadcvZjfCCIfjekBz2Bx5DUnkT3PIRnYV3QzIgvB56+T3IBYNXxO++8G3Zu
         n54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OLZkKXHEUBY7DeEd3iPlPLN0NQpAEg6enu9STnS7gk=;
        b=m8Uq29IZYiI65JNKJNGVPclQ6RiMOlgf/tuZF0yXCRaO3UFQh3Y0LryThVCg5QIIOC
         IjsCidzgO23rd5/b/ZilGfdgkw9uaFgjndF4m5h1/8VHwGsWzptInmTEOfdfLQaDw533
         Z/y+jPhzBaLMJmBDMQ4eyovN4fa+mHDHY42jIbukxKRhzCoxcLygljCimdTWzsBz74KB
         1p0WbQwsu73MbAqUF3bECNQIy5b+jwkrhtb6d9YkDJq1rIzpfto1/Xl/sog2EQPXzx35
         zfFoqNCIBK/eLW3P5olQ9VRSuqIjBg+ckj7IOo0+KtwUsGV4YoTtk+MjLYoLVU57PMur
         drYg==
X-Gm-Message-State: AOAM531bUfHq6CvTsBypaU3ik+IvRPTOjiEKToXDFO8YiFsTuTgtX4Qy
        jEMWHmdrOgvH8N+PxphS9VtRh3eApjWb3JddC6IxzA==
X-Google-Smtp-Source: ABdhPJx4N+GAZxZ3jOHWvgwLwSSRNUrBUdQfoPGcM/X3gXA5Q7shoWCmNyp4K61V0o+weJRPWgJvvBer3oP7qIR+Oms=
X-Received: by 2002:aca:b644:: with SMTP id g65mr404581oif.164.1603780497113;
 Mon, 26 Oct 2020 23:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
 <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de> <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
 <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net> <20201025105808.2pltif74at3xwtjd@hardanger.blackshift.org>
 <68846197-98dc-b991-1ec8-a477ceb8d614@posteo.de> <715b3c3b-dbbc-688c-9757-578455c3a607@pengutronix.de>
 <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de> <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
 <CAPgEAj4DceAkPySUekDZPAKwNToxNjz6Yr66_3mqkE-0iiKAYA@mail.gmail.com>
 <92dd7044-8f0d-154b-eb04-8cec1b572dd2@pengutronix.de> <fa70fffa-7702-7cd0-dcfb-15bd18c3bb15@posteo.de>
 <2a1ddec7-ca28-ae44-dc06-f80f0017bf1f@pengutronix.de> <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
In-Reply-To: <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Tue, 27 Oct 2020 01:35:03 -0500
Message-ID: <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Oct 26, 2020 at 9:22 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> Thank you the feedback.
>
> I think it may be any issue with spi interface and/or chip select config.
>
> [    6.812079] DEBUG mcp251xfd mcp251xfd_probe(): ENTER
> [    6.812174] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe():
> devm_clk_get()
> [    6.812208] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe():
> feq=0x2625a00
> [    6.850106] mcp251xfd spi0.0 (unnamed net_device) (uninitialized):
> Failed to detect MCP251xFD (osc=0x00000000).
>
> This proves that the driver is getting the 40 MHz from the device tree
> properties.  The board does have a 40 MHz osc.
>
> It is the Waveshare CANFD Hat [1].  They have their own tarball for
> download [2] with a mcp25xxfd driver that is copyright 2019 by Martin
> Sperl <kernel@martin.sperl.org>.  I'm looking at that to see why it
> works and the newer, proper driver does not.
>
> Thanks,
> Drew
>
> [1] https://www.waveshare.com/wiki/2-CH_CAN_FD_HAT
> [2] https://www.waveshare.com/wiki/File:2-CH-CAN-FD-HAT-Demo.7z

This is the overlay that the Waveshare download is using:
https://gist.github.com/pdp7/784d0ba8b9648d20ab055747ec945225

It is different but I'm having trouble understanding why it works and
the new overlay for the newer driver does not.

-Drew
