Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B75148FE3
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2020 22:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgAXVEg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jan 2020 16:04:36 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:26777 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387394AbgAXVEg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jan 2020 16:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579899871;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Ec81Vtsd8KlarNFepdfA/86NYV4/BVjrKx4dWTmOJ8k=;
        b=JBsGnS1MRwhHWS+33D/Q7lFI1D3ehtOFw/WTPgeJ1wzaLWwV6thnaY31XWXp8Hool1
        WU8fHO4k8Somg38F8jm3vO8h/vk44uc8zho2eF44F/RrMxDCY+f2j+NMq7Pp+nzaXsPO
        YqxgiewaZwbp+dwU21FRCWFcsB6DDcAyH+Gu0yguG659e1bOTXDqJIbEwUi+DDJ7ToI3
        pSGmFaCRsK4lNbgtg+COWzjzc8MyWEXsnOnPbE/t6VQKbUoDjwkyrW46CAZtsPsNFWGn
        ePLnOaKtknGGlhFSX7jHWpMMi8RlWSoSbHl/qEaWF26LccYs7Hvm53S7UZlCzhDLbX2b
        YKaA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch6kk2t"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 46.1.7 DYNA|AUTH)
        with ESMTPSA id R0798bw0OL4T4ie
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 24 Jan 2020 22:04:29 +0100 (CET)
Subject: Re: general protection fault in can_rx_register
To:     Dmitry Vyukov <dvyukov@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        o.rempel@pengutronix.de,
        syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>,
        linux-can@vger.kernel.org
References: <00000000000030dddb059c562a3f@google.com>
 <55ad363b-1723-28aa-78b1-8aba5565247e@hartkopp.net>
 <20200120091146.GD11138@x1.vandijck-laurijssen.be>
 <CACT4Y+a+GusEA1Gs+z67uWjtwBRp_s7P4Wd_SMmgpCREnDu3kg@mail.gmail.com>
 <8332ec7f-2235-fdf6-9bda-71f789c57b37@hartkopp.net>
 <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
 <20200121192248.GC13462@x1.vandijck-laurijssen.be>
 <9a6be054-ac52-761d-83f0-809ec80e7764@hartkopp.net>
 <20200121203954.GG13462@x1.vandijck-laurijssen.be>
 <afa442db-d893-25b5-c580-b29323c8816c@hartkopp.net>
 <20200124190512.GB14622@x1.vandijck-laurijssen.be>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <35983732-5a66-b25f-4ead-c7df5f39598e@hartkopp.net>
Date:   Fri, 24 Jan 2020 22:04:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124190512.GB14622@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Kurt,

On 24/01/2020 20.05, Kurt Van Dijck wrote:
> On vr, 24 jan 2020 19:43:23 +0100, Oliver Hartkopp wrote:
>> Hi Kurt, Dmitry,
>>
>> On 21/01/2020 21.39, Kurt Van Dijck wrote:
>>
>>> Maybe move the crosslinking to before the register, then they're
>>> inaccessible from userspace.
>>
>> I think I found the problem:
> 
> Well done!
> 
>>
>> [ 1814.648904] bond5128: (slave vxcan1): Error -22 calling dev_set_mtu
>> [ 1814.649124] dev_rcv_lists == NULL! 000000008e41fb06 (bond5128)
>>
>> The bonding netdev bond5128 enslaved the vxcan1 netdev. As vxcan1 is a CAN
>> netdev with ARPHRD_CAN the bonding process executes
>>
> 
> You were able to make the syscalls comprehensible then?

Not really. I was just digging into "what bonding CAN interfaces" 
probably means to us :-)

The fact that we are only handling ARPHDR_CAN interfaces *and* the 
dev_rcv_lists have not been available finally lead to the problem.

>> if (slave_dev->type != ARPHRD_ETHER)
>> 	bond_setup_by_slave(bond_dev, slave_dev);
>>
>> in bond_enslave() in .../bonding/bond_main.c
>>
>> Which does this:
>>
>> static void bond_setup_by_slave(struct net_device *bond_dev,
>>                                  struct net_device *slave_dev)
>> {
>>          bond_dev->header_ops        = slave_dev->header_ops;
>>
>>          bond_dev->type              = slave_dev->type;
>>          bond_dev->hard_header_len   = slave_dev->hard_header_len;
>>          bond_dev->addr_len          = slave_dev->addr_len;
>>
>>          memcpy(bond_dev->broadcast, slave_dev->broadcast,
>>                  slave_dev->addr_len);
>> }
>>
>> So bond5128 becomes an ARPHDR_CAN interface BUT without having a
>> netdev_priv() space which contains our lovely can_ml_priv structure with the
>> dev_rcv_lists for the CAN filters.
>>
>> I was able to confirm the bisected commit but the crashes still were pure
>> luck IMO.
>>
>> can_rx_register() accesses netdev_priv() of the bonding device - but there
>> are no CAN filters. BAM!
>>
>> So we need to make sure that ARPHDR_CAN dev->type can not be enslaved by the
>> bonding driver.
> 
> This implies modifying bond_main.c, right?

I think so. But I wanted to have this discussed on the mailing list 
before preparing a patch.

Best,
Oliver
