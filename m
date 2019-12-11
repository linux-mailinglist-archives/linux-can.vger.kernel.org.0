Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2AF11AB59
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 13:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfLKMzE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 07:55:04 -0500
Received: from first.geanix.com ([116.203.34.67]:56866 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfLKMzE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 07:55:04 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 211003BE;
        Wed, 11 Dec 2019 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576068874; bh=buaqjzS517jsvetk2ex264uXLGeDeE7VKnn4AlnG4Oo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hntj+a2Yp/5bMBZZYSpdb94SpcvsbzGVajWR0V/L0Tzy5Y/evwsyLu2sUGRwK2+Qu
         eCfRegDNu/gte1sKSjL3EZqhqVo1aPPbwUl4FRJOAEJC9dYUKfcJsQuowWNGVGV3zi
         slYxafRegV46kPjUGZxwfjF3Or8EbrQBCrKynjRoA0v/y27c3aGkub8VlLBxJaaM+C
         6FYUzIMdTGoJhNFevMLYRSgJyBqcWAq+iIRpxf1C4LeaPhLiHeOZ9fgqIDNFkgjyYp
         Hgtg6unZhz+ho7EwDCO77sCTuDKvkXyS4AR+LtvSltfpw+hyrJxR4UBUgHaS9J1UQF
         tTIpiiV+Y/byw==
Subject: Re: [PATCH v3 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191211064208.84656-1-sean@geanix.com>
 <20191211064208.84656-2-sean@geanix.com>
 <85c62554-5718-bfd5-1b5c-76ac13756678@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <7653ce79-81aa-eb51-f23a-581e14c0d78e@geanix.com>
Date:   Wed, 11 Dec 2019 13:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <85c62554-5718-bfd5-1b5c-76ac13756678@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 11/12/2019 13.33, Dan Murphy wrote:
> 
> On 12/11/19 12:42 AM, Sean Nyekjaer wrote:
>> It's a good idea to reset a ip-block/spi device before using it,
>> this patch will reset the device.
>> And a generic reset function if needed elsewhere.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>> Changes since v2:
>>   - added reset function
>>
>>   drivers/net/can/m_can/tcan4x5x.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/tcan4x5x.c 
>> b/drivers/net/can/m_can/tcan4x5x.c
>> index 1f04fec7723d..b5d2ea0999c1 100644
>> --- a/drivers/net/can/m_can/tcan4x5x.c
>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>> @@ -166,6 +166,18 @@ static void tcan4x5x_check_wake(struct 
>> tcan4x5x_priv *priv)
>>       }
>>   }
>> +static void tcan4x5x_reset(struct tcan4x5x_priv *priv)
>> +{
>> +    if (priv->reset_gpio) {
>> +        gpiod_set_value(priv->reset_gpio, 1);
>> +
>> +        /* tpulse_width minimum 30us */
>> +        usleep_range(30, 100);
>> +        gpiod_set_value(priv->reset_gpio, 0);
>> +        usleep_range(700, 1000);
>> +    }
> 
> Do the software reset if GPIO is not valid then this will make sure the 
> device is reset in either case.  Otherwise w/out the GPIO the device is 
> not reset as the commit message indicates.  This is another reason for 
> this function
> 
> } else {
> 
>      regmap_write(priv-regmap, TCAN4X5X_CONFIG, TCAN4X5X_SW_RESET);
> 
> }

Good idea :)

I'll drop a V4

/Sean
