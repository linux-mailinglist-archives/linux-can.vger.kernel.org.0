Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B45B4F61
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiIKOKj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiIKOKi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 10:10:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CC13D1D
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 07:10:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g5so9214102ybg.11
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=x3r/pK2DiW2XQt0x3Cl7YXHq6OshM/RSxXPUyqT2naw=;
        b=V7y9ubu+LIJ0kq38Zx6ITrM3NXxG906c/FE1kzkilaC8nl84OLZjIFrM5ZHfLNddiW
         z0LoaYsXUe4y3qJX/eqnLgqtUsqcJYpQLyu0IiCd2UrZnqpW3Kuo03oASTX4lDiHmpee
         yVJb9AdnkzZFTiOQyV39ONHXMvQ1n20YMP/RhCiPCuLnv1hArNyUthyEP9TMqUb2WiSt
         xC0i8y4iVfIgEBgHamsvAUyA0oXmcRs1/j1Um7B51gAj0c5tNzsXww/ZstBTnDEIEWhp
         om2NzyQm4BZSBdC6XifdsYZRe//FQ9wrMH8KynHu5TCXCTQ6LuuFa+XR54n6VjT0GT1Q
         +vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x3r/pK2DiW2XQt0x3Cl7YXHq6OshM/RSxXPUyqT2naw=;
        b=cQZ0mkkN/IGsq6/5XMKp0rlvXyNLxV6gbjWEsfB7DWtwEWRT2WVm6zy6epZ4QR2LRw
         H1z/Qyan2KsztVE/QCLR29TBNiBY0tdxsCKP9lCAfGxgvVxSmLfd4gDjcMO3tOO8YZSg
         Am0JVlmI36TfCTM0sg6bv9cMWstUDBo3AmRqtDXUeN8cXSs3qv4tFZ0LW6/I+XSjuj14
         7vkhD/u+xth/Lzmb+dj1GCtA8mMAduHaagorrP4gC6OJ24gEKB4fSfppUVrnFZiKEVIs
         ngGGMLbCGTLRWDewAaYWYtl4mMYsPaM8GPeyz0yN6oiEvMwFLVpkYLfX445y7jlqdoyH
         wzqg==
X-Gm-Message-State: ACgBeo1ycEUVYDMbFT0sB4DRp0q/ekozXDDA9GTTPfeV79bsBQ5v40QZ
        85jlmw1EGTH1qnkKQnR+I60CTZLUdR4nqRzdM4xw21S3
X-Google-Smtp-Source: AA6agR6pfRhWTttFfGdVNnb7uTrVx7pGqvaOegWqrVnIn3UX/tC1SiWKVvS3IMD7JTDV99gFI61fA44x7x6mkGMOpbA=
X-Received: by 2002:a25:9888:0:b0:6ae:b84f:1004 with SMTP id
 l8-20020a259888000000b006aeb84f1004mr4464335ybo.20.1662905436349; Sun, 11 Sep
 2022 07:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190010.3344-1-socketcan@hartkopp.net> <20220801190010.3344-6-socketcan@hartkopp.net>
 <CAMZ6RqJMTP8mO5LOgfdFHNAkrn+3bCP9_JcGb4Q86TtHiS100A@mail.gmail.com> <5867dc1e-36d7-d0ea-7d1d-56ea31ac19b8@hartkopp.net>
In-Reply-To: <5867dc1e-36d7-d0ea-7d1d-56ea31ac19b8@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 11 Sep 2022 23:10:24 +0900
Message-ID: <CAMZ6RqK_hPty_=8Jrmp+mHksm99UKeXs=Wo3LC2NSd4v_HsUNQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] can: canxl: update CAN infrastructure for CAN XL frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
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

On Sun. 11 Sept. 2022 at 21:35, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 11.09.22 09:53, Vincent Mailhol wrote:
> > On Tue. 2 Aug. 2022 at 04:02, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> (..)
>
> >> +/* get length element value from can[|fd|xl]_frame structure */
> >>   static inline unsigned int can_skb_get_len_val(struct sk_buff *skb)
> >>   {
> >> +       const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
> >>          const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> >
> > Nitpick: what would be the acronyms for cfx and cfd? I thought that
> > cfd was for *C*AN-*FD* frame, and thus I would expect cxl instead of
> > cfx for *C*AN-*XL* frame.
> > On the contrary, if cfx stands for *C*AN *F*rame *X*L, then for
> > CAN-FD, the acronym should be cff (*C*AN *f*rame *F*D).
>
> You need to start from the original
>
> struct can_frame cf; *C*AN *F*RAME
>
> Then CAN FD showed up and the naming moved from 'cf' to 'cfd' for *C*AN
> *FD* FRAME where is was not forseable that there ever would be CAN XL.
>
> For me it is more intuitive to generally name CAN frames 'cf<whatever>'.
>
> cf -> cfd -> cfx
>
> So it is about 'cf' with an extra attribute and not an abbreviation of
> CAN variants.

I still disagree on that one. For me:
  * Classical CAN frames: ccf (or the legacy cf before introduction of CAN-FD)
  * CAN FD frames: cfd
  * CAN XL frames: cxl
is the most consistent.

cfx is not consistent with the cfd acronym and it is out of order: the
structure name is canxl_frame, not can_frame_xl.
At least, that should be cxf for struct *c*an*x*l_*f*rame. CAN frame
XL just sounds odd to me.

Regardless, this remains a nitpick and I will not NACK the series for
that. So do as you prefer in the v9, my Acked-by remains valid.


Yours sincerely,
Vincent Mailhol
