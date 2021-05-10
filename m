Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB8378F3C
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhEJNlA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 09:41:00 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:20580 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbhEJM3v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 08:29:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620649719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=auIbreXz3V0ZNnogbYJDTNorEBMntL3zEZ1vwkenMVNQ+uSjkdNN/3c1oBSvpHV8+K
    YggiqcL8LXV2dtd//GAVlvZtq/97Gc/jW5zklg97GTHJ+VmMrFsxmwHysDlmhw8v1Mj4
    LxvwS36A+0N0L4GgLC7H2JRVYsWRYX8zqt9vTSIDlNktIKHeo3qi5uvWia0pHasdqXAi
    lSIjso82u48ACFhyLlBF1OXjnBUrWzYFj6vchN4opZSi+OThsTw9VhTDX36M6BvXSlrl
    7Do9ybDAbKfDRNK7AcvTx4AmP0aQmTXH0aeZ4/YUjZDazDUt0Uqp/am41cB0Pmwc1ZVD
    95yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620649719;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2Gu6Uf1rJimRewBWKwFkbOOrKkXWkJ8v9dvNuOb3GKA=;
    b=opvaPDa86zFCG8HwJZwkV/RKVWjclOOKkSPXgFBhxBsYqg7EWlNsrYfTdb1R5hwZNr
    muRWORdD8IOv5TGITR0uUwPiWPBEoexnPqfFx9KjTq82TWpEdBD9ZhFErYPtdqVqqjov
    pOo5Jz0vpyx7GdFrPvzRuDCoXl73sI3OBw0WkA7nwVdw/nwFP41ioysaPpHv4Hvh/OBA
    RHIzzBpoecf1gA/rZUxRGf/zEBj9lkIqdJzKSuez6+RyAIW9UQd5ZntPjbmevPG2yROv
    zyXffCOsc5FITrrzv0o7gTeOVonmJkjFvI1zebYdvtUUFBqFUUds4idBWTPH2Iu3WqVh
    sgOA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620649719;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2Gu6Uf1rJimRewBWKwFkbOOrKkXWkJ8v9dvNuOb3GKA=;
    b=T5FaP34NcKh9Pf67qscFxKreiRSkshUOql8eTd9/XHF1YZhR554+3tSpGngzvau69y
    BlURPJaphrO69HX2aW8ScAYBOob7ICyDSd+edNI1KestjzvngoKOY/nU6RMMAWXFWgID
    WMdxHkvdVzyAqYkgqlXU55VJ+LbqVyXlXxS6/2YwzlWcJmCHUkQ53BjK4vsbfnfhHUWr
    ulhkvcgxiYqprM0qxXbCMWlWwXXS6u2wjk6VSzdnXd4Wc9QdALa592UbSiRlYqiu6pJq
    Cpe7OlQyNfxqs2m/bPyMtffkA+PPiqUwP52AvKUgjVCmuwmEg5ZuY0rdqRKvFhh72Wxr
    cJiQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id e040b6x4ACSd7hp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 10 May 2021 14:28:39 +0200 (CEST)
Subject: Re: [PATCH v2 1/2] can: add support for filtering own messages only
To:     Erik Flodin <erik@flodin.me>
Cc:     linux-can@vger.kernel.org
References: <20210504203546.115734-1-erik@flodin.me>
 <20210504203546.115734-2-erik@flodin.me>
 <cf5fdb14-47e2-2d08-0d29-c621bff7b312@hartkopp.net>
 <CAAMKmocxj1zOQastSqKhHmV0-9HVh3NpPmSPWf=byxj+fFPUHQ@mail.gmail.com>
 <64bf5aaf-1e8c-2f29-8263-63710a771843@hartkopp.net>
 <CAAMKmoda0U912_6Qp97fzt4BjcbUPDrE8Cy5C7C-TS5_7du31Q@mail.gmail.com>
 <46bdff5c-c0ab-56e9-7c70-8a3267458d55@hartkopp.net>
 <CAAMKmocsZBsFfpRLyLHqFE94xb-xrm5S8YG=QzQTndDjtOyuzw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <64e37aae-e6b5-20aa-04fb-10b4a2f50b5e@hartkopp.net>
Date:   Mon, 10 May 2021 14:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAAMKmocsZBsFfpRLyLHqFE94xb-xrm5S8YG=QzQTndDjtOyuzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 09.05.21 13:28, Erik Flodin wrote:
> On Thu, 6 May 2021 at 07:26, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>>>>    From what I understood your main requirement is to double check the
>>>> outgoing traffic whether is has been sent.
>>>
>>> What I would like to have is:
>>> 1. Be notified when a frame has been sent. I send (from user space) a
>>> single frame and wait until I get confirmation before sending the next
>>> to give other nodes on the bus a slot to start sending, even if their
>>> frames have ID with lower priority.
>>
>> o_O
>>
>> Sorry, but I have problems to get behind your use-case.
>>
>> 1. You are sending a frame
>> 2. You get a confirmation
>> 3. You are waiting some time (which is not written above), to give other
>> nodes a slot??
> 
> No explicit sleep is needed. The machine is sufficient slow so that
> just waiting for the confirmation before sending the next frame is
> enough. But if the frames are queued in the socket/device then the
> frames are sent back-to-back.

Ok, I feel I'm getting behind your requirement ...

You mainly want to throttle the outgoing traffic, to make sure that e.g. 
a specific CAN ID is not sent 'back-to'back' and might lead to a DoS 
situation on the wire?!?

Do you know about the Linux CAN queuing disciplines that might provide 
the solution to your question?

See:

http://rtime.felk.cvut.cz/can/

http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf


A four-slides-intro to the concept can be found here (slides 41ff):

https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf

Best,
Oliver

> 
>> 4. goto 1??
> 
> Yes.
> 
> // Erik
> 
