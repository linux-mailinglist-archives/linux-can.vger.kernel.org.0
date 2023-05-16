Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60170565F
	for <lists+linux-can@lfdr.de>; Tue, 16 May 2023 20:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEPSw5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 May 2023 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPSw5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2023 14:52:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3B27699
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1684263170; i=ps.report@gmx.net;
        bh=jTq5kdq+zfRlNlEARuF1H26BVja+yx6BoHB48XZAcHs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=QsRBXciLV94F2F0V419gM6GxRI78C7/QUIwURuR2Y3XWki5D9zHoJAQs7sGgBPhMJ
         eXdr8ZdKygnLrOhKaGBft8ok3Roe6JtW+E4LFR0EWf3ZsVF66hg268gdj5ThgqqGWQ
         DMR2HvZ1u3Fwq30nqWm7rIvQkXeZzGZ/MH75U1fYf0AWVz1Nev9egEjX84ReCqClPS
         +rFGY7zSL/PkiRP+/SYZhlCwiLqruur531gmbCvA4qGxvDuKKaA3D6n4MnE7gQ/+NT
         hI2AMrO9Rm7g+E/O5pnOOCElOANO8S58GG/IWoGQXD0eVIVlrGYZ5Mx3d1SRxUNeEv
         f+sD2RjM/PBJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.209.78]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1qGfZ71Pct-00srR4; Tue, 16
 May 2023 20:52:50 +0200
Date:   Tue, 16 May 2023 20:52:49 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Florian Ferg <flfe@hms-networks.de>
Subject: Re: Any update for the IXXAT USB-to-CAN adapters drivers?
Message-ID: <20230516205249.334acea3@gmx.net>
In-Reply-To: <20230515-salon-sherry-cabae5cf7c49-mkl@pengutronix.de>
References: <20230514151221.049873cb@gmx.net>
        <20230515-repurpose-essential-7f66fdcde4d5-mkl@pengutronix.de>
        <20230515-salon-sherry-cabae5cf7c49-mkl@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+3CQSDFboosR1Ths21rlSpYadpCx1cSA22Mr46pQBW2VAoVLsmY
 83D3W+TTnLAE8EH+k9MNLBjyPJqHDNsb2QvLRjGYq9QZW3LHub2Y8Uvbhv5wP2kIxIAMNB/
 uw7SBj1hbYxcXBXIvoZp7Fmj8NX15ZkbElc/0ENsdg7WorWpiqarG+LoHWT/6sN56JiiIzN
 6JFfhyyHck7wHVLfmqEEA==
UI-OutboundReport: notjunk:1;M01:P0:gk6emh6otoo=;zQ3ivRGJ83pu7QwksmvP0FHCoIC
 83AtITpY6VNgfl/DHiRv94qJVbhuqaSmwQJoCUojGI0GumryTiqW7RF+7GT/TqN5IIXxPOcZO
 OvtMX2CXKhppfiRZe5dkluz6rK6HV5x0uUSjMtJAv4vevTMIfbnK7f/GY2PjEbKK4bilBunlm
 m8c4wPP/d+G3Np4VgI00ZNpE8D5M3dqv/JOAf7UK4cjYVFhuNbiIbaQh5YlyK4usm8Gezvftd
 0VAieZkoJ/7BrnyUZUAazCg/FNfIRbHByICEj3DSsBv8ah+MmExQfb1oh9x0jYj4Xfi4FoaXN
 RKpSrfLyJwPfpcjxofctYNQxubtof4u2Vnf/7a2wUNt5/9fgyI96VxaEe7zjB0V5o0Ee8M+l0
 L9Yr7gkLYwfB1s3+CNJphIZ9askEfyt828whGANm/a0Ohr2iZVpzhM/MzEH+vX8lBdm2NWXbX
 o+ugEEhkFocXddy16vwgCaz5PY5EpIwOpUVNhQdVE5Q4Qb1P/RED1wyUR1BOu66FXgVS5BxLJ
 rGTjOsjJZwqcxDyxlmqzDQ13GL1f9aF76AoDW6GwA+8syO43ApJiWc15/FE2Hob6bNk/Tthzp
 win7ClxPVKC7ynWHUjrAgI6RLVL8bX2ECk6DyTnN2RLsldxaoA2LbvsUYIUvAss0FRCXbe204
 +BvE3y9ASLgw03eXTi3d/ktTHonYdsideZVfLp157ERmyl2a0df+wwFrMql+MwK9C4nxn/Rpo
 q71ICpbrQ6hMRINclenAMbOiBq+RZLFck+qenovKrSrMk79vjTXFgT+EnRrUbCsgKbzXxEu6d
 lKAWDPd1xC4NIgPu3aN37yKg+9BXzsSU73nP2+uFSYyD5yXq5WJ+TpK781/YATu2U/hik46Tl
 OM/ye5bZBU8FOpwIoJpuu84Xd5TlPHBU3p6lqXuse0XV4B73fP9KK1f7VzLGFG4kPv8QN1VEo
 L8nCMA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On Mon, 15 May 2023 23:32:09 +0200, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:

