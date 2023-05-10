Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE06FDB38
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 12:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjEJKCq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjEJKCp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 06:02:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972046189
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 03:02:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52c759b7d45so6344512a12.3
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683712964; x=1686304964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9D0S88IIYzfUiqQPISifXo0f99UzcXHuWmqP6BHueQ=;
        b=BnZ6ShH96DCmZyDXHJv/KN2BllXXNkNO59pw6PAx+YiR48cg+A+jBObBsIjgWA2Vpg
         PzcmrP8ZRZGrzxr23RsFyAesYXo8eBz7Wzk9fPr6l5hRuvOnX6gpTJxdizP2viBXQXKe
         HM40owiU253N+AiO+jCcoRDllW80U438c7/8XS4sXpvDakAPR3o4kjB5x6Dm7vwysRc5
         JzYl9N+urH9X85ZDP2DmD032hLl/RMUmOZJ+l6Ct0mP0HeTFpHuPE0j7KmSammU6Xpqq
         ikClsSOk9LJkjVZOp8ky5zxVcW8ENhTgYjEKbwl0qyqhvd7q+NsrFg6qHgMaUNJorCiy
         i0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683712964; x=1686304964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9D0S88IIYzfUiqQPISifXo0f99UzcXHuWmqP6BHueQ=;
        b=DKbYwSBuox8M3hmdtbxK3RoY7mbDTl9g6/zrcQgky1wXZnqyLta6QBrNIttM3SrqUr
         +bCnqvMhx8RNpVtEUn8aVJlL4Z6itULyVhKnNj2CEtC+/A6BoPxnl/DHuO8A3/dTZ7pI
         RyCNH25P+a3C+RbL/EZNXheFSqIlWqYViK6J84mrbrzN5Azcg1TXDbdOGDd8OTXv2nYq
         v3mSpH8fwGBqCR89HXEJHcULKqWHYpnZxLw2nj+aPn/gHo7dWUS5a3zLB6En+AT0omhX
         arENwjEjwMJI2pRjZFmCWJEwrF0C3Soa6P1BUrw7nqqlddCps3MPbwE998ch1kg9DnDA
         qOqg==
X-Gm-Message-State: AC+VfDyxp588CRxUlLhMQqOzUH8qUnmamwpr2QqmStKXxiZT8YL0OJI6
        4RdCxnRS+6yMyR/OpH5cbusewBKCNDyISfVxo1w=
X-Google-Smtp-Source: ACHHUZ4O6oLuzPS8AF7edxztOFxSS2ud+UAgvhMGyOTESAjgiXOU/n34Z91WGUXa0ZTdc8AIn78WfPDaDz4PE3A92QI=
X-Received: by 2002:a17:90b:28b:b0:246:9ef5:3c45 with SMTP id
 az11-20020a17090b028b00b002469ef53c45mr17661090pjb.13.1683712963840; Wed, 10
 May 2023 03:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230504195059.4706-1-marex@denx.de> <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com> <BL3PR11MB64843D32844A848AAC7BFDF1FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB64843D32844A848AAC7BFDF1FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 10 May 2023 19:02:32 +0900
Message-ID: <CAMZ6RqK266c+taxgUqd_2kSfbNDgTawkcthTaM+4JXpeLV0cfQ@mail.gmail.com>
Subject: Re: RE: [PATCH] can: mcp251xfd: Increase poll timeout
To:     Thomas.Kopp@microchip.com
Cc:     mkl@pengutronix.de, marex@denx.de, linux-can@vger.kernel.org,
        fedor.ross@ifm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, lgirdwood@gmail.com, mani@kernel.org,
        broonie@kernel.org, pabeni@redhat.com, wg@grandegger.com
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

