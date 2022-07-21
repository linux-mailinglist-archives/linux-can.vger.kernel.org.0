Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE157C5F2
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiGUIPL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiGUIPJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 04:15:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8102B57
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 01:15:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31d85f82f0bso9204097b3.7
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqHE4BK3e3Pm9KgW/SJnUA527Cf4tqD4K+qQVkJukeg=;
        b=a7OWJov4SMDiz/4dl8Iyd2s3MXPCE+4q+YWRXaqUEVHM9vji3plWvfXPknEXBTP0O9
         2DN+vBsxRVgRUoB6ziEU2y5e9RjOpJ47NxPFPJ5jkPX3jLW6KFuJUyegEcWh0lllK7vH
         jQ6sadTtH38N9EFVFxvIlqg2yHDYGd7ln/TyazXA4/O9WXwRxb0e+UozTOwg9x1iFta7
         uxA+Lv0Y5JsE+wxAhx6eVHIf/WhykHx0ug2nYmidmOEUVkkgeRdCSz+vVB5+dRh0Tosy
         toTdFAiuI8S8wlRwFcYFcan9PUJWq4ohnq5smlww1nLPBmU8fyCx+tssgc1W9XUWDU2h
         +Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqHE4BK3e3Pm9KgW/SJnUA527Cf4tqD4K+qQVkJukeg=;
        b=brvsWKd/0hj0dNb5qP/h7lD0e52APjPLay30ItriB2PNLR9AGcd2O8vrT8JWie65aZ
         fxUR0aCCNG3k1RuSku5yVQAjn3sDKvJvGk1SSW4tcPGTGhGJjFl2qVbKiirU7rPK88mm
         BbdxSxaKKmERC4fz6XOb5wqcYj+ds/kOAZqQPHLhHxmDwA3E8dSHdQsdURQrbDtYDLcc
         zK5yn+v0jexRN5rQ6GWwCuwEIEUQdTFHOx6pVdKEpobM1lw0KmmLk4ganUge8ZQluXIy
         aHSE649i7F/kfCr/ghd0lh1P8OCscst7rotXhfPIYmnLlZuW7Z5dbizJpJESgT5bl1Il
         7RXg==
X-Gm-Message-State: AJIora9Wkc5pEpESY95Fz+S5mFyCzmRk4O+IU6nMOOwPAkoIwVONj0Kf
        FgxsmsleAxOt2jxpDbC1ylhIg0ddOMFv2BkCPiONCE+Rl5U=
X-Google-Smtp-Source: AGRyM1v/EeJ3vMFKAMdYojUG5AqgcT3ERq5egwt+ZcNrgULI8vX+VLDLK43sOaG13lWRIkLYz7gR6uSneaFTlI51dhw=
X-Received: by 2002:a81:9201:0:b0:31e:4ce6:8c90 with SMTP id
 j1-20020a819201000000b0031e4ce68c90mr15976475ywg.45.1658391306025; Thu, 21
 Jul 2022 01:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net> <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net> <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
In-Reply-To: <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 21 Jul 2022 17:14:54 +0900
Message-ID: <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 21 Jul. 2022 at 16:53, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 21.07.2022 09:36:21, Oliver Hartkopp wrote:
> > Btw. How should we finally name the 'non data' header of CAN XL?
> >
> > 1. CANXL_HEADER_SIZE
> > 2. CANXL_HEAD_SIZE
> > 3. CANXL_HDR_SIZE
> > 4. CANXL_HDR_SZ <- currently in the patches
> > 5. CANXL_HD_SZ
> >
> > I think it has to be 'head' and not 'header'.
>
> Header! Header is in front of data.

I am also part of the header team! By analogy with:
https://en.wikipedia.org/wiki/IPv4#Header

> > In skbs we also have head and tail.
>
> Yes, but they point at the head or tail of the buffer allocated with the
> skb.
>
> > So I would vote for 2 or 5 with a tendency to 5.
>
> 3, 1, 4

My top vote goes to:
6. No macro, instead use flexible array member and do sizeof(struct canxl_frame)

I do not like the SZ abbreviation either, so my next choices will be 3 then 1.

To recap: 6, 3, 1.
