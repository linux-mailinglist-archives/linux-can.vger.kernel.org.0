Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860E86B6019
	for <lists+linux-can@lfdr.de>; Sat, 11 Mar 2023 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCKTRL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 11 Mar 2023 14:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCKTRK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 11 Mar 2023 14:17:10 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09034F60
        for <linux-can@vger.kernel.org>; Sat, 11 Mar 2023 11:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678562227; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CXYU3KwBwwE8VnUrQre38nt4k8PP1looLhFzBxB7Gdsqlk+fAdV96pSZ6bhJg6MSOg
    jjEQXhdXsUONw539ZVNgPlCSR04K2TYrD/PKuvpdIBwIi5EFQVkAGEpej2c2J9E4eiiE
    H4q7HYRVW3lIo74mMc6onDWQPo/GUinVqhrNoVMgt+gYvCK0fGfDoPCzhQphMH7l1kYV
    VsbZmoyh0S9o9pn2Pi0XfZ3qHMPigwf+wJOfXc0Nsx5X9uE3+4cNDQ8+1L+nevPCnt4d
    /mwgNONB2ULN9TRPpzpZqqgBnYVSUpVuNyMrMXxCk5UTGZ+GUwLfPRoZQOEM0I/H3Wk6
    KMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1678562227;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=/jKafbPTO2Z4s0vTgiyN8lvGP1Fg0JS/NFmhD3Evi/8=;
    b=J2Rook2HGEXD3qe+JiXpkQmFaOCcgBoiqzVC5YCq6+CLV4a1xzRJzjxOzC9HPc5B+A
    3mAuwuMGzuvWaEVfCvhRXtRh2k2KjNVb6UOfdyGItSOTbguR1dWKUydc/BQWI9+S2eg0
    xc6StdNhy667OZ+Zw074mmLT5KMNBcOOXY8lg0CONBwmU+BVx8uSr3vCAZig5ihaHvpN
    3/2aAEyEIH34WWTPzusmUuF5arTGpWY4rxhSyZOGbQiH0m/INVP7eLKiyAjXYH3rf1GQ
    HZg37E27VtHI1+xJ8ekI3DmGmUMmThzBMjZXSBkeX9UDay8ZaNzH8H63N3YqNKR+ottL
    9dcw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1678562227;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=/jKafbPTO2Z4s0vTgiyN8lvGP1Fg0JS/NFmhD3Evi/8=;
    b=iPyoiA8qxk0LxEgRqH3UOxWqxc+vqk4N39iDsgpopiCE5pGQ6Ye9ZUXDMXASKVbXZe
    cAkMHJgy4I77jav7xnPo+K3s3I+FfhGfgGOU3d8I0KkILLq9xHOqxIAwhn87vdhxATFv
    69hejKXyAfOoHsus6zd8hDi7RyqjDnNz6bCbIELacGjT8leCON+Eb+jsE0XNwYBUsDlQ
    p6J5uOppahfVzmFC1tly7ZIY7NqXl6h+GZN7VbuXDIERa6dpB7r63yy9/ULy0MzZ+75R
    PK82RK4CskIvMdnxGuab9ieOijH5tvrQLv7OMZoUHVz4F5XAcaD881oU0NJNlGdnsY/I
    7zeQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id c675b3z2BJH6W7w
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 11 Mar 2023 20:17:06 +0100 (CET)
Message-ID: <405b08b7-df80-dc09-3a94-70bff3bb6e0b@hartkopp.net>
Date:   Sat, 11 Mar 2023 20:17:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] can: isotp: add module parameter for maximum pdu size
To:     Patrick Menschel <menschel.p@posteo.de>, linux-can@vger.kernel.org
References: <20230311143446.3183-1-socketcan@hartkopp.net>
 <fd198411-dc23-1c57-7599-d8b5214d0ce7@posteo.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <fd198411-dc23-1c57-7599-d8b5214d0ce7@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Patrick,

On 11.03.23 18:23, Patrick Menschel wrote:

> IMO it is the right direction but it is just half the story.
> 
> I remember having problems with the txqueuelen even with 4KB PDUs 
> originally and I'm not sure if that has been improved already.
> 
> https://gitlab.com/Menschel/socketcan#can-isotp-overflows-when-the-tx-queue-is-too-small
> 
> It would be great to have all of those size options in one place and 
> some intelligent IO buffer.

I solved that problem since Linux 6.0 \o/

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/can/isotp.c?id=4b7fe92c06901f4563af0e36d25223a5ab343782

> Apart from that the PDU size does not matter for UDS, because UDS splits 
> the data into chunks that are sent via transfer_data service and 
> concatenated on the receiver end again, sort of the protocol's built-in 
> IO buffer.
> 
> https://gitlab.com/Menschel/socketcan-uds/-/blob/master/uds/programmer.py#L495

Yes. It is not needed for UDS as you stated correctly.

The reason for the increased PDU length was discussed when we created 
the CAN FD support for ISO TP in 2014. Some guy talked about the 
flashing of bootloader firmware "in one piece". The firmware was about 
64kbyte but then we decided to go for a 32 bit value. IMHO 24 bits would 
have made it too :-D

Best regards,
Oliver

> -- 
> 
> Am 11.03.23 um 15:34 schrieb Oliver Hartkopp:
>> With ISO 15765-2:2016 the PDU size is not limited to 2^12 - 1 (4095) 
>> bytes
>> but can be represented as a 32 bit unsigned integer value which allows
>> 2^32 - 1 bytes (~4GB). The use-cases like automotive unified diagnostic
>> services (UDS) and flashing of ECUs still use the small static buffers
>> which are provided at socket creation time.
>>
>> When a use-case requires to transfer PDUs up to 1025 kByte the maximum
>> PDU size can now be extended by setting the module parameter 
>> max_pdu_size.
>> The extended size buffers are only allocated on a per-socket/connection
>> base when needed at run-time.
>>
>> Link: https://github.com/raspberrypi/linux/issues/5371
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
