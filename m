Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE711AD3B
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 15:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfLKOTc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 09:19:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60880 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKOTc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 09:19:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBEJPSe055855;
        Wed, 11 Dec 2019 08:19:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576073965;
        bh=wdxtrmyaaWmc9jCwok/dzm3n5W1ukUKXaLPA2ifja5Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jJbwSxFINo7SXYbcVHl0dxXmfy0MEpj1H/gZcKXRBmkcVfdpg1xK64ggJzJCyXmXU
         elrVd5L2MkCsoM0s6XXANM679wd9l80jyB4mb1zxYCBKWsYg3HyAxjv0xXZSH4cA/X
         8cilT5mhp6qHwATfRTbYGgJcuwr0hEjOfo/ZDJC8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBEJPGb051313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 08:19:25 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 08:19:24 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 08:19:25 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBEJO5W040500;
        Wed, 11 Dec 2019 08:19:24 -0600
Subject: Re: [PATCH v2] can: tcan4x5x: remove redundant return statement
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>, <esben@geanix.com>
References: <20191211141635.322577-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <72faeba9-1ef3-b6ed-1ca4-f646fbf85562@ti.com>
Date:   Wed, 11 Dec 2019 08:17:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211141635.322577-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/11/19 8:16 AM, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 8ed2813f227e..0fd83045f371 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -327,12 +327,8 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
> +	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
>   				      TCAN4X5X_CLEAR_ALL_INT);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
>   }
>   
>   static int tcan4x5x_init(struct m_can_classdev *cdev)
Acked-by: Dan Murphy <dmurphy@ti.com>
