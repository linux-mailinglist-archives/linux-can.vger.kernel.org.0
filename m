Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442D72D93DB
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 09:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439111AbgLNIN3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 03:13:29 -0500
Received: from first.geanix.com ([116.203.34.67]:57796 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439105AbgLNINY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 14 Dec 2020 03:13:24 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 32D9A485B37;
        Mon, 14 Dec 2020 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1607933562; bh=JW9hy5Fn7GGE9UcXjRFQFN01TdgXdSlY3BIKU6rhA5c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h5jCCNHAUX8Dt87cCmblgZMwvyMCCPdcswsW+aBwB/hT7eV2EGAxgezVG0R1nY07c
         OhpGcy1XE+NfgFn6YxtQgyP3ZJDYlU3YGQgfyNDdudZim7zCVdQ4uGSO18lysxAUDc
         /9B1PcBRAU0GikyJwbWT5msYumR9ucL0Zx04qHPaB7rwGTNY/pJoftgv8rp3tY60o9
         JI55r+5BQ8iDQoVAz2yV6rbSy2MADT7go5Pi0p/F+4Sk2z50Sj2AV6yaN4/zRSLRaA
         JWm3VaQQPbJ46uJEKfDZ19DoYqOXkD9y7t0rewPdjG2bQo/b+9rcq2t8J5d0BvDeuV
         mWmlUS/8YnkRw==
Subject: Re: [can-next-rfc 5/7] can: m_can: m_can_clk_start(): make use of
 pm_runtime_resume_and_get()
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-6-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <fd356d71-1856-c44b-7400-20d35327aa73@geanix.com>
Date:   Mon, 14 Dec 2020 09:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-6-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12/12/2020 18.55, Marc Kleine-Budde wrote:
> With patch
>
> | dd8088d5a896 PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter
>
> the usual pm_runtime_get_sync() and pm_runtime_put_noidle() in-case-of-error
> dance is no longer needed. Convert the m_can driver to use this function.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/m_can.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index b1ed925ead63..d556cd95bd8e 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -612,18 +612,10 @@ static int __m_can_get_berr_counter(const struct net_device *dev,
>   
>   static int m_can_clk_start(struct m_can_classdev *cdev)
>   {
> -	int err;
> -
>   	if (cdev->pm_clock_support == 0)
>   		return 0;
>   
> -	err = pm_runtime_get_sync(cdev->dev);
> -	if (err < 0) {
> -		pm_runtime_put_noidle(cdev->dev);
> -		return err;
> -	}
> -
> -	return 0;
> +	return pm_runtime_resume_and_get(cdev->dev);
>   }
>   
>   static void m_can_clk_stop(struct m_can_classdev *cdev)

