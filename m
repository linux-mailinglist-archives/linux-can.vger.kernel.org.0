Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB4116DB3
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLINKq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 08:10:46 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56654 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINKq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 08:10:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9DAWVe115332;
        Mon, 9 Dec 2019 07:10:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575897032;
        bh=rdbpZjsUQQhv+Oqsq+Jl1/FdVDV8VTijGJa/8NFEMog=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pjQQccEVTjq3Qz+n8UA0PGeo3pPupHprMvzFifbNltEEKmXHzIRVGBLNiW8lOXLKv
         i1fNLyyrhDPHqshHFyq2pR0iu2ZjsnJ+v+sHQQzLuaOdcnS7I5LOLGC9Ljtzerk73V
         DyyrAC9wMedJ1wQy5y6BbqVPGgZJQAh+x2t8s4us=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9DAWRT079748;
        Mon, 9 Dec 2019 07:10:32 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 07:10:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 07:10:32 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9DAWZn040502;
        Mon, 9 Dec 2019 07:10:32 -0600
Subject: Re: [PATCH] can: m_can: remove double clearing of clock stop request
 bit
To:     Sriram Dash <sriram.dash@samsung.com>,
        "'Sean Nyekjaer'" <sean@geanix.com>
CC:     <martin@geanix.com>, <pankj.sharma@samsung.com>,
        <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
References: <CGME20191209091507epcas5p4f54c5c836c7fb84039ad540808820d21@epcas5p4.samsung.com>
 <20191209091449.909319-1-sean@geanix.com>
 <019301d5ae74$4d9b4b40$e8d1e1c0$@samsung.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <73ad838e-d0a5-374d-4356-2c191baec883@ti.com>
Date:   Mon, 9 Dec 2019 07:08:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <019301d5ae74$4d9b4b40$e8d1e1c0$@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 3:37 AM, Sriram Dash wrote:
>> From: linux-can-owner@vger.kernel.org <linux-can-
>> owner@vger.kernel.org> On Behalf Of Sean Nyekjaer
>> Sent: 09 December 2019 14:45
>> Subject: [PATCH] can: m_can: remove double clearing of clock stop request
>> bit
>>
>> In m_can_config_endisable the CSA bit cleared 2 times while enabling
>> configuration mode.
>>
>> According to the datasheet:
>> If a Read-Modify-Write operation is performed in Standby mode a CSR = 1
>> will be read back but a 0 should be written to it.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Acked-by: Sriram Dash <sriram.dash@samsung.com>

I am not sure that this code is doing what you ask.

I think this commit message needs to indicate that you are removing the 
duplicate clearing of the CSR bit

Because the same code check and clears the CSR bit on line 379 as well.


>
>> ---
>>   drivers/net/can/m_can/m_can.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c
>> b/drivers/net/can/m_can/m_can.c index 02c5795b7393..4edc6f6e5165
>> 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -380,10 +380,6 @@ void m_can_config_endisable(struct
>> m_can_classdev *cdev, bool enable)
>>   		cccr &= ~CCCR_CSR;
>>
>>   	if (enable) {
>> -		/* Clear the Clock stop request if it was set */
>> -		if (cccr & CCCR_CSR)
>> -			cccr &= ~CCCR_CSR;
>> -

I need to test this on the TCAN part.  This was added specifically for it.

Dan


