Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6136F1178CC
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 22:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLIVqW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 16:46:22 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41614 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIVqW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 16:46:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9LkHWS027425;
        Mon, 9 Dec 2019 15:46:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575927977;
        bh=2YdLKsyCyc05eFGvNNX7LFuebeJYz2yZDq4ihEl6WgU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tf11p4tjP6YY8lqfGi/xRmyK+JyBSd6r6xexwWZcKVn7v7g3TnR3xhpoYqNjE2p3G
         N5r+jY775xXaJJjAxrP8cbATyTpLEC2p/v2gKPCBT098BecYtMdd6Jg0Lnd4yq4h+/
         ViGVnsxcwWBbVDEGTEUp3E0K4OIbJYKFN8zx5hOo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LkHU1108452;
        Mon, 9 Dec 2019 15:46:17 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 15:46:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 15:46:17 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LkHZl054583;
        Mon, 9 Dec 2019 15:46:17 -0600
Subject: Re: [PATCH] can: tcan4x5x: Turn on the power before parsing the
 config
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191209212351.27518-1-dmurphy@ti.com>
 <deabf78f-5b6a-f631-412d-49dd6f0c372a@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4ae989d0-dfa9-1b0c-0f3a-0a338605c3f1@ti.com>
Date:   Mon, 9 Dec 2019 15:44:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <deabf78f-5b6a-f631-412d-49dd6f0c372a@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/9/19 3:38 PM, Marc Kleine-Budde wrote:
> On 12/9/19 10:23 PM, Dan Murphy wrote:
>> The parse config function now performs action on the device either
>> reading or writing and a reset.  If the regulator is managed it needs
>> to be turned on.  So turn on the regulator if available if the parsing
>> fails then turn off the regulator.
>>
>> Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO")
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   drivers/net/can/m_can/tcan4x5x.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
>> index 4e1789ea2bc3..515486fcb150 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -451,11 +451,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>>   	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
>>   					&spi->dev, &tcan4x5x_regmap);
>>   
>> +	tcan4x5x_power_enable(priv->power, 1);
> please add error handling

Ack


> Marc
>