Le mer. 10 mai 2023 =C3=A0 18:18, <Thomas.Kopp@microchip.com> a =C3=A9crit =
:
>
> > On Wed. 10 May 2023 at 15:30, <Thomas.Kopp@microchip.com> wrote:
> > >
> > > > > On 05.05.2023 07:07:03, Thomas.Kopp@microchip.com wrote:
> > > > > > > The datasheet "MCP25xxFD Family Reference Manual" says it nee=
ds
> > an
> > > > idle
> > > > > > > bus.
> > > > > >
> > > > > > Technically what's needed is an idle condition on the bus as sp=
ecified
> > > > > > in the ISO. i.e. 11 consecutive sampled recessive bits after a =
full
> > > > > > frame (if one is currently in transmission).
> > > > >
> > > > > Right. What happens if another CAN frames comes before there are =
11
> > > > > consecutive sampled recessive bits? The IFS for CAN is 3 bits?
> > > >
> > > > Not quite. Between the Frames is an IFS that's correct but the IFS =
consists
> > of
> > > > an Intermission which is 3 bits long + a bus idle condition of 11 b=
its. Regular
> > > > frames have to wait for the IFS to elapse BUT there's an exception =
for error
> > > > frames and overload frames. EF may be up to 12 bit, OF are 8 domina=
nt + 8
> > > > recessive bits, browsing through the spec I think only 2 OFs can ha=
ppen
> > > > consecutively. Adding another 32 bits to the formula should cover t=
his.
> > >
> > > Re-reading the spec again I noticed that the part where I wrote
> > > that there's an "idle condition" after the intermission is
> > > wrong. What follows the intermission is just "bus idle",
> > > defined two paragraphs later as "The period of bus idle may be
> > > of arbitrary length." The 11 recessive bits can be removed from
> > > the formula again. The longest period (under the assumption
> > > there aren't multiple/continuous errors on the bus) will be
> > > Frame + Error Frame (12 bit) + 2 x Overload Frame.
> >           ^^^^^^^^^^^^^^^^^^^^
> >
> > How did you find that a error frame is 12 bits? From section 10.4.4
> > "Specification of EF", I can read:
> >
> >   The EF shall consist of two different fields. The first field
> >   shall be given by the superposition of error flags contributed
> >   from different nodes. The second field shall be the error
> >   delimiter.
> >
> > Then:
> >
> >   Two forms of error flag may be used, the active error flag and
> >   the passive error flag, where
> >
> >    - the active error flag shall consist of 6 consecutive
> >      dominant bits, and
> >
> >    - the passive error flag shall consist of 6 consecutive
> >      recessive bits unless it is overwritten by dominant bits
> >      from other nodes.
> >
> > Finally:
> >
> >   The error delimiter shall consist of 8 recessive bits.
> >
> > So the error frame should be 14 bits (6 + 8), not 12, right?
> That was imprecise, you're right - I meant an Error Flag, not Frame and h=
ence the 8 recessive bits were missing. There's an active error flag + pass=
ive error flag though which can be 6 bits long each. In section 10.4.4.2 Th=
e total length of this sequence may vary between a minimum of 6 bit and a m=
aximum of 12 bit.

The active error flag and the passive error flag may both occur, but
in that case, they occur as a superposition (c.f. above quotation).
This also means that the passive error flag is seen if and only if all
the nodes send a passive error flag. As long as one node sends an
active error flag, the superposition will hide any other passive error
flag.

So, I think that the error flag is always 6.

> > For the great total, if you want the absolute worst case, you should
> > consider that:
> >
> >   - The error frame may start at any point. For example, you may
> >     observe the first two bits of the intermission and have it
> >     broken by an error frame. It may also appear in the middle of
> >     a data frame. So you may consider cases such as: partial
> >     frame + error frame + intermission + frame + ...
> >
> >   - The overload frame is required to "destroy the fixed form of
> >     the intermission field". So even if not explicitly specified,
> >     I think that overload frame may start after the second
> >     recessive bits of the intermission, e.g. frame + 2 bits of
> >     intermission + overload frame + 2 bits of intermission +
> >     overload frame + full 3 bits intermission
> >
> >   - An error frame or an overload frame may trigger another error
> >     frame if a node does not correctly receive one of the bits in
> >     the fixed form delimiter. The only exception is the last bit
> >     of that delimiter (c.f. section 10.11 "Error detection"
> >     paragraph d) "Form error"). In other words, you can have
> >     the two overload frames, then an error frame, then two
> >     overload frames again.

Correcting myself: that last example was invalid. There are at maximum
two overload frames before the next data or remote frame. So the
presence of an error frame should not reset the overload frame count.

> > This is to say that the worst case scenario is just not something
> > worth consideration.
>
> ACK
> > The assumption that only one error frame occurs is pretty arbitrary. I
> > would suggest making it simpler and simply ignore error and overload
> > frames. As long as frame + intermission works well in empirical tests,
> > I would suggest to stay with that and call it a day.
>
> Correct, that's why I wrote: (under the assumption there aren't multiple/=
continuous errors on the bus) but I agree that's a pretty arbitrary limit. =
So I'm fine with changing it to one or two full-sized frames + intermission=
)

ACK. At the end, you have the hardware, so you should decide what is
the best delay to fix the issue. I just hope that my message was
helpful to simplify the formula.

> Best Regards,
> Thomas
