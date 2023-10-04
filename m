Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA507B81D0
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjJDOIH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbjJDOIH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 10:08:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C8C4
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 07:08:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1667354a12.3
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696428483; x=1697033283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=On2F5FNxPF7dUAO5oqJOCDCqt4lnvod+K/5Whu8j/js=;
        b=IUrJTutIRgWZfaCqLTrzOkOYqBDhu0tp43DeougexTEy5QqtaeaMtd8BqnlkhZz5LY
         9J9UsyeXmMiTDaa8taqimUDpC0zcv8o8GMEUWpRUsSiTw78LYh+yVxMP2ic+QQhnY+Do
         ISjd3IujjKwNuDpLUYxRNuR2JhJ4YXgfNR3cXGjlFD06ND9ZbQgXn9NX/K5tc4He6rXp
         0iQSJLRWIXRjPwNQgz1G9HCJOZv5eGAoJ/tevXKHuQiXUSdayPSQdUc7crIg1GsO8ro5
         ntGt3Km0SRMF45Xz2NlqMlAY7fdCjwpR6KgVBTIPH+Z5/PlQU6jaodFhe/PwBkJcFQ0X
         1TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428483; x=1697033283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=On2F5FNxPF7dUAO5oqJOCDCqt4lnvod+K/5Whu8j/js=;
        b=RSxlUQagxY93AyW3tz2UvAiJZo9HDdkuLOYfNJ4E44Qt31s/a1yVNtpXW0QahCTaMU
         /j40SJ2IBh1ParIwKvDLrmFuUaNeClQsX/P2V16dG8MEIoxoxvXB6yqf0X3HUHP/2Jy3
         2y3V2mUa041awNHiXQ0lnRqm0Lyd13TRyqaQJqOZHL4QMFZkEI3X6vpcJwf7aCfAhK8/
         smmLpg2Oq7ab2m+tmBV7jidAjM38RlX91Cal9P7PPMAq93fV3jMqvHDx1vRDwVa+EftD
         5U71CCh6l1sLTsN3XRrWvO0KePXdv4wUDFX/vMY7tlMkt3BimHjL8NAImkrv7xxVkRQg
         rI6g==
X-Gm-Message-State: AOJu0Yywkz0yEOBYGl16aq7Tu0VAeQyWrjM6iHDj6gJKR5FYpkerh6na
        aL3BkDElYiFhVWBFJ+eUMJ/3Uy+61PGZOKldCKxprgO8Y5o=
X-Google-Smtp-Source: AGHT+IFo15M7aCO5xTXCodUSm1sP8k+ugc3PIJwiD8INy0OhGfyF5cmTawE3k3hNVcM0xwMenQhRY0g7tgD4RngeLcc=
X-Received: by 2002:a17:90a:f996:b0:269:85d:2aef with SMTP id
 cq22-20020a17090af99600b00269085d2aefmr2284414pjb.20.1696428483045; Wed, 04
 Oct 2023 07:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
 <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de> <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
In-Reply-To: <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 4 Oct 2023 23:07:49 +0900
Message-ID: <CAMZ6RqLMC0LjbTp1oh8fpPFcrCg+APr+b5zA9sS=wC4Ad692FA@mail.gmail.com>
Subject: Re: [PATCH 27/27] can: at91_can: switch to rx-offload implementation
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

My message had a second part, did you miss it?

On Wed. 4 Oct. 2023 at 21:55, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
> On Wed. 4 Oct. 2023 at 18:24, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

(...)

> > @@ -638,7 +613,9 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
> >         else
> >                 cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK, reg_mid);
> >
> > -       reg_msr = at91_read(priv, AT91_MSR(mb));
> > +       /* extend timstamp to full 32 bit */
>                     ^^^^^^^^
>
> timestamp
>
> > +       *timestamp = FIELD_GET(AT91_MSR_MTIMESTAMP_MASK, reg_msr) << 16;
>
> If I understand correctly, you only use the hardware timestamp for the
> napi but you do not report it to the userland.
>
> Not a criticism of this series, but it seems to me that it would be
> easy to add one follow-up patch that would populate
> skb_shared_hwtstamps->hwtstamp and update ethtool_ops->get_ts_info in
> order to report those hardware timestamps to the user.
>
> >         cf->len = can_cc_dlc2len(FIELD_GET(AT91_MSR_MDLC_MASK, reg_msr));
> >
> >         if (reg_msr & AT91_MSR_MRTR) {
> > @@ -652,151 +629,12 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
> >         at91_write(priv, AT91_MID(mb), AT91_MID_MIDE);
> >
> >         if (unlikely(mb == get_mb_rx_last(priv) && reg_msr & AT91_MSR_MMI))
> > -               at91_rx_overflow_err(dev);
> > -}
> > +               at91_rx_overflow_err(offload->dev);
>
> (...)
>
> This concludes my "review" of this series. Because I was scrolling
> through it and not doing anything thorough, I will not be giving my
> review-by tag even if there is a follow-up v2. That said, aside from
> my comment on patch 01/27 and the random typo nitpick, nothing seemed
> off.
