Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0F140D71
	for <lists+linux-can@lfdr.de>; Fri, 17 Jan 2020 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQPJa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jan 2020 10:09:30 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:22108 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAQPJ3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 10:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579273767;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=HL4s5nll/xO8bB5emC78oqFiY2gTAwyypU3rIYh6U90=;
        b=CdOFq4QbOxF7ybsWR9s9eF6xwpYnlW5jrkAYrtU59EASJCNohzMhalhz89nDWQ6ShW
        ejV6yuZYfY7lJrxSZiCxD8Jed+qL9y/wUoq5VkiyQo3v5kjdpvp+Sx5Mr/o/WCvRgp9q
        AGSGGMld5v6IZjLlb+9A8DdbaEW2ye8IAVQ1TIh3F2wfV9Nae/8kNky+k+cnxT8PhsDA
        0N1UGoZ7GOrcYHjI3f1Odo5BWsoXxtDuqm/207aCEx3iyGPdp3NJGheckWYmnKXHX2Vg
        QWnh8XkHojBHJZai3bVvWn9dpirDldEb84vAlF1TJolVHFc9hAcHvn5Z7IQKp7Y/YbN3
        T2Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKNteTQLYO"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id 3013f9w0HF6PTCu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 17 Jan 2020 16:06:25 +0100 (CET)
Subject: Re: VCAN and CAN-FD DLC versus data length
To:     Andre Naujoks <nautsch2@gmail.com>, linux-can@vger.kernel.org
References: <ec6ffa3c-b208-b76a-d1ac-afd2fb1182a7@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <444ec681-0591-daf2-84ac-feed5c18ecf9@hartkopp.net>
Date:   Fri, 17 Jan 2020 16:06:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <ec6ffa3c-b208-b76a-d1ac-afd2fb1182a7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Andre,

On 17/01/2020 14.26, Andre Naujoks wrote:

> If I send a CAN-FD frame with a length, which is not directly 
> representable by the DLC field, the vcan driver conserves this value. 
> E.g. a Length of 11 is sent and received in userspace, even though there 
> is no DLC representation for 11.
> 
> I talked to a colleague about this and we could not think of a case, in 
> which this behaviour presents a problem. It is just a small discrepancy 
> from how a real CAN would behave.

Right.

Last time when we changed the can-gw we had a discussion about this 
"sanitizing" of CAN specific data length here:

https://marc.info/?l=linux-can&m=156537620228658

1. When we get a CAN skb from the real CAN interface this is correct (in 
CAN length)

2. When we send stuff to the real CAN interface the value is fixed 
before writing the content into the CAN controllers registers.

> cansend from the can-utils package actually makes sure not to use a data 
> length, which is not directly representable. This is the output of a 
> candump oagainst a patched version, which does not "fix" the length.
> 
> $ candump any & ./patched-cansend vcan0 123##011223344556677889900AA
>    vcan0  123  [11]  11 22 33 44 55 66 77 88 99 00 AA

Yes. vcan is just forwarding frames without sanitizing. And even the 
can-gw can be used to (intentionally) create weird values in the length 
field - but makes sure that the length boundaries of CAN (0 .. 8) and 
CAN FD (0 .. 64) are met.

So using the len value e.g. in a for-statement never lets you write 
outside the CAN(FD) frame data[].

> Does anyone have a real case, which would warrant a patch to the vcan 
> driver to change this? Or should the CAN stack even return EINVAL on a 
> data length, that is not representable?

As we had that discussion in the URL above and I can't see anything 
breaking I would tend to leave it as-is.

When we would sanitize the vcan skb flow we might end up with many 
skb_copy() cases instead of skb_clone() (permormance!). And as people 
may create skbs with PF_PACKET we are also not able to fix-up the length 
until it reaches the driver layer anyway.

Does that fit for you?

Best,
Oliver
