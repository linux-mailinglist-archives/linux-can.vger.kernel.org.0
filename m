Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED8711545D
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLFPgU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:36:20 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35378 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfLFPgU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 10:36:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6FaD98121014;
        Fri, 6 Dec 2019 09:36:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575646573;
        bh=VePEFKlHkZH9KtnuuNzwszlEMroE15Jc+QRZpLu457o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KPI0CQWpC5215tGrpS+3sGKp+oYuX8kF6H3fE+yU4TfNYNZLDdaEoQi4BWYgvZI/L
         l8JqINsco55WwYB221Z/I5AnU+ktcoV3/AHeUblqj43+3YiXVbtLfZbTK4hK7R6fYQ
         qf6mVs8KOOCmBnZ1C/iJQOuNJzW7QHnem0xetoeA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6FaDdl081273
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 09:36:13 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 09:36:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 09:36:12 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6FaB84096293;
        Fri, 6 Dec 2019 09:36:12 -0600
Subject: Re: [PATCH 1/2] net: m_can: tcan4x5x: add required delay after reset
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <martin@geanix.com>
References: <20191206152923.470980-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <eeb87274-d571-767d-a470-bae16fd7e35c@ti.com>
Date:   Fri, 6 Dec 2019 09:34:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206152923.470980-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/6/19 9:29 AM, Sean Nyekjaer wrote:
> According to section "8.3.8 RST Pin" in the datasheet we are required to
> wait >700us after the device is reset.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 6e37c3fd87af..cb5fdb695ec9 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -367,6 +367,8 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>   	if (IS_ERR(tcan4x5x->reset_gpio))
>   		tcan4x5x->reset_gpio = NULL;
>   
> +	usleep_range(700, 1000);
> +
>   	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
>   							      "device-state",
>   							      GPIOD_IN);
Acked-by: Dan Murphy <dmurphy@ti.com>
