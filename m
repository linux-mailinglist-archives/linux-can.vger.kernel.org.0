Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA282CC7E7
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 21:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgLBUgO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 15:36:14 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:45993 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgLBUgO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Dec 2020 15:36:14 -0500
X-Greylist: delayed 838 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 15:36:12 EST
X-ASG-Debug-ID: 1606940492-0a88182e5848ad30001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.124.12.adsl.dyn.edpnet.net [77.109.124.12]) by relay-b03.edpnet.be with ESMTP id unXb3H9cSyJlNl9T; Wed, 02 Dec 2020 21:21:32 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.124.12.adsl.dyn.edpnet.net[77.109.124.12]
X-Barracuda-Apparent-Source-IP: 77.109.124.12
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 1CC70117A76C;
        Wed,  2 Dec 2020 21:21:32 +0100 (CET)
Date:   Wed, 2 Dec 2020 21:21:27 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: Fix error handling in softing_netdev_open
Message-ID: <20201202202127.GA17683@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] can: Fix error handling in softing_netdev_open
Mail-Followup-To: Zhang Qilong <zhangqilong3@huawei.com>, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org
References: <20201202151632.1343786-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202151632.1343786-1-zhangqilong3@huawei.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.124.12.adsl.dyn.edpnet.net[77.109.124.12]
X-Barracuda-Start-Time: 1606940492
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1080
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9907 1.0000 4.2351
X-Barracuda-Spam-Score: 4.24
X-Barracuda-Spam-Status: No, SCORE=4.24 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.86265
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On Wed, 02 Dec 2020 23:16:32 +0800, Zhang Qilong wrote:
> 
> If softing_netdev_open failed, we should call
> close_candev to avoid reference leak.
> 
> Fixes: 03fd3cf5a179d ("can: add driver for Softing card")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/net/can/softing/softing_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
> index 03a68bb486fd..40070c930202 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -382,8 +382,13 @@ static int softing_netdev_open(struct net_device *ndev)
>  
>  	/* check or determine and set bittime */
>  	ret = open_candev(ndev);
> -	if (!ret)
> -		ret = softing_startstop(ndev, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = softing_startstop(ndev, 1);
> +	if (ret < 0)
> +		close_candev(ndev);
> +
>  	return ret;
>  }
>  
> -- 
> 2.25.4
> 
