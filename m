Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114D8114335
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2019 16:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfLEPDh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Dec 2019 10:03:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35594 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEPDh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2019 10:03:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5F3Ulr006976;
        Thu, 5 Dec 2019 09:03:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575558210;
        bh=bPHiSbvAxh5EbCsuea3JUYoH4fGkht5SLNEd1ncNzic=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fTGKpaPy/Zb0M6SWfVtLFtx/oJMxgtkSUBFcBDlcFlX4q/WFn5qcV+mi1vf2f8Rks
         leXqudsaDFzvOmxlpuYIiORXvpxmrHbi9BIjTBjR8jN0qwziaf+OfemkGBWzBnNqk9
         A7mm2VzeZH3wYiN7IIVdKKHhT9vl5qp3SakRI8Mg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB5F3Ukg053299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Dec 2019 09:03:30 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 09:03:29 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 09:03:29 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5F3TdL093838;
        Thu, 5 Dec 2019 09:03:29 -0600
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sean Nyekjaer <sean@geanix.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
 <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
 <827b022e-9188-7bcf-25e3-3777df3b08a5@ti.com>
 <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <76e96337-bbcf-89f1-2f1c-45144c15cb5b@ti.com>
Date:   Thu, 5 Dec 2019 09:01:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <809b9ff1-88e3-4e46-33e0-856db37898b2@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/5/19 8:39 AM, Marc Kleine-Budde wrote:
> On 12/5/19 2:26 PM, Dan Murphy wrote:
>> On 12/5/19 1:39 AM, Sean Nyekjaer wrote:
>>>
>>> On 04/12/2019 18.51, Dan Murphy wrote:
>>>> The device has the ability to disable the wake-up pin option.
>>>> The wake-up pin can be either force to GND or Vsup and does not have to
>>>> be tied to a GPIO.  In order for the device to not use the wake-up
>>>> feature
>>>> write the register to disable the WAKE_CONFIG option.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> CC: Sean Nyekjaer <sean@geanix.com>
>>> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
>>>> ---
>>>
>>> Hi Dan,
>>>
>>> I would add tcan4x5x to the subject of this patch ->
>>> "net: m_can: tcan4x5x Make wake-up gpio an optional"
>>>
>> Do you want me to submit v2 with the $subject change?
>>
>> Or would you fix it up when committing it?
> I'll change the subject while applying.
>
> Dan, what about maintainerchip of the tcan4x5?

Ooops that was buried in my inbox.

It only makes sense for someone from TI to take maintainership of the 
TCAN device.

Do I need to submit a patch to the maintainers file or is the authorship 
enough?

As far as a device what country do you reside in?

Dan


> regards,
> Marc
>
