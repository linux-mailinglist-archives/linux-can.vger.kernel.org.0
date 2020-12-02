Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688082CC23B
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 17:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgLBQ1I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 11:27:08 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:11994 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgLBQ1I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Dec 2020 11:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606926256;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yJjgF8dOL6lwf0hmnUYZCr0Aq9lkYwrdRYbr2v6wxSU=;
        b=DgyMDMm0b0tDJrGsXrA76QdxLI0DG3NJEw9ZEdzLjVwgvwOZNN1HskBq/ZWnwBX8+W
        /TLe+O9vv/lQ5TqdyKVCs5iC2NUsKZXrD6odfCCxOi8MgrAzsvfm/7GwXE1okhFCJxs7
        tcK2OGlz0f0opGYcuvzj2aGgEYmPwqkzseevCaOf5olDotJnONqrqFOl9Nde6mq/vBfT
        vhPWEVv0znZMONJgBFvtUbnol7MNLdmo2VVwM8KrJNWXNHMdK/B79kCZjkUOUMjBNliJ
        pc7BL/z3mmzbdkrd9tivTFOG1Pvaypz85sznW2rglk5JxwWIOHYMPCZM9u/SRlqI8kef
        3WJQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iO89vpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB2GOECYq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 17:24:14 +0100 (CET)
Subject: Re: rx-dropped increases if the can module is not loaded (yet)
To:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <269cc265-272e-6b57-0f95-90a3bd66aea3@victronenergy.com>
 <438db92e-692a-5fcf-db97-7ba3a51c97be@hartkopp.net>
 <dea3d0e6-9e75-671c-b318-830b080ce5d5@victronenergy.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <8a05136d-5582-c8ef-012c-fc6a25ba744b@hartkopp.net>
Date:   Wed, 2 Dec 2020 17:24:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <dea3d0e6-9e75-671c-b318-830b080ce5d5@victronenergy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.12.20 16:47, Jeroen Hofstee wrote:
> Hello Oliver,
> 
> On 11/28/20 6:44 PM, Oliver Hartkopp wrote:
>> On 27.11.20 17:09, Jeroen Hofstee wrote:
>>
>>> Since it took me a while to figure it out, it might be worthwhile to 
>>> share.
>>> If a CAN-bus network interface is first set to up and only later used,
>>> the messages received in the meantime are counted by [1] as dropped.
>>
>> Interesting! But makes sense and is consistent: When the CAN frame is 
>> not processed by the network layer is is just dropped in the rx path.
>>
>>> If the the can module is modprobed before the interface is upped, this
>>> is no longer the case.
>>>
>>> Perhaps it saves someone some time.
>>
>> So far we have not documented these details for the existing netdev 
>> statistics. Do you think this is needed when the behaviour, which 
>> leads to rx-dropped, is common for other netdevs also?
>>
>>
> 
> Don't know... Perhaps we should simply wait and see how many
> people show up wondering where the rx-dropped frames are
> coming from?
> 

ACK ;-)

Regards,
Oliver
