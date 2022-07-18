Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A884577C25
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiGRHFr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 03:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiGRHFi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 03:05:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADC101EF
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658127935;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Cmq0Sq23722M1ub7zfVx17GaS8QVFyupflRRDPb/Jfo=;
    b=jQLLNctyUyyeObK2QZlpnpPui0oxilrF3x2apfUc1asayb+BVw3AT+memeQsaVT+iw
    ckpP7Z7wOlQ6kQr9HSXB0LTAKgRnLg/7EV7JmThxtBBy+ALBBuUca80bvmPZym/+3mtc
    cz+dkmm3FjMcIfd/dzCbFWUJIK7P+BAs9WA8/JnEbvZ5Yn3KPvTtB8T/dT8FYta5xKnh
    ZG+BcwXMhg13M+DZzmzKFEu8HLgws8CHKDLTNUzQIKRqUT0X/KeV5RGqGaecyUcenfPq
    qskHyKCXbZdobpFINxD4W2MEFYGpR+vPzY8TbjFcwswZrhDIXMSI/0hBMfLV99qU+UbM
    GsMw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6I75ZC5T
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 18 Jul 2022 09:05:35 +0200 (CEST)
Message-ID: <93511e4e-acad-90ea-cd37-7256f328909e@hartkopp.net>
Date:   Mon, 18 Jul 2022 09:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 4662b7adea50bb62e993a67f611f3be625d3df0d
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
 <2d6d9627-bc98-07e9-dbcb-5f317913f5aa@hartkopp.net>
 <CABGWkvqNSgweoLoeOwhEdz27pqYVBH32TLTeEwNRiXhncUeB3g@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CABGWkvqNSgweoLoeOwhEdz27pqYVBH32TLTeEwNRiXhncUeB3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Dario,

On 18.07.22 08:52, Dario Binacchi wrote:
> Hi Oliver,
> 
> On Sun, Jul 17, 2022 at 3:58 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Hi Dario,
>>
>> did you see this build regression too?
>>
>> On 14.07.22 03:56, kernel test robot wrote:
>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>>> branch HEAD: 4662b7adea50bb62e993a67f611f3be625d3df0d  Add linux-next specific files for 20220713
>>>
>>> Error/Warning reports:
>>
>> (..)
>>
>>> drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void *
>>> drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void [noderef] __rcu *
>>> drivers/net/can/slcan/slcan-core.c:601:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>>
> 
> IMHO I think that adding '__rcu' annotation would remove the warning:
> 
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 7b0a5d478ef6..278b84f04d20 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -239,7 +239,7 @@ struct tty_struct {
>          wait_queue_head_t write_wait;
>          wait_queue_head_t read_wait;
>          struct work_struct hangup_work;
> -       void *disc_data;
> +       void __rcu *disc_data;
>          void *driver_data;
>          spinlock_t files_lock;
>          struct list_head tty_files;
> 
> But in the paragraph "SPARSE CHECKING OF RCU-PROTECTED POINTERS" of
> Documentation/RCU/rcu_dereference.rst
> we read:
> ...
> Unfortunately, these sorts of bugs can be extremely hard to spot during
> review.  This is where the sparse tool comes into play, along with the
> "__rcu" marker.  If you mark a pointer declaration, whether in a structure
> or as a formal parameter, with "__rcu", which tells sparse to complain if
> this pointer is accessed directly.  It will also cause sparse to complain
> if a pointer not marked with "__rcu" is accessed using rcu_dereference()
> and friends.
> ...
> Use of "__rcu" is opt-in.  If you choose not to use it, then you should
> ignore the sparse warnings.
> ...
> 
> So, I think that by adding the '__rcu' annotation we would have new
> warnings in all those points
> where disc_data is accessed directly (which are many more than those
> where rcu_dereference() is used).
> 
> If I'm not mistaken, the warning also refers to code that my series
> hasn't touched. Also, in the 'BUILD REGRESSION'

Oh, I didn't check that myself.

So some old code just came into focus :-/

> report, the slcan warning is found under the 'Unverified Error /
> Warning (likely false positive, please contact us if interested)'
> section.
> 
> So, can it be okay to think about leaving everything as it is, and
> then not apply any patches to remove this warning?

Yes. With this this background leaving the code as-is seems to be 
appropriate too. Thanks for the explanation!

Maybe Marc has another opinion. So let's wait for his feedback ...

Best regards,
Oliver

> 
> Thanks and regards,
> Dario
> 
>> Do you take care on this one?
>>
>> https://lore.kernel.org/linux-can/20220717025703.pcrf6bseaigsq22r@revolver/T/#m54028de8868a0f653294f6a272a9094378a1cdd7
>>
>> Best regards,
>> Oliver
> 
> 
> 
