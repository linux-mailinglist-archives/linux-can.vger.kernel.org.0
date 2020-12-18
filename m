Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C772DE89E
	for <lists+linux-can@lfdr.de>; Fri, 18 Dec 2020 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgLRR4F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Dec 2020 12:56:05 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:20243 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgLRR4E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Dec 2020 12:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608313928;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=QcgOyR3QlaXZ7AAlI/WERV0dnXGw65sQK2OTh5Fnh/Y=;
        b=UgxOFdIW9rpK7FpWVCMYPG0PYp8LUlvou72jf2ZX1l63+pvIqPmqJ9GN0IHnHZ1awP
        LqgnmA+Vc19UcChYkn86dKC9HN+r1a/8hMxgPjtjNzKuQYbNJZbUY+Yoq0k8moX5qPNe
        VXbDVldNfNkwhtwuG+pbF53FsEe+WIiL3nOECZBHE9t7PpQcE3VJsEV4QS6NAcIK1VdR
        ZD+IJU7siEp1bDbtaXC8Y1sxL0T1Emp/KMxo+3Eo3DWhmxkvyyHL2W/tQiNnBwyw2psX
        m2+HOhn6CbRz88u6BJ31DDmdMnpYKRurJJFR4Y/W8mJ+O0MyOypmr2MU+vx8O3QTGn2V
        3G/g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57T1lT8qMWw="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.9.3 DYNA|AUTH)
        with ESMTPSA id 604390wBIHq72ve
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 18 Dec 2020 18:52:07 +0100 (CET)
Subject: Re: [RFC PATCH can-next] can: raw: return -ERANGE when filterset does
 not fit into user space buffer
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Phillip Schichtel <phillip@schich.tel>
References: <20201216174928.21663-1-socketcan@hartkopp.net>
 <0c029db1-159f-dc02-75e6-af68c4306edb@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e8e2e110-b1b7-1a61-7f99-bb3af2e71459@hartkopp.net>
Date:   Fri, 18 Dec 2020 18:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0c029db1-159f-dc02-75e6-af68c4306edb@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 18.12.20 08:43, Marc Kleine-Budde wrote:
> On 12/16/20 6:49 PM, Oliver Hartkopp wrote:
>> Multiple filters (struct can_filter) can be set with the setsockopt()
>> function, which was originally intended as a write-only operation.
>>
>> As getsockopt() also provides a CAN_RAW_FILTER option to read back the
>> given filters, the caller has to provide an appropriate user space buffer.
>> In the case this buffer is too small the getsockopt() silently truncates
>> the filter information and gives no information about the needed space.
>> This is safe but not convenient for the programmer.
>>
>> In net/core/sock.c the SO_PEERGROUPS sockopt had a similar requirement
>> and solved it by returning -ERANGE in the case that the provided data
>> does not fit into the given user space buffer and fills the required size
>> into optlen, so that the caller can retry with a matching buffer length.
>>
>> This patch adopts this approach for CAN_RAW_FILTER getsockopt().
>>
>> Reported-by: Phillip Schichtel <phillip@schich.tel>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Added to linux-can-next/testing. Do we need an update to the in kernel
> Documentation?

Yes. Also thought about it.

Will prepare a patch for the documentation too.

Regards,
Oliver
