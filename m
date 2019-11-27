Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED810AAB2
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2019 07:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfK0Gkm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Nov 2019 01:40:42 -0500
Received: from first.geanix.com ([116.203.34.67]:58564 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfK0Gkl (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 27 Nov 2019 01:40:41 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 78E3093BC7;
        Wed, 27 Nov 2019 06:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1574836616; bh=m6L8+qGugw3q8FPvETvljHDnaCR8sWkrrBBhIrvpWAM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DEM7kUruWPJZRkJcyKP9lG3Tc1TUWv5ZCljZH6bM0rFngNW+m7WmxTbD8FV95fPSt
         0x79QtnaydwTYJulrw/t+WibAaZ8F1rZv08fXW3pfl6s1zLnHTZBb4MaVAKWeJDLt6
         wQJO+wt9XgZP+uVktOIKZ1sgjlkk1M8T5ugAVhlju//OpIAIXUzf00oj7a+HTDVOYg
         G35cxAaXiW0mH7ewh2+oKjlXPlbTtihQNuSCGTim8y0yRWWAoxhWOfwjeYMwGLJnkJ
         NpKJn4ccPryhKimlAFldgw8Cht+DCewoE70QzPfFwnVxSp+JyVenosb9sPSrPKyRAP
         bH1ETM6zAkwkQ==
Subject: Re: Devicetree for can tcan4x5x
To:     Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
 <eb7aaa46-3cc8-4ed3-adcf-aaa95c8dd197@ti.com>
 <80e8f758-e240-f1b4-f0e2-3a53b2f22b99@geanix.com>
 <d95c2d97-991e-6ba3-6d4a-3ea42463abc9@ti.com>
 <4e5e34c1-d153-7fe2-a42f-f766099389da@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <236f6a5f-722c-34f4-e1c4-6c89a86a3399@geanix.com>
Date:   Wed, 27 Nov 2019 07:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4e5e34c1-d153-7fe2-a42f-f766099389da@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 26/11/2019 17.55, Dan Murphy wrote:
>>>
>>>
>> Let me check with our HW guys here to see if that is acceptable.
>>
>> If it is we will need to update the DT doc and the code.
> 
> Got a response and it reminded me why I made it required.  Can't control 
> CAN activity and did not want to reset the chip every time I need to do 
> a SPI write/read.  So you might want to think about having the HW guys 
> wire up the wake up line.
> 
> The device looks for a transition to wake up. It should be OK to wire it 
> to ground, I believe. It will not stay awake, but note that once you put 
> it to sleep, your only option to wake it will be
> 
> 1)      CAN activity (out of your control)
> 2)      Reset pin toggle
> 
> Dan

Hi Dan,

I could get them to wire the WAKE line, but not in the first batch I 
have received.
We have wired the nWKRQ for wake-on-can, but I suspect it's linked to 
sleep mode. :-S

Does the CAN transceiver go into sleep mode by it self? Or is it 
something in the driver that does that?
Or only when suspending?
(I can't find it in the datasheet or driver)

I guess this have confused the hw guys:

Section "8.3.6 WAKE Pin" in the datasheet states:
"If local wake-up functionality is not needed in the end application,

WAKE can be tied directly to V SUP or GND."
and it can be controlled by setting the following bits: 16'h0800[31:30]

/Sean
