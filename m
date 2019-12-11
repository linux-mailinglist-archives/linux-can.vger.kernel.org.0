Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9072411AB0A
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 13:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKMgL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 07:36:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41722 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfLKMgK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 07:36:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBCa1CA009640;
        Wed, 11 Dec 2019 06:36:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576067761;
        bh=Rj2n1WXi/wCTUqW7Lh/grectVCMznB5EZuhr9iuKTeE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F71/VDk7Yb7C9U6hTzkDw+eQykh4LsmEk7GpI9wYny815pyAXqYboKlaRi07txIa+
         J7ALY4LO+ggyj2wUkVLN+VAsc1jKgE/DFElW3MSLICZTElr/QEaogWuYtLMFiblIhv
         3DBJiC5CDaDQpZdGZP4POd4QXVz+wbXsjdzzDS04=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBCa1X9024119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 06:36:01 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 06:36:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 06:36:01 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBCa0CT055079;
        Wed, 11 Dec 2019 06:36:01 -0600
Subject: Re: [PATCH v3 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191211064208.84656-1-sean@geanix.com>
 <20191211064208.84656-2-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <85c62554-5718-bfd5-1b5c-76ac13756678@ti.com>
Date:   Wed, 11 Dec 2019 06:33:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211064208.84656-2-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 12/11/19 12:42 AM, Sean Nyekjaer wrote:
> It's a good idea to reset a ip-block/spi device before using it,
> this patch will reset the device.
> And a generic reset function if needed elsewhere.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v2:
>   - added reset function
>
>   drivers/net/can/m_can/tcan4x5x.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 1f04fec7723d..b5d2ea0999c1 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -166,6 +166,18 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
>   	}
>   }
>   
> +static void tcan4x5x_reset(struct tcan4x5x_priv *priv)
> +{
> +	if (priv->reset_gpio) {
> +		gpiod_set_value(priv->reset_gpio, 1);
> +
> +		/* tpulse_width minimum 30us */
> +		usleep_range(30, 100);
> +		gpiod_set_value(priv->reset_gpio, 0);
> +		usleep_range(700, 1000);
> +	}

Do the software reset if GPIO is not valid then this will make sure the 
device is reset in either case.  Otherwise w/out the GPIO the device is 
not reset as the commit message indicates.  This is another reason for 
this function

} else {

     regmap_write(priv-regmap, TCAN4X5X_CONFIG, TCAN4X5X_SW_RESET);

}

Dan


