Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F125B61DE9
	for <lists+linux-can@lfdr.de>; Mon,  8 Jul 2019 13:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfGHLrG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Jul 2019 07:47:06 -0400
Received: from mail.iot.bzh ([51.75.236.24]:56675 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfGHLrG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 8 Jul 2019 07:47:06 -0400
Received: from [10.18.127.29] (unknown [10.18.127.29])
        by mail.iot.bzh (Postfix) with ESMTPSA id 14E0E40054;
        Mon,  8 Jul 2019 13:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1562586419; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmKasP+yE2XTDt1kxf8Ekr7lsLjov0QpAOzrpvnNtuA=;
        b=mvvpfO84qnmQ6VE+06IsZlDi48MHqZIujrxCWNXHOP4Fw3tvAI8CmU+cc1Mm9CT9V7PPrQ
        AXuowGtCeSe0qIayXvzIwA2POUseJBzpkUDPbWIMWSOYFwrew6J8WOeNGufOxClyRCF51I
        TrmzzIgXKUgW1DJNJNppxvH7now2NZz2xc+E0Tm7jR9NDauQtYvF9J0Dm/rzu/+ifyR2N3
        XAJSbQH2ZKZVj8PIRXw97uFwKYLq9mHesuuuc7UkJqhS2PdeE0WnK+Urq7fe3bp7Di6rgJ
        NXfSqJslrKzzoIAwgylf7OEUuUyBHLf150+dEuSBBE3xCzhpDp7ch2/mQpb2Tw==
Subject: Re: J1939 : Address Claiming
To:     linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be
References: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
 <20190706050020.GE22538@x1.vandijck-laurijssen.be>
 <f95b8200-31fa-e2f5-49a2-f576fae3cc9c@iot.bzh>
 <20190708084934.GA24954@x1.vandijck-laurijssen.be>
From:   Arthur Guyader <arthur.guyader@iot.bzh>
Message-ID: <81056b49-a0c7-8b2d-d2d2-785b6107fd9d@iot.bzh>
Date:   Mon, 8 Jul 2019 13:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190708084934.GA24954@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

OK great !

Thank you !

Best regards

--
Arthur Guyader - Embedded Engineer - IoT.bzh

On 08/07/2019 10:49, Kurt Van Dijck wrote:
>>     Each time a new address is assigned I rebind the other sockets with it.
> This administration is inherently racy.
> That's why you better bind the other sockets by name,
> so you don't have to rebind each time the address changes.
> The kernel will, based on the address claims passing in & out,
> apply the correct address, if any is available.
>
> As such, you can push the address claiming socket in another process,
> and my re-use jacd.
>
> Kind regards,
> Kurt
>
>
> On ma, 08 jul 2019 10:22:21 +0200, Arthur Guyader wrote:
>>     Thank you for your answer !
>>
>>     Let me get this straight :
>>     I create a socket dedicated to the claiming address.
>>     Each time a new address is assigned I rebind the other sockets with it.
>>     If I use the wrong address, the message will not be sent.
>>
>>     Best regards
>> --
>> Arthur Guyader - Embedded Engineer - IoT.bzh
>>
>>
>>     On 06/07/2019 07:00, Kurt Van Dijck wrote:
>>
>> Hey,
>>
>> On vr, 05 jul 2019 17:52:16 +0200, Arthur Guyader wrote:
>>
>> Hello all,
>>
>> I looked at the code of can-utils and more precisely jacd.c.
>>
>> In the way it is implemented, the deamon's only objective is to change its
>> address according to the different requests it receives.
>>
>> That is indeed the only thing jacd does. It helps other programs that
>> use the same 64bit NAME so that they don't have to implement the same
>> thing.
>>
>>
>> More precisely, the socket is blocked until the next received claiming
>> address request (recvfrom).
>>
>> yes.
>> Since it's the only thing it does, there is no need to use non-blocking
>> calls.
>>
>>
>> In a real implementation, do you need two sockets?
>>      - one to receive and write messages
>>      - another dedicated only to the claiming address
>> Or did you have another solution?
>>
>> The objective is to have multiple programs or sockets open that
>> each implement a little functionality, and that share the same NAME and
>> address. To the outer world howevers, they must cooperate and use the
>> same address at all times.
>>
>> This is not technically enforced, you could combine all logic
>> in one program. In my experience, it's hard to get that one program
>> correct and stable, and it's easier when you divide it in pieces.
>>
>>
>> In the documentation, it says: "If another ECU claims the address, the
>> kernel will mark the NAME-SA expired", how can this be checked?
>>
>> This is implemented in the kernel-part of j1939, which is not yet
>> mainline.
>> That part does interprete address claim traffic.
>>
>> You cannot check that from userspace, other than finding yourself
>> blocked when using that SA. The kernel will enforce the address
>> claiming.
>>
>>
>> Do you plan to integrate the management of the claiming address (jacd.c)
>> into the kernel or leave it to the user?
>>
>> The kernel part of address claiming already exists, but is not
>> mainlined. It enforces correct operation on the bus.
>>
>> The userspace part is jacd, whose only job is to choose an address.
>>
>> kind regards,
>> Kurt
