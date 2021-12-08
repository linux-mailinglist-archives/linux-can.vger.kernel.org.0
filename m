Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3789046D466
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 14:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhLHNa5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLHNa4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 08:30:56 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F4C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 05:27:24 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a37so2779529ljq.13
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w4snyUWborkAG4OBP7hYv4ofkdpHbmsnrR+cUxCsiYA=;
        b=jb6S57IrR87AKe1YFR1i14s+Qp4LteknvwKY803vOND5LomtGQ87QaPAybnMCgcNY9
         MTMagDXSAEDAutqIxwas3USs/QBXYMVlcEPkyvrGwQMl/zYNDA8Q7h1ShHRVqCgyE0MS
         YRR8qgd0WXgc1tRu/2FJ8CorG8w+TZy9bc/ATHDGQs1WXwmekdFaZjhc8sGsyOXB1ASO
         q5ZU6k9b+KrSDbeeZP0OPKpvULtHn5z/xzSzI0zN704G+cMxcyEGE7bFKtRk4QCCJQNq
         0xawZtbbDHhXtuGiCe0BdidP2733CSHTdCtAmYM+twvpHxFzasQSQ4uLwbEp+8p0JJL9
         beWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w4snyUWborkAG4OBP7hYv4ofkdpHbmsnrR+cUxCsiYA=;
        b=6fxk37CiIvfic28H+ERAIKqD1VrD9UiVoUN+gIvdOjU+bvGXRJsLO0N1OW84wxmi8f
         7eyOO9g8DfENun3PuxWW3scymBOztlvtrctxdEbTNbTuMqGS4ebIo0g2fBpqh8UK9NMW
         MOrW2Dqznjtuq8dqF+8KLnJRreW9ZvohjHDmecT5Cg8BPi6daKZJO/pWKwfSeurjPmFh
         lyVdlHX0VfSa5asupjMua9l9HeaLVrr1Dt/GwDguwoFh0oOcnvdjCKsW9ZSSCtu21kP+
         uuci0AfeeHvnDJL55iVZn28D1j5KJ8xaqeHnrpg0EcSgaCZEgbWmqL0HV9A5GctKhzSq
         8ADQ==
X-Gm-Message-State: AOAM530zv6iuN2eyGkUCg0kXmfxAbJ2gh7bkGtnJsbJWIHxfztf65Spv
        e2kUiY+aAE8RTvmtJ4b29/uWpXPjVcgvbgWM
X-Google-Smtp-Source: ABdhPJzOCmIRqZAI6nBCAb2zXmeH++vWEEqYvhBXtxeFfscAikvNRmoxFP3wuE47J4TJG53f6+xOgQ==
X-Received: by 2002:a2e:6e15:: with SMTP id j21mr49613875ljc.195.1638970043219;
        Wed, 08 Dec 2021 05:27:23 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id 15sm270151ljs.68.2021.12.08.05.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:27:22 -0800 (PST)
Subject: Re: [PATCH v3 1/4] can: kvaser_pciefd: Increase correct
 stats->{rx,tx}_errors counter
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20211208115607.202859-1-extja@kvaser.com>
 <20211208115607.202859-2-extja@kvaser.com>
 <20211208122606.v6c2hlb4zlicpuhd@pengutronix.de>
 <20211208123132.5ft747z35dcwrrq2@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <6bc42614-3a3f-7c92-2c48-c165b2e8e144@kvaser.com>
Date:   Wed, 8 Dec 2021 14:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211208123132.5ft747z35dcwrrq2@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-12-08 13:31, Marc Kleine-Budde wrote:
> On 08.12.2021 13:26:06, Marc Kleine-Budde wrote:
>> On 08.12.2021 12:56:04, Jimmy Assarsson wrote:
>>> Check the direction bit in the error frame packet (EPACK) to determine
>>> which net_device_stats {rx,tx}_errors counter to increase.
>>>
>>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>>
>> Is this a fix that should be applied to the stable kernels? If so, which
>> commit is fixed by this?
> 
> To me it looks like the problematic code has been in the mainline kernel
> since it was added. So I'll add a
> 
> | Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
> 
> tag, add stable on Cc and upstream this via net/master. Ok?

Sorry, forgot to add the Fixes tag.
Yes, it's correct :)

Thanks!
jimmy

> regards,
> Marc

