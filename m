Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3386D0CBB
	for <lists+linux-can@lfdr.de>; Thu, 30 Mar 2023 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjC3RZ1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 30 Mar 2023 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjC3RZL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Mar 2023 13:25:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAAE1A0
        for <linux-can@vger.kernel.org>; Thu, 30 Mar 2023 10:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680197105; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=isXloYelLA1tYBgEPb8gEhl8R2XjQxexpVZoOoDAoduGvPLiFL6fNGgCPZCnUONs7+
    1y1MrJQq1HI+ia1Q+CRTY9E8mx8h+msQTpPvlG3MkiF8lD3cZVbKz8DHZKeSSA59PduE
    scu4GmUPuZdyD9DhiC66Ukw37OD8oXyccCS2jwgSJ7fre5nbgsMMG/xgrKKE1lmzTlZb
    6h/QvksW/6vOjKIuGs9czpz3w9xtG/0nWqwt0nqyaTJuu6ZStmem6uFFrkViHHy3VWbV
    VU6SQxctwNT7CrEU1el6hlvbpwZY0Xqfu1d7mAR53dsqxkrzge5cnc2e4Bq3zRIwqNn7
    iRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680197105;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0eP5jMK/9gfK1S6yl7hP7Hslg5r2p4GX6yEXMmg0tHk=;
    b=SjGOvzWS5RK0ZFxVygcOPee+OiXohXPjb1Vd+3+fgXEyE9+ctHzJpzPU7+Q4chUUdD
    b2jGjm8d9E9amS+TCQglsCTaCo38wr96duRxKoyZmfa6mj5vME4ynXRTfylnWnvBGXT6
    raZwJdtxpi3LwJ8CIP5+iZC71RC7/WHLXb1icNxziJj5x2cZy5URppy+0BRXM+7ApFi0
    sNpbYtwqLbem1r1Jk5RKaJoWxb6Cucr5D3ogXdGTbtD8bdri8yYl6qfh+6FV7v2+1yrU
    USGYleG7vNUb6p7/Eixehd8vHUkXHkyIzpnb+NqwBtnmnlavxLGk+MFk0NePwJZV5UWV
    jZow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680197105;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0eP5jMK/9gfK1S6yl7hP7Hslg5r2p4GX6yEXMmg0tHk=;
    b=KxEoZW3iyybdqJRSQQWuphF9uSZDOoMVEonsgBx54QlOFluZQTH3BBuGYc0EcakUwJ
    fvgJ2z3bhwGgMQ+U4Hvzw+gpDSppO/gMdqelHTWKwgMhXFV8Iplm1OU6NHAXMruL3d13
    z9icwETE91nHrTs8EVn3f8fgKs1yywxaZ2US5wme/SIkTSoDpfGVj5BWZCrn4pIZ1Tb+
    /2Jvq22oAD6w7E5PI1A0CQ3yaX4PSBn0hMLJ2MsnW2ShCgQwEZGD+BHblEJ1AYwAirT0
    HIsySq3ogQ67lGH9zqRBi4pvIxqHg+UOjPT3SauLHEqk7TxqZ93OxxkbkphG22DZWe0M
    l9iw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2UHP5gun
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 30 Mar 2023 19:25:05 +0200 (CEST)
Message-ID: <11c6b18a-c445-41f1-c11e-b42573d1621c@hartkopp.net>
Date:   Thu, 30 Mar 2023 19:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Lost packets on ISO-TP and vcan
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Jakub Jira <jirajak2@fel.cvut.cz>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
 <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
 <87zg8vjyqg.fsf@steelpick.2x.cz>
 <40f9aad6-81be-e442-2668-cb349fe7313f@hartkopp.net>
 <87mt4tu4ow.fsf@steelpick.2x.cz>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <87mt4tu4ow.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

On 03.03.23 18:26, Michal Sojka wrote:

> I tried the exact same commit. When the system running the test is
> mostly idle, I have to wait many minutes to loose the packet. But when I
> run the test simultaneously with Linux kernel compilation on all CPUs
> (make -j$(nproc)), the packet is lost almost immediately.
> 
> I'm still testing with:
> 
> - receiver: ./isotp-poll-test -s 321 -d 123 -i -a -b -q
> - sender:   ./isotp-poll-test -s 123 -d 321 -o -w -b
> 

I've performed some more tests.

The poll V2 patch seems to do the job!

The problem with the kernel compilation is caused by scheduling in the 
way that the receiving process is not fast enough to grab the PDUs from 
the socket until the socket receive buffer gets an overflow.

To prove this idea I added the possibility to detect dropped PDUs in the 
recvmsg() syscall of isotp.c, see:

https://lore.kernel.org/linux-can/20230330170248.62342-1-socketcan@hartkopp.net/T/#u

Additionally the isotp-pool-test was extended to retrieve the 
SOCK_RXQ_OVFL information.

And then "compiling the kernel" the drop counter triggered every time.

So I added the option the increase the sockets receive buffer and with

./isotp-poll-test -s 321 -d 123 -i -a -b -r 20000000

(as root)

the drops were gone - even when compiling the kernel.

See https://github.com/hartkopp/isotp-poll-test for the extensions of 
isotp-pool-test.c

@Michal/Jakub: Feel free to try this out.

Thanks & best regards,
Oliver
