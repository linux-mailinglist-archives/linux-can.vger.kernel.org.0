Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8C687CC4
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBBL5z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBBL5y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:57:54 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA95BB86
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:57:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g68so1130270pgc.11
        for <linux-can@vger.kernel.org>; Thu, 02 Feb 2023 03:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsNZ7R/OOq4dVtO1Qmw9kAyKM8AdWJ+/ipZKZpCorMA=;
        b=KryFqyzAYKdf7GwdqD9Axqhgg/LNqAgNHPQu+qnpB9QhhOXckvO6z41Vq92xYppIUU
         0OsnFSdF5WcR6UkSOQCssitRePpXIoM/t0FKeZbErfv2V3O5sJ0qcS+EZUlEtq1aGK7z
         0ipwQsxfGIHvUIaq9K4t2d4rDCeyQaYCoZrcP/prPjV/uJygH6IczRIb11RDEKt0btdy
         oZE8eGrJGPwNRLucDZOQwdaN+AWlQITf8iNnqUaMtjjbM83Z87KZ3yxWX2EYIdSbG8B7
         QQglLyamIM4QYqH+8WoyeErxQ4OtV1lEjWvo2UT2XjNvlDYanJUIKZQWDQE2Jz16hWz8
         dmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsNZ7R/OOq4dVtO1Qmw9kAyKM8AdWJ+/ipZKZpCorMA=;
        b=tyX43A1LBg1k0jVsk3lC5V+WnWcvTXlQyL2v7sP8hCGnXZSEFQO+TdBNKosXKDZDMI
         WJZ5m/3GepnI9b4kRvb0UfMcn0zhu5GVu7rE/NhlBPd49A5v6vnMatTRDo0K/dl7XepR
         YveYp1qdlfPdUZDkVfUL4aL/KPijaPE0YhuhYLuDEucTI2MR9mB9e1WbpS62WJGNzRd9
         9Ra8iC/eRZ+rzQ6FhuceutIPFToQM0q0bAQTMPH/cLfiA2VweyifVcuUBenAnrLY5jx2
         Q85YDeCzOQugUySAasPt0bbxZB1SlNK2sYJMZFDVzzbYBo234iOtOpDG6dsaful8JnAe
         Ld+Q==
X-Gm-Message-State: AO0yUKUaUE2ig2kcy+zqL5a8/izeHR+V/c8M6ED5WUsI2Vpk8181BbfB
        cqecYLGS76xb/LyQJ5Iu+MwZUA8Ehk7Kj8nkJA0=
X-Google-Smtp-Source: AK7set+si3yDIrwHHihnVFtUH02WtxyeILnFBWQz4MLS74FzAlHD8D9WNK6GAu9zvbz9TiwPZRoeVXjwMlzTj5Apznw=
X-Received: by 2002:aa7:938e:0:b0:593:d7d7:17cb with SMTP id
 t14-20020aa7938e000000b00593d7d717cbmr1229595pfe.5.1675339072923; Thu, 02 Feb
 2023 03:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20230202110854.2318594-1-mkl@pengutronix.de> <20230202110854.2318594-15-mkl@pengutronix.de>
In-Reply-To: <20230202110854.2318594-15-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 2 Feb 2023 20:57:42 +0900
Message-ID: <CAMZ6Rq+5AKC2X+vNwbs0wvTGbx1zssF8tTS4TdhxnOH0=6nhrw@mail.gmail.com>
Subject: Re: [PATCH v2 14/17] can: bittiming: can_sjw_set_default(): use Phase
 Seg2 / 2 as default for SJW
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        kernel@pengutronix.de, Mark Bath <mark@baggywrinkle.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 2 Feb 2023 at 20:09, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> "The (Re-)Synchronization Jump Width (SJW) defines how far a
>  resynchronization may move the Sample Point inside the limits defined
>  by the Phase Buffer Segments to compensate for edge phase errors." [1]
>
> In other words, this means that the SJW parameter controls the CAN
> controller's tolerance to frequency errors compared to other CAN
> controllers.
>
> If the user space doesn't provide a SJW parameter, the
> kernel chooses a default value of 1. This has proven to be a good
> default value for CAN controllers, but no longer for modern
                    ^^^^^^^^^^^^^^^
> controllers.

Are you missing a word here? You oppose CAN controllers to modern ones.

I think the point is Classical CAN only controllers vs. CAN-FD
controllers. A CAN-FD controller is able to sample at bitrates up to 5
or 8 Mbits and have maximum bitimming values five or eight times the
ones of a Classical CAN only controller (which is only capable of
sampling 1 Mbits).

I propose this instead:

  This has proven to be a good default value for Classical CAN
  controllers, but no longer for modern CAN-FD ones.

