Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6EA5747F7
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiGNJMw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGNJMw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 05:12:52 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D8F237F2
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 02:12:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l11so2107220ybu.13
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e6whZqaZ9K78hxHV3lLGAsxfJFOaRKwmKBfYthMKXpE=;
        b=oC1JzjmJAbydSeWS4fSinJPU7wrKyETDZ6KLmwPpI9OQ9eGxxdaF3QFAdYn9/6IvAu
         KxIvP4zJ8J4JVzEw0feKHso9l4QUileyz5u3hyEL1D2u05Q0Z2l/UWhAj1q6ForxOHBn
         zkNuo+08U5lRBPmfoC3HGCJFpmY4+V4JqDJZ+7x0S7XnW4VLE3l5Msxu5rKxHpk+LC7B
         qmj4PSAIrOw8nUMDVZ2UKzWqKOOg1PcM4KS82PUNLYJbqm8Dvhl95A0LbDUiQsMNU5pz
         E56h8BHItbyDGnTtDBi9oG83OegNI9f7UzLiiBPtDEKEYzZqfpNa+Q8hOyby4+jPD11D
         RcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e6whZqaZ9K78hxHV3lLGAsxfJFOaRKwmKBfYthMKXpE=;
        b=MBvxyl/p5wxGCxlhpmHxr8qIOUMCyGBM6LjQnUplY7RRRb6fpHYu0hA9k+wEAXvobd
         dSWIBvK7UfU+XRjL353BfMF9096yNWZdEbx7ant2Ed65HTf3fx/cqhnfrhQgx5PlAN1C
         gRY0M52qG2htXrAYv0f2DW97gWMUch+IZXuqg1PyaWW9QSEy+koT4jQwhljoADcqnd1i
         hLW6IS1czXm5nuA6uch5sBHT7jiS7oRcX6oY09RgjavR00glEtoH+/GT7qkx8AOOAxu+
         s2fGZEb5Wx66tDjWWjQHcIbxitYbvxKJdVwTEaLySRRQBKooLDSzP4Qv3N/m6w4Vxnih
         1AKg==
X-Gm-Message-State: AJIora/pEqEFU1HPPT4DJPexqC8r3uc7nd9NJfxSMKQGN5fcn0/L2PPi
        Yyter04IXG9GpIH1iMMXHZ2W3QI7djnC/Mh0Ha8aZ7NUWt8=
X-Google-Smtp-Source: AGRyM1urPyzgRK1Yw+W6FDeRa2wzKxkkVymLC3ibk2YpZ71XB6dcvAgA+EpITo1QTy151vgCFdonA8BBouVBsg14uJA=
X-Received: by 2002:a25:34d0:0:b0:66e:255a:c195 with SMTP id
 b199-20020a2534d0000000b0066e255ac195mr7887200yba.151.1657789970153; Thu, 14
 Jul 2022 02:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net> <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net> <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
 <521fe0a3-a9ad-60ac-3ec6-30f0da228032@hartkopp.net> <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
 <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net> <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
 <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net> <CAMZ6RqLGWB-afDmZfV+qJU2g=XUycFS1o9j6EwqRVg_dyf4eOw@mail.gmail.com>
 <16457321-6a4f-4830-17aa-d6efd7a39555@hartkopp.net> <CAMZ6RqLSHAdB-ocj7=74zJqWbv-EH9x8X5ARPK6Gv+FFiTZ7Lg@mail.gmail.com>
 <ae995ec1-8dbd-7484-a250-28d8637eb6ff@hartkopp.net>
In-Reply-To: <ae995ec1-8dbd-7484-a250-28d8637eb6ff@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 14 Jul 2022 18:12:39 +0900
Message-ID: <CAMZ6RqLtUKja1dzvN9Wj8zRXigbeXW43jzpST-tZP9RmLHhVFg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
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

On Thu. 14 Jul. 2022 at 15:11, Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
> On 14.07.22 03:23, Vincent Mailhol wrote:
> > On Thu. 14 Jul. 2022 at 05:02, Oliver Hartkopp <socketcan@hartkopp.net>=
 wrote:
> > If we follow your idea, use __u8 xlsec in order to avoid undefined beha=
viours.
> >
> >> Where we define
> >>
> >> #define CANXL_TAG 0x7F
> >
> > Here, you "burn" all the flags for future usage.
> > FYI, this doesn't have to be 0x7F. It could be any of the length
> > values not allowed by CAN-FD, namely (in decimal): 9-11, 13-15, 17-19,
> > 21-23, 25-31, 33-47, 49-63
>
> Yes, I detected this issue too when waking up this morning ...
>
> >> #define CANXL_SEC 0x80
> >
> > I did not get why CANXL_XLF isn't needed anymore.
> >
> >> which has to be set in the xlsec element then.
> >>
> >> With this move we get rid of any flags problems (we only need the SEC
> >> bit anyway) and define a clear 'escape value' in the former length ele=
ment.
> >
> > If I try to bounce on your idea, I will propose:
> >
> > /*********** begin **********/
> > struct canxl_frame {
> >          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >          __u8    flags; /* additional flags for CAN XL. MSB must be set=
 */
> >          __u8    sdt;   /* SDU (service data unit) type */
> >          __u16   len;   /* frame payload length in bytes */
> >          __u32   af;    /* acceptance field */
> >          __u8    data[];
> > };
>
> ACK.
>
> > #define CANXL_XLF 0x01 /* mark CAN XL for dual use of struct canfd_fram=
e */
>
> IMO the dual use stuff between CAN FD & CAN XL is not working anymore
> and became obsolete here.
>
> CAN_XLF needs to be a hard switch for CAN XL - no optional thing.
>
> > #define CANXL_SEC 0x02 /* Simple Extended Content (security/segmentatio=
n) */
> > #define CANXL_DISCRIMINATOR 0x80; /* Mandatory to distinguish between
> > CAN(-FD) and XL frames */
> > /*********** end ************/
> >
> > This has no undefined behaviour and we still have five flags (0x04 to
> > 0x40) for future use.
> >
>
> I would suggest the following:
>
> #define CANXL_XLF 0x80 /* mark CAN XL frame (must be set) */
> #define CANXL_SEC 0x40 /* Simple Extended Content (security/segmentation)=
 */

OK. Having CANXL_SEC on the most significant bit (0x40) or instead of
the least significant bit (0x01) works for me.

> And the rest of the bits are reserved (shall be set to zero).

ACK.

> This way the CAN_XLF value would make the former 'len' element 128 -
> which is a proper distinction for CAN XL frames as such length value
> surely bounces on CAN/CANFD frames.

The purpose of the CAN_XLF is still unclear to me. In your initial
patch, you wrote that CAN_XLF was to "mark CAN XL for dual use of
struct canfd_frame". So are we really OK to specify that CAN_XLF is
always set? How are we going to tag dual use?

But my main point was to always set 0x80 to differentiate between
CAN(-FD) and CANXL, and we are aligned on this. :D


The last topic remaining is the data[] vs. data[CANXL_MAX_DLEN]. I
thought about it but can not find any killer arguments for either
solution.
The biggest difference is that for data[] we can do sizeof(struct
canxl_frame) to get the header file whereas for data[CANXL_MAX_DLEN],
we need to introduce the CANXL_HEADER_SIZE macro.
My preference still goes toward the data[] because I see flexible
member arrays as being more idiomatic C. But it is more for personal
taste than anything else=E2=80=A6


Yours sincerely,
Vincent Mailhol
