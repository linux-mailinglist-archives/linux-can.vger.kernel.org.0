Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5866B117713
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 21:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIUMc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 15:12:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIUMc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 15:12:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9KCKCL029574;
        Mon, 9 Dec 2019 14:12:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575922340;
        bh=vIR1I2DCykiPASU799wjlM8pEea0vgyTMh/js6j/3sQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T9BSSqEirAal5AlTHgsZNRj01rR5Zrf88nponNfMYAUsuGV7uVlWHOGl7muYqvBKc
         76zL3ZJz8HqamWtGtIkwlmEiol5IHsCsDAMi/2NkhwyAa9yQVaQPzgLhyw+I596plB
         8jVcXJu1jBDJDZxiIZtDkkG+KERvQOre2d9A8Wz0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9KCKsl093840;
        Mon, 9 Dec 2019 14:12:20 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 14:12:20 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 14:12:20 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9KCKTD021978;
        Mon, 9 Dec 2019 14:12:20 -0600
Subject: Re: [PATCH v2] can: m_can: remove double clearing of clock stop
 request bit
To:     Sean Nyekjaer <sean@geanix.com>, <sriram.dash@samsung.com>,
        <pankj.sharma@samsung.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191209192949.998976-1-sean@geanix.com>
 <cdf36996-376a-4755-75ff-27c441a317ad@ti.com>
 <8382275e-c878-6dd2-cd78-9f4615d299ee@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <edab9b5b-ce12-632d-9c23-af5692d082c7@ti.com>
Date:   Mon, 9 Dec 2019 14:10:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <8382275e-c878-6dd2-cd78-9f4615d299ee@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 2:02 PM, Sean Nyekjaer wrote:
>
>
> On 09/12/2019 20.53, Dan Murphy wrote:
>> Sean
>>
>> On 12/9/19 1:29 PM, Sean Nyekjaer wrote:
>>> In m_can_config_endisable the CSR bit cleared 2 times while enabling
>>> configuration mode.
>>> The CSR should always be cleared when writing to the CCCR register.
>>>
>>> According to the datasheet:
>>> If a Read-Modify-Write operation is performed in Standby mode a
>>> CSR = 1 will be read back but a 0 should be written to it.
>>
>> I am not understanding why you need to have this statement in the 
>> commit message.
>>
>> And are you referring to the Bosch IP data sheet or the TCAN data sheet?
> TCAN :)
>>
>> If it is the TCAN data sheet then this reference may not apply to the 
>> MMIO version.
>>
>> It would be best to denote which datasheet you are talking about here.
>>
>> Other then that I agree with the change and will ACK once I 
>> understand what data sheet you are talking about.
>
> This patch is basically removal of some duplicate code, the register 
> write functions will write exactly the same as before...
> No functional changes have been made.
And I agree and understand the change just not the commit.
>
> Maybe it's easier to see when reading drivers/net/can/m_can/m_can.c 
> before and after this patch :-)
>
> I can change the commit msg to whatever you will like to make this 
> change less confusing...
>
> /Sean

Its only confusing because what you are changing is for the MCAN IP code 
and is not specific to TCAN.  The change affects all devices that 
register to the m_can framework.

Referencing the TCAN data sheet for the Bosch IP implementation is not 
correct.

All the commit message should say is basically what the $subject says 
because that is all it is doing.

Dan

