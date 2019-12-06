Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85A0115459
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfLFPf7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:35:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35290 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfLFPf6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 10:35:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6FZop7120883;
        Fri, 6 Dec 2019 09:35:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575646550;
        bh=0BRORnxlqh1eKCfAJgDo8c7sySmoZLWBsjpWHi0YwVs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d24SdU8SN5NGDJa3Iq6iclJHjirK8lf3sTXPBwluDrpzp4gQxpBUSvJba36pTMdpY
         5r6rnT9VAIOy49XdzFR7UB4EiVjwlfo6AbA/qxwOBdh1bbIK5HkFkVmY2PRVm2+uEz
         5x2N2ABGKxcid6XOWpajG75ysvtLWmOusU+1KoKk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6FZovm080652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 09:35:50 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 09:35:49 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 09:35:49 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6FZm1U098371;
        Fri, 6 Dec 2019 09:35:49 -0600
Subject: Re: [PATCH 1/2] net: m_can: tcan4x5x: add required delay after reset
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <martin@geanix.com>
References: <20191206152923.470980-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6fbb68af-9888-32c6-da04-fd48d6b4e4df@ti.com>
Date:   Fri, 6 Dec 2019 09:33:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206152923.470980-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Thanks for the patch.  My data sheet was old and did not have the timing 
diagrams in them.
I downloaded the latest data sheet.

Dan

