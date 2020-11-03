Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C782B2A4A82
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgKCP75 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 10:59:57 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39776 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCP74 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 10:59:56 -0500
Received: by mail-yb1-f195.google.com with SMTP id k138so8730882ybk.6
        for <linux-can@vger.kernel.org>; Tue, 03 Nov 2020 07:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICH7ixyuzDjbi0WWbJNnppCeZ69tF3EeEplOoA2mcP0=;
        b=OSBF0/Lm2eeP7O7jdEEFTEqb7yyVSwszGy7gA85/1fkNlAhQmmZHTZpQgaaPrESbFJ
         EWvF7jJlnu2hlqEhxa08N+sw+fUGEPlVhnKcMZnKtG+JRxqtBhbUp7BrVducKmjHhyKG
         R4GqmZpx000dQoEcxVcUEElNfeuQMR+InxCTCqtenXVJMP5OLVw5XW7DtUcHtQOQ7K8c
         cUmnSucVS2bDCZGb06z4wPEWf1a/OnEdUieROFxuiq/d/LxvO/kH3Q/l/iwbMITMJkBm
         vQhCs/t8qL5dNzkQ5omsLAEL29f7GcPpyczczwxBKbiIQt2FbBnfHIQ+D9uouYkCwcNc
         N/cA==
X-Gm-Message-State: AOAM530/CCV1AwB6dYC6GYvNTX113uGEvkHc58qKFbb4Gr9r7GyRPuT7
        o3azBJl6aUW8tqkOtBoCkezHtsHoQLO4AmtGIrDbBPB+oGY=
X-Google-Smtp-Source: ABdhPJzN8HKK/A7xl0nNqoaXuBV5KOsSm+O0xzrq2yUMDgkNUZ+jEZ4JqAK2/pHsMzTCsK6C2CWcRQishSZber68398=
X-Received: by 2002:a25:c782:: with SMTP id w124mr30808754ybe.125.1604419195603;
 Tue, 03 Nov 2020 07:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20201023203017.3485-1-socketcan@hartkopp.net> <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
 <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net> <6bfdc3db-5aaf-b492-dc24-fb5d73cd3b23@hartkopp.net>
 <CAMZ6Rq+UY6SJxDJ15jx1vmSFUk9YHWx+Rf5dZiC9OY+6RO9QXg@mail.gmail.com>
 <e2e5e78e-5de8-9a36-ae6c-191518b3bba3@hartkopp.net> <729dcd89-d4b2-1139-4229-9d88f1fd3175@hartkopp.net>
In-Reply-To: <729dcd89-d4b2-1139-4229-9d88f1fd3175@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 4 Nov 2020 00:59:44 +0900
Message-ID: <CAMZ6RqKfu1TE62FS7vC-yUFKfpWOiVtg0Yq4kBd8_MRW3ZnU0Q@mail.gmail.com>
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 02.11.20 04:58, Oliver Hartkopp wrote:
> On 01.11.20 17:12, Oliver Hartkopp wrote:
>
>> Yes. After you shared your thoughts I would indeed tend to provide an
>> option '-8' and then always print the raw DLC in parenthesis e.g. (0) or
>> (F).
>>
>> IMO this len8_dlc stuff is an expert feature that normal users do not
>> care about. Therefore it should be disabled by default.

OK, it is a reasonable compromise.

> I implemented '-8' for your testing with curly braces {} which just
> looks 'more unusual' than ().
>
> Please give it a try also from a visual standpoint if it fits for you.

I did the test. As usual, it works fine.

Is the use of the hexadecimal notation a deliberate choice? I
initially did that because it is the easiest hack. I was expecting to
use a decimal representation in the finalized version but the
hexadecimal notation stands out even more and seems like a good
choice.

With both the curly braces and the hexadecimal representation, I do
not see how we could do something more visual.

Concerning the () vs. {}, honestly, that's a coin flip for me. No
preferences, both are fine.

Also, when receiving both Classical and FD frames, until now, the only
visual clue was the presence of the zero prefix: [x] for Classical
vs. [0x] for FD. I think that I might use the -8 option even when not
using CAN_CTRLMODE_CC_LEN8_DLC. Like that, the Classical frames would
show as {x} and the FD frames as [0x]: a way more visual clue than the
current one.

I will continue to think of other use cases for the other can-utils
programs.


Yours sincerely,
Vincent Mailhol
