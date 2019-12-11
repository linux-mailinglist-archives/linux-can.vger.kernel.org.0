Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A2811AD15
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfLKOLf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 09:11:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59896 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfLKOLf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2019 09:11:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBEBSqG053490;
        Wed, 11 Dec 2019 08:11:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576073488;
        bh=Hssx5/yusZZjjEKCKh6FBqTrdJ91tMLHkl3SRs/KIFE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kogMsghWFpkNFEqWybW0hmM/M7GL46a+vtKXTjzasE/wc0xWbj2CJFmWm/LbS4aS2
         MlT4loB/Yk71pPGmr518QaADKYCzRLZnnFyu9oHd91zJkuwZN4rKBJvoMNj8Rj8N+U
         8ZXLjvhs1URSUv0bT85s5wi8xjxdtH66YZwD7uOo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBEBSko038252
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 08:11:28 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 08:11:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 08:11:28 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBEBRXs038065;
        Wed, 11 Dec 2019 08:11:27 -0600
Subject: Re: [PATCH] can: tcan4x5x: remove redundant return statement
To:     Sean Nyekjaer <sean@geanix.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>, <esben@geanix.com>
References: <20191211140355.321479-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ff7adb5c-cccc-2580-d52e-e033eaceb1fd@ti.com>
Date:   Wed, 11 Dec 2019 08:09:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211140355.321479-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/11/19 8:03 AM, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 8ed2813f227e..9a33fcaaf067 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -329,8 +329,6 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
>   
>   	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
>   				      TCAN4X5X_CLEAR_ALL_INT);
> -	if (ret)
> -		return ret;
>   
>   	return ret;
>   }
How about return tcan4x5x_write_tcan_reg(...)?
