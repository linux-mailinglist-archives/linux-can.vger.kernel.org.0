Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7252FF1899
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfKFO0i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 09:26:38 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:28622 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFO0h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 09:26:37 -0500
X-Greylist: delayed 11629 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 09:26:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573050395;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2fbJNKf8X1yF8e0yTX4Gq7NWfQBwt8jDtbIAr0+veiA=;
        b=jeqtzFff85BYS5SzlSrRh3C+21oxevrrXzsXf1X+DyvDWPkRUkoKe1WHP71pKi2YQR
        mIPk5VbgwoSsgnbTzjRB6AYvYnEeFqs5VogU16Dk97wnryvCTqPDRBeP1pU5UJZXk7dF
        a1ar+v/z+zkj0pr9IpIjy18jbHSN9deCA0M/BtJ7Fg5taeLm2dtwMCHgehuq+laqW0Kn
        LvENIFuLpOiEAV/SXZq0++ltv+iAlO4vCw3o3b97I9ZqoiWwFC7bt/2pac8gugT9OGtE
        3Gpni/v3G76gE9KLf+3PrMNnq+22Laz78MuqUBWbygADJMQ+im9ShmwtPVBtgZoD1nJY
        TQNQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h+lyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id C03a03vA6EQSNor
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 15:26:28 +0100 (CET)
Subject: Re: Fwd: Return value of write() in BUS-OFF state
To:     Kurt Van Dijck <kurt@vandijck-laurijssen.be>, jara.beran@gmail.com,
        linux-can@vger.kernel.org
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
 <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com>
 <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net>
 <D5447E34-0D39-470F-A4FF-D9530F91359E@vandijck-laurijssen.be>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f11ebe09-1ce9-0b4c-2c6c-f6a0d2383696@hartkopp.net>
Date:   Wed, 6 Nov 2019 15:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <D5447E34-0D39-470F-A4FF-D9530F91359E@vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 06/11/2019 12.23, Kurt Van Dijck wrote:
> 
> 
> On 6 November 2019 12:12:39 GMT+01:00, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> Hello Jaroslav,
>>
>> On 05/11/2019 22.46, Jaroslav Beran wrote:
>>
>>> So far I've learned this issue is most probably caused by upper (net
>>> and can) layers (so this is not specific for certain controller
>>> driver). When a driver calls can_bus_off, it sets carrier-off and
>>> triggers linkwatch_* actions that deactivate net queues and
>> substitute
>>> a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enqueue
>>> function - noop_enqueue - just returns NET_XMIT_CN, which is
>>> transformed by net_xmit_errno macro to zero, that's passed by
>>> net/can/af_can.c:can_send up to a userspace caller of write as
>>> success.
>>
>> Hm.
>>
>>> According to description for qdisc return codes in
>>> include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
>>> notification` and further
>>>
>>> /* NET_XMIT_CN is special. It does not guarantee that this packet is
>> lost. It
>>>    * indicates that the device will soon be dropping packets, or
>> already drops
>>>    * some packets of the same priority; prompting us to send less
>> aggressively. */
>>>
>>>
>>> Is this behavior appropriate for a node in BUS-OFF state? I'd rather
>>> expect such controller would be always dropping all frames (not just
>>> soon and some) until reset.
>>
>> The common use of the net_xmit_errno macro probably really does not fit
>>
>> to the CAN specialties ...
>>
>>> In current situation a caller of write gets success even if his frame
>>> is lost for sure. Is there any specific reason for this? Of course he
>>> can be notified by receiving error frame, but why don't just return
>>> error in can_send?
>>
>> Yes. It makes sense to forward the carrier-off state that is thankfully
>>
>> provided by the linkwatch triggers to the user space.
>>
>> Looking to man(2) send we should provide -ENOBUFS in the case of
>> carrier-off state, right?
> ENOBUFS seems a bad indication. What about ENETDOWN instead?

ENETDOWN shows that the interface is "down" which does not fit the 
current situation.

The interface is "up" but the carrier is "off".

man(2) send says:

ENOBUFS
       The output queue for a network interface was full.  This  gener‐
       ally  indicates  that the interface has stopped sending, but may
       be caused by transient congestion.  (Normally, this does not oc‐
       cur  in  Linux.  Packets are just silently dropped when a device
       queue overflows.)

Fits to me !?

Best,
Oliver
