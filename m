Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12E117799
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 21:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIUnd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 15:43:33 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33442 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIUnd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 15:43:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9KhLE8006576;
        Mon, 9 Dec 2019 14:43:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575924201;
        bh=/watm3keZ77WRqPyE/rrGkSOVADAVGrAThqSMrXi4+Y=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=R6KdGwCuqmkXPuPj3W7cisUvCyjPUlB0e2e5V2+a1yYwIP7Ui2tcvyB+OPeffqTyr
         QznmYjh/jI4MLzA/uZLut4AhjmaMeGdv1jyzfrDAkSXsZ0t8s5KM5E+oXyJsxg5v3k
         /X0JPK8u7Ij8nSDwhFLS8ifd6mTuyBLpHUIjwlOY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9KhLoV121945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 14:43:21 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 14:43:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 14:43:21 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9KhKrc121766;
        Mon, 9 Dec 2019 14:43:20 -0600
Subject: Re: [PATCH v3] can: m_can: remove double clearing of clock stop
 request bit
From:   Dan Murphy <dmurphy@ti.com>
To:     Sean Nyekjaer <sean@geanix.com>, <sriram.dash@samsung.com>,
        <pankj.sharma@samsung.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191209201528.999698-1-sean@geanix.com>
 <e1a87a65-74f4-9ba3-2845-bd49bcb3fba1@ti.com>
Message-ID: <be8dbb51-1e56-eeeb-596b-4de1b7ebd153@ti.com>
Date:   Mon, 9 Dec 2019 14:41:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <e1a87a65-74f4-9ba3-2845-bd49bcb3fba1@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 2:32 PM, Dan Murphy wrote:
> Sean
>
> On 12/9/19 2:15 PM, Sean Nyekjaer wrote:
>> Removal of duplicate code
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Acked-by: Sriram Dash <sriram.dash@samsung.com>
>> ---
>> Changes since v2:
>>   - Changed commit msg not to confuse :)
>>
>>   drivers/net/can/m_can/m_can.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c 
>> b/drivers/net/can/m_can/m_can.c
>> index 02c5795b7393..4edc6f6e5165 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -380,10 +380,6 @@ void m_can_config_endisable(struct 
>> m_can_classdev *cdev, bool enable)
>>           cccr &= ~CCCR_CSR;
>>         if (enable) {
>> -        /* Clear the Clock stop request if it was set */
>> -        if (cccr & CCCR_CSR)
>> -            cccr &= ~CCCR_CSR;
>> -
>>           /* enable m_can configuration */
>>           m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
>>           udelay(5);
>
> I am checking with the HW guys to make sure we are removing the 
> correct CSR clearing.  I don't know if we need to clear the CSR when 
> disabling the m_can configuration access or if we need to clear it for 
> both enabling and disabling when the CSR is set to 1.
>
> Dan
>
>
Its all good!

Acked-by: Dan Murphy <dmurphy@ti.com>

