Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D607919D9C9
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2020 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbgDCPKX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Apr 2020 11:10:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35202 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403795AbgDCPKW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 11:10:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 033FALsN102255;
        Fri, 3 Apr 2020 10:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585926621;
        bh=LXFYYXTkAw0PXyx0vzgcVLYfckCCL2/exLpOgDuKdCw=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=DK+yUrtGO/K5SXn9ME/3W39jMS3rWTNpsjTSuIzgcAurhUYn2f8VPFhi61IAe0GSv
         jiG68zXu4Cnk0wkssOw/RdDspVnKAHL9CfuyXwwQTk9r0FTsvXGKN/htYHw7RY3pEC
         6e8ogSo70DxL+akZamqd1Q0/jv5OasuV4P5kWpgU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033FALSd116590;
        Fri, 3 Apr 2020 10:10:21 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Apr
 2020 10:10:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Apr 2020 10:10:21 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 033FAKEh039731;
        Fri, 3 Apr 2020 10:10:20 -0500
Subject: Re: [PATCH v2] can: tcan4x5x: tcan4x5x_clear_interrupts: remove
 redundant if statement
To:     Daniels Umanovskis <daniels@umanovskis.se>,
        <linux-can@vger.kernel.org>
References: <20200403150813.10711-1-daniels@umanovskis.se>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bee89027-bde3-ba56-f3ff-5e136fa19439@ti.com>
Date:   Fri, 3 Apr 2020 10:04:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403150813.10711-1-daniels@umanovskis.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Daniel

On 4/3/20 10:08 AM, Daniels Umanovskis wrote:
> The redundant statement seems to be a copy-paste error from other places
> in the file where the same pattern is used
>
> Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index eacd428e07e9..07f1d4a627fa 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -328,12 +328,8 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
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

