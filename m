Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1910EB68
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2019 15:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfLBOOM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Dec 2019 09:14:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40474 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBOOM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Dec 2019 09:14:12 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB2EE23q006618;
        Mon, 2 Dec 2019 08:14:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575296042;
        bh=PDmaPjMaRRDdCiLJRnEUzeRGoSIG8sCFbwelsQJdX6k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QUsa0TcPf1PdQMXsGPhR5QDqREqHPLPeGV3gjYR0zRK6/BFNuansJlkYHR5SaUF5h
         oBf3N0UlVn0qkTJnzwwvdq30Oj0oqbEBZU0MmksAmW37xa5G+rJvrYYz+/SR0WIGQN
         +iSO8oH1VAwEh7bvGJWwU8xKmTQ72HHqs++YkpJM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB2EE1dY073447;
        Mon, 2 Dec 2019 08:14:02 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Dec
 2019 08:14:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Dec 2019 08:14:01 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB2EE0HA074774;
        Mon, 2 Dec 2019 08:14:01 -0600
Subject: Re: Devicetree for can tcan4x5x
To:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
 <eb7aaa46-3cc8-4ed3-adcf-aaa95c8dd197@ti.com>
 <80e8f758-e240-f1b4-f0e2-3a53b2f22b99@geanix.com>
 <d95c2d97-991e-6ba3-6d4a-3ea42463abc9@ti.com>
 <4e5e34c1-d153-7fe2-a42f-f766099389da@ti.com>
 <236f6a5f-722c-34f4-e1c4-6c89a86a3399@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e2013616-7127-405e-e7f7-ea8356b12c13@ti.com>
Date:   Mon, 2 Dec 2019 08:12:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <236f6a5f-722c-34f4-e1c4-6c89a86a3399@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 11/27/19 12:40 AM, Sean Nyekjaer wrote:
>
>
> On 26/11/2019 17.55, Dan Murphy wrote:
>>>>
>>>>
>>> Let me check with our HW guys here to see if that is acceptable.
>>>
>>> If it is we will need to update the DT doc and the code.
>>
>> Got a response and it reminded me why I made it required.  Can't 
>> control CAN activity and did not want to reset the chip every time I 
>> need to do a SPI write/read.  So you might want to think about having 
>> the HW guys wire up the wake up line.
>>
>> The device looks for a transition to wake up. It should be OK to wire 
>> it to ground, I believe. It will not stay awake, but note that once 
>> you put it to sleep, your only option to wake it will be
>>
>> 1)      CAN activity (out of your control)
>> 2)      Reset pin toggle
>>
>> Dan
>
> Hi Dan,
>
> I could get them to wire the WAKE line, but not in the first batch I 
> have received.
> We have wired the nWKRQ for wake-on-can, but I suspect it's linked to 
> sleep mode. :-S
>
> Does the CAN transceiver go into sleep mode by it self? Or is it 
> something in the driver that does that?
> Or only when suspending?
> (I can't find it in the datasheet or driver)
>
> I guess this have confused the hw guys:
>
> Section "8.3.6 WAKE Pin" in the datasheet states:
> "If local wake-up functionality is not needed in the end application,
>
> WAKE can be tied directly to V SUP or GND."
> and it can be controlled by setting the following bits: 16'h0800[31:30]

That would be a driver enhancement to disable wake config.

I just quickly did a patch to make the wake config pin optional and if 
the wake pin is not defined disable the wake up to being disabled.

I will RFC it after I test it for your testing.

Dan


>
> /Sean
