Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE64C7E6E9
	for <lists+linux-can@lfdr.de>; Fri,  2 Aug 2019 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390483AbfHAXt5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Aug 2019 19:49:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35542 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbfHAXt4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Aug 2019 19:49:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so51534441lfa.2
        for <linux-can@vger.kernel.org>; Thu, 01 Aug 2019 16:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=capp-tech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9BSF2Y8qNdGXlBBRfluRgRErzVgWR0aGyXgFsakMao=;
        b=pwiIVmM9O2qnrsVxT1xXWoiKAQpUNxvKO7TkiW04t+2qihb1DccHNMVBHN+BJEuSHp
         lpqPOTZrGf9R9w6KOisRh2fhgMOPmiNRO4CZAUyswX+/cE+oHKNlTMi1Ke4nkTVlOIOf
         7B3xSUoWo/mASJLEspgXI8fVJcq+RhY/iAYSagyBwsgYE2BV+7/82OGol3s0XCW4f80f
         Y/oOERgRua6H1lTiWenh8d9GskE4+6vPBMMvlcxa5pBefEGrzFEEnpBdCGNc0R2IsgPo
         QxRSGmRzEX2qLHWk+k2bZmmTl5xZxxs4tisUXmGiEPw/jGAEPJmQY43BjbfoQ9I6hgJM
         elCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9BSF2Y8qNdGXlBBRfluRgRErzVgWR0aGyXgFsakMao=;
        b=BH0MgawVngqoIKTcnWtimmtdQB/CJT1J/aUrzQgSTLX/Ji1DjDp33AG4jMoRe3q4gP
         NVLHP99Okyx2EsFUwba/xwpUoCiIJwqZEHfg3EGAzf8caR3/x8m6tTEE865cQ8PRdsGd
         6BLzHBjc8jkMUErH3JcLo/CMPAw8oTq3N3nu3N9NpW9IxGgTqG+ojTk8g4tFtdmTwSs/
         M+smKNJiJ1Jcye4E/elhf2LpHI6nE8L1jWJ15vK8cm5scMK1SixGuZhyASwECtrriHBU
         06MBOl0KXf/DGdItKwgJePQMoGq6Prlz4r1ky0J3eLCTBkqLJ3+ZnANjTiKTx4D2hpGm
         wsYQ==
X-Gm-Message-State: APjAAAX0zgKGwy7o4NXTHhpS6YcldIQTRpidqFdP+PyV7X3aQxcJP9QK
        8GRodE02hU89v/eLU/U5CkIpT6BQqUNhB1iKNyQW8A==
X-Google-Smtp-Source: APXvYqwDwmZaSG4EDOi+E6WwzKU9S0uFsMQlJh2yD09CiXpo+dFkE+9je1uGbatLL/RPnefA3sLyf9mN2/DOp4AoRcc=
X-Received: by 2002:ac2:4109:: with SMTP id b9mr56884707lfi.31.1564703395111;
 Thu, 01 Aug 2019 16:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANRGksgbzcwt+XYNbZNrRMy=MXrT4WjXXW814=xYUgiJG+9twA@mail.gmail.com>
 <e4b4d4ea-735c-fa26-3c19-369b1e19b9f7@hartkopp.net> <4a7e43fc-dce5-218c-6ebf-85e48ee42936@pengutronix.de>
In-Reply-To: <4a7e43fc-dce5-218c-6ebf-85e48ee42936@pengutronix.de>
From:   Tom Prohaszka <tprohaszka@capp-tech.com>
Date:   Thu, 1 Aug 2019 19:49:44 -0400
Message-ID: <CANRGkshBMbe+JHr0Ya4fZ5L06UQpdJ5ScAc3Xpc-yYsmw1X1EA@mail.gmail.com>
Subject: Re: Disable Network Statistics - CAN
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I found this for the V5 commit:
https://www.spinics.net/lists/linux-can/msg00847.html
I may have read it wrong.  It sounds like the network stack is
dropping them, not necessarily the "statistics" gathering.

Still the driver is able to handle reception of 99.95% of all CAN frames
of a 100% saturated 1MHz Can2.0 Bus with Frames with standard IDs and
DLC=0 on a Raspberry Pi 3. Note that this statistics is without injection
into the network stack, which then drops about 60% of all frames.

On Wed, Jul 31, 2019 at 10:16 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 7/31/19 3:38 PM, Oliver Hartkopp wrote:
> > Hi all,
> >
> > On 31/07/2019 03.49, Tom Prohaszka wrote:
> >> We are using the MCP25xxfd driver.  A comment in the code indicated
> >> that during testing, the network statistics were disabled to achieve
> >> high utilization of the CAN bus.  Another comment indicated that when
> >> network statistics were re-enabled, a 60% decrease in throughput
> >> occurred.
>
> Can you point me to these comments?
>
> >> My question is, how can we disable the network statistics for CAN, and
> >> if not possible for CAN, globally.
> >
> > there seem to be tons of MCP25XXFD_DEBUGFS_STATS_*() macros.
>
> I'm not sure that incrementing some counters will cause a performace
> degration of 60%.
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c?h=mcp25xxfd&id=9b2ffbb925a0c32ea064c0a91b6bacb33d5e877a#n131
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.h?h=mcp25xxfd&id=9b2ffbb925a0c32ea064c0a91b6bacb33d5e877a
> >
> > We had to purge all the debug stuff when mainlining the CAN subsystem
> > and I wonder if this is really NEEDED.
> >
> > When the driver is in mainline Linux we can assume it to work - and not
> > to be debugged anymore.
> >
> > Additionally the CAN_DEBUG_DEVICES Kconfig option could have been used
> > to debug potential pitfalls.
> >
> > IMO the debugfs stuff should be removed completely.
>
> Or at least make it a per driver option.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