> On 15.05.2023 23:07:51, Marc Kleine-Budde wrote:
> > On 14.05.2023 15:12:21, Peter Seiderer wrote:
> > > does anybody know what happened with the IXXAT USB-to-CAN adapters d=
rivers
> > > attempts to bring the patches upstream?
> >
> > I think upstreaming starved due to lack of enough reviewing power in t=
he
> > community.
> >
> > > I found the following attempts
> > >
> > > - 'Re: [PATCH] can: usb: IXXAT USB-to-CAN adapters drivers' ([1] fro=
m June 2018)
> > > - '[PATCH v6] can: usb: IXXAT USB-to-CAN adapters drivers' ([2] from=
 Sep 2018)
> > >
> > > but now follow ups and/or references in the actual linux source
> > > tree...
> >
> > The newest I have in my archive is:
> >
> > | Date: Thu, 27 Sep 2018 16:04:43 +0200
> > | From: Florian Ferg <flfe@hms-networks.de>
> > | To: linux-can@vger.kernel.org
> > | CC: Florian Ferg <flfe@hms-networks.de>
> > | Message-ID: <20180927140443.29051-1-flfe@hms-networks.de>
> > | Subject: [PATCH v7] can: usb: IXXAT USB-to-CAN adapters drivers
> >
> > If you're interested to bring the driver mainline, I can forward you
> > that mail.

Thanks for investigation, in the meanwhile found all the missing
references up to v7:

  [PATCH] can: usb: IXXAT USB-to-CAN adapters drivers
  https://marc.info/?l=3Dlinux-can&m=3D152845162427920&q=3Dmbox

  [PATCH v2] can: usb: IXXAT USB-to-CAN adapters drivers
  https://marc.info/?l=3Dlinux-can&m=3D152996258423265&q=3Dmbox

  [PATCH v3] can: usb: IXXAT USB-to-CAN adapters drivers
  https://marc.info/?l=3Dlinux-can&m=3D153019414431266&q=3Dmbox

  [PATCH v4] can: usb: IXXAT USB-to-CAN adapters drivers
  https://marc.info/?l=3Dlinux-can&m=3D153113773029121&q=3Dmbox

  [PATCH v5] can: usb: IXXAT USB-to-CAN adapters drivers
  https://marc.info/?l=3Dlinux-can&m=3D153390928701300&q=3Dmbox

  [PATCH v6] can: usb: IXXAT USB-to-CAN adapters drivers
  https://marc.info/?l=3Dlinux-can&m=3D153596357327489&q=3Dmbox

  [PATCH v7] can: usb: IXXAT USB-to-CAN adapters drivers
  https://marc.info/?l=3Dlinux-can&m=3D153805714622658&q=3Dmbox

>
> ported (+ compile tested only) to recent net-net/main:
>
> https://lore.kernel.org/all/20230515212930.1019702-1-mkl@pengutronix.de/

Thanks for update (would have been my next task as I did something
similar for the latest upstream version [3] and a little bugfix [4])...

Will try your version the next days and take a look at the latest/new
review comments (and take a look at the differences of v7/v8 version
against the upstream version [5])...

Regards,
Peter

[3] https://codeberg.org/psreport/socketcan-linux-ix-usb-can/commit/c5464a=
c
[4] https://codeberg.org/psreport/socketcan-linux-ix-usb-can/commit/51b302=
1
[5] https://codeberg.org/psreport/socketcan-linux-ix-usb-can/commit/7c327a=
5

>
> Marc
>

