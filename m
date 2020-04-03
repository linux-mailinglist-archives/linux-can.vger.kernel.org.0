Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B517319D976
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2020 16:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390850AbgDCOuQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Apr 2020 10:50:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32952 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390751AbgDCOuQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 10:50:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 033EoCwG096148;
        Fri, 3 Apr 2020 09:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585925412;
        bh=wDVxrH5s0meLPLTcOH7s+XqZ//p8wYgCwT1+xpbM69E=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=hLFarzpAVOJeaNt2RAiYgsQGLS64gN6+X2UoT7iH5OQU22cznRxAk6fRscn3iwkv/
         lSruKNAuvMgh5kL94ETxStWTOz0FdcPkYpSyqu9Kj40u1ETy5jZKMSRtKte9yn18XR
         fKecMnUCrEYN9zoLA+cdJGmHvXhQSl4TFLUPEZdM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 033EoCp6066146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Apr 2020 09:50:12 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Apr
 2020 09:50:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Apr 2020 09:50:12 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033EoCku066654;
        Fri, 3 Apr 2020 09:50:12 -0500
Subject: Re: [PATCH] can: tcan4x5x: tcan4x5x_clear_interrupts: remove
 redundant if statement
To:     Daniels Umanovskis <daniels@umanovskis.se>,
        <linux-can@vger.kernel.org>
References: <20200403144602.8494-1-daniels@umanovskis.se>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e92799d6-06cf-6b78-0f1b-e85e4710c763@ti.com>
Date:   Fri, 3 Apr 2020 09:44:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403144602.8494-1-daniels@umanovskis.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Daniel

On 4/3/20 9:46 AM, Daniels Umanovskis wrote:
> The redundant statement seems to be a copy-paste error from other places
> in the file where the same pattern is used
>
> Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index eacd428e07e9..1065b0518c70 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -330,8 +330,6 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
>   
>   	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
>   				      TCAN4X5X_CLEAR_ALL_INT);
> -	if (ret)
> -		return ret;
>   

How about just returning the value of tcan4x5x_write.. and remove the 
return ret; below

Dan


>   	return ret;
>   }
