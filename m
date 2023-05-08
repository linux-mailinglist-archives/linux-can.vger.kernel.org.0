Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77C6F9E82
	for <lists+linux-can@lfdr.de>; Mon,  8 May 2023 06:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjEHEBn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 May 2023 00:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEHEBm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 May 2023 00:01:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E20658C
        for <linux-can@vger.kernel.org>; Sun,  7 May 2023 21:01:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6439f186366so1926218b3a.2
        for <linux-can@vger.kernel.org>; Sun, 07 May 2023 21:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683518491; x=1686110491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGN2OPB6vnt4EBjW5//SDguIFQjmLPStt7G4b8aPU8U=;
        b=cjxXDj+SDRdaX57k0jmFwt2pYO5AW/Lu9UaFnCcmu1oW6yLojTWVJL/z6ux8CpdFnc
         BYG4W3xj8aJ65sYfUu9zZ3ShO5KGtYL2mfU6/iyOeVuk1A+yJNRF1f4zKkaLGqU1QOox
         fF3eBsRVghjb82ak+ZrjFXnBZvnW6vPbOLPPmwJFa9jSxqlG9wi6zcACpNFEroJdk20Q
         Vx2yJIeZdbuygXrBOOHbzz1jLQqY9+bCAUaB36bblEOYgzvHht65dMJ/q4TjkP2iSXJJ
         9/OFJ0uVeL9xLQ7eK2cdq8KR2DbXXzPQsjb49avGt6p5PEybnD1P4rEU5Nff0WaQKG6F
         Leig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683518491; x=1686110491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGN2OPB6vnt4EBjW5//SDguIFQjmLPStt7G4b8aPU8U=;
        b=GQKwtMNegtycGVWcW1NTP6uGykWC8OweRumbvTdsWuZ7NmuzwbzxLdgfsQ9Bt6NA7C
         yVig3ozY2sXipQ4rzoAY4DHROA2sNNzG6yltbgus9pzlJCqeBESVB+geO5TzZQCoG0dA
         Q8XSnzzJ2es3DSph0KCFzxnAmleWCnDxByK3YyRif8IdgJcTyWJVKfS5VGelD7jqE04g
         TO8nQzsNFkJFvzFY6qPs3taGst5FlG5TszVFQFp3K6Bwgn0d1sEfEoWwT5NHajTTs9TX
         k6pfa6L5kuI1sEDtThAEhEyxrPbZzWMXWXLSUlJEl01rGCjZBhhHWqU13NHqvjUbq2tW
         NHyQ==
X-Gm-Message-State: AC+VfDyWjJSy+7KskcjVlmNL37RjlwUdNrGXJIeaJ8NvwqjC/OQ00wKp
        XJO50hv1ZEmBUQ3jlfS4E/qhrTlYJwYLUpNafXc=
X-Google-Smtp-Source: ACHHUZ73nh7lH+fnx+gicwYT52B57RD4+Tzg+O9f7v5lSpzqjlNM0w0V99kPreVio07O67+ypJ9MFlrxmJUImcYEeGI=
X-Received: by 2002:a05:6a20:2585:b0:f0:7ac1:ea61 with SMTP id
 k5-20020a056a20258500b000f07ac1ea61mr12436282pzd.6.1683518490875; Sun, 07 May
 2023 21:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230505222820.126441-1-marex@denx.de> <CAMZ6RqKYVJP-_Qdmj3pSAft5fsQtTK5HTsfRv+LsYwa4ngKMrQ@mail.gmail.com>
 <477f68d1-ee90-be54-586f-306f479f8694@denx.de>
In-Reply-To: <477f68d1-ee90-be54-586f-306f479f8694@denx.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Mon, 8 May 2023 13:01:19 +0900
Message-ID: <CAMZ6Rq+Deh6MypKKPG+mkXSzu_s-3siChjA_8w=WXcgfrVXEdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: mcp251xfd: Increase poll timeout
To:     Marek Vasut <marex@denx.de>
Cc:     linux-can@vger.kernel.org, Fedor Ross <fedor.ross@ifm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Le lun. 8 mai 2023 =C3=A0 04:20, Marek Vasut <marex@denx.de> a =C3=A9crit :
>
> On 5/7/23 17:58, Vincent Mailhol wrote:
> > Hi Marek,
>
> Hi,
>
> > The patches should have been in reverse order:
> >
> >    1st: can: mcp251xfd: Move generic macros into length.h
> >    2nd: can: mcp251xfd: Increase poll timeout
> >
> > so that you do not have to remove the lines just added in the previous =
patch.
>
> The current order is actually deliberate to make it easy to backport
> this one patch via stable queue, since it Fixes: a bug. The 2/2 is just
> a generalization.

