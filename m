Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA44F275F70
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIWSGd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 14:06:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36338 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIWSGd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 14:06:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NI6O6R113435;
        Wed, 23 Sep 2020 13:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600884384;
        bh=Hhjy9v9VdpkwlFFrSW6d6ZyqmVJVZU9tfSurVGCzSB4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=s+6PqfFjG0MNL6W/W8+cClGYxgmEWFEVyTgaHT0A4s7guxjPY3763XHhx1BY7FaBy
         M4pCd8wmMOW6Lp8N/SNrGKEM/ERu7Xt0IcGXwuXOvW2vGhGd0N7S4OXvlKCaQpygdd
         UAo4J3+XDpwhqCO/yhNy6pfgEIebuJwFCfxp8dLY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NI6OJ8113098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 13:06:24 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 13:06:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 13:06:24 -0500
Received: from [10.250.71.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NI6Nb6007743;
        Wed, 23 Sep 2020 13:06:23 -0500
Subject: Re: [RESEND PATCH can-next 1/2] can: tcan4x5x: Rename parse_config
 function
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>, <wg@grandegger.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200227183829.21854-1-dmurphy@ti.com>
 <057bc43f-7db5-de7e-dbf5-8bfe324a973e@ti.com>
Message-ID: <b61b1a65-90c6-5380-d4ba-d8efcdb42094@ti.com>
Date:   Wed, 23 Sep 2020 13:06:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <057bc43f-7db5-de7e-dbf5-8bfe324a973e@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Mark and Wolfgang

On 4/28/20 2:48 PM, Dan Murphy wrote:
> Marc
>
> On 2/27/20 12:38 PM, Dan Murphy wrote:
>> Rename the tcan4x5x_parse_config function to tcan4x5x_get_gpios since
>> the function retrieves the gpio configurations from the firmware.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/net/can/m_can/tcan4x5x.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c 
>> b/drivers/net/can/m_can/tcan4x5x.c
>> index 9821babef55e..37d53ecc560b 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -381,7 +381,7 @@ static int tcan4x5x_disable_state(struct 
>> m_can_classdev *cdev)
>>                     TCAN4X5X_DISABLE_INH_MSK, 0x01);
>>   }
>>   -static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>> +static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
>>   {
>>       struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
>>       int ret;
>> @@ -507,7 +507,7 @@ static int tcan4x5x_can_probe(struct spi_device 
>> *spi)
>>       if (ret)
>>           return ret;
>>   -    ret = tcan4x5x_parse_config(mcan_class);
>> +    ret = tcan4x5x_get_gpios(mcan_class);
>>       if (ret)
>>           goto out_power;
>
> I noticed this series never was reviewed and applied.  They are still 
> applicable and were requested changes.
>
Did you need me to combine all the patches on a m_can-next branch and 
submit a PR after test?

There are quite a few patches out there and they all seem relevant.

Dan


> Dan
>
