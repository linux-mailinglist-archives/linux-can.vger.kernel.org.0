Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB11111AC84
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfLKNyz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:54:55 -0500
Received: from first.geanix.com ([116.203.34.67]:59782 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKNyz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:54:55 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id B94F7490;
        Wed, 11 Dec 2019 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576072464; bh=BtfhZHZdksey9nFzQTtrfbUTUfi4a3kK8TIN15Z4ekg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SWaeIvTNGiZRH4N3BxeJeIa9eORYhkKh1ym/pPPz4QUnynjdLZ58Sm+RjeQPPIap6
         9LclH9V5DoIu5mqB/LDFiccgVaAnuXMv8pSG/S+klTK2kdxO4XzIQH4K6dTtWvLDjD
         AXC9IkMREPEbfnzhWg15PF2P/9/IwDYgRyFXXQYIDKJS/SzwMjtU8B1QWAH1tdz57E
         wDou5hyBseWVQ84yGhP+wtxzjMkgYT/TeU/53WVWso7t9MP/UQXA2LmP8yoCOMDFc9
         YLkvP5gyzTbDtpfmRCOAGJ7M+1XR2IMwoMdht5jFs4JQAYqh6spUpPizdUSVYXjWZR
         Iq8gMDEoJtKtw==
Subject: Re: [PATCH v6 2/2] can: m_can: remove double clearing of clock stop
 request bit
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sriram Dash <sriram.dash@samsung.com>
References: <20191211135340.320004-1-sean@geanix.com>
 <20191211135340.320004-2-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <a9539eac-a285-e09a-db1f-08395e552d9d@geanix.com>
Date:   Wed, 11 Dec 2019 14:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211135340.320004-2-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Skip this one :)

On 11/12/2019 14.53, Sean Nyekjaer wrote:
> The CSR bit is already cleared when arriving here so remove this section of
> duplicate code.
> The registers set in m_can_config_endisable() is set to same exact
> values as before this patch.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Acked-by: Sriram Dash <sriram.dash@samsung.com>
> Acked-by: Dan Murphy <dmurphy@ti.com>
> ---
> Changes since v3:
>   - Fixed fixes tag
> 
> Changes since v4:
>   - None
> 
> Changes since v5:
>   - None
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
> 
