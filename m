Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4352F2DAB73
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgLOKwA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 05:52:00 -0500
Received: from first.geanix.com ([116.203.34.67]:47754 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbgLOKvx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 15 Dec 2020 05:51:53 -0500
Received: from [IPv6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.21.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 3E65A485D7D;
        Tue, 15 Dec 2020 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1608029470; bh=SwxVD41sfQyMH6dh/Y4Nn58hWf3hM5BFxK8oH91Bloo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dIAr+I0VnM9DGm13Ff0nhhl55M1H/0wklsJxvN5c1IsbrACrS/iCMsGOeLEdeU5An
         PBZVVWiVpWm5V/SFm6tbFJqbIElWiGI61Vbh9D8ficjQaeZAEfyqV6hD2kYJwNLR/r
         mEGi6NXoUZN1in2M10KITsUDMrIS8H9ACOnQtLIC+SBq4cbPuWF25GFzN2w6PNyuNY
         5hMofK2LWGFH1ffw9n5YJ9UvDsQXBWP9TbCHobyPsu2gt4qI4XvpFklMHoLfepuKtw
         ng3Xwv5VDw9vLjkBD/Rm7QCmUoBqoztU10I5wjUWDGsgLskTUgfb6Xx/359oLYrk6W
         xpQRg5CqNprxQ==
Subject: Re: [net-rfc 1/2] can: m_can: m_can_class_unregister(): remove
 erroneous m_can_clk_stop()
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201215103238.524029-1-mkl@pengutronix.de>
 <20201215103238.524029-2-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <75de2a54-f857-7079-8143-4129cdb0ff76@geanix.com>
Date:   Tue, 15 Dec 2020 11:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215103238.524029-2-mkl@pengutronix.de>
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



On 15/12/2020 11.32, Marc Kleine-Budde wrote:
> In m_can_class_register() the clock is started, but stopped on exit. When
> calling m_can_class_unregister(), the clock is stopped a second time.
>
> This patch removes the erroneous m_can_clk_stop() in  m_can_class_unregister().
Looks good :) I have a little question...
Will ndo_stop() be called if the driver is removed?
>
> Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Sriram Dash <sriram.dash@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/m_can/m_can.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 61a93b192037..075ee760b5ba 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1918,8 +1918,6 @@ EXPORT_SYMBOL_GPL(m_can_class_resume);
>   void m_can_class_unregister(struct m_can_classdev *m_can_dev)
>   {
>   	unregister_candev(m_can_dev->net);
> -
> -	m_can_clk_stop(m_can_dev);
>   }
>   EXPORT_SYMBOL_GPL(m_can_class_unregister);
>   
>
> base-commit: 7f376f1917d7461e05b648983e8d2aea9d0712b2

