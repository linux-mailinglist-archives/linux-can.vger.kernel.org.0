Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5F345905
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 08:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCWHqU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 03:46:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:9619 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhCWHqP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 03:46:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616485551; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a5ko9wFednbVsuUshpCD9/xsFXp9c7VRGfCFQ2qynZpXc18vn81z4kucCB8GOaag2e
    +yqaeSu6hB2Ps0GA+0the0gRtsAMtdod6R0Jc79Xn0+hsayY96klKoLkgYspUjHqCdCc
    XXoXhLFn39M4MKF2px/5z3K/cILoXPlyd1JunJqrXrzCjIJHxwchyDqespdXwC0zfNym
    xezCQ9cvofLYIkQjjXDaTGN4HeOOVk2s1luYABK8zBOcq94tbo4WMyYmK6Q13EKo3x65
    ajE+2I8qsj6Gp2ZXkMpVrqSttf5M7NAl/lF+qIKYZjXjtNQhsTEkuSJBg+Dtk96qZ4hx
    GtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616485551;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CmIu2MA93XDFmrtFzpr67oVqTlKv0FFgJFFKMq6G36Q=;
    b=UE0irVoz48Q+juUH5ssHuuvcqgf34ybYf9BOK0SX6LXAHqaXt/oCEawCETUYrDXVtf
    2FVHzR2D3R+jZ/u0Inh6spZeBxHYJ9F1SQxa/bTs54ALhlwUNQGTXAj07Fh43rXcxvj7
    BJTG5VoW/AR958y8RBnhYrHkrrsbqeNlvK/aK9cOW0FbuXC86QgEuKl5DvAnFddp6tb8
    htEXcjNio62pjClidOG8Wo9Kt/+d2gGnX0ak1q1X2WB8UP/eJQXhEuox7oCukdB3fhAB
    EdmsOIC7v84XeLZO0pB0XqEU3zYNghL2fRkWBKNgaxXbqplY4FYxv1LUa/SKH3owMj6c
    QYJw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616485551;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=CmIu2MA93XDFmrtFzpr67oVqTlKv0FFgJFFKMq6G36Q=;
    b=r5iRS84ZzjKdxUpyEXSGuF15Vzf9gN9HHaMbvGPoXgXjUq5QkgTHr1yBpXDiylvHLl
    lRJpzNjvpv+a1P9dzAUbbbu834ScqMx2fMsvf4cYVUH96xCftNbnN9OYA9NUk1sO4xRt
    EhlV9QHtbJlbQceOLLKs9q9A2a8uAZUwGxnAm5J6wzXdF7ysj3cQ9bIcenO8PGABzFAI
    Uv2B81CL8ybjp13jhoYpVdHVAeLH1dZMagfCcEoePn/lm6PpPOpY+ukYZnz8QpwX5zFf
    5l8BVXkd5hApd7EDDtlEKufR4IZv8TZwhhLglHzz5ezJBfqDOStaRrQC72M+SuYBV2bv
    hpEw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xswl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2N7joDr4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 23 Mar 2021 08:45:50 +0100 (CET)
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        Patrick Menschel <menschel.p@posteo.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
 <20210323073437.yo63wreqnubbeqby@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
Date:   Tue, 23 Mar 2021 08:45:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323073437.yo63wreqnubbeqby@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 23.03.21 08:34, Marc Kleine-Budde wrote:
> On 23.03.2021 10:54:40, Rong Chen wrote:
>> I tried arm-linux-gnueabi (gcc version 10.2.0) and the problem still
>> exists, btw we prefer to not use the latest gcc compiler to avoid
>> false positives.
> 
> FWIW:
> 
> I'm using latest debian arm compiler and the BUILD_BUG never triggered.
> gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> 

Thanks Marc!

IMO we facing a compiler problem here - and we should be very happy that 
the BUILD_BUG_ON() triggered an issue after years of silence.

I do not have a good feeling about what kind of strange effects this 
compiler issue might have in other code of other projects.

So I would explicitly suggest NOT to change the af_can.c code to work 
around this compiler issue.

Let the gcc people fix their product and let them thank all of us for 
detecting it.

Regards,
Oliver
