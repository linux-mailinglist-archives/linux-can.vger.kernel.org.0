Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9C116D84
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLINC1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 08:02:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49804 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINC0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 08:02:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9D2IB6036743;
        Mon, 9 Dec 2019 07:02:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575896538;
        bh=TRF9jg0UbfLpL5NFrZ1ZWP1TbNI/hqDwkdiSkO0lnw0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cEVwyAngvhojX3VuLKh3Sj2DldoUVymzCA9WgalrOW4lGqOQSHo520LOpFKZZbjjV
         GVPeOBJmsOMLApw582oIa/BV6dx68aLF4GAnuAt80p61cAB7mKOT4par7NBHAjAQJn
         lpb8FOUfF+z1wkXgq7udqIvyv9zoq8ahr/ufz1+A=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9D2IhJ117461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 07:02:18 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 07:02:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 07:02:17 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9D2HIr030606;
        Mon, 9 Dec 2019 07:02:17 -0600
Subject: Re: [PATCH 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191209084808.908116-1-sean@geanix.com>
 <20191209084808.908116-2-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <233a4bad-1439-3e7c-18c5-a7b5c5bb1a0c@ti.com>
Date:   Mon, 9 Dec 2019 07:00:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209084808.908116-2-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 2:48 AM, Sean Nyekjaer wrote:
> It's a good idea to reset a ip-block/spi device before using it,
> this patch will reset the device.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 7f26c2d53f8c..dd812d40d475 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -361,14 +361,15 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>   
>   		tcan4x5x_disable_wake(cdev);
>   	}
> -
>   	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
> -						       GPIOD_OUT_LOW);
> +						       GPIOD_OUT_HIGH);
>   	if (IS_ERR(tcan4x5x->reset_gpio))
>   		tcan4x5x->reset_gpio = NULL;
>   
>   	usleep_range(700, 1000);
>   
> +	gpiod_set_value(tcan4x5x->reset_gpio, 0);

I was looking to add a common function to properly do the reset with the 
delay.

This way if resets are needed in other calls then the proper reset 
sequence is available.

Also this call  and the sleep assumes that the reset GPIO is available 
but they are optional.

Dan

