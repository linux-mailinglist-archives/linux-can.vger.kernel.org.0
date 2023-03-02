Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683986A8AED
	for <lists+linux-can@lfdr.de>; Thu,  2 Mar 2023 22:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCBVDv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Mar 2023 16:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBVDu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Mar 2023 16:03:50 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B4193CB
        for <linux-can@vger.kernel.org>; Thu,  2 Mar 2023 13:03:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677790842; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l+rzK9p4Ugl7TTK/1cxewF8r5BHbifXCRSnlQHO7WCRauDYCZOYZp4UA6QhwTMHHkU
    +2AonqlB01XGB/YJdKjH9WMxzV1nLtMz9ZyuFG34EYeJKd76p9ka5WIjckZIuVPyyVRg
    ZmU8aBd29bcLFgLtOzbmiZr/oRspc1W7FvLz+IP2YXruxH350U5W4Mnf6q6sP2m5lmSf
    YiZaDP0/lgpM9NlxmwrV//KavNwLLZuP7GYODupfv60wo8mODI1rzePyzwq70CTN+zyl
    1OrMOrGj42nTz6pNmr1j01TzsvayRbDP2fs2gf4eI4n3KmYil7MnPbI+HN9urD6xs4bu
    77xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1677790842;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MXzeWwsizsGpLRmnKztwU0mO2yQnN00JLvU0JJkpzCE=;
    b=LHkqPa1Os+QhwpHvzF+wd0jOCT5T2293tIqhatM/VMINJCOfdTSBVZZAVS0Wp22XUX
    LJRjhyRBOto5/X8dj0kQqjk4vnu3OYXkWud5ZfcjvVuIYeAcCc+z+Laot44V+aS6czNB
    WRSTgmdDc1MUvvVDhibytrnC51qRHhTozkTFgPAc6hudxEVSpOTepEWeL8tbYGV8QSXM
    BRoGLTrHu+9hyesFCnI33CiUMhH1XwtF+dvdAzSu9bF+fyo4lel30gbK8/YzOa5GHvwD
    tYvKin04aHKdkZXatWJ8p0li6HTN/Cr4VO7RmzMQtrIJf9IKbdmDcyFuRbxy1kKcl2f4
    puGw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1677790842;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MXzeWwsizsGpLRmnKztwU0mO2yQnN00JLvU0JJkpzCE=;
    b=eUCfQ4igf5fBIUMDV38ral63yFn2qmpbQS5U8IZKi7rNe9kErhYZsd4icbxwekJXQl
    ZAcPyeHCu8vl1WGwoD5DB949FGsZeIZM0Qt1vCykHdW2T8il0NpSb3vU+O85Zlgds5iW
    eMOx3HSwwHUn3D6sMTn5YjwSaEKyMylMZpefL1oat8KbDDhH4CjFX1AkMD6khTve9Nmu
    0XYCYGDW/z32DiCoTuLcUeOtHowv9lcHHv+mg96NG7FD5672134SoKjNqFn1qbgX5eRO
    4rbcJC+Hl8vB9bd8fiR+Ap+t9lFdNgjUUgoQTBgOiLo1O12obhR8OYVJVeVxFswyYX6B
    FfTA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id c675b3z22L0g7vU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 2 Mar 2023 22:00:42 +0100 (CET)
Message-ID: <40f9aad6-81be-e442-2668-cb349fe7313f@hartkopp.net>
Date:   Thu, 2 Mar 2023 22:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
 <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
 <87zg8vjyqg.fsf@steelpick.2x.cz>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <87zg8vjyqg.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michal,

On 02.03.23 10:20, Michal Sojka wrote:

> On Wed, Mar 01 2023, Oliver Hartkopp wrote:
>> I can not see problems or drops when using
>>
>> ./isotpsend vcan0 -s 123 -d 321 -D 9 -li
>>
>> as data producer where I added a counter:
> 
> Really? 

Yes ;-)

> I tried to modify my test program to also support blocking
> operation (without poll()) and setting CAN_ISOTP_WAIT_TX_DONE. It's
> available at https://github.com/wentasah/isotp-poll-test/blob/fd095b2242c49dc5d3e36faf5ac9f4f47fd002c7/isotp-poll-test.c.

Cloned it.

> With it, I detect lost message in mainline Linux 6.2, but sometimes, it
> takes quite long time (a minute) before it happens.

Hm. Everything fine here with 6.2.0-12944-ge492250d5252.

> What happens is well visible with strace. When I run the receiver as (-b
> stands for blocking operation without poll()):
> 
>      strace ./isotp-poll-test -s 321 -d 123 -i -a -b -q
> 
> and then the sender (-w means to use CAN_ISOTP_WAIT_TX_DONE):
> 
>      strace ./isotp-poll-test -s 123 -d 321 -o -w -b -q

Running these two (without strace) for 15 mins now:

Hello20160713

and counting ...


> The output of the receiver is:
> 
>      read(3, "Hello122813", 99)              = 11
>      read(3, "Hello122814", 99)              = 11
>      read(3, "Hello122815", 99)              = 11
>      read(3, "Hello122816", 99)              = 11
>      read(3, "Hello122817", 99)              = 11
>      read(3, "Hello122847", 99)              = 11
>      write(2, "isotp-poll-test: ", 17isotp-poll-test: )       = 17
>      write(2, "Lost messages. Expected: #122818"..., 50Lost messages. Expected: #122818, received #122847) = 50
>      write(2, "\n", 1
>      )                       = 1
>      exit_group(1)                           = ?
> 
> Sender's output looks as follows:
> 
>      write(3, "Hello122813", 11)             = 11
>      write(3, "Hello122814", 11)             = 11
>      write(3, "Hello122815", 11)             = 11
>      write(3, "Hello122816", 11)             = 11
>      write(3, "Hello122817", 11)             = 11
>      write(3, "Hello122818", 11)             = 11
>      write(3, "Hello122819", 11)             = 11
>      write(3, "Hello122820", 11)             = 11
>      ...
>      write(3, "Hello123116", 11)             = 11
>      write(3, "Hello123117", 11)             = 11
>      write(3, "Hello123118", 11)             = 11
>      write(3, "Hello123119", 11)             = -1 ECOMM (Communication error on send)
>      write(2, "isotp-poll-test: ", 17isotp-poll-test: )       = 17
>      write(2, "write(sock, str, strlen(str))", 29write(sock, str, strlen(str))) = 29
>      write(2, ": Communication error on send\n", 30: Communication error on send
>      ) = 30
>      exit_group(1)                           = ?
> 
> So my impression is that this does not relate to poll() implementation
> changes.

With strace too.

strace ./isotp-poll-test -s 123 -d 321 -o -b -q

strace ./isotp-poll-test -s 321 -d 123 -i -a -b -q

No problems with your V2 patch either.

> I also tried to update my poll patch to take into account the so->wait
> wait queue. But the result is the same as without it. I will send it in
> a separate mail.

I only get a problem when removing '-b'

strace ./isotp-poll-test -s 321 -d 123 -i -a -q

poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN}])
read(3, "Hello716", 99)                 = 8
write(2, "isotp-poll-test: ", 17isotp-poll-test: )       = 17
write(2, "Lost messages. Expected: #715, r"..., 44Lost messages. 
Expected: #715, received #716) = 44
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?
+++ exited with 1 +++

Hm.

Best regards,
Oliver
