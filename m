Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD23459BB
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 09:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWIc7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 04:32:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:28465 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCWIcg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 04:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616488331; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DbgzEnR/3yD9m/RpSCcQK6LwJhecbCkN1k6IUG83Ysh+2+dLZEwBdGXXFqfJUtJGa2
    6qC92SgHT7j8FPsU+wTzPk4gKC6UGph9A2fmTiTPHc+BQVT2su/DUADhmLM0KutQU2tY
    R3FpVu0HKQBcDaQZfRrt0oZH9pscQZZtpkhAyAXo9d4JUg0zkBNqukdq3Ri0rr+vnniJ
    7y8nLnmFAjHRYF7CGELeFY9p+JPLkHCqQUm1nSzPJyf0pnL5QNhgkYNuigGL1+wLZduk
    iX7nEgehS0UNOBbsuVYavHYBZaFxd0qVmFZdcf4Nrk/K13eao67RuKlve3gepXUqG8XS
    wArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616488331;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Y4IgOnzalvu2hjJrcEWQexr5i07F4zEpuG/tdwxSpqk=;
    b=LF4TPEZA/fhFtpsKm83JnZleYaTCTacfL5KtcaW696bnzRwmxuKuCAKnyiMJ75SVw1
    ZR3Pco7Av2D5PnqEaRH7Ja1dKTlHJMX0XnEFQzzmOzNNHHjddWmfprcDVqf25umMr6wj
    CqjFUIsHuRCBlocSr89JljGD0yZd1rZhkietGJV+kTCoXD2c6Nkf/lkFd4bb76UjT1ES
    5jmQ5shQI8rW6uOpjpsinaSkRzoowEdz0KqfWdAourpisbB6LZL39/EM2S7tIII3DY81
    UocDhk3fmsZAk6RxS73jExsBBSq6DmF0B9YYCJsH7bf9HlltkGCTy+sEf0BljlrFMYTO
    jDmQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616488331;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Y4IgOnzalvu2hjJrcEWQexr5i07F4zEpuG/tdwxSpqk=;
    b=Z8/xM0hedv/iL2TnYQLXs8DF1oBjI1bjmYgmdifWfE4WYp7hKlp4FLqkDwa4i5BQ2V
    KsqGUX7mq8Kh9kAb/S3yq9zCmjBsDDbyJQ4vAUdW/+gLIuwagwmNP/dBeRdntsjqC4lb
    ysznzENcxnNhDoFZeQYb5CdbO5/5iez2m7t7C/Ag5t/o/mRG2QYYlsGj/4nsVnSdUQmD
    wYUXnTibARFMkp/s0OOk7OxIeqXdaIsfJlCxRKnFDDOZRSa6ruIuvflonbN7v7sNePY7
    rng/SpWq4SDCPxQ9biqmqUSHfLUUakE2g8PJhFe9WADYA6fQOj4aRbesyeHFSw6P0HM+
    2FFg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xswl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2N8WAE5p
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 23 Mar 2021 09:32:10 +0100 (CET)
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
From:   Oliver Hartkopp <socketcan@hartkopp.net>
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
 <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
Message-ID: <c0fb01a8-6a6a-7e5f-f932-697065d18600@hartkopp.net>
Date:   Tue, 23 Mar 2021 09:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <7ff6bfd3-6b4b-045a-abb7-485927909587@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Answering myself ...

On 23.03.21 08:45, Oliver Hartkopp wrote:
> On 23.03.21 08:34, Marc Kleine-Budde wrote:
>> On 23.03.2021 10:54:40, Rong Chen wrote:
>>> I tried arm-linux-gnueabi (gcc version 10.2.0) and the problem still
>>> exists, btw we prefer to not use the latest gcc compiler to avoid
>>> false positives.
>>
>> FWIW:
>>
>> I'm using latest debian arm compiler and the BUILD_BUG never triggered.
>> gcc version 10.2.1 20210110 (Debian 10.2.1-6)
>>

@Rong / Marc:

I wonder if the compiler configurations (gcc -v) or the options used at 
kernel build time are identical.

Maybe there is a different optimization option selected which causes the 
compiler to extend the u8 union to a 32 bit space?!?

And maybe Debian is a bit more conservative in selecting their 
optimizations than the setup that Rong was using for the build ...

Best,
Oliver

> 
> Thanks Marc!
> 
> IMO we facing a compiler problem here - and we should be very happy that 
> the BUILD_BUG_ON() triggered an issue after years of silence.
> 
> I do not have a good feeling about what kind of strange effects this 
> compiler issue might have in other code of other projects.
> 
> So I would explicitly suggest NOT to change the af_can.c code to work 
> around this compiler issue.
> 
> Let the gcc people fix their product and let them thank all of us for 
> detecting it.
> 
> Regards,
> Oliver
