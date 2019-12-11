Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7454411ABEE
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKNUX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:20:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53222 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfLKNUW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 08:20:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBDKDur036313;
        Wed, 11 Dec 2019 07:20:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576070413;
        bh=qPmKj8MQTMQUVkzzNDm6/2JIWA1S0qzCM1EuImRqxzE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oBO8HZF1ra36eL3QE0/KGVPW9gDxwD5HsyEhAK4SVS25K3/uQ6jlNtJLsL5y9tmOh
         Gor7uAGb+WUDe3MEv1eeWC+EWx4/BPhlNR4X7PJ4Ewc56bVL99KzefO+8SvqVYFowc
         oWhGCQQ8BtKKJyKUAXGwVeoyeY2UkqCIl4x/ZPbw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBDKCVe025977;
        Wed, 11 Dec 2019 07:20:13 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 07:20:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 07:20:11 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBDKBM1041668;
        Wed, 11 Dec 2019 07:20:11 -0600
Subject: Re: [PATCH v4 1/2] can: tcan4x5x: reset device before register access
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191211131223.292455-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <80e94af5-1a49-887e-c31e-e0c3629f105a@ti.com>
Date:   Wed, 11 Dec 2019 07:17:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211131223.292455-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/11/19 7:12 AM, Sean Nyekjaer wrote:
> It's a good idea to reset a ip-block/spi device before using it, this
> patch will reset the device.
>
> Added a generic reset function if needed elsewhere.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes v3:
>   - added reset if the reset_gpio is not avaliable
>
>   drivers/net/can/m_can/tcan4x5x.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index b6b2feca9e8f..960a16aca7ca 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -166,6 +166,21 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
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
> +	} else {
> +		regmap_write(priv->regmap, TCAN4X5X_CONFIG, TCAN4X5X_SW_RESET);

error handling especially for the I/O

Dan


