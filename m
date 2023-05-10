Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D204B6FD891
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEJHuk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjEJHui (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 03:50:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4EDCD
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 00:50:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aad6f2be8eso64648125ad.3
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683705036; x=1686297036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rss2CDu36G4nVdoielyfkOlJ+bigdSILIh4+JnaMfw=;
        b=Et/HL8uuBR/VTXc1PU56x/xR8gKRkV9Qf2LN/jkMc8qtnBJJaMyk5EzwveYAJMcS0y
         s8OL6y9LaW03XS3CQ61iWi9qTWVzNAEftTIKijpwVEB38DTPJ5lmLFZdjjfJZl3XrKur
         mO/g5D8g67TRM9qI4RZ4sF4vmxhFwWxNMplvxRiKpElfZHmbFNzGP6vAkK4MgldnGESG
         9hn6i/PdKrkbBg+kukbstOta11FOiPNSM7kde3orJJu4c9x3M1G5gF2JSnKUeQKzL5kV
         Xj0mocHOy7KsB/8Zbhp08Koqdbw5stQhTLRewJYH9koBqXoNj5cXtaHoc0UKGplLEqql
         m+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705036; x=1686297036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Rss2CDu36G4nVdoielyfkOlJ+bigdSILIh4+JnaMfw=;
        b=JgIbTpDVz5aLfu4d7LsiuXTh1NMSHwR+EG+xNCoKjWxNb5g2C72jGXWtVr94t67GjF
         qbxBtAcdkKCVQDqTVZ3OkPRwzylyhdwa79a4Yx9//P8YMabeMOPO9ViljG9IgyDwLfPm
         uTYLxLro/qVt4l5II0+QgPKSnbNZ6hauZzEoaWEe2eAZA7CD0gV3gVM6Bx3nGmzFr+Hj
         665tORUEbKMGbl6HAXICzmyUWy4aV01p+CIiyYuuegRS511i/GZSz3XPGujc/MFiFors
         3Z3Tf5Z1Te6fQEKW4xnawbrDtu9/rDKEnMEVkAT5yFESN7TWabdUW/qibcyUgf33Vc4q
         vLgg==
X-Gm-Message-State: AC+VfDxNI7/eetPgqt9Q1qGY9D8gtAxHGK1kutDPrEQFH7MBWkcpWkIE
        WaznjT/QuTZT6FQhOdklSFtb9DnL7zsLig29M7E=
X-Google-Smtp-Source: ACHHUZ6XdbNjcyRgScBrwXBrN1N8UwvsfTOFSQ2NZCEbD+l154OVapOgaITO7OcYk33UTEMr3G/AbvEIzbuR0PVKGR0=
X-Received: by 2002:a17:902:db0e:b0:1ab:12cf:9e1c with SMTP id
 m14-20020a170902db0e00b001ab12cf9e1cmr19774775plx.32.1683705035994; Wed, 10
 May 2023 00:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230504195059.4706-1-marex@denx.de> <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 10 May 2023 16:50:24 +0900
Message-ID: <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com>
Subject: Re: RE: [PATCH] can: mcp251xfd: Increase poll timeout
To:     Thomas.Kopp@microchip.com
Cc:     mkl@pengutronix.de, marex@denx.de, linux-can@vger.kernel.org,
        fedor.ross@ifm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, lgirdwood@gmail.com, mani@kernel.org,
        broonie@kernel.org, pabeni@redhat.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 10 May 2023 at 15:30, <Thomas.Kopp@microchip.com> wrote:
>
> > > On 05.05.2023 07:07:03, Thomas.Kopp@microchip.com wrote:
> > > > > The datasheet "MCP25xxFD Family Reference Manual" says it needs an
> > idle
> > > > > bus.
> > > >
> > > > Technically what's needed is an idle condition on the bus as specified
> > > > in the ISO. i.e. 11 consecutive sampled recessive bits after a full
> > > > frame (if one is currently in transmission).
> > >
> > > Right. What happens if another CAN frames comes before there are 11
> > > consecutive sampled recessive bits? The IFS for CAN is 3 bits?
> >
> > Not quite. Between the Frames is an IFS that's correct but the IFS consists of
> > an Intermission which is 3 bits long + a bus idle condition of 11 bits. Regular
> > frames have to wait for the IFS to elapse BUT there's an exception for error
> > frames and overload frames. EF may be up to 12 bit, OF are 8 dominant + 8
> > recessive bits, browsing through the spec I think only 2 OFs can happen
> > consecutively. Adding another 32 bits to the formula should cover this.
>
> Re-reading the spec again I noticed that the part where I wrote
> that there's an "idle condition" after the intermission is
> wrong. What follows the intermission is just "bus idle",
> defined two paragraphs later as "The period of bus idle may be
> of arbitrary length." The 11 recessive bits can be removed from
> the formula again. The longest period (under the assumption
> there aren't multiple/continuous errors on the bus) will be
> Frame + Error Frame (12 bit) + 2 x Overload Frame.
          ^^^^^^^^^^^^^^^^^^^^

How did you find that a error frame is 12 bits? From section 10.4.4
"Specification of EF", I can read:

  The EF shall consist of two different fields. The first field
  shall be given by the superposition of error flags contributed
  from different nodes. The second field shall be the error
  delimiter.

Then:

  Two forms of error flag may be used, the active error flag and
  the passive error flag, where

   - the active error flag shall consist of 6 consecutive
     dominant bits, and

   - the passive error flag shall consist of 6 consecutive
     recessive bits unless it is overwritten by dominant bits
     from other nodes.

Finally:

  The error delimiter shall consist of 8 recessive bits.

So the error frame should be 14 bits (6 + 8), not 12, right?



For the great total, if you want the absolute worst case, you should
consider that:

  - The error frame may start at any point. For example, you may
    observe the first two bits of the intermission and have it
    broken by an error frame. It may also appear in the middle of
    a data frame. So you may consider cases such as: partial
    frame + error frame + intermission + frame + ...

  - The overload frame is required to "destroy the fixed form of
    the intermission field". So even if not explicitly specified,
    I think that overload frame may start after the second
    recessive bits of the intermission, e.g. frame + 2 bits of
    intermission + overload frame + 2 bits of intermission +
    overload frame + full 3 bits intermission

  - An error frame or an overload frame may trigger another error
    frame if a node does not correctly receive one of the bits in
    the fixed form delimiter. The only exception is the last bit
    of that delimiter (c.f. section 10.11 "Error detection"
    paragraph d) "Form error"). In other words, you can have
    the two overload frames, then an error frame, then two
    overload frames again.

This is to say that the worst case scenario is just not something
worth consideration.

The assumption that only one error frame occurs is pretty arbitrary. I
would suggest making it simpler and simply ignore error and overload
frames. As long as frame + intermission works well in empirical tests,
I would suggest to stay with that and call it a day.
