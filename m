Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1230BBA6
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 11:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhBBKAe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Feb 2021 05:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhBBKAG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 05:00:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23801C061573
        for <linux-can@vger.kernel.org>; Tue,  2 Feb 2021 01:59:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id e15so6882772lft.13
        for <linux-can@vger.kernel.org>; Tue, 02 Feb 2021 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=meng3+TcOaV10C/VHk29at8BfkTG6/w2wrEo/wAAC/g=;
        b=nhnqnBHzvKxPcaKyXkifrWqU6G00ec0ihOQuSESocfDj0XY0QyrLWT5h5m2lmjRDnD
         ZevHaZprORQN5BNuUgM5o3aD/Gv3JWVebaDf1u6SeMuoxlWWqBLsApc3FkMuPJ6tvt+n
         wBCiweU+fXESmxPcWNk7DudeyBSsoK0autXuynImF8nhNafUSdpV2vdtnFfJ98n6dRI9
         Kdw7l4BRY05uEvuNn6mP+DQKa1Go9F0xulFW5rkyk1L5kjZvvywRk/PTYYbKs56pMuJo
         qcvlBVRIG4U3GINjL9x/EmnRrdTJXjCN76/Bk0Ye4nNk2smbpiwGkLzPQZiXiPhuI3ws
         cwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=meng3+TcOaV10C/VHk29at8BfkTG6/w2wrEo/wAAC/g=;
        b=FkyXPpzOtxe3RaMNT9KL2HUs+dSTMSl+/O4WqpYCIQosOjE14sRLEoPRXL9N5JDKd8
         0X7NSOhVkLTzwJwNkYqrJTd1H1FbKf9bl/0cJglzGHACNOl2mQ7oNjO0GnVewFVM15Dp
         mHhNAUm2726GkFK1E1pmkV2Tp14sydONW1sCS9ou8i1HIdg/L7Y7TKpSqJSnorFvDkeN
         v2sSe7mLcoRt0RzoLsVVZhGsAnMEIFCGfIv98z/Tl/Fudatl6FP9iOapVZVlALa4bs9e
         IUv0Lv2pOt+uPw/72mcHhb7mSN9FH7kJWOvhCZYLWebX88copeXhiicuaA7asmVfVM6i
         +g8g==
X-Gm-Message-State: AOAM531yavirTJSP7onRalEWNCCAjdw8Rhv5bZvHCU8sBy4R66jc/Xhl
        hSWk/aIxD9MQaZmXXySpD9z3JA==
X-Google-Smtp-Source: ABdhPJxj+cEmoJ/31uqKliUnPX/RiwXAog2tOYRUOJlhDWUimePGJj9R6Ig1kf37RXiYY1294fVuqA==
X-Received: by 2002:a05:6512:14f:: with SMTP id m15mr10354133lfo.304.1612259964649;
        Tue, 02 Feb 2021 01:59:24 -0800 (PST)
Received: from [10.0.3.39] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id g27sm4274339ljl.82.2021.02.02.01.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 01:59:23 -0800 (PST)
Subject: Re: [Question] Sending CAN error frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
 <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com>
 <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <fc4a285a-2260-3bd3-9abc-887976685c25@kvaser.com>
Date:   Tue, 2 Feb 2021 10:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-02-02 01:22, Vincent MAILHOL wrote> On Tue. 2 Feb 2021 at 00:41, 
Jimmy Assarsson <extja@kvaser.com> wrote:
>> On 2021-02-01 15:19, Vincent MAILHOL wrote:
>>> On Mon. 1 Feb 2021 at 05:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
...
>>> There are two forms of error flags:
>>>     - The active error flag: 6 consecutive dominant bits
>>>     - The passive error flag: 6 consecutive recessive bits
>>> Can it generate both or only one of these? Is it generated as
>>> soon as the device receives the command or is it generated at a
>>> predefined timing (e.g. beginning of the frame)?
>>
>> It can only generate the active error flag.
>> It will generate an error frame on the bus as soon as the bus is idle.
>>
>> $ sudo ip link set can4 type can bitrate 100000
>> $ sudo ip link set can5 type can bitrate 100000
>> $ sudo ip link set can4 up
>> $ sudo ip link set can5 up
>> $ ./candump -c -ta -H -d -e -x can4,#FFFFFFFF &
>> [1] 177884
>> $ ./cansend can5 20000000#
>>    (0000000084.786201)  can4  RX - -  20000080   [8]  00 00 00 00 00 00
>> 00 01   ERRORFRAME
>>          bus-error
>>          error-counter-tx-rx{{0}{1}}
>> $ ./cansend can5 20000123#0011223344556677
>>    (0000000086.798898)  can4  RX - -  20000080   [8]  00 00 00 00 00 00
>> 00 02   ERRORFRAME
>>          bus-error
>>          error-counter-tx-rx{{0}{2}}
>> $ ./cansend can5 20000000#
>>    (0000000087.385292)  can4  RX - -  20000080   [8]  00 00 00 00 00 00
>> 00 03   ERRORFRAME
>>          bus-error
>>          error-counter-tx-rx{{0}{3}}
>> $ ./cansend can5 20000000#
>>    (0000000087.911860)  can4  RX - -  20000080   [8]  00 00 00 00 00 00
>> 00 04   ERRORFRAME
>>          bus-error
>>          error-counter-tx-rx{{0}{4}}
>> $ ./cansend can5 20000000#
>>    (0000000088.404890)  can4  RX - -  20000080   [8]  00 00 00 00 00 00
>> 00 05   ERRORFRAME
>>          bus-error
>>          error-counter-tx-rx{{0}{5}}
>> $ ./cansend can5 005#FF.12.20
>>    (0000000093.061655)  can4  RX - -  005   [3]  FF 12 20
>> $ ./cansend can5 005#FF.12.21
>>    (0000000094.667557)  can4  RX - -  005   [3]  FF 12 21
>> $ ./cansend can5 005#FF.12.22
>>    (0000000095.617019)  can4  RX - -  005   [3]  FF 12 22
>> $ ./cansend can5 20000000#
>>    (0000000097.883071)  can4  RX - -  20000080   [8]  00 00 00 00 00 00
>> 00 03   ERRORFRAME
>>          bus-error
>>          error-counter-tx-rx{{0}{3}}
> 
> Thanks for the example, things are now clear.
> 
> So the error flag always increments the RX counter even if you
> are the transmitter.

To be clear, the printouts (from candump) are from the interface
that is not transmitting the error frame (can4). I transmit error
frames with can5. However, the transmitting interface (can5) will
also detect and report the error frame (and increase the rx error
counter). The only difference in the above example would be that the rx
error counter wont decrement when can5 successfully transmits a CAN
frame.
Sorry for the confusion.

Regards,
jimmy
