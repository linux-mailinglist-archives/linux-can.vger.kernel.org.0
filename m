Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBF457219
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 16:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhKSPvs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 10:51:48 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:46995 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKSPvs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 10:51:48 -0500
Received: by mail-yb1-f173.google.com with SMTP id g17so29384580ybe.13
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 07:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WG5C/rFd/3saiDhXJ3Dldw5ww47nItnIYfkZbQzrJFQ=;
        b=she0QScqndTufLVs1cgbNm4DJUYMiArNJzBVWp0aSKND2F3NJoab2MO9k4r+aqq/oF
         PO9IMnUDV0F6SPczOu1zbRWZ81rq0PHTXYFpT6T9gMLoWjd675VfemksHJqLhpkXTKTv
         aIhW/T/DP6z1a9+QUeJevniPji+yEn7GXe8qgp6fzBUqRlWsOXlD2/diZ1/h0ROgmzMO
         ZRQy8De4sV2iLXHkDzfoseYruzTU/8qjOKQK3gFu0n9s7t1vM8VKo0ffVbXWdHrAh0HR
         zhy+vplNelMXyOT762NzWqeDMcFRA70kEF95m4uGVoqy7VUf/qY6ycgfkPTWp65zl540
         +1AA==
X-Gm-Message-State: AOAM531IP3gl7Fsc5JXEdeA7QDmx1Bl9kjrATEnKb/OkmBsVyrQjN0CX
        qjtgb60DDR43QGeZqSvDMtAJArO8moIzC5CLPOk=
X-Google-Smtp-Source: ABdhPJy5OF2vncye8VPwP+kWiJYNLiPdXswQgBxtY2POcqSdKoPZb5N8Ib2xL+Tc5HfXCLHC5jsUbPBZWnTxhUyzjAY=
X-Received: by 2002:a05:6902:1208:: with SMTP id s8mr42157619ybu.375.1637336926256;
 Fri, 19 Nov 2021 07:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20211119131915.2033234-1-extja@kvaser.com> <20211119131915.2033234-5-extja@kvaser.com>
 <90d2eddf-fcfb-0abf-2807-413b12480e8d@kvaser.com> <CAMZ6Rq+gMAypGxVQEy0KKMMcb0n7hHNjefXUB-csAg3NgT_=FA@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+gMAypGxVQEy0KKMMcb0n7hHNjefXUB-csAg3NgT_=FA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 20 Nov 2021 00:48:35 +0900
Message-ID: <CAMZ6RqLiBnHkoGFF7hZ005wLRe8eXniPdtbuT0e4c8U_dcqDPw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] can: kvaser_usb: Use CAN_MHZ define in assignment
 of frequency
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

(I inadvertently sent my previous message while I was still
writing it, resending with full comments)

On Fri. 19 Nov 2021 at 22:30, Jimmy Assarsson <extja@kvaser.com> wrote:
>
> On 2021-11-19 14:19, Jimmy Assarsson wrote:
> > Use the CAN_MHZ define when assigning frequencies.
>
> Maybe we should use the HZ_PER_MHZ define introduced in kernel 5.15 in
> linux/units.h. It also got defines for KILO and MEGA, which we also got
> in linux/can/bittiming.h.
>
> What do you think?

With the recent changes in linux/units.h, I am perfectly fine to
remove the CAN_MHZ, CAN_KBPS and CAN_MBPS macros from
linux/can/bittiming.h.

I am just bothered by the name of the macro HZ_PER_MHZ. Hertz per Mega
Hertz is a ratio without a unit (physically speaking). The
clock speed is expressed in hertz. So:

| .frep = 80 * MEGA,

would make more sense.

I see HZ_PER_MHZ as something used for conversion, e.g.:
| freq_in_hz = HZ_PER_MHZ * frep_in_mhz;

Yours sincerely,
Vincent Mailhol
