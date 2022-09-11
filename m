Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BFC5B4F41
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiIKOBG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 10:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiIKOBF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 10:01:05 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C331202
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 07:01:04 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 202so9181607ybe.13
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hG4AqhF4cFRdywsDcrSKS75dbWPSQkUL5UI3I3CWkZ4=;
        b=QTN8E7ZnafQssGkYg2JHDtqbRuGBIynIygfofHJIjh3azyk9UudlGpu2cnPXsBem3c
         j3IgH+jhUxtyJt+KvQemYS3GrjTLQ5mv5UQAj7DbfzEyGJn0n6x+//3+WRuiN6i4Dx43
         4h4gXV+3Du5pcpCqu4J4YaRMe0cCn8o+e7WZRn8fu43Vn4vWqC6/Kt8xSA7UdU0NxwZH
         MF/DRTyvYUuAmRVbIKFV1G72XWdRscEbL4giTcH5istQbfIiUDZI0uQVZ/T7+05wld7K
         VirjU9cLZ1PCbAVzR8l6h7zZiQJwn/3TaRJDQdqgEE4T6OQkGgIPCIVM4QrXzXzow59g
         +2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hG4AqhF4cFRdywsDcrSKS75dbWPSQkUL5UI3I3CWkZ4=;
        b=X85TxypdpsAtFRxuM0erkiD5H71wGRXLnen3GbuOopXMqmXpO7r7LT//i4yuKgrBnP
         gEy6d6xmBNB64SlAqjro2vWWLfXzILG7ohcEHXtspK0RfEF9ILwmIl/ZilBE47MoKfex
         AGyM0BTm7WSc6VnTNZcoCfAJa2/8o5jnf5uNpnHtXfh8ZaviIu3PA6zvwHflmC4KoBrv
         KPCWrNKc76VnGeBNA2GSBkq7vLtnXk9SdNC1CSvY9EgkJkfatDFme1n3zhtNZz8/e4cm
         FBcbvfxIutkLUdSDSgSUZ1XWVu46k1375hqJV02rfyMN/M9EoF7nW66HSqNRURFqCMUo
         qkVA==
X-Gm-Message-State: ACgBeo2+AI1u1NmdUW/T+GU4P/TrkQxUC2WvrmDCrhb/tDVRyWM87TGd
        d0U3YxglBXhsCbpKpums6OrWAwsIAQ+FaIdyc3VNA7INOeg=
X-Google-Smtp-Source: AA6agR5KucUGs7mAk4jIgBBhnWnSS1mXnsiBktzLeEmYs5/XV+5sU7937gWE2cywruXaKtUoXihwSwKGlHJXPZHqduY=
X-Received: by 2002:a25:6643:0:b0:6ae:fb64:9872 with SMTP id
 z3-20020a256643000000b006aefb649872mr2235416ybm.423.1662904863377; Sun, 11
 Sep 2022 07:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190010.3344-1-socketcan@hartkopp.net> <20220801190010.3344-5-socketcan@hartkopp.net>
 <CAMZ6RqKFNY1y9XpsLU6cjs_TmnYBjjDin6LHn5TRpm5m4w2ewg@mail.gmail.com>
 <414e2a33-0091-11fc-70db-a87331addff8@hartkopp.net> <f79f729c-01eb-2121-e315-a240357d2eb0@hartkopp.net>
 <CAMZ6RqL=ZqBUSA8xGQW1jMU8fwduz11_HJcFjerPtO8ZUAVdiw@mail.gmail.com> <1d8be592-5f4c-8036-8050-22aec73a3eb4@hartkopp.net>
In-Reply-To: <1d8be592-5f4c-8036-8050-22aec73a3eb4@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 11 Sep 2022 23:00:52 +0900
Message-ID: <CAMZ6RqLmSVQycDJeZ20P_oVE0GwyM3NoGbbuVHRsMzYXODvarA@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
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

On Sun. 11 Sept. 2022 at 21:11, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
>
> On 11.09.22 09:50, Vincent Mailhol wrote:
> > On Thu. 8 Sep. 2022 at 16:24, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> (..)
>
> >>> The CAN-ID was (due to its arbitration nature) always also a priority
> >>> field.
> >
> > The CAN-(FD) ID holds two roles: priority and ID. For CAN XL, it is
> > only ID.
>
> Typo? It is only the priority ;-)

Yes, typo ^^;

> > While I agree that both have the priority attributes, my
> > concerns are on the semantics. The type is canid_t, not canprio_t. I
> > just want to point that it is weird to had ID in the type when that
> > field doesn't have an ID property anymore.
>
> CAN XL moves away from the two roles combined in the CAN(FD) Identifier.
> The main focus is on arbitration now (CAN XL is like CAN arbitration
> with Ethernet data).
>
> But in the end the CAN bitstream at the beginning of the frame including
> the arbitration is completely identical for all CAN variants.
>
> Even when this arbitration field is now named priority for CAN XL it is
> still the exact mechanism of the CAN identifier (what we introduces
> canid_t for).
>
> Therefore having canid_t for can_id and prio seems appropriate.

I guess you have a better insight. Thanks for the details.

> >>> So nothing changed here. There is no RTR and no 29-bit priority anymore
> >>> now. The RTR flag has already been disabled for CAN FD (see presentation
> >>> at the end of this mail).
> >>>
> >>> Therefore it makes sense to handle the SFF 11-bit prio analogue to the
> >>> former CAN-ID - and also use canid_t to simply keep the entire CAN
> >>> filter handling in af_can.c !
> >
> > This is a good argument to keep using the canid_t. If we make it a
> > u16, we lose the alignment (unless we add dirty endianness
> > preprocessing macros).
>
> Yep.
>
> (..)
>
> >>> Btw. I uploaded a presentation which shows the way from classical CAN to
> >>> CAN XL which might depict some relations of the bits in a clearer way:
> >>>
> >>> https://github.com/linux-can/can-doc/blob/master/presentations/CAN-XL-Intro.pdf
> >
> > Thanks. With the Bosch PDF now returning error 404, I suggest
> > replacing the link in the cover letter with your link (or the CIA
> > knowledge page).
>
> Ok, will do.

Yours sincerely,
Vincent Mailhol
