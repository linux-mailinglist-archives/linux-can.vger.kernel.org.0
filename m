Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523F3117781
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 21:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLIUfN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 15:35:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53116 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIUfN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 15:35:13 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9KZ0uB057589;
        Mon, 9 Dec 2019 14:35:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575923700;
        bh=tADxOUdv3EnZaqqnRBU1/rCDqelIoI6SrSKvJ+AZpJY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dJ24IU3muH6T/jmxQx5S9Q90+jNjj4PcrLUpJ59pWQaVN6SUuzgW+4wgntpUK3hTP
         n7fIJ7ntqnc0aUqfoKEdkrIPTRVF93cbPBKABDsts16UWagV0saa6pt+XyhA69Gc3z
         ssPaiV5sgm5VFGIkBQUJ2P1T6sJHpTRVg0S3elEc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9KZ03H005455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 14:35:00 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 14:34:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 14:34:59 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9KYxbk062483;
        Mon, 9 Dec 2019 14:34:59 -0600
Subject: Re: [PATCH v3] can: m_can: remove double clearing of clock stop
 request bit
To:     Sean Nyekjaer <sean@geanix.com>, <sriram.dash@samsung.com>,
        <pankj.sharma@samsung.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <martin@geanix.com>
References: <20191209201528.999698-1-sean@geanix.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e1a87a65-74f4-9ba3-2845-bd49bcb3fba1@ti.com>
Date:   Mon, 9 Dec 2019 14:32:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209201528.999698-1-sean@geanix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sean

On 12/9/19 2:15 PM, Sean Nyekjaer wrote:
> Removal of duplicate code
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Acked-by: Sriram Dash <sriram.dash@samsung.com>
> ---
> Changes since v2:
>   - Changed commit msg not to confuse :)
>
>   drivers/net/can/m_can/m_can.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 02c5795b7393..4edc6f6e5165 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -380,10 +380,6 @@ void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
>   		cccr &= ~CCCR_CSR;
>   
>   	if (enable) {
> -		/* Clear the Clock stop request if it was set */
> -		if (cccr & CCCR_CSR)
> -			cccr &= ~CCCR_CSR;
> -
>   		/* enable m_can configuration */
>   		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
>   		udelay(5);

I am checking with the HW guys to make sure we are removing the correct 
CSR clearing.  I don't know if we need to clear the CSR when disabling 
the m_can configuration access or if we need to clear it for both 
enabling and disabling when the CSR is set to 1.

Dan