I see your point. However, your patch uses CANFD_FRAME_LEN_MAX which
was introduced in Linux 5.12 but mcp251xfd was introduced in 5.10. So
you will need a separate patch for the 5.10 LTS branch.

As for the other stable branches (5.15 and greater), patches toward
linux/can/length.h can easily be backported. To conclude, in that
particular instance, I think that the correct approach is:

 - One separate mcp251xfd patch for 5.10.
 - A pair of patches targeting mcp251xfd and length.c for 5.15+

> > On Tue. 6 May 2023 at 07:36, Marek Vasut <marex@denx.de> wrote:
> >> From: Fedor Ross <fedor.ross@ifm.com>
> >>
> >> Make `MCP251XFD_POLL_TIMEOUT_US` timeout calculation dynamic. Use
> >> maximum of 1ms (arbitrarily chosen during driver development) and
> >> bit time of one full CANFD frame including bit stuffing and bus idle
> >> condition sample cycles, at the current bitrate. This seems to be
> >> necessary when configuring low bit rates like 10 Kbit/s for example.
> >> Otherwise during polling for the CAN controller to enter
> >> 'Normal CAN 2.0 mode' the timeout limit is exceeded and the
> >> configuration fails with:
> >>
> >> $ ip link set dev can1 up type can bitrate 10000
> >> [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode =
CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=3D0x068b0760, osc=
=3D0x00000468).
> >> [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c=
 (length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> >> [  731.938101] A link change request failed with some changes committe=
d already. Interface can1 may have been left with an inconsistent configura=
tion, please check.
> >> RTNETLINK answers: Connection timed out
> >>
> >> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xx=
FD SPI CAN")
> >> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
>
> [...]
>
> >> @@ -251,7 +252,12 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_=
priv *priv,
> >>                                         FIELD_GET(MCP251XFD_REG_CON_OP=
MOD_MASK,
> >>                                                   con) =3D=3D mode_req=
,
> >>                                         MCP251XFD_POLL_SLEEP_US,
> >> -                                      MCP251XFD_POLL_TIMEOUT_US);
> >> +                                      max(MCP251XFD_POLL_TIMEOUT_US,
> >> +                                          (unsigned int)(CANFD_FRAME_=
LEN_MAX *
> >> +                                           BITS_PER_BYTE *
> >> +                                           CAN_BIT_STUFFING_OVERHEAD =
+
> >
> > The goal is to have the exact number of bits, right?
>
> Not really, the goal is to calculate a suitable delay, for which the
> kernel has to wait for this SPI CAN controller to switch mode . That
> delay is dependent on the bit timing though.

Ack. In that sense, the above formula is indeed suitable. Regardless,

  CANFD_FRAME_LEN_MAX * BITS_PER_BYTE

expands to:

  (DIV_ROUND_UP(80, 8) + 64) * 8

and that confuses me a lot to divide and then just multiply again by
the same value.

> > It seems odd to me to use a rounded value and then try to recalculate
> > the exact length in bits.
> > I understand that because CANFD_FRAME_OVERHEAD_EFF is a multiple of
> > BITS_PER_BYTE, CANFD_FRAME_LEN_MAX happened to be the exact value.
> > Regardless, that is a fluke.
> >
> > I think that we should have another set of definitions for the frame
> > lengths in bits. I sent a proposal here:
> >
> >   https://lore.kernel.org/linux-can/20230507155506.3179711-1-mailhol.vi=
ncent@wanadoo.fr/
> >
> > If you like it, you can rebase this patch on top of mine and use the
> > newly defined CANFD_FRAME_LEN_MAX_BITS_STUFFING.
>
> I think I don't have enough experience to decide one way or the other,
> so I will wait for the reviewers to suggest the course of action.

ACK. I am fine with delegating the final decision to others.
