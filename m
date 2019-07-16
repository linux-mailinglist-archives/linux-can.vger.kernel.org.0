Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1485B6A91D
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2019 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfGPND5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Jul 2019 09:03:57 -0400
Received: from mail.iot.bzh ([51.75.236.24]:59657 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfGPND5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 16 Jul 2019 09:03:57 -0400
Received: from [192.168.5.93] (153.79.119.80.rev.sfr.net [80.119.79.153])
        by mail.iot.bzh (Postfix) with ESMTPSA id 3071740098;
        Tue, 16 Jul 2019 15:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1563282231; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6A26yQff6e50jKdgEs0fay3jxwRVBJVmw+1qY9eKog=;
        b=tGLgcfkOGn5tltvlaAA6MItsUFCNxssv2Bym7XrzTQ7i/F0NXKpCYVS1gBuJxwtQYMmPmD
        r6oMaArWWf/8hJAHTlxVJEg9qK1zu7Sb64m7NFWm6MoO3w6dGfzJCEwLYdAtfn6CMuC8kF
        sNUTCyjfARj8i6at0kCltaYj4nzpdPxr6abmYQAjvzDN2Bl/mzMzCRhhLKtQK9wh+GHNja
        Py4fRhoJ2a4E2gr/GhxmNnClDIg8AdAz8RMLMFWI93c2D9hQIyyv3qisuEIWcMeMsYWK8i
        6hF9eiuH4HSO5XCJJfMEgWByLtGSB7Kvr2MwOIE4PZFazCme7Wrc3d0IQN5Upg==
Subject: Re: J1939 : Address Claiming
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be
References: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
 <20190706050020.GE22538@x1.vandijck-laurijssen.be>
 <f95b8200-31fa-e2f5-49a2-f576fae3cc9c@iot.bzh>
 <20190708084934.GA24954@x1.vandijck-laurijssen.be>
 <81056b49-a0c7-8b2d-d2d2-785b6107fd9d@iot.bzh>
 <a0d48616-86ac-a2f3-8d07-e0209e6f2021@iot.bzh>
 <e6ea6de2-e21d-04d2-656b-c71b68dbaa7f@pengutronix.de>
 <20190716070518.GA4257@x1.vandijck-laurijssen.be>
 <20190716073850.GB4257@x1.vandijck-laurijssen.be>
From:   Arthur Guyader <arthur.guyader@iot.bzh>
Message-ID: <9eaef783-53a1-efcc-b846-b90ef1274d57@iot.bzh>
Date:   Tue, 16 Jul 2019 15:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716073850.GB4257@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ok, thank you for response !

I wasn't at the latest version. And after updating the kernel, this 
problem disappeared.

Sorry for the inconvenience.

Best regards.


-- 
Arthur Guyader - Embedded Engineer - IoT.bzh

On 16/07/2019 09:38, Kurt Van Dijck wrote:
> On di, 16 jul 2019 09:05:18 +0200, Kurt Van Dijck wrote:
>> On di, 16 jul 2019 06:36:35 +0200, Oleksij Rempel wrote:
>>> Hi Arthur,
>>>
>>> On 15.07.19 16:15, Arthur Guyader wrote:
>>>> Hello,
>>>>
>>>> I encountered a problem when using the claiming address.
>>>> When an ECU1 with a low name requests an address, it is saved in the kernel cache.
>>>> If this ECU1 is cut, and we launch our ECU2 which will ask for the same address.
>>>> He will have no answer from ECU1 and has no trace of him in his cache, so
>>>> he can consider that the address is free.
>>>> However, the kernel will consider that the address is busy and generate an
>>>> error when sending a message. (99 : cannot assign requested address)
>>>>
>>>> How would you handle this situation?
>> AFAIK, J1939 does not describe a timeout on claimed addresses, so
>> technically, ECU1 is never really away.
>> The code will respect the j1939 spec, and will never timeout either on
>> that.
> Reading back my own reply, and trying to fix jacd.c, I realize that it
> is allow to contest an address, and if the remote didn't respond within
> time, you're the owner.
>
> jacd is written like that, so I assume the kernel code is blocking so
> to avoid unnecessary address claim congestion.
>
> It's not nice to put a 'recently seen' notion in kernel to decide if an
> address claim will problably fail or not, so that justifies to remove
> the check completely, but it's not nice to
> allow stupid contests either.
> I'm undecided wether to add the 'recently seen' or not.
>
> The problems you experience would in any case dissapear.
>
> Kurt
