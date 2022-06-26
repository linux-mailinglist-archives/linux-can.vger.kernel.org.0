Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9DA55B060
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiFZIou (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 04:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiFZIot (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 04:44:49 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA98D2AE6
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 01:44:47 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id p7so10384665ybm.7
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 01:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=arYmRhElP/waqmZWPT1QhV3G5x/Yz5WVvQk6T6thT9o=;
        b=TQEYydsX70F2N/37I5ygqmmo52zv49RwZalgajACq0joUCClVFJ+MtcX88wDP1WYgq
         2akguVezOIRl2kvb666dzEMqDLFsCf3AIvti/EqgkYLXpP/U9rdSeSEmFbWYl2lRetsa
         X+713Hsb8kBy/drTIWAABP/0fdlxeUGEKHixvI+gXvE/JM5llQJZAz6Hy0agUfDiO1j6
         J/DJo8Q8m7VlnJ+kI3VqT90Rs6WgTXUywNbhxiMPVn8x/5vBu7n78jy9Ecb1/bOFrj0k
         zBMsHCw0eSO0TUC54KFEB4BAnUwDw2l3sUO3J03QUtnsg9uhqfUoSIamYFS9tTPe6Yx5
         ZiEg==
X-Gm-Message-State: AJIora+WLtC6jLIBW8QplhMcr536MQPMQ+0KopxEjKrQ9JILKq2TZiDV
        Y+MwRWJ4L8YkgRd7V7jAb3B2Ux9DJKUogXXX87qNGwzDbA0=
X-Google-Smtp-Source: AGRyM1tGK2JZ1vSgE1fLCy6qoBn1BTeiT8IMUiBvF8skFagson01BXZK3KZvY8P0XhrMbKC6bS756K3p/kQ7EFyxryM=
X-Received: by 2002:a25:b74a:0:b0:66a:775d:a257 with SMTP id
 e10-20020a25b74a000000b0066a775da257mr7933899ybm.381.1656233087150; Sun, 26
 Jun 2022 01:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220614222811.1a18e19b.max@enpas.org>
In-Reply-To: <20220614222811.1a18e19b.max@enpas.org>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 26 Jun 2022 17:44:36 +0900
Message-ID: <CAMZ6RqKAOSKcdY2PJqSHR0fBaJ8k+9Fw3jcP5nD3xg+PbF11Sg@mail.gmail.com>
Subject: Re: Thanks for reviewing can327!
To:     Max Staudt <max@enpas.org>, linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_20,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+CC: linux-can

On Wed. 15 Jun. 2022 at 05:28, Max Staudt <max@enpas.org> wrote:
> Hi Vincent,
>
> Thank you so much for the thorough review of can327!
>
> (the word "relentless" comes to mind, even if it doesn't really fit...)
>
>
> You went above and beyond anything I could ever have dreamed of for
> something that has started as a hobby curiosity, and now likely powers
> several projects more curious than itself. No idea why you did, but I'm
> grateful.

I can answer you. Several reasons but the strongest one is that less
than two years ago, I was in your shoes.
I posted my first message on the linux-can mailing list in September
2020 with the patches for the etas_es58x driver.

I did mistakes similar to what you did, for example I also had a
memory leak in my code:
https://lore.kernel.org/linux-can/45c0b0cc-bfd6-5180-7ad9-51eebc9de3c9@gmail.com/
(thanks again to Jimmy for spotting that).

My patch reached v15 and took half a year before being finally
accepted. All the comments and mentoring I received back then from
Marc, Oliver and the others turned out to be my best learning
experience in the last few years.
In some way, my review is a way to give back to the community what I received.

> Please remind me to buy you a beer or other drink the nex^H^H^Hfirst
> time we meet.

I live in Tokyo, if you have plans to visit, it would be my pleasure
to share a beer.


Yours sincerely,
Vincent Mailhol
