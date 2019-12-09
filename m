Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB2117884
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLIVaI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 16:30:08 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52664 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVaI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 16:30:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9LU0kg129451;
        Mon, 9 Dec 2019 15:30:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575927000;
        bh=G35pk/lrYZNoKuYCIkKsc2gddw3x0x7KrwfOrpKB0wg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=psuRYQpYaTU5UZXpPfXqcKK6ChOmdvaaosM7s/E0ujTvER/jmgbgqMJzMYKO699Qx
         BJ9+cnApxsrWwpR4SU9QYxY/+OJnR7UhQpoEZuPGgpL3vNnYtMCvDGSoufr4al+UUe
         nr26AmJUP6SzWs4EfTF9esGt73OFjXb0/489uFpk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LU0sK080973;
        Mon, 9 Dec 2019 15:30:00 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 15:29:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 15:30:00 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LTxM7017829;
        Mon, 9 Dec 2019 15:29:59 -0600
Subject: Re: [PATCH v2 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191209192440.998659-1-sean@geanix.com>
 <20191209192440.998659-2-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <17908fc8-550b-4832-5b43-7a5ea387a12f@ti.com>
Date:   Mon, 9 Dec 2019 15:27:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209192440.998659-2-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 1:24 PM, Sean Nyekjaer wrote:
> It's a good idea to reset a ip-block/spi device before using it,
> this patch will reset the device.

$subject says 2/2 where is 1/2?


> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>   - Added toggle of reset pin with required delay
>   - Only toggle reset pin if it exist
>
>   drivers/net/can/m_can/tcan4x5x.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 3c30209ca84c..5b26e494a7db 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -363,8 +363,15 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>   
>   	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
>   						       GPIOD_OUT_LOW);
> -	if (IS_ERR(tcan4x5x->reset_gpio))
> +	if (IS_ERR(tcan4x5x->reset_gpio)) {
>   		tcan4x5x->reset_gpio = NULL;
> +	} else {
> +		gpiod_set_value(tcan4x5x->reset_gpio, 1);
> +
> +		/* tpulse_width minimum 30us */
> +		usleep_range(30, 100);
> +		gpiod_set_value(tcan4x5x->reset_gpio, 0);

I would still prefer a function that can be called.

Dan


