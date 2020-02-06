Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B0153FC9
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2020 09:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBFILI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Feb 2020 03:11:08 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40030 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgBFILI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2020 03:11:08 -0500
Received: by mail-vs1-f67.google.com with SMTP id g23so3202482vsr.7
        for <linux-can@vger.kernel.org>; Thu, 06 Feb 2020 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmUcPRO54/BdBaz9G6UqSudyCrbhUDL2nStrQrZ2ayU=;
        b=BHYlmltrburzkoLeXAHkojZo9EbWkLNz3Tx9rI2Ka1fDRlBFVJe7Txfxd1ohtg/80e
         CqmHPnW/w9ecZtCeezVY9sajGhbN52aevvRzFfbXVyVgnILUWP0x6hj2bdYy1M7sKEye
         ByrErVRsVqoTPfIyMil6b9SUAZoLH6lOSHQAA8R0+g0OPKnQsDzA+XbNYQSvBb+APHsA
         3njBT4HhnTIEoOWMMtgoSKjEI+p4dEH2CfYe40gkhSv8OY9MUCba1u5l9ha7GmudRxbb
         oPiULMfLXsW8yBUoikog5rnofIfAGlL0SC2pdkJGeKSpVa+o9jjI0r6qGnvMQXsuBRVq
         6pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmUcPRO54/BdBaz9G6UqSudyCrbhUDL2nStrQrZ2ayU=;
        b=bCBf7DW1aLQSGOl553ZvroQPzPphaKeVgzgf4JjagOHuSnFjLwJTkWjpqCinO2uz5d
         XlC0QxTXAiyCYo7xMaNIVJRqrHEc39s4vnBb637Svr8T61wdldNzWe6GbYtRSXLHv5Sh
         N0qJ0f05j9M+3Wl3QEaYRUEddgCMgz1HbuYQCcZCklaoY9VtwdbmZP123lmVqf2TM4jr
         vD25xMxm0UyLuRLSAe5OIW45tOnchqurKrs3nIPY01CfvR4YR/UlL39bweV6vlqgvjl8
         Fy0mj0uf27fYF0rGDN+x3fbO0vyVFl4UWyj8FQJn+3WSdkBgozhC//ByiH3VAJs29pie
         tQJQ==
X-Gm-Message-State: APjAAAVGyLSTlyW/1eziCgfo0rumj+n1lpNRkmfJOfytLc3GrWWedrrw
        m0z2SwT1c6LvFPo+4olI4fPUvRrpk62J0PCbtALr77kx3eE=
X-Google-Smtp-Source: APXvYqzbxeEmcROhvFnBprdJHtLQlYXY339CR3OFYGi1rw+ZWTYiuoBaRB111DZ/FuU425FhGb32sPXRCM4MjTnIONQ=
X-Received: by 2002:a67:80d3:: with SMTP id b202mr1039381vsd.142.1580976667127;
 Thu, 06 Feb 2020 00:11:07 -0800 (PST)
MIME-Version: 1.0
References: <CAP22eLE2ro96aZymd3-b9HW6k2XAJeZGWBS5jRe+WU0pCJJFmQ@mail.gmail.com>
In-Reply-To: <CAP22eLE2ro96aZymd3-b9HW6k2XAJeZGWBS5jRe+WU0pCJJFmQ@mail.gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Thu, 6 Feb 2020 09:10:42 +0100
Message-ID: <CAGm1_ksLOtbu=PEOYfkzsckejLEUPyF1HRh1Xf--iaukPkwrTQ@mail.gmail.com>
Subject: Re: Is /dev/ttyACM0 of ATMEL serial CAN bus ?
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Lev,

On Thu, Feb 6, 2020 at 8:56 AM Lev R. Oshvang . <levonshe@gmail.com> wrote:
>
> Hi All,
>
> I decided to split my correspondence with Oliver to be very specific
> I have Atmel Chip  on DELL 3201 board with built-in CAN port , as well
> as LAN and  USB ports
>
> I followed Dell manual and run proposed command below
>
> > for i in /dev/ttyACM*; do udevadm info $i | grep -q 03eb_2404_USB_CAN_FD && echo "path:/dev/$(basename $i)"; done
>
> It prints the device
>  /dev/ttyACM0
>
> What is this device?
> Does it serve CAN port or USB port?
> Can I use it as a serial CAN  device?
>
> BTH, even kernel 5.3 does not have a configuration option for ATMEL CAN device.

DELL's description is very poor indeed. I would try something like
this just to verify whether this device can speak slcan:

sudo slcand -o -c -s6 /dev/ttyACM0 can0

See [1] for more information.

[1] https://elinux.org/Bringing_CAN_interface_up#SLCAN_based_Interfaces

Regards,
Yegor