> In the past there were CAN controllers like the sja1000 with a rather
> limited range of bit timing parameters. For the standard bit rates
> this results in the following bit timing parameters:
>
> | Bit timing parameters for sja1000 with 8.000000 MHz ref clock
> |                     _----+--------------=3D> tseg1: 1 =E2=80=A6   16
> |                    /    /     _---------=3D> tseg2: 1 =E2=80=A6    8
> |                   |    |     /    _-----=3D> sjw:   1 =E2=80=A6    4
> |                   |    |    |    /    _-=3D> brp:   1 =E2=80=A6   64 (i=
nc: 1)
> |                   |    |    |   |    /
> |  nominal          |    |    |   |   |     real  Bitrt    nom   real   S=
ampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   E=
rror  BTR0 BTR1
> |  1000000    125   2    3    2   1   1  1000000   0.0%  75.0%  75.0%   0=
.0%   0x00 0x14
> |   800000    125   3    4    2   1   1   800000   0.0%  80.0%  80.0%   0=
.0%   0x00 0x16
> |   666666    125   4    4    3   1   1   666666   0.0%  80.0%  75.0%   6=
.2%   0x00 0x27
> |   500000    125   6    7    2   1   1   500000   0.0%  87.5%  87.5%   0=
.0%   0x00 0x1c
> |   250000    250   6    7    2   1   2   250000   0.0%  87.5%  87.5%   0=
.0%   0x01 0x1c
> |   125000    500   6    7    2   1   4   125000   0.0%  87.5%  87.5%   0=
.0%   0x03 0x1c
> |   100000    625   6    7    2   1   5   100000   0.0%  87.5%  87.5%   0=
.0%   0x04 0x1c
> |    83333    750   6    7    2   1   6    83333   0.0%  87.5%  87.5%   0=
.0%   0x05 0x1c
> |    50000   1250   6    7    2   1  10    50000   0.0%  87.5%  87.5%   0=
.0%   0x09 0x1c
> |    33333   1875   6    7    2   1  15    33333   0.0%  87.5%  87.5%   0=
.0%   0x0e 0x1c
> |    20000   3125   6    7    2   1  25    20000   0.0%  87.5%  87.5%   0=
.0%   0x18 0x1c
> |    10000   6250   6    7    2   1  50    10000   0.0%  87.5%  87.5%   0=
.0%   0x31 0x1c
>
> The attentive reader will notice that the SJW is 1 in most cases,
> while the Seg2 phase is 2. Both values are given in TQ units, which in
> turn is a duration in nanoseconds.
>
> For example the 500 kbit/s configuration:
>
> |  nominal                                  real  Bitrt    nom   real   S=
ampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   E=
rror  BTR0 BTR1
> |   500000    125   6    7    2   1   1   500000   0.0%  87.5%  87.5%   0=
.0%   0x00 0x1c
>
> the TQ is 125ns, the Phase Seg2 is "2" (=3D=3D 250ns), the SJW is "1" (=
=3D=3D
> 125 ns).
>
> Looking at a more modern CAN controller like a mcp2518fd, it has wider
> bit timing registers.
>
> | Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock
> |                     _----+--------------=3D> tseg1: 2 =E2=80=A6  256
> |                    /    /     _---------=3D> tseg2: 1 =E2=80=A6  128
> |                   |    |     /    _-----=3D> sjw:   1 =E2=80=A6  128
> |                   |    |    |    /    _-=3D> brp:   1 =E2=80=A6  256 (i=
nc: 1)
> |                   |    |    |   |    /
> |  nominal          |    |    |   |   |     real  Bitrt    nom   real   S=
ampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   E=
rror      NBTCFG
> |   500000     25  34   35   10   1   1   500000   0.0%  87.5%  87.5%   0=
.0%   0x00440900
>
> The TQ is 25ns, the Phase Seg 2 is "10" (=3D=3D 250ns), the SJW is "1" (=
=3D=3D
> 25ns).
>
> Since the kernel chooses a default SJW of 1 regardless of the TQ, this
> leads to a much smaller SJW and thus much smaller tolerances to
> frequency errors.
>
> To maintain the same oscillator tolerances on controllers with wide
> bit timing registers, select a default SJW value of Phase Seg2 / 2
> unless Phase Seg 1 is less. This results in the following bit timing
> parameters:
>
> | Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock
> |                     _----+--------------=3D> tseg1: 2 =E2=80=A6  256
> |                    /    /     _---------=3D> tseg2: 1 =E2=80=A6  128
> |                   |    |     /    _-----=3D> sjw:   1 =E2=80=A6  128
> |                   |    |    |    /    _-=3D> brp:   1 =E2=80=A6  256 (i=
nc: 1)
> |                   |    |    |   |    /
> |  nominal          |    |    |   |   |     real  Bitrt    nom   real   S=
ampP
> |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   E=
rror      NBTCFG
> |   500000     25  34   35   10   5   1   500000   0.0%  87.5%  87.5%   0=
.0%   0x00440904
>
> The TQ is 25ns, the Phase Seg 2 is "10" (=3D=3D 250ns), the SJW is "5" (=
=3D=3D
> 125ns). Which is the same as on the sja1000 controller.
>
> [1] http://web.archive.org/http://www.oertel-halle.de/files/cia99paper.pd=
f
>
> Cc: Mark Bath <mark@baggywrinkle.co.uk>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/bittiming.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittim=
ing.c
> index 68287b79afe8..55714e08ca3a 100644
> --- a/drivers/net/can/dev/bittiming.c
> +++ b/drivers/net/can/dev/bittiming.c
> @@ -11,8 +11,8 @@ void can_sjw_set_default(struct can_bittiming *bt)
>         if (bt->sjw)
>                 return;
>
> -       /* If user space provides no sjw, use 1 as default */
> -       bt->sjw =3D 1;
> +       /* If user space provides no sjw, use sane default of phase_seg2 =
/ 2 */
> +       bt->sjw =3D max(1U, min(bt->phase_seg1, bt->phase_seg2 / 2));
>  }
>
>  int can_sjw_check(const struct net_device *dev, const struct can_bittimi=
ng *bt,
