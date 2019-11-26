Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4871B10A2DE
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2019 17:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfKZQ5R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Nov 2019 11:57:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37674 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfKZQ5R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Nov 2019 11:57:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQGv5QV121635;
        Tue, 26 Nov 2019 10:57:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574787425;
        bh=6j3tDQv6TJlGg5DtEP/7e0Zq/RO2smgIC2o4WdTLrFk=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=yeEqkfeAes4rbQSfo3pKiNMeBqyqB6u8ThC+5sJ6AHHEKkjlFATDgmPfY/pr7LVQx
         A/+sNvWYos0t+0/igzoqVUr8A1p/BGvjT0Iz7h5srJ3QSwAJkIRCTUSwyM9DkQJSC2
         oraBK+BFA2sKs6VJQS6djgl7shpwgJICD3sSEB9Q=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAQGv5kq055209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 10:57:05 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 10:57:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 10:57:04 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQGv3Rc072965;
        Tue, 26 Nov 2019 10:57:03 -0600
Subject: Re: Devicetree for can tcan4x5x
From:   Dan Murphy <dmurphy@ti.com>
To:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e5892c08-03a5-60a6-61e0-6b75e248e172@geanix.com>
 <eb7aaa46-3cc8-4ed3-adcf-aaa95c8dd197@ti.com>
 <80e8f758-e240-f1b4-f0e2-3a53b2f22b99@geanix.com>
 <d95c2d97-991e-6ba3-6d4a-3ea42463abc9@ti.com>
Message-ID: <4e5e34c1-d153-7fe2-a42f-f766099389da@ti.com>
Date:   Tue, 26 Nov 2019 10:55:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d95c2d97-991e-6ba3-6d4a-3ea42463abc9@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 11/26/19 8:31 AM, Dan Murphy wrote:
> Sean
>
> On 11/26/19 8:12 AM, Sean Nyekjaer wrote:
>>
>>
>> <snip>
>> Hi Dan,
>>
>> Thanks for the reply :)
>> I have the driver loading now, just with the SPI entry.
>>
>> Our HW guys have hardwired the WAKE pin to GND, I'm guessing that's a 
>> perfectly valid scenario.
>> I have a small patch that makes the WAKE pin optional.
>>
>> /Sean
>>
>>
>>
>>
> Let me check with our HW guys here to see if that is acceptable.
>
> If it is we will need to update the DT doc and the code.

Got a response and it reminded me why I made it required.  Can't control 
CAN activity and did not want to reset the chip every time I need to do 
a SPI write/read.  So you might want to think about having the HW guys 
wire up the wake up line.

The device looks for a transition to wake up. It should be OK to wire it 
to ground, I believe. It will not stay awake, but note that once you put 
it to sleep, your only option to wake it will be

1)      CAN activity (out of your control)
2)      Reset pin toggle

Dan

