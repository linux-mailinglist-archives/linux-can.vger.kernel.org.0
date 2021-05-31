Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEAE3955E3
	for <lists+linux-can@lfdr.de>; Mon, 31 May 2021 09:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEaHUF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 May 2021 03:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhEaHUE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 31 May 2021 03:20:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 391FD61186;
        Mon, 31 May 2021 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622445505;
        bh=NwKJSIDFWeCFMJuw/KCGn/ZQUFJqsq4w0+WD258Sv0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ckzb9zbO6Tc674QzI3Gv5MJM2m5giiqLZJCGwIumpgv+pEfbUjU5DJBl0njVWwIlG
         Kz9Gja4elz+cd1Mg0kkwZAg7I81Jbu3bxE38hkBVAsXfKvRNb0/oWZNXMJYaoIQAjD
         G9yV1ISamcEsm3JNhyBW5v2HvWJ/20JqtzQEAYeuNzbHRkmhKcQXlyQJAKQlcgzQrO
         oNKmQy5QOY5FdQnj6uOK7yv3C5ajHpSfbAHURwuYPtLZKNQYbqIFygtHQSHwBRg+PB
         38Cu2dJLK5jS9+ulPXO6X9ZPDVX3peWgGJKosTJx8wAHRVJYujOuSmcV5A+izxQ6Gq
         xdwPDdcMKQfeg==
Date:   Mon, 31 May 2021 12:48:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] phy: core: Reword the comment specifying the
 units of max_link_rate to be Mbps
Message-ID: <YLSNvUDJZ/v6NTuN@vkoul-mobl.Dlink>
References: <20210510051006.11393-1-a-govindraju@ti.com>
 <20210510051006.11393-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510051006.11393-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 10-05-21, 10:40, Aswath Govindraju wrote:
> In some subsystems (eg. CAN, SPI), the max link rate supported can be less
> than 1 Mbps and if the unit for max_link_rate is Mbps then it can't be
> used. Therefore, leave the decision of units to be used, to the producer
> and consumer.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  include/linux/phy/phy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 0ed434d02196..f3286f4cd306 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -125,7 +125,7 @@ struct phy_ops {
>  /**
>   * struct phy_attrs - represents phy attributes
>   * @bus_width: Data path width implemented by PHY
> - * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
> + * @max_link_rate: Maximum link rate supported by PHY (units to be decided by producer and consumer)

So there are a few users of max_link_rate. It would be better that we
document all previous users of max_link_rate that unit is in Mbps and
then modify it here

-- 
~Vinod
