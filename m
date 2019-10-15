Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED45D7ADD
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2019 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfJOQK3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Oct 2019 12:10:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36557 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfJOQK3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Oct 2019 12:10:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id h2so18577249edn.3
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2019 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wsH/H4/IvZbw1PBfApeIo2ldu5dbGC9/0sEtLu5BHw=;
        b=0Cs2fQ+11eH0QVgZsZWadHdiWihinDAvgb4Ioa7gYg4yiKnVsD04fCFg5y4sFuUKN7
         102tkBCNYur4z4uin78NLBgAn6ngTyCMIDplIkzTuA07sL+HHbwHG9+TN5zEoU84YMmP
         wqlTflVW7GYFjZBoch+//tLKDt6mdgJ3UHe/P7JCkaa21fZ3SIZngSBo8J6qU3AUDdLP
         SFXpoSqI1ldXa0sCrS9IDsB0ZUfWVWMIrB7iz6Fi9jQ05Pc/EMaYErfEeMKnO5Uw1knM
         aqmOfiwXL+5RtQn76aKnrUNVyh7xChRvYRzL8VVfSHP7sHtZC4zPwkSBtSoqh3syzD/1
         9bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wsH/H4/IvZbw1PBfApeIo2ldu5dbGC9/0sEtLu5BHw=;
        b=V8kSBQb7YwOnusWkp9NDe25KL5mVjQaYIBYdrx+0Cc2UvhXAmwZ+4V6CyelAd4wTUd
         qs6KTDlZZS1uxbamfciWKPhIXCSpTQTJKAHge8UphrSoCXYR8dZV2Zx6EDY5exGGSsat
         Duemhn1vK2DKlYN9oTLWuReb4qnqgjVJ42XOZf0F7uPPINu4VGiqwvcz/tcAFY3MrL8n
         KuB29J4yYg2R0Nr9aE+to049UQyFGTuE1xagw/K98+lFC/tM58j2MRaANAR/5UvtTAFD
         8qu7fqIcuF7jG25WflmU1QnM9bv5lfbyGNCzcHjtHwVgG6CSBgU0Udtyg/nXKWxPwCZm
         qudw==
X-Gm-Message-State: APjAAAUNLiYlzrknxxdelHg5pwIgiRi+CTmql+HkzzF9b5ntDXgd65ez
        TNIYKnAuvZrAMm5nW0DOTvkG3Q==
X-Google-Smtp-Source: APXvYqxRdcnRI22r9M7UXPsBCBGbEnHT8bpl3u0lG8avm96l2X0z/fb7buBkQh5xPEYJUZLYEf060g==
X-Received: by 2002:a17:906:1cd8:: with SMTP id i24mr34165866ejh.149.1571155827144;
        Tue, 15 Oct 2019 09:10:27 -0700 (PDT)
Received: from netronome.com (penelope-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:c685:8ff:fe7c:9971])
        by smtp.gmail.com with ESMTPSA id dt4sm2793092ejb.45.2019.10.15.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:10:26 -0700 (PDT)
Date:   Tue, 15 Oct 2019 18:10:23 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] can: ifi: use devm_platform_ioremap_resource()
 to simplify code
Message-ID: <20191015161022.mtgohberdmhkbo46@netronome.com>
References: <20191015142046.24844-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015142046.24844-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Oct 15, 2019 at 10:20:46PM +0800, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  drivers/net/can/ifi_canfd/ifi_canfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index fedd927..04d59be 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -942,13 +942,11 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct net_device *ndev;
>  	struct ifi_canfd_priv *priv;
> -	struct resource *res;
>  	void __iomem *addr;
>  	int irq, ret;
>  	u32 id, rev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	addr = devm_ioremap_resource(dev, res);
> +	addr = devm_platform_ioremap_resource(pdev, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (IS_ERR(addr) || irq < 0)
>  		return -EINVAL;
> -- 
> 2.7.4
> 
> 
